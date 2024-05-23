Return-Path: <linux-kernel+bounces-187087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962828CCCF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C709D1C2116D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2B13CA89;
	Thu, 23 May 2024 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzv3DL9Y"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C013C677;
	Thu, 23 May 2024 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449004; cv=none; b=nL0lfgcHS5G7VCn4oo+XsxW0TJ3cNtkWQ1c86pXrY6DgHu4ht9TKD/F1/HOEytQZTRgjmMCuSt3jrHyDOdj6JkbvK1bRrOLDrQlpGmI+57qg7vwVzWVMWeu6RbchUdgHo7HfW8tkUVLGSDcLlrPd/3nMk9g12hdK0oYonSZr6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449004; c=relaxed/simple;
	bh=vK4pezd55jcyKV1ONSHi+cBOCH1OBx7KMPkopav6q5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=frDIwqXr0zMZchtFXU3IEVnI+6c+D9LgYUz+iifscBnTYzUH3aS5ze/10PgA2ZrhjSsbZSpUJ+MkT11BSmKhksi9PeTS/MLVlkhkbaZ5O0OFhF2EPof8u5xPJPiVDuaY/VmGXmCHp+k/QDVQKW64A/hnnD/Sjdf9Tz9HXFfBCg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tzv3DL9Y; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f6a045d476so1980947b3a.1;
        Thu, 23 May 2024 00:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716449002; x=1717053802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rq5A7qawIz0cEKS1QsmbeowUJYNK+rwYbjhoZojg+Kk=;
        b=Tzv3DL9Yj8lhL3SFTdgFNHoDk7lDDNdffTOpzzsXoo32/0vgrX78vWIPpJ+H7d9Uku
         OD7y4nW0CydeGIw5uUp2jIl+04nzTV1x0he+WBJl2kEsLWmDoaqRQnhtz8ctIMY+5DZL
         IFgvSudDJ9SKtQZ2Nhpug/YS6O9UqosrlEY19beyN+3na1oPTOJ5/ZrCkabXTFNCaXHF
         8Sr+inP+IcOKFRJqJXI1YH1BgAGfa0inXiqLLr1/NZo0RQv5pm8DWk2mywpJLa70raJB
         Zh+feHVrf2fKekYRp88detGfKxHJosm4bAQb5QKXjpYdxifp3cufigLNkE7Jst8h0Ktj
         2R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716449002; x=1717053802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rq5A7qawIz0cEKS1QsmbeowUJYNK+rwYbjhoZojg+Kk=;
        b=RgMq7t5xKUae+aPWhiDKLvoCUN8wyFmg1soHVD0T0iIMfJ6G2f34/3Ysnse5Z23C5H
         EuaJvl1IILYWu4k8Ro30OeN/hNVc2h1TaMdV2idxR4MhQWi/2cDZVZGvtbbl8fK3nq/0
         bVye80bSHed5bxNm/H1rLKbbArQNjjuV4V7AA2GQ53Ebz7tXnZWBdaG0cpd8IDUZohCf
         c7rWSqm0UcAJh3neqiXwxhBhF+EMbYiTRPJfAAO+1XA7vcshNrhFtgS4UHwgkMVbcyP+
         o7aGndMMJKkKqF9+hND2kBstQ0AWk45lxUhMt6bu//QN+ALDiqBSq2NBIxs0rxcjzHOH
         bpig==
X-Forwarded-Encrypted: i=1; AJvYcCUkDgeyU/9MLTzGAEQqubVUUN+ZZJXcsPhrbVKJXnIMKCIEd9WEZHLCdLDgCGCE3bYAY6gxxAHGybx2uzDZRglTeyDQMDNAxIHFGuBB
X-Gm-Message-State: AOJu0YymtY6YmBOP/9fxcblQKMfpbUFoIZbUKvFXPDqb7M9DHqTfqOi5
	YP2hmlomMdM6Tzh11v45T0dWr+hqqBGED/34Eus57qt6eHxt04r3pDJVn2HrMUUgnA==
X-Google-Smtp-Source: AGHT+IFpoZpVLbPeQ5T/DaknlTrnAKDdSVBFeHX/QrlwsffK1M0xpnExRp2d75Xz8wt92hyGCyfHGA==
X-Received: by 2002:a05:6a00:acd:b0:6f3:88c5:fed6 with SMTP id d2e1a72fcca58-6f6d60ca8b7mr4509744b3a.19.1716449002429;
        Thu, 23 May 2024 00:23:22 -0700 (PDT)
Received: from velvet.. ([111.42.148.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2fe07sm23453154b3a.216.2024.05.23.00.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:23:22 -0700 (PDT)
From: Shichao Lai <shichaorai@gmail.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Shichao Lai <shichaorai@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: [PATCH] Check whether divisor is non-zero before division
Date: Thu, 23 May 2024 15:22:42 +0800
Message-Id: <20240523072242.787164-1-shichaorai@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since uzonesize may be zero, so a judgement for non-zero is nessesary.

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Signed-off-by: Shichao Lai <shichaorai@gmail.com>
---
 drivers/usb/storage/alauda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 115f05a6201a..db075a8c03cb 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -947,6 +947,8 @@ static int alauda_read_data(struct us_data *us, unsigned long address,
 	sg = NULL;
 
 	while (sectors > 0) {
+		if (!uzonesize)
+			return USB_STOR_TRANSPORT_ERROR;
 		unsigned int zone = lba / uzonesize; /* integer division */
 		unsigned int lba_offset = lba - (zone * uzonesize);
 		unsigned int pages;
-- 
2.34.1


