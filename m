Return-Path: <linux-kernel+bounces-425425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B52679DC1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E5E163254
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7823181B8D;
	Fri, 29 Nov 2024 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BxWzYHYC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A714C5B0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874563; cv=none; b=XRo26I0FhRyJapE7dRYGHfNhGxgdhRlQ8eZ0leuSYI+Hu1a8IAGMKo4s9hBGLQTY2BL876jybIfFbKXK//GRsI3OcgF1su4n7F5YbIhk2KJMqvdhKPlBRvsHKNuU7Lu5kIjsHXA2wZ9DgRpaYpSQ/u7zO+QmTOxy563v66XiNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874563; c=relaxed/simple;
	bh=sp+zLP2CBFohJT9cPOrrEqwrt5dmPGet0gbGsPWt9kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sz2mXN9gR2Eu8gJyoiD7GJcQ4mOcxCU9egQ4J0+YTYKUoPo0H21Bc3qII/K3+OMN+1h1B1/K8tlKzqFAZEljGGhjDHPYkrGQbRHbtxlcpTNxjWJwmaNI1HZWQ8ikfkx2P6FG1mSdMJ+nMEQJ1SAfuxOuF80wsC8V6XlO8TNhlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BxWzYHYC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so15323095e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732874558; x=1733479358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAJBAXOB1YG7NDxO7OMsPhgAc+X+arS87/h0UJdXVjw=;
        b=BxWzYHYC8a3bplgiCcoaK/1+iY718mcbO1lv55n/W6OTzRupJ0Ov4auQ/q8AYqIBqF
         dLkbp0DhV9wKOA4zxVzm6CvQNbkfM0x6MflKim9kGa5/wKCfwbkQICT63eX9rbHI+Djl
         cn85b3OUNWs8BYvBo+bESazbOlcv80GFe3jAK9NR68b3QTwPAP47jspu4P/OgmvN2ZQL
         FyLvTCnVH8VHKYDbwfnkKuhFbPofyOF1RjNpJ1chNZvq1hrB2tNoUfH9os46kgfyWQ+j
         cR3MsFVklYsxUkXcqSFHFfiL/4ujk3gt3gFdYn1DQkuJXdH4dGu5el9/fALhqZkhRbJO
         SxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732874558; x=1733479358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAJBAXOB1YG7NDxO7OMsPhgAc+X+arS87/h0UJdXVjw=;
        b=g6l6A/sa4gkXqSZEv8mgykgBdLZ7GPa9DDZ4tbfD1CePEE5DX/sSvhEVvMzmqR1mEv
         BxV67OV771ITrlLcRq2ChkFsoG1f9CN9mCNgsxEfeclhPnSYZ5ziLJmeOvVyLC4V5OhZ
         FRkvF3WYlU44TtdAEnOCsTJLx1o2QBbCCcGIkKz5TVTzZmY66JUP6C9AdaCwWgUEBM52
         xfB7KAfaWKBnRUG5Frw/KubhMMmg0cdcn3KP86v67i7r+WeLxAqXVWwnk3ayu5EbUKvf
         i+OjAH65v1mZgYlkPM7f4tk18vWUfLfe1bICNA99OeNSKTg1Ic7tyjUqEH6cwr7hU50T
         lyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcUkIcsOrCT9qxEywMz9zISDU4vEvkgF3ldkZv3gKUFa7tjj9+N2leOgfl8KiuEHB4qVqcKub47PMenuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmbbDnuOJxiNEtskQ4vLcZ+JwPCMMh7FRSwQeUQAxZVcTFsNuX
	IXQ2iNcyiXa8D2xSLSEyXiAF4K7s0mBVL44z0DIrVpPa/9w5MtTRY6SejG0D0+8=
X-Gm-Gg: ASbGncvOdy6oNlMgpc3bzmjPZ7oGcJxBjXePd2TZKV2e6I9elhwXIpZ88xl9HiYStAN
	JcFAFJUcLzYzurP1WgrKL7zzzY471Y0Drj9ppalOTlk42s/rP/39hsQE1lL4ZrGcbd0QeoP2dUd
	RdsuF81tgIWF2NPQeIMhYG4/f6II5kkkQ/seFsymJVfhKPCYJewien+0SwVta+I6Uzbm6nY/CAV
	ys79unztiSbNFIT2Fs9UaGb/K8pzahTa2Cr+ifjQKJ+YyySQmgs
X-Google-Smtp-Source: AGHT+IGHQRXBudKk9UKWVPtrmOTuTpSdu4am9KJ1Nrf0na5K5YKj9IuJKngLkUwt87RR0SMyIHHP0Q==
X-Received: by 2002:a05:600c:54c7:b0:434:ba13:e52b with SMTP id 5b1f17b1804b1-434ba13e7d8mr14220115e9.31.1732874558417;
        Fri, 29 Nov 2024 02:02:38 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36919sm3997438f8f.39.2024.11.29.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 02:02:38 -0800 (PST)
Date: Fri, 29 Nov 2024 11:02:36 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>, 
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Thomas Gleixner <tglx@linutronix.de>, 
	Joel Fernandes <joel@joelfernandes.org>, Vineeth Pillai <vineeth@bitbyteword.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>, 
	Suleiman Souhlal <suleiman@google.com>, Youssef Esmat <youssefesmat@google.com>
Subject: Re: [PATCH V7 9/9] sched/rt: Remove default bandwidth control
Message-ID: <tjsas6vkv3xegcgmranxmnkrt46xuitp553caz6vvtgpfrbwl3@252nbydvxaqt>
References: <cover.1716811043.git.bristot@kernel.org>
 <14d562db55df5c3c780d91940743acb166895ef7.1716811044.git.bristot@kernel.org>
 <d3bllrfwji74t3ix3jcdlvdt6jdorw75wjol6kmadpeuuqal2t@io7ghgf7zkbs>
 <Z0c8S8i3qt7SEU14@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t37gyouyghhpnzgj"
Content-Disposition: inline
In-Reply-To: <Z0c8S8i3qt7SEU14@jlelli-thinkpadt14gen4.remote.csb>


--t37gyouyghhpnzgj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 04:35:39PM GMT, Juri Lelli <juri.lelli@redhat.com> =
wrote:
> > The default DL bandwidth is thus is 95%. The fair server is given 5%.
> > Is that 5% of those 95%?
>=20
> Yes, it is indeed.

Thanks for navigating me. I have followup questions about
/proc/sys/kernel/sched_rt_runtime_us / /proc/sys/kernel/sched_rt_period_us
(a ratio, without CONGIG_RT_GROUP_SCHED)

- 0
  - disables DL, (not RT, so they can monopolize a CPU)
- 1
  - DL tasks can monopolize CPU, SCHED_NORMAL have 5% thanks to
    fair_server
- 1-=CE=94
  - SCHED_NORMAL tasks have
    - (1-=CE=94)*5% on behalf of DL (above RT)
    - =CE=94 regularly (below RT)

Is this breakdown correct?
I'm wondering if different values of =CE=94 mean anything or how they can be
used.

Regards,
Michal

--t37gyouyghhpnzgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ0mRKAAKCRAt3Wney77B
SSC+AQDOKrZ13w1tQ31c0xTmRLDs/Jl3+tSQ2VNg7Xm5HLFGjQD+PArbaYKrBd04
e28dbxnJ0aIaN9+FKC8ZWkTjVeLvqwU=
=waSH
-----END PGP SIGNATURE-----

--t37gyouyghhpnzgj--

