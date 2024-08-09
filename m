Return-Path: <linux-kernel+bounces-281015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17DB94D1EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8849281857
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F5197A88;
	Fri,  9 Aug 2024 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gmca4lK0"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FFC1D551
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212851; cv=none; b=IeUIhNBctHwEIj8xoLM9MkqdA/D0J/Eh+uqs+LJqLk0x2/vjuL2FmlfwRwJN4yBB3eIoj3qp/pouRjllBDz2FoixHpjHmxIE6nF5swk47TP21jj8Q9YyycQUMEkKwJoyO301G3msOu7tk7BXTjUumJ6mrTSHjbOwxdTq/JXaTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212851; c=relaxed/simple;
	bh=lNFlLkhfL7PGmym6bYzcbV4ss8tvTi31Rbwht10lofI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiUOnUtnPr5uQbPEXSvlQIU5ZhSjcp3olLRYe9yiDnEPBYUZNckXg2Thfbd2v7vQz4LZTrKytO5ehfvGUokcESOP1gXNdJvVdRR/HImlSnj+9o3DsSfiuQ3AT5TLoIQqGqZmPZrc51JLakSFXs94j2dm8lYtGvnUuYCSmPCISs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gmca4lK0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ff1cd07f56so18397675ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723212848; x=1723817648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp39z+u4lrroAv5FlQuGnxo/zwyflIlnYSEFg4kk+oY=;
        b=Gmca4lK0hMU7sfLviJjUzD/+4WVIBZ2m5D0TBfWzmm5HmxQwHLAWzh9IgwWUjgd30P
         wUURxFRss3GLorkdNRGIDWMlbdfDyLzuijq0wS3u6Iy8tQwSJlETcuHCPpuNMKc5lP6n
         Qr5wqafx8Q9puYNVnuSvV2I9Lv48hoBEDWfjxwO1s515rDhYdgMILVF9mfmUl8Z/dtIt
         g/5we252R9Wlo9k3elphAQF4mXJpX+6W+voA0RltPh2lDkjunGDq29uM6g9AHNoMH8dM
         0Qgshae1mGmS9FEoU+7CSxXXLT+u/tWmLRsjbwAWXy7FhQ4crDhDbao9ZqzV/t7u0kQX
         MLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212848; x=1723817648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp39z+u4lrroAv5FlQuGnxo/zwyflIlnYSEFg4kk+oY=;
        b=VIIe8iDgDzpXqqnxWLtf9BuKnBvtkI3LGycBiMIq3pOVSmQucPByj9DdScJte+g9nM
         TCJ+8XwWjZoJdm5VA2Od2unhHDeRDzXKjbWcnGD6MQ461aQ0wzLSfeAQMbPCezN44qrw
         dzhxLoUXTnSaf9es+5pULW6LDWoJL64neWYNbYhCQb5j4a4a61MLRwOp3tVA6E3gKF+L
         YidD6GkHb5NHw62sGEW9nrhrRYtuUB8f2hLD3fBZqUYF81FTHvnq6c+m2kJQQR94+Lfo
         i9FnTfK0HtKcp8Mn8bt8320PUYqDwSP6zx0+OgD4DA3Q4OTMgOssbDIBqHxovLG1CNMt
         avjA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Zs6lG2tojxoVBd7zQYRL08ljS90BUM8WXuYVfiFXRppAT7sXYSWJmPdZKfyQqNTy5qTC3Or20XNRXG4z5ImYYimzRc1WZo38ot7D
X-Gm-Message-State: AOJu0Ywkyi8iDWN1C5gJmsDChLHB/r71Sv8u37OpGMwSKi/mnA9xLuUJ
	ONoYuhUxtlTa/exnAirj5JnEd6We6DQP0EMkKjl6HHfAeXKtQbP0pyYhy9OFLR24gA6Rhwv6Pcv
	Qsi39wPBHf6l2Uz3b0A0PH0YoibIM8RKPpmaFaNbiBG12WIoe
X-Google-Smtp-Source: AGHT+IFyMQUTum0CqjZAJJvppxm1rAPilIvHqmOtoXaZfy5yrhQPNhXHNDxUbJ5rDqe1YrKyPxYvIictHLGJhJIcb/s=
X-Received: by 2002:a17:902:e543:b0:1ff:4d2a:fe43 with SMTP id
 d9443c01a7336-200ae5e6a9bmr20147015ad.61.1723212848304; Fri, 09 Aug 2024
 07:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org> <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org> <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org> <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org> <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org> <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org> <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org> <4dd7f210-c03e-4203-b8e9-1c26a7f8fe79@arm.com>
 <c73573e7-206e-4a6c-b6c6-27903978d0aa@linaro.org>
