Return-Path: <linux-kernel+bounces-279686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53E794C07B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 010DDB22B98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE7518EFD7;
	Thu,  8 Aug 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhHGFJ0V"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F3418C91F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129318; cv=none; b=B3bl7Ps7Q3HUKkV486eq2PAHhlO+ElrGhj1tjfbO8Sm8hmytYlyQkGckCfMteiybdj0Z0P/LeUgEm7d/H9SVkz4UG5eYEx2ch6tOir7FNuSDrjBUY7i6fHONYqZv2p4sWTF58hBdubGFaVJZE1wJ6TKchpwgMMeTF8OjHCl4mwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129318; c=relaxed/simple;
	bh=IGqyB60C15tCk8324fdrN8Jvjj2DF65eMV/HkMoY0b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WokWIxUyny6NKTBMhxF2Iao579AVcbFPvjUZLAooEDiVCUZlyl21hbVBTpSdNiRZ8d+wDqiZcSqchuX1iWNBTe9v1Oj73gxFxjupj1Cqk4NaR5/66FiFizIT97RX742tjgAOE0sewrYlWeR6JbxUnLPVCCZIP2IH0GbmTgPV4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhHGFJ0V; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d2b921c48so881731b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723129316; x=1723734116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4j7WbEnJXtkxCdjwQUxYxy3v9OuIAKcYqpXlgnQ3Mk=;
        b=NhHGFJ0VyAbESlKa/55r0gqR7yKcwFECc/2mwmt+tHAUv1/Q92g2ob7AbgEqERW8K+
         hOtMchGbJRjnpChoj5teI8Udw60v3IFLY8gEArvaWqpYDRwVgi3FcoWXo6iX3Vzbr8mf
         hKyA5lgWhuDaR1WtMfaLLzj6iEvtq1vWDI+ghIkMvoLyrQeTZOq/KKCoBrdZuyGVzWa7
         iJesbwaly1wewJAiHyY4ghR0gPvgQhV75VYNZuIZrr2UR6SVhaiy/UnwcwnUmTMPg22V
         gxjwcNxqa9fAjjSF6aq3jx82zXxhb+Sh4LTcOrHrNFPqcq6TUtpBzwPbXeErnlxXJMzg
         zQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129316; x=1723734116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4j7WbEnJXtkxCdjwQUxYxy3v9OuIAKcYqpXlgnQ3Mk=;
        b=YNjp3qcnOZIqrMXS+qFLjELSnUdb4iktesY2u4z1MAOQl5f8aTuedL9IisDc17ifPg
         duMEnG7c6ISkj9izs7qpJlEZT4VzHZEXeupZV5tcfcA3egHiR8aUNfwg7/9HjjOlLmLg
         LxAiP8m3AJ66xakWsLiXrF0RpmA0gJ+Vy24A//i2G9bDlUS3+2iCCwBsC5+Pa+N6i8tQ
         mzHqbZMnSmiNsW5aY0LXGq+cCaF9alkzGZ1uZwo+KiQEfPmooXu3vswj4HhIvBBCQY40
         zd4i9t/NGOQdJBlH4Hhk/+TAst4Pic0nYKMzusjJHVDfSY/mW0SGAee+K4WM4vjLUN4Q
         AoSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvN1VZUisRf+O3Wn5xAaG6RlBN7yKWEC1SGhMTv1fxXThkcwjTToaXEndqpRLM0YO49x1nwE0aMf4kt/CC3FsAVQ4+0UdYshqe4B66
X-Gm-Message-State: AOJu0Yz0VU0QiPRbIE+R58rI7rdWWawyiH47sf9scY/qLAq1xY2PfUpK
	8lx5V0xhfkZhCMnwG+NAdObjgUEbsOzY7DXOrlhhJk6VOaWIwhLLxUn6rElDpc0jaOYZ5AtZnsE
	hqv5oR0bsk+0k/wU/dueR9PhSPemTfuP1k5RbnA==
X-Google-Smtp-Source: AGHT+IHr4bEVIEDUkrvrZVv4ShqUAVHohWrj2ykqtWfc46pt+bMEFoVPVlpyhTFlyOzFEsJU7XnWmwwmhalGu+1dwvs=
X-Received: by 2002:a05:6a20:6a1a:b0:1c6:9f28:37b7 with SMTP id
 adf61e73a8af0-1c6fcee2554mr2585578637.27.1723129316064; Thu, 08 Aug 2024
 08:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org> <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org> <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org> <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org> <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org> <4ba157c2-4a56-4d77-9a15-071e46adc33b@os.amperecomputing.com>
 <d3c86965-090b-41c5-85a9-187704754072@arm.com> <915fefb2-b0bc-4306-83ec-22570719e8e4@os.amperecomputing.com>
 <d34d402c-7765-41be-8a7c-b9d564c5bedb@arm.com> <2c0cd5b7-1ca6-4088-817c-209026266d58@linaro.org>
 <16ea091e-0f3b-44cf-b3b4-b07efabe9c02@linaro.org> <3ef38bf2-39df-47c6-aa6a-7e65d3909564@os.amperecomputing.com>
In-Reply-To: <3ef38bf2-39df-47c6-aa6a-7e65d3909564@os.amperecomputing.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 8 Aug 2024 16:01:44 +0100
Message-ID: <CAJ9a7VjspK8XuJfJyr_fNg6+pfnhxoLbQceDPWi9ACiCncbsEQ@mail.gmail.com>
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	scclevenger@os.amperecomputing.com, acme@redhat.com, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, darren@os.amperecomputing.com, 
	james.clark@arm.com, suzuki.poulose@arm.com, Al.Grant@arm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 12:15, Ganapatrao Kulkarni
