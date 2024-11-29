Return-Path: <linux-kernel+bounces-425214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657239DBEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297BF282036
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A254B1537AC;
	Fri, 29 Nov 2024 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nRLLdXS7"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D515252D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732852960; cv=none; b=B6Bb3LR12tWVk8Ut8Qsu+dHCk6+5KqIGyrln/PgTvJlM9bLR+kBz689uspOa3jPfWjkcVNcM6akbgyySQx0JF8qA0KSXRvwe68lO7+4rVOQ08MSlKPMakwGd9v4SJj6iYw5I3DqADq7skO9vdIocoxeQVV8jbiJqY3A0tw3BK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732852960; c=relaxed/simple;
	bh=swf3tvexmzGXcI+VvwStGrdUTjxkMIOjndPZHS6BChI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6KDzKPRwSuV+SSGghHrOxw0ILkkVMufq+wSJAZVhwHupa+GSzoMB/m3hI6H4Jow+8mo9xl3SnC+mS3fozNxG5VjCbhJzlSiaEGWAzf3PsBcOrnYTeH2dSAKhIBwE/40NuHP3CnCt4GTRPQQfwowLKPud6UGxfDK1G+a1/Iw1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nRLLdXS7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso966386b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732852957; x=1733457757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tDKIA0yiYCe6asl+5icjBS253n4DcVUQRcHeWfLOnqQ=;
        b=nRLLdXS7F/kP72GrwBJek6prqTrUjOYrMI7ivY/W32G29oGZ3N/g8Kc3EJT6RU706Q
         HSVFDlraq9WtezN1CL+aT0Uv8vCnZQ2TArpDBl8xk5vEu09Tc7B5WtWcboUmN8KdpeqR
         9jtwPqIqH133iTzzcxgUTovv8YdR5kK87jAL63hrX1PDz5vvXADE9YqkB2kxlLqz3G2w
         CSxRw3qH7u4rsL2lBOMshw+pRXqpwPJqeSpYr3A20tp/owJGbHo5QoIEDKmO4qo0gspW
         3+178xxAwigS0IMQgWvwb+DVJL9nQaOSISNOE7XVna4kuBcfRy0x7i0AGlflHcvb4lel
         Rt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732852957; x=1733457757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDKIA0yiYCe6asl+5icjBS253n4DcVUQRcHeWfLOnqQ=;
        b=xOkIj3h4mKclrtkc6o3cXgzPFi7PUEmf+j0pPypUE7rxfJitvXghB6aKtMl2encCDO
         HLCJOK49R47cqeEyrF1wG9a3jmh6kgMHGtnOXC7U3DkK/bEZQhUlqCjSK4/goBbABbbT
         CqZqgA3gQp4Un+VClt9lTLBrdZla6UJDVC0RAo4YqyNjTL85NQtbWu1fDOHm3RbWTQw/
         RCxNrgb6bTTiADfhMim1MD+LfkS9HbxnxpGl5GLneUER3Vgw05thl0VFX7Gw9dLV6CcH
         bjVYHiIrvKb7GR/M1E6vM72en5cK4zW68NgFdIfJRQD5T36QzamgZAywlO9bokN6K7yy
         814A==
X-Forwarded-Encrypted: i=1; AJvYcCUHHeSnZUuwnwvBLIIEy5dWZbS6AHuqGPFBA+5Dp5hRZt/ENbkZdylogW6YYXW5qvKHp5aDKrHeUNMMcCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ZR3gNMTUa+MeP3Iw49w3XOhbChkAKRSZUO03vo0oU5NcI6+a
	mQ5ezN4Kn0zYBUollzFsPQmjzqbJbB8HdJWCAhnpDcwDHzYcClg5hLcOtqmQ1hg=
X-Gm-Gg: ASbGnctry+4mnLq9DmKHZqthZGVs/EQCV2EB5laXWAu7WN2Aitim8VWmxkCiwBPFblH
	1qSyMpHwxARFfx6VD3FktznrGNUv+ATG1aEjvKAsjibAsLXIjg2hIZ7WOMA5IoiBDmVldC8GWQF
	lYjexUTPZMB6/qUwvqhL22WLv0WCnxvw6dLh2YBRqL3ZbCstz7oPkn1Wf9uZJA7OqTQ7yoKDwZ4
	vvVY4Oy/Epam6azZQRjn0/QN9n3E/9syzsOr7f6kFAoJTKn21UW
X-Google-Smtp-Source: AGHT+IEAhW/xPQsLV7GpQCQL+wp98x0Q6oXhlkxjQV5TPTO6tnakzR6fvonO4cnQqjJ0GvMZf0TIcQ==
X-Received: by 2002:a05:6a00:1d1e:b0:725:4301:ed5a with SMTP id d2e1a72fcca58-7254301edc7mr6822764b3a.2.1732852957427;
        Thu, 28 Nov 2024 20:02:37 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbab6sm2495237b3a.106.2024.11.28.20.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 20:02:36 -0800 (PST)
Date: Fri, 29 Nov 2024 09:32:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com, ulf.hansson@linaro.org
Subject: Re: [PATCH v2] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
Message-ID: <20241129040234.enfb2vpehpzhmtmc@vireshk-i7>
References: <20241017190809.16942-1-ansuelsmth@gmail.com>
 <20241119072054.64hi347qmv7ng3un@vireshk-i7>
 <673c549c.5d0a0220.3a3476.517a@mx.google.com>
 <20241119104421.hqsil2uvklxok7lz@vireshk-i7>
 <674470dc.5d0a0220.119e75.b012@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674470dc.5d0a0220.119e75.b012@mx.google.com>

On 25-11-24, 13:43, Christian Marangi wrote:
> sorry for the delay... I checked the example and other cpufreq driver
> that register a simple cpufreq-dt. None of the current driver implements
> a full clk provider internally

Yeah, that may be done from platform code for those drivers instead of the
cpufreq driver.

> and I have some fear it might be
> problematic to have mixed stuff, eventually I feel I should implement a
> small clk driver that implements determine_rate, set_rate, a compatible
> and all sort. And still we would have the double reference of OPP
> Index->Freq Clock->OPP index.

One way to avoid that would be to use performance-state stuff and model this as
a genpd. In that case, opp->level field (which you can set as index only in your
case) will be programmed as is by the genpd core. That's why I cc'd Ulf earlier
as it looked more suited to your case.

> I wonder if a much easier and better solution for this is (similar to
> how we do with suspend and resume) add entry in the struct
> cpufreq_dt_platform_data, to permit to define simple .target_index and
> .get and overwrite the default one cpufreq-dt.

Easier, sure. Better, I doubt that :(

The OPP core currently configures a lot of stuff from set-opp API, like clk,
regulators, genpd (performance state), bandwidth, etc and I really want to use
that infrastructure for everyone instead of starting to open code that in
drivers. The suspend/resume callbacks are special as the OPP core doesn't know
what to do in that case and so it was left for the drivers to handle that.

> This permits to both reduce greatly the airoha-cpufreq driver, register
> a simple cpufreq-dt and prevent any kind of overhead. After all the
> .target_index and .get doesn't do anything fancy, they just call the OPP
> set and clk get rate.

Yeah, clk-get is pretty simple but opp-set isn't and then there is scope of
further enhancements / improvements in the future which can be best handled if
we keep that code common for everyone.

> What do you think? Changes are really trivial since this is already
> implemented for suspend and resume.

I think you can model it as a performance state (which lot of platforms are
doing as well), and then you won't have the index->clk->index issue anymore.

-- 
viresh

