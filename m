Return-Path: <linux-kernel+bounces-219484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FF90D347
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D62D28461B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE1716CD27;
	Tue, 18 Jun 2024 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ED+Mf5PM"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E5416B387
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717877; cv=none; b=iSC9nMa9LQkOSb7LRke99XloVidJoUqKP/D48YPCIyLvF8I3oz5gt5yI4MQn+SmIEV2vLYwAy6T3po59IH0D5xFAzGPbOZ6kM92FAyi2/J6+J4aFf3i1vxo5LLvsqp766Lvlhyp4Hm6wzUl2xoz2IVfcbkCEAUD9CXJTyaacekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717877; c=relaxed/simple;
	bh=Kx34urW1bu83x+FpRH2PjWtCHfI81fNXdP9esvIj2lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NF338OHjeISWKy6xRXyVcwscuJYXUsFHothut4hjqkfFggSDzs9bEICQqAmzQ4+5K4FK8FBqNupcM+mdoQSYmnzima2+fnaUPAc2jnOoYocOgEsj04lmASp+oYdKStLwerW9ZJthokbRUUScZGK9QPuvyCzwaoERJ1JEIba92YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ED+Mf5PM; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80b821f3dd6so1380510241.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718717875; x=1719322675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSxpnRMMBh3XAQOKvAUYOjxDrEUAAE5bMiw0Qh3Ul94=;
        b=ED+Mf5PMUM9of7URCeAn7RNQyecPKy1WZT9ZXXKfINjlYKnJS4TTjPujbIoucX9y9v
         rIkowdH+aHrbVgCph+ZcuOjYR8l6lU8OIhUB0z1AGCe1G3zqPXcP+oeIdo8n8pOHUUJ1
         5lmFQ6fRFXcnZEKnN2BqIsojaiULo27kjpej8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717875; x=1719322675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSxpnRMMBh3XAQOKvAUYOjxDrEUAAE5bMiw0Qh3Ul94=;
        b=G2eSCeMHYxvpdEsF/8H8ikjjBhqmDD8D8kZweCQL8PmkgBItyehCSQraVLO+LZG52d
         JHGxgBXpPTq/UmjAqErKtCHRc66mdktW7IXt/BUmW0kcQen6ycw/gXL8cccgbaH/V3EC
         Agk/ScZs8QPYuLWS267mi69wF9+drgzBNMBIr3XNyeXSvqqmIZCq+I3PsQ5g8XVPnSIC
         /CoiQsHWe3e+BgrZKqpMna7r5aBK7C6anNrcVO7x368xezlK08KEBWzsLiJ8w2wsHrgD
         4sdXOmXS25eNyV7IjrN5afvJ4B4LBNnssOWAnz6UhUHYT438yL1etNID/WSXEQn9LlAp
         Hj5A==
X-Forwarded-Encrypted: i=1; AJvYcCW6u6xqAfd2hncrVECW7sUg2cSbDEn0ql5hc85xJYOnSt1cVC8pl1kicOBGDhjEhZRjFtos6TkYMMKzhPiJt1EJ+iIffdYzX1OTtj8J
X-Gm-Message-State: AOJu0YznzE6Ov/tYKsGg+mKkvgtQqgmNsji08CltfVtHQmJo7+YaOq9i
	/05mCO+ozcZNxzJY9OP+0rmnnuFpjiB5SgjSITmGWuNsBtfsQzkb5T0dX5ic6Q==
X-Google-Smtp-Source: AGHT+IHAODVjmf2y7hxDr47vyEGKr+vtIgOCrnudAO3YuibggEVox0Hp/ospxqFRpHhKmeRWGN0DcQ==
X-Received: by 2002:a05:6122:c97:b0:4d3:cff6:79f0 with SMTP id 71dfb90a1353d-4ee3e9808e5mr12164963e0c.4.1718717874707;
        Tue, 18 Jun 2024 06:37:54 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc06e93sm521666385a.82.2024.06.18.06.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:37:54 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 18 Jun 2024 13:37:47 +0000
Subject: [PATCH v5 04/10] media: venus: Refactor struct
 hfi_session_get_property_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cocci-flexarray-v5-4-6a8294942f48@chromium.org>
References: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org>
In-Reply-To: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The struct hfi_session_get_property_pkt is always used to fetch a
single property. Make that explicit in the code and avoid a single
element array at the end of the struct.

This change fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:194:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 4 ++--
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 3418d2dd9371..75f4a3d3e748 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -402,7 +402,7 @@ static int pkt_session_get_property_1x(struct hfi_session_get_property_pkt *pkt,
 	pkt->shdr.hdr.pkt_type = HFI_CMD_SESSION_GET_PROPERTY;
 	pkt->shdr.session_id = hash32_ptr(cookie);
 	pkt->num_properties = 1;
-	pkt->data[0] = ptype;
+	pkt->data = ptype;
 
 	return 0;
 }
@@ -1110,7 +1110,7 @@ pkt_session_get_property_3xx(struct hfi_session_get_property_pkt *pkt,
 
 	switch (ptype) {
 	case HFI_PROPERTY_CONFIG_VDEC_ENTROPY:
-		pkt->data[0] = HFI_PROPERTY_CONFIG_VDEC_ENTROPY;
+		pkt->data = HFI_PROPERTY_CONFIG_VDEC_ENTROPY;
 		break;
 	default:
 		ret = pkt_session_get_property_1x(pkt, cookie, ptype);
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 6dff949c4402..f5708fdfb197 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -191,7 +191,7 @@ struct hfi_session_resume_pkt {
 struct hfi_session_get_property_pkt {
 	struct hfi_session_hdr_pkt shdr;
 	u32 num_properties;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_session_release_buffer_pkt {

-- 
2.45.2.627.g7a2c4fd464-goog


