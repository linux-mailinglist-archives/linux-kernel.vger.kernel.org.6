Return-Path: <linux-kernel+bounces-232633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A091AC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB947283D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FB1199251;
	Thu, 27 Jun 2024 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXyE/BZn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F81CF8B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504046; cv=none; b=c0VBXQmqvsAx7qxG7k4iHIkrWu9EqVskyFeP41Bk6RgozxVn2ONEpJcmkQFj9dmwKELEgtk8opuBV4qY6Bknzbo7rr33MCUuxvK/2eDyTpLIA/jKStDeUz2hS4/suXCI9ASnIYQWxqR9HyB6M+6W0BD/ApRmqC9KttuptivCFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504046; c=relaxed/simple;
	bh=WDaNMzqPAnqi/u+RFCDIImLuvAlHk1efK+xDKhaieBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VyniABgN2QBhXflISk6wXaj6cGHUsFAFA8u+JcissBnDHNQWdpdQCq4LQqua+1CVEjzZjsGHMPIFlo+6cML2vA2Ztevdly2IBDb6QzxqOXxe7WpyQEGD9ORE/CdYrFCGm2zDHTKvKjmlIV1qzMIfYsNXcsllqDuqvbNUi5MBWw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXyE/BZn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64399573fd3so142117887b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719504043; x=1720108843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=INzVQfOcOyw0MPWfDO8THA5WvTmxm42HTaXMhSU67yI=;
        b=oXyE/BZna6lKoZMe7WtAZTJbTveNSKOm/c2TgsEu3l6Eugobo9U043DntkHV7o9UnG
         1JBDPVZ45EhBGB6aVT6/rwmJlTDfVSwuR+Gj6IVnx7cHQdJsaTMOWXJuRD2K30cFHGlB
         ZpXGsyWuUwWZi6/9Qc/i1VrA6pNlcg5k8UWCRQ9aPbwOmklNNlwo/zr0dtNwT9Oh+Su8
         o5D3AtbWl+uxSrs21RuOjpoDndBbvnfNwyCamW5skVCRmfrbWfn2w4Qq7vciWD/QM/l4
         V6gEQAg1PeTdSeMQep0ubjHgbuB+c4hpdHwCNkCnVTTKa92NpSw10iJOp3uo5e/8Jtwa
         xI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719504043; x=1720108843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INzVQfOcOyw0MPWfDO8THA5WvTmxm42HTaXMhSU67yI=;
        b=CUVkK/x7fg+e2nqXg/Sv89/NRInd1t2Xg/UucXnNAxXN1apEzvqbusdngMeWFOIah/
         pNm+srJaYH2QR6yTApwR+UEhDrpiKFwAh5iLMHPq9d5VBHbMVLXHpG9ce81mRJKjHSjV
         DGrDze2LUmxrr+9XtnC7rGsPnun6cihauIwoYx7D8jcoAvYWWHIxqptqbzfMUYnirPPS
         H3DkqVMMcTZ0MkSSdhcJw1F+q+4jNE24fQ6rXVGHQT2Uv4mX8XP0MXsrQ0VMPMx4DiNt
         KAmbbaYI1IJukubGGUOxSVAcT1CHUF5U+N6F6iIcshNtm5lNNOKFVq8yuT0qZ2PyOu+Z
         pChQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJq1RRINg3z86girH8kxxsrvlu8RrZ4mNgAKxrXDg5Hpke00krbGNNE/ZvZj3bMmMqxGgK34H6NeezhI9E68DLbo4wSa4LSmklJwYo
X-Gm-Message-State: AOJu0YxtPN+GE3y6Lh+xXrspg3oqlMzQnny40fk/NuQU4NDDF7jy989G
	YoQNMv5SUy8ZVG3xc4ie1Loal+AyAbkJ0PjZYw9Z5J6PioEwvRStZTxIfn+DKaQXSzRJGS1tn4j
	OwprUxh4GaQ==
X-Google-Smtp-Source: AGHT+IHfPPeti93pMs6W3uQWXmwfASWg/OmdR++s3AodAbpKZKaM1TqDW6jcYi8RtSqHCe7HJ2lZKrNynSZxGg==
X-Received: from tadamsjr.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:177c])
 (user=tadamsjr job=sendgmr) by 2002:a05:690c:60c7:b0:61b:791a:9850 with SMTP
 id 00721157ae682-645cfddf3a6mr6375587b3.9.1719504043514; Thu, 27 Jun 2024
 09:00:43 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:59:23 +0000
In-Reply-To: <20240627155924.2361370-1-tadamsjr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240627155924.2361370-1-tadamsjr@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240627155924.2361370-2-tadamsjr@google.com>
Subject: [PATCH v2 1/2] scsi: pm80xx: Set phy->enable_completion only when we
 wait for it
From: TJ Adams <tadamsjr@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Terrence Adams <tadamsjr@google.com>, 
	Jack Wang <jinpu.wang@ionos.com>
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
Acked-by: Jack Wang <jinpu.wang@ionos.com>
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
2.45.2.741.gdbec12cfda-goog


