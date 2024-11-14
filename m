Return-Path: <linux-kernel+bounces-409258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915A29C899B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B252826D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD4D1F9AA5;
	Thu, 14 Nov 2024 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dd3nE96Y"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BB91F8F13
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586375; cv=none; b=TLJhqRo7dr0MME0hH5NyNQdNzcEHi6vvabTi3hY2tqalmXY/5/nn+Ue2wi7ZF7AaefPTaN4kj4dqwV4f+jTsMwGhYBAau85azAcqfOwqCckBjtYV8we6xc7rgs1R8C8HS1NtDNBBAkSz1vUVlifgqeVudt6QxFU4uPvli8y02Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586375; c=relaxed/simple;
	bh=0N4u2tvQVfKeWhKuS6RSfLlT70Xj9TPhYMFHBgms7tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5URIpxS8auLotBiTOEgISrQi7Vv2reYIn7uCUA8Lu8ALyWsXlgJmCfkjbIvx/TRNnVJfxP4CFvjLbqKN3V+iU2r862XdaDA3tD1uX80Z/bxPH5302n04c77A6OWl/Uk8Oaf1VzI99m3vGYfw4Oiu4Xfznku+VVATEqDQCIqpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dd3nE96Y; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53da209492cso590130e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731586372; x=1732191172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1osO7NFmTGmX19JFLUCez78ik/qFqOXaEh8yYgfrqY=;
        b=Dd3nE96Yvf9KhC5sscy2bWPKumUdAspIKhoz/e2k0vUBFeyQ3n9QSfa8rREXYKzsis
         Yqxc5SAB50BpdTfeW2QmUIOCDy4cR9LmVmB42xxrUYXWWzm7YIzcH95XbJYa1kAE6jqT
         vF7kU6tks6MvOxEQRoR9DaHcf62SY8dwmwkCQWnJnuZdPa0DBJ04ggLs80mP9K68UtbU
         +LCzRif75GROmJ1Kh7iNNizIGixzrA11ZKpBKOWuVBaS8N0Ts+bSr313GIO5pwzi3JcV
         +USWIye425YVJXMN/GXRyzg7cTRGe+fLBff9ckFGlOYxb9QAEh7xF3GvTwncCp2fabip
         0dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731586372; x=1732191172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1osO7NFmTGmX19JFLUCez78ik/qFqOXaEh8yYgfrqY=;
        b=s9QPTkc50oWfGjgm5UV64k8+A7QFP0dBZ8NmLYlSmLjc3IBh0wxca+24vuqD8nphjx
         k8ANdj+0makttBDxByfW3zZvr3u9E4ICmuKXNaiTPUlXTpEnmiXMlaFeI9IICasELuf9
         cus7nJOgEXosvDxYNrzYnljvymtgnOj+vQiwaA0/JbidpPsL4rW1IA9VIiXlYm8FVoaB
         Vws1alRTd1/IDti1+mHDNLMP4A8Q9HAKn2N3RU6HosKE23wTR+ISAeM3EGJ8Oiy4TEC9
         z1w7WyrohwddaLO1HCpZKy9UYBRcOgexrWtirLmKV2ZuyExpjwHqf6nPwXCPB2WX/i3H
         UPDA==
X-Forwarded-Encrypted: i=1; AJvYcCXXWySnXg7l5G457UQVOAn9kEx8JYaZBLP6iGfW7G6manEZQa8W3VgY7dFc3O/eqoGMq+gMvVFvSttoJU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+fEeX6B5kXwgqm44Tt0GYOJLFObDys93t+XLvfr2dQvBho/z
	ALd8l9aCM2F+IkaK/FaSIwDvTdJKRs+ctzMuh9B8Td5jsoTLaB7XhEbpFFHB5LY=
X-Google-Smtp-Source: AGHT+IEuR0xLWMXeFH8Hj+BtIFR3zIeL3E9KlzQyVZ9bHzcIKoypj3g/lYGAKeRXG1eysRTlMVJEog==
X-Received: by 2002:a05:6512:3e17:b0:53a:7e:bcc6 with SMTP id 2adb3069b0e04-53d9fee3452mr3399322e87.53.1731586372180;
        Thu, 14 Nov 2024 04:12:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da653dd4csm162919e87.170.2024.11.14.04.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:12:50 -0800 (PST)
Date: Thu, 14 Nov 2024 14:12:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rex Nie <rex.nie@jaguarmicro.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, airlied@gmail.com, 
	simona@ffwll.ch, avrac@freebox.fr, sean@poorly.run, marijn.suijten@somainline.org, 
	jani.nikula@intel.com, mgonzalez@freebox.fr, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	angus.chen@jaguarmicro.com
Subject: Re: [PATCH] drm/msm/hdmi: simplify code in pll_get_integloop_gain
Message-ID: <gqej2hhenngqzcla6mgxywfft5qbpglrlotetgiezdrt5t5fjo@tpazzxp7gleb>
References: <20241112074101.2206-1-rex.nie@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112074101.2206-1-rex.nie@jaguarmicro.com>

On Tue, Nov 12, 2024 at 03:41:00PM +0800, Rex Nie wrote:
> In pll_get_integloop_gain(), digclk_divsel=1 or 2, base=63 or 196ULL,
> so the base may be 63, 126, 196, 392. The condition base <= 2046
> always true.
> 
> Fixes: caedbf17c48d ("drm/msm: add msm8998 hdmi phy/pll support")
> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

