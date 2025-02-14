Return-Path: <linux-kernel+bounces-515185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E51CBA36172
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F319118965FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2E7266EE4;
	Fri, 14 Feb 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLNOzJl2"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97380266EE5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546318; cv=none; b=qWfhB9JMQoJd0KEXjPWgGCaTK4+MTMZPAdNWNhRWCeatfvuzBfD2BYjz2/8ts46m0qWq0Z6l3q9fLXfqa+ZZGblVopDUuwvogLFezOz4uDRCREugWSDnsG5qnarbrOBmj4dSrwvtT+fi/pUBbhTfwdwdsaBOgQA7UvNhd483MeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546318; c=relaxed/simple;
	bh=khiM/ryaaEil6pLN+/17eJzNX76ge6PFhXLfoJXCGLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpmM20ntOw+zNmDgxpj6+fbsUm5EZXAr2IZKGPLhJV5dYz2lnoLpPFlUE7wcxxyQC44taDshr+TM1wTEWq2z1vK/TeO564Zh/dKSyq+PhcrAQ4GDijDU/z1gJBgjuzQV5C9Y9RjlO8+VU3wODi4T7Vd/8MMWKlPd7LJYKPf8mM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cLNOzJl2; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-308ec50eb3dso22457181fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739546315; x=1740151115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OcMZLvgo2+3kThO/hfiHuPvII26oDwywV7kGrf9ppp8=;
        b=cLNOzJl2A1/vuizglh4nHJ6+tGN7YWDR+B9XPK9Zzr9AEnkTK5rHMFPcWm9oLniytX
         fTIhJY2ZWnLasJApXyNfLx9DolTHxRSwxS2pZ42/wI39SgbJEq8p49WCnoUkHxaVySLQ
         2jBzk/2CVOaZOXqbYaZJUzhz/drGb44iOjvcY9+sxPWZm5+Zwns8M84+0cnxCJyqjmhj
         zxpZZ3mbDSaYck/zgbdaVbGtwADZK8Cg3Tl54MM3vAtYuVHV6YsWlQUt414t8m0n8wjt
         DmZPwuufiwQAI8OobOD2bm+V4fvqcGNVVrlSC7xWEhOlrsOqTpHMMZorceqKLjHlFfeN
         sk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546315; x=1740151115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcMZLvgo2+3kThO/hfiHuPvII26oDwywV7kGrf9ppp8=;
        b=WvuDmZr1mxf9eSi53E66z3gmvC5b4YI4uA29tqnM9xRH/dqz07iqioli+TIf7q82Sl
         9AMGYHc57TrDl8wqVCnXxmRExVEz1ZLZJQmuN4IAOnGQZgZzJpZ13t57r/8pqToPrwY8
         8gIAiy39gGcrjL6T4/DW6oOfsJqx6Tq4YVN84+jR48pcZIYQTZtMpyfa2axdJ2aajk3+
         I1gSSh/tYx+I4rMJohYjKCyhAbCyb24vauv1awU0vRpVaeRcnDzp9zqyBRtvXP8iMl7o
         co3BoTriUCzJ+tfg71oc0AEIJl3hg3GRWiANifaGvsC2I7vZUF5DmnpC/ZCNAjw0i5t2
         2M0w==
X-Forwarded-Encrypted: i=1; AJvYcCVG6iwrW1HHHLjzUdmZjiP12lmha/7brRcCnJw38lDTumoi2l0sqNc5ou4hjPo+iIC7+MnBHx6DGpRNQkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Bh7s1nkVtwxQ3roO1bJksH5MbT6kfyTrdZBDtJrVZUkzpRRl
	GIwp9Ew7MtvTAN4oS9xExyoUiq1Gjmhwwh3KRBJ7jq19UlvwxoAnAm52DyNaNM4=
X-Gm-Gg: ASbGnctXo5Y6ukBFfGGIdJ/+klbKCsz+xuDdCsrfcCONOQQ2DRk/UPVs/b8WJRgYo5h
	wrwn3siYSXMCGEuMx5lnTBZ5uocMxdMLasIIyYjVUfnwz8HFyMzLa0OIXZwuoeKdv2BGH222wnb
	Cf5QpaT1eNU9lLUQzeSWwBYYMpu/Z36S6Vp8N3LQB5PZeASsXnqNzIdVTpKyDsGut4ghNDER+re
	xqeQvWhRzBVoRX6Dun+5fJw51wjGW2LJnhLIONhU3mb+WTUDbAnJ7uz5YieJyvQqtmws5IeRMg4
	Yn/Lq62XaLWksgMh4VpqtDpVFdO9DJVZxqpnwMb2em9CWs9OSTFKngcwd5sz8XSnaozhvT0=
X-Google-Smtp-Source: AGHT+IEezzYlzsneQzuZxQe4Yo+jf7QLilk9BuU0obW1zoL2W/XDA76D0mSIeKsRAt8vyBqyYw8shw==
X-Received: by 2002:a05:651c:b29:b0:306:10d6:28b0 with SMTP id 38308e7fff4ca-30903630202mr37322251fa.1.1739546314624;
        Fri, 14 Feb 2025 07:18:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100c528asm5887331fa.22.2025.02.14.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:18:34 -0800 (PST)
Date: Fri, 14 Feb 2025 17:18:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jonathan Marek <jonathan@marek.ca>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v3 2/4] drm/msm/dsi/phy: Protect PHY_CMN_CLK_CFG1 against
 clock driver
Message-ID: <g6ddzfh6vsd7zgyopzassfp5ehife2t5mlq5jbjdcas3ewed2t@th37tsj7mmsw>
References: <20250214-drm-msm-phy-pll-cfg-reg-v3-0-0943b850722c@linaro.org>
 <20250214-drm-msm-phy-pll-cfg-reg-v3-2-0943b850722c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-drm-msm-phy-pll-cfg-reg-v3-2-0943b850722c@linaro.org>

On Fri, Feb 14, 2025 at 04:08:42PM +0100, Krzysztof Kozlowski wrote:
> PHY_CMN_CLK_CFG1 register is updated by the PHY driver and by a mux
> clock from Common Clock Framework:
> devm_clk_hw_register_mux_parent_hws().  There could be a path leading to
> concurrent and conflicting updates between PHY driver and clock
> framework, e.g. changing the mux and enabling PLL clocks.
> 
> Add dedicated spinlock to be sure all PHY_CMN_CLK_CFG1 updates are
> synchronized.
> 
> While shuffling the code, define and use PHY_CMN_CLK_CFG1 bitfields to
> make the code more readable and obvious.
> 
> Fixes: 1ef7c99d145c ("drm/msm/dsi: add support for 7nm DSI PHY/PLL")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

