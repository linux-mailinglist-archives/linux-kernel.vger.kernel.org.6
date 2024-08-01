Return-Path: <linux-kernel+bounces-271535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091BA944FAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82611F24FCC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAF11B142A;
	Thu,  1 Aug 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ3JWQtX"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0F13D2AF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527528; cv=none; b=fcoVZeXuPypVBgb5qiBVnCZt3mzbmuNjIFlvemoyC3CFPPxRApi0qb7+QtGVRTCXxiKjIV6AX2+Hy4mARG3D8TywmQcSK/hO440m1ZVVZHCyz96hIozXjFz23eazn5YeEo2Xt1S2Exy8/in4qfVvMrZ9KRm/yswQH2xRIVz+FRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527528; c=relaxed/simple;
	bh=y/lj7vBeNf0zFhIlANE7wwYSi3TRQBUY7ACxJkAWiQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=em9i9gKpX82G/iCxGH3S6bQfhjX1DKjBRseRaDF+MAtI0xkxycSZUPN5uBnz+dEuOH3VzNGM/Ro+v+3XWWkit3rIyrIXa4FUyqG6TNAtEnTpPZA678RhqEgOYXZwkdAuaARw9/gryyI9UZMT2H2lXo1bM92gifTo471qScsY2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ3JWQtX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a10b293432so4487303a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722527526; x=1723132326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WK6z8bBp4HaVQ4gSLs/GzN2vxB5I+xvIw+ZJcc3qJM=;
        b=iQ3JWQtXAtU54KdFAiakUSGEsoi62oUAJwM21jSIdaaueU0zhFEiQN1s9PR7nhfE/0
         vgt4py8nytz8De4C4chKCbVEBvqAWyvGpRdFLDdJax4wtU4KedZ6xK6YLOaObuaEs3xI
         3JCFQ5obQKrgAVRqmlnJRjr8x0Cpln90sVtgTFGpSj73ME2LqsLlyMeBz+yRJcSDRRtO
         Wo6TZ6XSwE0SDR/cBGubE0+4q4/6lyyAeg2KqJCdGgaIGfhEyiuBrTKg/VIQniHwxMmH
         +FY+g3HlSuRGgfiddtV1XrMX28Lpz32fenf2MQD9bioLWS4MVYrdGSfjtN2Tx4NNpeHF
         xV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722527526; x=1723132326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WK6z8bBp4HaVQ4gSLs/GzN2vxB5I+xvIw+ZJcc3qJM=;
        b=CaUyWMIo26xnbUaq7am8R6i0uggV/wo/QNRSXvYCTzLqtC4dfE2rU5ls7RRTCcA4ih
         VVix99h6ze9fBcmq1x2ix0BzTYP5webUvWJvOEjg5axqNoFpZbTzszs3CVRzDj4n6eO7
         NowuqIHPms1RjPtx+AglHGE8EjDsVrItzwR0Y7gVPjdbrqIZlpgpJIFQZUYp9vwA2WQ/
         WXoQy24qxiq1s71U1POvp+29eOEwR69HFp9QTMq3TDCukCBr/gne/KmXi/NcRktTz0FX
         /7BeN2Ds1wbIXhX5mL8zEcLrZfyTLHAftrQ+10sYTlnpTqBBPPl4RHk51Te83eM3GE3Z
         3sfg==
X-Forwarded-Encrypted: i=1; AJvYcCWDn92qW+iGq88yK6ik37Gz9btguYWw4EZsfaLjV8ZBFWzSkaGdOweNZHwG9i/ozHkOxVAJ/qzM//T9Oes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLBhnUqc1426J1ko7LpGygOWIo61TMhWY7mxnp54dwe/++XN2
	0sQXb0wrXm79forYXiFJrW4eW59BoZDScyCGf9ITQNspOOtrYODS
X-Google-Smtp-Source: AGHT+IEIbp/uvYLet050nvRtxKTJyYdiGQ3L05uMZKwP9rmpMifIJRZRJg+VPTmyeEu2Wix4XSuVQQ==
X-Received: by 2002:a17:90b:109:b0:2cb:5134:562a with SMTP id 98e67ed59e1d1-2cff93c4bfcmr872553a91.7.1722527525843;
        Thu, 01 Aug 2024 08:52:05 -0700 (PDT)
Received: from VSUS.11svbebsuybebf4lhlhk4eftnc.syx.internal.cloudapp.net ([20.39.190.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb0cc3e7sm75034a91.26.2024.08.01.08.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:52:05 -0700 (PDT)
From: jiwonaid0@gmail.com
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jiwonaid0@gmail.com
Subject: [PATCH net-next] staging: rtl8723bs: Delete unnecessary braces for single statement blocks
Date: Thu,  1 Aug 2024 15:51:38 +0000
Message-ID: <20240801155138.25531-1-jiwonaid0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiwon Kim <jiwonaid0@gmail.com>

Deleted braces {} for single statement blocks.

Addressed scripts/checkpatch.pl warning.

Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 1eeabfffd6d2..e0736707a211 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -144,9 +144,8 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 		psta = list_entry(plist, struct sta_info, asoc_list);
 
 		stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
-		if (stainfo_offset_valid(stainfo_offset)) {
+		if (stainfo_offset_valid(stainfo_offset))
 			chk_alive_list[chk_alive_num++] = stainfo_offset;
-		}
 	}
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
 
-- 
2.43.0


