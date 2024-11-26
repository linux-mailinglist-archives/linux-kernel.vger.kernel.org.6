Return-Path: <linux-kernel+bounces-422886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C08D9D9F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C7EFB22A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149251DFE03;
	Tue, 26 Nov 2024 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ln7f3+Ma"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280461B394E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732661390; cv=none; b=NgZ2qCZ78RSAMGOw6UEZRYaZU+ZR3ycoVPlEKcSWe5pukPDjaY2+Adz1DppCRlJ+RRZa11D/VpPGtUA0Z2nu9ip+x8AddwA2mCxIDCCwlRrt3WXo82RUxT7xsEYsJH9lANs8/tG4DuduH1Bcx2JghItjArHAnKCmsUz0lzIIHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732661390; c=relaxed/simple;
	bh=HO4kGLHdZ46KJzFqmtjTFi+nQsgV3QcEAv4sUsSt5xo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d1Rfax241Y1cWS2zz+ClmXiOGEKmbqTeVv2sMLXDqSRkyMSunczsgkLJ0vrtGEidI8rYgwl8qEA9x7O6h8O28MUZWD2OAXehqbwjaLCo5SfumItYUWhL0WEf5tApAg9YtlHMK5sjrAmmv1Zji3EnAg5WULVNWuFo92ehhrpgANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ln7f3+Ma; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-724f7c09c58so3338541b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732661387; x=1733266187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9P7Y6hO1KRaALzgNc/8yHI8FvE407ycTLKy/FIi5bOI=;
        b=ln7f3+ManIYlw+pGafejt5GaRFRJhYVVVni6KW1VnVAtDfbMr7zVNRrDNvMf/td2Hj
         ceChdLN5T9mQsGlkZ32Al+cL7RJAk2kJ2E9H5sTeQ9H9/nsFFr49Hj/uRtMIim2GeCxW
         /p8YvlQOqOQggLnt+BVVlGUXYfcHQKf7xAPBD2Ln6OOB5TZah/Z7HIpVRscEcOmYUrjL
         GRNQAdn/7WmGpKG+lvDgi8D6yqBopFOKWy8qovACqH+h70c6px8EcsLhzCfSFFnBAaoR
         BMjnlrQ5x+qGzFvOQiQESt/b3c6ZYkxUVWMapxjKsad4AWcGZDnAeOoPMoWq7qsoTQm2
         AbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732661387; x=1733266187;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9P7Y6hO1KRaALzgNc/8yHI8FvE407ycTLKy/FIi5bOI=;
        b=eyv4mJA2y0FmIdp+UlAoV33te3B8Gpq670d9HPw1CUGvqCS6Nr5q1TSpD3yyGFwwNF
         5dE4BJhaY8n7+2nqApA+Adrm6LQFYEhjXD+uKuT9VAX7EK5tJIo4XKhwzOhMOrS2wzSY
         rPyZlpI/nMsgQ+WVy5zTp/Cjn7PrZf11wyMpoq/PPggJYsAQwpXPtzATvJ5tykCcx1Ig
         DPmDk24SAwhLttJexlxcc9+bmzCjA1MPAV1odoOeXI/EW6SahgiSaKJFkuT2hL6G+mjc
         JkSJPtMaPUMCper8J2cOTX/2LVYcqVtij1lBO8N0yOKrJylpFDwWzon5WnVc0om0Fy6h
         scUw==
X-Forwarded-Encrypted: i=1; AJvYcCVy4oyrsReKk4wSRv1mqf0Izig7dxRn1Nf30UQm1SZ+I4gxqQdCv5JLpFb6lM8NfnSJbgn6kOszYbSrEtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yVV3vtLzVRuq9DRyYXJXyZ6ouGhVFgPKf9q0Tz0DDpj0pnc6
	FSd7xs/mrEPgzacfKCkrafcUATs95qpnIbCouaedQs7OFmmX9dLG29IqFHoAzFeVGzXKe9rUfp4
	lU05uUoVcBS3PAFEhTp55nQ==
X-Google-Smtp-Source: AGHT+IGBAWYeOEhaz87TjdeEOr5B5hoQsFgmzgO/CGWAO8M7kpMSblZXDhBBLm/oE/W0R77+i9RRo26nBAsOi90Pdw==
X-Received: from pfau6.prod.google.com ([2002:a05:6a00:aa86:b0:725:31af:9cfb])
 (user=salomondush job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:230b:b0:71e:2a0:b0b8 with SMTP id d2e1a72fcca58-7252ffd2b20mr996637b3a.1.1732661387475;
 Tue, 26 Nov 2024 14:49:47 -0800 (PST)
Date: Tue, 26 Nov 2024 22:49:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126224923.973528-1-salomondush@google.com>
Subject: [PATCH] scsi: pm80xx: Increase reserved tags from 8 to 128
From: Salomon Dushimirimana <salomondush@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Salomon Dushimirimana <salomondush@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Igor Pylypiv <ipylypiv@google.com>

Increase the number of reserved tags to prevent command processing
failures when the driver is under stress. 8 reserved tags are quickly
getting all used up leading to errors when command completions are
delayed.

The driver needs ~512 ccbs/tags for maximum I/O utilization:
16 (max disks) * 32 (max SATA queue depth) = ~512 ccbs/tags.

By reserving 128 tags the driver will still have plenty of tags/ccbs
left: 1024 (max ccbs) - 128 (reserved slot) = 896 tags/ccbs left.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Salomon Dushimirimana <salomondush@google.com>
---
 drivers/scsi/pm8001/pm8001_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_defs.h b/drivers/scsi/pm8001/pm8001_defs.h
index 501b574239e8..abe6560a5817 100644
--- a/drivers/scsi/pm8001/pm8001_defs.h
+++ b/drivers/scsi/pm8001/pm8001_defs.h
@@ -90,7 +90,7 @@ enum port_type {
 #define	PM8001_MAX_PORTS	 16	/* max. possible ports */
 #define	PM8001_MAX_DEVICES	 2048	/* max supported device */
 #define	PM8001_MAX_MSIX_VEC	 64	/* max msi-x int for spcv/ve */
-#define	PM8001_RESERVE_SLOT	 8
+#define	PM8001_RESERVE_SLOT	 128
 
 #define	CONFIG_SCSI_PM8001_MAX_DMA_SG	528
 #define PM8001_MAX_DMA_SG	CONFIG_SCSI_PM8001_MAX_DMA_SG
-- 
2.47.0.338.g60cca15819-goog


