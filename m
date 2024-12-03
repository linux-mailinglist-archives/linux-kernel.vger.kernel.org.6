Return-Path: <linux-kernel+bounces-429219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613739E18FB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18ACF166DF8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A71E0E1E;
	Tue,  3 Dec 2024 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YiyPPPMi"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81FE1B395E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220930; cv=none; b=uALD4IV3rJdkH21MZCKaA1l4ORCJqPbUAUK0hwPDwzgMSdvXERRG9NyMb1HIEv+aal33Yq9VHjrnN8uAd3CVOLn18izVlgxKGQr5Ox7QC4g2XNgoGg2CSvXtRaM/CVwqW2TZReqtVnibs03PFDQxBqlmlySVMo4LHae+hmipq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220930; c=relaxed/simple;
	bh=G0sj8PY6ADW3aET+hb+E7GMb/SqAJl8FiJH7t0gVTnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8ghP8IZ857RcCPMgrC4MjKOTt6hEGHKYjvV9OIzIQO0J2vmmg5MXNfCB5/K01qM+qUj/8AvMU54XbIYymRPMGviFwomSpn9XXHYv93oUmDwdPYUMPx04vB+92hX/L07aMRIR+lPPxXF0rCr6qKii7f/1VZixOTxJoB3bqlk76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YiyPPPMi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e5db74d3so2222545f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733220927; x=1733825727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1oL/Eu1oFnM7Lq/a9MADW9dd1D0ZuUMkh3bz7/dA41Y=;
        b=YiyPPPMiYl2teojVGTnN3euHxVo3Ei0VTzhwP3CJBRoS/pvHiMPwEbS9NzToxJ5cjG
         286vxWQmQUffhxvIpOQrpNbgAQ1QUFVh409diZRUfyRfVdYPrTSS6Ok6ML+TyxDgwjn9
         456fT9A+d6UYdGXo8Wy6zV1SYxoQxnbtntZShuiNrcVtOAFBlF2iut0IXT7mGvHztPCU
         ZIhdgKmlP8jHb+UoSMvzP+bhRYXoNlIz+SzGoJzgYLjZLnyVwXcHFyRT2iRMWsGkt45x
         JslA1LiRvzNWaK7l4iWDn9tcjnEruJS0W1beRmAfuH214LvcSTFj08wM+RpvjFUXQpyz
         ulDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220927; x=1733825727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oL/Eu1oFnM7Lq/a9MADW9dd1D0ZuUMkh3bz7/dA41Y=;
        b=t6afUf4HVtnYwmhGfq2BqMKx3F79haP7D+F8xhqPM1dKrACVCAe1g0ugoXTJmyhCJu
         WqXxpXtFypan7A+idpatRpkWhRQRrf81breD4GlcwkuN5dSirND+lio/ClbmX3nW2r++
         la//SWo1d9msoG43kqQZkm5eLkn3VVJXSTGXd8W5rXBbmbZjTKGLY7snSSXHXEw9zj5v
         zxVnj0t/dcnkpJB6B+cC05l2HGEU75HKUsLd0HSoJuRKRaqArDiSIDxGzZYYFl9gu810
         EjLqRkUlAdxiAfap8a1f1+q0x3gpHjPnX3JAhaq0RriHUoIDmPlXbtLeclKVUtMVneSB
         1OpA==
X-Forwarded-Encrypted: i=1; AJvYcCXjHlOrPfQMgYCMPxzrBHwsDb0v4XohlSJV2Waoev3b4tK9YWeg1+Er5qqxzgf4E4ToWaN8uK2kBUo4dkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPuLdQXISg8d8pLXbc88y7BFTuJMjd2aX94VsM/4CiUJfmGDkr
	6BXvy9FGuuBt892Nsd+aWPqWlu1K3Niq/Tq51ParLTDWpfPwolzAWt/AYcR/pyU=
X-Gm-Gg: ASbGnctadknKw0lkbypU/POr79dKzXkyUqQa5mqsGv3ECwYq3bBCP6udVJ1OqWBz4ua
	ELFw4YTYJRkTf4Hti06sLi+9Uvpup8lVacLioyADXl8gnKPAQapc9fTG0pLNtVEdtkhWhRXYxzZ
	F7NDtVqmxneno/RfY4v7uK3VvaXNLPBSENP0z7ICSwmaNAzWhfeAp7iNVVu21aY+1JAgb2dcIE9
	p4z+AVuKPhu3be5MRUJOjKC5n7KpsrnBTL4+8w00pKB3muKRM7T
X-Google-Smtp-Source: AGHT+IGP+wf/uT+o8vDXMwC1hvUzbUJpXqnj3ziNpYlS/jQFsv7zchrVLXRh0KKHa1usVlCFg2O3Cw==
X-Received: by 2002:a05:6000:78d:b0:385:fd26:f6e0 with SMTP id ffacd0b85a97d-385fd3cd5c6mr1704607f8f.18.1733220927155;
        Tue, 03 Dec 2024 02:15:27 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d25c5sm214564325e9.28.2024.12.03.02.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:15:26 -0800 (PST)
Date: Tue, 3 Dec 2024 11:15:24 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <ghu7irmizgbyso5hjemwsgscfoigdtzufpfckxkvdqibeo63uo@kvzncpy2rlit>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
 <20241108132904.6932-4-laoar.shao@gmail.com>
 <7pad3qmmmy2hgr5yqwwytj3wyjm3d5ebbqy4ix6boxkd34fc7c@ebdjg75tfgiq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="efb3qc5jht7fzdid"
Content-Disposition: inline
In-Reply-To: <7pad3qmmmy2hgr5yqwwytj3wyjm3d5ebbqy4ix6boxkd34fc7c@ebdjg75tfgiq>


--efb3qc5jht7fzdid
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 11:01:41AM GMT, Michal Koutn=FD <mkoutny@suse.com> =
wrote:
> On Fri, Nov 08, 2024 at 09:29:03PM GMT, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> > sched_clock_irqtime may be disabled due to the clock source. When disab=
led,
> > irq_time_read() won't change over time, so there is nothing to account.=
 We
> > can save iterating the whole hierarchy on every tick and context switch.
> >=20
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  kernel/sched/psi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

On second thought, similar guard may be useful in psi_show() too. Since
there's a difference between zero pressure and unmeasured pressure (it'd
fail with EOPNOTSUPP).

(How common is it actually that tsc_init fails?)

Michal

--efb3qc5jht7fzdid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ07aOgAKCRAt3Wney77B
SQp6AQDCofeL+RYVr6OoZ5Ku/ryrsGjAU/xUYeRLREz6RNOLswD+Mqy1fxDBv3bL
jyX2QbOi3rrBurYl8eDsySO0VMuwIwk=
=B8Jh
-----END PGP SIGNATURE-----

--efb3qc5jht7fzdid--

