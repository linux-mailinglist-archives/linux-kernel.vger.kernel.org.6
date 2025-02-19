Return-Path: <linux-kernel+bounces-521336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA36A3BBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9477A6DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D80F1DE2D7;
	Wed, 19 Feb 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tiDumWSU"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA21DE2BD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961625; cv=none; b=kbD4z6HHjhycD5SWAJXix9WwzyFedx+xj8CgCEfz3ehl4RlXrF/eoNX7zuxUisFbHvZdYbFLgM+SMyvV3hiQ3Cq6Jk25mRbMjfdldIaGUBkBTqLY2MlvnU7j8uj5/gTPxEacqVyF4mtfUZ/AQwl6xCyIpocbx+NKiSwdiJz8HOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961625; c=relaxed/simple;
	bh=+Anp7Lg+FVfajyUS0vQIj16UIiLsxJxFxYN+q8tFg5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsD4ApqO5prcZ129OS1zsN9KlEuvsN14mYXQj4aHvWyMNI3d2vMhSs1RriV2C2L9ZLhkXqMrlpn9wIfjt5p9Y95oeO7zhGTuJelYFAQqCEhhTYVACgIa0lmnU7SyDHfBfg/ss74jYw2YxniLVLflWoYkd+3vbjSQJAO0QxX2SAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tiDumWSU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f3ea6207cso2909955f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739961622; x=1740566422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oTpEssmUoRIjX9Gc5CypTsWt0/nZ9V99gdm6sCPaUhg=;
        b=tiDumWSUIen5vA5PEKbxRhze1OoAEXKqdQVOEKPbXK2dwq1GUIO2PP9INjhAMT+OuD
         ATpTp89gX7FPZ2b57cu+BuA7v7AraLwLN3pDxegSQuozJ7Q0ujbwBiORytZnhRkG0Udh
         mxoZjdpgWtrsOC4rvGpkEi0p+MVu/Ka9+c/QCS2oQIZrAHzXjvmK/pbN68w83cxyUzgP
         bpHSZowD2Jgm44cUjTc9HjBRvYF/yHOre4KsKj9ZCdEwGMvNm6AjREINTSuzatNj5bVO
         bvkpU9uQCe/Ez6MlAFBEXBXasoCkPttbwfvx9Es9BuzoU1nmoghlwtQtwdKlnpGm8scc
         E7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739961622; x=1740566422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTpEssmUoRIjX9Gc5CypTsWt0/nZ9V99gdm6sCPaUhg=;
        b=Ocb0wI61abt5mqGHEx8nyqXnmHXBfZEGa06IsWzpeqgyxgxL0gMugqeZ1TqQANRyPq
         B0/Ri7RLCQ+4qk824NVkg77iUVB1dbp6vSXgkA+UwGgUBz5fMYEMuBbhdEuJ3aYLSh/o
         ZhhAO/TaPEP2rBLCbT7pspDuCzUy+qoJpCvHHIn6Rv1jgGUoZO+Q7M93kBvh+d3JnC/d
         rtC65NR2zQgUemxaFR8x4zi2tYKvD0PV8QL0TpX3oJlXsKD5M03csS+gvvWgTWD0KnqR
         K4GEFyHJneyNeJnkXPdZRXSqmdNze8zjob+toWfpTTUyaexVDIrrLlgn+pVC9rV4qV+4
         ETIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGURdHoZ1ZiZhbQbtpIlGfGP5pOa/tifBhnoK13jrTM24OnJc2fchNm5J+FznwEyngqPcvG0Sm0toRqqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTv+4xjOkn+mShDBqrKRIA8aQRgsHr3cte5NhqMCHFL05tLtFh
	sHgIPIwPv2mq2lKetar9abI1052Lp8Awlizh0dCWo+J5zSg0mC4FSrcpnzG7wH8=
X-Gm-Gg: ASbGncvB7oaqD5170BYt0rwgQaGQloE5ahUtI0fax6ith8vtUIRFSutQap+5NLMuB/i
	kiQmG/5YmRoHv74Z7WkPzji73sTvMcUsZhY1QjPxf3tc7xn0YiB8WrNunoLdVpWiH0japl//A4N
	hobUpDhAnFT5EjH/HB9p1nUVHopqdDWh+Prj84NXFRw6StqtM8JDW5UPDkrAfGlhYKlh/qaAnbL
	eLcIZNzEuGXohiQF9EEZqYaoFPAKgm5oB8CD24e/2plg5O+wE4lXRfh4PU+zLRpb4rf+40EyENm
	uAM3CiHV9Zig61YL5FABZqPM6TQ=
