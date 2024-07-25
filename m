Return-Path: <linux-kernel+bounces-261729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6686E93BB65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B2DB23851
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B515182C9;
	Thu, 25 Jul 2024 04:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5aVO7mV"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB37FF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721880576; cv=none; b=D3vV7k5dwDnI3L8vDAvGJxTq0H/yjAL4cNSE4TkndOxCWjIWzyMVwJ01nFx/uEvz8sLRyESTYYlL/PfZ0XedQxfU3z/ikCwz6yWEbH9643OHrL9DfbUkOApDLoPIE0QkFU063nHNGtdPas5GDRKQtNPtLb82H4S7dP10F4wRru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721880576; c=relaxed/simple;
	bh=p5GtbNHNRQ5r/oD5RNkuzVgkS4Fr7AIwgKC1jwN4934=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epxm01pI3Q8iKK9Gd+M5QunQtj4XigAXRG20z3FwcnzQiPAzLlZeyDSCryiMxPuZPpaAU+nOZKVgJ9P7bbWCJbkvHTvv296kAClWSH8r0EWT1h6Bpc7k7YmWeNP5q2eHBvmytYPc6YOUs/Z/00yvvfVtaiKLWNJ1lpgfGqlFFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u5aVO7mV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f01e9f53ebso5615601fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721880573; x=1722485373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2aLaJYQrt2Mrpa6ixTAmSx6t43lvxNvXrJytjXn2tsc=;
        b=u5aVO7mVeGPMacn595k5oAlKOmcQhVP6NDIOAPJTKMu6I+1oq4e+QLwuzkfE9p5+Ix
         9NwaXLZnNmbp7IhrlEDr8x0UINKRVKDt6S3FellHSrCjoHniO/WRq2Tnwuv9I7HIphob
         znoNio16PDtyBxyTs5JKNo3xm/FvjpuVoCOrUrH3prkucy/GzrbJT/prQenGlET502EL
         MWB5byikLmI6K30sAYXGI5//DQWC4op4ZUZpAWVttfE/ZCNoTIF1D7oyLE+Edko2jjCR
         7vUCcM1m4+4mJtSGY74kC85TK00N1FKN3m+lAB36Rlq3MddSbu1hVZH6zUy2okNA/QmU
         TqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721880573; x=1722485373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aLaJYQrt2Mrpa6ixTAmSx6t43lvxNvXrJytjXn2tsc=;
        b=NXR/s6djdjRojBcMvO21F/eHuHtut2ZnNwk5ZRcu2B3+Z5w+QwQIK9Q/q04B/Z86Gl
         N0lt6D+RlLIhYt/F+R0nARAPqdREUiTaKWonQHD3o/wnP2Y5qbIFnGgNwyXsYQqZO7k6
         S7aCDhxA2l2cOXwUCBXC4yQs7ARtKIn/fDgrV6NSg8Po7ESwLSxATxAFB3uiJLurRiWI
         yDm51B9vdpZsNDF+DKOp1N08BdB0FSjzEVygw7HX5I/JKdfODv9HVqmm2QIZGmWYf8QU
         X0NCQNxD8Zyd2XE0RUaPQexf9wjb49waNV9XaBtmBft1KFN/th9ubECnkd+H+3FkdtiW
         3V1g==
X-Forwarded-Encrypted: i=1; AJvYcCVxeaFuu9utOV5Syfc6CdiTP1uHfR/5FxBuY6RoAyDUbpaGCitwRGYfiCwlPNBQrbpaWh6peMYA0nrhJbvhLhc+KVJGHpAcC+cPeEAX
X-Gm-Message-State: AOJu0Yyz6Mw+ssPm1PN2oya5PSmElVOZYQb3GJqgUI3j7qt088FDW8KN
	+Y2xV0VNlJ2ds0RiuSqqTAc7u8L9G/Vagmf35dkB3zYK8NQKCUfMuPBcaq11ypk=
X-Google-Smtp-Source: AGHT+IHHSLqQht8+k7EY6AfB3rbMJpvFsWVF+UqzojkS4iXdaTdaP69THmV9umWbUpansa7zrf2raA==
X-Received: by 2002:a05:651c:207:b0:2ef:22ad:77b5 with SMTP id 38308e7fff4ca-2f039cc448amr10613301fa.29.1721880572931;
        Wed, 24 Jul 2024 21:09:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf55cfasm751491fa.65.2024.07.24.21.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:09:32 -0700 (PDT)
