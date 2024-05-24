Return-Path: <linux-kernel+bounces-188437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999E78CE201
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5547B282EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C49128832;
	Fri, 24 May 2024 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkNSMJbO"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFAA17578
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538188; cv=none; b=ZAzPa6rKClqoM8g9F64yVHOfo+4mV7sDxSETfUlo+CnLwGTEaVOUgUjc9LOV+6x58LGKrywbgEmDYbvnKuzTgQS/uA5FhkdMhrQHAcRknK36+QJ6LCALDxHwnFM71rIpb0ONZ+/UbhMCHJ/eQA3y5Su5JeaN9y4s82E1h8MB4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538188; c=relaxed/simple;
	bh=M9VBoq6dREqgaOs5ZCoiH/xJnCr8Qi/PvPkkfAnMqT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuNDqXBR1ya8PlCrvERDN0dYuxdpJZZVeqIBBTmwObFZ92ShLGcj6pRHahLvX/yTzeVkVfiAZAm5fAAbsaCjKJ++Xrd5N8QVonPV2HkwRD0jDLQA+v44fo7u0/n1kKRf0Ew5x07C1DLSPhyQG5hiFAodIrvSgnGDAEwVvSAmeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkNSMJbO; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e576057c2bso126042651fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716538184; x=1717142984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2lSidCsB9ehXoWQ8boWr3QTXV4fjcTGdt04EwooGBA=;
        b=vkNSMJbO7R2aGdYyZ8SCmG6zzEE6aDMrcgZAeCx3fGDh+Pz5olsDQNpoAjCbOq2xwI
         ABgQI3+SYZwBg2EM+2JlI3CTexuAWKJ3UORTDdDoHpuY3/SmEgOwJVStmWfq+HN++ZGS
         QZL1yOpATt81sV/zm/QmsUA7tmOaNcVU+JlQ+hMJf5AuJwcB3U5ymR1NfpnZLTohFjJk
         xm6O0GNlRO35TStBNwNMmljAwy2XmPAF8i7rdyfscal19BhCzzkOEk5h7QHfa3R0p/48
         H9eM6xTnXgSwjd8U5Q/xw4ybeyaiBPmHS2C4sz4W+/TwG1/A8x1SahzNvcPP4uFh2Lag
         /b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716538184; x=1717142984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2lSidCsB9ehXoWQ8boWr3QTXV4fjcTGdt04EwooGBA=;
        b=bqh8+54eT8qT/pZIh6GvFO15QpHTEuGQ/Ry/4ehlxriDVtM/PBrwfaDjYwXdi/g0dP
         wt9thAdChW0AHPZngBfUqfSaD8xI6nXppOGsyjwGpC7eOruybHBe6eCVlTFzcltYUTw9
         l87nxopM/eeCBZl1oAQXDdE7D4luYzhBuDEt30YPV7+VTr7kgMN+4fk8/2hF9lPSaPVh
         bF/px1YDYW3KgByYGn4TSFFGLX3z3E1kP5AMBL8rIOMx/rdKElMLIqthdErvyGD6C4GZ
         Le8giVBHn/99BpPDfqF4Xdm5SnU6kNygmqv1GKc7t/JyVQGcC2hKIJAlfzS2kLPHEYDE
         XtcA==
X-Forwarded-Encrypted: i=1; AJvYcCXea54zAb6Kkb6ORJLxIrBDDiud3qvfivRt+n6uPVJDOlsI/wWydYGPoGn0A30rMiYiSkZb3KFgtyCHsyta9TLOJu6lwIL3TiKB+apk
X-Gm-Message-State: AOJu0YxfpAg07ekgTwM9QrdgHY59wvqvCBUIcPJCl+KLWqIAh8jIgb4f
	m4HKDrVCa/O9QsyBDObkGt6Mh1ZEG12ULpGLZeaCKaRVJGXfhhn/owhgSQ7lKw==
X-Google-Smtp-Source: AGHT+IGzgQlRJ5ug3LTivhVUY93cMPG5I4SOe6hVc5ZOXCHlEHuiL4z22/IDhTQdsTn2j4oV9P3KDA==
X-Received: by 2002:a2e:a1d0:0:b0:2e2:a99a:4c4 with SMTP id 38308e7fff4ca-2e95b27b113mr11582591fa.47.1716538184250;
        Fri, 24 May 2024 01:09:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:7092:8288:69bc:29e5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc487fsm963351fa.24.2024.05.24.01.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 01:09:43 -0700 (PDT)
Date: Fri, 24 May 2024 10:09:39 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v5 1/3] perf report: Support LLVM for addr2line()
Message-ID: <ZlBLQ87edfIHiGRt@google.com>
References: <20240523092920.3355004-1-sesse@google.com>
 <Zk-MpqzRlAecrWA6@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk-MpqzRlAecrWA6@x1>

On Thu, May 23, 2024 at 03:36:22PM -0300, Arnaldo Carvalho de Melo wrote:
> Makefile.config:982: No libllvm found, slower source file resolution, please install llvm-devel/llvm-dev
> 
> ...                                    llvm: [ OFF ]
> 
> But maybe use "libllvm"?

I think I was trying to be consistent with the previous patch using LLVM
(something with Clang and eBPF, I think?), which used llvm and not
libllvm for the name here :-) And I don't think upstream actually uses
the libllvm name much (e.g. as you can see, it's llvm-devel, not
libllvm-devel). But I can change it if you think it's a better name;
I don't mind much either way.

> So mostly the above, and:
> 
> root@x1:~# perf probe -x /usr/bin/find -L find | grep fts_read
>      44        while ( (errno=0, ent=fts_read (p)) != NULL )
>                /* fts_read returned NULL; distinguish between "finished" and "error". */
> root@x1:~#

This part went a bit over my head, I'll just assume it's good. :-)

> So the libllvm is even producing a better result, showing those inlines
> not seen in the BFD based output.

I think maybe you need to give --inlines to BFD objdump to get it to
show inlines. (It can be useful in perf annotate sometimes.)
But annoyingly enough, LLVM objdump does not understand the flag.

> 100x speedup, looks like a win! 8-)

Great, thanks for testing. :-)

> Thanks a lot, the comments I made on the patch are mostly coding style,
> please consider them, but I wouldn't get in the way for this patch to
> get merged because of that albeit would be nice to try to fit in more
> nicely with the existing source code base.

Sure, I'll make a v6 with the requested changes. Just some
questions/comments below.

>> +		*inline_frames = (llvm_a2l_frame*)malloc(
>> +			sizeof(**inline_frames) * num_frames);
> Do we really need to cast here (my C++ is super rusty), and why not
> calloc()?

Yes, C++ does not have implicit cast-from-void*. The C++ way would be
new[] or use std::vector, but, that would make it impossible for the
caller to free(). I can use calloc, it won't change much either way.

> > +			dst.funcname = strdup(src.FunctionName.c_str());
> If strdup fails, users will cope?

Yes, same as dst.filename. new_inline_sym() (which is where we give this
data to) has an explicit check for if (!funcname).

> > +		Expected<DILineInfo> res_or_err =
> > +			symbolizer->symbolizeCode(dso_name, sectioned_addr);
> same line?

That takes it way over 80 characters, is that OK?

/* Steinar */

