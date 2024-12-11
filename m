Return-Path: <linux-kernel+bounces-441439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5CD9ECE64
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231091881B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0303913B5AE;
	Wed, 11 Dec 2024 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L+k8UZQL"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F5246323
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926601; cv=none; b=U/yN6WtNnuWxr/pKn/rIhnUF6m9pM/Eun+iv4xQljSvUI0xS1OxWCG1c+Dujam8JsuS0KZHnszh28Z7GjjY5AjBruy0mJ2RW8jug/jQ8g73wCUsBcRQMKEMBzzqPDATp8kNCjF1ABCvUwnY/Iml5FTNrCewMhOjh0wDmVFzbbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926601; c=relaxed/simple;
	bh=j11plmX3WljnrzSD5dzfw1Y7R5TTWgy0hvsNq/eMpbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFkJs3POa6ysYLZ470MIo3Kg6UCnV3k2pQXMFTs7F6F1BNn7Yqetdh/w41ZqGBfcgJ8vM3dp1LazTM0W1+rlbpkrhk/AKkrcy1uqSzF+cjkjx48WRyu3wdY7tkwbPbe6PpNc7ncs5vBxe4R9EpnJ7S2ffmGBykF1j7g9Wz+C3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L+k8UZQL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso64883275e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733926597; x=1734531397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/l/71lnxq84rwPfCjk4CleHCDjjJZQ5hvEmCc3YESzE=;
        b=L+k8UZQLxHfDU2hYWDKbViYAD1QnOUZRcDCSuW9+/tyrugSACen5dCE1ozQ2DOYdPw
         Yz2KtwG7FmZWvIzNiFel7kA4QcsvcK8AspGXvFnlFphy2MRUcV+zYnPvlrZVuTdAW2gH
         iE29fOGeRQtniOlNFke7zkgcX4QgLZJ9sykBsNRQKGlQPHV1CwjuqzvKsUE8LLOcNVJ0
         z74eEA1oZum1CaF2/XAhljSL2yLamW62Z6o+yd4QS/nwKjcHmbBiKfxehQbLgEOmxpv5
         avrg2wnugu+xT7CsfDtM2E9UkgpBaHcMSC8RiFUxALwNIuCxHx+iZSmZvQaRUVpy/ws7
         CewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733926597; x=1734531397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l/71lnxq84rwPfCjk4CleHCDjjJZQ5hvEmCc3YESzE=;
        b=l8/Icr+Ju9EfBormAPK79dd5MMBkKHLA+cTKnx1a9nOsX4OXSPKT3R6KBpOmexUJ4e
         k8ye7clyue66zrMcM48NMTKAJq8vGrg7cIau5GMrpQvIN4dVuCokzroBglK0aTkS2xvx
         VksHaDSRhYtHAstFQNgAuxYMRqUTsiI/oSBpvtjQh7SVXi7F6RXzYrIrO5mkWMCTikT0
         EpWTxnPtOXZsqELZ3xNnHCbHg7RHzsxv1KTU77w3EdJNoBt7Az5esxsPP96+fUOvXDdP
         mZE1JqwjsiucBWNmX94oUOv8ME2DO8OwJM+9jQdCGUN51dgXEKs5rrKf9EAL+6tRtWhG
         0UaA==
X-Forwarded-Encrypted: i=1; AJvYcCVatHYBZ+J2osRdcF6+gwCrJA+G+zrSJvxCt0+y+sCNsDh4tyS23R+m+5eDimIImD+jj4Q4cbqgjzdutTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGtylo37chZ8aLcKCW+zOy6aDiHneHgJQqNz2EDQIwldSmPQe
	oJbguzTZ/Jy6KHCMCH85W8+V5Y3DfOLeL+aTva92442OjU0DsUqStb/YT5YKmP4=
X-Gm-Gg: ASbGncucaCdDcoCWZACz+jqBR2yH6yUYoe2x1LQL/IWMbQMG4d+HEkqv6TW4K1j69k0
	aL+/7bIkiR8g4qlP7YPJ1Drs3Mu2AjYPnuamlTZ/qMIk4HP0JrGHiAvgvavWh2HzEvhD6NEYdrL
	OMyTAPy4/Nwde/n66nn0Xce8VFydIbmNJu0t5Td0p85BJc+WemUoqdXQXPFc4Lx/wZ3CazdVIgv
	CgEpMqis0wNYC4Bfwh4CYPoGC1NWL5wtc68gx0zpHSjlKooW0hmpT9+
X-Google-Smtp-Source: AGHT+IHqBGbbZfDgcN/VSufV0Qew7KbtVtXU3aUoVJRPvdFkH+JA95EBHVD3u0UzOE8oeq1MFI166Q==
X-Received: by 2002:a05:6000:1545:b0:385:eb85:f111 with SMTP id ffacd0b85a97d-3864ce901bfmr2546503f8f.14.1733926596785;
        Wed, 11 Dec 2024 06:16:36 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824bd45esm1407673f8f.43.2024.12.11.06.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 06:16:36 -0800 (PST)
Date: Wed, 11 Dec 2024 15:16:34 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, hannes@cmpxchg.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <bfvyt34exutgxu7ctow4llzpdttk6rhwrom62ppvr6rvp6ehre@uyu2sjyidssi>
References: <20241211131729.43996-1-laoar.shao@gmail.com>
 <20241211131729.43996-4-laoar.shao@gmail.com>
 <wvqotmnk2kad3lyigbsc5vtq4ymdtaxqcjijaj2f5mdcp6m742@ltmazfge3eu4>
 <CALOAHbB_i9rpG03FVKE5gyue0hpM-gE5V=X2gcjTXHjP2yNTGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hlvkpzrcvalk6dhl"
Content-Disposition: inline
In-Reply-To: <CALOAHbB_i9rpG03FVKE5gyue0hpM-gE5V=X2gcjTXHjP2yNTGA@mail.gmail.com>


--hlvkpzrcvalk6dhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 10:07:41PM GMT, Yafang Shao <laoar.shao@gmail.com> =
wrote:
> My apologies, I'll fix it in the next version. How about the following
> change instead?
>=20
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7341d33d9118..263c26a36511 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1233,6 +1233,9 @@ int psi_show(struct seq_file *m, struct
> psi_group *group, enum psi_res res)
>         if (static_branch_likely(&psi_disabled))
>                 return -EOPNOTSUPP;
>=20
> +       if (!irqtime_enabled() && res =3D=3D PSI_IRQ)
> +               return -EOPNOTSUPP;
> +
>         /* Update averages before reporting them */
>         mutex_lock(&group->avgs_lock);
>         now =3D sched_clock();

That looks correct.

Michal

--hlvkpzrcvalk6dhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ1mevwAKCRAt3Wney77B
SQ5iAQD9kfXwtAw5XVF/N5ZaIvnmStu+6/o5q50ktwPbAEK65gEA3aEuuwKum8Nh
47ZwipR4WDvR8cCr2bpg+CXPI/QVEgw=
=t1Qy
-----END PGP SIGNATURE-----

--hlvkpzrcvalk6dhl--

