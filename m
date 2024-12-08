Return-Path: <linux-kernel+bounces-436317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0655E9E844D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 09:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9901D1884A3E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66061144D1A;
	Sun,  8 Dec 2024 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wrbc057U"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B413C836
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733647900; cv=none; b=Lkot6TrburHt6fR/DyouBpxJhW6X4w6CBKWP+3CrhTzPA3QeKx7cCRP7pRO8fF4LweTGdvgyQGwEp2+yP5nakJ3n2cjlH7u0GlJXaAIcwFtA2gywVNkE0e3TAV5Q2GVTVYuM3ohG7y/f9Y8X5jvSlb4lhDaRDkbH3pUHLkwIOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733647900; c=relaxed/simple;
	bh=vYgydQqr1VLEhPsnbpJ8DT0BEmdJ5iq6owBvdPG8TPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wco2lkZV5iJeLw0iKWI/SRb9tJ0+rB0SwKcsLQiuuT0Fr3wGTqnw/yfgQ/O9LLI6dNI0y36Ho7E1L3NZZyoaraMc3DfUR1B6CmDjfyUVCNEVBiFvqvUTdsCB3+0qViuz0STzKTA6EdUJrT+wSCnCBShfYeWf1Ywq0XO6gDnQalE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wrbc057U; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffc86948dcso33955711fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 00:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733647897; x=1734252697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhNcbbr16rCA3/JeSUAsY4Iitw9SPQbHFYkFe1dOMAY=;
        b=Wrbc057UusUlAU3tJwyCbN9Eow9bwh0G/WxSTRLgTrDlBD5E6lCRIOFKt6zPv1C2sM
         W76bLywekJuo0q32KpX9AorKgGMoO0tkkri//UpNqWcXBD1LnMus4TURmRaJgQiNX/4t
         tnxYNC53n81W5id7ANyR11oMjNaP0amRuZiS2nqsjtxR/wpDc2zVwb2cAq3/k4mKyygH
         DMN1rpFw7AKHje/zfyhbpT3rgxBXqxS2rppY91cDXTWSf6Ggn35M/O9AnQg7viTP8vGg
         bG4iPMFk9YEqJ9Gf0c7olW7TOc1YDHageZ0niYhJOrPXMCuHGmCvOid9p4T8b4X0pdlW
         /n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733647897; x=1734252697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhNcbbr16rCA3/JeSUAsY4Iitw9SPQbHFYkFe1dOMAY=;
        b=kmLtwtAHETt8fV0CuScEneHfYuwNVMAB/8bcqiDvc68yXmV/UUI+nCxasR5z3iiZSA
         iC7RL0xFdPbBhFlMj13G6A1MivKEVk0bPcmAjcPr3FevgBKr7/CGP2V8A0wXOHejlPuS
         Ft1AAcpZTn6MFRKi8pz77Ryd8QPVCvBVDiYbHGsH+gW1bD9YWdn4jeR3nG8F4chFl8tN
         /Y/kJPXUjaiYwWSnKxxViutAjkOZS2IB9IUiJq9+LdaR291B4nlC5GYSCs8QSWlhccnJ
         e+dk2iwostzmCGyEd8wjP6n7aXhcAoUcCYjVdf3Uqj2UgwP51t8CJn3vz6r7Zv3VbM2h
         6GkA==
X-Forwarded-Encrypted: i=1; AJvYcCWK5t3VVHQuh8EuquweSKbEO1DSHXtTbt+/a0ZotuyTXM91DQnKiWvuM6irg4ZAC+lRqi2xxpQXg4Q/5uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMoCVKMI4UIa+Y+khDKACW6dOYM/9Xe3W2Uw9aSjLidHJMGxgh
	g8GPzCT+ZGs8ut+CREsr+v14Z4j1RMgupj19WOE1xI+9fEgxb+PIYuPyaRv4RzM=
X-Gm-Gg: ASbGncuOyTx+3gChqpJRPVy0bUxekIUmBQtWxabx/4COeKfq9D0x8jkWTLZwIOR9iFX
	JbDnYELo0130lIHuOBSqSeOxni9yi05BtEbD3Myu+pMN1S8FzgAxO3n9/ybwOsbeTqEYrABik8u
	IiKFZIgfbQiCNL4Em0ye0ZZ3iTVAy+w36fDFd4t6VtyAGIl7mv/MLW0YFRU7EmIrWVJj1uLb2AJ
	xBidNWRMFdsrfzgeZOt3nEgskzA1t+kjRbcnv5Xtvzb2VMjkdZk/xCOi3xSwtP3hIJl4RM5PCIX
	UPxP/QSy0irprkiHdSX0Xftv2W9fsg==
X-Google-Smtp-Source: AGHT+IHiwphjww0ZX/ARCaOQWbDtkiMp61r+FZ23Ev0IT+2ZIgkD8Jn/Hmmxto1mAzafzC+0GFmXvg==
X-Received: by 2002:a05:6512:3e15:b0:53e:38df:673d with SMTP id 2adb3069b0e04-53e38df6949mr2968634e87.43.1733647897072;
        Sun, 08 Dec 2024 00:51:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ca282sm1033705e87.241.2024.12.08.00.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 00:51:36 -0800 (PST)
Date: Sun, 8 Dec 2024 10:51:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 30/45] drm/msm/dp: add dp_display_get_panel() to
 initialize DP panel
Message-ID: <akhwuvpxxsjmejbbwksf3uty3cs3utian2vsmalrtfxbx6h6r6@pcrlpelx3545>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-30-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-30-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:32:01PM -0800, Abhinav Kumar wrote:
> Add an API dp_display_get_panel() to initialize and return a DP
> panel to be used by DP MST module. Since some of the fields of
> DP panel are private, dp_display module needs to initialize these
> parts and return the panel back.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 28 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
>  2 files changed, 30 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

