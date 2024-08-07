Return-Path: <linux-kernel+bounces-277371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B58949FCA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849D11F2293C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6C81B32B1;
	Wed,  7 Aug 2024 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfXnjQD4"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F7A1B29C5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011999; cv=none; b=na0zlet36xg5ISgJ2suSeOHEkT833swLqbJJyhceCUrpGzhE+b6iAwUFstWZWj6CIFAS3txpWTu//rs8flumy8xogtP3r5RqJHUnIdBnvVzLuffE411QkQUCloYemOsUuoUzmPEHh8RW5c6MtDxSQ608iphrJuzfaKiqhZzw840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011999; c=relaxed/simple;
	bh=SmflkcuMDJIW8naPbm/v9DBM5XF4zog+gRlw/8dQf7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVvvUiQXoaQmuOK7jCe8nbA0Oe9kMD2ORSKtrLxotRTYSIjP5P+KZwM++J0DgBDlNGe7rvFD+FX4v79MMY6w6DgPsrN9yBklzTSOOXHtnKUXhOnolhVYKjYkYFP18pwSWkW09XHU0QyHxZMoafxQIgWWJTspOELcEYgB7myVASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfXnjQD4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso1094348b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 23:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723011997; x=1723616797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xgv4Lz4y4hdpusu1y11h6gCcVe+Xzav2jc2y5Yt+/PU=;
        b=gfXnjQD4z4OArTgSnqqw8Q//IOPBlbqHd4t4YP6Xo61Vp41dB6I3n+2gql3bIgxAJe
         cyVFQmfppiUlgMHSZUKiXM6PTvT6xAugt5vz0/mBlC0hl5raaahaJCq/wLkN8kn09pDe
         m5tpETqd64r/QwVOo4+YrQCUpsJeoOPnfys6bhs0XrwFTzVcCwXyVZCdC716yG3GoJRS
         J78ZiNTHRFg+S/GtGEbcqMo02EVaditHmTDAbLLIUN6Rm5C8pQXNPT6cuoJBB3oosQm4
         g4vQxLzmImOLP+oHDFiZNAVivpc5hDLFuIk62/7z9Zyq5RjIglW7IhnZDemU50vHVY30
         AiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723011997; x=1723616797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgv4Lz4y4hdpusu1y11h6gCcVe+Xzav2jc2y5Yt+/PU=;
        b=vQ1sZPoO8ogfm8tC1gg5eSDJMCM7U3kWosN7f6RkLhaoTI2dKPPTlQiTl/FqlYMiWo
         XDPgKKny2APIrieusdbFc0GEFpjah9mE2hn/JnMDDu7+jn1S00w+BOspQKQVRGf/XEo4
         SkU9+RitnPZUhI/yzyA3KnowN2O8RhlrBfwHITLfNvJ55GttRb6roMFD9a8lJLKXp5Jq
         EdcotNo9ySQHL3VhKneDvkk6dUnB7Z8WYN/MOX7Y1bkKiIIMBpOuYnyK8jdmcNTScEmG
         Ippg8l2QPrI3DggUGPoqGm3ywswNWEtzG19S2jyyInrX8IlPesJ7xNLhjRaT1yEEbw7v
         xCLA==
X-Forwarded-Encrypted: i=1; AJvYcCVsWD4LNRfF0B9K1UGUB/fijoYavLU+TWlupFioLBfMUigIqT9x91MhBEGOjAtDIXpkYQuC0I0FaTQvT9WEu34S15I4sb1RXltDToN8
X-Gm-Message-State: AOJu0Yzsc6ynvB78mU+a4TT45ZwFbh6iaLpW0NEVeUHOClHXwGn6Wfif
	cSaaZJucvEgsuH/qoEcTG16S85/R17TyiBou+b8S4WPxMC7/Ao1orV0rGcQKGpg=
X-Google-Smtp-Source: AGHT+IG20fXp71pe3D6UGQgRh1rVmAZGcmBn1yO/PMuCn4PndSdnVchYjgLooIp6izXKPApmK0kzPg==
X-Received: by 2002:a05:6a20:4323:b0:1c4:8492:88a8 with SMTP id adf61e73a8af0-1c699580a57mr19116232637.19.1723011997207;
        Tue, 06 Aug 2024 23:26:37 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b372e028sm640455a91.45.2024.08.06.23.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 23:26:36 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:56:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	kernel test robot <lkp@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] cpufreq: spear: Fix uninitialized variable "i"
Message-ID: <20240807062634.egqwyeqwjpvwjwsb@vireshk-i7>
References: <20240805202042.3229190-1-robh@kernel.org>
 <20240806044928.2j6z2ucnzk6lg5y3@vireshk-i7>
 <CAL_JsqLVj2sCuQFYFwR8QnB9jHq_9z4axeNzid1d7+ZrWzmgYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLVj2sCuQFYFwR8QnB9jHq_9z4axeNzid1d7+ZrWzmgYA@mail.gmail.com>

On 06-08-24, 10:08, Rob Herring wrote:
> On Mon, Aug 5, 2024 at 10:49 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > We don't increment 'i' anymore, don't we need an i++ in:
> >
> >         freq_tbl[i].frequency = val;
> >
> > ?
> 
> Sigh. Yes.

Fixed the original commit with this, hope this doesn't add any new
bugs:

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 777f7f5b3671..d8ab5b01d46d 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -173,7 +173,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
        struct device_node *np;
        struct cpufreq_frequency_table *freq_tbl;
        u32 val;
-       int cnt, i, ret;
+       int cnt, ret, i = 0;

        np = of_cpu_device_node_get(0);
        if (!np) {
@@ -199,7 +199,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
        }

        of_property_for_each_u32(np, "cpufreq_tbl", val)
-               freq_tbl[i].frequency = val;
+               freq_tbl[i++].frequency = val;

        freq_tbl[cnt].frequency = CPUFREQ_TABLE_END;

-- 
viresh

