Return-Path: <linux-kernel+bounces-577211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B6A71A01
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF441886AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D421F1905;
	Wed, 26 Mar 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCfJXrrN"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5E1DD539
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001726; cv=none; b=ZH0c4W9Nj/nDLYdO517BTTZskkXILpMpmJpenRS1db9EWiQ2ameoXsXQr0I+luPYV4ZcRRbT+fFlyCMlJ5E7b4zQBD3Wgb0qHU3UDtHhje4qL+1CHtu98pNnjashD9LBSm+xBQLavOZZnHHu1nleJDCD63KU7QxMdheoDo/wUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001726; c=relaxed/simple;
	bh=J+Uwty62x7DdnPcwWCiCgXAH3nCocKjRLuMfYyRNiMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmrQ/yHGzq14F9exjB9b/ERfPXcHSOaaDclh0vlyUV5HoNt+Bc/CRDPDTuyrXB2uyiR3vx+UTd1rck/Rk55RJj83cpXCV3PpsnzqnCMff48//r6II2bjMm7OcOLqfdexj105ivMrsxk57E1XGH/JLJ/I6K6xDyeK23OoYjS9kyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kCfJXrrN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso53512845e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743001722; x=1743606522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K6QgeinZ4T2CEETUj1UU3X0d9N2W6dwCixOfG2GPPgo=;
        b=kCfJXrrNGyYQnLL4wjLhwIilrMjQQcWNtxISBQt862laBdIFZliqrf+WGeLZ+AqMF+
         xthCNCpObZNbaDen0ngVWtqhBuSIquBii1GOnL3yzUmLcuiY8VO+95GHTAsBsdIEwHSI
         Ak108r1LvyTimKvteVjurk1UdEdzaelPT/McICBt7rKnqk0ltM9muX2qn5hGnCRiu4bU
         I59t63++WcWoCiAWOGSSsRGs0HfeoSMhCGBdhdzdcGJklk5wtuWHKr0pdIu0QJFkY1jW
         /cLXq4fV50KiEfQ4tBT5qYjR+WFO7A95n3AgWbVX4hk9NtenRq3vdfZnGaCTtATym1S6
         Hn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743001722; x=1743606522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6QgeinZ4T2CEETUj1UU3X0d9N2W6dwCixOfG2GPPgo=;
        b=NXdvIuF3A0YHd7X69SF9rjHkaghnqoPnCQvN9u5Dx/hpqqlKVoHcpiLJxbRNFNyxvD
         v1Cy/SoSQZqd3jpoI/5JYRflC1yB9uriAzVxSo0rMVD4A4uqKmjsrRq7hZd0nkVVIs8Y
         m8+USWc+MVcVAAD3SxPBEF3q2LaXHskol5pfkWgI+bHuvYOsqEdmPugXf0eaUuEtOy/y
         3AV48e3VxCrHGP7glVN1FBEwm9sLd5CRukbQkjkFU17/FuCRHaxFIlaaF15TYYOBDVvt
         ojSSnEgK9ae8vnXXJgfmA0tt0dbv6txFlRaUr9ugdBSXyOsY7YLzJurTfxtAvC7DS4po
         okAg==
X-Forwarded-Encrypted: i=1; AJvYcCWqIlMbIs04+GfalL2JT8PmWhFVz2kPO7NQh4QK9uWE6ohDRDF+peMy0+eweQIWqf70soOaKmoyxivrR9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bxKgzrTqg08eGoru11BRUM7NbsokCRoznX3iBxr+8t7mL0JY
	aM0pdYZCrOey+s+1vtMY53woB8M3Ld0gh4gL9HoLzS3o6aX0C/VBq1mdiL1f8YnLDywsNDhX9Le
	Pw5f/UOUga0QKqzix/HcDAN8IapxqR/nNzUdvWg==
X-Gm-Gg: ASbGncuZoSInVWbxQ0vY/A8c1X7txKiParRITWv99xCSrFPbnXRAqXIuwP/uBQQpaxy
	m/zYDKs4kBLscLFzDnFPkuZisTkhTA81SBl8bFUU6p+RHAynNR1Hg4FWDwSUUfwxIHxzwyJrY7c
	0GX13q9kwam+N7kj1idpKd8r5XYKiZ1ZExVXW+XeGpwRl6IXUSKkiRLkgbtcw=
X-Google-Smtp-Source: AGHT+IFRX9Dag9WPYVZCjInr7s5+x9rD882OTti+EwgHv/CLcHvYu2T59wrDheZNF3bNaOL19EhKT3JrZA0RrFDharQ=
X-Received: by 2002:a05:6000:2b0c:b0:391:4bfd:6d5 with SMTP id
 ffacd0b85a97d-3997f9389d0mr12644513f8f.52.1743001721724; Wed, 26 Mar 2025
 08:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-0-e9bc7c9d30cc@linaro.org>
 <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-4-e9bc7c9d30cc@linaro.org> <2cfdf7f3-56a6-495e-83cf-1921a2e0ef8d@oss.qualcomm.com>
In-Reply-To: <2cfdf7f3-56a6-495e-83cf-1921a2e0ef8d@oss.qualcomm.com>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Wed, 26 Mar 2025 15:08:30 +0000
X-Gm-Features: AQ5f1JrG9jYOKFuYMJGa7mTyKExVbCzem5WJO44l_oFhXBZmwxNQppiXtjv4bCQ
Message-ID: <CACr-zFBFpqgHVRiH37ooeVJ4Jk1UA4AhP5J5L5yV8_CHBTG07g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/dp: fallback to maximum when PWM bit count is zero
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Douglas Anderson <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Rui Miguel Silva <rui.silva@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

On Tue, 25 Mar 2025 at 22:53, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On 25/03/2025 21:21, Christopher Obbard wrote:
> > Some eDP devices report DP_EDP_PWMGEN_BIT_COUNT as 0, but still provide
> > valid non-zero MIN and MAX values. This patch reworks the logic to
> > fallback to the max value in such cases, ensuring correct backlight PWM
> > configuration even when the bit count value is not explicitly set.
>
> I don't think this matches the eDP standard. It tells to use MIN if
> BIT_COUNT is less than MIN, if I understand it correctly.

Thanks for your comment; that's a good point.

I need to re-read this section of the spec; but at least on this
hardware I printed the values of the registers and it seems like
MIN and MAX are the same, so I could switch the patch around to use
MIN in the next version.

   drm_edp_backlight_probe_max: pn=0, pn_min=11, pn_max=11, bl_caps=134


diff --git a/drivers/gpu/drm/display/drm_dp_helper.c
b/drivers/gpu/drm/display/drm_dp_helper.c
index 6e519c58c2e84..2be2b00c8a531 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4061,6 +4061,8 @@ drm_edp_backlight_probe_max(struct drm_dp_aux
*aux, struct drm_edp_backlight_inf
                        aux->name, ret);
        }

+       pr_info("%s: pn=%d, pn_min=%d, pn_max=%d, bl_caps=%d\n",
__func__, pn, pn_min, pn_max, bl_caps);
+
        /*
         * Some eDP panels report brightness byte count support, but
the byte count
         * reading is 0 (e.g. Samsung ATNA40YK20) so in these cases use pn_max

