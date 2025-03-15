Return-Path: <linux-kernel+bounces-562550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C1DA62BB6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 12:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE2A47AC400
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2140D1F76CA;
	Sat, 15 Mar 2025 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoi92MUz"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058E133987;
	Sat, 15 Mar 2025 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742037408; cv=none; b=lexkGarhtV66gAWAI4Ej/muyxhAmrHF6EQrszW7AhNBkZ2qsOQqSNUtBHHSeRCV9vSgmA5Gz2+uHU4k7daiSO3ufeLKLowalUL4VAmpccx/g+t4wMCUjMFD3EYw7LvX2VKr8NomsjhyCZHcIz9+DdMg6N8x43yp8jrtiPp0Ti0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742037408; c=relaxed/simple;
	bh=O0XKV4TCIzupLl/wP4TiJR04cPO9HQyseHS8TEc9lo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kYyoQpGGKmhKU2h7XqIzcBv1LUZNHSMx4qJKzNI8kQLdBGAipHY4ezSXUYydxfve2r6V+I0Lpb3jR6xs47C5TRXiHJsmzIVMgO4N62PqJ+fx2oXj9C46mEQuSOzhPg/by0Av8U8nsIf7y2O8VmTtGB676jyfCwNJ8nOhCXFzzf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hoi92MUz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216513f8104so6263185ad.2;
        Sat, 15 Mar 2025 04:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742037406; x=1742642206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WecbUE4xProJEd8XgKN6I8pWdco/eyfiW7vf+WpwRx4=;
        b=Hoi92MUzdVwmhtcMrtUCxeuC2sXPFEPw7y15qXibIH2/FDgV+J2j4DcSGmu51h2HN+
         0UK1xG3tpN8zvfyWHcJybhh5jZ4TaMrymu+bDP+orstCN9MSHLOVX9to8aW4DNcA2H1N
         woYwVR5eKni07hV7sihxhcxtWbipomixCmXJSTjVM7Umhi7QGH5LnPs+rMYTwFVcthX0
         O8CjB2+AAHm2fkQYd84ilGeHteUYNh/IByHFPDseS8BOt1qwIgDIIydGagVPwGBcVoi8
         2OhtQt9HIjF0HZTxp9ZQcWMUkhUG9DU86t15GRrMV6rZ6IjaAsHdpBCcGskYB4HGLNGA
         1UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742037406; x=1742642206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WecbUE4xProJEd8XgKN6I8pWdco/eyfiW7vf+WpwRx4=;
        b=O+r6qiWzh2JvmPUDrS4N1nq1FhbOmQcpJOc0F6G9tYqDT+nwIdWMfqU8aa2NYeoyak
         1/mfy7n2tLTPwQHVH4W0r01PtC9/RKWhgUV79iLRWjylrGo2ru0/EFnWcs4ae3V74it4
         BHR6GC8GpjxywALHxVU9nQHzTuVgIkQXPkz63t+kqQuM+EidUxz5hxMwV8VqXRg095uH
         4Eo06UN8roMqDrhU7MXlis98egJxSZIcCDPehkth8HIPO4ViExs4NH9qir8c8te5iCVT
         A7gy6nj4/4s4rFeBuqslv9eJ4LbgXTIVUHTZzVfgRDJuQEP2MyxC+wqjKN50hZp5vlrq
         nyhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSWdgBBsinahCPete8zZOItiUnrnNK5Hlvonmf5abhS4jhKVj1vPtyi8SAgXSRHA16zMMJcwABT3qxTuM=@vger.kernel.org, AJvYcCXjMdleZmmmbEwRlhHXy5leEh3Wad9TITwv4swEdceHYdFISLl/Qo/kSNaDZpokuZTyGwM6nVSH+ZHNm6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2oUMobchtjl5yAGINPfyns31H7WR/lfzuSBO2cc45YsHq7Qk6
	zgeYnUkzFLFWDOP0R8Lc2ga2SSG8pMJ30KvXlEUsNmErnLHnCCgDSKfeFiGwnxg=
X-Gm-Gg: ASbGncvjQxHQ+OW6jIk4KdVASxjeLlHIvqgHMGSa06YBCTMsRY38ABnKY3ivv0qCMy1
	qN+6YKhGlBfJe2dm+3RSKM+cgvlh616VpftAQgxL1FOISsqNIu6L16pl5+LjkP9w2o8Y5pVw1Oi
	/m7Er6BrILJybaFsV0WtgFrIAe/NIbnOkd6nkV9ES4Jkab9TgheY6sPBkjYK/rLOy+MERrvphNu
	RFMmdiP2WGhSz5nB7zkxXVSpqYA5Br/buEeDz6VykVXtRBBqPWfSAu3lSkScJLEBcHH1fo5TGWM
	LaEQJ4jpYCGR5Y3maCjmHi8m9lnQq9UyzwkCtSHSpJKL
X-Google-Smtp-Source: AGHT+IHc43b/5PK1wY01B7EXa9MObOVfpQcrp6YkQQcyJjFyHk29utlsSzj/tGqVxHtsHjGc8dHcmw==
X-Received: by 2002:a17:903:1207:b0:224:252c:eae1 with SMTP id d9443c01a7336-225e0a666d3mr28172685ad.6.1742037406356;
        Sat, 15 Mar 2025 04:16:46 -0700 (PDT)
Received: from knplfy-pop.. ([136.158.31.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68886a8sm42776775ad.44.2025.03.15.04.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 04:16:45 -0700 (PDT)
From: keenplify <keenplify@gmail.com>
To: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: mario.limonciello@amd.com,
	venkataprasad.potturu@amd.com,
	lgirdwood@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keenplify <keenplify@gmail.com>
Subject: [PATCH] ASoC: amd: Add DMI quirk for ACP6X mic support
Date: Sat, 15 Mar 2025 19:16:17 +0800
Message-Id: <20250315111617.12194-1-keenplify@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some AMD laptops with ACP6X do not expose the DMIC properly on Linux.
Adding a DMI quirk enables mic functionality.

Similar to Bugzilla #218402, this issue affects multiple users.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219853
Signed-off-by: keenplify <keenplify@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index a7637056972a..bd3808f98ec9 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -584,6 +584,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "pang13"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7UCX"),
+		}
+	},
 	{}
 };
 
-- 
2.34.1


