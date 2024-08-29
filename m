Return-Path: <linux-kernel+bounces-307728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F74965230
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE8F286F85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E618A933;
	Thu, 29 Aug 2024 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2GX8W6J"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CFE28685
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967640; cv=none; b=a+GQKyX3Y4r0LkYTN3Q8pusXN2sOiPgj91ClwCBuySLzSH/2F8+dmpcCdtNzCWbE+JMKLUHdR9ufVnJ7fk+S3tWDRx9tcJq7IESmS7HsVXJeJK6DL8q2aEmsiV78YXnbzxu36/dfadU27PAZ3MR29bIAnKg7aPbJ3oAMknIvoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967640; c=relaxed/simple;
	bh=LieYg7NH1ZzCj7/f6QMWYqnUg0Vc/d1N3HRBdyagslY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hwKbNgu2zZNu7FoWqDyhbBdzRw+z30aOjFX0A21ezSCOzP8DLw6vBSXu3MmxI9am+/ljAQ3gwsg0vhpbcubWcBrNmDzCW8Avf0YN3yEn4QmorZbyNtOuHdm3RYEpe1YjTl5VoU7qa6VVKK5au4WyNBRpdzavXnVdDttutESwa/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2GX8W6J; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27051f63018so733925fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724967637; x=1725572437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz6Dy37VCv1sN/3hRrn/LM1TxSOkjRrN0Y/enN2q/vQ=;
        b=B2GX8W6JyVK6yp5Tq+YUnNYg0bv1yeJ2A3iBymIFai7G5/YG8wFKU9jLm0w3W6FWGb
         ZeI08e/Hkpo/b7jgfb/eko/ZFlJKp8rfCN3P0OLiKbC+vizrOFQEKXbk0ZM47c4cBnnm
         VC//UJVzJPl4wiz6UGKpMaWCJuD34So2iPykJiPYRicOCFFbd97Yd8Rk/TvD4YTKQ+z5
         XkrIQVQ/xjeVEsiX3U0AqJvX4aBDt6CWICqOHZaeszNaxSqBA55Cxpa9dX+qVASzoLsb
         PrA6csOULrD7arX9z0VwwCVXNB+ELizG7p1a7YrGGStmj/vpUQP5E9npf33ZMMgobr7N
         4axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967637; x=1725572437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz6Dy37VCv1sN/3hRrn/LM1TxSOkjRrN0Y/enN2q/vQ=;
        b=e5sqEW7Io9ygmVJxlDl/uCiNOsAZCwt4LGk1C1RGkm2OTmYwqM9gZrBVedbfWLMjm8
         oWLB4UNfObBXElSqZNcPNzZXxcmGeI5z3RM0ZcZjlza2dhShGColVE5aFP/YbLNjrpKE
         yeIDJFypsxIW8aAHenV5a2XGM/HpPucioB9gNUh7XfgqyYIvBJ2LSMUfIizOe03d4Nmj
         a5OshNUHAFXQ2ITXs91tdznEG8UJviwgDI6SOVgNB3rGCaNM48ixsgeqTvgAmHbL1fdv
         Cc8Xl4q4YQgCZKT+sxYg1AV3rD9soCabIdQlbhbbPln79c7l0eOxg4XyQdcBhK44KTuv
         qVNA==
X-Forwarded-Encrypted: i=1; AJvYcCV7jwmBjSeKXvJ7jUQRdeimTkrAdjlIgnOuv36EbSRlgG93lFjwkta0srUJy1syk5siRJgg6S6efsVs+s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBMBJEu2jh4DJbwj9tY6nYu41XflI2PSdxCdia/61YO5YZIz7e
	y3c6sjBcR/pU6ELtvFZxtXtgnoUWtSyvCi56EEMKDw9wazL5U0FM
X-Google-Smtp-Source: AGHT+IHwNTYA1EbM185xeo3YV3aR7BQP15rLTFxPgrpH08ju+uTm5zEA3NlhSBPILdEG4y4/FqZBIQ==
X-Received: by 2002:a05:6870:fba1:b0:254:b420:5ab with SMTP id 586e51a60fabf-2779007556cmr3808030fac.8.1724967637637;
        Thu, 29 Aug 2024 14:40:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:4b0:1410:400:9408:c7b2:31:3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e742ca0sm1480841a12.7.2024.08.29.14.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:40:37 -0700 (PDT)
From: Gabriel Tassinari <gabrieldtassinari@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v4] staging: rtl8192e: Fix parenthesis alignment in rtl_core.c
Date: Thu, 29 Aug 2024 18:40:31 -0300
Message-ID: <20240829214031.4893-1-gabrieldtassinari@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix parenthesis alignment in _rtl92e_qos_handle_probe_response to
silence checkpatch warning:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gabriel Tassinari <gabrieldtassinari@gmail.com>
---
v4: Remove line number from subject
v3: Adjust the indentation by adding one space
v2: Include the modified file in commit message
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ad21263e725f..75192041008d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -322,7 +322,7 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
 
 	if (network->flags & NETWORK_HAS_QOS_MASK) {
 		if (active_network &&
-				(network->flags & NETWORK_HAS_QOS_PARAMETERS))
+		    (network->flags & NETWORK_HAS_QOS_PARAMETERS))
 			network->qos_data.active = network->qos_data.supported;
 
 		if ((network->qos_data.active == 1) && (active_network == 1) &&
-- 
2.46.0


