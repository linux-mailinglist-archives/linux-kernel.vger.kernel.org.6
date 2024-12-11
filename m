Return-Path: <linux-kernel+bounces-442356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146E79EDBBF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079A916308E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67671F238D;
	Wed, 11 Dec 2024 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAja7mNW"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEFC1C173C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960032; cv=none; b=c/8io+kKkXffQcYk93Lqz7rtj/1xoN1pwZ+8OVspt9FDW/MJOp9vJkmzBRkenYaa5Nmj/r7mak/EKppTEqY1oE+2L2/qUWRQl2wtsrWSzch4KU+wsrrV6w3yPwwIKadcbQXXc6Ytys9u6vMxS4XfvOwpjBFyV2NSqTQqYG/Jefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960032; c=relaxed/simple;
	bh=i4+UtDhBjO+YU7bZFPO8OB/xszwhppBjQznZ+O1+qmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3I0VSw5LzQ0enIvm310kkrxXcm9GJzv6efmKumBGhTp45j8VzoPMCnx+fPXU+ckaFbfaJfPJQN+3D10GTbbOg2JuOYnNIRniyZcw/6fQsHgqBeJJAwkU6uvmet9JEzcrLJwx3A2LGoC3CPVdwg3uTwsd9HSvp3dszIjQaz2/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAja7mNW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so35295a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733960030; x=1734564830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q3au5bmUxQOxRzXtBZeaF/N/DbzaLEIexfI0aIxChA=;
        b=oAja7mNWlT8U1PPUXIHtoTU8VM+XrgcQg4PH5n/oQhFH9neg9u56C4vPkVq/XFk7Np
         Jt3L/98Ya4HuGg9heec3PAPpAXs0FA7YHh5pV97EX0ZIAm0j2p3M0JVrPUjrb5LgaBIm
         wjxefKk4H/r+H9BeSLQemzw74lqXhXCN0fQOkH4eYvjU1GBzB016h8UipTpscIBcn6bJ
         LRcsLZ4AdKbAxUGSOn86H8I7nbCOgXCViF36EaxHQ/Ktt2IZ8WJ2SLoSgA0cL0AOxvAY
         GmahaZmRLxXCA0n92zclM9zbWXr7rxsFIVfJEHZtknoxRkhH8VWjspJG0Z2SdimH8alL
         uQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733960030; x=1734564830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q3au5bmUxQOxRzXtBZeaF/N/DbzaLEIexfI0aIxChA=;
        b=h7S0hOySj/Z2V7Pg0v5Z3v0KaHFd9jSrta2qRY7apKgbUSHk2XEnoKemK7kSsJ041K
         9NyKoDSTi3v/T5g8rVZUDQt1UgnXF66XDJ6KDrhEH2gDDrILJzDHh69oLvWMpCE/WI0D
         WmnZTakRsjzgYgncsXnZKsa1RRFL9aRS3+yvzOzLPwdnS5c0xykhQV2hG6S1dYopvGdp
         JHSeMaPpp/wI47w2ro4UlT7d2LhvNZnd3ouQbSgmFWVb3/2FJaMZyXO0auco851IEV13
         wLsmCx7jnFE/EBGWq+mVfEKBCDnhTF4XtYItB32NK/OXhF/lE4lGbvapcOtaXgNOxbun
         TuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWRIbbc8inWDpGpoke7jL+gz9h36XdC8EhVyCM5+1dlyfEMZ2ef+CTrKs1f4x5bINtaxzS7dQkY/9vDaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8NI1PpYW1981kE3xJkggo580K/1ulKItFvGMIkPx63Qt8o0r
	USfDSrlMyMXUDZEfjOqwJF0S8wp8zSO8JFETtoYBC+Fk/6YWAw2o1M8tV/l50g==
