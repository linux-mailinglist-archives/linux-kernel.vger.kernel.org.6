Return-Path: <linux-kernel+bounces-531493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58492A44121
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D791885B17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC802269AED;
	Tue, 25 Feb 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="dSEWQXhi"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5B626989E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490948; cv=none; b=SCwkyaoOsAC5R1Nf6/2aXurEcForFaQKNO5PZKzLE3tGeWf6OSNG2K0X0HLQLbSI6eGmLkqD4g7eC7+RIJc+NfDkEUd+GbTSKOTtsQld38Il2qatgHsojpxlLWFMtIlOvaTFfGtZMW3e019ZMrWL6OlI+N+0v+q+7jfyu/r2CwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490948; c=relaxed/simple;
	bh=BnR1UEhkD2s11wwqzNvj/RhJsief2AsOyiHWF4nIWnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKUxPpQcP9l/hXwlThAYfMtjHr4aiIXhqnQ5RkvsBXphui8MlpKIsKUS5wc8qgGayjI/Jn1CoDIVkiZVqmwp7/shhrJDWrg6C1xLgdPrPOAenI+SoRjE9Zg+uobglFjiUaTuoiGRffLTFxp665SgpbvtaQOQ57sgwTVItiTmhGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=dSEWQXhi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so48996675e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740490945; x=1741095745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3XL4nlHnnlyPH4jYVrMU0QnNTngOwLFMHwhGLj0jSQ=;
        b=dSEWQXhi7J5ZiWC0r1WAU4qdDss4BfmtHbpqYlNA6YnzRvkM1G/yqcXp4SfV6SgU80
         dLCygOh7LnAtcbXdPjEI4ibNIJiYtDbl2Wm2Tr3sGLZ3IDK8AHKCKcvQS2V/L+OWWw06
         kE8/yhFBA0mVCg2vnF5zorGWdMDUTjtE2P2gjCbOEe9k3rq0dl8gb8+5Uu4ezUObvB8K
         7dcMhdvTIv1AU9214rpqDdSnMIM2yc+IYrlZjoyjSPJnDGHBQSrV/96npJ7SdQF+kcIL
         lEHFHENumW3LPJ+5fyHMip5DCNChGZmKQbPe7SAHXNgwiMtNJ5qQf/mOaZsNAFNxivm7
         eP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490945; x=1741095745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3XL4nlHnnlyPH4jYVrMU0QnNTngOwLFMHwhGLj0jSQ=;
        b=DW1As7noHkOtSXiQFv0XCOJ5lB2g2Vez1SuvGEc26LE/XgaxrUKcI0kZwSsq1HiBIp
         vPcYH1rodhb6RIRDnwfTvOvevZKLTtSvFDZjJt0L5MqblH9UtdkiR02gAUB9p+98OZbZ
         q5NheE9HKIZkAncYv2bMVG6lh6R1p5KBMx0fs+TxV+spiRKso/O78sPpqHrvMNpWqwQ+
         mdqX9PqVZK7uNU03ViRevE0wUXXFZjTSfqCN4OdIRwWEXaarLnop9yT76uzxdi4vQVO+
         5dVJwxX+0HiBL+rxJtHFruBPfP3ybcuG9AMzCHs5PYXW+dfqzn2zctgc72anrdnV4cNO
         1qWA==
X-Forwarded-Encrypted: i=1; AJvYcCXy/M8qfGdW7Kg+bktrLxeHQYEY2JrJAxGHG8A075qv5ljSFEt91foIbEVhRHxM9HwC4Jd0dcPsVDPa++o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+JgNHwb3+PNzmp7uz8Ge3BBLxEO7O7S43cRrOcVfwhurmDNWl
	P9FY5AkByhCgL5xk8n2jRHOSpYdFMJin50YPq1VTLVEhNDFvL/ZPcTp2HcCWx08=
X-Gm-Gg: ASbGncsrfwPeNsk3kGhLcBTCkQ6zXL5vhT3sQxlnhfkQtCEjraSdHD3G1n//92ayvSy
	d+bz/EeQGvoTa48J4jHSLH4AZAfef1eHNCWzfIzbyykoQVJFqBvGKIHgn8Y6ufp152tmJrd4Wqx
	+1jgAoKnXtN2NrgwJ9ESgUbA89NvbcycFN2VIWP9XlQ+kzgUT+hE6QnppBdfSmzJlRsp8LIoPL6
	2AbD4NJV1eZDbyElFOYKICDLR1QCVKBkHSh3makekU2hoAnaRy67expkrlR42+t2l74ovrg/krr
	mvVq99JEJZJZmPgtFix5
X-Google-Smtp-Source: AGHT+IHz/kHuckgA3TvrA+/LI4qYIECysjjksxwCyLbpI4maWhZXofOF7yzDRNHHsxuldeUWnRaCCg==
X-Received: by 2002:a05:600d:5:b0:439:30bd:7df9 with SMTP id 5b1f17b1804b1-439b04f9d29mr123525755e9.9.1740490944720;
        Tue, 25 Feb 2025 05:42:24 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b037213dsm142703895e9.40.2025.02.25.05.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:42:24 -0800 (PST)
Date: Tue, 25 Feb 2025 13:42:20 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Chen Yu <yu.chen.surf@foxmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	zihan zhou <15645113830zzh@gmail.com>, oe-lkp@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>, lkp@intel.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched]  2ae891b826:  hackbench.throughput 6.2%
 regression
Message-ID: <20250225134220.qjctfqwwhjz7bspp@airbuntu>
References: <202502251026.bb927780-lkp@intel.com>
 <tencent_6D9B516AFF16965A3BB652A049D6CA847706@qq.com>
 <20250225122705.GD34233@noisy.programming.kicks-ass.net>
 <tencent_CC411B43EAD996961A06366F606C96DD0406@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_CC411B43EAD996961A06366F606C96DD0406@qq.com>

On 02/25/25 21:15, Chen Yu wrote:
> On 2025-02-25 at 13:27:05 +0100, Peter Zijlstra wrote:
> > On Tue, Feb 25, 2025 at 05:31:34PM +0800, Chen Yu wrote:
> > 
> > > 
> > > But consider that the 6% regression is not that high, and the user might customize
> > > base_slice via debugfs on-demand, we can keep an eye on this and revist it in the
> > > future(we have encountered some SPECjbb regression due to over-preemption).
> > 
> > You can specify a per-task slice using sched_attr::sched_runtime. Also
> > see commit 857b158dc5e8 ("sched/eevdf: Use sched_attr::sched_runtime to
> > set request/slice suggestion")
> > 
> >
> 
> Thanks, we'll have a try during the next test cycle.

Could you also try with HRTICK enabled?

	echo HRTICK | sudo tee /sys/kernel/debug/sched/features

