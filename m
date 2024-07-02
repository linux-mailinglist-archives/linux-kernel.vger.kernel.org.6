Return-Path: <linux-kernel+bounces-237525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB35923A51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACF31F235DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D9A1552E3;
	Tue,  2 Jul 2024 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e161Zy2d"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E114C596
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913237; cv=none; b=JvFOKs4aZAjTxXSUroci89/WKTg4JA/Mc2V/SpUBp95LwGR/8sv4RsGtHm9q37fQCAl31EAATqrTnPm2r9mpnhOtFfG1EbY4WTNxOqxdTml7fa2v+3b25RAfurYo302QAFyblMeChXStqlt36R1pAMr52jBJb8wD94EWeAZqQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913237; c=relaxed/simple;
	bh=B7+94hvlkodJOvFHC3YK4CIhT2VDmqcOGPfsXeZNpxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqn83mhhL8JwzclCGZrei97EN6PTwBeqiyoGagDfRsBUJQWQen/qj82SbZIW5zE151Y/eR4dLEOKapaNUBlVV0CdnOIPyccGGa93dDn0sxCC4u9mBKjxQPWlYnsfGqI69Y6iQSmwy+RdD0Dvc5zYIWT28Ta8Rv+97ufQMDx5JiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e161Zy2d; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-64b05fab14eso36920657b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719913235; x=1720518035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq/Bbroqxvnpkgip5EYHo2n8xKxIxzuqj82AqyB4e9g=;
        b=e161Zy2dc+TPIXuzp/QpNIyGpkvwLczL1vuFiyM+qctLDrr0O7d65MFvRgmZu9aagU
         SrFzF+UkAnlTDrw+4hwNg+UMVGIOknzGKPYkQi+ZqVpcldCUFL3x37ZjsakvVdYyzOhB
         o8fmrhLRhkbBkyOMu/B9mM3+Tet0S/My0tp3JxwjK5z7Nwqs2IC1RkjueG39lX3LMUmL
         xCGCHCGWgZ1w2o0wdcStqan59lGlP2im37BtOm+ekfq1A+y0HtBJO812PXkVe8d58+a3
         wNBs7fta+giVboL9z3ArN/B9xb3fc1vrhyZ2P5DsBF4FZKpvUV50p6wIRAIc1fQZsJ+P
         z9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913235; x=1720518035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq/Bbroqxvnpkgip5EYHo2n8xKxIxzuqj82AqyB4e9g=;
        b=ImgZGzMN4mKJG7Nfs+jFjJ7hMbPT9eCmI9Kq+djx2KeDO4T9a19Hv6voL6uX5CM4es
         h6xVbaNBjrH4MBm1qdXc6MijfD6NvzRwl8AKulLINv6MtuH0w4Im7o+rgvg1rLrMmkrW
         3v7HRJ089eIgU5EKKcDYsBvpdmATbpd88yOoTNDq03wx1Uo7nkuv7hsg55kL11BZFUuG
         x9irURgCF4HoJsymNw0fNPd/9OADO2dP9x1e3AlPJoC2V1tao22YCRVV+VoAZ+ilX/X+
         KxQcWc4/f16bUsA5F5TzOc0lmb+W5MQHQhZ8KjS3Zc4KW71qkN0f7SAS8l7G4u0hOuaA
         C8gA==
X-Forwarded-Encrypted: i=1; AJvYcCUC1bkf1UfW5Rw9iDKDqW2eHdB/wnJa4qMaTK4I7NnIE8gnqlR0MhgsBAa0sDukqbV6yLiyUVXRa9/lZyMBgxfO5ym4hsdNQ7tfyjoR
X-Gm-Message-State: AOJu0Yw15NNgqQadjwFTFZ/wBJZDZ17lfA8DoGmz8Ptmw7TIW64afour
	PjlWzQ+4YVysSfUpl8GvMB7qZaGFF6B6dubUuE7vEdhHq9Na1lGRhg5iD8j5dIbPjJiyrJQy3kI
	n8g8OsAl9SabJwcVWQ9/qrbq30xxJsu/9USAyCg==
