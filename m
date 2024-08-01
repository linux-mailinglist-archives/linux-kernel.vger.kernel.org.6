Return-Path: <linux-kernel+bounces-270657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F0B9442E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5033F1F22CAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913AB156F5F;
	Thu,  1 Aug 2024 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUUSZV0Y"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF0213E03E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491515; cv=none; b=kZtoDh4dWrspf/lJWcTUjVotgKI/I/J60yovqf4WJ406aK2oegC9Qe6T3sONJB727Mt+L/R2e7OWjHatoE/WftvLFO7IcrJ3+tE7ebq54O8H35cPrcspuHTvYwQMgDu58inj5+yWtk9m3PJCBf5fYYhMH1TTxzszzdp0dhcmz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491515; c=relaxed/simple;
	bh=mHdBEdoA646mRvFAlQiOSeu1k6r5IpBY8UYszqgYIDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku0nmF/fMPqMueqRQA08O2ifDUvmYlhTgearRswcTQ4dQ9tPophVUuL8jHBRM4ekFNfnqUq5fsRWbpJfqCa+7MIZucjSHzqHvym8MJyN4Fbjc8o2Dwd2kdC8/HKr/igBmhsh+9ylu38g1AVM5BRmilb+eOrUqMCLPwDJ/mozZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SUUSZV0Y; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7b396521ff6so1955374a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722491514; x=1723096314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gBLGL+mmGX6AVb3elsBnCFrc79BJCRR+zjbmuB2kqk=;
        b=SUUSZV0YI9lDg7q28pCzDSRb5R+5DhANp73imtBFTyeaDuj5oCbfOjG5TIfld4lOJJ
         TteZLaMn1SRNPBrBR6IfNjGaxiMebAWEFWvahvNnUHRFgIGqjKtO/VvJJP5/G2TWceE4
         Ew61HVXysIQIrqfNSGNxvQ3UMkhOswAvZpKHubDjSNHUaJR8Pg9sJnE9CjKg9/W+oy5U
         404aBPh7TP9j+3MoSuW/3sAFgTf9o/MdZRiT6En5uBv6OX7UXtkRASHRiJJEwbsTm9nq
         SZJNhZ+WFTKjuU6hzOsmcFK2smjnxbkqrFwhHUfK36pwv65bTI/Bd82ARtbdcCXU6qwT
         E7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722491514; x=1723096314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gBLGL+mmGX6AVb3elsBnCFrc79BJCRR+zjbmuB2kqk=;
        b=HbsNifRUj5efMXhy64J06dpbK/0QDTRaq07zgwnWN9iwJvGLag4vKbxaX0S8IlGJ11
         ANNrddH8vOj2h6kqBHLp1SVUaJ6W3LEjYIN9ZmKz7PLZCLbkISk3lAfUOVIZEkBbMUyW
         gl434wiegbU+QJIS91zGXzrsnwQf9+STJn+Hgkvqv36Kl6ZXt3bXVVRHZDWIJIcu9WXW
         CtRxBpD1VpH8eiCCse8/hVWCITSudGDYm7bFci1k8f3hW5LuhVCgZrKwLrKaiL40Njky
         THHETJ0rfnoUmWFx497nx5QkziMoK1eP9NUIAypmySHmQEAtaEMl5Fo+HA93iH+69bHc
         HAkA==
X-Forwarded-Encrypted: i=1; AJvYcCXlfCLYXobxaGYy4XALsR5/qMOc147hy3MUxIOvSC494i1XUEAyLf1u5qHFDuKE+ei2ws5fPYGdXvlxTGIyf4H2pVSWGc/JZ/K24Jzc
X-Gm-Message-State: AOJu0YyrlVfigNBo+3gXNnSZLmZIOky6psoV/bSaunTk+prCPPhmmvjP
	YJ9gzJnWYm/ybdBPZmMQ4Rh4znPEXvQo5V6OAqiqiGiI3dbWT6x2IrwrNTZAfSA=
X-Google-Smtp-Source: AGHT+IHi3LdaOVqsILRzUG5RajCZhFYqsgwTEJCbU7Q/0owEgSj/B+R4O+r/bPYrYZw7jZacX4sQzQ==
X-Received: by 2002:a05:6a20:ac44:b0:1bd:feed:c031 with SMTP id adf61e73a8af0-1c68cf30d2dmr1821935637.28.1722491513712;
        Wed, 31 Jul 2024 22:51:53 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4add69sm2325862a91.47.2024.07.31.22.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:51:52 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:21:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] cpufreq: Use of_property_present()
Message-ID: <20240801055150.ojas7q5w5jzhmeut@vireshk-i7>
References: <20240731191312.1710417-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731191312.1710417-2-robh@kernel.org>

On 31-07-24, 13:12, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_(find|get)_property(). This is part of a larger effort to remove
> callers of of_find_property() and similar functions. of_find_property()
> leaks the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c           | 11 +++--------
>  drivers/cpufreq/pmac64-cpufreq.c       |  2 +-
>  drivers/cpufreq/sti-cpufreq.c          |  2 +-
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c |  2 +-
>  4 files changed, 6 insertions(+), 11 deletions(-)

Applied. Thanks.

-- 
viresh

