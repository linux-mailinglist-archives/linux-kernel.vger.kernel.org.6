Return-Path: <linux-kernel+bounces-425626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 065879DE7F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CFCB22960
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C321A0724;
	Fri, 29 Nov 2024 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlSL/GEB"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867B19E7F8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887938; cv=none; b=bUTVFv3tq7HXe2xQGZyrYTxyP1s8FbbsJh46SLQCaUo8AVLpTp4hut+EEyK8U+t4lQ/RvySFAIILGjyFPHPXk4AAUJKeJRfWENyFH4m+BGsohu7JQ13GN3dJzOxoieFTUHQPpIzu750xKVnOSftYmkpKAr3zYal71zwg6zLTq8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887938; c=relaxed/simple;
	bh=WoE2yMfvRouFCW1YYkpvAbtADpCH3VD5R9wGkslpWIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVYNPqfK6aGO4qkmWsdHTeQ0737vS/cF6qVtj9JDEZXp9btNmHA/rRD7+F9Wg9cZNYgdTrYkvV7zh8nrdoimIoBJGgcrSrIKMMtF9NUJjYBiBZVx7yHOIGx+F9QDRJ7eGvMocORd8rPh6o6ccPZfsWZ3UQ+S+4f4j2Rkmwh9VSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlSL/GEB; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e34339d41bso16958907b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732887935; x=1733492735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jnuFPvHlqF2+V5h7gDxD9QoNqnoE7Ul8whcq/eg7E7s=;
        b=SlSL/GEB4MLqk5P9mojbkJI7VRjdhbLLbK41ON1gkOkhA5Iy+rAlWGaoqQC0sJ3Yzw
         Ize0eBodDL0tgwfYGmn6J/KulNFFalaRKWcLmXSNqqw12BS3HPMp0+LEIi1OFUMDrlcQ
         Y7d851+/QiQIJD7NdpXfB3pm9fYP3dFbNhtb2lAu+RSm2e8SEGeh+9FMAxezpLSEYLQ/
         DGA9UDACITPwrbXBK7H/Kdye11og2UqO63fHD54uKx91E0uNqxkM1rQj8A/l8m9nXz1K
         j8zbwjuMsTc1opZB2KRcC9w8XpDUYosbNyW92KNiISo8LKRnoZDMmj/IBLIoJtISYI09
         um2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732887935; x=1733492735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnuFPvHlqF2+V5h7gDxD9QoNqnoE7Ul8whcq/eg7E7s=;
        b=sHDUPGMsj2Bggz4b8NvHzD/bUHgEx3X0/GjIjR+MjZsNOQ8UBq6mPQXdQNHSlrNh16
         mSPLafTzgnEz+hX2i3U782k/1UZUGAdi3/qtx/yTzYUtGYwv9/TzVFjhQl/CqnJl8XxO
         NHsETkQuThyjk686qIIBGFJEIfpcX1FVNln+Qsp7Wu1YpHEnrMqgwzxd1Bg06wq3R5q2
         HdeQvVfzOuVmMYxmjFwE8Mcs6Gmz4q7btMvBdcd9NlgLX/8xdm86+ebF3tq6BPtB/n8Z
         Bas6s6LUUwAfbzxBnPjprl70dEXO3yjRXdUDghNEepU+A0SsdtxKMKJGfXNJkB8pDckU
         V7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUjeR76SYhF9oqfElj5aKfASjnoE8+xwVbhvZwDg2dk1bSY1CUfrNYHpJp815IIPhBjvFxkb2xi+RYmkYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+KHI5zonLWZqOJlrGfXrms/m590EjwwTKbfuS4HE4qyTCA3A
	cinBxTCirXFUZJ8+SJF9V+NyQm1ft54eW8DodX5DmyINFWFnGa5xR1xirVOISgfij/woJzE2Xzh
	IaIpWZ+f8tia2crOX8VVf0dk09tQB0sVu4o4Tqg==
X-Gm-Gg: ASbGnctYwBxlJzxoC8UvX9WLqUM4XragTOkDcp4i59XGS8Hp7d6OPL5/0Q7SxEuzNuu
	J/+O3AO8SijCY1xG9ZjhFPtMSVvDjbQE=
X-Google-Smtp-Source: AGHT+IFcdw16JjCHhf6pyyNofTqnqJtbeYn35N5Sw7fR5PMwJk8S0Dust9v7sJdcUjiPz0hKcc++q+mU90RLLwYFzZk=
X-Received: by 2002:a05:690c:9c08:b0:6ef:4ed2:7dfe with SMTP id
 00721157ae682-6ef4ed381ecmr63286207b3.31.1732887934964; Fri, 29 Nov 2024
 05:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-8-09a4338d93ef@quicinc.com>
In-Reply-To: <20241129-add-displayport-support-for-qcs615-platform-v1-8-09a4338d93ef@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 29 Nov 2024 15:45:29 +0200
Message-ID: <CAA8EJpqMug4u1YPxBGfDUT8Cf8F5XckxnJdau-Gm6swyU5VT=w@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/msm/dp: Support external GPIO HPD with 3rd
 pinctrl chip
To: Xiangxu Yin <quic_xiangxuy@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_lliu6@quicinc.com, quic_fangez@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 09:59, Xiangxu Yin <quic_xiangxuy@quicinc.com> wrote:
>
> Add support for handling HPD (Hot Plug Detect) signals via external
> GPIOs connected through pinctrl chips (e.g., Semtech SX1509Q). This
> involves reinitializing the relevant GPIO and binding an interrupt
> handler to process hot plug events. Since external GPIOs only support
> edge interrupts (rising or falling) rather than state interrupts, the
> GPIO state must be read during the first DP bridge HPD enablement. This
> ensures the current connection state is determined and a hot plug event
> is reported accordingly.

NAK, use dp-connector instead.

>
> Signed-off-by: Xiangxu Yin <quic_xiangxuy@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 83 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)


-- 
With best wishes
Dmitry

