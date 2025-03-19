Return-Path: <linux-kernel+bounces-568945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E108A69C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0BC8A7044
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C29221F1C;
	Wed, 19 Mar 2025 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2/NpOmN"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E41A2567
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425410; cv=none; b=bDJhnwC9pd6BsNOwrEJSzukIKn/9TjRwhbykB0D+93723HM+BKO7x3h9dGwg573jsDnGe5rackM8esNqZvz+QJEz56ejkNO8QK7CelFI/ppyJPyutsvZ5odtFzPDDfMUvTRG1ffKf9GiBvUzjUAsOg1ngmRjsdwXORAGRRefw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425410; c=relaxed/simple;
	bh=Ym/oE9/zF1E6WrnK7sblqTplV6fSMY8+bf5qbWR2xCo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=In4cC6VXcR+GXu92Z+Akrua2/8DW4sDSETDll+4X3h9pwcvgVGKTvuRi8D1v4BZaq7kceYB6kYT1gC8j2gxqrG3NJZpQcxP1gQ8cFacpC4OyfISRuu+6Bqo9DRjqLeYQBtsF1F2+wAvSN9oik5FygyJQmxlaxQ3GUbRskukG238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2/NpOmN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2265a09dbfcso3264905ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742425408; x=1743030208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6nIujCaipHEcjWLXKMhhxpOA7wQAYdR7gK4wSARh5AA=;
        b=J2/NpOmNPKEQRESWufotm7gFEll2n6Ag2a6od7bg0I3XUNUTx48Q71dUt4IEJiAyb/
         pLc6s/0hXPvKziS2AWb34ZxYbBcjW33cCSCxxwT5XuxLYgNEE7mkt8EP0O3mG8HdzTbN
         gZeiITe1UdiljdEWIL/FgNroIQqZl80Mpo3LbEUhKgES59VKa9FjHU7d+y5EshmfGHTx
         Dhy+e8LFzPKOxCWSz8exP+vEMZEC+ZyWB9bqiww97q1nYtGavcgRJLbLWRClAA9mxaRM
         Bk1mmAI6sBkOLnlHMkwy9I/t5IsiTUd3xVa+yurBupVrvuQ2juKeP+CkwBseUtlMkBtC
         OR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742425408; x=1743030208;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nIujCaipHEcjWLXKMhhxpOA7wQAYdR7gK4wSARh5AA=;
        b=DHg3EPIMOmjhQcAjwShWgr86eAu79DvXAwo7P9hQPPBA6aTiHQOGeFH6/qqSQYT7Pm
         ump3ZYztYKLZn2wyVAqJ+U0OBSvdQozqcgUxV/4U0hjo26pcJ31ivp4Fof0s4GbGHAsq
         i+q/YirVv3vTxyMRywulfFREnbfeNNResQsjvt26NzXMaqPp+bTlhCu3yy/G3Xdln372
         KZjfPu47/8tqbIMji8Zexx/25S0QnhLSgSfTxkd3oXTGmKaJPBXhZDwLfEiLrGrawI/p
         vUzjfWsKJR6t/kaJNoNveXYTE1xxaunt5Aa2dyydcejSPkCzgoYoreptSLzDyef6IByP
         RCrA==
X-Forwarded-Encrypted: i=1; AJvYcCUl4vxmpV0X6giFeHbQ6g0gnhEJRqGsmaL7ZvzzbfsnRnN7O3Mh1Etg/n1uzleXlb+CmwbiL7wKZ/Urq3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxL1i8r164QIwesO0JXZ5n9j17LHF/kpmfJZvfQykhQRFqRFG1
	KAoRcs3ipUxIIhX9cREl7kE32sez/xyYdTy+sTCfAJ6ghIcWLRgYrPxXB8/fomHzm1+44csoHdC
	PwJrv9I/6Bd3nMYgRs3SdNw==
X-Google-Smtp-Source: AGHT+IGY3B63A+a3JRwvAfAFumFgsjw1Ar3r6BNfWtiIpuP0pkmz5wFEyXp+q7/EyGOCwI9iSkI5T3Bj8kpcdIojVA==
X-Received: from pfble5.prod.google.com ([2002:a05:6a00:4fc5:b0:737:6066:fee8])
 (user=salomondush job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:6713:b0:1f5:8cc8:9cc5 with SMTP id adf61e73a8af0-1fd133f989amr2152207637.34.1742425408172;
 Wed, 19 Mar 2025 16:03:28 -0700 (PDT)
Date: Wed, 19 Mar 2025 23:03:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319230305.3172920-1-salomondush@google.com>
Subject: [PATCH] scsi: pm80xx: Set phy_attached to zero when device is gone
From: Salomon Dushimirimana <salomondush@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Salomon Dushimirimana <salomondush@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Igor Pylypiv <ipylypiv@google.com>

When a fatal error occurs, a phy down event may not be received to set
phy->phy_attached to zero.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Salomon Dushimirimana <salomondush@google.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 183ce00aa671..f7067878b34f 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -766,6 +766,7 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
 		}
 		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
+		pm8001_ha->phy[pm8001_dev->attached_phy].phy_attached = 0;
 		pm8001_free_dev(pm8001_dev);
 	} else {
 		pm8001_dbg(pm8001_ha, DISC, "Found dev has gone.\n");
-- 
2.49.0.rc1.451.g8f38331e32-goog


