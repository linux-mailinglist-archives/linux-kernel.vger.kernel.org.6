Return-Path: <linux-kernel+bounces-409745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B147E9C90DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F3F1F23D19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A09B189F3C;
	Thu, 14 Nov 2024 17:34:23 +0000 (UTC)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58697262A3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605663; cv=none; b=I6EIxQuMv/weUbLr+n3sV2Ztuapd3WCEbUe874WfStFSATChAIoL+RXW7cvktYI0BsYR/DeFDM7gFxae55flUb63aDdXBpvEmt6SJMJcDi94Kckq/loe9JJEpS9TsFn8hyFVOxBnU7C3UV4Ic0bNkfGuIUm6qJui5H+cyMVjdRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605663; c=relaxed/simple;
	bh=w3Kgi6NMQefSt7FMZmFoT7F48bNhTskbbxGecsSokzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9GzR46pjV+LbR4KKBvZfudVG3nJUmEY5dvU5je/+OSNMlcmTFImei8u+liMwO0EHwmEMCI5UHhWF5/5ObdkbZdoj6rx4URLnRA6jcoqBzmS3PAB1r1v7zYwfAOV6htxl4Iu/I8PHpGU0NJvyjO8SfGaLk1NM4M0SId8ErJ/MM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a4d1633df9so2729745ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731605660; x=1732210460;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DJUKrvhRKu5cg87uHKK2PRa/3maDazrpIE2gT9RJ4I=;
        b=xMkOiFXTq6FvioolgZWVIZXQlAFYltn+0k/5lto2DHtrnmfHhRtFxOXyd9i14CUzlM
         OSAgKXmPyFP1OasHGBx76IvnwVpO3QQuwYWLEudqMQ84a/CbyK39fmO9p4HNDAH/t/w2
         5aB5ViLOng+NgjGds2GHb44powKOIrVZaR+LqyGRXVqDTh7zjG6LM31bnuEbugGiPanb
         gOkuev3NpD3ysp7Bw++yIRSzCa757gA/DfoBIp6YnPPj4kiV8nfeOBU4XjXkzAth4vYt
         L72B11C6iK2hUF3W+V7tsDui4+Z0ij2pS/Ugo+kwpiTjWkIbk9P4K+vg2bL62qPCBvAF
         DLow==
X-Forwarded-Encrypted: i=1; AJvYcCXvG/SxTMoU6g5LBkF/9MdDgQTBBznRuKwlT2Vvzq9PnwhDQMTNa30xiKJbEl2TnS0sipcqzILiG/s/q6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcvbU7/00N3yfiV34X4+SAqMKFDt04rRXDljhc0ouum+oarLc
	r+/Rwm1elYwo/SlG1Yx6aHnLC/eESuSHiip1HFPSo0ZJHjVQBsZQ
X-Google-Smtp-Source: AGHT+IHXmGAQDxMeA+kS5h9Cz3SB14qa7ht1GOFFAlHeNUrwAxWgEMUhnhazLiQDSPEpzX+af4Zr5w==
X-Received: by 2002:a05:6e02:1541:b0:3a6:af20:944c with SMTP id e9e14a558f8ab-3a7156f9c8dmr78881405ab.9.1731605660500;
        Thu, 14 Nov 2024 09:34:20 -0800 (PST)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e02fd167a7sm359968173.106.2024.11.14.09.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:34:19 -0800 (PST)
Date: Thu, 14 Nov 2024 11:34:18 -0600
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: Zhao Mengmeng <zhaomzhao@126.com>, zhaomengmeng@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Replace hardcoding with macro and minor
 typo fix
Message-ID: <20241114173418.GA4643@maniforge>
References: <20241113025908.306936-1-zhaomzhao@126.com>
 <ZzYvf2L3rlmjuKzh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YNjSbQfq0mdQkgeI"
Content-Disposition: inline
In-Reply-To: <ZzYvf2L3rlmjuKzh@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--YNjSbQfq0mdQkgeI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 07:12:31AM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Wed, Nov 13, 2024 at 10:59:08AM +0800, Zhao Mengmeng wrote:
> > From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> >=20
> > 1. replace hardcoding with SCX_KF_UNLOCKED.
> > 2. scx_next_task_picked() has been replaced with siwtch_class().
> > 3. minor typo fixes.
> >=20
> > Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> > ---
> >  kernel/sched/ext.c             | 6 +++---
> >  tools/sched_ext/scx_qmap.bpf.c | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 1b1c33f12dd7..832f77d1d318 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -2759,10 +2759,10 @@ static int balance_one(struct rq *rq, struct ta=
sk_struct *prev)
> >  		 * If the previous sched_class for the current CPU was not SCX,
> >  		 * notify the BPF scheduler that it again has control of the
> >  		 * core. This callback complements ->cpu_release(), which is
> > -		 * emitted in scx_next_task_picked().
> > +		 * emitted in switch_class().
> >  		 */
> >  		if (SCX_HAS_OP(cpu_acquire))
> > -			SCX_CALL_OP(0, cpu_acquire, cpu_of(rq), NULL);
> > +			SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_acquire, cpu_of(rq), NULL);
>=20
> I think this is actually a bug. David, shouldn't this be SCX_KF_REST?

Yes, good catch. We're holding the rq lock so SCX_KF_UNLOCKED isn't safe. I
agree this should be SCX_KF_REST.

Thanks,
David

--YNjSbQfq0mdQkgeI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZzY0mQAKCRBZ5LhpZcTz
ZEh8AQD+1FddaiaxpJqLHSodYb04lpcjZ6jehqY5VF/X9LavYwEAlqaWK62A9djF
Nr3FuP/JtAg786w4RkbLZCjGkWiBig8=
=nCac
-----END PGP SIGNATURE-----

--YNjSbQfq0mdQkgeI--

