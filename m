Return-Path: <linux-kernel+bounces-440306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A0D9EBB87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E97286A43
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE31232375;
	Tue, 10 Dec 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF8TgUSt"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC04C232368
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864907; cv=none; b=qBlbKNhULQ17cBn+pMRHgNKGqYLWYWfJxPCJ6RxjJUjPLhzzicmJU7zY1pbuh59mlrLaS8D9SlgTuyUK6wgPsVNkI6JtCQVf5Vej491BGPpys8h8ne+aIaC2gQ+j/1HohVGSfVxauz+lopcIHn/Y6FZZXbWQpeOT2LaFhIyAWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864907; c=relaxed/simple;
	bh=qZGtZZutbMvlH+uph3zH7rgccrqwRhz3wHSsLjRGNeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+2TjrIq+bPqVj88Y0XeRlwY9qDdC8BzkDxRunjbCBcRcryD1DOTv3drc9e2zBJ7diqZuwnwYazgnwcBQjRMs23FEi6FPqiAnF4jtaChyQAXIzgzfRCc0w0QScO1Xvs2HmbQgrnY5HXBE7vn8DJ0X8FlMAwWyEwbxSxY0A1c5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF8TgUSt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso2349668a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733864905; x=1734469705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q03WUTFmev9HP2RHXk39Wz7Ep62vHEDdq6OmuvP2N0I=;
        b=fF8TgUStB+GfHkbqZh/GucHclDJfyWGCHYA8ooEu165h4VHTAc/yyXfvgToSnNtcg6
         KpE3KAD5+N8wYVW5NjpNcQG84JjYtrhS+dbBzetJ+7pXn7Kx669NRHTA60wDXH8C1zb8
         9zeWVlzJqsz/wcQ1OkR3nK1fvrKGJ1BQg8/ONGJcBxkikVGY5Ysj+YVjlgoG9J7HG6fu
         YQs8huT7ITVCYsrxq+1MfWUxj6wqSQhTbiQoIRO0ctoRMDpd31a7n9PYPMzYT0pc44mW
         mRc7JBp1/roukn7enemIZEqc428H8RsM4rLt+jPT1O7Tv3Njf0a45GDSewjERk5A7+2A
         w1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864905; x=1734469705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q03WUTFmev9HP2RHXk39Wz7Ep62vHEDdq6OmuvP2N0I=;
        b=OabtdRU6RjOqpmAMTg3eC8Y1rkWZ4oB3pS4IVfR5+Rcr84FI5MQy5FbpRsPS/M+W6s
         UDAGvUBGehkzuGEfaQgc1J6ARuVw07ezw2kggBxfXQfkWOG0g8TNyXPoBi2WI4gxhesg
         HWhTzAZiML5jXuUo7QtqYiPz0L3S3npTtH8B5ELtwZbFbrXQn6Oerz8LkbXzv8a7ctW1
         cxQEijnRyg6FXfVaEUwbYnni0M4wnpYUOR77z3USZBMyAfVq3Wv4nymg9WGfg046ob/F
         rhEBrE7/AVtf3vzPhxGDzYr1N3fPmiTHkmENVO2eYWPPO5YyphkZxYBcBFlhymyyNxEI
         8Peg==
X-Forwarded-Encrypted: i=1; AJvYcCXNkqxhbwd3yspofBFVooafnMMpBe2KQYriSZ2tyLHYwPqste7SwD+oXBA6HKFdiPPD8r2YCZqtuNp7JHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIeJ5OuNmWG/M5X76qFCNhHLVu5z4RfYsxaCb/uASSwBM2+ZY
	1Btg62AhfDVTbbrzVgFzPWiHRvuI1j1hZt9p56pPGvQpp6Wj1bc+
X-Gm-Gg: ASbGncsrdhMjFzJpUUUvCpYZixpcOXsGPp0IV9+WYnEXwKmEwM2bgRWGHFxTTlUFNNJ
	45EbWc+oKqTzbYst0RfSLAbsm4819fdh2K0ymfiwM4Qsax9eJ5Llrh5dttqmU67Eould/s/lhrK
	lP1iib1chKrF5MLW0pkLopuPdIDJMy/CGequ+RdlDZT6dMSLpRMQag+PChVr8sXD9Ycb0++3w1g
	t4nHaZnIAUHCo1WyGnSltdSzZkRBiS4D5owVLOHch6s/EFJNYsmNsqq9EK2NXxT9G15gktrimZ3
	7Q==
X-Google-Smtp-Source: AGHT+IFXVjibjgKMMpneV2PFzLE+OdzrN5Y+d44zUeacgNzcWzOI8KwbWibXSxqnsYpNt692JVJh9Q==
X-Received: by 2002:a17:90b:4ace:b0:2ee:c2b5:97a0 with SMTP id 98e67ed59e1d1-2f128032302mr621367a91.25.1733864905089;
        Tue, 10 Dec 2024 13:08:25 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700979fsm13385731a91.18.2024.12.10.13.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:08:24 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] staging: rtl8723bs: delete HAL_DEF_DBG_RX_INFO_DUMP enum
Date: Tue, 10 Dec 2024 17:48:19 -0300
Message-ID: <20241210210741.17101-3-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210210741.17101-1-rodrigo.gobbi.7@gmail.com>
References: <20241210210741.17101-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After removing code isolated by DBG_RX_SIGNAL_DISPLAY_RAW_DATA cflag,
HAL_DEF_DBG_RX_INFO_DUMP enum lost it's use.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c      | 2 --
 drivers/staging/rtl8723bs/include/hal_intf.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 1803c0cd3a7e..b41ec89932af 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -682,8 +682,6 @@ u8 SetHalDefVar(
 	u8 bResult = _SUCCESS;
 
 	switch (variable) {
-	case HAL_DEF_DBG_RX_INFO_DUMP:
-		break;
 	case HW_DEF_ODM_DBG_FLAG:
 		ODM_CmnInfoUpdate(odm, ODM_CMNINFO_DBG_COMP, *((u64 *)value));
 		break;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 282e141616b0..85de862823c2 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -144,7 +144,6 @@ enum hal_def_variable {
 	HAL_DEF_PCI_AMD_L1_SUPPORT,
 	HAL_DEF_PCI_ASPM_OSC, /*  Support for ASPM OSC, added by Roger, 2013.03.27. */
 	HAL_DEF_MACID_SLEEP, /*  Support for MACID sleep */
-	HAL_DEF_DBG_RX_INFO_DUMP,
 };
 
 enum hal_odm_variable {
-- 
2.47.0