X-Google-Smtp-Source: AGHT+IHVPH+x2D9veQuZ61oIQPsTP9AxyUNRYacWvYz9JNRPToJi6VkCzlbwDQrN1Pa4LZ0UIwceeMzNftvj14uy+cs=
X-Received: by 2002:a81:a9c4:0:b0:63b:f6c1:6068 with SMTP id
 00721157ae682-64c7277c692mr81276737b3.32.1719913234764; Tue, 02 Jul 2024
 02:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627060518.1510124-1-quic_ekangupt@quicinc.com>
 <62dzilcvsp3efxpxulzkf6e62rzcrhp55k6yjk5fymkqthdfzw@yageexbx6ddz>
 <f3d502ca-228e-4be4-b296-a9073975d34b@quicinc.com> <a5e69a5e-b882-4f36-b023-f85da430fa2f@quicinc.com>
 <2024062849-brunt-humvee-d338@gregkh> <2e616e9d-fc04-4826-b784-4c6ee45bfbc2@quicinc.com>
 <foe6khsckzdvd5ccwitzfpdwoigdgu3uostuar3zk5d5stcd4s@hkrdg7vp4mqt> <3b07be20-e0c9-4ee2-a37b-34400e63862b@quicinc.com>
In-Reply-To: <3b07be20-e0c9-4ee2-a37b-34400e63862b@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Jul 2024 12:40:23 +0300
Message-ID: <CAA8EJpoxwNv-wpJvqEf9U+Dg9=BJXG++GWB+2DES92MSqXN-3w@mail.gmail.com>
Subject: Re: [PATCH v2] misc: fastrpc: Remove user PD initmem size check
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, srinivas.kandagatla@linaro.org, 
	linux-arm-msm@vger.kernel.org, quic_bkumar@quicinc.com, 
	linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, 
	dri-devel@lists.freedesktop.org, arnd@arndb.de, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 10:07, Ekansh Gupta <quic_ekangupt@quicinc.com> wrote:
>
>
>
> On 7/1/2024 10:41 PM, Dmitry Baryshkov wrote:
> > On Mon, Jul 01, 2024 at 10:50:38AM GMT, Ekansh Gupta wrote:
> >>
> >> On 6/28/2024 7:51 PM, Greg KH wrote:
> >>> On Fri, Jun 28, 2024 at 04:12:10PM +0530, Ekansh Gupta wrote:
> >>>> On 6/28/2024 3:59 PM, Ekansh Gupta wrote:
> >>>>> On 6/27/2024 4:43 PM, Dmitry Baryshkov wrote:
> >>>>>> On Thu, Jun 27, 2024 at 11:35:18AM GMT, Ekansh Gupta wrote:
> >>>>>>> For user PD initialization, initmem is allocated and sent to DSP for
> >>>>>>> initial memory requirements like shell loading. This size is passed
> >>>>>>> by user space and is checked against a max size. For unsigned PD
> >>>>>>> offloading, more than 2MB size could be passed by user which would
> >>>>>>> result in PD initialization failure. Remove the user PD initmem size
> >>>>>>> check and allow buffer allocation for user passed size. Any additional
> >>>>>>> memory sent to DSP during PD init is used as the PD heap.
> >>>>>> Would it allow malicious userspace to allocate big enough buffers and
> >>>>>> reduce the amount of memory available to the system? To other DSP
> >>>>>> programs?
> >>>>> The allocation here is happening from SMMU context bank which is uniquely assigned
> >>>>> to processes going to DSP. As per my understanding process can allocate maximum
> >>>>> 4GB of memory from the context bank and the memory availability will be taken care
> >>>>> by kernel memory management. Please correct me if my understanding is incorrect.
> >>>> Just wanted to add 1 question here:
> >>>> User space can also directly allocate memory. Wouldn't that be a problem if any malicious userspace
> >>>> allocated huge memory?
> >>> No, because any userspace program that takes up too much memory will be
> >>> killed by the kernel.
> >>>
> >>> You can not have userspace tell the kernel to allocate 100Gb of memory,
> >>> as then the kernel is the one that just took it all up, and then
> >>> userspace applications will start to be killed off.
> >>>
> >>> You MUST bounds check your userspace-supplied memory requests.  Remember
> >>> the 4 words of kernel development:
> >>>
> >>>     All input is evil.
> >> Thanks for the detailed explanation, Greg. I'll remember this going forward.
> >>
> >> For this change, I'll increase the max size limit to 5MB which is the requirement for
> >> unsigned PD to run on DSP.
> > So we are back to the quesiton of why 5MB is considered to be enough,
> > see
> >
> > https://lore.kernel.org/linux-arm-msm/2024061755-snare-french-de38@gregkh/
> This is based on the initial memory requirement for unsigned PD. This includes memory for shell loading on DSP
> + memory for static heap allocations(heap allocations are dynamic for Signed PD). This requirement tends to
> around 5MB. I'll update this  also information in commit text. There will be some additional memory passed to
> the PD which will get added to the PD heap.

Could you please clarify, are these 2MB and 5MB requirements coming
from the DSP side or from the userspace side? In other words, is it
coming from the shell / firmware / etc?

>
> --Ekansh
> >
> >> --Ekansh
> >>> thanks,
> >>>
> >>> greg k-h
>


-- 
With best wishes
Dmitry

