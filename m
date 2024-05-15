Return-Path: <linux-kernel+bounces-179418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE938C5FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3179F1F23968
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023E35103D;
	Wed, 15 May 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Ob1pOn0O"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF92482C3
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748766; cv=none; b=F1fmOoIDqok5kNO3pCMPAGK0U0cBCgXj466X839EkFQYRT2SanyPL4S6132dYECxfPeVStoh6jj3GfOEVtBVYJxh2ycyzSVcgrRP3QQC48TGu32rQs71Y3iihwVT9nQ7KFfe6cogsXMp9HWw0rDdSofjWq85qDjTshS7uVzGyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748766; c=relaxed/simple;
	bh=OQCA/Wuv/HfcLT3KLlRcg8Og+eLrIFBwwBqRoIqjfpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1U/ut/MR9emH4AMaZvzpRBwcEFWIuevtNs+nxcDGoyXah1l9lLJ7ZCL/9jz1EvWX+6Au0Qt9UhtPT3dpE/a0rXReMmK4bXCas10sgVJX+qhWjf9xyBYaYWYIkeL7HQix0N4sKNlQG7lxepcT7TVEzsr4KZ+zhq0vP6z8EV9w8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Ob1pOn0O; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-241572c02efso3775863fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748764; x=1716353564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dZh+TjKA4PTqq8oux7GZt+IFGMZGNC7LsD9Ci9/UDI=;
        b=Ob1pOn0O3PJJQ6lVf6VY7uoGsrXX7Ov9mR1czjSYGvRJ/PUTdN/r3jjGiu+URxKaD1
         3FnZ/Y3uiexZQKS9NaaBSaR9H8VN6/pN39tSzZSEw0w2moVSrJbhaHbpLEK0LsXLIl4+
         O3AIZiUGsDhJ4prPGbn0208Hp6JQoAFDDscq9nSRAa+YZEJ7aNhLjjqWQJtOyZDoQmZ0
         vuiIsh5VxhXZyRn7xbMEbtK5inJDflsXs8xAAJ8GCEIiwN0Grxn2TnRw33Uraq0EPbFB
         8CKrYi7+yk9l+ppH7n9560AHmCkyYHO16/NBFl/GwHFL1ayO6Ci8NUwF+/DOvxFTFZfo
         E4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748764; x=1716353564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dZh+TjKA4PTqq8oux7GZt+IFGMZGNC7LsD9Ci9/UDI=;
        b=K7nnE31wC1fIc1qp6EI5+HbZsJPADOPhrc7e6ykyzbQR+uGaqspABJgYOpNmbwZ4S1
         Jm9toCWmmdw26VTUHfS+VDf5jKklcVqrzQ3KkRoReIdWdWtWpjR8qLOiXN5WmUnfsKTU
         /QD4twvXXwmtED2a4I6DWmDvElH+y9eSrxsMmZoJDaQbm7tCGwLoAdym0akPvDxdElGp
         yoEXh5oq1mqjv8P9+EYMGKNEyyNIAcM0hUb9EpP3jrihyVXTsUltnsxR8LBbhbEmQKaP
         Poar6Cu6jNt5ZF8yiERp/WRso/7ep0NDp2Brh3b9cDLJn/dnXWpBgth/Wcfcgyg5hl0/
         xx7g==
X-Forwarded-Encrypted: i=1; AJvYcCU/Fhwgc6gtF8eVZfCyqBl9grF1dME6hVaimTE2uCfCjD6LKERT3Ol7y7YMt/Jb+rTkWZar/dCco2p05yoPl7Xv4e58X84mc77KT/CK
X-Gm-Message-State: AOJu0YyI3aCa8Ni2E87M/FrSVobL1k94mkxasUja6lUCJfrWPaqFzS87
	IHXznFAnP7QytK4Ox2Of3xWRzECzzzq8sb2Hu+T9+5mh+8H7fM7A34G60YXRafk=
X-Google-Smtp-Source: AGHT+IETKpJHTIGgyOdig88uRhkcCct6gCbyK/ArdRVDW/rPCpb+83MR9NMIqp097Ctk+y26VdNS3g==
X-Received: by 2002:a05:6871:5892:b0:244:bec8:febc with SMTP id 586e51a60fabf-244bec90232mr11318039fac.56.1715748763820;
        Tue, 14 May 2024 21:52:43 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:43 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 13/31] Staging: rtl8192e: Rename variable RfdArray
Date: Tue, 14 May 2024 21:52:10 -0700
Message-Id: <20240515045228.35928-14-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable RfdArray to rfd_array
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index cdb3ebc77a53..996662a06e3f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1407,7 +1407,7 @@ struct rtllib_device {
 	struct work_struct wx_sync_scan_wq;
 
 	union {
-		struct rtllib_rxb *RfdArray[REORDER_WIN_SIZE];
+		struct rtllib_rxb *rfd_array[REORDER_WIN_SIZE];
 		struct rtllib_rxb *stats_IndicateArray[REORDER_WIN_SIZE];
 		struct rtllib_rxb *prxbIndicateArray[REORDER_WIN_SIZE];
 		struct {
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index a30945f30e14..4c8cfa40927c 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -509,13 +509,13 @@ void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
 			   pRxReorderEntry->SeqNum);
 		list_del_init(&pRxReorderEntry->list);
 
-		ieee->RfdArray[RfdCnt] = pRxReorderEntry->prxb;
+		ieee->rfd_array[RfdCnt] = pRxReorderEntry->prxb;
 
 		RfdCnt = RfdCnt + 1;
 		list_add_tail(&pRxReorderEntry->list,
 			      &ieee->RxReorder_Unused_List);
 	}
-	rtllib_indicate_packets(ieee, ieee->RfdArray, RfdCnt);
+	rtllib_indicate_packets(ieee, ieee->rfd_array, RfdCnt);
 
 	ts->rx_indicate_seq = 0xffff;
 }
-- 
2.30.2


