Return-Path: <linux-kernel+bounces-359841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E200C99915E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890EF1F255AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F31EB9F9;
	Thu, 10 Oct 2024 18:32:02 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A13119CC10
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585121; cv=none; b=VhO/uxJmIuZxVBtPlGl3kQG1HoDASkVoy6p/eAIvmzy0S8fa16QKz4LpXddSvOqd8eU+Nqm4/nIx8Wrqbh30yycW/EVvWI6l/J1Ws9Ssh0U+XQq9VLWSTYPCsSNvbW5AGKBCCUekaAmKmaDqXC3tAJetTtuUEOeP3H0rDqVodyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585121; c=relaxed/simple;
	bh=6Q8x48cyQEyrC+yQ/ZQX7QwayuHn8dNKIXTMm7lIje8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGOeg7C6VjgjHPa1qtn/WHlldgRIJ9ND4IrtQgMnvrVFjiPwOk1XAjBjFgKiLq9XSoAZtoMlIJx6BDQ1S/QffeExxw7/L91c2Du7yNvpeSofdSMLkyAnyarVF9usTSlSTzyZ0lF0uFv4RPQKODcYFa7HxWDEW9OnNc4/VzMrMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fc33fd8eso1032081276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728585119; x=1729189919;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q8x48cyQEyrC+yQ/ZQX7QwayuHn8dNKIXTMm7lIje8=;
        b=MD4RF7ielvXkVO5HGlzeuWWUtITvy17IiN+HKwQrhKuTcH3S6YhSp5CrQb+QREPa/0
         nrzJxZnu0oAaO2gt5Yxsp1031Pq2Z4ijPTzsk0fv8yyhtFVTuhb7OKDF+4mtJJoE+4Gs
         5rYt1Gz+t7o1CPAYFxDOtcZI1Jg5UPWcTpQGH1Ggm5oFGo4LR6k+qq+21EJ0+gGknLA1
         A25lU804N0Vxrqmn8Trcg919HjvMbns8aZTuCoYZ4BQxT7l/t9HiOQb6AwAYivK1mDh6
         qL0NG1PFVWOQKfdMlmUdBWh09eQNpDZZbmuXxB1AhmxYdQyUjiHo21MSnecyd1Imkn8f
         GwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKyFOqxIWdCbzV031UWhh1/05yYU5b0ij2bMIJQ4ohMdnqRw5yaT4HRFCCAlSg95IkQTkEtnVuEcZD5WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/iPxbVVy7/TBMwwQlVhy9j6GFjQNw/Gsqr8/xp19XZQFeYWp
	iE6zopxBE9kZf1nyHt4cTOgqb8+bqcLTS1k6Rb9Dz4vUa/2fQH6W
X-Google-Smtp-Source: AGHT+IGib9iE0TgZ+rOp8CiOuMKm/DgfkHOzC2PAi8eX+APTnJgoElsrDQnC/xU0zq1suGEJTcaqpA==
X-Received: by 2002:a05:6902:846:b0:e29:890:c6d4 with SMTP id 3f1490d57ef6-e2916a18094mr477274276.41.1728585119108;
        Thu, 10 Oct 2024 11:31:59 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e290fc28c1csm358115276.20.2024.10.10.11.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:31:58 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:31:56 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 4/6] sched_ext: bypass mode shouldn't depend on
 ops.select_cpu()
Message-ID: <20241010183156.GD28209@maniforge>
References: <20241009214411.681233-1-tj@kernel.org>
 <20241009214411.681233-5-tj@kernel.org>
 <20241010181517.GC28209@maniforge>
 <ZwgcU6PKOYMP83MC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9cLWydsEGbSYLXRG"
Content-Disposition: inline
In-Reply-To: <ZwgcU6PKOYMP83MC@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--9cLWydsEGbSYLXRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 08:26:27AM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Thu, Oct 10, 2024 at 01:15:17PM -0500, David Vernet wrote:
> > On Wed, Oct 09, 2024 at 11:41:00AM -1000, Tejun Heo wrote:
> > > Bypass mode was depending on ops.select_cpu() which can't be trusted =
as with
> > > the rest of the BPF scheduler. Always enable and use scx_select_cpu_d=
fl() in
> > > bypass mode.
> >=20
> > Could you please clarify why we can't trust ops.select_cpu()? Even if it
> > returns a bogus, offline, etc, CPU, shouldn't core.c take care of
> > finding a valid CPU for us in select_fallback_rq()?
>=20
> For example, if select_cpu() returns the same CPU for all threads on a
> loaded system, that CPU can get very overloaded which can lead to RCU and
> workqueue stalls which can then cascade to other failures.

Ok I see, so it's that it could make such poor scheduling decisions that
the system can't recover. Got it.

> > Assuming we really do require a valid CPU here in bypass mode, do we
> > need to reset the state of the idle masks for the case of
> > !scx_builtin_idle_enabled? The masks won't necessarily reflect the set
> > of online CPUs if we haven't been updating it, right?
>=20
> I think resched_cpu() after switching each CPU into bypass mode is enough.
> That guarantees that the CPU leaves the idle state, clearing the idle sta=
te
> if set, and if the CPU is idle, it goes back into idle, setting the bit, =
so
> at the end, it ends up synchronized.

Yeah that sounds reasonable. Thanks for explaining.

Acked-by: David Vernet <void@manifault.com>

--9cLWydsEGbSYLXRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZwgdnAAKCRBZ5LhpZcTz
ZC6gAP4w++CmE9FxpOMQWvPNtHboZkJjItrODpsRfOPX7LrUQgEArePyE9NdYzZ/
tA8wSm3rr4x6TjJ4kbhp2eC0DbjtHgw=
=LqEq
-----END PGP SIGNATURE-----

--9cLWydsEGbSYLXRG--

