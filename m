Return-Path: <linux-kernel+bounces-191435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997A8D0F22
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84828B212C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A52616B752;
	Mon, 27 May 2024 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ldcn5YN+"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1616A389
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844148; cv=none; b=OS+dPbAX04NkoMrlFTghOjr3ET027esgnHWr3/7jAFzDs3nv+2uPKivjOmzS7CuITbDAUbo3dKJtl0WHw+qPD1d8GFxByCg8uzDisqXS+yMPqpm8DeJLHg7Z6ETf62bGwIfS0p8aToAXZB/9b+B8qMs0axnQY5CqoxwyGjiPYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844148; c=relaxed/simple;
	bh=Lq1y0c2FBMWDMcJqNw9gMzRU69b3LiN8MPGPGDiaNGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nRZa/rgrfeuMKb7b0mfTLPUUaM1dxt39Crh5eozd9TLv/7T1xCrw+uAl576UUpklGIwz3LNszYJGGadIhq9posI725Dm2Z9+tyIcFl6lFq6toRggrYSwgtwjmCN4/s4l8xvoNdDhr98f0se7HgHxFwXsqhcStquZ0/QwvHDIq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ldcn5YN+; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d1bf72f819so79199b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716844146; x=1717448946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umQqb6RnOEqhwSbkLr5UqyeS93yk9NUaTbaKND2fVbg=;
        b=ldcn5YN+T+padx88LZhTPymZ9qD94G8fcGOkueat89XsPBcyCT03mNbyfJ7Sk8nie7
         8UKz+3sSdTQ7jfjK6n0Eovf+S9AiBxZYXNe6r/WoX5OIv83wWkXRwJh3DxNSpbRigCME
         71/Rmk1SSYf5a9THJnACFYw2K6MmvYZXXZ+VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716844146; x=1717448946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umQqb6RnOEqhwSbkLr5UqyeS93yk9NUaTbaKND2fVbg=;
        b=IbTMfKYr1NFNHlClA60BAnkfGhK0gehGWZYuU1imuqipuvSjpSLumV361z8km/0rxS
         vcPL+AlPjn3BWoIBMC35Lxh1weUDdHYmq37ldj0W58I12N79Nwm2c1qVcagJuho4QmhA
         MTw555aYRDZDtQGikV7R+/jgt6e+KFv9GW4wRvKdkTWjjVF1lBGBZN3nU9kyn57KHVpr
         jSfQXMfoGoGRtun9w4GvxCa/gO6ZipKTx8BzSJWj1MCfuAB8ZW6h4gl9uUgi9s0oFf9w
         6LV7jbQLn9qY5XYXflm7WzIhLISqNHI+39YwhlxR7/fDjUuDv5zUbBn9+BC0TCbbRc5B
         lRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAdz2GStMZFcM0HQtjoPFDzypqbrlAytOsGdkcuSfH2XDrKDzlHsacw6u2mOd04EVpX16+UUXevHzy+6toDVUiwjJ/zro7DyUux+y0
X-Gm-Message-State: AOJu0Yy73RVwHxyV1gWrxphjDd3kvR7UBPm4f7vs5OeKokd4hL8uVbS0
	gnBJZ+ZWU9wGlUP/tUVG6+rPrFmP1wDechmAIA/T57F944eMj5VOBWrq2Eq/yw==
X-Google-Smtp-Source: AGHT+IExxy1NVsKPC20NN8GUcPBEpa+B5Qdfpnr1hCHN8PSGnu8BXMpCsdi04L8WrZaTqFEAL+NTSQ==
X-Received: by 2002:a05:6808:1a0b:b0:3c9:714d:cc7f with SMTP id 5614622812f47-3d1a745c6c7mr12813221b6e.36.1716844145955;
        Mon, 27 May 2024 14:09:05 -0700 (PDT)
Received: from denia.c.googlers.com (125.135.86.34.bc.googleusercontent.com. [34.86.135.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad850a6dc7sm9511866d6.93.2024.05.27.14.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 14:09:05 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 May 2024 21:09:01 +0000
Subject: [PATCH v3 11/18] media: venus: Refactor struct
 hfi_uncompressed_plane_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-cocci-flexarray-v3-11-cda09c535816@chromium.org>
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

This field is never used, but if we remove it we would change the size
of the struct and can lead to behavior change. Stay on the safe side by
replacing the single element array with a single element field.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_helper.h:1003:43-60: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index 7c0edef263ae..eb0a4c64b7ef 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1000,7 +1000,7 @@ struct hfi_uncompressed_plane_constraints {
 struct hfi_uncompressed_plane_info {
 	u32 format;
 	u32 num_planes;
-	struct hfi_uncompressed_plane_constraints plane_constraints[1];
+	struct hfi_uncompressed_plane_constraints plane_constraints;
 };
 
 struct hfi_uncompressed_format_supported {

-- 
2.45.1.288.g0e0cd299f1-goog


