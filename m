Return-Path: <linux-kernel+bounces-275089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE94948088
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A80B229D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5393E15F3F9;
	Mon,  5 Aug 2024 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPAuuqjN"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247A15ECFB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879550; cv=none; b=cpTjZFDVWUNRcQ5PSDF7GpJivKu7SD/W/ofESrFOqBTl6r9NWT2vcQVhflDujl2d7lXC8yM+Tr9APo3j2rgqZTnLmGq9wvEtnWgWqn+uhj8GwOT6ydWGATHpEBCcJvkI1++/Air286DaQx8X5b2TrJCC9ElzzOpgX+fqeAXEYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879550; c=relaxed/simple;
	bh=zy0gxfVbeGgyDryolUgYwiLH7uSgtjsvr/ukfic9ehs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjNbeNUFBFY8Z7UuQY2TLaaNWI2j2fseh+8tzC528NrKXUD7plqLeNdD9ydrlji5tJbwGXi5fN0R5n2GWc06uhDCsQbjQYv6zrImk5srzFHALqT5oSNeMkm20tZIY3HdkqD+3NFxJMK4APD47aCPbRJ3OjnrtGtLHNpmZ9mjsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPAuuqjN; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db1657c0fdso6819778b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722879548; x=1723484348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7oWqqOxuMMzqDAp8bmvsML2FFXRTUg/BYx7miwMuizU=;
        b=HPAuuqjNG8uJio0dLeDwrPuJ2KjYyPZb0IXwXC+Tppc4NJgAzSw+Ngs7bPdP2YpWjR
         oPuJ5OlOvklrkD8fjuzk5d94xugzXHBoTPKxpivfSSMJyykLgx4W5ydL42Z77WyT3GPl
         N0kwufpvg3RYdRnmgX0MFZa03BhcgoRmmCXQiiURJWdboUdvxbigbn6ZgmDu5gWtKBg9
         XTpf3IyWnFK8HjqvDZbgpCKeF0IaOiN2n/7ykMjirnmuX9tZ+QCEQVP42McM2esMk9OG
         Rj8nQsFoHxs7rB7NQONzTA/bclvC3pZIOrpVABp7Lpqt4S5yeap6xq+CIjyJ2yu13qMC
         gQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879548; x=1723484348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oWqqOxuMMzqDAp8bmvsML2FFXRTUg/BYx7miwMuizU=;
        b=LZx98asCPGMT2jrsFSEkrcnGpyBNf2vYREQUjT6ujQSMHvs3DuZb+SxwhKmPygTWxl
         vHOttTiF7qErD/wncWpig4XkQ8YfS/pFjm7cEQG/fujMYr3nGD5BJw2Du65QNhAGUBAe
         9TG9YBv3gW7Gj8hrZ5F1nt8G0zxCIOmwWjzVK9cKXw8gfdXoD0k1cFAkzIXtGcg98wJG
         Jkq9vOdZMHA9N+ZS8aBtXLAvhW83X7OgjzDajRJLLLOY0cNwsiTQyljSG+X6XxXj0fmZ
         JjyG4/Vg69D8tw9pCyHwW7orl1UbUQ442BkH06pAdlsGNbVzqkgiQLLf7ZKlhELStCGX
         0l+A==
X-Forwarded-Encrypted: i=1; AJvYcCU7sFG1odTnq65YHAKP8rAwfEHSNrjNP8F+sofcH2pRVUdvzLPRbUljVas0PsxPrqbA/bAaVszwWJJ/N79CHviGQg7sB29oaShjLSE5
X-Gm-Message-State: AOJu0YyvO9S8k73FhPoxqSK3QLpX9yEwRQO3S8xukpt88OnUB5BX3H1+
	mM+8LGS4pQ9nAnEsYLDLqTRshHaxxSzV2VMOVz6Fqqej6wDdEehY
X-Google-Smtp-Source: AGHT+IHBtOjacMBEh0wJlo+n2hJVaZO9gHfcEq00FS9qgxJYbFJuMBhs5Bk+kBoAcwHIJuzApyCTlQ==
X-Received: by 2002:a05:6808:148b:b0:3d9:e0b3:6d1d with SMTP id 5614622812f47-3db55849312mr15456665b6e.51.1722879548058;
        Mon, 05 Aug 2024 10:39:08 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a75803esm31179721cf.64.2024.08.05.10.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:39:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 2DEF9120006A;
	Mon,  5 Aug 2024 13:39:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 13:39:07 -0400
X-ME-Sender: <xms:Ow6xZpaQdVlS7472o2MEptL5Ri63USsz4j4Rj4aeRV4jhPzQe8WZJw>
    <xme:Ow6xZgZwM12YTfD5brDCV8Q-puUn-zLAjdfCd0JP-CSG6RkegdtCbT9ATKLY2-Bp0
    W_Z_RkiZBbtEAeOag>
