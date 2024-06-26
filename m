Return-Path: <linux-kernel+bounces-231335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3767F918E64
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28021F27614
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38819049A;
	Wed, 26 Jun 2024 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGUpkRVL"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC77C190499
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426393; cv=none; b=EfCgff12VeSEp4tOAXMhM3QVuXPG3D2xizWVKT0QpjPk6o0H8vV72fKDyOyVPlFZMr3oQKTAiowvuwn9EgqP3TkCisBhciH6qhtyCodjOI45TAvFLVN0qygTDgKJ+rTM3Bky0tWVxGwuTLip8vaQ3z/qR0YmJxwVDkWBbSHJtok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426393; c=relaxed/simple;
	bh=k01cK/YCuo1hQTt6db4+MUng1CIWGzBUN3c2BeefC6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+tMBUMcsKkpSCHNymk1VTFgFl8hGnu0L/rlPQJ08M9hlZ6FNL3j/aJYjDXdbKoCm2UPVOMhKwnSUHDaz1oJ+GQqf1bI/j9YDo8fFueJyU3TGbxGOe6b8CMzdUyoXJHjuPAxLGqsy3lA7pKrc7yRpTttewixGaG4WFacTyKg0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WGUpkRVL; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdcd26d61so5233858e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719426390; x=1720031190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtNa5H2/MJwEwkgtO3HYccqUUX7XhI9GZ7VcG3cyTuQ=;
        b=WGUpkRVL0KZeMSWgWOf8iPJhDWK6YVaVEuTidHI0/9ubsiuGYf20fFJ9ndReCqAzwy
         we/j0JjTZHHz4WC/ir0UZxJY9OZ8jZlM3wfWicNSxE/V9aai9xygIGZKF4iK3inNu6lL
         QaKr4gOGHwV7O6uWh0xbBLzF1xSPIg5IDFGDfOfzaYU/iEpAc4puwCG0pT/z3Sq7w8fh
         jDNWa/Qy3NVnXLWKeMLxvHcOW/NjrKRaoysVG4unzQy1KI+BLwabQ+k7HVx3boPzIEuz
         gJrS8UmzdE+vns/SZBkYAQNSpmcTcr7P4mFEWQPTfpQfM6JJ8U7KsTwkhyRkmEK2ScF9
         6rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719426390; x=1720031190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtNa5H2/MJwEwkgtO3HYccqUUX7XhI9GZ7VcG3cyTuQ=;
        b=QWdhZwFzY/nVM9xdcBVQBWg5KfnY/6LwZjmuzkJa1DAe7zvjLyEDFPRrHWBZVzGDtn
         Yom9NhR7cfWAxJoq6U4zIghUvVFPtFjrlS7QZqN/rY6ZVbGuMR/02Q/buoPJQ71xa/2E
         b92MnvMsK/EexpaOTIQSJnWlsyIcI16buV+mgPUg5bBcAbOpUaFyN++HSTlwU9YWRlKM
         NufGVj8w/55wfpxPTQCPPudUDHgFyxNYRuyBSzwgcz3VicAXAIUDP/kR7FiN6221apEY
         yNmUAgM94L9Y+moBPL+68Y/eQB5ey8lCqTftIX8e5o2esh0LBGs7/jTT1f6SKRSQJIgA
         gX6A==
X-Forwarded-Encrypted: i=1; AJvYcCVrkuXqNx4csRIipXV8oWfb+rOPLB8x4oUEGroIy7sE9goRXpyzx6b1rq7zrB8q6fQvKyWRvUnPytlOVn86weScn2hpseWkdP7HiTTg
X-Gm-Message-State: AOJu0YyiAbY23alJXCAbgSm5l6o5zHl+ZlascPmV/6t0S5MCrArsJVL4
	GWSZJ7nsegEWXxAeHni3tzD+Iwxxp9GVOr3Bw7FtSVyAjtxoXAVIeZEM3sxGujc=
X-Google-Smtp-Source: AGHT+IFPNDgKkvuVJj7YmfXDZK7PGPveQ+DO514sDOaDxGF/JOZUPyL7BfEVaKt57bjNRSLgfcMirQ==
X-Received: by 2002:ac2:5ded:0:b0:52c:dac0:59f8 with SMTP id 2adb3069b0e04-52ce185fb12mr7019578e87.53.1719426390002;
        Wed, 26 Jun 2024 11:26:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd7697e0bsm1640365e87.124.2024.06.26.11.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 11:26:29 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:26:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ilia.lin@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	otto.pflueger@abscue.de, neil.armstrong@linaro.org, luca@z3ntu.xyz, abel.vesa@linaro.org, 
	danila@jiaxyga.com, quic_ipkumar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/9] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Message-ID: <5dwbbuu74jdoukvmr7j3cqzf2rju6tngzawnptlldy5q2e4rwa@kqoucucwo4ae>
References: <20240626104002.420535-1-quic_varada@quicinc.com>
 <20240626104002.420535-6-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626104002.420535-6-quic_varada@quicinc.com>

On Wed, Jun 26, 2024 at 04:09:58PM GMT, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Add the APC power domain definitions used in IPQ9574.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Fix patch author
> v2: Fix Signed-off-by order
> ---
>  drivers/pmdomain/qcom/rpmpd.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

