Return-Path: <linux-kernel+bounces-261756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B773793BBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9AB1C21784
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6370A1CA9E;
	Thu, 25 Jul 2024 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+wOKq8U"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF011C2A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881983; cv=none; b=dOhHi/AS970Ap9dTnAyXkT4cJ5BlAKR1CWys5RncnxnB4DaD86AL2Eyd7TlNrwfjmHBHan4m3wrxgRb8ezIM/R2oRLt3MsYAw/T/rFrrnhb7FHSjtqZhy5CZ07bGQ9+6xXKhqDVe+f6FfNObwdlgsKonUYJmbmRlbo87tDJ+nGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881983; c=relaxed/simple;
	bh=9PUDpDX3YVNuKkUqONsTAeenTRx75NVihwe7qXjgTvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5Z/QZ4gtEStWZUuofm33UCKtmJuiO9clRTGTh2oQczAr73FmoA0i3NJ9t41mYXjwuhxHiziHeqecyifsgYun8ekOgWZTfYszJEpGOR69VV+RAaRu0PNhKk06l+KbgGXLcs8FnPlRjf1mTfRiZrWA2cSqEDg+2hVFvyTyYXhP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p+wOKq8U; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6512866fa87so4779637b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721881981; x=1722486781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rDFqw6oHHPxpfXtOUHUn1IVLUDP2YjdBprOP06yJvHQ=;
        b=p+wOKq8UFkzZntssawnaETB7+9V4o3x7q6aHPWa/rwUv9OzNPcOFkh9McJeJE0fQb0
         QoU3DsT8nJ4s3mkcupW88zf2yzAq9aEEthQJH15UwrbYq9tvrBqDJsZGVMBaKhZ7shv5
         xO2nmHqOh2MaZKSngMEapCmom8y54yk2v1x9sgerz3jamiFgZ48Iwhw+o5M7Dy7H0GVJ
         PJ331rVDelA5A/AsI0h+CX68lKOthMvk8ms72pCGQh4lV82OyVGS3doXXxQkQnxgZdA8
         9coGfyDPrf8IYzIFUbLKzs2oJLfWkzFKCKTedijsDlHtstVlsta8a8R0nVNKhTVhYdXn
         ElQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881981; x=1722486781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDFqw6oHHPxpfXtOUHUn1IVLUDP2YjdBprOP06yJvHQ=;
        b=meIOb8lYml/0SPfMIG6mdr532L2FHJhhxwGTtvSK8vZHcvYxTK5AWONQlfIzG3iK32
         9Q+v2fNYC5z4j/QFtsOCY9JiDFpeVfArwkrMYDfFhdPnTEp4olwEtoiXX1VhnmZBVCEg
         2nz1nzOCb88dIlBq8vbXQCKQr72xf0eaCnOzLIKX0uxbN+uncBc/6iJd5ZY29sLozyYF
         T7PJAzSbFMs1mIJcJ38ohaDzYTaA8X6EIvjJHvckm/c+cXzzsYCvQ68X7cSYLpRl/DCR
         kCXNY84ptb0aQM+5R0SU8wZFJpFLW/TGi7l5A5RwKOOKO8gurjZy2meYqtsundQH8Ymv
         IYrw==
X-Forwarded-Encrypted: i=1; AJvYcCV8UldjPOdT+aaGFt1VzscZkL2kcXkmGIC/PwZDq7K3FnJCpr/PijOgmeiKIyfjgxyfuXsuGFU9IVXHIvtLcnmkrMSiRVG0WCC8Tx+u
X-Gm-Message-State: AOJu0YxdDPOPmLONWx8w0Vw/3i/nW/bh5sdzdJZDpJDhV4IjvOIb1h5N
	Wb83AXr+3pW1Lqfp1V71dKpkvoVML74j2AYEfZIO/tplPjg3ceEbWwhQ1wcfxCLZ8ww69fSfAtI
	Ene1ZNb1rb35NynRRLXDlGTOyuG8gYEZGxsp0Ug==
X-Google-Smtp-Source: AGHT+IHUKsyqw7tG3OOmxBx8cB5eWQECQmicrTjKE/6hNnrXGqghpEGBVp8H937CrHq2VeWgvBoopVddULDaspRFEXw=
X-Received: by 2002:a0d:e701:0:b0:669:e266:2c55 with SMTP id
 00721157ae682-6751082c4e4mr17035787b3.5.1721881980943; Wed, 24 Jul 2024
 21:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee@quicinc.com>
 <20240702-qcom-tee-object-and-ioctls-v1-1-633c3ddf57ee@quicinc.com>
 <ink4tq3wk2jkpybiisaudkun3g2x2drfogrdw43zdpi6yh2u5g@yrvrxzxsi46g>
 <836dab13-9c59-4d87-a600-a0be6506deb2@quicinc.com> <CAA8EJprp2veCaQq8GsYv4Mu1HQbx8nWv0XWtxcE4cu5kxkA16w@mail.gmail.com>
 <f9e5ef49-754c-4d97-8186-634674151b2f@quicinc.com> <gtdr5s7yih7pjuhpfkjmlu2lflya4heiph4wi446rlbxduqlya@5xfix7dyocli>
 <a1f4457a-2313-4d75-9857-0d82cd502343@quicinc.com>
