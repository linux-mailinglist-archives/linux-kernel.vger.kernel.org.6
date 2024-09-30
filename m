Return-Path: <linux-kernel+bounces-344399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C5A98A916
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405B21F2351A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724FF192D65;
	Mon, 30 Sep 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye+nBW+b"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F2191F8A;
	Mon, 30 Sep 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711488; cv=none; b=aLfW4Q/lZazZVcJh9WDnsuPNl+gZopX0BJOOnHPoMF6QViSv2AsHZuJ40MH6/UPYiSVDxB/ZrCljWZz8vEuEkF4XslVhQajV1dwV1Vx5OCDekGmqlF9LwpPUJimzh7oM2rE2mY3D5U24cq8fhPpgOWwvQysfDVZxiUt64S1HXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711488; c=relaxed/simple;
	bh=x3/NYRhqdZ25w1cWCnf65Jb3aFSFAFZ/91FdfDZ1weU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRkY8dPYExsykyTSqha9KYb/oXS+57nlrKFwbmPIHBL9By+HUkgCB+jL9S2ay7sOzWSC5snJC35kX+SGgWhydjP8LynH0vxMdWk2SkwRpgbx7ralGf40tRF2ALzuw7Ga8WBXfZsbcA5jEt8jmLEmm+YsTKSMAJng4WkjEUa3jwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye+nBW+b; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2db6e80555dso957044a91.0;
        Mon, 30 Sep 2024 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727711487; x=1728316287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WATU2LUL4m9jJ4Aa98MIDs6l2qLx+EWO4m8F+EIqLxk=;
        b=Ye+nBW+bQF+xhAhuhAj6Gumfs42csHfoNPUaAvVBtZaF+8YQ0SgIjL7k939wfE89OG
         ldgqKXVhcJMroYyUrDQwUsav9neEAR8MYwPBXRYkn1RKfPrgLkSGuIvwwWUQKFxwjeVm
         wMc3bcgQZ9+Pasv01SEJO3aj5MzuWTwKD9dn+wmSMGYkgSo8DPwm+00qFCFkbg2KxP4g
         8e8EDKf/yo0ZMEqVdzQAzB58Vh4qBPXjO973LbQUfZg4eCGshWVVLWNXIA26Quv0ubxa
         DpwpNc/N0vK5yxXSoh29lb78y5K9jkpvGp+/I6QEGSJSUbC0YfaVOPMWWn67H4vvTGQU
         e3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727711487; x=1728316287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WATU2LUL4m9jJ4Aa98MIDs6l2qLx+EWO4m8F+EIqLxk=;
        b=MRCbsIiVElKMwQ5rpcls/i/ll+GDU/rfWiTXdWp++nu7PmIriJcC8oRqynqbi5kCap
         3Lgi5oC+2MKsRmXMHNP+Vh+JazVTDtwWlGsFaxg79wm5KcCk4jAQMfbLYTthM3qqAsur
         ql4e/UpYe7TRU3z42FcwzFBKdhG8X8Qzl5QJhVD3UI57h3NHGo913ZxNsVvtNob8aHTs
         0+eN1AhBd4N8o52wyZQpeBz6l0pwcYb1E2oEGlTqFaw7QhLa8OOTIeIUSnaGutCjYTzM
         qmm4z3GvxR1qix3eaZvZJByeXSCAkWcqWCXDyV0vK2RJWqGb9aAMduAVpsJKtWHEh4Gz
         Qe7g==
X-Forwarded-Encrypted: i=1; AJvYcCVUGIsEJEY0kclUm2T7Da1n5J5IMy9Ak1t4ygne3b7MIVhMoU6O3QvXobReTQ2uJ3bZQ67Me5BIvF/j5vLMduk=@vger.kernel.org, AJvYcCW7GUfHVElBEZxjvnl0f+d90MYZCaWNkMWvdo6Wzi605lKSPmDkCEVGqN88mHgx9jXMntKVQ5H1CMlThs4P@vger.kernel.org
X-Gm-Message-State: AOJu0YxfyjVLVmdUQveaR1OvaLr50S+Bo4b5iyHze3pnl3iZUwjXFrb1
	ZIpXHjHZhCl6Hdr2xJhaSbSN/ltoaKj8PYB3rWSWs8fKl46WqdoBHON0b1yxHwk/nC4Ge/MwPlg
	f2sLQ0TTzx+9Fjc6wD0EDX+9ZFCA=
X-Google-Smtp-Source: AGHT+IFy3pRmWmgHWpHGv0hrtSuJlpDkTjLMGNYiRP85LAIbiklgXtlTBb98vvOc2vKFgYVr4pAxxQk/8QByQ4oMpcQ=
X-Received: by 2002:a17:90a:e548:b0:2e0:8c23:fe5a with SMTP id
 98e67ed59e1d1-2e0e6e9902amr4399944a91.3.1727711486757; Mon, 30 Sep 2024
 08:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930112121.95324-1-Julia.Lawall@inria.fr> <20240930112121.95324-26-Julia.Lawall@inria.fr>
 <feb19089-a7ee-4a39-be8b-bf9e380b17b7@amd.com>
In-Reply-To: <feb19089-a7ee-4a39-be8b-bf9e380b17b7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Sep 2024 11:51:15 -0400
Message-ID: <CADnq5_Pv1YOo2SNajhJvfRFKK=Yf1a4=4ufFteP2_n3jFA45Yg@mail.gmail.com>
Subject: Re: [PATCH 25/35] drm/amd/display: Reorganize kerneldoc parameter names
To: Harry Wentland <harry.wentland@amd.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, kernel-janitors@vger.kernel.org, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Sep 30, 2024 at 10:49=E2=80=AFAM Harry Wentland <harry.wentland@amd=
.com> wrote:
>
>
>
> On 2024-09-30 07:21, Julia Lawall wrote:
> > Reorganize kerneldoc parameter names to match the parameter
> > order in the function header.
> >
> > Problems identified using Coccinelle.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm=
/amd/display/dc/core/dc.c
> > index 5c39390ecbd5..417fe508c57f 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -621,8 +621,8 @@ dc_stream_forward_crc_window(struct dc_stream_state=
 *stream,
> >   * dc_stream_configure_crc() - Configure CRC capture for the given str=
eam.
> >   * @dc: DC Object
> >   * @stream: The stream to configure CRC on.
> > - * @enable: Enable CRC if true, disable otherwise.
> >   * @crc_window: CRC window (x/y start/end) information
> > + * @enable: Enable CRC if true, disable otherwise.
> >   * @continuous: Capture CRC on every frame if true. Otherwise, only ca=
pture
> >   *              once.
> >   *
> >
>