X-Gm-Gg: ASbGncvZKJr5Dqb5bExvVQUQtgn13pD3Z9B0imZIJOsPw4pU7pfdMDtfBNqU84M1TR2
	Dh6aDw3U+nyQWKziCNq9psLBy9Fvo55Uoq6Vvo5bGKC4TwrP8bTzcT2VgdFVWqtqsMuTcuZ5aj3
	OFj9DCdOsAGaGZMx1idPMYdNW7nT+X7KiMxAa7iHAXspw/mXh6mEOkQ5x9BrHyN8oUBBGZG12O0
	TpIhA/uoxP6xhsIJNHdyP7Y/6rFYkL0uSY33wfvYGsuS+mRYg+ncqAQI7D6KY2CyV/EY8RYpJr+
	/NNS3u33oEELElsNX1pofK43
X-Google-Smtp-Source: AGHT+IG8aD1Qqh3kEUiTPGH96yIdNZ1vUy+wc0P4hxRimnY8FEv8+p/pdrOK7wiPfxZc2chXSialWA==
X-Received: by 2002:a17:90b:3c45:b0:2ee:f550:3848 with SMTP id 98e67ed59e1d1-2f139257803mr2750010a91.5.1733960029821;
        Wed, 11 Dec 2024 15:33:49 -0800 (PST)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef7ad1293fsm9023217a91.34.2024.12.11.15.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:33:49 -0800 (PST)
Date: Wed, 11 Dec 2024 15:33:46 -0800
From: William McVicker <willmcvicker@google.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel-team@android.com
Subject: Re: [PATCH 3/3] mfd: syscon: Allow syscon nodes without a "syscon"
 compatible
Message-ID: <Z1ohWoq1jEFgR17P@google.com>
References: <20241211-syscon-fixes-v1-0-b5ac8c219e96@kernel.org>
 <20241211-syscon-fixes-v1-3-b5ac8c219e96@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-syscon-fixes-v1-3-b5ac8c219e96@kernel.org>

Hi Rob,

Thanks for working on this!

On 12/11/2024, Rob Herring (Arm) wrote:
> of_syscon_register_regmap() was added for nodes which need a custom
> regmap setup. It's not really correct for those nodes to claim they are
> compatible with "syscon" as the default handling likely doesn't work in
> those cases. If device_node_get_regmap() happens to be called first,
> then of_syscon_register() will be called and an incorrect regmap will be
> created (barring some other error). That may lead to unknown results in
> the worst case. In the best case, of_syscon_register_regmap() will fail
> with -EEXIST. This problem remains unless these cases drop "syscon" (an
> ABI issue) or we exclude them using their specific compatible. ATM,
> there is only one user: "google,gs101-pmu"
> 
> There are also cases of adding "syscon" compatible to existing nodes
> after the fact in order to register the syscon. That presents a
> potential DT ABI problem. Instead, if there's a kernel change needing a
> syscon for a node, then it should be possible to allow the kernel to
> register a syscon without a DT change. That's only possible by using
> of_syscon_register_regmap() currently, but in the future we may want to
> support a match list for cases which don't need a custom regmap.
> 
> With this change, the lookup functions will succeed for any node
> registered by of_syscon_register_regmap() regardless of whether the node
> compatible contains "syscon".
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/mfd/syscon.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index bfb1f69fcff1..e6df2825c14d 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -171,8 +171,10 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
>  			break;
>  		}
>  
> -	if (!syscon)
> +	if (!syscon && of_device_is_compatible(np, "syscon"))
>  		syscon = of_syscon_register(np, check_res);
> +	else
> +		syscon = ERR_PTR(-EINVAL);

This else case actually breaks Pixel 6 (Tensor) since you are now returning
-EINVAL when the syscon is created by the exynos-pmu driver and present in the
list. Instead you should only return -EINVAL if the syscon doesn't exist and
the device node is not a compatible syscon device. If you still want to check
for `of_device_is_compatible(np, "syscon")` even when the syscon is found in
the list, that should be okay , but it's probably best to check that before
inserting the regmap in the list to begin with.

This worked for me on my Pixel 6 device:

	if (!syscon) {
		if (of_device_is_compatible(np, "syscon"))
			syscon = of_syscon_register(np, check_res);
		else
			syscon = ERR_PTR(-EINVAL);
	}

Thanks,
Will

