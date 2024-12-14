Return-Path: <linux-kernel+bounces-446209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 865659F2124
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D61188745B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0611B21B7;
	Sat, 14 Dec 2024 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5yCS9sx"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9781B0F29
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734213966; cv=none; b=IyN50Bf8Vh68VVuyKo8fWjOGJAU6ZrJ4KupbH2xCsRFqpbUEo5zOAJm2hCXQjLyZLvLaRrOOpuAk028H7VOfkxRRPU0yInfeU5dzYRhR91MzIUmJY3JrWYUu/Xa31rlKo/bTKRmI2RINPNEll56+ER0+M55GxChSNtzEnITqAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734213966; c=relaxed/simple;
	bh=rW7LJGhUR67ZrhZhYTw8fIWFpSlMqooGT4dLSlk6zA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9HmRnWhOS75OKaj4MJiELO1y67c95RbZMNxTvT7QLIDVeQJdC2Nww4gjr3wKuKh/4zk+facRlJOvCw2BPZzrqTARhJIgQEIbC2T8GzMAaOBkJm1QfutNvIGFKkaQ41g3X3DXPI5l1okWMfjkHp/eEy5tODCFu7l6bhguQYai1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p5yCS9sx; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3dace03a73so1847330276.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734213960; x=1734818760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ukiQXGlnMpDWEcktfUMa64T2wStPZV8Z0XjoJ8Wk5BY=;
        b=p5yCS9sxgs4ajXWmnfx6m/spW6JVzGBCW6Y6GR2QSmPviMQNO+m8D1Upk2BGNjBLbc
         nLsNRf+WG0oLgYIzYK40zqbqlMba1/LAFQIzkADAn67uEk7V8u20jU3U/pjPNYIHhhPq
         Pr6o1NdqXKzUIUYBwwUf/o4Hl3Q29hk8Wn7s+FnF+tj2BHFjsTYPlHOaugQhfWKaN16I
         CbxoGPlVM1Enxb3/2XTmpGisKETFMeZ8GTlLWun6NOaMV62k+29pObpPdLXCSmk0j9OH
         ygAGJn+5GOMQiIdNSFKW6ocVQyJLP9PSGFEJcfV7jgdPZ09idq4B8JljQOJm4ah+dNfB
         rcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734213960; x=1734818760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukiQXGlnMpDWEcktfUMa64T2wStPZV8Z0XjoJ8Wk5BY=;
        b=lDnPaLtsZT4duat9/6M+ToMkc7w18H7lsJ+PSsy/zjXpO/XDuhhL433/qJQG8XxUxs
         z/jdU37vXpqRtbmBemhRnAnBJMnhF5A0V1qLVAIaulnmryiX6+Rle0r0AcyImWvVvtjM
         obrl7XZ5oUTvjqf8n2PAi7oef0M7Z0IXFCjDcKKhrkyGmNAHlm4Jwj2RypbMtSJCIi1u
         pfzMgyJrgG2pFYwKddAoaAy5Zlpd3WpkDFD15yjkuAq6njCZu8KkBPHWWynjw2tislqD
         gEIWogNxAm18m0QzTWLUh2GNxdO7wciYHhA5qyM8YqG8AYgLpda3vt48pMRCgu0tYe4J
         QHkg==
X-Forwarded-Encrypted: i=1; AJvYcCVWTtL8h+eqxjxY2xj/Vck11fwsRuc/62BLWaiKRVMJKNWph7JQgVZPYbHRbUZBb9QdgAWBeheDXE2S2X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzScEMNnsuPmY3HB+1RLeeOGLK8bShGJEZTQeRh+aOrje6qOIMx
	OlXYMdbIpHPskffkWk0ymgKsvA4ptNgx6XXalOGU4jbLSOozavnYbIHluLB4R1r/195cItR6JV0
	/VKRvXSM1JGwEH1WRl/xvDankWQSizv2YfD4nSg==
X-Gm-Gg: ASbGnctYsfEz1XFNnHxv4kI9vympPZW+IUGJmAQSeOuvTGqJYQEd2x6wOBAzZBEqFvW
	AtPd3pwGyw+mYSdycYQm+eheFXt2WbPcxMBBCUghj0ENadk9ku1rb
