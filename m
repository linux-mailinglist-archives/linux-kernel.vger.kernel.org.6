Return-Path: <linux-kernel+bounces-341821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB29886A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A025E1F2241D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773EB7405A;
	Fri, 27 Sep 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gccWDigm"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91CA524B0
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445801; cv=none; b=GcTSkNy4+cH3y3HsYhhpkxYzc5sBPwMLyJ93aBwO03jdH256y4SdfGO4LLb3cH4o3pYV5xRE1XD3G3An2KyTPquNr42Uad8Eahz0HPXrzmPC5tnVizaGBHHaUPb5fLNt00PxAELX32iSDVWSV0NRvxRZndPOFdP3AptZDYbKumo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445801; c=relaxed/simple;
	bh=N1oUxv8Fuk3s4IDXTpoWVFLeOzsWppA7l+cWR7k0zx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyHiafqcrxOcDhMkEUwdY5KAS3GvZ8WWEDepVWGjJvfV78kIycSrRWA3VaOAtn+qMjcHmoop2z7vhs9RZkDQcGXrrDbnC89aEnt6a1h2T/i+QBOOUfOaMhqbQEZCQhbW/0sv/BoNaQMthU+1Yzlx66ri0tSW1HcpWCY5xZcxsHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gccWDigm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso399812966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727445798; x=1728050598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ilDLO/w4D1h79Cn17evM3dxXJpvBxV7O0gGjs3DSJQ8=;
        b=gccWDigmqpsfm1uQ/MbzwtfKY8dm0FEho1VWvV1Esiul9c88R+hVfFYGZhGdPUa1ZM
         rKwZAWw8t1hwheB9+umwVahTlIhoxuIEXi3TKrsE/s5a4fBd956GzbyhiliyP262EjAt
         ohU1Nknaw6Oo5igMaU6kIkgGexAhsJdB2+Fa2AZ4b6lb4U8mPo1UBMsYSA/mgKwm/CcS
         PRuPIH743vbMO/UyKrlgSBFEKhtzT17ZX0sBEw3smWr2QO1QodYtND3twQrHjFvYC9vt
         jl/xfakIwDq89haG8xrPbdOP40l+IEqn8+dvNY38D03RmrzcJzRNGxy5VcXsyDaoQ5rt
         Ds9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727445798; x=1728050598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilDLO/w4D1h79Cn17evM3dxXJpvBxV7O0gGjs3DSJQ8=;
        b=WSEolH562HA9Zq72tZ4C7CLRt47eASUwYWKg+J5xRln1rMqYjfCHZ4VCKZ5f8hVmuU
         WD5RmuQPO2+KAFOmqVXobnURKAgxxQPhvAkAZwxHJ1cEiCPVn1Q83gFf/xBdDcjrQibE
         KI02djIzL4+Zk2gtwTw2wtKxH0uoDdARTGo6n/ONDsgPTKnQRv8Znl7YLkjgiEyZmNLM
         gbxlN0c7Z35v++bw1szPZB0M1TCspCxo1tZQ9UY2KZn69Ih86Q1zHoC+8NiFm4AiUeQh
         6vjfKcmaX7a2/+MukeG7GAoXosXq8phe1WLqGLbpamjPXSAX9CUU/eFHVwWWqBhS811f
         nPAg==
X-Forwarded-Encrypted: i=1; AJvYcCXc48gTEH+if6vl8lSvjmhbPNuORWtR8qSGu7lPrcquSKsOdEZ6EJ1pxd9TEaIjKXmiAzjtlEOA5FQfhUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnweBl7ijZPZ6XAhNyCTccGhX+Ke7svDDDQcuuN+gRXiYHppvk
	A98rvjHqXX14pRo09WR9XCbXW/Zsxp4WNXf9XR8yOjKA4hruOXavhrQxlZM/CRQ=
X-Google-Smtp-Source: AGHT+IGJWFabzttSmxlbnN3217JwN5XTx6TiZkmS2MiGqhdVgMpiuAoCSBT/PTjmO4pkV0kxJDkarA==
X-Received: by 2002:a17:907:3faa:b0:a90:1f60:7b2d with SMTP id a640c23a62f3a-a93c2b9cd79mr421037766b.0.1727445796377;
        Fri, 27 Sep 2024 07:03:16 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c29991adsm136930566b.214.2024.09.27.07.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:03:15 -0700 (PDT)
Date: Fri, 27 Sep 2024 16:03:14 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Chen Ridong <chenridong@huawei.com>, tj@kernel.org, 
	cgroups@vger.kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Boqun Feng <boqun.feng@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
Message-ID: <3syvchv2pryjtqrwjeyfddhfzcmgnkv7znq7fv6tt75cysg6fn@ee2m3svbqr6x>
References: <20240817093334.6062-1-chenridong@huawei.com>
 <20240817093334.6062-2-chenridong@huawei.com>
 <20240911111542.2781-1-hdanton@sina.com>
 <20240927112516.1136-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cdhtwavnjy3c7mbm"
Content-Disposition: inline
In-Reply-To: <20240927112516.1136-1-hdanton@sina.com>


--cdhtwavnjy3c7mbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2024 at 07:25:16PM GMT, Hillf Danton <hdanton@sina.com> wrote:
> > Or if the negation is correct, why do you mean that processed work item
> > is _not_ preventing thread T from running (in the case I left quoted
> > above)?
> >
> If N (N > 1) cgroup work items are queued before one cpu hotplug work, then
> 1) workqueue worker1 dequeues cgroup work1 and executes it,
> 2) worker1 goes off cpu and falls in nap because of failure of acquiring
> cgroup_mutex,
> 3) worker2 starts processing cgroup work2 and repeats 1) and 2),
> 4) after N sleepers, workerN+1 dequeus the hotplug work and executes it
> and completes finally.

My picture of putting everything under one system_wq worker was a bit
clumsy. I see how other workers can help out with processing the queue,
that's where then N >= WQ_DFL_ACTIVE comes into play, then this gets
stuck(?). [1]

IOW, if N < WQ_DFL_ACTIVE, the mutex waiters in the queue are harmless.

> Clear lad?

I hope, thanks!

Michal

[1] I don't see a trivial way how to modify lockdep to catch this
    (besides taking wq saturation into account it would also need to
    propagate some info across complete->wait_for_completion).


--cdhtwavnjy3c7mbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZva7IAAKCRAt3Wney77B
Sd2mAQCxOrw2I8bsq5+HUt8cg8qakt97WeglQHMG9ceCXW2LDgEAxCnLeSko2OVY
tg7Ga1Z4DzB/tAkefAhq9FpE/8CSmQ8=
=mf9o
-----END PGP SIGNATURE-----

--cdhtwavnjy3c7mbm--

