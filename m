Return-Path: <linux-kernel+bounces-388728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2C9B63A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7931F22465
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B001E9097;
	Wed, 30 Oct 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eUcKZTex"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8F1E767D;
	Wed, 30 Oct 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293440; cv=none; b=Qvv32xu3Hh+QkktUE3hdpLddCzBU/CGT+OwXA1MnQxPC1OM4aMXJCE6UM/RPXS+NVl2hxdvIn+SvvwfO4Mc0zan+Ec4TsRgBT10wl1eGNwr/82QPjCkyXF0QHnEGgZ4zpYdGUEN5EceZfCKIUoBA0sfUCBkSMKPAxgQA7jq3oNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293440; c=relaxed/simple;
	bh=PXExopGqHf/XUbPawY0gjrjO+odnFm47+qge4z72Bx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8Bhux9sDzKJNH1XHO3BleKrsBuIUsBGeHcaxPrI5QI71YxwzqbryCU6qie+SP7zXebg0cwY4NV+9xCKLqYuLvn4B5o6nHYkw2FkeDyKIYwvfJevr9hKa6XJbV7nywluwmIPyGnWJhyKpz5YkkJgvqcyWOyMZpFQCyaTX24z3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eUcKZTex; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=x/+J4VNwyIjYndlAztlVz2EFWQN/WXmhUknqKDEMai0=; b=eUcKZTexxC8M2Wcn30sWoZqyrh
	LRP8JP0FKQ7H6mI4jJPzJasXn5FjP4SI+86Rk4Y2y+LLjP5yX8tNfAF7HOupm4XdtVK6GYJJltnXv
	Bii1xx1Lszwsm1Sk9XipuwCR7WesaGLsQWxv1K8M4nDfto6PNgH91hdlxpZw/U8TmeR3WkUCaxwxP
	9e05jUf7ku16Xrdqq5krv0SN2z2/ktQAPwydgXKS2DaY/XYz88gcC1yI6Ifwo7iXUkvjmfcUr9YgO
	HGBP1vZXhg4m0Gh89vceRFzZgwj23LY6lgdxkFEmqno/aBR4spbKMiHFHtUzsjB9SyvtY9BTvrmjz
	d4nXaHRQ==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t68MI-00H5h8-GV; Wed, 30 Oct 2024 14:03:35 +0100
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v3 1/4] mm: fix docs for the kernel parameter ``thp_anon=``
Date: Wed, 30 Oct 2024 09:58:55 -0300
Message-ID: <20241030130308.1066299-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241030130308.1066299-1-mcanal@igalia.com>
References: <20241030130308.1066299-1-mcanal@igalia.com>
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
index 203ba7aaf5fc..745055c3dc09 100644
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