X-Google-Smtp-Source: AGHT+IEWjgG7pbgCzAJkKiubwvHKifXXf7rgGGj2vJdSFL2Ufsb0tZitD1EnLcEdqieTl59H6i3ZRw==
X-Received: by 2002:adf:ef46:0:b0:38d:badf:9df5 with SMTP id ffacd0b85a97d-38f33f39223mr10831845f8f.17.1739961621535;
        Wed, 19 Feb 2025 02:40:21 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:6f72:6161:57cf:1c9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258eb141sm17162624f8f.41.2025.02.19.02.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:40:21 -0800 (PST)
Date: Wed, 19 Feb 2025 11:40:16 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 3/3] i2c: qup: Vote for interconnect bandwidth to DRAM
Message-ID: <Z7W1EJ7uGsaTZMRh@linaro.org>
References: <20231128-i2c-qup-dvfs-v1-0-59a0e3039111@kernkonzept.com>
 <20231128-i2c-qup-dvfs-v1-3-59a0e3039111@kernkonzept.com>
 <5dr5ps4vb57xj2mfelgsxgoyrr3gg4ggwqggqchff6pda3ffsn@thxpg4h6kgel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dr5ps4vb57xj2mfelgsxgoyrr3gg4ggwqggqchff6pda3ffsn@thxpg4h6kgel>

Hi Andi,

On Wed, Feb 19, 2025 at 12:02:06AM +0100, Andi Shyti wrote:
> 
> sorry for the very late reply here. Just one question.
> 

Thanks for bringing the patch back up after such a long time. I've been
meaning to resend it, but never found the time to do so... :-)

> 
> > downstream/vendor driver [1]. Due to lack of documentation about the
> > interconnect setup/behavior I cannot say exactly if this is right.
> > Unfortunately, this is not implemented very consistently downstream...
> 
> Can we have someone from Qualcomm or Linaro taking a peak here?
> 

I suppose I count as someone from Linaro nowadays. However, since this
driver is only used on really old platforms nowadays, I'm not sure where
to look or who to ask...

At the end, the whole bus scaling/interconnect is always somewhat
"imprecise". There is no clear "correct" or "wrong", since the ideal
bandwidth depends heavily on the actual use case that we are not aware
of in the driver. There is also overhead when voting for bandwidth,
since that can take a couple of milliseconds.

The most important part is that we vote for any bandwidth at all, since
otherwise the bus path could potentially be completely off and it would
get stuck. My patch implements one of the approaches that was used in
the downstream/vendor drivers and matches what we already have upstream
in the corresponding spi-qup driver. I think it's "good enough". If
someone ever wants to fine tune this based on actual measurements they
can just submit an incremental patch. Right now this series is blocking
adding the necessary properties in the device tree and that's not good.

Surprisingly this series still applies cleanly on top of linux-next. The
dt-bindings have review tags and there was plenty of time for someone
else to chime in for the driver. So maybe you can just pick them up? :D

> > [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/commit/67174e2624ea64814231e7e1e4af83fd882302c6
> 
> ...
> 
> > @@ -1745,6 +1775,11 @@ static int qup_i2c_probe(struct platform_device *pdev)
> >  			goto fail_dma;
> >  		}
> >  		qup->is_dma = true;
> > +
> > +		qup->icc_path = devm_of_icc_get(&pdev->dev, NULL);
> > +		if (IS_ERR(qup->icc_path))
> > +			return dev_err_probe(&pdev->dev, PTR_ERR(qup->icc_path),
> > +					     "failed to get interconnect path\n");
> 
> Can we live without it if it fails?
> 

of_icc_get() returns NULL if the interconnect API is disabled, or if
"interconnects" is not defined in the device tree, so this is already
handled. If "interconnects" is enabled and defined, I think we shouldn't
ignore errors. Therefore, this should work as intended.

Let me know if I should resend the patch or if you can apply it
directly.

Thanks,
Stephan

