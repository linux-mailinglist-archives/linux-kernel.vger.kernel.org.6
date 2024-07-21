Return-Path: <linux-kernel+bounces-258183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39B39384CB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DF31C204AB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFD61684A1;
	Sun, 21 Jul 2024 13:37:20 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A071649BF
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569039; cv=none; b=FMEd/o3nqLoSfw1TkOixFfSX5385wPZahQvT/yskd4+g8GEHsIvQ1ImnzZBxD1taORJhiVRvhYpChWMLKpRCYJcHLlGry+TkijYDhL894L274wg9eErgNXe89s+Mp+QqGsD4emSJL4/jZKaOK5BKbI78PNLEHNMfTQuvsstqdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569039; c=relaxed/simple;
	bh=5uWd4JnlNjHMxFHmrTYl3gRP/nyyCC6uH1TbWEXfKMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hk3sF5qXcMT8R8bSsXvmmV7pB4AsCtHe5k09PdhNBrlM+e1O6YWv7//0CAgb/VRrioD1u7FclSyUpEv8htWHWq5B+KFBuldyjMyoyzH4sTneircj2M3DlsDhl1DaCWhK5MMwF0yJo9/kImx89DjlOyKxeWWvufANp6xkVsgEC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id 5227B42E60;
	Sun, 21 Jul 2024 16:37:15 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkR-00000001SmU-3sDS;
	Sun, 21 Jul 2024 16:37:15 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/16] xz: Use 128 MiB dictionary and force single-threaded mode
Date: Sun, 21 Jul 2024 16:36:28 +0300
Message-ID: <20240721133633.47721-14-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721133633.47721-1-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This only affects kernel image compression, not any other xz usage.

Desktop kernels on x86-64 are already around 60 MiB. Using a dictionary
larger than 32 MiB should have no downsides nowadays as anyone building
the kernel should have plenty of RAM. 128 MiB dictionary needs 1346 MiB
of RAM with xz versions 5.0.x - 5.6.x in single-threaded mode. On archs
that use xz_wrap.sh, kernel decompression is done in single-call mode so
a larger dictionary doesn't affect boot-time memory requirements.

xz >= 5.6.0 uses multithreaded mode by default which compresses slightly
worse than single-threaded mode. Kernel compression rarely used more
than one thread anyway because with 32 MiB dictionary size the default
block size was 96 MiB in multithreaded mode. So only a single thread
was used anyway unless the kernel was over 96 MiB.

Comparison to CONFIG_KERNEL_LZMA: It uses "lzma -9" which mapped to
32 MiB dictionary in LZMA Utils 4.32.7 (the final release in 2008).
Nowadays the lzma tool on most systems is from XZ Utils where -9 maps
to 64 MiB dictionary. So using a 32 MiB dictionary with CONFIG_KERNEL_XZ
may have compressed big kernels slightly worse than the old LZMA option.

Comparison to CONFIG_KERNEL_ZSTD: zstd uses 128 MiB dictionary.

Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 scripts/xz_wrap.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/xz_wrap.sh b/scripts/xz_wrap.sh
index bb760b721b2c..c8c36441ab70 100755
--- a/scripts/xz_wrap.sh
+++ b/scripts/xz_wrap.sh
@@ -16,4 +16,15 @@ case $SRCARCH in
 	sparc)          BCJ=--sparc ;;
 esac
 
-exec $XZ --check=crc32 $BCJ --lzma2=$LZMA2OPTS,dict=32MiB
+# Use single-threaded mode because it compresses a little better
+# (and uses less RAM) than multithreaded mode.
+#
+# For the best compression, the dictionary size shouldn't be
+# smaller than the uncompressed kernel. 128 MiB dictionary
+# needs less than 1400 MiB of RAM in single-threaded mode.
+#
+# On the archs that use this script to compress the kernel,
+# decompression in the preboot code is done in single-call mode.
+# Thus the dictionary size doesn't affect the memory requirements
+# of the preboot decompressor at all.
+exec $XZ --check=crc32 --threads=1 $BCJ --lzma2=$LZMA2OPTS,dict=128MiB
-- 
2.45.2


