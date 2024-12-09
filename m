Return-Path: <linux-kernel+bounces-437667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 953DE9E9695
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6B82834C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C31B0406;
	Mon,  9 Dec 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adE3Ub5B"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F33597D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750593; cv=none; b=Lmcwp3xder/kNv4DD/k6KYTIyzx/x0eFtqAjTZP85e2UnhyfwNgh/Fh3wvdbh2YvaaqH74Pp2dejWbbDtXjrxhPWY+r5uOr6+BEEGAezqIsk3hlad68rZ9qHhyxzJWIYjWaDppUIo1b7WEgQmzpXRxO9JF1WVsfOQvGB3OLUntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750593; c=relaxed/simple;
	bh=04S6B0nJf9Hn+gzERCF/uMkmUx0R4j34PMLxCp3iOME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNMxh3TNtItLe1JLYNFX2pHT3AmmGAYiB1WpkoShsqz5WxD289X1TNdSIVjPJTCcVwQoQS4mIGqIF8HGMD8KQ3qvFXTjpG9o/WbdmqSUoYsk0XVjKbGe6Y6NWCFiP2GoziEj0/znEILo7rz2SXVifnVqZTRTmvy2HUk3tsmuMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=adE3Ub5B; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so22965181fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733750589; x=1734355389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1Q3KowuVs0mZ0rb0Ic9ZcrPzwsNDNKvHLsAlNmDHFg=;
        b=adE3Ub5BZfR6CrZ2XJUHI82jOpLKlD7RblzqWlFNs5L4C9VqHSuE0bVU8LmlzIj46Y
         wpwJZuPcKuvs/NBG5HwfgfDWgfgwBH4PXs3eHkSmXTkmyq/Wpl2cd5Pm9PZjb1jOfaqc
         3Gup/6gjbPgBAMha3i8Xo2tKgTk3HaGHocuPdWcNXOTIZ7smxJK9P130BXiytoJSP8GW
         /6G5JSFyO0UBmhgP69y8xI4GrKEn5kuPG/6q94ysm/ZgoXcpHKMgC8FftVzY6EygFODw
         50OZVTsGC3lpwybc2O0ZikoacQjZnSO91pVH9q8i5tsbXusnqSK8EK70t7D718AMD9Q3
         3CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733750589; x=1734355389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1Q3KowuVs0mZ0rb0Ic9ZcrPzwsNDNKvHLsAlNmDHFg=;
        b=hhyqU5/grvKHvdxr6IrfwHrHdT7zYxJNDuswJqs7x80NQuNDmoOk70xvLFSxTETpxm
         gYw7aU4aTdvzRVGAG/xi3ieebHCtVnC2PGgp8XY9mSnRJImJoNSxhqDtmGJxKERRShSg
         uq72M/wmoMmyNyqvBo01653GX9fH3IBTRZtoehZggsYfHpIaCGYOPrO/hLdcu66m6bC5
         tRDoHW/Sni22AHrc9/u/Gv0OidRBKlkUFboHjjCBeKsSod/Wd8OIKSElSAIldLXtUv7g
         PJMbv/seJYxfYgJX+EErAnoq7ZnLFfAchD2EYQ5jKG/AwwCQV6JSM8djx9j2um+kaF+N
         L6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9LX9Wrglrp4FasVQ7jtI350yhbwBQ9uKWv5f6R4+68YBoNmBVDPCgrwfJjBciYE34O7JhwFOCUqflPmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0fNsDY43FmmUr0cahq2XPel5knrsG1p6WatDf+gk5u3foQ5h5
	hlPDCUUEdGxmYIrqUoD4I6isugDbZw2TnnfvOLC52qUO7DGqacxxaZkTv1ZLLf8=
X-Gm-Gg: ASbGncu+1TliSRYFwv9FfH6neXQzOQeNO/WIbQykYNmmzzIeiVqn4eEhL/FMf6t9e5Y
	dKqGG5bMggVUA60NXwW4mEnwisvltxSK4cNDDeBEB8MsStfWUPBz/Fz60pgcrZyU5WizcyPLYxn
	jurpmKf1sSD4QedceH4DZFioZhEeTIpR+A0Ts92qKe/AX1gjNm1tYH1G0eu/m04hVJo/kwn6lcp
	7JbrVL1OhHNwtGq6ZWlqVn3iRfPnFuV6rjPTPo8Tjf/ResSvAMUw8emuLvcSuvMnAXehApMvMUl
	2x71vEdOAMx3B+pX2SlFPPXeHqh6qw==
X-Google-Smtp-Source: AGHT+IHzRS3kKeuBIaVbiSldvKszXqHDXCVoEU74JuhkpXf+Z7S09whtCDZ/ssVTFfacSGsQVfKscw==
X-Received: by 2002:a2e:a817:0:b0:302:17e7:e18a with SMTP id 38308e7fff4ca-30217e7e59cmr24900501fa.26.1733750589475;
        Mon, 09 Dec 2024 05:23:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3003b760a56sm8652811fa.18.2024.12.09.05.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:23:08 -0800 (PST)
Date: Mon, 9 Dec 2024 15:23:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Marek <jonathan@marek.ca>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: x1e80100: fix USB OTG
 regressions
Message-ID: <iw2c4fceyppf2w2gueevsqsz2z7hatbqo33vufx3veatprczu5@u4k3j2igy6ee>
References: <20241209111905.31017-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209111905.31017-1-johan+linaro@kernel.org>

On Mon, Dec 09, 2024 at 12:19:03PM +0100, Johan Hovold wrote:
> A recent change enabling OTG mode on the Lenovo ThinkPad T14s USB-C
> ports can break SuperSpeed device hotplugging.
> 
> Abel noticed that the corresponding commit for the CRD also triggers a
> hard reset during resume from suspend.
> 
> With retimer (and orientation detection) support not even merged yet,
> let's revert at least until we have stable host mode in mainline.
> 
> Note that Stephan and Dmitry have already identified other problems with
> the offending commits here:
> 
> 	https://lore.kernel.org/all/ZxZO6Prrm2ITUZMQ@linaro.org/
> 	https://lore.kernel.org/all/hw2pdof4ajadjsjrb44f2q4cz4yh5qcqz5d3l7gjt2koycqs3k@xx5xvd26uyef
> 
> Johan
> 
> 
> Changes in v2
>  - revert also the corresponding patch for the CRD which breaks suspend

As you are reverting two commits, please revert the third one too, it
breaks pmic-glink.

> 
> 
> Johan Hovold (2):
>   Revert "arm64: dts: qcom: x1e78100-t14s: enable otg on usb-c ports"
>   Revert "arm64: dts: qcom: x1e80100-crd: enable otg on usb ports"
> 
>  .../boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts  |  8 ++++++++
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts            | 12 ++++++++++++
>  2 files changed, 20 insertions(+)
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

