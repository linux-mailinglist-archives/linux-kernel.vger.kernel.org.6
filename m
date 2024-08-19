Return-Path: <linux-kernel+bounces-291915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1522A9568D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C200A283306
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471271607B0;
	Mon, 19 Aug 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJazZEQX"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F362209F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065213; cv=none; b=E/I+0v+stjdQykrVYZxgPGdl0ufzl8uuK5/Rw4wgGVoKyW39gjtyBEYv8Ddgsphp0o87FR+GRR2m9YxfcHfAKyCE8wTB7i6PfuaFP9CeaBKzrHwx7Z5x3ga3wKtAHC7ydRr766VHiDLKJdy0Xw7h85oEoLpMdx0TsL4avP3tn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065213; c=relaxed/simple;
	bh=HYaO3J52rv3xeKapZAeQwljdE49vL1NCB7EBdrFN45k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSXVFnbSLu4daM+ZMYsMS+PjQN5gEB9ZWKjfewxxs+AhU9pjxAZzqUI+ZMNZzxFxPoIq9Iearw6owYSfhuyYMKVXU4SvzvBT/77J0jnbsgR0Zh0GjbJuSLh3PxxLhEhMWr+8+MYgKOLHo/oal1X0uGWRq9VOaiUMUDBRP1Z5aRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FJazZEQX; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-27032e6dbf2so1069976fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724065211; x=1724670011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwUU6FCxyi4adWoMLxBbcUKpuY6U0CqKDUhDDluQfIY=;
        b=FJazZEQXeVEvrKhljNg4C7rP/zGkxwomm5cDBpywazZUsCe51LapoTZtt0hA5XtwON
         aAGkIBVoPGH0rALMWeOU9NhWPF4A/4XVMCXT2u+IEnF2N+ry0/wiASX4AdpZe3FQ7c2K
         PWFPrOos7RqTRJzzUvEeAkcGf8OqVP7/iBvmz+wKg1UmEqie2T06L+gGBr3h3X2jJSji
         F2eqWyZfmdTWXschvL/izBgcTIVTqFXkbsZlnDSOYFMOV7PmuS7YLQKtF/PUN5Lo3DBd
         DlHFuJST1TeVeVb9Nt1hN5sbjixFDlEqL8KGQrsykvG42eZdXkrip4Rm6w5RC/RZKcat
         dXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724065211; x=1724670011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwUU6FCxyi4adWoMLxBbcUKpuY6U0CqKDUhDDluQfIY=;
        b=aDkwufZUaaWZA2vDYylX65Z9geAz3nB6FrOfnsg1Ycl627QGyHCv4LafkPY5sXtV+j
         kIvw4hGWmLLYfJUYbAAK1zcijvF99/GD0AaxCRvNVl6S7MiilBwgcMK4PSJVUZOAjvLm
         B9nL49ATLmCVxc4QPmvGHO2bvSAr7bReCXlOF9B6wTiR80XFdmUkhDW9Va1VuXIuZ3Oe
         hrdYE0oLQwizsdZNa6KqhQEtfcVVswdjzGgQG1KcdYCpa+8AMTgEzhPrFUsfxrWmpIA+
         fr4FzbVYyWPJeYhB1oKwXnHdzw6LRCCOtjzJUW6rwaSQ29ymWrHI2llLcidWNId3XFK3
         pzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0h7V+lzh5ZQMlK7RSJZLIRNhxtRCtrrqxC+zzdKhndWqxF1fXV9rKtb5RxBIEkNn/G+eNni3lLxCvhC05MmLZhHdpGo2KM3kUnNhq
X-Gm-Message-State: AOJu0Yy9bwDEsEm567YFNYpkEkE0F0NLkEQ10aXuYhPaPFsWiVji6f1G
	kLTtQEOvHmboAuMot49Gj2ay9QJz8YdAQ+w1Dz2/cJoTq35Jyj5RA+WIimI8oo6bkvAUP3+7MtW
	Q8QBk0sJHkoPYWOLd/BcUAcA+XudIUSTWVmIUgA==
X-Google-Smtp-Source: AGHT+IF1NsUqh9of02Duq6hMyPc/Wal264TNklcZTJs73RIXyNkJbiYtx1Nxd5wIwUbxbO/l4vSg72JW5eyy1muERSw=
X-Received: by 2002:a05:6870:8a06:b0:270:1dab:64a9 with SMTP id
 586e51a60fabf-2701dab712bmr10656491fac.14.1724065210667; Mon, 19 Aug 2024
 04:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org> <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org> <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org> <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org> <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org> <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org> <4dd7f210-c03e-4203-b8e9-1c26a7f8fe79@arm.com>
 <c73573e7-206e-4a6c-b6c6-27903978d0aa@linaro.org> <CAJ9a7VhJFNxPCVva5tS51SBaxx76nFq9in0MGJe2jEwbVdSTkA@mail.gmail.com>
 <27912fc6-8419-4828-82a7-dacde5b4a759@linaro.org>
