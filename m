Return-Path: <linux-kernel+bounces-429609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D949E2095
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7288EB3C473
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933E21F4280;
	Tue,  3 Dec 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrf57wu3"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97E1F471D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234341; cv=none; b=bV/Q0VlizSwhfBUB70WzsEgWIttEP44ptuWp/+UXH8RVlYd3LiRllOzDiuHTyCjhbdDrbWF8RoNQutkRFVWvmnDwnZWAax1RC5K+F6AdzxDF5zikZ+rXU8b+zHjEkAs+ZGQzybr1ArrF/2kMU2p/+gxKhxFDNMbeu8TocReiIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234341; c=relaxed/simple;
	bh=TF0PUhtQTicvC6M129Y4QTNRkQEuUNF1PsicyZbmyQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTa+GE+zDJ78ApqlkDx2iwhOgKHhbGs/cDyqGF8qZ3OHBKLpOcLyLesj4UHGaXcVnwc7/uxmFzXMuGEKIyYGhsSv3TfJ0Iem23owyJrNixVOz9G9khOD/YRVV1bGmidXHw06DiGGcMB46ycPTomuUMeSsfP+sWiLNSWGHd+n2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrf57wu3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53de579f775so7804763e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733234338; x=1733839138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ratoXWp/EmolcxNUAUNGQ1kmRPcGIDYTBbsytoKVT70=;
        b=qrf57wu3TdmSGq5Rpxe3lX4V0TQeAepWhnssvHbbk8N159cFgJ90/doN8H5xLTXReZ
         sXvpT7H3Eb0h7rWguridTBqAh2kIsyJIXuNCjUuYhpagjs093HORXq0W4Iez4dW0x5kY
         M0gx8tCna6n21Fgt+Z76TQY0j/3Ikf3Z1rFmbRFKcJMKUmhoVKrMGNhmg8ToME3FS1EE
         a1zIFEcPlQaoCuO2Cux+EQ2ivB5GHCAporzlupljAo8PDk04wZtB+zouiyJYzS8o938e
         z0nABEzlRdn3gwkoPqUEirMQ7x/ujdwNEdufQ+MLOiMSWJ07CkZQgWTq4GPpbbKYWe6x
         NONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234338; x=1733839138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ratoXWp/EmolcxNUAUNGQ1kmRPcGIDYTBbsytoKVT70=;
        b=jH/hPivQB+j+qhHiS6lUyv4d83yqetJahckSETgQBmzwbuln2GI+dNL1E52TlFvaqO
         jnyq88Ufvbnypgwty7rZZe90fCRqKOXFNirxXHl/x/siYL45RxeD0BfoEAMUZsX3pmI+
         tyC1fnKJw4RQiAsdwoFrgZP0tEtZIV1EqMj9PHPt8BRkFEle6ouZipKFdtBm6lwJ0LB7
         smR/8hvQAtw6B1de8l2M+87ErECSgURK2lU+C/tB0w4YC4GDSKL5zfyU+NabXjr08fWy
         atv5hdk0hSyOANjN5zOvb9z28wT33RlxrTy7p/wFc88SybcYWpJEOD7b6un5VzAzfLn0
         Mf+g==
X-Forwarded-Encrypted: i=1; AJvYcCWvWZz36OxegUwpOfxlfvgkYfzBB2IEwGHdeXFt3vIczbqBeE66Vk7r4rVcQJls/y4wIvdbB59HuLuZGAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPPwJH0Ovcllb7oU7y9BHKcTp5eKfs117PZmsbu7lZ/srPzS0v
	s4jsC/8/sd4zACBHvpOdzvWDM0AULFSXkoGPB/DotI0zl+emop85NRm6pAraiJQ=
