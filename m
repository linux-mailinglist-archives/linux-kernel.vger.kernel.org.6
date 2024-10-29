Return-Path: <linux-kernel+bounces-386098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC99B3F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CE71C224D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FADAD53F;
	Tue, 29 Oct 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XhqzgsmJ"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B3567D;
	Tue, 29 Oct 2024 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161454; cv=none; b=sDERpNyMQRiVUFPZmY50iyAgO11NjMCLYDEnk1TSr3x69wrx2vWhAKrZ75rmey1d2VlhltKItxmko2/14VEuC4qCrQR8IqyUwMJnCUyI7wGYt0gV8s4+d/Bp8JQtDr8FE578dAylJg+Ffw2zGDHOYUq1N/AIykbiX08LujEmk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161454; c=relaxed/simple;
	bh=PXExopGqHf/XUbPawY0gjrjO+odnFm47+qge4z72Bx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgvYq6gmQLIDAJiVtkzmwBuESDsWXVgh6bQmdI21kUka8/175xw9ytGupYm3pmYsTVb4m8q6sOav71HJP46t9k14oM+7sUswDXAiWRx0L0VEh1dZhdwqSLreBOxzVpJZC+wvm6d+iWH7WWJyCOSVpVFa5A2D1hS1SiDzGC4ok7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XhqzgsmJ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=x/+J4VNwyIjYndlAztlVz2EFWQN/WXmhUknqKDEMai0=; b=XhqzgsmJFPEicL7uXc8og75hT6
	GoLHVGkfeLhnFeZnqsIp/LmFd5p+DMTqpcTnTZfsMNWPvpMO8cOMAdP9dEL+4qLDcz1l22Axah76m
	5i8pvPIen5duuIFzXBoxOYd7BriPN3mw1yLxwqosyH5YEDOg2v6xdKMhLPbcYuoXQTjLTcQWzujZB
	XazKzT53tLeY4W0J9nnM8LxKURXn5gPxzexKe8HoK0Hdjjkmggv3IrEB7I5A1EbZhEYVL48Tqn11g
	qvO5YgR8dEtRmTQQpliXY0rpILzWz9KAMN1MJpWzmlWTTPVsq3Aoy6WRl1ZLPYDQa5A48redJ6zTc
	HrqroFaw==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t5a1U-00GIrd-TT; Tue, 29 Oct 2024 01:23:49 +0100
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
Subject: [PATCH v2 1/4] mm: fix docs for the kernel parameter ``thp_anon=``
Date: Mon, 28 Oct 2024 21:13:05 -0300
Message-ID: <20241029002324.1062723-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241029002324.1062723-1-mcanal@igalia.com>
References: <20241029002324.1062723-1-mcanal@igalia.com>
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


