Return-Path: <linux-kernel+bounces-438395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9E69EA0BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9ECB1886FDD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA319B5A9;
	Mon,  9 Dec 2024 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnROmsST"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D719B3CB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777814; cv=none; b=SRHG/9DTvG5bgZDXTm2C8lx+6vm23YYkHC+7QifruJwtQ4pu1Ns3Za/TjtSECnYaNoUgykywDbyoPOaHuujo5lBuLqlRym2eCT3MiFaEckBhXT6MlzpfbghfqmPTnQwdSwCIy6L1VyNpQyxUPuBHwQvE4N5y/8k+JOePCgsNHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777814; c=relaxed/simple;
	bh=wNYSSe6aEUUbk7DbRyQCZ83hXHBs6D5DfDEJQ5xzCuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idVpJza1vwUCRKvj/nrx20gCJFsrHfmOrsZjDBUrG7gCIn7idSZgB7gqjNJdmTkufLrrKug2DanqKD25NXrjQn44ug64Xd+8prHnRoINkbApf8LgZ8+5O6gdJy5hnLrznzRj/Y/cWrWe5N7cV5GSAWXYCK/nA/XVte53lzfkKHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnROmsST; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef79243680so586779a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 12:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733777812; x=1734382612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezkmBL5VUO/PNXtpKMgd76cJBr7+MADsjdUYCjfhYy8=;
        b=NnROmsSTpJsvpnC4pD8YBNdYy0ySnvXPTi+36liatOcMmPrrDLg+JYpGPBZTVEsCkU
         +S82hdX2bXAenkldIlAOQoWDQ1A+ir+/r+snHAPK7hzFLChIgCfjOs/jFCkPS2zGtQBa
         JNhcLpP1sh24JZvc7upihjrZaVaJCuSWonkk2Or3ZvS88AAbeCq0PJdGefJkTDNJs4ZJ
         I2zTdtUibAy2ynceNfaohLGxtS4rjq811LY7e0qOqG4UYfDtEB9w3EJrbYhXlpxmlaNp
         kJY8y0NLtANzcJMmi2aO68wW1LhjTUQRfJeutCVPANylEugpU+8DAQVT1F9NcsyBNUUx
         P89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733777812; x=1734382612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezkmBL5VUO/PNXtpKMgd76cJBr7+MADsjdUYCjfhYy8=;
        b=c4nk4JZRUKzxVuBty356vmFB03JFGiOkDnjPio+ej5QVYaicGr96/031ZbzGds3FU1
         gLJuVOB1KsrYGNPL/huzOQg2wpUCCnxCd/R9X4vdCeeNaVcoDNuopYVHjs57WEXqkEhn
         mgptJeNu5XuLx/VJia1AXyHGWkZCCcpR8RNGFUM3uYWcyguMNnoV9QK3cWoTEgcyWM1U
         D2WeWscmPuM4DRn+fSoy5EugfakJH5zPpo1I7fOi/E7nFCjMiQzbNPByeI/FZX71ZI7+
         qRYHc8lWyoyyNsW8WaY/aKSDRfeO4H4zvPNTvzbxa29LtEFKL4TlqjLZTMngXvnusmNh
         WlyA==
X-Forwarded-Encrypted: i=1; AJvYcCWJksVlELrui1SrnCOsbbD371bSQJxU72KHilNFGKOW9SNsPDly1/zH2I6d4WfXsVOXjZdPyT48BuFGcJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLeWh3R1wowATd4Do8CClnrJCeRRe/s9V5OSN83knveNTuaAgo
	OYV0TN9/o7dOQyz2KfGUNe6y3tb+uyPs7XbFY7aa7IwJFnkc8FVG2LTKOw3xe99GBFTHyYsZoua
	EzIjZZdahWS22dmdHM1RGwF7Pib4=
X-Gm-Gg: ASbGnctfl9XhptHwwd9PP1EWO98ZP9OCgZvUDJvzTQETGqJb+VBETSsHLcj3LRsnCN+
	KnUYzN2GqFUcsU47VkYP3bkhQW2G+vzcHSMw=
X-Google-Smtp-Source: AGHT+IFcRrfCMGls5yqYKTcr2PE5GRIpy/PG523CyNrG70/v+QAJwYJp8rMrfjufd2aMTUe7Bmwh2Iowhj5LZcmxjaE=
X-Received: by 2002:a17:90b:1b42:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-2efd454dfb2mr588400a91.0.1733777812387; Mon, 09 Dec 2024
 12:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104023852.492497-1-linux@treblig.org> <Z1JhHcaYZCzKHp-i@gallifrey>
In-Reply-To: <Z1JhHcaYZCzKHp-i@gallifrey>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Dec 2024 15:56:40 -0500
Message-ID: <CADnq5_OUSOzzUYin8SRRGPL0MCvmd+RGo0TM_DRAyp85zE--Jg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Some more drm/amd/display deadcoding
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com, 
	Rodrigo.Siqueira@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	chaitanya.dhere@amd.com, jun.lei@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:35=E2=80=AFPM Dr. David Alan Gilbert <linux@trebli=
g.org> wrote:
>
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > Hi,
> >   This removes a bunch more functions (and a field) from
> > drm/amd/display that are unused.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>
> Hi Alex, Harry,
>   Gentle ping on this set - I think you've already pulled in all
> of the older ones (Thanks!).

Applied.  Thanks!

Alex

>
> Dave
>
> > Dave
> >
> > Dr. David Alan Gilbert (5):
> >   drm/amd/display: Remove unused enable_surface_flip_reporting
> >   drm/amd/display: Remove unused dwb3_set_host_read_rate_control
> >   drm/amd/display: Remove unused dc_stream_warmup_writeback
> >   drm/amd/display: Remove unused mmhubbub_warmup field
> >   drm/amd/display: Remove unused dcn_find_dcfclk_suits_all
> >
> >  .../gpu/drm/amd/display/dc/core/dc_stream.c   |  11 --
> >  .../gpu/drm/amd/display/dc/core/dc_surface.c  |   7 -
> >  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 -
> >  .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  | 132 ------------------
> >  .../drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c  |  13 --
> >  .../drm/amd/display/dc/dwb/dcn30/dcn30_dwb.h  |   1 -
> >  .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 -
> >  .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 -
> >  .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   1 -
> >  .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 -
> >  .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
> >  .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 -
> >  .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 -
> >  .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 -
> >  .../drm/amd/display/dc/hwss/hw_sequencer.h    |   4 -
> >  .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 -
> >  .../gpu/drm/amd/display/dc/inc/dcn_calcs.h    |   4 -
> >  17 files changed, 187 deletions(-)
> >
> > --
> > 2.47.0
> >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

