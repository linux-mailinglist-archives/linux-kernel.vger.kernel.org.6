Return-Path: <linux-kernel+bounces-448556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0959F41BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2E716D731
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BB1145346;
	Tue, 17 Dec 2024 04:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GALa36JQ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172EA13D25E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409651; cv=none; b=QYkllKHEu/HkMGWWLbcelhLc0hesFa/wr0R7BSV/aHF5k/iHnXOO6EAnyiS6NKnF8BgNjPt8PIFImOFK0YsxJyctGcTQa8ZdQECfEfzvuq8bPIi62XhjrxcbtpsflMkZNTmgaXTqjlT/UdbSHbSskSyOUfV0WM1KwGMXEI/JqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409651; c=relaxed/simple;
	bh=KGf3WEZUTgWBNJDe2xew7TkgY4CxKh65T66dzPPcwMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5cZzWmC+HpE1dzslRyQIjlTgB1SXipX0fPILqgCvdW8/n9kNX0HVQNEHhAHkvJRUx5APR1BOZzJo/caic/YMO2NSHwEGKrDSWTkJ+ZNu2qVoRZpdaELk/I+Y5P2nNUZ5235GBCFwTRFX8HxFTokMzMCk8d6y/BQYTq8zskZOgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GALa36JQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so4366770a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734409649; x=1735014449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr3GeSntlHloZ4yayQx6BsNSKnwpryezH5Wr5AEdqz8=;
        b=GALa36JQf9P2udVWsBlKW83PFKRaM1xO+HG3eiFw7WlO1O0Wn4+oq8x6fbQKgDefNv
         XxQQYZxiuDM0ud9PEIyOF6SBGhx5QA/9M9nliQ5krmXOJnYGwDf34OlbAE6bAjXPbkzc
         3X9a7sbTgxbzGb40JBMlERxMGW80J9tLlm5b6M5q+cyd5favPWLXEvMwuztljLkaCn1T
         PSq2ANdZhssa/LoB+3FYIBteMGi/lV7uCeOX/UqnGprCPa7MHnJmDMBcI6vT60Fgftr6
         lsw6hky/0n3ikwns0s75tFAXnC+BwKbuA1AHHJ6nCWNtjIUM7rL4vGG9Odz+Yi5X/e0I
         nzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734409649; x=1735014449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fr3GeSntlHloZ4yayQx6BsNSKnwpryezH5Wr5AEdqz8=;
        b=R3R92ADoi+ktD9VRUbVPVEGrMIaZhIJbjKr0GY0Rf7Ch0W09CRu4IjCWJ22nyQsbhl
         jDiR0ZMihyDWLz62MNiMmBkKZECMVoexIGKB2MVK6m7WMvmIYz0Vs/Hc4g68h/AJAGq/
         qwSTuUnRWnZLFrzkdmANScDdKqalbuiKfp6xrFa2bOBgapJ71dgLldqeor0LGNIeYsmh
         ctj+dkWDxLUelDxmWEqvJPPqsOu1Ta1xCJEvpcEZQ7E3Xpx7x8YIc1g97fV2V+eeSmdE
         gjhwjTUo9NcCy9bg7yBOlw4HyEqjFOH+SCLYD3Ay3cG38tpxwEc9F6kg0qfxUG74T4/U
         /DZQ==
X-Gm-Message-State: AOJu0YzqMVuoqWmuhgsfop5tDjRUQwZDYjOo3ZfJ3v+Nc1mEZ9/iUW/B
	t4lOU+XXRn4rWoTaiH5iNEBXpx9dboFM6Xq4jaAk2XKZCU6l3RWhZ8gwlwOWseg=
X-Gm-Gg: ASbGncvFpgP2XFucI8fmMRlibWlpj7XjMq5rff+q0qLPwZ37Gm2tDUf4B19SY4J2YT3
	J+9ueHP4Pdgj3aikciO5YGXgwngEU6Yg0DMK8DE67MxQMo4MhlK5JurPQIgV5OPa4DYhmDNR8Yg
	UZ68Z4pnzBQ/O+WDOFBZuRKNr7UExZpsPxIc0HP8lF7pMQjbedmrNt9B0vkFvmCjhSNeMO9JSQa
	/zRo0xhYnpfyx0sWxhBlbNkj2ved5V++Oj+sLS+1mJOOywrCUvUcfPv8hQ=
X-Google-Smtp-Source: AGHT+IE/JeMuR4dBQFhr2ewi062MYvFxM7gFUf/kYOjekW7K8q6et1llylqaVQeIxsiURZEwVjKeIQ==
X-Received: by 2002:a17:90b:2e48:b0:2ee:6736:8512 with SMTP id 98e67ed59e1d1-2f28fb6f983mr28756658a91.12.1734409649481;
        Mon, 16 Dec 2024 20:27:29 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d45sm9072765a91.11.2024.12.16.20.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 20:27:28 -0800 (PST)
Date: Tue, 17 Dec 2024 09:57:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <20241217042726.isllh5bulpnwql7i@vireshk-i7>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
 <20241206135600.4083965-2-beata.michalska@arm.com>
 <20241212065100.sjb7lrlmksbm2hdk@vireshk-i7>
 <Z2CmcelSy89NULtz@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2CmcelSy89NULtz@arm.com>

On 16-12-24, 23:15, Beata Michalska wrote:
> My bad as I must have misinterpreted that message. Although I am not entirely
> sure why this might be unacceptable as it is not such uncommon approach to use
> signed int space to cover both: expected positive value as well as potential
> error code case failure.

This part is fine. The problem is with handling frequency here. Signed int can
capture up to 2 GHz of freq, where as unsigned int can capture up to 4 GHz and
so we would really like to keep it at 4 GHz..

Maybe we need to move to 64 bits for frequency at some point of time, but at
least we should try to not break it for now.

> Enabling the new attribute for all is an option, tough not entirely compelling
> one as exposing a feature that is known not to be supported seems bit
> counterintuitive. On the other hand using cpufreq driver flags won't help much
> as the support for the new attrib is platform-specific, not driver-specific.

-- 
viresh

