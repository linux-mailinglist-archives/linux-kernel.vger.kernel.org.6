Return-Path: <linux-kernel+bounces-535555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EBFA4747E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BAD188C29C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC9642065;
	Thu, 27 Feb 2025 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y14zn1GJ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AC92EAE4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630794; cv=none; b=AanwDlth6ZmDpDCYkUIFPVKEOSGTEP3XVc1GMOul7oH66RY3HP4YooA5U6EdWftECN5I1VAVw9NupwWILgvP3eMBBKTrDTltYQGpBBHcpSFQmMULabxF9ARRieqw6Cp355nNIfcoruG3LPjRUVHYPWsZ4TSzctUVYCLeg0WnH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630794; c=relaxed/simple;
	bh=YtZ5CKgC1l5YAr+QgfvUWGH0Dop2tg9dyuK7ovDLanU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bx99vQQ1PTYr3xM55s4lo8QF5eFHrGgabh/fNT5gdNyUIKb8OaV39h5h0bcQbvSagX5jV0cfgjNXuLdXSSf8n08IwkY/Y8ACNl70iWrEf3I7+OI3iz6lUmMMt1xGUFS3bNrBfE23K/LrsXzzZgy8DGvN9oYwQrNMtwuexs8ivw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y14zn1GJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30a440effcfso17520861fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740630790; x=1741235590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obscijDO91Mt88inTL4A7vtLGjjQitrqKYoQVkgXUGk=;
        b=y14zn1GJoYrYvUK/F8WVk8Qx/xlvIciq4I07zgZ2XzH+2lgpK8LxrKuVPz6kyc/sXK
         0TFg1k3e0uuEnbTkssAHm5a3+EpcLDs6IJ9v7eiYVxoJEOEeOaSgmclaPNGtpY72wlhY
         5Rgb4s0jBC4b1u+Qj1ITPUrMzvNTkvasrdWqmApj5Pei7wZr5IfCfdZBuFx0rmIySE/N
         yayS6ikiHsd3HWXTLRnYzTVeRhOywix84SSKF+ICTZVytj4dmJBB0oLyrqmr9VCSQyj7
         9Uj1yccnd3gkfxjAjtWvnUq/GsrhlRJvWCt5VR8Dm1kwznd/9uieDY0QTcCfYMnfuHak
         IHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740630790; x=1741235590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obscijDO91Mt88inTL4A7vtLGjjQitrqKYoQVkgXUGk=;
        b=F4e8BRbWA1alCOU0CWA/+jj/5YhLNyQrHyB8a4Q5FtjxbXAYY3Y1Km7ttcUWxn10Me
         8nYv+zXj7JjJC7dforjX0mCOnI9gNScz88c4oG0fj7t5dCHs/fVUGrIOF327pQ1VTWRn
         s7lA/wOQMCRqfdVZEmGgQZ0LWwG+rsLKXCCV/u0clIdPq/ACWuNgCVXcXeXZKxzD5Q7G
         QOKYA0fS8fMGPasqti/TEOj/z/KUGDvJP/dFX0dRetpnr02lZIl6jry64Vjw1li831RD
         TlVwXCu1IjS8eUoj0jAFzjq40d+pvX3S+3P3e60tj2BLkW9u6OXU1N5rTYWtmcvVNR9U
         l4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXQL/19sNbfa2rwcp0RdYHDL0EFEyC9hxZ23NfpxSQOmStMcN5O5tonf/ZW2oRvASbA8vBrUtk++yO67DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Xr0VXhoM/30cmmaaf1r6b9b5UR+uqp8GWlZf4BVno5fg0LUL
	W70p9ZBfVFNQdfPF86EUCrupWf50PA9/zDqyfmsS/H1yKzLdTLN7EwJlt6TPt+nGxzKpqo0wr+c
	P1M8Dow==
X-Gm-Gg: ASbGncs62rOPt1DeseFD3pI1dh5W+sHezQAbprIQZAnquayDk7SVF8fKsTQ+UYw/rKy
	PXJ/p8AcrWGFQFVR+BO2wN1n2FtnMx0SaeVYydYowtltsPPejkSuWwEtinBQztM3TlTYN4WERwn
	C/FTEyqIKDRLzrXh3iLlF7SNyvBMJGI6UbY3zddjf2tAqo6ndJMPX9Bd4lI6bSmWQ6AXrkHwrYn
	UH50nsRDbcdM6rjKilROYYMRTikwgPMxb4MnXJEU8Cs2z6iny0+fonHTJIMIP601YkSiZQO/kQn
	gwWb9iS8v4hJP2eE7rorbK9QAY9nq4si6UZZQcuBE5eGDrg3wAyrUIUV3v+DDYVqwkS3De+0p+d
	3+TJmsQ==
X-Google-Smtp-Source: AGHT+IHn49HjynasOW0d3PE6ed9GscgrGPeAaHZGAfjQ6cYekzKg6vVVq5xB21jaMu9bNtfIFG8yJw==
X-Received: by 2002:a2e:9d0c:0:b0:308:eabd:297b with SMTP id 38308e7fff4ca-30b8464b31dmr7624621fa.4.1740630790326;
        Wed, 26 Feb 2025 20:33:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b8685b31fsm610901fa.77.2025.02.26.20.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:33:09 -0800 (PST)
Date: Thu, 27 Feb 2025 06:33:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	patches@lists.linux.dev, cros-qcom-dts-watchers@chromium.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: sc7180-trogdor: Wire up USB to
 usb-c-connectors
Message-ID: <nnklm22zfnjiabjsbo7fsdigwx6nbcqjidhzynjyr2aunmk5r2@6m4dj45ddfge>
References: <20250225223038.879614-1-swboyd@chromium.org>
 <20250225223038.879614-3-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225223038.879614-3-swboyd@chromium.org>

On Tue, Feb 25, 2025 at 02:30:37PM -0800, Stephen Boyd wrote:
> Fully describe the USB type-c on sc7180 Trogdor devices. Most Trogdor
> devices have two USB type-c ports (i.e. usb-c-connector nodes), but
> Quackingstick only has one. Also, clamshell devices such as Lazor have a
> USB webcam connected to the USB hub, while detachable devices such as
> Wormdingler don't have a webcam, or a USB type-a connector. Instead they
> have the pogo pins for the detachable keyboard.
> 
> Fully describing the topology like this will let us expose information
> about what devices are connected to which physical USB connector (type-A
> or type-C).
> 
> Cc: <cros-qcom-dts-watchers@chromium.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: <linux-arm-msm@vger.kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../dts/qcom/sc7180-trogdor-clamshell.dtsi    |  21 +++
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  47 +++++++
>  .../dts/qcom/sc7180-trogdor-detachable.dtsi   |  16 +++
>  .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  47 +++++++
>  .../dts/qcom/sc7180-trogdor-kingoftown.dts    |  55 ++++++++
>  .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  55 ++++++++
>  .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |  55 ++++++++
>  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  44 +++++++
>  .../qcom/sc7180-trogdor-quackingstick.dtsi    |  31 +++++
>  .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |  57 ++++++++-
>  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  47 +++++++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 121 ++++++++++++++++++
>  12 files changed, 594 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

