Return-Path: <linux-kernel+bounces-321832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8587972015
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7A01F23D3C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F54516F907;
	Mon,  9 Sep 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGxPiRA7"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC94D8DA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901874; cv=none; b=L4twgtHt3bx0Ybl4ZaTQ3kcoi0CBfCYUQJJKfIsxCnrPYy/mqyrJ8v/p675pTCRKeep2L9lHWqNToOH+wrzbvbbymYVzj4WmvP8/3ufSem4JpuShPoD9FDwyyUT6FMAv9m4xkzytulbOllGZyaKczZUcJhsnzZD/p8GRI3IpxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901874; c=relaxed/simple;
	bh=SaKp0Q7ae/fE6I+7pWzgCXp1MwPG/g+L0Gkjze7UDHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUkGBVmfKlw1wfALM/pQ+0RYECWzIZrL1S8iTacvyNM0Kvy/WenKzbn0G54wp3KkSWn/p0h0GMYb2CxgxyiL3bjtdfK9qedBVKG2a4jsu50TQy/+FaBvaY9QbzAh288VF/bruLG4dDA3w/2gB9SxMDiVFPK9SOFSIgW1QPBlbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGxPiRA7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2053f72319fso2169215ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725901872; x=1726506672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVftTf/6dppL8th41rroSYqvMXFlN1yv6xhVhcE4Yek=;
        b=QGxPiRA7yxxojymL6l++coDdjwxIEX6hgeVZlN4PaIFliXAnz/i5cGE4k8cDeH9AM/
         SD+ah/H//vSRjOfLsM+PKj6jeYkoGc7USkA6o1unVPO7uOmQh9eflluOIYVPQ+DuXp6p
         b9itrXb9D81Sqvtqox2jXvwOuiEKdnxwbDiM6qJWFLmtLZVXQkZarOdyf+IUT1LaBBaB
         e69HyyWAtHu8ryim76356U/6F61agsy0E6yvOCCM7uPjB7lQdvXIS+A8qNsGBI4JxBUQ
         oIedaKnZEuHGLir/fN4FE60bwDsoutkc9+NNP77J5kZ5/MK3Z1nx37kJr1M0QqXY0U+C
         9EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725901872; x=1726506672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVftTf/6dppL8th41rroSYqvMXFlN1yv6xhVhcE4Yek=;
        b=liWEOCLi22UHhEWbBkp2+eIm7UojDSzcEoIoMV/vVI1NowABCiw7V9fTk7CNiQAZZ0
         A5gGbvKEuFKDjrAXsOkKEiFhr6d0pbICaioYCxbYBBG6ycaLalrVNqDbAT9rOuzUH0pD
         4fL5Tsc7AVUC7+55tb7wL9P6US7+mp7mVPxhOVzjmXoj5d6pyzRlRdzvgUVdauCCzJ9V
         e2/Wds5mx+TVgP5E2ezIeyTYovKrG5gDHZoY5TsYzhT3nWfOZK7WUMdCSXU9VeH4j5xP
         Chbk7mHLw/4qi472iAiq4g5TV0Zu7kg48mCpWEqxLg6HLDidspWNwk9HOw4H5eVdrd2t
         3/rw==
X-Forwarded-Encrypted: i=1; AJvYcCVooni+1V71BdVD032eenUI2ivObo9asjuXe1/VXqOZc0hR6OKI+9kDtntv5j7I2x4cq4PhZF82oxa6lLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHgzoCZT5b61KrLSXpOSb4687D8EKz0kIPVvHQaShi9ZvUsyl
	NNCee+ON1XmXPy6GFFWxG4FjFgJuXmBO5JOoGCXxTvVCXoAw8qwbFheUQ5YX4lHfAlTvEGiJzFg
	8kjAjO7CPToxrl1oF0D29WaJDvJw=
X-Google-Smtp-Source: AGHT+IG6tq0gRvkzZXE20DrtwJfgOOovD9fBBwckWQFdSkiHCtqeKpXQgZwxo2UTje5uc6S+kLw3UDjEzbi2mI3hjqk=
X-Received: by 2002:a17:902:d2c2:b0:205:76c9:795d with SMTP id
 d9443c01a7336-206f0605ebbmr59105145ad.6.1725901872296; Mon, 09 Sep 2024
 10:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725269643.git.tjakobi@math.uni-bielefeld.de>
 <D40Q9ZLDQIZF.3OERFS0AYREN0@kode54.net> <deb6d962-f24e-4769-b313-be3b0efb873b@math.uni-bielefeld.de>
