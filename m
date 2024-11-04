Return-Path: <linux-kernel+bounces-394676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9CD9BB29F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C63B279EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C41F818B;
	Mon,  4 Nov 2024 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDKKxYOT"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67231F80AB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717752; cv=none; b=HMA/iQQGAVLutFF6l6x0niyAWOAZ8IXpC1t85TNgySDhYj4Oo1nSPObBNa08+weq5LTwt99WedCyWTSGVKdfj8LyZCChDGjieEUiR+qz30++sE5YgqlVKupQdNdq8oV29OnQI9EUZSfzIPLITpxxrlcHilnFyRrhyWZfYAZP6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717752; c=relaxed/simple;
	bh=c8wGjkPlYVNRPfGqZMa6pSmboLrkZFgSexB+/+qfnkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh+Gp1QFmETD5mjq/h2A+KAxOUwPTnDEYPBV81L51xIDGn7+DrNzOK7a3djXLkb7Q4DjCLCOXAnqvdL7ajANxZfi+BJ2kCXmfUIDvpB7CcuLtAnpjmyXKYtyaFTb5+5mqCzRB0RTYF+arRG0xfCs0IQpV1fDQtJ2cBKW86qfb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDKKxYOT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so28200271fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730717749; x=1731322549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=waBTGTBlHfd2MNV2pSDkGRfLXdLzKoYk2Pq0OYzBkOU=;
        b=iDKKxYOTav3FlKlyvCIY9PRTCGFxKIM8oKRD4scy+A4gwAo3AwXDGcf6AQV2+kKSTO
         O6c787h44MtAcNmgIjxibirN+4iT07SYswIJXN08I6F3XhY2owDrgAiUSTAInFhlmCec
         Eobu8WCPM+jBTx+R2tIM3D9M9HzJYCO/j/a1aKx9rgFPQDm5lc56499g99bRq9W2Hi/x
         cxnSijgQ/fncTOUoDIKFKJV0eHyUBz+8Jn6fB8z+xQr9czjluCpvc46HzW3WHGVKJR31
         zp4G0LeloJpgy3rE9DzgKTCyic78TDu5l/SK45flm4pxaYs9yQGhWZFI9xPh5Zet2332
         VOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730717749; x=1731322549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waBTGTBlHfd2MNV2pSDkGRfLXdLzKoYk2Pq0OYzBkOU=;
        b=IAHx0oyG0Ht3RcZvej31TM1hAHzdDf8U5YMMnyP7bZAEEOHcjoJ2WD8Wk5xfTPr0Yx
         Nkhvd2+Ksd92ZnOilBft8fsAWIG4B3IZRmO/G1Dm4v6SjwyaAH8ypBef4VsQrNU+lGeU
         4b5Mvg2tJ3pAAZj/99HIrAeDtpGWrAPnFlXPhYiWh0nfaovIMPlaLl4vF1U2MgdW/PDo
         Il0MY75NlL2/Bn9RQ7uuaBrtkEfWkx6BwG2WBarxHIAMeNazMRaYVskF4lhDG+moCiws
         +mQ9ZiDsF/jiTmL7NMTBPdKsZ6BKWVO6sWrYlOa7M4av0g0cJkNzrrPrskaQv3zJAC1T
         gWKA==
X-Forwarded-Encrypted: i=1; AJvYcCUBHHUO9OeTDTDU5NlbhdMu8Tq0b/2qa1yiltp3vT8AEENXAjQQ/IhVyD/NFoIGmnVb7AbEg8qbVY8c3R8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0npcgAkjUEJgYB+CTSJ2hvpgrqBUS9U5MDYGMdz+FCG/QbhT
	cL3qpLL1dPKK2tGU+yMupALcWn1eVWeDQdbwUQLwegqyK9vnY/EkzwPFd73kKEK69KEeFC2XVAS
	gWKg=
X-Google-Smtp-Source: AGHT+IFIdshEtjyMvc0qsRzAdG4WZnPMu9TjKvznb5pP5VfP0Yu1NA7g4L56eiwhpWFlir9ooEF7gg==
X-Received: by 2002:a2e:4c12:0:b0:2f6:6074:db71 with SMTP id 38308e7fff4ca-2fdec5f831amr53140821fa.17.1730717748783;
        Mon, 04 Nov 2024 02:55:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a6404sm15870731fa.84.2024.11.04.02.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:55:47 -0800 (PST)
Date: Mon, 4 Nov 2024 12:55:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] soc: qcom: rmtfs: allow building the module with
 COMPILE_TEST=y
Message-ID: <eac2ese3gmzkdxhmgoj7qfs35izrgb3oze5es5kr6wn64t5guy@bpbolwqttdui>
References: <20241014130303.123394-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014130303.123394-1-brgl@bgdev.pl>

On Mon, Oct 14, 2024 at 03:03:02PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Make it possible to build the module when COMPILE_TEST is enabled for
> better build coverage.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