X-Google-Smtp-Source: AGHT+IH3A5dlodfa4TvCiSNvyPHxu8dNk6lV70C56el/VBAmCGYPT5WmQqKaGrde3U2sAJsoq2/wvmI6b0HHCMThjxQ=
X-Received: by 2002:a05:6902:2186:b0:e39:7b55:ff7d with SMTP id
 3f1490d57ef6-e4351746c88mr6798303276.49.1734213960061; Sat, 14 Dec 2024
 14:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
 <20241212-fd-dp-audio-fixup-v3-4-0b1c65e7dba3@linaro.org> <c5090fcc-d7ec-4d49-aa21-8d1aa7f6a1c7@quicinc.com>
 <CAA8EJppOjAjFVUFSEXJMbJ4aV_MvzpeTuKDkL7P+t_Mw47YECw@mail.gmail.com>
 <5cb7b1b1-5596-4704-bd01-beaadf8bba51@quicinc.com> <CAA8EJppyNceC+t-2MKqq1QhCj2cYb+jprc++cFEen8Cqhhbo0w@mail.gmail.com>
 <459e59b1-1212-4a93-89cd-f5a2e062543e@quicinc.com>
In-Reply-To: <459e59b1-1212-4a93-89cd-f5a2e062543e@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 15 Dec 2024 00:05:49 +0200
Message-ID: <CAA8EJpqaigaJmHJB73doAxwWMWXDHS4Drs0R0w=YEtZ3iZkWcw@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] drm/msm/dp: pull I/O data out of msm_dp_catalog_private()
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Douglas Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 22:53, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Hi Dmitry
>
> On 12/12/2024 3:09 PM, Dmitry Baryshkov wrote:
> > On Thu, 12 Dec 2024 at 21:15, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 12/12/2024 12:52 AM, Dmitry Baryshkov wrote:
> >>> On Thu, 12 Dec 2024 at 04:59, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 12/11/2024 3:41 PM, Dmitry Baryshkov wrote:
> >>>>> Having I/O regions inside a msm_dp_catalog_private() results in extra
> >>>>> layers of one-line wrappers for accessing the data. Move I/O region base
> >>>>> and size to the globally visible struct msm_dp_catalog.
> >>>>>
> >>>>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> >>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>> ---
> >>>>>     drivers/gpu/drm/msm/dp/dp_catalog.c | 457 +++++++++++++++---------------------
> >>>>>     drivers/gpu/drm/msm/dp/dp_catalog.h |  12 +
> >>>>>     2 files changed, 197 insertions(+), 272 deletions(-)
> >>>>>
> >>>>
> >>>>
> >>>> Fundamentally, the whole point of catalog was that it needs to be the
> >>>> only place where we want to access the registers. Thats how this really
> >>>> started.
> >>>>
> >>>> This pre-dates my time with the DP driver but as I understand thats what
> >>>> it was for.
> >>>>
> >>>> Basically separating out the logical abstraction vs actual register writes .
> >>>>
> >>>> If there are hardware sequence differences within the controller reset
> >>>> OR any other register offsets which moved around, catalog should have
> >>>> been able to absorb it without that spilling over to all the layers.
> >>>>
> >>>> So for example, if we call dp_ctrl_reset() --> ctrl->catalog->reset_ctrl()
> >>>>
> >>>> Then the reset_ctrl op of the catalog should manage any controller
> >>>> version differences within the reset sequence.
> >>>
> >>> The problem is that the register-level writes are usually not the best
> >>> abstraction. So, instead of designing the code around dp_catalog I'd
> >>> prefer to see actual hw / programming changes first.
> >>>
> >>
> >> So thats the issue here. If we did end up with registers and sequences
> >> different for controller versions, the ctrl layer was expected to just
> >> call a reset() op for example similar to the DPU example you gave. And
> >> as you rightly noted, the dpu_hw_xxx files only expose the ops based on
> >> version and the upper layers were supposed to just call into the ops
> >> without knowing the register level details. Thats pretty much what
> >> dp_ctrl tried to do here. We did not want to expose all the register
> >> defines in those layers. This series is doing exactly opposite of that.
> >
> > We don't have the issue up to now, even though we support DP
> > controllers since SDM845 up to SM8650 and X1E80100. The SDE driver has
> > v200 vs v420 catalog files for PHY programming, the rest of the
> > functions are common. So, for me it looks like a preparation for the
> > imaginary case that didn't come to existence up to now.
> > So, yes. I want to get rid of extra useless indirection and I want to
> > expose register sequences in those layers.
> >
>
> Yes because PHY programming is managed in the PHY driver today and does
> not go through catalog whereas in SDE driver it does, I do not have any
> other concrete example to give you which exists in the current code
> where sequence changes across chipset variants for DP controller and
> since I certainly cannot discuss how things can evolve moving forward,
> as usual, I have to accept it as one of those things which is not used
> today. So yes, I guess the register sequencing point changing across
> chipset variants, does not have a good example which I can really share.
>
> But exposing register sequences within the same file, I am not too sure
> about that. For example, you can take a look at
> dp_catalog_panel_config_hdr in the SDE code OR even
> msm_dp_catalog_panel_enable_vsc_sdp in the current upstream code. Why
> should this entire sequence be exposed to the dp_panel layer?