In-Reply-To: <deb6d962-f24e-4769-b313-be3b0efb873b@math.uni-bielefeld.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 13:11:01 -0400
Message-ID: <CADnq5_PMnCUYsUq_SPS8woi20KxaW2+teMzhmmOyFJRaq3YVQQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/amd: fix VRR race condition during IRQ handling
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, 
	"Wentland, Harry" <Harry.Wentland@amd.com>
Cc: Christopher Snowhill <chris@kode54.net>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 7:23=E2=80=AFAM Tobias Jakobi
<tjakobi@math.uni-bielefeld.de> wrote:
>
> On 9/8/24 09:35, Christopher Snowhill wrote:
>
> > On Mon Sep 2, 2024 at 2:40 AM PDT, tjakobi wrote:
> >> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> >>
> >> Hello,
> >>
> >> this fixes a nasty race condition in the set_drr() callbacks for DCN10
> >> and DCN35 that has existed now since quite some time, see this GitLab
> >> issue for reference.
> >>
> >> https://gitlab.freedesktop.org/drm/amd/-/issues/3142
> >>
> >> The report just focuses von DCN10, but the same problem also exists in
> >> the DCN35 code.
> > Does the problem not exist in the following references to funcs->set_dr=
r?
> >
> > drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c:      if (pip=
e_ctx->stream_res.tg->funcs->set_drr)
> > drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c:             =
 pipe_ctx->stream_res.tg->funcs->set_drr(
> > drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c:             =
 pipe_ctx[i]->stream_res.tg->funcs->set_drr(
> > drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c:        if (pip=
e_ctx->stream_res.tg->funcs->set_drr)
> > drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c:               =
 pipe_ctx->stream_res.tg->funcs->set_drr(
> > drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c:               =
 if (pipe_ctx->stream_res.tg->funcs->set_drr)
> > drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c:               =
         pipe_ctx->stream_res.tg->funcs->set_drr(
> > drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c:        if (pip=
e_ctx->stream_res.tg->funcs->set_drr)
> > drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c:               =
 pipe_ctx->stream_res.tg->funcs->set_drr(
> > drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c:      if (pip=
e_ctx->stream_res.tg->funcs->set_drr)
> > drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c:             =
 pipe_ctx->stream_res.tg->funcs->set_drr(
>
> Maybe. But the big difference I see here, is that in this code there
> isn't even any kind of NULL check applied to tg. Or most of the members
> of *pipe_ctx. If there really is the same kind of problem here, then one
> would need to rewrite a bit more code to fix stuff.
>
> E.g. in the case of  dcn31_hwseq.c, the questionable code is in
> dcn31_reset_back_end_for_pipe(), which is static and only called from
> dcn31_reset_hw_ctx_wrap(). Which is assigned to the .reset_hw_ctx_wrap
> callback. And this specific callback, from what I can see, is only
> called from dce110_reset_hw_ctx_wrap(). Which is then assigned to the
> .apply_ctx_to_hw callback. The callback is only called from
> dc_commit_state_no_check(). That one is static again, and called from
> dc_commit_streams().
>
> I could trace this even further. My point is: I don't think this is
> called from any IRQ handler code. And given the depth and complexity of
> the callgraph, I have to admit, that, at least at this point, this is a
> bit over my head.
>
> Sure, I could now sprinkle a bunch of x !=3D NULL in the code, but that
> would be merely voodoo. And I usually try to have a theoretical basis
> when I apply changes to code.
>
> Maybe if someone from the AMD display team could give some insight if
> there still is potentially vulnerable code in some of the instances that
> Christopher has posted, then I would gladly take a look.

@Wentland, Harry can you confirm this?

Alex

>
> With best wishes,
> Tobias
>
> >
> >> With best wishes,
> >> Tobias
> >>
> >> Tobias Jakobi (2):
> >>    drm/amd/display: Avoid race between dcn10_set_drr() and
> >>      dc_state_destruct()
> >>    drm/amd/display: Avoid race between dcn35_set_drr() and
> >>      dc_state_destruct()
> >>
> >>   .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 20 +++++++++++------=
--
> >>   .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 20 +++++++++++------=
--
> >>   2 files changed, 24 insertions(+), 16 deletions(-)

