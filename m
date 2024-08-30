Return-Path: <linux-kernel+bounces-308914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A972F9663A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529791F23018
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD91B2526;
	Fri, 30 Aug 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oV0O0fTB"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C631B2509;
	Fri, 30 Aug 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026672; cv=none; b=MbPeAyQxuvkroFHoIn5yDErtuyPu0iwXaHpZytnjSa+qbPlYkffxjW+/3MOn2zJOW4eH9qJumFLfWKmPcDU2EY/M03RMCK0TD5PwM68IGvvOhU+eyAO78pthlto4ilspos1Y4hdEGWnlTQZXn6irIOhAXbYO7e765s5bx8hHbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026672; c=relaxed/simple;
	bh=ordtzeKGfZ9tzbNzAMjuXb1IZc/l+GZwq+W62hzwnn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJVmP0+phHmPcxAJpS6R/1QBJfPG/Z57XeM0RC/jHnRRfK4gpm8g/sHiahIdvZfxGtCfGFLypS7+GIKbnennwzVxGgLV3KA8ROoyW+kTcKmAKPTO6X8iHosqWTjhxDPSXmsMP7wUTXP903sYCNtXt03cbWPF7xP9dS5kT+DISWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oV0O0fTB; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=g7u3JY1dUMc3W4JVQxtJZrZEzcHPVuAghUUeOne4iAY=; b=oV0O0fTBZZfPvlMEar3HxRPa0R
	60yLSGtHnZeL//MGhGu2vHwUSUo5HxT8qquoOyBGnBJNR7LJE1NUbQ05R0hqFX+0Fi/e1l1wa/ctr
	G8fnCLEOVdVU2mg3Dnc3k7sAP1m2w0+tnKWn+lFobslVpqkPbK2uPvDm3wmQgxMBnbntetzGHLqiD
	+oiuRhbx7V/x2BisNbLierYpDp154lb/OHLrlQgI46cSo8M9hj/zPAiXTCmZz4bZVOhI8CeNi7b3l
	XcKv2NoG3gg0a2k/b1ezD4vA3ZLg6YmD7aRuiBwc4eZ5ixf21Q4aNuCakkxZDC6BvpILj+qISMj/v
	gK6Dsy4Q==;
Received: from [177.76.152.96] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sk2Ea-007AjX-Ae; Fri, 30 Aug 2024 16:04:16 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org
Cc: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	stephen.s.brennan@oracle.com,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH] Documentation: Improve crash_kexec_post_notifiers description
Date: Fri, 30 Aug 2024 11:03:22 -0300
Message-ID: <20240830140401.458542-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Be more clear about the downsides, the upsides (yes, there are some!)
and about code that unconditionally sets that.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc52ddc6864..cb25dc5cbe9a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -913,12 +913,16 @@
 			the parameter has no effect.
 
 	crash_kexec_post_notifiers
-			Run kdump after running panic-notifiers and dumping
-			kmsg. This only for the users who doubt kdump always
-			succeeds in any situation.
-			Note that this also increases risks of kdump failure,
-			because some panic notifiers can make the crashed
-			kernel more unstable.
+			Only jump to kdump kernel after running the panic
+			notifiers and dumping kmsg. This option increases the
+			risks of a kdump failure, since some panic notifiers
+			can make the crashed kernel more unstable. As a bright
+			side, it might allow to collect more data on dmesg like
+			stack traces from other CPUs or extra data dumped by
+			panic_print. This is usually only for users who doubt
+			kdump will succeed every time. Notice that some code
+			enables this option unconditionally, like Hyper-V,
+			PowerPC (fadump) and AMD SEV.
 
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
-- 
2.46.0


