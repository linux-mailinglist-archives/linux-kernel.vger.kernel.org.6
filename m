Return-Path: <linux-kernel+bounces-304675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7E896237B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D25281B19
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159C165F1C;
	Wed, 28 Aug 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHVG+U2z"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69015CD42
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837624; cv=none; b=rpDbaI1iczhvqXuj+Fgy6Dd4JfClqHqKCXwsWFQFfd/bJWdNZNR2Xz+SEYcOHf3TMCpvGRDmITX3TgWI8OltPWXK4gPi2O6f2jnLIjz/lDZgpU9FsNNJdxr7Ze2GimAHq4lRXjETa0tZCM2Sykqh9xkApGJPNC024rMtOkAoJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837624; c=relaxed/simple;
	bh=bk6rCaLPqC8UxoxrvPrVO0Bk+0B/trM8dZd7v5biVYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqHKIuitWM0ns/zAxWby+XjqdF5Ch/+YuvkkYYDCBcQUIcEc9jTsRf0Ab0uIV7FDF30nvJNlAOQWqZJKCP/4Lt4rFMKIqUyAPBHGwmVSY1Hlh3v9p8SOGQQBLTB02yaDiODwg6AHzyj9UsSeOwweAvjBa9e3Sbyo9Egpz5qR/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kHVG+U2z; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5da6865312eso5139806eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724837620; x=1725442420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HMx1eURhWRZKjBnkQyZHTos0T11x8HE9aRPuiwVLS+c=;
        b=kHVG+U2zPOxpttxQicRKs5rQTzLbfukGyifywPACKvauXznpN1OZXX8V61Bc4c6cbm
         1ePpsuXP+SyZivP1cYj0eWePVXJNGGXOYVF1G2RaHkH56uGX+uK7S24U5UMc/OVSlPHZ
         mW3L8HLQIhbHBI8jB2rnQdkoYJvzLQ2hLUImN7Ligek6OYR3IVA3gJqWqYb1XN80J+7i
         Nlpq/1beVvAWiC0FH1wIpC6zUa2vcR9ggGLnfNSFNuYYX7fn+QLA96uEnGFVdGPH+sYT
         TwaUrwWZU3QnS0E/G4raiST2MN1nb+H14LnZvhahxQwBRXp0KTqxhHsaZAxm5xH5OyN7
         RVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837620; x=1725442420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMx1eURhWRZKjBnkQyZHTos0T11x8HE9aRPuiwVLS+c=;
        b=tA+MCWR2Cp4JajTXKAxyzxqNcoFeN1j7qNVml05dnL72C4iydrLfeYKEQ4sUwJiN/2
         zzLKldb3ZrPe3m1sJVLcLc88CR7kMTWGTcg6zOTT/sAH+6e+h7UFtyYQZeM4p3MWnBll
         KuX+umYvNuqOAXlBtz0Th1rYOjhC9Mj6F0sNiWDeTC5E22OfT5krJd4BPtaBbxYaZ1wb
         ZUWB0kULWecPiJ8gRvBZlKnJo5b+u4vFgJ/updHizpIc5aguLG7DMRDHYK+p7VHIlPQh
         Kxjw3HToxpTiNgDSyNTaSy4l3cpOoL1Vi0Xn3W5hEhdF6rARXZb4Hp9PMbbD2sTNH1Rk
         gO3g==
X-Forwarded-Encrypted: i=1; AJvYcCVDGxzLIPlIf+LYQdpH/UouiT8f0DcuQfAn6UVqfNsgcXYmjALXWHSjYyqM7auebxqXq0UhhIsYtde2Dy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSq3M5LVbWI0idG00pt/AQFcOLG/qSpkNnRuu0lFxck3YTBqBE
	ZTGPSczEOh0/YsBl6f2vuZhhNnnh8gG3I3UwwFgsL3SA/Ppr5WW3RWay6aEHMMNRqXYLgXLFLrN
	RMLzdI0FzUOFYflDndCmIHxXUQ8ougsfS/71djg==
X-Google-Smtp-Source: AGHT+IHuEg/81hgJChu+RJnhOb0NlweEhXyIUW1PD+kRwYvZMWF7br3mNWq9NEjhs/0P8aWG7PUB7QU17ckEsSXT4YI=
X-Received: by 2002:a05:6358:7208:b0:1b3:93b7:ee43 with SMTP id
 e5c5f4694b2df-1b5fac8c8cdmr160643255d.4.1724837620110; Wed, 28 Aug 2024
 02:33:40 -0700 (PDT)
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
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org> <4dd7f210-c03e-4203-b8e9-1c26a7f8fe79@arm.com>
 <c73573e7-206e-4a6c-b6c6-27903978d0aa@linaro.org> <CAJ9a7VhJFNxPCVva5tS51SBaxx76nFq9in0MGJe2jEwbVdSTkA@mail.gmail.com>
 <27912fc6-8419-4828-82a7-dacde5b4a759@linaro.org> <CAJ9a7Vg3W0NseXes3_irgkyeDKjhWqw5YMRghguHJZS73p9SJQ@mail.gmail.com>
 <36f947ef-c2a7-486a-b905-f0529308b06e@linaro.org>
