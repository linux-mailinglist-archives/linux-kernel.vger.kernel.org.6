Return-Path: <linux-kernel+bounces-326117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7DB9762CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FDE3B215C5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F5618BC39;
	Thu, 12 Sep 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7fqXDaA"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109F18E346;
	Thu, 12 Sep 2024 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126572; cv=none; b=XCc2LE5ME+Q/VoeH2HKTikTABXdyTbiRQu7LhHAkFYyFA/rIBwaASlGAJBNkdWUBIhBngwE072T1QCNL0vKo3xLB71S6Tb8NAA2guXrFpl2gEClJm5Ugbqb6GKx/eQrgUNoqO0pBUPdXlO1DdMgBxEWglZ/9O+NPK9xfW3Vsizc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126572; c=relaxed/simple;
	bh=5rev4I5bo5C3iXDhlvBIqZuRxVvPrrbxpZxHrwuQb44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6fyKRXbePUGMQU+/nAQsg0XeTlwpbDaTCE62bnyi1+n6wAp/QoboaPnYX+XzbBkhfQKWMNlMWqYHqKDhx9tSfle0kbCoqZQBEu2WPMGUIggY71ZQxWNT5XCD7wObLU3equewGCRfOFP73+B7waF1MtOmwJBdt6BO42wWtnw6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7fqXDaA; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so600276a12.3;
        Thu, 12 Sep 2024 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726126570; x=1726731370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X3MfHhmi5C2bWV1uj/b4rUQI6Yupm80M+TE7ZDCDw+I=;
        b=h7fqXDaALYwLcf0A3zFHbXWxlyc+5MnFqewIXSTrpXIhJa8OZ+8DdUAD2DmQYtCm0Q
         +tgTUdglgffCIC6pVHIexdIladzrBMxRQAbbznVZ1qMr45dcbBsMEirg7tq9oKmPfJNh
         4x8+w/fC6NDnGvRHXqPghk3T7vj4r6e6VDLY85O+I+EHt65ptZcYfxJc+Iq2g+h5a2UE
         sLwvdOk94MEFcOiIUMaELxdNvmx18ItuAyeDRcDlCdaGCAOX1GdokPIJhB+yeiVknd8F
         lG/XH0YFt/I1Dc9o5E5J0SufeI0ClSLVskUrT2i4aIFjo/Wbg3SzpnyPz7jJVoXK1S8R
         7DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726126570; x=1726731370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3MfHhmi5C2bWV1uj/b4rUQI6Yupm80M+TE7ZDCDw+I=;
        b=CiEple8fFjb7TKjrCSDg7zq1+g8FKcDtg4Wgfo8V71wQCeL/qbPcH3eoGYKqPsY3xG
         o7sABDb91ovurWUZ9mUqGIwjXRBjZ86eV7kOR0SVt0DSY/3HVl/hvmuQ1LADEe5pvqJF
         sTwhTUn3r5y2EfafZpMh0sMMumVHiAs6bEf1+7IkGjt+A+l/kQogr4uhDqI7HK77pkE+
         s0QP3SbLlEaSvggfX6Y7MisDTXLP/rypi769DPjYQneeKOhyJ0mrn/1f+uK/5Z9p1DGX
         FAJpS1qbR2lk5SoyZXfPRwRGin89zC5Ss2Wp/3z1+ewkw7GeR37PirjXog7hAAW6UZKs
         ZB6A==
X-Forwarded-Encrypted: i=1; AJvYcCU9cKGtGyE0d+IkgIHRt4uGdWL7hGsJVbaxIaYGQnqdIbsYr+EtsvKykJQrIathGJuEyKxiWYXehHpb8t4=@vger.kernel.org, AJvYcCWbyuJWn34T5szSAZqiSbKTU/TvYlIz5LdzXlSYrS4q9b/SsABCmEkAV/LAEtYMPOG+g7fRCSYQY6l1Cg/WjoRQv0dxgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlI6jzfiqk7UrhaSCYJPX6RbyA1B/NPvk/ULEk5jaYZG6xKw6B
	Dh6iYt8uaUsRkBjNVq6OnGS87E5Bqe0DOxZ8S36byWGqKH7C+JqwbhnrBGuz9aM=
X-Google-Smtp-Source: AGHT+IGj4RXIhCYuVDwgDRPK2/lhL36yq7XUG05e54IImAjGGQ/PnyU5u47LFMzwQeoCGzNXKb3W8g==
X-Received: by 2002:a17:90b:4a4a:b0:2da:7536:2b8c with SMTP id 98e67ed59e1d1-2dba0082fecmr2240278a91.36.1726126569954;
        Thu, 12 Sep 2024 00:36:09 -0700 (PDT)
Received: from fedora.. ([58.246.215.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4b41sm11921403a91.8.2024.09.12.00.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:36:09 -0700 (PDT)
From: aln8 <aln8un@gmail.com>
To: Shyam-sundar.S-k@amd.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	luke@ljones.dev,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aln8 <aln8un@gmail.com>
Subject: [PATCH v2] platform/x86/amd: pmf: Add quirk for TUF Gaming A14
Date: Thu, 12 Sep 2024 15:36:01 +0800
Message-ID: <20240912073601.65656-1-aln8un@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS TUF Gaming A14 has the same issue as the ROG Zephyrus G14
where it advertises SPS support but doesn't use it.

Signed-off-by: aln8 <aln8un@gmail.com>
---
v1 -> v2: Change to FA401W so full series models will get the fix.
---
 drivers/platform/x86/amd/pmf/pmf-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
index 48870ca52..7cde5733b 100644
--- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
+++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
@@ -37,6 +37,14 @@ static const struct dmi_system_id fwbug_list[] = {
 		},
 		.driver_data = &quirk_no_sps_bug,
 	},
+	{
+		.ident = "ASUS TUF Gaming A14",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FA401W"),
+		},
+		.driver_data = &quirk_no_sps_bug,
+	},
 	{}
 };
 
-- 
2.46.0


