Return-Path: <linux-kernel+bounces-320913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CDE9711FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7343A285373
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C780F1B29B8;
	Mon,  9 Sep 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="I+4Hf1d0"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BC1B3B34
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870405; cv=none; b=YCPg9Nx0BbcOI15n83w5TUpBn1IbNt8VeohYOqsfWPdD978WdCQmjbo8pmIOVnRhD3M0yUMsqDahKb8V8T4idrw5pZ6vq5A1cfhVCBBBhCiKEA9/VyXNsuLP4ulgJZs+03Rdt/9N5F3QBCIFEf5ccmKbDdCz19VHq9e3RQqNxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870405; c=relaxed/simple;
	bh=nZuZ/WbvFo48E5G+2CIQ1m+fKWKpi/j+8Y7r5vaV4W8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=nuK1VLM6wMi3ygUUFrEFlrBrQCbvrZ6LvDIuYJPNDIXCTgPzFE2MJTpwZ9C49vby/MMgmvf1MSkUzyNM6ncy8BQriVk6cNCGB1Bfpop++S/ydfJmV0nty82+I6JJiH4YMniRJap+f2qeCgtefIWyYz95GqpC+qmq1wAk8mzx7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=I+4Hf1d0; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; s=key1;
	t=1725870399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+IaTZWyNvLfaA2Yx5fCNnoQgcC03AEhnkKUre/aJms=;
	b=I+4Hf1d0d3CNvp7ElH51pfEZxXnYCoVn67V4JfPay8WtDcTFRdkBquERTs120VnN09CLwO
	bpWSQjSI41klmpM8uO1qRCvtP2DaImZciba0nWoXVSOZe7SZ3gpmrWKdmREDvB+0qh9fc6
	e0/W9c3oO3Ney4gfXdf2SGHK/1cbQwTf13UE7O4dEzyELjNyf1dOFKD2/dKYlOr+t26ACJ
	Yqlqqg9eGTSz0VqA+Pz/JgWnH6krmru3nNuvYg5JHJgNVW9giprna/ERNaUyxunWgKtjVY
	t/hzkIXAtv74ncXRyEdIslJLGtdEmNzlWihoNJgUc7XONvaGhZ37d7C29zngXQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Sep 2024 01:26:34 -0700
Message-Id: <D41LZTT7K2N5.10I6PS6B05IDG@kode54.net>
Subject: Re: [PATCH 0/2] drm/amd: fix VRR race condition during IRQ handling
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Christopher Snowhill" <chris@kode54.net>
To: "Tobias Jakobi" <tjakobi@math.uni-bielefeld.de>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
References: <cover.1725269643.git.tjakobi@math.uni-bielefeld.de>
 <D40Q9ZLDQIZF.3OERFS0AYREN0@kode54.net>
 <deb6d962-f24e-4769-b313-be3b0efb873b@math.uni-bielefeld.de>
In-Reply-To: <deb6d962-f24e-4769-b313-be3b0efb873b@math.uni-bielefeld.de>
X-Migadu-Flow: FLOW_OUT

On Sun Sep 8, 2024 at 4:23 AM PDT, Tobias Jakobi wrote:
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
> Maybe. But the big difference I see here, is that in this code there=20
> isn't even any kind of NULL check applied to tg. Or most of the members=
=20
> of *pipe_ctx. If there really is the same kind of problem here, then one=
=20
> would need to rewrite a bit more code to fix stuff.
>
> E.g. in the case of=C2=A0 dcn31_hwseq.c, the questionable code is in=20
> dcn31_reset_back_end_for_pipe(), which is static and only called from=20
> dcn31_reset_hw_ctx_wrap(). Which is assigned to the .reset_hw_ctx_wrap=20
> callback. And this specific callback, from what I can see, is only=20
> called from dce110_reset_hw_ctx_wrap(). Which is then assigned to the=20
> .apply_ctx_to_hw callback. The callback is only called from=20
> dc_commit_state_no_check(). That one is static again, and called from=20
> dc_commit_streams().
>
> I could trace this even further. My point is: I don't think this is=20
> called from any IRQ handler code. And given the depth and complexity of=
=20
> the callgraph, I have to admit, that, at least at this point, this is a=
=20
> bit over my head.
>
> Sure, I could now sprinkle a bunch of x !=3D NULL in the code, but that=
=20
> would be merely voodoo. And I usually try to have a theoretical basis=20
> when I apply changes to code.
>
> Maybe if someone from the AMD display team could give some insight if=20
> there still is potentially vulnerable code in some of the instances that=
=20
> Christopher has posted, then I would gladly take a look.

Sorry, I was taking a note from someone else who mentioned set_drr function=
s, and wasn't aware that none of the other implementations happen to be cal=
led from IRQ handlers. Thanks for looking into this.

-Christopher

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


