Return-Path: <linux-kernel+bounces-225974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BCA91389C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DD81F217C4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681E12BF02;
	Sun, 23 Jun 2024 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGID1342"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654855CDF0
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126860; cv=none; b=o+tJGhKEX+9LZBBvuy4sjXlSjcsiN5B1HnDy1p2A1wHpp5KPlbaGHhc/FKVfi+WispR875/tCKtBKpHmyAaZJ5POS9krdxW7c34JokHtwCBmm4gT1/lob0rO/l5HiiTMypArllzo2zvUqnxS6B4gwJZTVU8RLMRTGzG9b90BpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126860; c=relaxed/simple;
	bh=sBSMtds6asx5P2qJBvmPM0qBKchY3X+LlgjBSPhuC74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLntOW0LvIghVaj2eWJmcKowBO8pQruXG1IsW+ZX3PH+NaZxpFzIzycR15/xO5JlDe96qtXZ/eOF03z1ZKSbYn5XwOZIWecXXt4ehuGcHfI9db/d1kDI2XvsNkJ2A8NkIDRjRaPwc3TeHVvZTluQq1qCcA6FOAIHwLSWVCyYaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QGID1342; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so38782021fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 00:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719126856; x=1719731656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2ZMLQFo4YvUdIspJItgGUAJ6rugpc8UkvKjlKE6e6U=;
        b=QGID1342n76tfKWVmD+wNJDjv7/UPE60r68RjhHMHvHSuxakZTWVtyVixkD8VHnAuG
         nwjApPfFzm9AzWYKxznU0IXCbApfh1I5yijWjipfoXWyNVSR1LMGyDmbMI0YcFjwdPd/
         O4LiL0dqZi59H05q7dcmtwh8zgr8C8PLlFPWRHcbXQ70Ixr15S1ASFA5KrqcexOKo2Xh
         B82Yye9H4N7IQJCmvFILoD9P/di8OhBlVAHWLSQloU9B/gFpxUnyLpt/xRavhOS28l43
         z7jX/9Ozn/aAelJCZcFIU0z+SqbYXhZHFZaBcQLtex89E3LS3dfYqTz57CzzkO1to7oy
         hdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126856; x=1719731656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2ZMLQFo4YvUdIspJItgGUAJ6rugpc8UkvKjlKE6e6U=;
        b=fL75V6v+OwAPkpAW5N7j+aPfckAfsZa1enDor2iZuyh81RSkO9QS98Qzh23D0VDPfV
         Z/oRIraQRZyPOcWCvYZYhNT/ako2jI/aa0Y7lXqzu8qNKqgyhxPfmil7CGc3EE9GFRf4
         WFQWv70pxPpcOoecO0eOmiQ8pgd4T70ItPtoJugcvlpbYii6wyud7Wy9xCUvVzLIGc1M
         GFQIz27YlfOY/Y2szURoqcgA5y3qurXXObzqw7ggJIip1sXUu1zq+yX7FQOJH1TNu7la
         NfLqMP4tdhXbSv2Njpowel3Xx0Q0stCaykDrGPzr4H9LeDdb79cia7a6nG6tpK5kEqZ3
         X3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXH9ooVqsLdkpmF2ggUVA0s/Dbzn2MlQa1y+Ya1wTgtO4MV8VRJVqq4MsHoDkE++xEtzpMEtl169dCxY3Ex33VR/8mu3m2jU+eUdsdh
X-Gm-Message-State: AOJu0YyDS4PIcIpWrE5EBnBMeUzj/kRGQ3vbmuoaZewX+QZakGh9Hy77
	n8IAI1a0PSb/M7l10xxBJqt5U4+ONejUemNRoJWGAfYQG73O4vDKlV5rdKxHwyI=
X-Google-Smtp-Source: AGHT+IEiNk0Cn6MVwI5JAm4CSWs1hj1gD+x4Feg4TNA4+aIpcGR4ZjhqJy/We9xVKcVn1k9NgGuX6Q==
X-Received: by 2002:a2e:9e88:0:b0:2ec:4eea:5dd5 with SMTP id 38308e7fff4ca-2ec5938a51cmr13815331fa.45.1719126856656;
        Sun, 23 Jun 2024 00:14:16 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec5b031208sm1886861fa.26.2024.06.23.00.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:14:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Remove more useless wrappers
Date: Sun, 23 Jun 2024 10:14:09 +0300
Message-Id: <171912674298.840248.13296926368532998967.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240423-topic-msm_cleanup-v1-0-b30f39f43b90@linaro.org>
References: <20240423-topic-msm_cleanup-v1-0-b30f39f43b90@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 23 Apr 2024 00:36:58 +0200, Konrad Dybcio wrote:
> Shaving off some cruft
> 
> obj files seem to be identical pre and post cleanup which is always
> a good sign
> 
> 

Applied, thanks!

[1/2] drm/msm/dsi: Remove dsi_phy_read/write()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8fd6f64ddba0
[2/2] drm/msm/dsi: Remove dsi_phy_write_[un]delay()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/5372db09f4ba

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

