Return-Path: <linux-kernel+bounces-227251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8225914E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782FF28559B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B2D13DB9F;
	Mon, 24 Jun 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBhfsXR4"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2913D531
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234663; cv=none; b=oQlqCNEym8sjxP4aVhjGAwy68YRtD62dijYqRt9ymjPMuHKCI9Az7/aAnn4r/JpdES4fnXWMBUpgu1MlEwcIlgicaIiiI/wfXDUALfkVlb/Zlcbp99SDvOELbGaAoaukT913Mu+MsyFrW4GkNXkPpcSc7uWnMG7Dp363sVDVxtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234663; c=relaxed/simple;
	bh=xGJaHKJwyhWl+hAEdZGvosuidOGTbGyxm1SE3qgRRf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psMQeWjxekkH5KlZD2kB9IR+ZDVx+WiMDWIo1UW+Y5q4lweQIo7GDl+YApoZGGoaJhCaq9z8KFIEbpOvweHBV5XPbVHeEmBSlW6SvsTjQVKS4ch7/gYtPG10OVheoXE1xtgi1T32/HDBH9O4shb+BzZ+b/bxaaOTWQjuxiirnhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hBhfsXR4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cd8897c73so2992028e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719234660; x=1719839460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yXZVn39uAFhs3+C1LuYu19O8cafRf9RIHdluf7Xz6dE=;
        b=hBhfsXR4KAreIcUZmWnH4y3VTwDTqcRNSV99DbsSFe/hKgeB/knPOWG6RiW8O3+2hF
         dzpH6NzXtAge24UpebarjA+mqoGsMSpw/TS3qjYfcUte0FbxZR6Gk9IVrjoWGd5okbe4
         GPtKgwmcYQ0lkSM7fGR7KlBehTfxdr/WGASPIweftKd9W2TxGdw0aYYUXPYhmwgwQ3kV
         o+vdIEFBW3KwmaQ6WITwMPI8fzLysB2mGlzE9EOTTIZAzbuRuVUX/WDDVXUKxJXRhhEa
         /d5RWPaqEe0xSAZqpIpSuiDjp8VbDenR+eUEDhvWjEzJmcl1TidRlozw6mdptt2hmZEh
         1u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234660; x=1719839460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXZVn39uAFhs3+C1LuYu19O8cafRf9RIHdluf7Xz6dE=;
        b=Zq47Jbj10HPGM1v6FLRBFqWg4Tq9/idjzjQcFAH6v427BOiuZEkIfOCtMg7bdHzJZa
         MJaN05OPEiHAEWgEUPPbWzrFCz2NLKDTFcXtJhjPvPTvVEsDOERqCe4QfUUMNKcPxBHA
         sEmJJVonBNaq1UYu0igjdJlqnbf/WzlJtcchla/NPg95pSwBWuDIC3NpoKm+K7Om7D36
         uOaZnb0ybvZNgq2zC8a/12ZrzaYP7n+B/71XbOcGAV7TRyG0cMMfYPBK7kMf2UwgViW6
         y5wNuL0woNLvlhQ2RzU19JNVlkjE6jYs/CK5VMLw3r827nzhjD7ncBJ5cGLF18ChzPJX
         Qw1g==
X-Forwarded-Encrypted: i=1; AJvYcCW5Tg0Xvw8gifJ4GFduxVZEIZVjb/ZfhMb0cSU2b1NW4dos9UKRkllCI+U6nW+XJO9AIEQAS95T+HWawE8UvhOvbScna2ORremXFYCS
X-Gm-Message-State: AOJu0YzyhI0J97Y13ZcGzmpNSFk6kx2o0FQZsihje+PrJWnrjU/sPWDg
	P1xxOjeJcMjnXj97gd1rrg7D4AgrJMM8hndKd1zt7FwmPEMfBOQk2vAcFugoZCs=
X-Google-Smtp-Source: AGHT+IFueE8gynLR/P2KeKfrRv7tISR8x9woq5xEOkvIzjjkg5eNCFX/5IAJGOQFKoVmCdePjO7F4w==
X-Received: by 2002:ac2:48a4:0:b0:52c:dd21:8a2a with SMTP id 2adb3069b0e04-52ce1835057mr2259242e87.21.1719234660314;
        Mon, 24 Jun 2024 06:11:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b460fsm983524e87.26.2024.06.24.06.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:10:59 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:10:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8650: move usb-role-switch to
 sm8650.dtsi
Message-ID: <sq64sf2wym7ti33sadtkvxrdtnm6pm3j2hgzx2ousnzpvwrmnz@w4qcsihnwsgf>
References: <20240624-b4-rb2-fixes-v1-0-8d763ee4e42e@linaro.org>
 <20240624-b4-rb2-fixes-v1-1-8d763ee4e42e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624-b4-rb2-fixes-v1-1-8d763ee4e42e@linaro.org>

On Mon, Jun 24, 2024 at 02:23:42PM GMT, Caleb Connolly wrote:
> All sm8650 boards have role switching capabilities, set it in the soc
> dtsi to deduplicate things.
> And drop the explicit dr_mode = "otg" since it's the default.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 5 -----
>  arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 5 -----
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 5 -----
>  arch/arm64/boot/dts/qcom/sm8650.dtsi    | 1 +
>  4 files changed, 1 insertion(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