Why not? The dp_catalog_panel_config_hdr() is a bit tough, we don't
implement similar functions currently. For
msm_dp_catalog_panel_enable_vsc_sdp() this is also a logical sequence:
configure GENERIC0, write the package to GENERIC0, indicate presence
of the VSC SDP. I really don't see why this should go to a separate
file.

> For smaller functions which are one-liners the redirection seems
> redundant but when the sequence is bigger like in the examples I gave,
> the logical Vs register sequence separation grows. Thats where the
> dp_catalog came from.
>
>
> >>
> >>>>
> >>>> We do not use or have catalog ops today so it looks redundant as we just
> >>>> call the dp_catalog APIs directly but that was really the intention.
> >>>>
> >>>> Another reason which was behind this split but not applicable to current
> >>>> upstream driver is that the AUX is part of the PHY driver in upstream
> >>>> but in downstream, that remains a part of catalog and as we know the AUX
> >>>> component keeps changing with chipsets especially the settings. That was
> >>>> the reason of keeping catalog separate and the only place which should
> >>>> deal with registers and not the entire DP driver.
> >>>>
> >>>> The second point seems not applicable to this driver but first point
> >>>> still is. I do admit there is re-direction like ctrl->catalog
> >>>> instead of just writing it within dp_ctrl itself but the redirection was
> >>>> only because ctrl layers were not really meant to deal with the register
> >>>> programming. So for example, now with patch 7 of this series every
> >>>> register being written to i exposed in dp_ctrl.c and likewise for other
> >>>> files. That seems unnecessary. Because if we do end up with some
> >>>> variants which need separate registers written, then we will now have to
> >>>> end up touching every file as opposed to only touching dp_catalog.
> >>>
> >>> Yes. I think that it's a bonus, not a problem. We end up touching the
> >>> files that are actually changed, so we see what is happening. Quite
> >>> frequently register changes are paired with the functionality changes.
> >>>
> >>
> >> Not exactly. Why should dp_ctrl really know that some register offset or
> >> some block shift happened for example. It only needs to know when to
> >> reset the hardware and not how. Thats the separation getting broken with
> >> this.
> >
> > Yes. And I'm removing that separation very intentionally. If one is
> > looking for AUX programming, they should be looking into dp_aux only,
> > not dp_aux & dp_catalog. Likewise all audio code should be in
> > dp_audio. By using dp_catalog we ended up with a very very very bad
> > abstraction of msm_dp_catalog_audio_get_header() /
> > msm_dp_catalog_audio_set_header() / enum
> > msm_dp_catalog_audio_sdp_type. Just because reads & writes should go
> > through the catalog.
>
> No, I think this is where there is some correction needed. the
> get_header() / set_header() was done not because all writes need to go
> through catalog but because the audio headers were thought to be written
> only one header at a time and we had thought that read-modify-write had
> to be done to preserve the bytes. And when we have to do only one header
> at a time and because two headers map to one register, catalog had to
> end up managing an audio_map. Now, after checking where it came from as
> I commented on that patch, this requirement was not a functional one but
> was just trying to preserve the pre-silicon validation scripts sequence,
> this part of it can be dropped. So no need of get_header() /
> set_header() and an audio_map. Now all registers going through catalog
> is another thing which we are still discussing here.

You've skipped the msm_dp_catalog_audio_sdp_type enum (which was
explicitly mentioned). It is an abstraction which in my opinion also
isn't required, but it clearly comes from dp_catalog.

>
> > For dp_panel likewise there is no need to look into some other source
> > file to follow the register sequences. It can all be contained within
> > dp_panel.c, helping one to understand the code.
> >
>
> > Last, but not least. Code complexity. dp_catalog.c consists of 1340
> > lines, covering different submodules. It is hard to follow it in this
> > way.
> >
>
> Its just a question of spreading up the functions all over, not reducing
> code complexity. So yes, it reduces the file size of dp_catalog whereas
> increases that of others. Code complexity impact due to that is subjective.

The main issue is that dp_catalog now contains unrelated sets of
functions. That's code complexity.

