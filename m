Return-Path: <linux-kernel+bounces-269271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284079430CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A5F283F39
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C31E1B1505;
	Wed, 31 Jul 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErUut1kc"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCDE1B0123
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432526; cv=none; b=N0tQ6U20aGsrEFkPUb17jkpCuLAwXffuPh7xX98vBDxRIQYPftSZienaiHH9ZnP6nuy0tTCGR/0u2to0PUoA1XLTyPCsF5IbxuhP3cTTvDiJ2WtGerS+GGTZLh+Ya7d+JTm7fOlOhHmlJkJY42DSzzV+5mhxUwR/glXupFtvqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432526; c=relaxed/simple;
	bh=AN6dcobfsnNdYLOXFrgy8ln44GUPCni1YdOBd+ilrH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1LltMcBerl4w4914G3nO1+2WRsKEEYVf0ENdpGDjFEZxKkp9i1WiCymKwiAcdYszrq1ltnvRvKUTkbyyENPyOdrTxiwHqtEJWLtiQFCkX/rKVdCB0vxU3VenRJoJrbymztpwLW8xCy3bAFdBzb1KHIBhqG4888A9Cjd9fBWFLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ErUut1kc; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so74828431fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722432523; x=1723037323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UjNb/W9PzqFhyA7ecL9dMbHE01A2sX3SN01rofguaBg=;
        b=ErUut1kc3ExWCE4ZGijB1wIaTrsUQ+/Oma+Wfw/CnYab3Kymr1uTP16AthNUgo4z7a
         m3YW3jVdJ4pKP4MJ3H9mgluhPkp3Z5Vdj2G3LrRtfafsMRMlz0K7HyHtiIVxWYqCX5Um
         lwJXTByeNDsocFnK1XUm1Coe5f22WvS3nrTWj8fBYEXWXPMj93Q3QQ9LqVDtgJiFNBy6
         anf6/XkK4aVyW4zuhsiI6m+v9L2+i4JCpi5aGOzdjDm0Bocc4/83sKgYM+yLX0uI46Bj
         pMBBOGoJ6gOyaguMg95ra+XirI8+9D7BvIIByEPVcIV74DLMVksWd6BmQRzv/yuwYA07
         wTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722432523; x=1723037323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjNb/W9PzqFhyA7ecL9dMbHE01A2sX3SN01rofguaBg=;
        b=XGikETPMW29B6oE313Tkw6PMqH8IMdLsdwqN3R7EKFyeeJuR4nTrTqX+EbGTvvJ+w6
         /5qHcTIFsIlecR6fGkITvFVI8lHYkh/uHlAcgZatHtMLjrAHL3XDZB2ZAge/cfwzKOV9
         o6LZaGI/vbE9/Y65GE+mjNe7dyiDH/aplM/T26H52LwgB/fbWmI9YENsQ9amodN/dMMh
         m9FVrc9Bpcp0jhYkp1QA4hLS2m2IVcla13GcdEETq53OFnJJXS11xqErRrUDNuvQ4LIa
         43cHgca8z1mOfJXZB8GvcPmp8JBcYnmRaWH2SMkDeoBljLohujf191x94RgM/iNc8+SZ
         7O2A==
X-Forwarded-Encrypted: i=1; AJvYcCVwpC2wsthnKuk7HOptHdjhX4QXW4qhHlDb4WMYTJwmYBEyI3CSeSzzJgHv4m5fyrvO/feKRNlnOohDy2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDjrJHxK7qYIM8IHYpdsr709JQJNr7evMTB2JfRu6MYy9adr8u
	VhP0+RrwdgbQUjzzcsf/c4cc8OzU4J/75rdwOHKBiPA4a3OVYmC7XGKWBDHRf3Q=
X-Google-Smtp-Source: AGHT+IE6atB6z6OV9CQhmRK/cwk7H5bC/E7Z6lhESECLwGOuzOQFg2ndG+qf9TrXDb9ItYztuLPMiQ==
X-Received: by 2002:ac2:5a4b:0:b0:52c:dfe6:6352 with SMTP id 2adb3069b0e04-5309b2bcc1dmr9914290e87.48.1722432522905;
        Wed, 31 Jul 2024 06:28:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c363aesm2225844e87.291.2024.07.31.06.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:28:42 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:28:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, stable@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH V3 4/8] clk: qcom: clk-alpha-pll: Update set_rate for
 Zonda PLL
Message-ID: <6ntwin4iu7ue4n6kvz6hiqv7ixuc32bc6goxm4bg4czkdlsyyk@25qfz47opij2>
References: <20240731062916.2680823-1-quic_skakitap@quicinc.com>
 <20240731062916.2680823-5-quic_skakitap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731062916.2680823-5-quic_skakitap@quicinc.com>

On Wed, Jul 31, 2024 at 11:59:12AM GMT, Satya Priya Kakitapalli wrote:
> The Zonda PLL has a 16 bit signed alpha and in the cases where the alpha
> value is greater than 0.5, the L value needs to be adjusted accordingly.
> Thus update the logic to handle the signed alpha val.
> 
> Fixes: f21b6bfecc27 ("clk: qcom: clk-alpha-pll: add support for zonda pll")
> Cc: stable@vger.kernel.org
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