In-Reply-To: <27912fc6-8419-4828-82a7-dacde5b4a759@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Mon, 19 Aug 2024 11:59:58 +0100
Message-ID: <CAJ9a7Vg3W0NseXes3_irgkyeDKjhWqw5YMRghguHJZS73p9SJQ@mail.gmail.com>
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

Hi,

A new branch of OpenCSD is available - ocsd-consistency-checks-1.5.4-rc1

Testing I managed to do confirms the N atom on unconditional branches
appear to work. I do not have a test case for the range
discontinuities.

The checks are enabled using operation flags on decoder creation. See
the docs for details.

Mike

On Fri, 9 Aug 2024 at 16:20, James Clark <james.clark@linaro.org> wrote:
>
>
>
> On 09/08/2024 3:13 pm, Mike Leach wrote:
> > Hi James
> >
> > On Thu, 8 Aug 2024 at 10:32, James Clark <james.clark@linaro.org> wrote:
> >>
> >>
> >>
> >> On 07/08/2024 5:48 pm, Leo Yan wrote:
> >>> Hi all,
> >>>
> >>> On 8/7/2024 3:53 PM, James Clark wrote:
> >>>
> >>> A minor suggestion: if the discussion is too long, please delete the
> >>> irrelevant message ;)
> >>>
> >>> [...]
> >>>
> >>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> >>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> >>>>> @@ -257,6 +257,11 @@ def process_event(param_dict):
> >>>>>                    print("Stop address 0x%x is out of range [ 0x%x .. 0x%x
> >>>>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
> >>>>>                    return
> >>>>>
> >>>>> +       if (stop_addr < start_addr):
> >>>>> +               if (options.verbose == True):
> >>>>> +                       print("Packet Dropped, Discontinuity detected
> >>>>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr,
> >>>>> dso))
> >>>>> +               return
> >>>>> +
> >>>>
> >>>> I suppose my only concern with this is that it hides real errors and
> >>>> Perf shouldn't be outputting samples that go backwards. Considering that
> >>>> fixing this in OpenCSD and Perf has a much wider benefit I think that
> >>>> should be the ultimate goal. I'm putting this on my todo list for now
> >>>> (including Steve's merging idea).
> >>>
> >>> In the perf's util/cs-etm.c file, it handles DISCONTINUITY with:
> >>>
> >>>      case CS_ETM_DISCONTINUITY:
> >>>           /*
> >>>            * The trace is discontinuous, if the previous packet is
> >>>            * instruction packet, set flag PERF_IP_FLAG_TRACE_END
> >>>            * for previous packet.
> >>>            */
> >>>           if (prev_packet->sample_type == CS_ETM_RANGE)
> >>>                   prev_packet->flags |= PERF_IP_FLAG_BRANCH |
> >>>                                         PERF_IP_FLAG_TRACE_END;
> >>>
> >>> I am wandering if OpenCSD has passed the correct info so Perf decoder can
> >>> detect the discontinuity. If yes, then the flag 'PERF_IP_FLAG_TRACE_END' will
> >>> be set (it is a general flag in branch sample), then we can consider use it in
> >>> the python script to handle discontinuous data.
> >>
> >> No OpenCSD isn't passing the correct info here. Higher up in the thread
> >> I suggested an OpenCSD patch that makes it detect the error earlier and
> >> fixes the issue. It also needs to output a discontinuity when the
> >> address goes backwards. So two fixes and then the script works without
> >> modifications.
> >>
> >
> > Which address is going backwards here? - OpenCSD generates trace
> > ranges only by walking forwards from the last known address till it
> > hits a branch. Unless this wraps round 0x000000 this will never result
> > in a backwards address as far as I can see.
> > Do you have an example dump with OpenCSD outputting a range packet
> > with backwards addresses?
> >
> > Mike
> >
> The example I have I think is something like this:
>
> 1.  Start address / trace on
> 2.  E
> 3.  Output range
>      ...
> 4.  Periodic address update
>      ...
> 5.  E
> 6.  Output range
>
> If decode has gone wrong (but undetectably) between steps 1 and 3. Then
> the next steps still output a second range based on the last periodic
> address received. (I think it might not necessarily have to be a
> periodic address but could also be indirect address packet?). Perf
> converts the ranges into branch samples by taking the end of the first
> range and beginning of the second range. Then the disassembly script
> converts those samples into ranges again by taking the source and
> destination of the last two branch samples.
>
> The original issue that Ganapat saw was that the periodic address causes
> OpenCSD to put the source address of the second range somewhere before
> the first one, even though it didn't output a branch or discontinuity
> that would explain how it got there.
>
> But yes you're right the ranges themselves always go forwards from the
> point of view of their own start and end addresses.
>
> I thought it might be possible for OpenCSD to check against the last
> range output? Although I wasn't sure if maybe it's actually valid to do
> a backwards jump like that without the trace on/off packets with address
> filtering or something?
>
> The root cause is still the incorrect image, but I think this check
> along with the other direct branch check should make it pretty difficult
> for people to make the mistake.



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

