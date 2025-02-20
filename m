Return-Path: <linux-kernel+bounces-523526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5DA3D80E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A371C3B0B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD5B1F4182;
	Thu, 20 Feb 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1XDyR9T"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CA41F3FE3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050108; cv=none; b=sP8r1ynyo/2AkwHuzw1K7HU7lHx153wmMI4wkKh0MPuNps5xWF6Qhkjgjlg30FhuMRUK4e0QUMDPoosuheVuaDz/1AvJTttJi+k5TV2kWpq7NDfLrNw5MouU2rvBjXXbr3QNOKIWsQxgt2wW323k8oy9aSO1LUTq6zzgWPzBPjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050108; c=relaxed/simple;
	bh=gCK+JqgYnCP01PtEyqufWSc/n0zhfsQsxdJ+Ud3negE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ezOFVoCPNxrGl/GTpTt4u/eD8W35pJflU9QpGV2/CrVMzyzMLCA9HI2p7eIgjzEdNoiwGft3CCBa89GkiPp+s/C3u/4tF6iLMZqcqMeATXMg9Lxd8kqre8nA6KkiXO1ab7EiLBimldXTnHnUS/eySOnGfntPQkV7v9CIAms4Vhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t1XDyR9T; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5461cb12e39so813859e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740050105; x=1740654905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KX85e3cYE0QI6HqN7XA+DGsKC7NKCz4a8QkfcGXFNn0=;
        b=t1XDyR9TxEYGdB7O5W4LWddE7+BKL6nRqeRlsqAwGsswZisS7/hJJu5VijaZzkI4e3
         YSpunAXOqMM++4y98K2JFg93tAbggWEFQSimCp+QDJrvfK4ogpwLDYNBVmcVFDM6S+P+
         CJ5NSASxnKW3d2XAJklwNV1vkUVN7QPC5fA+ZAX/2EiOJFiXKMhBoGFM1uhhcAA5+Dsu
         Bt+kPWUIU8xlZ+RWud0Dstj8rv1MxEp20PXyvEIcrx679M42EkXgA/G4K+6dNiGRnLly
         TtSi8g47CCAvdgFzIp/d9IF6ALA6VtJYr6LMLzHv8iJedYraIhpWkpNONnjB2H5YcfnA
         3jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740050105; x=1740654905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KX85e3cYE0QI6HqN7XA+DGsKC7NKCz4a8QkfcGXFNn0=;
        b=aqZWvfKNvDShQNDsdJtzQlb+epNYAZZv3WDAK54po1Gv5P3S4ZiRxnqpa4oLGI+GVc
         vqGoIwH5dSiZAamOMLtFc/lbehaPf8jNPqse1egfnI3V5qrdXzi8UKH/8ZCXBubIrPe4
         W3VTfUL4qBsbt5lMWwWoSSjkKV46LJcIEd+CdztjBB5rOK+1IlVkhqJi3oTTyZpa330c
         I4haPT4HeHO7rlsHUduZ9y1Z7mWTC44LcYczUAqd8M0O6hA/IBS/egIq+d/MJtMnAabH
         ZvM4tv8WGn0/UX4rIJW+tRl0RrWe07dITChPDMIIkrFighl4YOicvS8NuXsMB/YYjosp
         dIBA==
X-Forwarded-Encrypted: i=1; AJvYcCXWqriD8+0xOmUrvbMHum2kaD0vtvdrX4XxLwr/mw8paPiaCBWPoAb0HQoJpZmSUzAAegCo2ar2Gm/5uko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDobmO3DqiLgBBOIl1TYgG8CxI7zjNQBQ4D22TNTFB+Mij1Yw
	T6URwbtw7JfiokQ+DmBKvjOuxSPoZMb9FyjotZQJR0vpUblDIyV165E62xZOGbU=
