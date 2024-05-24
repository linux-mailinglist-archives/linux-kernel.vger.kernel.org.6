Return-Path: <linux-kernel+bounces-188730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED78CE609
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6553A282EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CFE86ACA;
	Fri, 24 May 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZonWxfb"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28C127E12
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556800; cv=none; b=hi+jP6/a2UUaBDtrvoj7odlaFpfZeTP8eoswk7QMYp5T4XGav0Uwfd30UQAhKcNRm3y7CxQfehfVn32bRTk7+TR6fj+5F8HlNGmKuJeMX9myceNOKCNgTsdqcjeeIWyHxvY/qcDqQSPO/BmvCD1VVzjbnZBHVBCa9vn52LCsiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556800; c=relaxed/simple;
	bh=SCnJNIycjKCOU6+DbbjFa7Anywkc1It7tnIXU4WQ6yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EGoWWEt3HKWcBNxsv/X1R6clp40oNLdAnEuRGtfRLwN30b+4bKLGGW0UHx2pjBb72pmEtjqlxHzmqfIBPoKqausDkF0O60TCNFldpVpBo8Y2ly7dKdSagSTQMviNqUhz/x1BKICD6x4z3BO9jinhURlRaA4+BpvJT6kAd+wKyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wZonWxfb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f850ff30c0so1473305b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716556798; x=1717161598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhL1+y0kIDyt6L6HzzdKzEkTEMOaNifsp3D2+XHrbto=;
        b=wZonWxfbanUbP5R/j/A0E/+Szjpw8JjVCWYnROa703BLjkBzVng2Wjubq13ngD1Hwk
         Oy/qcoLpPKhxSODjORfPkVBKeZ55QnhN8YE/I+TNRDHXPZrfa+neJ3nqMlmKXK7kLz3H
         KIOE+OhhyNP+dnnElhel+gkdkKnFBNLWIlrOpo/hS0wW1ADjj2NeVEk0FAyLFC/9AjAp
         D3xkQNhOp4mrgTCuGs4d08jkLmDdtjR/6cZHmX6SPCC+Lzj0Eihrx4MNTSEZgGCkS1gd
         S7nWhkavXzjIc2Rqi0azMkbiyDEi8/ybE+VOouHfeFsFUNTCdxyBJinHIYWObyj1BNpD
         sSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716556798; x=1717161598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhL1+y0kIDyt6L6HzzdKzEkTEMOaNifsp3D2+XHrbto=;
        b=XAXxclIK6xR1CsJkcVBx3mDWlHCN1xT3KJv78On+H19zaYwZJoRj680E0FMgdRRSmx
         ccl+KMXR2Gx0sn0g5rr+24cTlWTqbhRPXky35t32mSkAyV7q1+D87UxtYyDzM/kN/vQW
         ojlW4xSm1gfeRQKR4k20wbJD264m9Y/YfNUkrItXoIBdmiaxyLJgRxzo/EzdTTVCSdst
         49xMeHNJtejFlf0EbZYR8vhC5V4mUXAr94kNExnxT4DkeC32I8ScX/XqygepxldTkwvb
         TTRCfS8A22R42b1WuotqfWRO3rjwpglwdJKwTgdI9iooFZcXx5p4IYTAYplrrTASJQIW
         cgkg==
X-Forwarded-Encrypted: i=1; AJvYcCWs+qqO70dYLS60fs5b4XRWU3ScJHx7/aBik6MVaWQZ2Tj1McbmLqyOR4Qb8yKu2JZ5ZaXkiIe1f2ci7+zwAN6lOrPMNKZoN4jBWLD6
X-Gm-Message-State: AOJu0YzTbHJ5BV5TWhR24LsUzgg+a2NQqgxB8teQtobk3OkAh3OR7Dln
	RRIxOscv189W7r67CTc0xvp1KP1bIMY+ks9vLeP93diyRMMw2MsL/qKh5wPV82JwdRdAGC+8XVw
	Hc9EtWw==
X-Google-Smtp-Source: AGHT+IGYLRLvRCV0D84/IopEephkJQILPn2RZgOVI7Q2aoXRtKdZHxZWVGFZ6JlmgNMpYIqoXVs6Og==
X-Received: by 2002:a05:6a00:1c83:b0:6f8:de0e:cdbb with SMTP id d2e1a72fcca58-6f8f33b05d3mr2189694b3a.13.1716556797922;
        Fri, 24 May 2024 06:19:57 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd2d492csm1117852b3a.179.2024.05.24.06.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 06:19:57 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 24 May 2024 21:18:22 +0800
Subject: [PATCH v4 2/5] drm: adjust data width for widen bus case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-msm-drm-dsc-dsi-video-upstream-4-v4-2-e61c05b403df@linaro.org>
References: <20240524-msm-drm-dsc-dsi-video-upstream-4-v4-0-e61c05b403df@linaro.org>
In-Reply-To: <20240524-msm-drm-dsc-dsi-video-upstream-4-v4-0-e61c05b403df@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716556778; l=1081;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=SCnJNIycjKCOU6+DbbjFa7Anywkc1It7tnIXU4WQ6yg=;
 b=sEk66AQRqgPYNGk32xeRrchV7uu3ZrAvWWbJGODk/QYBOrByjanPmW9jI9kFbdWwYSIY0ltA5
 ap1NVCxK4ZmC3cS20S2Fl9I7yKwSQ/K71lMWsa7FlqkOWVPHREINtdu
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

data is valid for only half the active window if widebus
is enabled

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 2cf1f8c116b5..3d1bc8fa4ca2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -167,6 +167,14 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *intf,
 		intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
 
 	data_width = p->width;
+	/*
+	 * If widebus is enabled, data is valid for only half the active window
+	 * since the data rate is doubled in this mode. But for the compression
+	 * mode in DP case, the p->width is already adjusted in
+	 * drm_mode_to_intf_timing_params()
+	 */
+	if (p->wide_bus_en && !dp_intf)
+		data_width = p->width >> 1;
 
 	/* TODO: handle DSC+DP case, we only handle DSC+DSI case so far */
 	if (p->compression_en && !dp_intf)

-- 
2.34.1


