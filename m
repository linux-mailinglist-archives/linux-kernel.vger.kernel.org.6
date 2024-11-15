Return-Path: <linux-kernel+bounces-410930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4858C9CF258
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5892FB3EB0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFA91C75E2;
	Fri, 15 Nov 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dm8f46Do"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE71DA23
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685250; cv=none; b=oCEbttI3fvjGIINnLCy8PKtKQNNN2sCuRn3N9m0iNa0cfpR2aINaJskw8FLHGPJVvH1gsOflI8P7bbxlrEohGJxTkcrLG3CsxYAYYL8nrRrzfrbQX09eB7fR/gi1kl+Lcd22UHVIdq/JVfwlpEPWvH5IZd548s7opCXnMFTl2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685250; c=relaxed/simple;
	bh=e1BsjWrK/kzNf9cCgD7tXTxvlV9QNmyd9j9wKC1xxNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAioW8blzXRvTDQL8c2LIy8L8wyCW2hvBBlRofE/FPz9iQcR53aAa0D4X+dU280veGQUXsYQCUtlxTmk+tuvHNFTbHLjsstNH711qAg21HdVgMmc59PucoI3oSLOAnjDAiltzKa2bl4lqOxypiDwanhBJmAwEypyjInlGqcqtpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dm8f46Do; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53d9ff92b14so2099952e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731685246; x=1732290046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddEutbtPWg1KmTucj3taFQtrXu2EJy6K8zzDaRFp7s0=;
        b=dm8f46Do7FgLGA9b6rp+XaBdYQIk7A46lrz1H3RQLWehUfA9+NZh/jkJM1TXfdtz5G
         MtbUkoBKrCX8MeCluRISLAsvLWEe0y/c2tiiSk17eqYkp/xpGtbLxve25C9TcmRtcf6z
         9waVoMMOA1ZT0ehskotBFdJCv9jlpebaIjkACl95+hh5pUBRRgsz8SM3mHykPqdyO5DH
         Msj4k/vPQ4Pky4VZ27CGmOdw4wiYsfov0exVsj1UpDeTL1JL49DBcBB3RAT7JYg4v5NW
         vxSsEEQKyD901XT4LHsS5YP8FvtDFKrlzMVEJ8V9tc/0QGlQwZiQl329BXTq8YvOKV/k
         PU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685246; x=1732290046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddEutbtPWg1KmTucj3taFQtrXu2EJy6K8zzDaRFp7s0=;
        b=AUrsGyyJIZwfeX4W3Xnr2rwZFO8DgQgaS+XlGgQhSg/cd4KvLhRGroKgfjXgZ0xzPH
         LdqEH1iRjyg4GcHP+b60b8I8Dx53Q3ogBcmbWa3kB9Lh2iuhE3EgsB+5QjXRYjMcObS6
         JMxDtGD3G2dlqetcU9KcxU9v94+XvdFwKBcsPAhS4odo6weNVRchYJx0kQVeOJVeM9zB
         Ii/tZyEpAys76e3Kb7CtXVWuacx4kHCyy6EuvEYPOxYzyeez1M4k/q84Ky9aTbKMHZLj
         FE1xHcKLQIMZq2HQZtS2U+AcdqM1igOYg9sm2pYLs/DriTE6y2llduAQarfRITqbrUC+
         RmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhnDxIiZ40Z9iY5KvqvP9lrF12Q5D1QCSKhK22rqydSchJce7skEodesXIhgCuEW+shFZRiL9eNNJu1y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0c09Q4SHf+yJHTSdDI2xzgYdEZoMM8pMXMZ/dPXXHVm5MVYmJ
	RUwf35ZbPHgEgzT6AvdXaHpKhT8HVFyjUa7UYpksvhe5o3lESZCzAf3IHzG7zYrocL+JKTtsz2N
	Z
X-Google-Smtp-Source: AGHT+IGiWuk5Q66NHJ3LjXN67sEupBz252YAxeBkL4RX4XijCDZTBhhYO6iJP7cDergE3QFssvqbkw==
X-Received: by 2002:a05:6512:3b85:b0:533:44e7:1b2a with SMTP id 2adb3069b0e04-53dab3b261fmr1703126e87.40.1731685246352;
        Fri, 15 Nov 2024 07:40:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da653104esm609956e87.131.2024.11.15.07.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:40:45 -0800 (PST)
Date: Fri, 15 Nov 2024 17:40:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: qcom-rpmh: Update ranges for FTSMPS525
Message-ID: <d7zkmr3kdgrtyxettnhnt4cscxodsxertmocsgtpqdokjhi7z4@ox32a25ekbfv>
References: <20241112002645.2803506-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112002645.2803506-1-quic_molvera@quicinc.com>

On Mon, Nov 11, 2024 at 04:26:45PM -0800, Melody Olvera wrote:
> All FTSMPS525 regulators support LV and MV ranges; however,
> the boot loader firmware will determine which range to use as
> the device boots.
>     
> Nonetheless, the driver cannot determine which range was selected,
> so hardcoding the ranges as either LV or MV will not cover all cases
> as it's possible for the firmware to select a range not supported by
> the driver's current hardcoded values.
>     
> To this end, combine the ranges for the FTSMPS525s into one struct
> and point all regulators to the updated combined struct. This should
> work on all boards regardless of which range is selected by the firmware
> and more accurately caputres the capability of this regulator on a
> hardware level.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
> Changes in V2:
> - merged FTSMPS525 lv and mv into one
> - updated all regulator structs
> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 83 +++++++++++--------------
>  1 file changed, 36 insertions(+), 47 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

