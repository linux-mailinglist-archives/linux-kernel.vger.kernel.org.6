Return-Path: <linux-kernel+bounces-515597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241CEA3668F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFE5169A01
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE371C84DE;
	Fri, 14 Feb 2025 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEWdw2kz"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6C1946DA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562934; cv=none; b=uW60V1146jGAGya+I77hL9cSr0ek9e63zwHmutveqfshFKuHrPizu0Amaq+hgDHcWtd++I/An1BciQ3Z+8SxUoP2pWyromPgK2nf1/6w/zkiB7JW6cXlTurhvHJrNkbWlHklPGMiXqrfSuDXAXZ0l5HKU2H2uWBYlfSSa1i6prM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562934; c=relaxed/simple;
	bh=GlLftjDRagTS13s5Ysn5RJqGQA/ImDdXkaSwQnm1HmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcjLm6N7ZffniqqYhs2cm2PKbCNL4JfeUeAl3scph3Fzf2DUjQUgtrNRoSu/l6KIVli1GMnAwFjFZCXWE4s+erGq11b/Dcppevdy8UVukO2IHNdQlXP5rEty0JI4A0lg1/WFAzLrXKNtpyMSZ8yjY09/BkIX168pYV3yrslhuC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEWdw2kz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so538258a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739562930; x=1740167730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1ls72V8E9puB3eNgIJ94RbIr4YeTpcns67AF/rE8Ko=;
        b=VEWdw2kzux86nJ/qoTMDgNOy3aDSFmW9YAHZQxWIWerZhxZUFuqgAT21uwcaz8t+Gi
         OQYN/RxNn0iET6DZ8E9BwkSSsB6pwhWzLNBK6AXTAvoz9dkOftKDh7XCcDwMd6Xl/Dht
         8FOBjEkdPvqUiITNVPpa8f6MeTlyGrz3hVSSWVHgfbrx+Pndj83XxIXs4FoVB3A6cjgz
         WXXqgpX2u4TK8ssfLuTHBX4v/5Trzl5PX8lKbpPLzQAj+hkIRLgHneWhRRUkRd8sBKI/
         45jrE/BllRTTQPHHP612SnhGEN8F2OQb0f2Lqz1y4xPl71TXpxJ82TMD7JRHHX1bFFEm
         0PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562930; x=1740167730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1ls72V8E9puB3eNgIJ94RbIr4YeTpcns67AF/rE8Ko=;
        b=ngHvsxhrsi8t6c3i8pcTrOiWT3pNOq4/lrIUYMr0MpMViVGOyD6hxLC5PUOga2pxoU
         JAUcOSGLQCoOZ+Qjvfqv6r2teNe2VV8ETy+qlXZCY6wC2dO7oazOCFX/ps6WACyetvsk
         1km2PCJMlngrCQ3Tw0llMDtgc+Qxl1jmQB2C1eZn50JEUtU3Ff6WXfElt6og3JE7goar
         Y6B1WBZaGWeF7hGSvK9TJ32P7hkoxUnKpdUj8nmUvV6MgUWvBatw8VhWqVIZQseiqEUV
         BpTdDhiZdlmMGlB88eaPVm7qrl7kPRjr2haeMY+5fXfuqOkdpVcCbXZwYk6yoTsRZRh2
         uvTA==
X-Forwarded-Encrypted: i=1; AJvYcCXfI4eS2vNhCufkDYGAtweudm9iRHFFTMfsOzAj0Uwm5oaz91AnkhyKWx4lQW9P+BU9v94C1y9H2WR+cDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPHFkPoYoizSce5sASV3S1sY8Kbew7xGm1txUoku2ATRKnYFP
	7lc6TNP6jbTPKUIZfpCpJElfmwjhYuZOFQxZGEjt0VHbbiIjr/GD
X-Gm-Gg: ASbGncvK53Dlg+bSVpOvC843dIFGMKaj/US2jxeiDUpGhMKNj1ZOvERklObqSmD2eNi
	X9sw+PcQELosyU4kOLOiLZr0pj1pXXnWqBfaGS61uWsHS1rnupbfxSHlmi0QhdkR/j6kEdith/y
	qHzmGH56fkaiuSXaGJ2R4YAJmWNF+QBO34fFnlfIeeK/2rycGCbIlkMRgXCLUqY8lLk60Pw2xQa
	5wQ3g1gD73B+LrgNkTJRR45tVS9bTwj7R8gJHE+YZnO4hihSSN+G+IhLt+DzNOmpEokBFBORCrp
	Tv/Xq90RzCXeve1+BkTLItYLAkNPFNY=
X-Google-Smtp-Source: AGHT+IFjYT/m1MRnPua56A4ceDqKHqnT27HdXDvwyL2LyaK5ILMPgH1OeLlvurwBgPORnzf4Xg755w==
X-Received: by 2002:aa7:8893:0:b0:730:f1b7:9ba9 with SMTP id d2e1a72fcca58-7326197e823mr404985b3a.7.1739562930518;
        Fri, 14 Feb 2025 11:55:30 -0800 (PST)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73249fe96b4sm2670530b3a.75.2025.02.14.11.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:55:29 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	ajithpv.linux@gmail.com,
	roheetchavan@gmail.com,
	niharchaithanya@gmail.com,
	eleanor15x@gmail.com,
	everestkc@everestkc.com.np,
	kees@ijzerbout.nl,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	gascoar@gmail.com
Subject: [PATCH v2 1/5] staging: gpib: cb7210: remove unused variable
Date: Fri, 14 Feb 2025 16:54:40 -0300
Message-ID: <20250214195456.104075-3-gascoar@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214195456.104075-1-gascoar@gmail.com>
References: <20250214195456.104075-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove unused variable 'nec_priv' in function 'cb7210_line_status'.

This removes the following warning found compiling with W=1:

warning: variable ‘nec_priv’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
v2: no changes in this patch.

 drivers/staging/gpib/cb7210/cb7210.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index 381c508f62eb..5c2b2c382df3 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -383,10 +383,8 @@ static int cb7210_line_status(const gpib_board_t *board)
 	int status = ValidALL;
 	int bsr_bits;
 	struct cb7210_priv *cb_priv;
-	struct nec7210_priv *nec_priv;
 
 	cb_priv = board->private_data;
-	nec_priv = &cb_priv->nec7210_priv;
 
 	bsr_bits = cb7210_paged_read_byte(cb_priv, BUS_STATUS, BUS_STATUS_PAGE);
 
-- 
2.48.1