In-Reply-To: <36f947ef-c2a7-486a-b905-f0529308b06e@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 28 Aug 2024 10:33:29 +0100
Message-ID: <CAJ9a7VjWKX-ugfM3VE6_ZfSooc7MHOFEWe=S_jAGHK+gyFUgfQ@mail.gmail.com>
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>
Cc: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Leo Yan <leo.yan@arm.com>, 
	scclevenger@os.amperecomputing.com, acme@redhat.com, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, darren@os.amperecomputing.com, 
	james.clark@arm.com, suzuki.poulose@arm.com, Al.Grant@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi James,

On Fri, 23 Aug 2024 at 10:03, James Clark <james.clark@linaro.org> wrote:
>
>
>
> On 19/08/2024 11:59 am, Mike Leach wrote:
> > Hi,
> >
> > A new branch of OpenCSD is available - ocsd-consistency-checks-1.5.4-rc1
> >
> > Testing I managed to do confirms the N atom on unconditional branches
> > appear to work. I do not have a test case for the range
> > discontinuities.
> >
> > The checks are enabled using operation flags on decoder creation. See
> > the docs for details.
> >
> > Mike
> >
>
> Hi Mike,
>
> I tested the new OpenCSD and I don't see the error anymore in the
> disassembly script. I'm not sure if we need to go any further and add
> the backwards check, it looks like just a later symptom and the checks
> that you've added already prevent it.
>

The OCSD_OPFLG_CHK_RANGE_CONTINUE is the backwards address check - at
least as so far as is possible in OpenCSD.
What it checks is if the next range after a not taken branch starts at
the end address of the previous range. However this check is cancelled
if there are other packets that intervene - e.g. trace on / exceptions
/ anything that might imply a discontinuity.

The other caveat is that I did not have an example to see if the code
could actually get triggered - though I will go back and manually
trigger it in the debugger just to test functional correctness.

If you are still seeing backwards addresses after these changes then I
am not sure where they are coming from. It may be there is a missing
discontinuity somewhere that is not being flagged.

The other alternative that does occur to me now - thinking about
incorrect images, is if we incorrectly associate an atom with a direct
branch rather than an indirect branch.
For a direct branch the decoder will calculate the target and carry on
- not looking for an address update as it is not needed. Then when the
address update does arrive, it is used as a latest address and the
range address will be updated.

Unfortunately this would be difficult to test for - the decoder is
written to assume good trace and correct images - adding in code to
try to remember previous state and judge if something is wrong,
without getting false positives is difficult. It adds code complexity
that is not necessary for well behaved clients!

> If you release a new version I can send the perf patch. I was going to
> use these flags if that looks right to you? As far as I know that's the
> set that can be always on and won't fail on bad hardware?
>

That set of flags is fine -

> I also assumed that ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK can be given even
> for etmv3 and it's just a nop?
>

It is safe - as there is no flag for ETMv3 in the same slot.
Effectively decode flags have a common set of bits and decoder
specific set of bits that overlap for each decoder.  We have not
really needed anything for ETMv3 to date, and I don't expect that to
change.


I'll get the new version released by the end of the week. I am off on
sabbatical for a month after that so any further investigation /
changes will have to wait

Regards

Mike


> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index e917985bbbe6..90967fd807e6 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>                  return 0;
>
>          if (d_params->operation == CS_ETM_OPERATION_DECODE) {
> +               int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
> +#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
> +               decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | OCSD_OPFLG_CHK_RANGE_CONTINUE |
> +                               ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK;
> +#endif
>                  if (ocsd_dt_create_decoder(decoder->dcd_tree,
>                                             decoder->decoder_name,
> -                                          OCSD_CREATE_FLG_FULL_DECODER,
> +                                          decode_flags,
>                                             trace_config, &csid))
>                          return -1;
>
> > On Fri, 9 Aug 2024 at 16:20, James Clark <james.clark@linaro.org> wrote:
> >>
> >>
> >>
> >> On 09/08/2024 3:13 pm, Mike Leach wrote:
> >>> Hi James
> >>>
> >>> On Thu, 8 Aug 2024 at 10:32, James Clark <james.clark@linaro.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 07/08/2024 5:48 pm, Leo Yan wrote:
> >>>>> Hi all,
> >>>>>
> >>>>> On 8/7/2024 3:53 PM, James Clark wrote:
> >>>>>
> >>>>> A minor suggestion: if the discussion is too long, please delete the
> >>>>> irrelevant message ;)
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> >>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> >>>>>>> @@ -257,6 +257,11 @@ def process_event(param_dict):
> >>>>>>>                     print("Stop address 0x%x is out of range [ 0x%x .. 0x%x
> >>>>>>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
> >>>>>>>                     return
> >>>>>>>
> >>>>>>> +       if (stop_addr < start_addr):
> >>>>>>> +               if (options.verbose == True):
> >>>>>>> +                       print("Packet Dropped, Discontinuity detected
> >>>>>>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr,
> >>>>>>> dso))
> >>>>>>> +               return
> >>>>>>> +
> >>>>>>
> >>>>>> I suppose my only concern with this is that it hides real errors and
> >>>>>> Perf shouldn't be outputting samples that go backwards. Considering that
> >>>>>> fixing this in OpenCSD and Perf has a much wider benefit I think that
> >>>>>> should be the ultimate goal. I'm putting this on my todo list for now
> >>>>>> (including Steve's merging idea).
> >>>>>
> >>>>> In the perf's util/cs-etm.c file, it handles DISCONTINUITY with:
> >>>>>
> >>>>>       case CS_ETM_DISCONTINUITY:
> >>>>>            /*
> >>>>>             * The trace is discontinuous, if the previous packet is
> >>>>>             * instruction packet, set flag PERF_IP_FLAG_TRACE_END
> >>>>>             * for previous packet.
> >>>>>             */
> >>>>>            if (prev_packet->sample_type == CS_ETM_RANGE)
> >>>>>                    prev_packet->flags |= PERF_IP_FLAG_BRANCH |
> >>>>>                                          PERF_IP_FLAG_TRACE_END;
> >>>>>
> >>>>> I am wandering if OpenCSD has passed the correct info so Perf decoder can
> >>>>> detect the discontinuity. If yes, then the flag 'PERF_IP_FLAG_TRACE_END' will
> >>>>> be set (it is a general flag in branch sample), then we can consider use it in
> >>>>> the python script to handle discontinuous data.
> >>>>
> >>>> No OpenCSD isn't passing the correct info here. Higher up in the thread
> >>>> I suggested an OpenCSD patch that makes it detect the error earlier and
> >>>> fixes the issue. It also needs to output a discontinuity when the
> >>>> address goes backwards. So two fixes and then the script works without
> >>>> modifications.
> >>>>
> >>>
> >>> Which address is going backwards here? - OpenCSD generates trace
> >>> ranges only by walking forwards from the last known address till it
> >>> hits a branch. Unless this wraps round 0x000000 this will never result
> >>> in a backwards address as far as I can see.
> >>> Do you have an example dump with OpenCSD outputting a range packet
> >>> with backwards addresses?
> >>>
> >>> Mike
> >>>
> >> The example I have I think is something like this:
> >>
> >> 1.  Start address / trace on
> >> 2.  E
> >> 3.  Output range
> >>       ...
> >> 4.  Periodic address update
> >>       ...
> >> 5.  E
> >> 6.  Output range
> >>
> >> If decode has gone wrong (but undetectably) between steps 1 and 3. Then
> >> the next steps still output a second range based on the last periodic
> >> address received. (I think it might not necessarily have to be a
> >> periodic address but could also be indirect address packet?). Perf
> >> converts the ranges into branch samples by taking the end of the first
> >> range and beginning of the second range. Then the disassembly script
> >> converts those samples into ranges again by taking the source and
> >> destination of the last two branch samples.
> >>
> >> The original issue that Ganapat saw was that the periodic address causes
> >> OpenCSD to put the source address of the second range somewhere before
> >> the first one, even though it didn't output a branch or discontinuity
> >> that would explain how it got there.
> >>
> >> But yes you're right the ranges themselves always go forwards from the
> >> point of view of their own start and end addresses.
> >>
> >> I thought it might be possible for OpenCSD to check against the last
> >> range output? Although I wasn't sure if maybe it's actually valid to do
> >> a backwards jump like that without the trace on/off packets with address
> >> filtering or something?
> >>
> >> The root cause is still the incorrect image, but I think this check
> >> along with the other direct branch check should make it pretty difficult
> >> for people to make the mistake.
> >
> >
> >



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

