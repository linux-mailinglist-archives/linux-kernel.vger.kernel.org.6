Return-Path: <linux-kernel+bounces-270658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8729442E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B53B1F221FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA5D157470;
	Thu,  1 Aug 2024 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VadtAcDt"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1213D62F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491568; cv=none; b=hPSwASQl68Zv82NPI22JUQo0l3Bt1jk7/nwBxVfgsyfPtX3Ci+IWqBQCGqdOkSHPgU2lu2VH2o7Fbu6f3fV1CSE8qoOjqjr/aXOEsD/piJQvaFKzhmI3pBkuJwK6nK4cCh48XRW2PAwxDWkwxr/2ejjZ1GX6gjh1ekTtp6i2opM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491568; c=relaxed/simple;
	bh=39kV8TnfrRo3OY7bcupHlM07rU26F5qV8vSLQRhn/qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjtnI4UqKwGCkqRa/X8U3EulYaVWBtAPEQhPj98iFaKYKBmXl5kl541oc/6pavbvXQ9TVKtRrk7/hZ50fiYxcmFkBziWGRDb3BcdjY8T+c8pG9R1rWuwHVKw6hiuhQGbcOKmdJG8JS+zuAg7S1w4cpD+HIRbq7IkJMCHVdrA9N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VadtAcDt; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db35ec5688so2655585b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722491566; x=1723096366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5fGtN50/1mQqmVQtTYes3gLQWfFN9t9TA0/Jw74rZ8=;
        b=VadtAcDti8NsZKeXhvJvZo7Q3wpv7uouUjjwcgUWfjJR1zB8XzioEvqDrV2jQY6wXm
         8eMTJS0kcumgrzuRRbIhv8mb1Dju3kOGCuIY3kgiWUUpNcFm0OvK3QBqdKrs9VZbRWf5
         Nk6hkZu4cKCX1UKa3Ae9W0j7NVp5ZRWWDkfDx/w9o6jTBDrsMTl1Ev89PYqL1BdfVw/8
         1tY4am9+wRHNsv3JIpCq+9zRX+NwXls1cPWyXq9o56pj3CA5aYbYIkctITpj00va+BDk
         pRr5TZnLup41CeJh3rzSQuGDYud7ZP5bzq6EJDRqnu97ZUPVKRvIUNCxzU3nr+oCEhlh
         A30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722491566; x=1723096366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5fGtN50/1mQqmVQtTYes3gLQWfFN9t9TA0/Jw74rZ8=;
        b=CiSYxZt01FUaet4ohlFCE9EgbFDYSMFVpFMugMkaRrPKf7IxYnBIfKjxXuWN/gvZ8D
         D2WZp3a+AovltWvX4ivLKCpcXJ0ikOL7oDSKOjtTHH2qx/BQ+kQRlDb7O2YW4aYeAFen
         FsmsboNU+pAge3HA49MICBlxpTyidFlbn5GZxwSL85IGnxw/kaU0j7gRtNdE15b2KFY0
         93mSTRxx5rYX3sg3ZRSbJ1hgoeFN3/hV+3vyU3mzz9l+zEeMUz0W3wtFLT6+W5TLutM8
         a7IbP5zdYo9A6T2/Pc0FkhqkraUgQaJVtViQsRSz8EdjZhB+b7RYOM9EdmvX96kAyR8O
         iXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu+3YwMKIlZOtqyiFX5Zo2wKsJlyG4FFxGNUnxkAp7BaIpncb/dLrkQBuQA8r76sN98NxqrdA0PWJPF/B9yxYNBB8hR2wUoORIKtXM
X-Gm-Message-State: AOJu0YwUSyHDz22ajeN48QZ20xrJvgk7ZNBeit4ZanoaodWVKISB7jdM
	SN/NMYJwLNgL9G1QS8Izhp8dWg2UaB0Xo6wNYPilUbEmDSohGOryOxo28eT/OsrBea0H2KA4Sos
	b
X-Google-Smtp-Source: AGHT+IH0gNZ9OdMTHw2ASbO8tzsXuYFiyGCXWAbvqVuhbPSmGtQ0yzbUGqDhc9DDXMNX23K0H9TsXA==
X-Received: by 2002:a05:6808:13d3:b0:3da:bc74:e9d3 with SMTP id 5614622812f47-3db511c45bamr1570260b6e.17.1722491566172;
        Wed, 31 Jul 2024 22:52:46 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7c74533sm9850813a12.7.2024.07.31.22.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:52:45 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:22:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: spear: Use of_property_for_each_u32() instead
 of open coding
Message-ID: <20240801055243.sisi3m62s5raw7f2@vireshk-i7>
References: <20240731201615.1841145-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731201615.1841145-1-robh@kernel.org>

On 31-07-24, 14:16, Rob Herring (Arm) wrote:
> Use of_property_count_u32_elems() and of_property_for_each_u32() instead
> of of_find_property() and open coding the property parsing.
> 
> This is part of a larger effort to remove callers of of_find_property()
> and similar functions. of_find_property() leaks the DT struct property
> and data pointers which is a problem for dynamically allocated nodes
> which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/cpufreq/spear-cpufreq.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Applied. Thanks.

-- 
viresh

