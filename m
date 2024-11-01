Return-Path: <linux-kernel+bounces-392600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F529B960D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF90C1F22710
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0241CBEBB;
	Fri,  1 Nov 2024 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BI9jEnho"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45B1CA81;
	Fri,  1 Nov 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480287; cv=none; b=oOndOLYtEktUG/zvB7RZGcKz1aEFj4akSAbvG0QgNW4z9g128W+fMfKB/8g/eBycB58n06Lcxb4oDFUfgPd7e+Lf8rnlIlqM8oaStIAlvnvU23U08zGO4dI1kNxJER+dMyt3pAwFYTLnOvCa+W91nAtILB/M2CvR11QRCbyD1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480287; c=relaxed/simple;
	bh=CfopfRF6+wuYULvRjMimxddxy11nsiHKE0xvJuzLbNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0LvTtPvSNAGKTpwh07rdIHka7mr5oWWAIkiUvkYIfQPkTdzmpmNiOwrSjNYK9FefIO4aDsaf36zw3SBBXh/1TgIN4+V1S0if8pcVm4BoEloU6HVodREHfGrAuI1DVaHrOW5SGzWG8IjPX5Tex/KDJgdV3glDaByW72X1oHBAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BI9jEnho; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8BSVR7eAERprKgDeJ6doXC6uVFc0KlLSJulHHmYrLgw=; b=BI9jEnhon5ednLcCmYInr+vw6p
	mIMSqT39GTQyH04EYJP41wvD8Djx7wWK39wltY/y6DRYGVP9S2R+TcJZGtmSsYCf+q6g1ZeMSEtB5
	kdbOUT86ij9a9EBhfo+8pAvicmbS1LUUdJFoWGxB0c+CU3+mkFxB2I4c7nZWpW08NEbe6kL41Y9nH
	dhbtEGveDTYllp9w0+roP8S67cDXZ+P/kW7PyvlF+eTVhcoMlrdDospIAYIMSaS5OWEohPedrAVV6
	ADkLuALzBPrdSM/jj62rXeUWKDo8DeR1OQjQ9tfwdZR+WvCfRO4g68wOkXKXLJitwbcIne4miQwOE
	8EOqjoJQ==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6uy6-000VPu-FY; Fri, 01 Nov 2024 17:57:51 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v5 1/5] mm: fix docs for the kernel parameter ``thp_anon=``
Date: Fri,  1 Nov 2024 13:54:05 -0300
Message-ID: <20241101165719.1074234-3-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241101165719.1074234-2-mcanal@igalia.com>
References: <20241101165719.1074234-2-mcanal@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If we add ``thp_anon=32,64K:always`` to the kernel command line, we
will see the following error:

[    0.000000] huge_memory: thp_anon=32,64K:always: error parsing string, ignoring setting

This happens because the correct format isn't ``thp_anon=<size>,<size>[KMG]:<state>```,
as [KMG] must follow each number to especify its unit. So, the correct
format is ``thp_anon=<size>[KMG],<size>[KMG]:<state>```.

Therefore, adjust the documentation to reflect the correct format of the
parameter ``thp_anon=``.

Fixes: dd4d30d1cdbe ("mm: override mTHP "enabled" defaults at kernel cmdline")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Acked-by: Barry Song <baohua@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/admin-guide/mm/transhuge.rst      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..1666576acc0e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6688,7 +6688,7 @@
 			0: no polling (default)
 
 	thp_anon=	[KNL]
-			Format: <size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>
+			Format: <size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size>[KMG]:<state>
 			state is one of "always", "madvise", "never" or "inherit".
 			Control the default behavior of the system with respect
 			to anonymous transparent hugepages.
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 5caa3fb2feb1..abdf10a1c7db 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -303,7 +303,7 @@ control by passing the parameter ``transparent_hugepage=always`` or
 kernel command line.
 
 Alternatively, each supported anonymous THP size can be controlled by
-passing ``thp_anon=<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>``,
+passing ``thp_anon=<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size>[KMG]:<state>``,
 where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE and
 supported anonymous THP)  and ``<state>`` is one of ``always``, ``madvise``,
 ``never`` or ``inherit``.
-- 
2.46.2


