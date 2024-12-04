Return-Path: <linux-kernel+bounces-432225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB69E47E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BA22817AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7021F540A;
	Wed,  4 Dec 2024 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DeFL3Kh7"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81054192D8B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351559; cv=none; b=qvav7Fp92e0H3DMPCF22WTkH1A7M4Rbwsyv0YCIkrqPJYOMAptJ9QY2PhAiETRGxvd4wy7bt1g7nOUJZdka3eOmsnLAgLSRs2+ayC8LACqYSoL/e4K1XmXGnvyIPoYaU3/UImaUbAeNNwre20XIzQx6FCUD1w/1FFucxaLokD8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351559; c=relaxed/simple;
	bh=vOa7LETYg7icjKW7lrEIWCbaGqar/4hAk8skymKe1nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amXs//HiwBXKHSqp7JB3zsECQWopYIE3JfCuQ4ahhjgTiLpYVgJV5EhlYuNzrjMoYl6oUMMwBBUoBanuOXSMM3Iq6c0Lbmek+Ihx36ZG11O1BiXzEyibAhdxPaqcpmovIMrPiPxII+4SygIWbl7H8WzF1x7DNyCsPU+WgeTRCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DeFL3Kh7; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffa974b2b0so1689211fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733351555; x=1733956355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lUKjEXOkSq/BvCViX3wWNqzFdxMzt0G+l0vc3wMpMM=;
        b=DeFL3Kh7enETMSi2GUQVozhxyMgbsZUaZRESVhxCsQKILPA03cwV5cjjC9eFqYmobW
         gUlyhpluCQkJU/r7ElO+G0vPabvuF54wPdo3JUClUIJeZlxthToUPvSRtxfO+qLJtnfm
         JiJ28JeyCbEbaW18s63aXck6PFQsQBQPrTNqMd9AUSJukOCO3hWmh3QFPmYhgpTKB6fI
         hcg3/hofC+1yjz26Pb99w/jderIZxb67GRMEf5EIK/YKakOXXIHuEEe/+uRl4xzi+LqT
         MW9PJuoAa1m3uvry3m2D47tnzvZsPRYFzg0cUySPNpH9VnhtifRCjsZWZHw5wIMcxvce
         kf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733351555; x=1733956355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lUKjEXOkSq/BvCViX3wWNqzFdxMzt0G+l0vc3wMpMM=;
        b=JmRANdVRF93i01Es7XGT4yi3bN7BWhoustUZp+ICQwGSArtTSf6pi/L5tjEoTb/gv0
         5/AMpnNUeJq8LNzGb8Dh8yn0A66MSSSOFkhMmTodAzT+IyFNqN99SWwcO9FFoHbQ6kGj
         5XKYzrRYLynJS6Ad0yQW7Jrjyd8LRHDoxbkB2pIcb9x10v69kVlMJsTKbD48KnPnFxgY
         YuhSx1ofLzP+wSVMQpz1dizY0NCX0kxE/ow7StmjWH41Oe6FLlztZqAzQ5sGat5Qa710
         TeoOozs4H1YV4/jpfSkdsHX5wdGcm+pPcAwL0tG2QzlysgbVUxXYXGt4PP2/kZF7gOQY
         oB8w==
X-Forwarded-Encrypted: i=1; AJvYcCUWtbtx/1xLOD7LTN92Rk/jv45CJruBlgyGuMuGp1SdVVHgbhNylTHaJw9oVXvJD7ikzUN+lUvvCXUFUHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYlpmflJsushKMzTPi2MRhbJLFKkRyzXXX15u7taBjHxp4x13
	pxY4UayPxZREIdON5QakqtBPp2kQAtwqKsLgGQZ3Hg7paa9xfvuhAUK7bQ1SGiM=
X-Gm-Gg: ASbGncs1hlcCr2qwI2zyPe35uyqx/YpCQeE46cd9CCmZYrJQXpxzAY/kranjdlPz2Y6
	jm8YVWx0t7ncjYEcKVQ/SHHu2LFxyO/a6xcf/uBao4csD+y05MGGULdEIXw7DLTpWQoQoNsPP3P
	LB9YfBYj1qHDwSM8zmqxELzsCY1Jbcrm3lh8fLBxp3/LFK1cpO3ggxGe+sYcP7bRgfeQ+uqjkGF
	4emlkrJueSvR/RyyCswCf63sk798mPh4d1hdtPwq6xmjUPNl+7CyyuxgvBA0J9ulxj73LvRWl3Y
	YUdxHzsYzZYSiwivYeQF7vhzwxir0Q==
X-Google-Smtp-Source: AGHT+IFNWhkJVAJckm6/eNAWU6WXd/hjHauSXtKnuiWCrx2cr6kF+AVPGV20Vj2333ehZHP0bITu8Q==
X-Received: by 2002:a2e:bd82:0:b0:300:1f05:5bcb with SMTP id 38308e7fff4ca-3001f055dc6mr2766501fa.16.1733351554688;
        Wed, 04 Dec 2024 14:32:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020d85256sm51301fa.11.2024.12.04.14.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:32:34 -0800 (PST)
Date: Thu, 5 Dec 2024 00:32:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v3 3/8] clk: qcom: rpmh: Add support for SM8750 rpmh
 clocks
Message-ID: <a2ztbxi2sth6pws6vtw2t7tnrqfh3d3j4dhbphey4vckkkdjep@jrgtpu7uw57z>
References: <20241204-sm8750_master_clks-v3-0-1a8f31a53a86@quicinc.com>
 <20241204-sm8750_master_clks-v3-3-1a8f31a53a86@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-sm8750_master_clks-v3-3-1a8f31a53a86@quicinc.com>

On Wed, Dec 04, 2024 at 11:37:15AM -0800, Melody Olvera wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Add the RPMH clocks present in SM8750 SoC.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

