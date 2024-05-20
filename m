Return-Path: <linux-kernel+bounces-183499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C658C99E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54A21C20F37
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76F1CA85;
	Mon, 20 May 2024 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRz30wSJ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D71CD00
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716194074; cv=none; b=akkjH/RHeaqrG2me71vPlDC/q8KV65KxDqCudvSfyEWHfSUL6Rxf0N6MwYwV8aw6yh6aE5VkeVAhP4f8H6ryUuod95wPkiP8D0dHeZDPzbfR9Nto5w4rS5jALyCSmEilklA+N/MwtiHMzWap2q1b9J/9oLa6Qyu1fez3HiNTCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716194074; c=relaxed/simple;
	bh=EB3qMQKJYEnU+3Ng6Tr6wYGW1yUtDcOSoM4RZFjdAR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsR5ieuCU+SvBkgP829lmaMOrF0ReyFjxug4JIA4eVSuy5soMR5ivX+fOhF5HAOmnHhxnfWWVi78ajq/Rh3B9kl0uMVyK5AgOmWLrg4MKu0WIwg1+g03FjPQlU+ADtba+mrUy2OArtju3ZzQKMDINCYVM0R+6OANX/ts5nJnADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QRz30wSJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ed0abbf706so64476325ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716194072; x=1716798872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/0VbbHPXh3+HPq9Lwv1t2nzWPtTvHI52qOE5s8NY3Gw=;
        b=QRz30wSJ1oBkKpbGVxBoU6BD9tjmBQgMkpY0mJnOfcqU5kejOCsaL6tlfrruZJVtDm
         /9tqKGRsR21qiEYSAQzHolkrsd0pM9xPjNbXizx/T9DN1397DnXBYCfcpMZZO2kPB8rL
         2bKtqe0NFGlu5LYXijGXxLcHixVwyRLv4HKr/cBxCRd02UFN/QeK2VYz1ggEzsizPjb6
         kTzQajHOwtHLVFcPx7mPAjAu/RhuNSsc9v3X1RrgC5fSjUarbO/J+5OhIqmQmBzDqM3E
         O4ryf/bLiVsFLZVzOwF46ZAZMW/UppJ5uJEsSpEUF0BW7FGvKUhiWGI8BKO9KMdVU7kK
         Ld8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716194072; x=1716798872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0VbbHPXh3+HPq9Lwv1t2nzWPtTvHI52qOE5s8NY3Gw=;
        b=IrW3FcbxNE8+RHTzKxw3XKdf/EhhFna7rbropyfwPz7vY/kdAU1UdH094u6+DtlJi5
         zHYN1gZKNE90m6aXXBers8O++VwAMOpOMaMd3KExMVxHQrnNvQHRD94Hiqt+YPek+LxV
         IYfT2PVL/axcUsmebQi8cOg2XiAX6SpgidL3Ygo/FdfpJE2HDfpgu6jtqeLRPEOPTOEk
         1OPfYErcAeec7Bded+C0E4uX7sEBzWe32Lyv1nNLvqp8o0wpth6ZpBI/O2DiuvSR9g/R
         Wbfaj3OvA6axIlPfPNrQkJLF5A9YCk8r42n/PfWnALmwtYxvPcynW9Jcf9jCGfL3YxTC
         UCPA==
X-Forwarded-Encrypted: i=1; AJvYcCW6hxkWS3VkszwfqxekMknX9RyYDEp6fKQ9XLvI4+V5zjlpKYRmqO8mjm5aIi56BPgNe/WoaqjcKTWqeM/432kM36MW9wWcBsO8qwvj
X-Gm-Message-State: AOJu0YyNm9YzwebODSNcXOCWlTZnzbBFIh0FoNvW6ugbKEqqEUTzOa4l
	orhJkvptUfuFXDVuaLg3h8AEwBTXcSPd1cWJSiyC09uWoem4FuHxWgkLF8vtVEw=
X-Google-Smtp-Source: AGHT+IF2Fay5nzBDJS+qndk5PhD+BqkgoWj70xfZaviqp0+ytl1HWTEY4sMDUZUV8COfR4PlGWkfZA==
X-Received: by 2002:a05:6a00:468b:b0:6f6:7c6a:2c14 with SMTP id d2e1a72fcca58-6f67c6a3007mr9545512b3a.4.1716194072386;
        Mon, 20 May 2024 01:34:32 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f68c7d3651sm5600251b3a.183.2024.05.20.01.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 01:34:31 -0700 (PDT)
Date: Mon, 20 May 2024 14:04:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: sun50i: fix memory leak in
 dt_has_supported_hw()
Message-ID: <20240520083429.e3f5vtyzc536x4wz@vireshk-i7>
References: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
 <20240503-sun50i-cpufreq-nvmem-cleanup-v1-1-0a2352cac46b@gmail.com>
 <20240510174937.0a710104@donnerap.manchester.arm.com>
 <20240520073339.rf6laivnglmww3bf@vireshk-i7>
 <20240520092623.6ce850e1@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520092623.6ce850e1@donnerap.manchester.arm.com>

On 20-05-24, 09:26, Andre Przywara wrote:
> On Mon, 20 May 2024 13:03:39 +0530
> Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> Hi,
> 
> > On 10-05-24, 17:49, Andre Przywara wrote:
> > > On Fri, 03 May 2024 19:52:32 +0200
> > > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:  
> > > > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > > index 0b882765cd66..ef83e4bf2639 100644
> > > > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > > @@ -131,7 +131,7 @@ static const struct of_device_id cpu_opp_match_list[] = {
> > > >  static bool dt_has_supported_hw(void)
> > > >  {
> > > >  	bool has_opp_supported_hw = false;
> > > > -	struct device_node *np, *opp;
> > > > +	struct device_node *np;  
> > 
> > Why is the opp pointer removed ?
> 
> Because it's now declared *inside* the for_each_child_of_node_scoped loop
> below, courtesy of this new macro. The idea is that by doing so, any
> "break;" will exit the scope, triggering the cleanup routine. The loop
> running till "the end" will also make "opp" exit its scope, triggering the
> same routine.

Applied. Thanks.

-- 
viresh

