Return-Path: <linux-kernel+bounces-545979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D037A4F4C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913933A7D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF0315B10D;
	Wed,  5 Mar 2025 02:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kooRwLJz"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93213792B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741142266; cv=none; b=E7H6oDNXOv60W1E1wUrtAyN6fu10MBxTNswvDj8y7KdL/9PMrfyM4DUvY3xVtIqSJUiN6rZ3zvIgELwKGpcjOelmbxAfkn/gNKj64+BGWMEorES2LBo53XWmFBnnM6S2UI2+ujuwRgG1lrwGI8dr92DQVVgGzz26JXUspGONp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741142266; c=relaxed/simple;
	bh=oxBgNmxdENcaCJquuWTf/U9k8IjF40VaPYhmT3ZZHy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huFmWemOpBfvn3TQMnCs8A3vZNTUpR6lD3rCTsovmXM+W4RVmjFy/Kwby/GKMuDoJiFqSgKne6+XeZt/P66JHDjesrrZxrog4EwYj+GnoXaf/o7fjG96SI1U+yy0s7TmPO8GbO/hlFLuNoAdOWv2DgaDOQdOJ58TgcraRLq7LXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kooRwLJz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5494bc8a526so5678062e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741142263; x=1741747063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+97ZVr2GLGNMwRJ+JHGTl73f9HD8d4XIQHgo+B51+A=;
        b=kooRwLJzxzEdOhokl3zQO3Xx84jqsBBY9dgmfKwi0jz7uhWiZ3G5hlD57tR7nDF8Bk
         vlXk5+mBNuZBVSflJAW6HN6F6J0U0o7LAZu3zeWUm/DPyyZoWTyph88hooWedIyZTPnd
         y4Xqd6HImr0dDeaafY97ZpmIsdCNZp5VUxSJAENc0SjaGoC8uUgKR1irXvsg0j10qUCx
         i0t18gNiJXTPhcCx92etEpud+kZWX3wTiTgm5nJqFc0MRkCEj51ENOkXiqDE+TNHnGkU
         toazh99YJ72LgD1TZeNxy3p2wYLO0rf3CbtweGU32AARYrTUi9uki0MG7NObNG4qfR8Q
         6dAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741142263; x=1741747063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+97ZVr2GLGNMwRJ+JHGTl73f9HD8d4XIQHgo+B51+A=;
        b=Pjpft7UP5RXic0K1YKiVKuu8MHirBGZ2Wlku9iPhFNQrFHI3GITq9TqOLetqSe/DXZ
         rAcKbdjzXxGmLJmtBkw37EEU5OnQsIIqZ0JpgxID+I3fcJOPt5yX8+pDCnU7TcRaUnaK
         RtBORXWZyAiOzXrXOEXm4kpYFF6eajzrcT+2l4YD2gixPpICyym20lwdWLDstT8U0nTN
         GjZRL3c/vcgAom99per7VbPOF2Bv9O73A/FZruZXjqOD7HnzVjqGdxiiJas3QZDPcLS3
         gwpTmF7Getf11reH6tp1yCQSdoog/eZTV3L+yHbKBUuDffPLgEro0tpdVJQk8Fw7+S93
         gtOA==
X-Forwarded-Encrypted: i=1; AJvYcCWRREA8WK3/5xwQlbrgKumFXK6GYoccVFREJatZuK1QSMonNqgi9tCIVGDP/CSl3HEzJkvlnt/X6DiPlqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxItLBtizulpg5qnncCtS6k4hEL5ixemvyMVrP/NXj2ZBR5VMT0
	IPYWKPtKCkWpeaHlbdHxlpnIvXtJTBrkNS0tGocXt5QIkzpTS8Em/lhb2CTXLzk=
X-Gm-Gg: ASbGnctYlOCvItL8jgBN/ejlPgF0myIUOmcpoVQuxI1G9O8DuSMFlC2tbHposEHh0he
	2UoQ31PLOuYPc+mwdovIKlMe5FhYDCsgcQWfb5uHKFVwk1Wm6jCPKi4iKqGxagz2zT4M7i+9X0s
	G8HRWw4IASvBxaytkxIuVeJkoLYE01zO4K1vx5GHPWlrID3faqbGz0ja7drXFaXtreIVmrvYg3t
	fl6z9D0UdObx2/kUMlt+8XoXdrt8VNoOIN68eAOA/1YQqvkYqNi4ICkn4//sU9iXMS8KhMLIHal
	4qllSWgLdXlEd0OHkzAM4Dk/MiNevRXdYrKUpPM9qpoUPbEzZ8e92bErZyAxqjVtZmSHKa+ZPay
	IFZZ6AZ3AKtZQbS2yNQwnEATi
X-Google-Smtp-Source: AGHT+IExjENqSk5hjjIhys2YXSgdpIqL5VVjIyb8jsl9tsSbsyXgT3nWgdPRJ4khQWdE/LA6vVB24w==
X-Received: by 2002:a05:6512:693:b0:545:c7d:1790 with SMTP id 2adb3069b0e04-5497d336432mr449658e87.22.1741142262813;
        Tue, 04 Mar 2025 18:37:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495ba98c6bsm1058122e87.232.2025.03.04.18.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:37:41 -0800 (PST)
Date: Wed, 5 Mar 2025 04:37:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/9] phy: qcom: qmp-combo: Add new PHY sequences for
 SM8750
Message-ID: <jr4lvgumvnjhybvwuo7crpjhaogjvet2d7llt65qzstjnoekuj@zx6z3npa37xg>
References: <20250304-sm8750_usb_master-v2-0-a698a2e68e06@quicinc.com>
 <20250304-sm8750_usb_master-v2-4-a698a2e68e06@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-sm8750_usb_master-v2-4-a698a2e68e06@quicinc.com>

On Tue, Mar 04, 2025 at 01:56:37PM -0800, Melody Olvera wrote:
> From: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> Add new register offsets and PHY values for SM8750. Some of the previous
> definitions can be leveraged from older PHY versions as offsets within
> registers have not changed. This also updates the PHY sequence that is
> recommended after running hardware characterization.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 221 +++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v8.h     |  38 ++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8.h         |  32 +++
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h |  64 ++++++
>  .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v8.h    |  68 +++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h                |   5 +
>  6 files changed, 428 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

