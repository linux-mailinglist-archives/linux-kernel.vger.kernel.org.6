Return-Path: <linux-kernel+bounces-310284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A503967767
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529201C20B01
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811EF183CC9;
	Sun,  1 Sep 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6SUHzlH"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB116EB4B;
	Sun,  1 Sep 2024 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207339; cv=none; b=JrLyrfxb55pzjT+cNrCmyq40O8CIBb8BAb8JHTfJNj42cZ6f9HefWxvw7ZK6svkcJkAvDBH0+oUE7WmakHHWuD0tw70Y/k6mL3REq1PahmDFllNLQrOezgt9o0V2BaTUVYTYcqjcGKb1Mnc4ZFrCRc3BS12R1NQ4SKcGUGfdwuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207339; c=relaxed/simple;
	bh=R4VNz8BWmDGh8AOZOk4zNDKcYi+yiwkcZyfuIJceqXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dWB2tLH4EbDcMR6bVNaegCLLzGDdlFqJUpLFoQB021Cgu+4DcOpxiDeI0FwX3JtHNxjKMZorzNODuGxC3U8Ze8k7zItXuU31aDwmr7m9+khOEuZXBjCSk46ImDKtAbCzjLJg/LwD1z1ibjlaA+4we7sJ73n3PoaPpcGV1nYjoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6SUHzlH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8684c31c60so380746666b.3;
        Sun, 01 Sep 2024 09:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725207336; x=1725812136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FvHJ/0sFHcIi56+VT5QpPlQ5XneFMSu2E37DEhXuugg=;
        b=c6SUHzlHdHIAFr7T7Tp8h0oGoEv8//t3cqEjm7LMo8yGza1UZmTZM4Thr5Qam/JNOJ
         pCT/hlKqqXUCllt50jV4D+Ti10NALpQycOZabHADuHaS1S7dvqErD+w0cNxIGrRYeMlq
         pH20PotxIOPeENaOKG8k9Bt46QoWB1oqAPOa4442qrjmAaVuv8uhnQILxOTlaymgr8Og
         a+R1KpgLMf/+O1jwYFMfR4j0qncYony+Ah5NRmREEbGswl5MmtgdKirXVl9GE0HD86nh
         PqPL8kHaUxrDSl6EXM6FOX1IUXoiEv7Y12Ep8SN6Ea2GCGR0MR7DFv6NUz9XgHdENMOv
         MYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725207336; x=1725812136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvHJ/0sFHcIi56+VT5QpPlQ5XneFMSu2E37DEhXuugg=;
        b=BfzyjdGMd7bve6MsTf1/6UvRFECuytsUv3IcikbfwzmdYUELD9tHVmDXcmAlFk1D5f
         MiqrICcJquEkhLDboyALzFwBBbcPmAbJRLPRQGNwTLeUms+oqva+hqMPMdtvv6AIJqod
         PmKExzv+b73wOPpG5ADxCuN8YHku8xa15A6g5yCiqB7/F8fkQppzgPv0KiRWglhqQO42
         CqoIA3Q18v/87HGQSbzARTTzqhmk8p8i3K6fE8JhHWHTyk+klzG+avEqgKI9DhzGjDo+
         svlG6/Ubn100yAo1eRgnf62Vuy37azUWnQOezQcgWdknneyAJ8OfPVecGcRT7Rg6EsXL
         iQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCWgLre0gOw9ZlLe6CX8bSPbr9eclWaJFIkuINNhLEOUMeauvtwYcn6oaXAFvrpkmNj6YmpbvwR7DgqbhGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUDACHCLcNGEjPPNsZdaDERjvxOvd1GT+BeIxW6w48IdSart1n
	MxGOYIp52MAZqKB4QhxzpPL/EmJYXeQwLtKYDvdVC0e34IuiNoHw
X-Google-Smtp-Source: AGHT+IF46DT3j14xhDm2/bhky7JkzuBdMVV8iKwUpLkL+6PHWlDcG4bcSo778pkcrTmHtjfWGY3Q3A==
X-Received: by 2002:a17:907:7256:b0:a7a:a30b:7b93 with SMTP id a640c23a62f3a-a897f77eed8mr1010865666b.2.1725207336312;
        Sun, 01 Sep 2024 09:15:36 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898922276asm450787366b.204.2024.09.01.09.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:15:35 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: rtl8723bs: Remove trailing space after \n newline
Date: Sun,  1 Sep 2024 17:15:34 +0100
Message-Id: <20240901161534.143887-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space after a newline in a netdev_dbg message.
Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 9ebf25a0ef9b..6c52a856c9e7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -628,7 +628,7 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
 					netdev_dbg(padapter->pnetdev,
-						   "ap has changed, disconnect now\n ");
+						   "ap has changed, disconnect now\n");
 					receive_disconnect(padapter,
 							   pmlmeinfo->network.mac_address, 0);
 					return _SUCCESS;
-- 
2.39.2


