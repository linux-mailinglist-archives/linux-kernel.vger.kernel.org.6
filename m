Return-Path: <linux-kernel+bounces-329515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D31979238
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C068B2185C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6977D1D0DE3;
	Sat, 14 Sep 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmky3W7F"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA0C4414
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726332885; cv=none; b=B3lo/oVO76WdYm5gnEMrWaJS3AzikKLCsCXKBGkftGHR7LwwDsnXeifohWLpix28MCUb0s3DXlCsbETHeVJZIWqUZQImctSXadlwOEKdugVSo8xtYsHnT7eu+K6/p0NkBU4F6g0YBuqFphN5dNpzKtQZ0jWcFtMA9qNCofISnnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726332885; c=relaxed/simple;
	bh=z5VesJRl/jV5UT7rRcGdT8C17aOfVnnW0ObeIcYpdNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ87YOoBq97J5yt69w/i+3bkeZQeDxXsmBMtPaSkEUcyISvMdIqTO/eF+D3xUzLJquOk1lftuVFdyPxwQH4roYvHOXrwFIMjeFvUQtGXQABHYlO4V0Tfxd4m7Et+oZAcHhIlLxZ+fTX82wiQr5czpc3TQtzR2b50D/3b4oJ8I6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmky3W7F; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1da3677ca7so2517837276.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726332883; x=1726937683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GY83ayXQMAAARMYQA/xQ3eoO5Exv84rjaCVVIgV4VpM=;
        b=Pmky3W7FCnEFbFjI/aLG/9MNAF0GSOgJ/ShpTyMLA06RPNneU61AiUbejOYKhdWQ/s
         s6Pl8lprvyioZ+7ifSQLiMYnyyiI0HpSz1KfgpuWx9UXcICbJEj70mXOisrk8TAO3RyD
         z2bf9neE5r61O8XdU1i6kMj7QvcJhNdzdaBvbeMyXWuHcJfs84TS/hSPZWy+VIGwKo3J
         FvmSSz7KB8Xf3aWl7OKfoCc3dfxqwt6zRW8T3Hzx3VgZ9QftwIg7/KFaK+9z3Z4dkpwh
         IYACzYwxAphI8QZeTATAt6BOZtg5EwxYtose6OcSsDJhpxUSgaomB5ZB2qgKWIcmP+Pa
         s7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726332883; x=1726937683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY83ayXQMAAARMYQA/xQ3eoO5Exv84rjaCVVIgV4VpM=;
        b=ZMBY4ccMUeUNldIa3JCcefkBs8aHNlToFxW4cBp8A3a7kModTN4wTMMUdH1+7jHKXN
         b/ydEXyOWUudOL3OEoNyQQLLFLDuz9DhcNKxOBqOXcMe0PkmDzyVT/5sdgYPhiLMIwmX
         ZnqY3UKZmBWrPXtIH9qDI0hDicKVu4Y8TuwZHokJJvkpl2thbxHoy+2Wxep+Kfc0qybX
         UiM0Qu5VqnTWY0HZXsHzIFiL/d+gDb7f+r+pIADMaxV3pMky1VuTmNoyJSJIIKgzBrct
         rrZpKSLtU43Y3bH0JQ1XM9nOXFkfCBPxUyRjCEfSRSBQes7guex0reINBA2qQgnjgA9j
         aeyQ==
X-Gm-Message-State: AOJu0Yyu+PRwhqItddFtYg8lwrn2vZ87IS+ipOhvxShyaOSMvAFKkyKN
	OTV3al4KizXi7beI+XIiXb/oZvtYPvip7+FP+bcj5oAC0Fwr3ZPzsj7qJMa/
X-Google-Smtp-Source: AGHT+IGyXetBt7WhMBQog8As5UmFG8GSXru1xDP0MfO26i7vtAPEhzZh22oQuMn0d2Y4sd55sB0fxg==
X-Received: by 2002:a05:6902:15c2:b0:e1a:7033:73a3 with SMTP id 3f1490d57ef6-e1d9dbd6743mr8549910276.27.1726332883113;
        Sat, 14 Sep 2024 09:54:43 -0700 (PDT)
Received: from localhost (c-71-203-131-184.hsd1.fl.comcast.net. [71.203.131.184])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1dc112e77csm318104276.18.2024.09.14.09.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 09:54:42 -0700 (PDT)
Date: Sat, 14 Sep 2024 09:54:41 -0700
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Chen Yu <yu.c.chen@intel.com>, Leonardo Bras <leobras@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3 0/3] sched/topology: optimize topology_span_sane()
Message-ID: <ZuW_0fMfPSix4qqX@yury-ThinkPad>
References: <20240902183609.1683756-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902183609.1683756-1-yury.norov@gmail.com>

Ping?

On Mon, Sep 02, 2024 at 11:36:04AM -0700, Yury Norov wrote:
> The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> even when cpu != i. In such case, cpumask_equal() would always return
> true, and we can proceed to the next iteration immediately.
> 
> Valentin Schneider shares on it:
> 
>   PKG can potentially hit that condition, and so can any
>   sched_domain_mask_f that relies on the node masks...
> 
>   I'm thinking ideally we should have checks in place to
>   ensure all node_to_cpumask_map[] masks are disjoint,
>   then we could entirely skip the levels that use these
>   masks in topology_span_sane(), but there's unfortunately
>   no nice way to flag them... Also there would be cases
>   where there's no real difference between PKG and NODE
>   other than NODE is still based on a per-cpu cpumask and
>   PKG isn't, so I don't see a nicer way to go about this.
> 
> v1: https://lore.kernel.org/lkml/ZrJk00cmVaUIAr4G@yury-ThinkPad/T/
> v2: https://lkml.org/lkml/2024/8/7/1299
> v3:
>  - add topology_cpumask_equal() helper in #3;
>  - re-use 'cpu' as an iterator int the for_each_cpu() loop;
>  - add proper versioning for all patches.
> 
> Yury Norov (3):
>   sched/topology: pre-compute topology_span_sane() loop params
>   sched/topology: optimize topology_span_sane()
>   sched/topology: reorganize topology_span_sane() checking order
> 
>  kernel/sched/topology.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> -- 
> 2.43.0

