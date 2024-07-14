Return-Path: <linux-kernel+bounces-251946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACE3930C04
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 00:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40F22814CF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202BE13E88B;
	Sun, 14 Jul 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaazSMqC"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F213B5B7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720997636; cv=none; b=jtWHdQF6qclzjfex2YQobJw1nE0SZLJM+jdszGnVEweoVb1jBkwU0/RkfFTnL2Vs3FM8H/gj2CGRsw4wBcLzTGmwCgTwkLco4TcMyTu1K4hDm277UeaVL3NsT6gRYS8DUbXsgYO7dIRFT9iXrDBaGNnDdD11eWJwnP8E2tFaUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720997636; c=relaxed/simple;
	bh=iYI1KOvw94wnIMS8FI79AwEMjOsLCg7Kzx1l6dqHV1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uHrKyg5Fe77dpjDishJKb9BNc0w4bGubczAZB1LXnjO/sAYiv/bsss7gdyPoSWzP1KgfKq2wtK0qJe/5nb9gLf0rvHdLfphuJhd34vNhjHohrzsw7CZZU6ZtyRFDwCRsefJgwSx0Nl00Uc1W0vzlf9n4FThHEBTQdp9ipLQLD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OaazSMqC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427adb1cf75so3079545e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720997633; x=1721602433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI2MH/h15Gsz7mc65cDWKHx+IlGAYagBQoxwo/Wd/mo=;
        b=OaazSMqCQ3NoXH8qDFtsCOazI24K+V8nKDEv/GnufbXMvp2kv58Yen8Z0scXJXAzsr
         xH4BuFh5on7DXpqXI7tSjgYq20xXd3LksUpvU3HUTKK7k9ob7anVAO2jJlJ6xn5GdEM5
         o3akeyHxPnVEgTZsEugLp0cKIjilsawU80/xSz8yJ0afCAqwddz6HkEbPt+C7h/OYlkz
         bCXh/JsuYFNbKjbyTA4Nvt122ZxGOUWVyg0SAeo40Eq28I/kjqf8pgIwZ5jd2gJ9nqw+
         ZulSH91gmzYN1zfuTt+bBsWyzMfJMNFmZ586PBzE7NYeipJvTUpkv3aeGhf4E54kKQET
         LEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720997633; x=1721602433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MI2MH/h15Gsz7mc65cDWKHx+IlGAYagBQoxwo/Wd/mo=;
        b=SsC7Z8HbEM8/0/VyEVp1HlNNqH+v37JCROQaJK0gTVy3B8Ya8qgryhBfgAnoeoT5ca
         YjyuXpyc+Rv36Z9AhqIZkcHVZiCe5rR927etr3b9RPqxumjp56QfRtVMvAg8/m+lDBO+
         cqArbUd+wQVIXA1mnm1D80OK3o0+443kabWyeDQ/LxDSINptwAT9nr2bJ/G3EiuaJSKx
         rlOSDyi4ciCwsu4JrfUG89M+anj0hJvK23cOh9TBXX5yAmFu8yNThhX+RwR2r26fS43V
         qhbZhYkH3n/F7WrdAGss6md07n1gTq4qfzD4URmAP9izlFJlw6sX7cDGLcNyEdt46TO9
         8WgA==
X-Forwarded-Encrypted: i=1; AJvYcCWcH+ntTaAXCbcqInc9SF0zQYwsC8oSSMFY3f6uOgoC/Rvykde4M8MTxTpxOmq1FBb0VcuAnnBRjxi986jJPfwFu6jehRgiv1YQ5d4c
X-Gm-Message-State: AOJu0Yzo5RcLReryHy0n1J6WnzwUCN3o51gkcDThZMTvFkDgiJmaSQ+P
	/X8XDFJK/6BoR3HByuampZAl5L2clx8mRvtuQOMIcDxy+EeKU17fPCR0DRU+ZUs=
X-Google-Smtp-Source: AGHT+IEysSdUKxeJskaRsDHM4PnZM/pkXEmRsm6QU3mdlwpWsYGntp5CbVnOrGZjCgS2SX/mqCIDbw==
X-Received: by 2002:a05:600c:1587:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-426708f1df1mr137832735e9.29.1720997632879;
        Sun, 14 Jul 2024 15:53:52 -0700 (PDT)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279dae34casm40632445e9.0.2024.07.14.15.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 15:53:52 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Sun, 14 Jul 2024 23:53:58 +0100
Subject: [PATCH 1/2] media: qcom: camss: Remove use_count guard in
 stop_streaming
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-linux-next-24-07-13-camss-fixes-v1-1-8f8954bc8c85@linaro.org>
References: <20240714-linux-next-24-07-13-camss-fixes-v1-0-8f8954bc8c85@linaro.org>
In-Reply-To: <20240714-linux-next-24-07-13-camss-fixes-v1-0-8f8954bc8c85@linaro.org>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hansverk@cisco.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Milen Mitkov <quic_mmitkov@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-13183

The use_count check was introduced so that multiple concurrent Raw Data
Interfaces RDIs could be driven by different virtual channels VCs on the
CSIPHY input driving the video pipeline.

This is an invalid use of use_count though as use_count pertains to the
number of times a video entity has been opened by user-space not the number
of active streams.

If use_count and stream-on count don't agree then stop_streaming() will
break as is currently the case and has become apparent when using CAMSS
with libcamera's released softisp 0.3.

The use of use_count like this is a bit hacky and right now breaks regular
usage of CAMSS for a single stream case.

One CAMSS specific way to handle multiple VCs on the same RDI might be:

- Reference count each pipeline enable for CSIPHY, CSID, VFE and RDIx.
- The video buffers are already associated with msm_vfeN_rdiX so
  release video buffers when told to do so by stop_streaming.
- Only release the power-domains for the CSIPHY, CSID and VFE when
  their internal refcounts drop.

Either way refusing to release video buffers based on use_count is
erroneous and should be reverted. The silicon enabling code for selecting
VCs is perfectly fine. Its a "known missing feature" that concurrent VCs
won't work with CAMSS right now.

Initial testing with this code didn't show an error but, SoftISP and "real"
usage with Google Hangouts breaks the upstream code pretty quickly, we need
to do a partial revert and take another pass at VCs.

This commit partially reverts commit 89013969e232 ("media: camss: sm8250:
Pipeline starting and stopping for multiple virtual channels")

Fixes: 89013969e232 ("media: camss: sm8250: Pipeline starting and stopping for multiple virtual channels")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-video.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index cd72feca618c..3b8fc31d957c 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -297,12 +297,6 @@ static void video_stop_streaming(struct vb2_queue *q)
 
 		ret = v4l2_subdev_call(subdev, video, s_stream, 0);
 
-		if (entity->use_count > 1) {
-			/* Don't stop if other instances of the pipeline are still running */
-			dev_dbg(video->camss->dev, "Video pipeline still used, don't stop streaming.\n");
-			return;
-		}
-
 		if (ret) {
 			dev_err(video->camss->dev, "Video pipeline stop failed: %d\n", ret);
 			return;

-- 
2.45.2