<gankulkarni@os.amperecomputing.com> wrote:
>
>
>
> On 08-08-2024 04:21 pm, James Clark wrote:
> >
> >
> > On 08/08/2024 10:21 am, James Clark wrote:
> >>
> >>
> >> On 08/08/2024 8:42 am, Leo Yan wrote:
> >>> On 8/8/2024 5:36 AM, Ganapatrao Kulkarni wrote:
> >>>>
> >>>> On 08-08-2024 12:50 am, Leo Yan wrote:
> >>>>> On 8/7/2024 5:18 PM, Ganapatrao Kulkarni wrote:
> >>>>>
> >>>>>> Is below diff with force option looks good?
> >>>>>>
> >>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> >>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> >>>>>> index d973c2baed1c..efe34f308beb 100755
> >>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> >>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> >>>>>> @@ -36,7 +36,10 @@ option_list = [
> >>>>>>                       help="Set path to objdump executable file"),
> >>>>>>           make_option("-v", "--verbose", dest="verbose",
> >>>>>>                       action="store_true", default=False,
> >>>>>> -                   help="Enable debugging log")
> >>>>>> +                   help="Enable debugging log"),
> >>>>>> +       make_option("-f", "--force", dest="force",
> >>>>>> +                   action="store_true", default=False,
> >>>>>> +                   help="Force decoder to continue")
> >>>>>>    ]
> >>>>>>
> >>>>>>    parser = OptionParser(option_list=option_list)
> >>>>>> @@ -257,6 +260,12 @@ def process_event(param_dict):
> >>>>>>                   print("Stop address 0x%x is out of range [ 0x%x
> >>>>>> .. 0x%x
> >>>>>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
> >>>>>>                   return
> >>>>>>
> >>>>>> +       if (stop_addr < start_addr):
> >>>>>> +               if (options.verbose == True or options.force):
> >>>>>> +                       print("Packet Discontinuity detected
> >>>>>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr,
> >>>>>> start_addr, dso))
> >>
> >> The options.force for the print should be "options.verbose or not
> >> options.force" I think? You want to print the error until the user
> >> adds -f, then hide it. Unless verbose is on.
> >>
> >>>>>> +               if (options.force):
> >>>>>> +                       return
> >>
> >> Oops I had this one the wrong way around in my example. This way is
> >> correct.
> >>
> >>>>>
> >>>>> I struggled a bit for the code - it is confused that force mode
> >>>>> bails out
> >>>>> and the non-force mode continues to run. I prefer to always bail
> >>>>> out for
> >>>>> the discontinuity case, as it is pointless to continue in this case.
> >>>>
> >>>> Kept bail out with force option since I though it is not good to hide
> >>>> the error in normal use, otherwise we never able to notice this
> >>>> error in
> >>>> the future and it becomes default hidden. Eventually this error should
> >>>> be fixed.
> >>>
> >>> As James said, the issue should be fixed in OpenCSD or Perf decoding
> >>> flow.
> >>>
> >>> Thus, perf tool should be tolerant errors - report warning and drop
> >>> discontinuous samples. This would be easier for developers later if face
> >>> the same issue, they don't need to spend time to locate issue and
> >>> struggle
> >>> for overriding the error.
> >>>
> >>> If you prefer to use force option, it might be better to give
> >>> reasoning and
> >>> *suggestion* in one go, something like:
> >>>
> >>>      if (stop_addr < start_addr):
> >>>         print("Packet Discontinuity detected [stop_add:0x%x
> >>> start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
> >>>         print("Use option '-f' following the script for force mode"
> >>>         if (options.force)
> >>>             return
> >>>
> >>> Either way is fine for me. Thanks a lot for taking time on the issue.
> >>>
> >>> Leo
> >>
> >> But your diff looks good Ganapat, I think send a patch with Leo's
> >> extra help message added and the first force flipped.
> >
> > One other small detail about Leo's suggestion print out. Can you add an
> > instruction of how to keep the warnings as well:
> >
> >    print("Use option '-f' following the script for force mode. Add '-v' \
> >      to continue printing decode warnings.")
> >
>
> Thanks James and Leo for your comments.
> I will send the V2 with the changes as discussed.
>
> Thanks.
> Ganapat
>


Certainly any ARM trace decode is dependent on accurate program images
being input to provide correct trace decode at the output.

So if an OpenCSD client does not provide accurate information then it
should not really expect to get accurate trace as an output!

That said there are certainly a couple of changes that can be made:-

1) Clearly outputting a trace range with a finish address lower than
the start address is incorrect. This can unconditionally output a hard
error.

2) Detection of non-cond not taken should be added as a configurable
option.   - either all, or direct only. This can be achieved by adding
flags to the library configuration API.
For a client like perf - these could be controlled by the verbose
level - which I believe is an int in the range 0-10 or something?


However - when we do detect these errors, it is essential that the
entire decoder is reset and tracing not restarted till the next sync
point in the trace data.
i.e. assuming that the next range that happens to be consecutive after
a break, given a prior input of incorrect address data is simply
invalid. There is no way of knowing if the branch taken / not taken
sequence matches the addresses in the program image any more.

The solution that James proposes above, needs to actually generate an
error which will then automatically reset the decoder to an unsynced
state.

Regards

Mike


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

