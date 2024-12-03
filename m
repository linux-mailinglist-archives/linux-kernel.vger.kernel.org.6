Return-Path: <linux-kernel+bounces-429201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D889E18AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA816284A22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BE31E009A;
	Tue,  3 Dec 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JrcEo5/W"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85631E049B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220098; cv=none; b=dNlfURc79gkreB1FcSHNeO86kis37guoDBaAhNTTTGsx18XS2LvGlBh0L2EhdqHgPIIPWj5lG8yyp9zCai4K1mdpfug1lZ0KVAIpTdKGtyNwPrI+rR6KZBKIAPuMVuUxiF5BYHjVR659ow6KK2wnEz6BKHB7Sd8cG6O8lG/TP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220098; c=relaxed/simple;
	bh=sTaUZHI2tA84h8s1smjIA8SchVj4beLWUzNFEdnsLGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1Y+BeYj1j1moNYwg9ym0VlPoQ3YGnHQF6nlKCgxnUxTBfdCMN+Xs6JkNrXS9tL5zyyYfl4xEvxlerwTE+pZG4ZKVrtebFRBZbODiv+tZs50OYBlxDMU3TmfBLap88Pw9n9Av1JqsDujdl1laYUk/XeGH1NxGIfmNARe8rf6usA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JrcEo5/W; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso45345175e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733220095; x=1733824895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RhTW3NC1pbn/g5iDVajml/TzAYdzfRHRj7mqxdaAUTg=;
        b=JrcEo5/WIv5Y9slnLjpi/tW3KI5MOSebxJKEa1pKNvnxP7V45KTywrZEpAyV+MO+h6
         P+HFFvS/OvRo2a2UTRC/5BZqi2M4p7keEErCrp07MRCXW6qksy3UmoPWE2oQIUtGwPEq
         ezwqftIybC1xeHnQ05tif/2y7yXAG+rjVp+SJ4NEO16SMIfV/FYTpRo/NY5b/Ar5ONqN
         rJ05Tk/cDGZYM+Fj0QtP/ZnCsnIOHr6Xp2TtEnhpBtFyLHJJPLRysjvDPjOVSgiMbgBB
         ej0VPLItBX1FiOet0tH0GQ1wdG/5rPV7VBlseKeuKX21I8pyUmwx+q/JE5lfUHkitm8m
         n/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220095; x=1733824895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhTW3NC1pbn/g5iDVajml/TzAYdzfRHRj7mqxdaAUTg=;
        b=lQ8fqIT7pJ7+WLa3F4RjCO7N7+LqXDkSKzb+astOACVmP+yjDlh5j6Df1gB07k3COn
         MYKLSLUOV1rkx6esReXnGAixPDdC/Mq2epnFAP4ee069MHILBTScv3+gtgptaGsiWBre
         bTs6AMHSqvLtcfgsOAauR/1l40xPdFW+g+3PWUvU5/25ntcIk3zDlXyqHgEMxuaItEEW
         hJv/h+/SFDO5GK5OGdscuLSmL3qjv4STCwcyOqbRk5IdYJeN933NhbE1rFm/MNb1rVEm
         r2svKruyfEA+/jjtGN2lFStlXnVsrrRWPhnrOdt3iPpqFZw5HGx2BPXLwcNg2hfT/ADj
         MYLA==
X-Forwarded-Encrypted: i=1; AJvYcCVFwHyWxOoIHsp3dgan66IyM4AaI0tG4HvypDtmaEXztGyaoX5I5uhKeQmAHyX99sO/cGfaf//BdbV/oXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7nbWKa3VAVJ7rrCEIQqg70TYmcqYKwQad12OT2ey2WoG7e/wz
	ksB80iW5/BCkQAmfzcF3iIRinfeK2o6TRVLuCkJ7pOnXCnMV2MtdyLlMFlua0rQ=
X-Gm-Gg: ASbGncvbGdkZl4P4fDxYodCSazE2pCYuMOPPTpp/7vyL8/tHcLkNeopixNvey9yUifG
	slGaaNrV7Bqds6BbZYUPJ00aRkiBVqf2qxkbuc8VmqEzlYZUizGGVBtzE/MsMwiPONaZdqXTKlJ
	C+cEg48BNFnh6R40nDaHi2Usff0bGdyDwYojULUpHGEXDJ/RUIi1yil/UuLVseqnENehHljQxQc
	N646px0LK8ZTAiuI3YmqGiPPoCGlsSjqyENoGAM0GLNCGNRONp1
X-Google-Smtp-Source: AGHT+IGq5X9mSPxxsAFmS7My9jVFZsDOIyBErQpUdlf+4yk/lCrnKIeVD1Y0clKPxw7cqtpmcqfo2g==
X-Received: by 2002:a05:600c:4748:b0:431:59ab:15cf with SMTP id 5b1f17b1804b1-434d09c37bcmr15948935e9.19.1733220095018;
        Tue, 03 Dec 2024 02:01:35 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bc91sm188449525e9.9.2024.12.03.02.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:01:34 -0800 (PST)
Date: Tue, 3 Dec 2024 11:01:33 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] sched: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <odrc34bhhsgvrbpwenhppuhoqonhwzd7gboiib27lkwdcblbd7@sp2nukpotx3u>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
 <20241108132904.6932-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ea4zwagibntp3e67"
Content-Disposition: inline
In-Reply-To: <20241108132904.6932-3-laoar.shao@gmail.com>


--ea4zwagibntp3e67
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 09:29:02PM GMT, Yafang Shao <laoar.shao@gmail.com> =
wrote:
> sched_clock_irqtime may be disabled due to the clock source, in which case
> IRQ time should not be accounted. Let's add a conditional check to avoid
> unnecessary logic.
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/sched/core.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)

This is actually a good catch!

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--ea4zwagibntp3e67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ07W+wAKCRAt3Wney77B
SUToAP0bf3KX+N5xm3vm8owfdlzAy/cVhQL1fm1fSrhXqDheCQD+Ks6ccQNENKEb
o0qFsPqS2NnoPMupbIr+Hyuox4gA+As=
=N/M7
-----END PGP SIGNATURE-----

--ea4zwagibntp3e67--

