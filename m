Return-Path: <linux-kernel+bounces-437266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1157A9E9109
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9D116198C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E30321767E;
	Mon,  9 Dec 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJ3NfQyg"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558C130AC8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741780; cv=none; b=WH2CNK2LpTMBBnydveGrOFDDdFAG081S5DGnb6EgVz6coPT4i1jpv90kVmIa+gZ0r29vZ2BJjC6HAY1PzvM6yE5jPOgrAaYM5IsMrdC7g//9gcUMesECiskPlOsgEQOz05PBOu6o+zmtX2EubmMRiBMWtF22ifGff9LYLnXsl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741780; c=relaxed/simple;
	bh=MvjEr+QmcBYSFD+4yOMfFy5J+y5/erO43wRjxGBp134=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyZNU8z+y7+UrVX5SJ1ubsBFH+5sJqn3djtef5sSWq4aDb+rp6pakrmYm7rnuzxcWd3kGz5UMplGaEcYOG/9jEkO7HYY/kWa9//n4taz0FZnU4bpTQKPxYP+06EhBJ6qV5vLCohRrrqnPGFeeQPwHi1TzYpSOpjDcxbDQ3hb1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cJ3NfQyg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5401ab97206so1088744e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733741777; x=1734346577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1LCGkepE9BNY41wwancZQPMjgbX9qpsMb1C/mBNuBo=;
        b=cJ3NfQygvrCnHUz1YhqypYJYiFuhT4uUwvhmpez3mjHDRzZZRMBdFD3aBlcQocSGVP
         QMi9lDv2NlEC9MDche/rEAOuJn0/+NKCZUQaM3JZvP/s0eavqk9x/oZQ4/8i0OwnNJ79
         y7OWe777vevFgqZ4gsWQJG1FpXm50ZYyihn5tOKOw6sqz/MX7fJW1/rQru9iQDUpLZc2
         gSgyqQQAM9ODTyP99A1dr+DRz2hUgN5NXcaPNJv7NREy0v+kAma9Zaj3qbG9AqFLpkC/
         yyrxMf5SSXNA24r+g0+leBQupql+B1aG1LhQANzOnk9wwS880CRLDnL/cUHnEhSPFNmX
         9w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741777; x=1734346577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1LCGkepE9BNY41wwancZQPMjgbX9qpsMb1C/mBNuBo=;
        b=gQXu0XrdSo1ZxAhxEelOVS0OPOSCzpDNnvS1hqFSEtFrprQqbpIMR1ZK3s2gsgWBiA
         omzFpdyB52/zFOF51P8Sfe/n3GLYXUEtLN9pPA0ANa3zwl/xSm5IC7+NKvSwKVUOZ2jk
         7R1QL6mLYUKPiFsVODNjd9Cpru0bnu50Ela4oSxBD60V26Bq0xPdhc/0skagZTQEB7aX
         HSE1o1QuyWuM7Q7WhkKmyZbl/DokrDMVNE7bBhRflyDTleVvswiKRPIwtaMC/gKQPC9E
         WlkcPONgdZ63pzIwt3SuyRQ2+4te8xBnSdvpY85buQ7nAdh8mSX6LKXzXdJMofC40G7Y
         2Rpg==
X-Forwarded-Encrypted: i=1; AJvYcCU7aGdW6IhE0i0kC2xi984MA6srJdJyeqFL8AGN9KvTG3xs+ZwXDZ3fItuMTuVTdydJorRClZ+FW3/hLPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVEPpST7nQRe1mvjMyB4+g7BDRTQGK+7pwcqppIyKSGrOqJHKZ
	cRGXXSrTxvqQN0j09G1JPKWITGYX4FFMz7tFSdHlpqt/MofLy8LMYlUFTovvnPU=
X-Gm-Gg: ASbGncuVFdgfRctMdTbVKQRfYg+Evq6HQsevnqENAbBn6+cr3a07yqbSQNTXGc0IvjV
	X6ErGyJA3brLJOmL48FkjvgA7jTVArbodhch0TpXiZ1UTBF/G3pl8aobYO9llhY3ioWHJamnwYK
	9rdDoIpsOs1I9r38uDBEyKGn0YJZSc2B6CvP4HDr4n3nkbe3kZUcieYn0EaflTcj+4d93K2MEXy
	Mgwd5pdc7Vurh/iS0oxxMPm6ZvUtGaXf3/VL7WCdKeGljpyJp5St842Ni+eT5J3yj5P80F1R0s3
	iNXsDEadF2wb/daezo8FqyNtspXpZw==
X-Google-Smtp-Source: AGHT+IHLQhW4yrOheTO3FKBH2BMc3+YO6hNqRhmWtxjdDrWhydjjQ8nuO7eWSOcahHRapkZ5ee4u3A==
X-Received: by 2002:a05:6512:3990:b0:53d:a321:db74 with SMTP id 2adb3069b0e04-5402411a69cmr1638e87.50.1733741777425;
        Mon, 09 Dec 2024 02:56:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3745b0bbsm930193e87.185.2024.12.09.02.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:56:17 -0800 (PST)
Date: Mon, 9 Dec 2024 12:56:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/4] arm64: dts: qcom: qcs6490-rb3gen: add and enable
 BT node
Message-ID: <cros4yf4mwtu24xdpevpixlmtt5si6ywjzacezemhsmkfsomgx@gtjaznwqvjsm>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
 <20241209103455.9675-3-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209103455.9675-3-quic_janathot@quicinc.com>

On Mon, Dec 09, 2024 at 04:04:53PM +0530, Janaki Ramaiah Thota wrote:
> Add the PMU node for WCN6750 present on the qcs6490-rb3gen
> board and assign its power outputs to the Bluetooth module.
> 
> In WCN6750 module sw_ctrl and wifi-enable pins are handled
> in the wifi controller firmware. Therefore, it is not required
> to have those pins' entries in the PMU node.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 168 ++++++++++++++++++-
>  1 file changed, 167 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