In-Reply-To: <c73573e7-206e-4a6c-b6c6-27903978d0aa@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 9 Aug 2024 15:13:56 +0100
Message-ID: <CAJ9a7VhJFNxPCVva5tS51SBaxx76nFq9in0MGJe2jEwbVdSTkA@mail.gmail.com>
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, scclevenger@os.amperecomputing.com, 
	acme@redhat.com, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com, 
	Al.Grant@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi James

On Thu, 8 Aug 2024 at 10:32, James Clark <james.clark@linaro.org> wrote:
>
>
>
> On 07/08/2024 5:48 pm, Leo Yan wrote:
> > Hi all,
> >
> > On 8/7/2024 3:53 PM, James Clark wrote:
> >
> > A minor suggestion: if the discussion is too long, please delete the
> > irrelevant message ;)
> >
> > [...]
> >
> >>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> >>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> >>> @@ -257,6 +257,11 @@ def process_event(param_dict):
> >>>                   print("Stop address 0x%x is out of range [ 0x%x .. 0x%x
> >>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
> >>>                   return
> >>>
> >>> +       if (stop_addr < start_addr):
> >>> +               if (options.verbose == True):
> >>> +                       print("Packet Dropped, Discontinuity detected
> >>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr,
> >>> dso))
> >>> +               return
> >>> +
> >>
> >> I suppose my only concern with this is that it hides real errors and
> >> Perf shouldn't be outputting samples that go backwards. Considering that
> >> fixing this in OpenCSD and Perf has a much wider benefit I think that
> >> should be the ultimate goal. I'm putting this on my todo list for now
> >> (including Steve's merging idea).
> >
> > In the perf's util/cs-etm.c file, it handles DISCONTINUITY with:
> >
> >     case CS_ETM_DISCONTINUITY:
> >          /*
> >           * The trace is discontinuous, if the previous packet is
> >           * instruction packet, set flag PERF_IP_FLAG_TRACE_END
> >           * for previous packet.
> >           */
> >          if (prev_packet->sample_type == CS_ETM_RANGE)
> >                  prev_packet->flags |= PERF_IP_FLAG_BRANCH |
> >                                        PERF_IP_FLAG_TRACE_END;
> >
> > I am wandering if OpenCSD has passed the correct info so Perf decoder can
> > detect the discontinuity. If yes, then the flag 'PERF_IP_FLAG_TRACE_END' will
> > be set (it is a general flag in branch sample), then we can consider use it in
> > the python script to handle discontinuous data.
>
> No OpenCSD isn't passing the correct info here. Higher up in the thread
> I suggested an OpenCSD patch that makes it detect the error earlier and
> fixes the issue. It also needs to output a discontinuity when the
> address goes backwards. So two fixes and then the script works without
> modifications.
>

Which address is going backwards here? - OpenCSD generates trace
ranges only by walking forwards from the last known address till it
hits a branch. Unless this wraps round 0x000000 this will never result
in a backwards address as far as I can see.
Do you have an example dump with OpenCSD outputting a range packet
with backwards addresses?

Mike

> >
> >>
> >> But in the mean time what about having a force option?
> >>
> >>> +       if (stop_addr < start_addr):
> >>> +               if (options.verbose == True or not options.force):
> >>> +                       print("Packet Dropped, Discontinuity detected
> >>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr,
> >>> dso))
> >>> +               if (not options.force):
> >>> +                       return
> >
> > If the stop address is less than the start address, it must be something
> > wrong. In this case, we can report a warning for discontinuity and directly
> > return (also need to save the `addr` into global variable for next parsing).
> >
> > I prefer to not add force option for this case - eventually, this will consume
> > much time for reporting this kind of failure and need to root causing it. A
> > better way is we just print out the reasoning in the log and continue to dump.
>
> But in this case we've identified all the known issues that would cause
> the script to fail and we can fix them in Perf and OpenCSD. There may
> not even be any more issues that will cause the script to fail in the
> future so there's no point in softening the error IMO. That will only
> hide future issues (of which there may be none) and make root causing
> harder when it hits some other tool.



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

