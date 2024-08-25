Return-Path: <linux-kernel+bounces-300487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741B95E43F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBDD28170D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B7155A34;
	Sun, 25 Aug 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/nyva7K"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090FF1DA4E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602422; cv=none; b=t9U/MG80YPwVbSG27uC6ghy9Q7halyuxpwmw0a3oDYUEcAkb3BkzHI5yOl07vBrSejNOqPxlGdUgbeJ1M0gvhNmTZKQpYevYvr44TwFYFyAlIj1DDqNwF8mOjfl6jWG7Byt5z4HiOREsR/NXan5gcSfD1i23p6HK8+t9Rccopy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602422; c=relaxed/simple;
	bh=/jvCeKfSVXgCuuSol2E+jpEb/J70J+/Kp9rzudHAATs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Wpts/djXc1W5Ig7C3HH/8ggPpSzqfvZy8JmRrQZ6uCudV8m8/AV6jib0LgFycDRacAQMlJLRYQ/JAAw4esGfIrSYkmwvS+wQ4MB8nldS7JIBhrIqjnrnnA8MoeXZFSZKupPD1hdYZUeau2srLS6Bc+b6rVshBXzhTOrLezXWjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/nyva7K; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202508cb8ebso23017065ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724602420; x=1725207220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FKSCX9vM07YsCHT6bGYskoWhcQrnKZPSMcqcmHFl3Rw=;
        b=f/nyva7KMbpWQ/l+eGe8MshYs1Z2hxcIyq+JxxMct+7H+ftBmwSJNP+TjWAfT+rH7V
         vY6KUH4CUsritH0kyQmaJDnDR8O8roL0RMcu1esLarubvYvMTREeFG+fRmEIOcR7fLFA
         JkXgTik5bYsnRMUuLOVLgWGBGMttGAa8VOYQm4XYk/23hX7n1N2b8eUQu8nXHEebcN0S
         qjN/7eW0ZPeAFVL0sJJ+j4Fqmk7MtMWlC1TtLtlZRxpPVxeQlx+kkSX/Y9/U5mbEjNeL
         d1xw5KEDMXBWp4x6v/jUVXFHskZeSGuIplb0KNaZXNJtyrd2zyczA5iw2xopVovgYyMP
         4wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724602420; x=1725207220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKSCX9vM07YsCHT6bGYskoWhcQrnKZPSMcqcmHFl3Rw=;
        b=CpM9YgAnurRvyI7QsufykfYcPbzTGaGI6ucEQnS/g+E3xOsy+X/Nf6VZXqbjnFnY6b
         +mpuiCsquvtwCRNsHhqR+w/5JTfBwxGUNG0uxhN4hVGfwLAxlrgpe0pi6MhiPWRVixvD
         kTKIKGiR354wRvKU4mnJTpNXc/LFhI38j2jwlZ5k/CRVdNgsl8TX30zyYGzYZoVZqJe6
         DSSkDgor/8J0H2OUfqKRP6w7RLAVnhxyughnMNRfHd1JItsLuCFIm6xB2rZGoPqFIOil
         RaxpE9GocGfv9cT4jGmwTkCsfXe2ymd4lnRjnW5TfZZnrCN6FwPOxtVLumVo9+UZBNc4
         8u5w==
X-Forwarded-Encrypted: i=1; AJvYcCXVOBOFZ1clGCXZwVSp/i/hIck0BdKTXQSgQbhyetGJU4hlH0l6X6WGM6Ykl2mkGdYUV93qtMgtQy9OeXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRE9e2VSVGaRfTaBGe1LJC/G+TKEdJdBLXCNdlkyx/aT4PJTId
	uXf5HZF6WAjCUcLC9bnVsJlyuDDPuF5cTxgfmArN/Daoymbp98Zq
X-Google-Smtp-Source: AGHT+IHWvj5k/XDP5QdRApqaybHDJVssK7CDqyPKWf0AgEMYxLyZwmbqdvj9FX7PkTosugvM7nTxBw==
X-Received: by 2002:a17:903:2349:b0:201:f853:3e73 with SMTP id d9443c01a7336-2039e4a900emr81726585ad.11.1724602419937;
        Sun, 25 Aug 2024 09:13:39 -0700 (PDT)
Received: from BASE-20.home ([2804:868:d047:ced3:41fa:c7cf:e733:9f1d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385bdd1cesm54980955ad.277.2024.08.25.09.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 09:13:39 -0700 (PDT)
From: Alien Wesley <alienwesley51@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix Assignment operator '=' in rtl_wx.c:681
Date: Sun, 25 Aug 2024 13:13:35 -0300
Message-Id: <20240825161335.21737-1-alienwesley51@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separated assignments for pairwise_key_type and group_key_type
in order to silence the following checkpatch warning.

CHECK: Assignment operator '=' should be on the previous line.

Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 47f1adf30ab4..2d42e7a5bcdb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -677,8 +677,8 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 
 		if ((encoding->flags & IW_ENCODE_DISABLED) ||
 		    ext->alg == IW_ENCODE_ALG_NONE) {
-			ieee->pairwise_key_type = ieee->group_key_type
-						= KEY_TYPE_NA;
+			ieee->pairwise_key_type = KEY_TYPE_NA;
+			ieee->group_key_type = KEY_TYPE_NA;
 			rtl92e_cam_reset(dev);
 			memset(priv->rtllib->swcamtable, 0,
 			       sizeof(struct sw_cam_table) * 32);
-- 
2.34.1