Date: Thu, 25 Jul 2024 07:09:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, srinivas.kandagatla@linaro.org, bartosz.golaszewski@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH RFC 1/3] firmware: qcom: implement object invoke support
Message-ID: <gtdr5s7yih7pjuhpfkjmlu2lflya4heiph4wi446rlbxduqlya@5xfix7dyocli>
References: <20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee@quicinc.com>
 <20240702-qcom-tee-object-and-ioctls-v1-1-633c3ddf57ee@quicinc.com>
 <ink4tq3wk2jkpybiisaudkun3g2x2drfogrdw43zdpi6yh2u5g@yrvrxzxsi46g>
 <836dab13-9c59-4d87-a600-a0be6506deb2@quicinc.com>
 <CAA8EJprp2veCaQq8GsYv4Mu1HQbx8nWv0XWtxcE4cu5kxkA16w@mail.gmail.com>
 <f9e5ef49-754c-4d97-8186-634674151b2f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e5ef49-754c-4d97-8186-634674151b2f@quicinc.com>

On Thu, Jul 25, 2024 at 01:19:07PM GMT, Amirreza Zarrabi wrote:
> 
> 
> On 7/4/2024 5:34 PM, Dmitry Baryshkov wrote:
> > On Thu, 4 Jul 2024 at 00:40, Amirreza Zarrabi <quic_azarrabi@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 7/3/2024 10:13 PM, Dmitry Baryshkov wrote:
> >>> On Tue, Jul 02, 2024 at 10:57:36PM GMT, Amirreza Zarrabi wrote:
> >>>> Qualcomm TEE hosts Trusted Applications and Services that run in the
> >>>> secure world. Access to these resources is provided using object
> >>>> capabilities. A TEE client with access to the capability can invoke
> >>>> the object and request a service. Similarly, TEE can request a service
> >>>> from nonsecure world with object capabilities that are exported to secure
> >>>> world.
> >>>>
> >>>> We provide qcom_tee_object which represents an object in both secure
> >>>> and nonsecure world. TEE clients can invoke an instance of qcom_tee_object
> >>>> to access TEE. TEE can issue a callback request to nonsecure world
> >>>> by invoking an instance of qcom_tee_object in nonsecure world.
> >>>
> >>> Please see Documentation/process/submitting-patches.rst on how to write
> >>> commit messages.
> >>
> >> Ack.
> >>
> >>>
> >>>>
> >>>> Any driver in nonsecure world that is interested to export a struct (or a
> >>>> service object) to TEE, requires to embed an instance of qcom_tee_object in
> >>>> the relevant struct and implements the dispatcher function which is called
> >>>> when TEE invoked the service object.
> >>>>
> >>>> We also provids simplified API which implements the Qualcomm TEE transport
> >>>> protocol. The implementation is independent from any services that may
> >>>> reside in nonsecure world.
> >>>
> >>> "also" usually means that it should go to a separate commit.
> >>
> >> I will split this patch to multiple smaller ones.
> >>
> > 
> > [...]
> > 
> >>>
> >>>> +    } in, out;
> >>>> +};
> >>>> +
> >>>> +int qcom_tee_object_do_invoke(struct qcom_tee_object_invoke_ctx *oic,
> >>>> +    struct qcom_tee_object *object, unsigned long op, struct qcom_tee_arg u[], int *result);
> >>>
> >>> What's the difference between a result that gets returned by the
> >>> function and the result that gets retuned via the pointer?
> >>
> >> The function result, is local to kernel, for instance memory allocation failure,
> >> or failure to issue the smc call. The result in pointer, is the remote result,
> >> for instance return value from TA, or the TEE itself.
> >>
> >> I'll use better name, e.g. 'remote_result'?
> > 
> > See how this is handled by other parties. For example, PSCI. If you
> > have a standard set of return codes, translate them to -ESOMETHING in
> > your framework and let everybody else see only the standard errors.
> > 
> > 
> 
> I can not hide this return value, they are TA dependent. The client to a TA
> needs to see it, just knowing that something has failed is not enough in
> case they need to do something based on that. I can not even translate them
> as they are TA related so the range is unknown.

I'd say it a sad design. At least error values should be standard.

-- 
With best wishes
Dmitry