In-Reply-To: <a1f4457a-2313-4d75-9857-0d82cd502343@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Jul 2024 07:32:49 +0300
Message-ID: <CAA8EJpojNj0wB1aG3JWBc3AVGAUH7foShiWsX4MYdkYJLWRn8Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] firmware: qcom: implement object invoke support
To: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	srinivas.kandagatla@linaro.org, bartosz.golaszewski@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 07:15, Amirreza Zarrabi
<quic_azarrabi@quicinc.com> wrote:
>
>
>
> On 7/25/2024 2:09 PM, Dmitry Baryshkov wrote:
> > On Thu, Jul 25, 2024 at 01:19:07PM GMT, Amirreza Zarrabi wrote:
> >>
> >>
> >> On 7/4/2024 5:34 PM, Dmitry Baryshkov wrote:
> >>> On Thu, 4 Jul 2024 at 00:40, Amirreza Zarrabi <quic_azarrabi@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/3/2024 10:13 PM, Dmitry Baryshkov wrote:
> >>>>> On Tue, Jul 02, 2024 at 10:57:36PM GMT, Amirreza Zarrabi wrote:
> >>>>>> Qualcomm TEE hosts Trusted Applications and Services that run in the
> >>>>>> secure world. Access to these resources is provided using object
> >>>>>> capabilities. A TEE client with access to the capability can invoke
> >>>>>> the object and request a service. Similarly, TEE can request a service
> >>>>>> from nonsecure world with object capabilities that are exported to secure
> >>>>>> world.
> >>>>>>
> >>>>>> We provide qcom_tee_object which represents an object in both secure
> >>>>>> and nonsecure world. TEE clients can invoke an instance of qcom_tee_object
> >>>>>> to access TEE. TEE can issue a callback request to nonsecure world
> >>>>>> by invoking an instance of qcom_tee_object in nonsecure world.
> >>>>>
> >>>>> Please see Documentation/process/submitting-patches.rst on how to write
> >>>>> commit messages.
> >>>>
> >>>> Ack.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Any driver in nonsecure world that is interested to export a struct (or a
> >>>>>> service object) to TEE, requires to embed an instance of qcom_tee_object in
> >>>>>> the relevant struct and implements the dispatcher function which is called
> >>>>>> when TEE invoked the service object.
> >>>>>>
> >>>>>> We also provids simplified API which implements the Qualcomm TEE transport
> >>>>>> protocol. The implementation is independent from any services that may
> >>>>>> reside in nonsecure world.
> >>>>>
> >>>>> "also" usually means that it should go to a separate commit.
> >>>>
> >>>> I will split this patch to multiple smaller ones.
> >>>>
> >>>
> >>> [...]
> >>>
> >>>>>
> >>>>>> +    } in, out;
> >>>>>> +};
> >>>>>> +
> >>>>>> +int qcom_tee_object_do_invoke(struct qcom_tee_object_invoke_ctx *oic,
> >>>>>> +    struct qcom_tee_object *object, unsigned long op, struct qcom_tee_arg u[], int *result);
> >>>>>
> >>>>> What's the difference between a result that gets returned by the
> >>>>> function and the result that gets retuned via the pointer?
> >>>>
> >>>> The function result, is local to kernel, for instance memory allocation failure,
> >>>> or failure to issue the smc call. The result in pointer, is the remote result,
> >>>> for instance return value from TA, or the TEE itself.
> >>>>
> >>>> I'll use better name, e.g. 'remote_result'?
> >>>
> >>> See how this is handled by other parties. For example, PSCI. If you
> >>> have a standard set of return codes, translate them to -ESOMETHING in
> >>> your framework and let everybody else see only the standard errors.
> >>>
> >>>
> >>
> >> I can not hide this return value, they are TA dependent. The client to a TA
> >> needs to see it, just knowing that something has failed is not enough in
> >> case they need to do something based on that. I can not even translate them
> >> as they are TA related so the range is unknown.
> >
> > I'd say it a sad design. At least error values should be standard.
> >
>
> Sure. But it is normal. If we finally move to TEE subsystem, this is the value that
> would be copied to struct tee_ioctl_invoke_arg.ret to pass to the caller of
> TEE_IOC_INVOKE.

Ack

-- 
With best wishes
Dmitry

