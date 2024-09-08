Return-Path: <linux-kernel+bounces-320041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4CF970559
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D9BB21C2C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452975733A;
	Sun,  8 Sep 2024 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="vs9QuaaM"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7BEEBA
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725780926; cv=none; b=f00sN65UoqaMUzfQqCVtASIyRPsv2Kw6JRHhxEHZEcHV2CTa4m5dqbQumgbp+kaEmH8HcZLQREGpVdfpR+Vq0KsuN4XzY614L1IsbPEwkgxw+VOiaW9Np5g6mv9gMmy6hemjjfZfWggU8yTnDlQ7JyQ40ID8qOXCVsKK+HKyFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725780926; c=relaxed/simple;
	bh=Z3bkSIIMCaJ2Mews1CBMj8m/WqlFLp+FFx301ufFIGw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=dTkS3X9tfSXuv5xbdbyfcTMqLnmPiwyyiuAFmwHKjkccRO320iyKRqYbTxujn1WdujlVEox4vFb5pP4Toi/OW5bj5hk9CjnVThvh/bw7szsA/vEv12HCEU42y2xLKqtqF0FHktUTO3dHEnpS3aPcJ0PUXNuZbT2+8sXhaFTYIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=vs9QuaaM; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; s=key1;
	t=1725780919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0T3JnuFovJcPSZrr0kiMqAwcD+Baav4OSrwaNtip90=;
	b=vs9QuaaMH8C5P7D10dtuh1AepPnZZdG3yid2Oz9KNSEq4mtwRL5Cu2t3HTCYdYCt2KjVG3
	0QKlwtk54rU+jcrnkIwJMRMgO0DqZSDAdgvdmpodIuOFnGaDtpmWCmSEq339Epm+C9KET6
	Vo8FlerLFeurqQyPR3+vyZevwOAdpCvE2Yc7NTqQcjcfjqb+4IKTycLtKG1bVBhGa27nXr
	5oeyvleig15Ll6b74NLwRUuSqj43jjc3pCu1Z3VtDcySI51KDYEyYfMkyFXlWjsbskE3Up
	5+1ex8AkPPMu6S9VZY1u3VitgM2madHFyWsbGMpKm9MNZaHhdadCsWz7KXCD0g==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Sep 2024 00:35:15 -0700
Message-Id: <D40Q9ZLDQIZF.3OERFS0AYREN0@kode54.net>
Subject: Re: [PATCH 0/2] drm/amd: fix VRR race condition during IRQ handling
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Christopher Snowhill" <chris@kode54.net>
To: <tjakobi@math.uni-bielefeld.de>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <cover.1725269643.git.tjakobi@math.uni-bielefeld.de>
In-Reply-To: <cover.1725269643.git.tjakobi@math.uni-bielefeld.de>
X-Migadu-Flow: FLOW_OUT

On Mon Sep 2, 2024 at 2:40 AM PDT, tjakobi wrote:
> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>
> Hello,
>
> this fixes a nasty race condition in the set_drr() callbacks for DCN10
> and DCN35 that has existed now since quite some time, see this GitLab
> issue for reference.
>
> https://gitlab.freedesktop.org/drm/amd/-/issues/3142
>
> The report just focuses von DCN10, but the same problem also exists in
> the DCN35 code.

Does the problem not exist in the following references to funcs->set_drr?

drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c:      if (pipe_ct=
x->stream_res.tg->funcs->set_drr)
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c:              pip=
e_ctx->stream_res.tg->funcs->set_drr(
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c:              pip=
e_ctx[i]->stream_res.tg->funcs->set_drr(
drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c:        if (pipe_ct=
x->stream_res.tg->funcs->set_drr)
drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c:                pip=
e_ctx->stream_res.tg->funcs->set_drr(
drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c:                if =
(pipe_ctx->stream_res.tg->funcs->set_drr)
drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c:                   =
     pipe_ctx->stream_res.tg->funcs->set_drr(
drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c:        if (pipe_ct=
x->stream_res.tg->funcs->set_drr)
drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c:                pip=
e_ctx->stream_res.tg->funcs->set_drr(
drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c:      if (pipe_ct=
x->stream_res.tg->funcs->set_drr)
drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c:              pip=
e_ctx->stream_res.tg->funcs->set_drr(

>
> With best wishes,
> Tobias
>
> Tobias Jakobi (2):
>   drm/amd/display: Avoid race between dcn10_set_drr() and
>     dc_state_destruct()
>   drm/amd/display: Avoid race between dcn35_set_drr() and
>     dc_state_destruct()
>
>  .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 20 +++++++++++--------
>  .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 20 +++++++++++--------
>  2 files changed, 24 insertions(+), 16 deletions(-)


