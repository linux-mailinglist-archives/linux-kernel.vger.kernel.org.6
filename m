Return-Path: <linux-kernel+bounces-206576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58F1900B9D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429361F225A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A91C19CCE3;
	Fri,  7 Jun 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PX6kx7Pi"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4178D19B3FB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717783071; cv=none; b=hAVuLv/mr2deLOLqzJOeaNp/01/nrLPxPc3IVmc5IuhvylPkAlxJxKyLwTbCZkKRtAC4ekDBHYzi/Xkxslrj/R06jIkfEPBWKn0AAVnSVspp2Mp9rwbqXBayObNXxSdE2Bn6fd7rX5vOVD5I6oywH5LHsFu+jXX0kQj+vuKPLZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717783071; c=relaxed/simple;
	bh=kceaFwwjaSlBmkhXtusA3USI+23jbBoLODkMZKgX7RE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dsJP2jaFvS0e2fy5OMSVeS5ZC46d3jtInT/aPUJOPInzCRpGcpKZCyn4VrpBz4kuKWOUyJm3UyN7Z9NaP2dEu9ovsUzOfQLtAuFLtTNGZnH/AmjaOVjS/Pph82q9pbeebOirrUjj8qfyNbzVVAA8JujvXX75EPYMixWcaBVBTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PX6kx7Pi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-629638f1cb0so36730547b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717783069; x=1718387869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=68M9FutlL8cAjPUlj6bX6OztbAKg98sW3h68noYav98=;
        b=PX6kx7Pi7Pi5pBl4e6DZGHy18AgFLMWz4iuwOpWW3nxYSqlabtLJCQeUoCv01bEybO
         SN8FN8z4/b29sxLG60rOdmweMU3ixP+Y8/NHFwXirPyZfdt4AHGHMZ1ll+X1O6K4LKmt
         QlMh2DVFJd87n+hiEtcUFR8RbGha79j8ouNBUUGr1ajHWkbC+umY7qj4Yh9ZLvx31sFQ
         Hp5GTgGkZAO60xigUFeThLcahCeJZsXjQjFrtlbozJSyPnMHiUKWNBuvPS2xnX8YIRcO
         cl0Tf9YDGhslrApG5Omn53rGlYB/+piL302rNxeBhMrSCRU3mn4J79ys3+5HhrCTjaDr
         Wtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717783069; x=1718387869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68M9FutlL8cAjPUlj6bX6OztbAKg98sW3h68noYav98=;
        b=r24NKLj2Or+3LLscPDKEMKIM9F3fuXJ22hQE78Ajo+tdprGzZem2HkO1y0XhnrctRc
         Rxvmq5waJNwZu6RIVTObwErE3aGTDg+9Elr9k6EE3OUI7qMPk0NvZ1jl3SqHRGtWjSji
         MIHaT5kubq55sLY9HnPzMY4OAxw/SOMSAVvbEkyYGablCIWAA6HORp3UYR8T9zQ57nlt
         fyimmF6axa1rVatnXLOSJk0AQmK2BQY9yUDqcOqrzEq6y0SnYsoP8USSIDRp/7mWIxDf
         9YoUZrPgmdnf56+Wa590nmK+YogqhU8MlK2YPIznx0Zz8Ngeej3qyqwFbkW4Cskhweqh
         yEJg==
X-Forwarded-Encrypted: i=1; AJvYcCXUq9WNRpxgQB9bYzZY808OEUqIvXMm8gysbgQw8LZokQo8iMcHXhPQCZUgTXj0j14tGfB86U0kR6drHCCPSOCPeX4x/BhbcKwN5+Qg
X-Gm-Message-State: AOJu0YwsbNliaw4p3MP1QB1zd6MApT+jBMYAaNLrOxp6h8YGwIg6COIO
	JTVs2BaJ9bgvn6e4R2rYZqnBQmleDToUhsljLhoSlY/7OTfsdg27Kc/Rrk9acIDN7I0oiuW8Jqf
	RA7ZZsDRhmg==
X-Google-Smtp-Source: AGHT+IFSVowxqqPvr0+4CvkqgeikyT0vf4vjJ2LiCufzLnHvtpyVCokVVjJIiQzdT4oPCJcaV2sRwUt/x9KYIw==
X-Received: from tadamsjr.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:177c])
 (user=tadamsjr job=sendgmr) by 2002:a05:690c:4:b0:62a:4932:68de with SMTP id
 00721157ae682-62cd566adc9mr9535477b3.8.1717783069258; Fri, 07 Jun 2024
 10:57:49 -0700 (PDT)
Date: Fri,  7 Jun 2024 17:57:41 +0000
In-Reply-To: <20240607175743.3986625-1-tadamsjr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240607175743.3986625-1-tadamsjr@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607175743.3986625-2-tadamsjr@google.com>
Subject: [PATCH 1/3] scsi: pm80xx: Set phy->enable_completion only when we
 wait for it
From: TJ Adams <tadamsjr@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Terrence Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Igor Pylypiv <ipylypiv@google.com>

pm8001_phy_control() populates the enable_completion pointer with a
stack address, sends a PHY_LINK_RESET / PHY_HARD_RESET, waits 300 ms,
and returns. The problem arises when a phy control response comes late.
After 300 ms the pm8001_phy_control() function returns and the passed
enable_completion stack address is no longer valid. Late phy control
response invokes complete() on a dangling enable_completion pointer
which leads to a kernel crash.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Terrence Adams <tadamsjr@google.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index a5a31dfa4512..ee2da8e49d4c 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -166,7 +166,6 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 	unsigned long flags;
 	pm8001_ha = sas_phy->ha->lldd_ha;
 	phy = &pm8001_ha->phy[phy_id];
-	pm8001_ha->phy[phy_id].enable_completion = &completion;
 
 	if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
 		/*
@@ -190,6 +189,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 				rates->maximum_linkrate;
 		}
 		if (pm8001_ha->phy[phy_id].phy_state ==  PHY_LINK_DISABLE) {
+			pm8001_ha->phy[phy_id].enable_completion = &completion;
 			PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id);
 			wait_for_completion(&completion);
 		}
@@ -198,6 +198,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 		break;
 	case PHY_FUNC_HARD_RESET:
 		if (pm8001_ha->phy[phy_id].phy_state == PHY_LINK_DISABLE) {
+			pm8001_ha->phy[phy_id].enable_completion = &completion;
 			PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id);
 			wait_for_completion(&completion);
 		}
@@ -206,6 +207,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 		break;
 	case PHY_FUNC_LINK_RESET:
 		if (pm8001_ha->phy[phy_id].phy_state == PHY_LINK_DISABLE) {
+			pm8001_ha->phy[phy_id].enable_completion = &completion;
 			PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id);
 			wait_for_completion(&completion);
 		}
-- 
2.45.2.505.gda0bf45e8d-goog