>
> >>
> >>> For example (a very simple and dumb one), when designing code around
> >>> dp_catalog you ended up adding separate _p1 handlers.
> >>> Doing that from the data source point of view demands adding a stream_id param.
> >>>
> >>
> >> I have not checked your comment on that series here but if your concern
> >
> > This is really a bad cadence. I have provided most of the feedback
> > almost a week ago.
> >
>
> Yes, was a very tight week trying to enable upstream developers to land
> their platforms such as QCS615 by fixing platform specific dpu things
> and had the fixes cycle this week too so as a result my own feature took
> a bit of a hit this week :(
>
> >> is stream_id should not be stored in the catalog but just passed, thats
> >> fine, we can change it. stream_id as a param is needed anyway because
> >> the register programming layer needs to know which offset to use. This
> >> series is not mitigating that fact.
> >
> > No, my concern was that you have been adding separate _p1() functions
> > which are a duplicate of _p0() counterparts. When one looks at the
> > dp_catalog.c it is logical: there are two different register areas, so
> > there are two distinct sets of functions. If one starts looking from
> > the dp_panel point of view, it's obvious that there should be a single
> > msm_dp_write_stream() function which accepts stream_id and then
> > multiplexes it to go to p0 or p1.
> >
>
> Your multiplexing suggestion of adding a msm_dp_read_pn/msm_dp_write_pn
> by passing a stream_id can be done even with current dp_catalog intact
> as it will help reduce storing the stream_id in the dp_catalog. So its a
> valid suggestion and can be implemented even in the current code and not
> tied to the fact that register writing is done in dp_catalog or dp_panel.

It can. The point was about the implementation logic, not about the possibility.

>
> >>
> >>> In the DPU driver we also have version-related conditionals in the HW
> >>> modules rather than pushing all data access to dpu_hw_catalog.c &
> >>> counterparts.
> >>
> >> The dpu_hw_catalog.c and the dp_catalog.c are not the right files to
> >> compare with each other. dp_catalog.c should be compared with
> >> dpu_hw_xxx.c and as you noted, DPU version dependencies are handled in
> >> those files only and not all over the files like what this series is doing.
> >
> > Not really. dpu_encoder_phys_cmd_init() checks for the core_major_ver.
> > Let me see if other files check for the version under the hood.
> >
>
> Well, thats because only cmd mode panel cares about TE. No other files
> from what I checked.

I've sent a series which refactors feature bits into core_major_ver.
Now HW revision is being checked inside dpu_encoder_phys_wb.c,
dpu_kms.c and dpu_rm.c. And I didn't refactor SSPP, which would bring
similar checks to dpu_plane.c and possibly dpu_vbif.c

>
> > Also as you wrote, there are multiple dpu_hw_xxx.c files, each
> > handling register issues on its own. We don't have a single file which
> > keeps all such differences in one place.
> >
>
> Thats because of the way the registers are laid our in the SW interface
> document aligns nicely with the file split we have in the DPU even when
> the first DPU post happened.
>
> But I still dont think its a fair comparison.
>
> If you really had to go deeper into this thought, then even dp_reg.h
> should be broken down into smaller headers because the offsets in
> dpu_hw_*** files are relevant only to those files but after this change
> all DP files must include dp_reg.h even though they will not be using
> all of the offsets. Since current code was already doing that, which it
> didnt have to as dp_Catalog was the only one writing all registers, this
> went unnoticed.

Well... I had a thought about reworking DP into using XML files to
describe registers. It will make it slightly cleaner and
self-documented, but it most likely will be a single file.

>
>
> > Last, but not least, in the DPU driver there are actual differences
> > between generations, which require different code paths. In the DP
> > driver there are none.
> >
> >>
> >>> I think it's better to make DP driver reflect DPU rather than keeping
> >>> a separate wrapper for no particular reason (note, DPU has hardware
> >>> abstractions, but on a block level, not on a register level).
> >>>
> >>
> >> Thats the issue here. DPU hardware blocks are arranged according to the
> >> sub-blocks both in the software interface document and hence the code
> >> matches it file-by-file. DP registers are grouped by clock domains and
> >> the file separation we have today does not match that anyway. Hence
> >> grouping link registers writes or pixel clock register writes into
> >> dp_ctrl is also not correct that way. Let catalog handle that separation
> >> internally which it already does.
> >
> > I'd say, dp_panel, dp_audio and dp_link are already pretty
> > self-contained. I was hoping to look at dp_display vs dp_drm later on,
> > once the HPD issue gets resolved. Only dp_ctrl is not that logical
> > from my point of view.
> >



-- 
With best wishes
Dmitry

