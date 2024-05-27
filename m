Return-Path: <linux-kernel+bounces-191440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BA88D0F30
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7371F22327
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47141667C8;
	Mon, 27 May 2024 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YmT+Kdmn"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E15816A389
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844153; cv=none; b=McYZZYTmeNEX6O5p7dt08KDhcVDDYU3ZF9NwVnAr7AEsSWhi1IV2NTHZwHJ/lBMRxo0pWrRiNHj17MOEa1DxdiV2hMokfREHKybqKraXBeOSYkQkNJP5i+25qjPBW5iVkQODLvRGd96nFc8J6ygqzWThRSurYE8EfdlkpJtLEHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844153; c=relaxed/simple;
	bh=18CJ7PQ1lB0gUrD6RfVGnPJXBvr7tkb9/ypQsAIKU1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGopjykCqaWjCobQaLBaIf1t8ocWI5w0q1AJvBlLDjggRPT6lgqj0KmS8vhC2qnr5j96YzdMRuBg7EY6y1RAjqnlCN3VQ+98nOcp/ooAzNTzRP1YAfZowcI9EpNSSZ8zoO3Pny/5EGvGMWki0Gv5WBcGYiYBT0v0athwOcsE2/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YmT+Kdmn; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d1bf479c62so124420b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716844151; x=1717448951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsCOjnsdlcylSWUzXLRi2p9pLgCPEuJ2hVxyk0b0ycA=;
        b=YmT+KdmnTQLLAQZHGC+OuPtSeRLET6O7wwjdDAJm0akq+km0kzwcU6KiXZDABW43O7
         GgxhLessKLQP+7AlatVbN1aQj6GkBex0rTf904/OBmYaGMT4dj1BFkRF6fmlET6RRp3O
         sXduBIflcaHrTEaUg/9pk4Uesbd34ybtrTeRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716844151; x=1717448951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsCOjnsdlcylSWUzXLRi2p9pLgCPEuJ2hVxyk0b0ycA=;
        b=BUCsbMgMa5FfiMBFpX1EA8yGfh66gfTaC3VPKPjUgQIpBQrl+UObE0431Ft/qUr/qu
         gK+laeNbleoGMi0tJz4nvpNibGu5Up/vbf/KmPuYudWJ3djUXiAttF1mcBeytKT0GYvc
         lrVHzpdPkoc9TUdmgfkvf1bJcEbHM1cb4QVmWzqVn7RiW9/l04NV2h7koB7BSrjul/zc
         AcGOfiJbq08+KmfFFDK80puUcZLGFesamkR89f/0zbW1PipxlO0SEs08EoHQ6Zh1j29Q
         m587V+ODnjlPRNmQ1NzaSryEAwvyDTxxqzQa1oWdyQKSi7lmDNJAKR/Xi+5B4uuchxFI
         mZJg==
X-Forwarded-Encrypted: i=1; AJvYcCVAW9+NKpVT/vnqIByaQ5mw2U2jE7Zjq3j1BfDGG9IIEE+yE5XHL8qqOxM3/I8kqzQE9MzJOX5IY8MhIC3MwPD4v1M2Y+2H2psgj5Ew
X-Gm-Message-State: AOJu0YzA6S3+89BBzTUNsvWX6g2yhVogpPsjf28akSgp3ISkYfImr7jS
	HrAC3Hhsb4CEtxqzWf7TazMTPWQvooC3J4CNMPAAKZ5EFX0rAws4+Kt9IBl8/A==
X-Google-Smtp-Source: AGHT+IHc+u88l3NZeB3gMeItKSAdfjYaqVULR7KLH5vjoOvzDl4hgtgcjoAzsjlvxjTkKAMqrKZ/5Q==
X-Received: by 2002:a05:6808:1788:b0:3c9:c509:c17 with SMTP id 5614622812f47-3d1a4fb41d3mr15134430b6e.11.1716844151531;
        Mon, 27 May 2024 14:09:11 -0700 (PDT)
Received: from denia.c.googlers.com (125.135.86.34.bc.googleusercontent.com. [34.86.135.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad850a6dc7sm9511866d6.93.2024.05.27.14.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 14:09:11 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 May 2024 21:09:06 +0000
Subject: [PATCH v3 16/18] media: venus: Refactor hfi_sys_get_property_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-cocci-flexarray-v3-16-cda09c535816@chromium.org>
References: <20240527-cocci-flexarray-v3-0-cda09c535816@chromium.org>
In-Reply-To: <20240527-cocci-flexarray-v3-0-cda09c535816@chromium.org>
To: Michael Tretter <m.tretter@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, Andy Walls <awalls@md.metrocast.net>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Replace a single length element array with an element.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:77:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 2 +-
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 75f4a3d3e748..0a4de8ca1df5 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -156,7 +156,7 @@ void pkt_sys_image_version(struct hfi_sys_get_property_pkt *pkt)
 	pkt->hdr.size = sizeof(*pkt);
 	pkt->hdr.pkt_type = HFI_CMD_SYS_GET_PROPERTY;
 	pkt->num_properties = 1;
-	pkt->data[0] = HFI_PROPERTY_SYS_IMAGE_VERSION;
+	pkt->data = HFI_PROPERTY_SYS_IMAGE_VERSION;
 }
 
 int pkt_session_init(struct hfi_session_init_pkt *pkt, void *cookie,
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 2c56ae303989..f91bc9087643 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -74,7 +74,7 @@ struct hfi_sys_set_property_pkt {
 struct hfi_sys_get_property_pkt {
 	struct hfi_pkt_hdr hdr;
 	u32 num_properties;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_sys_ping_pkt {

-- 
2.45.1.288.g0e0cd299f1-goog