X-Gm-Gg: ASbGncsgOuhSzHVvgPfyVtfBMUHdbUSTUskRzD+96d8h57noIEZ0HxwTQRuxE5ASIep
	ZJ1PtWS7pcnlhsL+rkz+hI8B3s/ARs58vesW2UIBY9ZVWWvwDWp7P/HMURwYFRyYNXH4rOPcd7L
	zoPXiRjoWPyA21K8ZAnx9IJCSAaJn0z+Fie0ClzfxF14VpgLGdU6Gq4u6iz/fWgTK07dje+ZKgF
	q/f6CVZOX9NXU799F/WO/eYWVE8VJc0VBlbJONFMdFpod9a3TTSi2IddGfqGA01zfQzeXEgX30/
	Rz3wyjtDzfU9o7a7mJzqMzQ=
X-Google-Smtp-Source: AGHT+IG5EZ3MbgXrnnf2FkcjlwzeGF14xhIhWRQXhiEeQQCNYMIhTxtVaUCFD3nFrIpgoLw26AvRGg==
X-Received: by 2002:a05:6512:224e:b0:544:c36:3333 with SMTP id 2adb3069b0e04-54724a7b447mr799283e87.30.1740050104821;
        Thu, 20 Feb 2025 03:15:04 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545297856c6sm2056164e87.142.2025.02.20.03.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:15:03 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 13:14:46 +0200
Subject: [PATCH v2 4/7] drm/msm/mdp4: use parent_data for LVDS PLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-fd-mdp4-lvds-v2-4-15afe5578a31@linaro.org>
References: <20250220-fd-mdp4-lvds-v2-0-15afe5578a31@linaro.org>
In-Reply-To: <20250220-fd-mdp4-lvds-v2-0-15afe5578a31@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=gCK+JqgYnCP01PtEyqufWSc/n0zhfsQsxdJ+Ud3negE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntw6rEbJHBbORbIefZc6iISdAFhieGQ33v4LyZ
 TdCorO1c32JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7cOqwAKCRCLPIo+Aiko
 1fjdCACP6GLXiufCQ9UEpsNvSB7qNK9i1JDaj/ntqy8bB6XhsyXItB4E00m3PRNBAO32QhZ/WnX
 nktwAb2tH1j0Sg2HKU0CW0Y9y8l5jTX3oLQoKh+wVAXrXdpUum4qRBndE88/7xaSa3x+p85OzzL
 xWXcDJkFVKUPuNj//5AF0s9+33Pyfp2sgqUbSKltUCjoNEvj/5XSvD45MaEfhAfp3k7I1skaPE9
 a1SwxoaY4Sx44nleZaJ7xvx4VAThvuBbUtyQix1OGjk5hqBlK7y0cW/iDzLKf30qxM9lvBY0Jk8
 fOYobntzAK8ViKS88/mj+MvhbEgHl+1nuplkxzdDW0tswKXM
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Instead of using .parent_names, use .parent_data, which binds parent
clocks by using relative names specified in DT rather than using global
system clock names.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
index cbd154c72e44c848fa65fe01d848879b9f6735fb..a99bf482ba2c02e27a76341ae454930a13c8dd92 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
@@ -122,14 +122,14 @@ static const struct clk_ops mpd4_lvds_pll_ops = {
 	.set_rate = mpd4_lvds_pll_set_rate,
 };
 
-static const char *mpd4_lvds_pll_parents[] = {
-	"pxo",
+static const struct clk_parent_data mpd4_lvds_pll_parents[] = {
+	{ .fw_name = "pxo", .name = "pxo", },
 };
 
 static struct clk_init_data pll_init = {
 	.name = "mpd4_lvds_pll",
 	.ops = &mpd4_lvds_pll_ops,
-	.parent_names = mpd4_lvds_pll_parents,
+	.parent_data = mpd4_lvds_pll_parents,
 	.num_parents = ARRAY_SIZE(mpd4_lvds_pll_parents),
 };
 

-- 
2.39.5


