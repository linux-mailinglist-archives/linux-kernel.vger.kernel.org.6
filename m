Return-Path: <linux-kernel+bounces-570720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4FA6B3DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DA1462ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12051E5B70;
	Fri, 21 Mar 2025 04:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBQ0o1D3"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C8184F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533183; cv=none; b=FrWgoD7nMrW3BK0yRi50nCnyBQQmNpTFGZBNs6ujUOGKcwFR4w0+2eemfv0qCGNAwxCaUPt4uoZ8+D63xk3IDAi/WkGbzCa16YM/MosvclF1Ee5vcjy/qsIFdO8rABfB6eM4enmNsfE8CHAV7MdkPjZ3uIdG++tOM14Efj7Yst0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533183; c=relaxed/simple;
	bh=gxd1hr2GTxufsrMwYQjmiavkuOVdqhc1FwR0v5o/cW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbQ3vnMbntQuvq3Zd96fUAFO0Cxer5iCXCcEYsj+QyvcRYCMENq1tm2YDAVqhcVZLJih4BZWeGLdDqZ2iIf5GG/K2LiCnR7YUohB63Ov8BT/KXsNqFweHCE7vFmgZRuYQ2fDHbgJpXVXkytkUBMrit79+etZSNH80UVkBF8VoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QBQ0o1D3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso2162605a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742533181; x=1743137981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jU1uq3ftdFeUBHBrd4FxFBQmvi/x+JX/MfO5OssoYEQ=;
        b=QBQ0o1D36ECMAUnXX79OTh85pU8sq8Fg9gCM3DikMI61K9Nt+oO7Tk5+t0aFGjAWeB
         rhvPs5nVzTcwloxAWps7qyHLUyQ8SJ2V1cah6pnZr+CBviR4lmDLLwAweX4fAiSapmN4
         Pd48S56iYYTMHZjOxcK8k69n+BieAwqJBfq/6s6TMUO9TfVnW0hJyDSRIAHjRygSe5Py
         v8/Z1HH/Hrb5ghtU/nbiYm1OcKDL6oF7wtYlnf4f+SkUOaNuDN7YxX577aREPotgjBHh
         MHg0Gr40Dc7BJSqMcXeuktcX51aUh7N4TolXX54v+g2BK4z1bWe86GIrBDM0IQdHkRGV
         EmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742533181; x=1743137981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jU1uq3ftdFeUBHBrd4FxFBQmvi/x+JX/MfO5OssoYEQ=;
        b=MOfM7+vK7nbbytrnkKbImeSE5YjcrYn2YQMcGVw2wbiV+qN5vT4oSrNPvPu/wHfGVA
         bUHqt5ZtuWLIIseCN6TQryXA8B4y4gERPIYJr5A2FzvkXDKOkotbmMDcQ42v6aAa7UTL
         Mxp3V1W/WknXyPQx4q3FEWgYOyMwjWlYd63U2wXkcB9tNP2aizhPwXvNQxmegbAkUjf4
         gzrcpdlwwmYIvxqu9LWd1GrZN5LJEme4aU5xT2SD/elu9lk7mSl+y2xI8pvMfUGTdzHJ
         EjqInAkEUm4aVEK4LJxcruTON53boRZ175mfkpY0G+9HrIpiU0VaEjIzG5xwoF+yOuvo
         Dstw==
X-Forwarded-Encrypted: i=1; AJvYcCV0aXL7QVg+8HblK2+zDelh2dJYhKA6HWGzaYWSYC0YOrQYiitoQ8Y7sZn/q0vd8nxod1s5Y92rzWY/pFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQh/cZZwhlqi1aLvXpWHgHlCpsSksGYBn2IVsHeZgphsrul1y
	1jWN3PfF8Vy+yEFZgb/+pWC3EIJxA4J8yAAM70JK8bs2YUYmZ3RxDN/EdT0s6hY=
X-Gm-Gg: ASbGncteOsIG5t/V5ZQw8snwnuyXjk/bfXuOko4wHj6EskVgfUfw/WSd8tMVj72jCPj
	Iaj4uk2tVWg69gTgSjCctV4DiUTAd9UOWvM997ohxv8dFQPqUrpTRSiUeugFeZC/FcS1dGhfmAX
	ri9vhUszvFqez7jXeVXYlNj8el+ts8SbD4rzsgNgyYLluZhxnuPVm5yqjcwyZpCNAT/0TWBKNQC
	NzgQIo1pW3NdP+3DI7Lcvvob2YtpIAdlwEnhKpr5JmnmylIuD8tEiXbriBsrGjPIjdc3ohv0MV9
	AEqZmMBOTfM431YQGga58X8a0RE2Btn3ENKF+qe1Lar0WA==
X-Google-Smtp-Source: AGHT+IE1MkhF+eIlYdPjXH6Mh2gvQg0KSwaX+hGGWKTe/5F0qYgaHVHgqtmttCIIq/1Wqtv32WWi0A==
X-Received: by 2002:a17:90b:3912:b0:2fa:e9b:33b3 with SMTP id 98e67ed59e1d1-3030fe56ae6mr2439451a91.6.1742533180745;
        Thu, 20 Mar 2025 21:59:40 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf59e2desm4949374a91.23.2025.03.20.21.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 21:59:40 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:29:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= <Chun-Jen.Tseng@mediatek.com>
Cc: "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 2/3] cpufreq: mediatek: Add CPUFREQ_ASYNC_NOTIFICATION
 flag
Message-ID: <20250321045938.6gnmtlbdcx2i6gmw@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-3-chun-jen.tseng@mediatek.com>
 <20250219054543.4xt4tixsauwoqpst@vireshk-i7>
 <21e1b622c2968a5549b2ff37e4ba329a557968b6.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21e1b622c2968a5549b2ff37e4ba329a557968b6.camel@mediatek.com>

On 20-03-25, 08:34, Chun-Jen Tseng (曾俊仁) wrote:
> For CCI and ARMPLL in different driver, I need to change ARMPLL first
> then use cpufreq notify CCI driver. it can avoid CCI driver get wrong
> ARMPLL frequency and choose WRONG frequency.

That flag is only required if mtk_cpufreq_set_target() isn't able to complete
the freq transition. Which isn't the case here. I don't think your patch is
correct.

-- 
viresh