X-ME-Received: <xmr:Ow6xZr9udFa6jrUepsvXeRJV9ZrC3H_ieVWlv_oJDLw2VSk6uwW5PYp1TWfu8VqsAhnOeF-NnK_eTSQQ7N1Dg6jDq860jtfN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvdefgffgieejleetueettdeiieegledtvedvgedvjeefieevgeethedt
    veelueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:Ow6xZnotCmpeFJAEZtSMqm28LhpooUphpwHKwIlFPvyXUcPr-NWH3g>
    <xmx:Ow6xZkq97D-r36hltoWFPpBWqqr62yWMxg8DV2ZL3HE1H8zK_MKhzA>
    <xmx:Ow6xZtSw-xbZEwu4rEzfVF5-lZ4MCIoL98CJ4hIlA08_Wm0i2vn5qg>
    <xmx:Ow6xZspTFjiE7hPDb2y1Y274kTc87Neiazm2NNGTQTGzUIE76QyIGQ>
    <xmx:Ow6xZt71sWMKLnjPlFqQx3XeK5sjj3PZOQCfc_tmTxkzCdvWVkmFmEgv>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 13:39:06 -0400 (EDT)
Date: Mon, 5 Aug 2024 10:39:39 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: make class_filter() inline and remove
 unnecessary macros
Message-ID: <ZrEOVOA3e5Dl6l_2@tardis>
References: <20240606085744.3475629-1-haowenchao22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240606085744.3475629-1-haowenchao22@gmail.com>

On Thu, Jun 06, 2024 at 04:57:44PM +0800, Wenchao Hao wrote:
> This is just a clean code which simplify the code implement and make it
> easy to understand. No logic changed from origin implement.
>=20
> Make class_filter() inline which just return 0, and directly called from
> verbose(), very_verbose(), HARDIRQ_verbose() and SOFTIRQ_verbose() without
> macro control, remove unnecessary macros VERY_VERBOSE, HARDIRQ_VERBOSE
> and SOFTIRQ_VERBOSE.
>=20

Are you looking into using a Kconfig to control the behavior of
class_filter()? Otherwise, I find this change is not that necessary,
don't make me wrong, it's better than the current version, but still it
just changes one version of dead code into another, so doesn't bring
anything.

Regards,
BOqun

> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> ---
>  kernel/locking/lockdep.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
>=20
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3de5936..cd8356106da2 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -478,21 +478,11 @@ void lockdep_set_selftest_task(struct task_struct *=
task)
>   */
> =20
>  #define VERBOSE			0
> -#define VERY_VERBOSE		0
> =20
> -#if VERBOSE
> -# define HARDIRQ_VERBOSE	1
> -# define SOFTIRQ_VERBOSE	1
> -#else
> -# define HARDIRQ_VERBOSE	0
> -# define SOFTIRQ_VERBOSE	0
> -#endif
> -
> -#if VERBOSE || HARDIRQ_VERBOSE || SOFTIRQ_VERBOSE
>  /*
>   * Quick filtering for interesting events:
>   */
> -static int class_filter(struct lock_class *class)
> +static inline int class_filter(struct lock_class *class)
>  {
>  #if 0
>  	/* Example */
> @@ -506,14 +496,10 @@ static int class_filter(struct lock_class *class)
>  	/* Filter everything else. 1 would be to allow everything else */
>  	return 0;
>  }
> -#endif
> =20
>  static int verbose(struct lock_class *class)
>  {
> -#if VERBOSE
>  	return class_filter(class);
> -#endif
> -	return 0;
>  }
> =20
>  static void print_lockdep_off(const char *bug_msg)
> @@ -809,10 +795,7 @@ static void print_kernel_ident(void)
> =20
>  static int very_verbose(struct lock_class *class)
>  {
> -#if VERY_VERBOSE
>  	return class_filter(class);
> -#endif
> -	return 0;
>  }
> =20
>  /*
> @@ -4171,18 +4154,12 @@ void print_irqtrace_events(struct task_struct *cu=
rr)
> =20
>  static int HARDIRQ_verbose(struct lock_class *class)
>  {
> -#if HARDIRQ_VERBOSE
>  	return class_filter(class);
> -#endif
> -	return 0;
>  }
> =20
>  static int SOFTIRQ_verbose(struct lock_class *class)
>  {
> -#if SOFTIRQ_VERBOSE
>  	return class_filter(class);
> -#endif
> -	return 0;
>  }
> =20
>  static int (*state_verbose_f[])(struct lock_class *class) =3D {
> --=20
> 2.38.1
>=20