X-Gm-Gg: ASbGncsnvamgG88/QzxEOX5m8hvB7AXyln3hUpkdxydjXZlpRtCgC5w3K3F8QmM87DV
	eDzGwHNVxrL+xVWwgm/gMNo36m+UPu7Nhy7W1e03IDuHFflJ8JEaR+wvMQjLRVnVyOJYRi3uV1W
	nUWzBVbOmzCdj+xnZn1CusnWYbIAgGFoCyJXy9rMD85OTcwgWMX21XilniCbX91HfAu9HzTBs+p
	o4tB225rDc88W8RwVtVK4suBHsfzUtyd6bK7LsqbdOE13gGnhN9UWtzpe/Crt6XWTcPB8rdPljo
	BUC5SGQxxPVhqZFc0VBhTZ5MUr39Kg==
X-Google-Smtp-Source: AGHT+IGXwu7iAMc0T7nz4ZWr7DVCTldVmrbcWesEg5VeYru0HhyDfTDMH7KA7Bk8Gf9p7i1oKm3lyg==
X-Received: by 2002:a05:6512:3182:b0:53d:a025:1142 with SMTP id 2adb3069b0e04-53e12a39336mr2285402e87.54.1733234338202;
        Tue, 03 Dec 2024 05:58:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a06fesm1843812e87.258.2024.12.03.05.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:58:56 -0800 (PST)
Date: Tue, 3 Dec 2024 15:58:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xiangxu Yin <quic_xiangxuy@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_lliu6@quicinc.com, quic_fangez@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 6/8] drm/msm/dp: Add maximum width limitation for modes
Message-ID: <fb6enh3wzusadc6r7clg7n7ik2jsucimoi7dnecnsstcz4r6e6@dtahvlm522jj>
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-6-09a4338d93ef@quicinc.com>
 <CAA8EJpprTGRTxO+9BC6GRwxE4A3CuvmySsxS2Nh4Tqj0nDRT_Q@mail.gmail.com>
 <95a78722-8266-4d5d-8d2f-e8efa1aa2e87@quicinc.com>
 <CAA8EJpo-1o9i4JhZgdbvRxvoYQE2v18Lz_8dVg=Za7a_pk5EDA@mail.gmail.com>
 <86b9a8be-8972-4c19-af0c-da6b3667cbf4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86b9a8be-8972-4c19-af0c-da6b3667cbf4@quicinc.com>

On Tue, Dec 03, 2024 at 03:41:53PM +0800, Xiangxu Yin wrote:
> 
> 
> On 12/2/2024 5:32 PM, Dmitry Baryshkov wrote:
> > On Mon, 2 Dec 2024 at 11:05, Xiangxu Yin <quic_xiangxuy@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 11/29/2024 9:52 PM, Dmitry Baryshkov wrote:
> >>> On Fri, 29 Nov 2024 at 09:59, Xiangxu Yin <quic_xiangxuy@quicinc.com> wrote:
> >>>>
> >>>> Introduce a maximum width constraint for modes during validation. This
> >>>> ensures that the modes are filtered based on hardware capabilities,
> >>>> specifically addressing the line buffer limitations of individual pipes.
> >>>
> >>> This doesn't describe, why this is necessary. What does "buffer
> >>> limitations of individual pipes" mean?
> >>> If the platforms have hw capabilities like being unable to support 8k
> >>> or 10k, it should go to platform data
> >>>
> >> It's SSPP line buffer limitation for this platform and only support to 2160 mode width.
> >> Then, shall I add max_width config to struct msm_dp_desc in next patch? for other platform will set defualt value to ‘DP_MAX_WIDTH 7680'
> > 
> > SSPP line buffer limitations are to be handled in the DPU driver. The
> > DP driver shouldn't care about those.
> > 
> Ok, Will drop this part in next patch.

If you drop it, what will be left from the patch itself?

> >>>>
> >>>> Signed-off-by: Xiangxu Yin <quic_xiangxuy@quicinc.com>
> >>>> ---
> >>>>  drivers/gpu/drm/msm/dp/dp_display.c |  3 +++
> >>>>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
> >>>>  drivers/gpu/drm/msm/dp/dp_panel.c   | 13 +++++++++++++
> >>>>  drivers/gpu/drm/msm/dp/dp_panel.h   |  1 +
> >>>>  4 files changed, 18 insertions(+)
> > 
> > 
> 

-- 
With best wishes
Dmitry

