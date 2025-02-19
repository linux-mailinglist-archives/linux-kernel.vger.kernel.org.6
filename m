Return-Path: <linux-kernel+bounces-522255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C14A3C7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826E41898110
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268FF21505C;
	Wed, 19 Feb 2025 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cHBolhbF"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA8214A6E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990854; cv=none; b=FvKGGWxe4ZX2lZva3jSsMzIkSTzhyV/OWu0oqo2SLk/+eBZB2EgphiCnSQ0oFFnIuOlXVBbiy1SEFYB2Jb7enzaZQPprvm+8jaE6hdvBIgt/KYBmrtbdZha0nhY9yn9vuNzgmsL7WCMdzNa4SUl5GphKQio2JOJsuxTTREf3SMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990854; c=relaxed/simple;
	bh=EThqj7W/9h4N49llwUrtRtTEsyucQPjCnv9l04YpcWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOwLoM6keR2dYS/wL0mreF2pSjg3Z3QdKdxrs5Ylg7dlX5JM92VEM0U2zgch69PZkcAfYQ1jyNMsk1a4jcBZTWTTB1VXSIzAvg041Lgy9/WRn7TtHp9rZ4hUe0SdSyVq+NKiXW9FOkPEFg7s4ixH9s6xVextK6B1tuKZB6L1uCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cHBolhbF; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2pSe7Qe4/i9BOa9RVZfFghHp+mZzc1kq2e9gbulZZME=; b=cHBolhbFoTP+UyloEjGW41mC4P
	McBtXgBNa6gF8b6RnBXynfN4SdraHT7cBct9WXHWO63VNztgnREpXS04GyyAv/QtCCVThei0sCYpt
	YXCrU5jiRo3jZ9wGxtRtDxMHD8lAU26J5gSe3UoZ62Fyt4AeyNyT2qiQxki5xCk73wv8LwIwnXMer
	Ph2B/xTV7L8a1bieTkcIZs1i0PGMmMIABaVHoF+Qrk5zT9SQpx1++WurJhxWrkOKs/+I8g1kbBVOz
	KpRsv9p4boaVHcfy91iYC7ksGjQWQW+L8uWyeoJgxpSUHiO+j+1bd9QV1AOif3bzYVrwZMklBxM1a
	Enj4yNaA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14] helo=maloca.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkp6O-00EwF0-6g; Wed, 19 Feb 2025 19:47:26 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/2] MAINTAINERS: Change my role from Maintainer to Reviewer
Date: Wed, 19 Feb 2025 11:46:19 -0700
Message-ID: <20250219184702.242924-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219184702.242924-1-siqueira@igalia.com>
References: <20250219184702.242924-1-siqueira@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8b35ca294a0..a94abf72e117 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1024,7 +1024,7 @@ F:	drivers/crypto/ccp/hsti.*
 AMD DISPLAY CORE
 M:	Harry Wentland <harry.wentland@amd.com>
 M:	Leo Li <sunpeng.li@amd.com>
-M:	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
+R:	Rodrigo Siqueira <siqueira@igalia.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/agd5f/linux.git
-- 
2.48.1


