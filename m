Return-Path: <linux-kernel+bounces-429443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C99E1CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33BBDB2C2B3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DAC1E1C33;
	Tue,  3 Dec 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nbzs8tuH"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D391E377C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229106; cv=none; b=Q8wynu8s3PEvnfhKIniakRYIOORbRW39eWFAggsiY4DfHXDefo+SS5a9ZQ6bHuCyYLUmyu/L8WeUrgd1/x+lbu9hNRgiBbL+XkNEo0y16r7IwDZ168q8PQe/F1Kx2j6p14UqkL5Gp1WC2oT8BAV6obMbj+lTkbikgoKXvPUJJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229106; c=relaxed/simple;
	bh=71RVm4jnhzuql2pIE4eBzII2aWtBSSvxUgiJT7K0d4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNcy+Zet61mJE/jnp+gcTUPmmLYFzPnMh3GRsbhdgeBDOHO5H01Y+GTcsq86T/IDdNs+0Vcyipo63AyaJ7PvkOjbs0nB98jqanx4zbQ4LFr7KSAs5AT5KniiZUoJt6sSBdDmOuq4JCbu8OyeQhRvi9dgbLH9WPtLxLLqIQopUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nbzs8tuH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so44650015e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733229103; x=1733833903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=71RVm4jnhzuql2pIE4eBzII2aWtBSSvxUgiJT7K0d4Q=;
        b=Nbzs8tuHcUpJyVR372BeKfO+33GwJoCkxnzWYJTdtvF03Ohps1HPF3eCECgiqdEav+
         wjL70BO8+P2UB9svQS0nyQEIxIVnWl8p2538o6Eu40W6XsaIuQZncw7Q44Z8iVhR0mR+
         MrZLn0ja3XEUqxduxPmRP3Za0SfUdPxIK+AHgD+wTiQEGdVMIc1m67fLUt2fCesjl1HJ
         6ha+eR7Kyt3E18FteIh3uevkVuSIFribh0ckgh7bFiN8uMzPfDDtNzbUfrZLqUw9AjL0
         USYDuBbeq9vZuUOC61ovcWLmDi6e2fovESHhL135wwP0731Z6wPF4ShhtsIgIX/BjF53
         1ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733229103; x=1733833903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71RVm4jnhzuql2pIE4eBzII2aWtBSSvxUgiJT7K0d4Q=;
        b=J9+byv+jLgNPE9Wp/nzoLF41QjRr1T51NjSHjbfG469wUKImDMQAgzOfgetFGoADIS
         Gb1qEgPpSpXU/yTDrddCawTtIYnsWULnmU/smS89SLlU1DXKVo+KYHmNXyYH146VuHZu
         hmGHwvIxkBKmipLbP2wzjhtx6RJGD63ZfO/cjx9dMSRu0VlcXxgNRbGeGZ5qzsxZopyW
         nqBeAzVaoG1IPMOK3E4SyEJNZdL8ho/Yj5356WHXUuJxMImuC/pQrmhCbsmbFgSfO4Zg
         +EnqJ0dUja1QsLFUCoc62hWvhdtwF2N+etq7De43dGzk8a/USr2ARplzk+4h0H+3rSov
         PyXA==
X-Forwarded-Encrypted: i=1; AJvYcCUdUYBNJRN2SBsTLbfvIwS8RJb672Nho5NJF6ULqmj92haH17ayYoNwRlWkDgZwnRALf5ep5OxB3/AdNEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7rlkr8d1ewbrwYKa6m7BALF3kIvWLBn+w0mBrRn2cNNb5GJsH
	CsZ4b/lbH7bS5fncIiGXrOtg3TUHLNnFkc8tV5R/OlYWfJFsggfLpiOajKQt2ck=
X-Gm-Gg: ASbGnctn/ROKQCsRVq4kA9lF66bXkI4i0d2WPFv4A6NyA1GNBqQs8jZa195Wz89lsgA
	z8hnuE7cat6heGWGJMHeS5ZkZ02fepkbFgijt4NaPOhZAtWa0DKDOQqkJmjq4aEH6jpEBLtlrx4
	0CyBectOD7bYWdYC8HUxHyc0dukyXZPY6LBftakunrTpHZCXa/1j69Xu7bX3jE6eQHAVmw3k+1H
	+5rNK7GarpaYKppi3kUs9znIVPvFWn3bUcP12Ew+mkPUVDBZ2yn
X-Google-Smtp-Source: AGHT+IHUGEnXul1z6h01353jiiorSwSKWZVta/CMetAn5st8zarQxCzltNJHvFkgNKq/TTMW29B7ww==
X-Received: by 2002:a05:600c:3502:b0:434:a902:415b with SMTP id 5b1f17b1804b1-434d09b647cmr23796755e9.10.1733229102878;
        Tue, 03 Dec 2024 04:31:42 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm185474395e9.15.2024.12.03.04.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:31:42 -0800 (PST)
Date: Tue, 3 Dec 2024 13:31:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Remove stale text
Message-ID: <6scvm7d7pcwtgo3gqu6jxf6ht6qcr2rnmmdwnhpopkd44gayej@ussah6oaxssn>
References: <20241203095414.164750-2-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hlz2riwuijrgz4t6"
Content-Disposition: inline
In-Reply-To: <20241203095414.164750-2-costa.shul@redhat.com>


--hlz2riwuijrgz4t6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Tue, Dec 03, 2024 at 11:54:13AM GMT, Costa Shulyupin <costa.shul@redhat.com> wrote:
> Remove stale text:
> 'See "The task_lock() exception", at the end of this comment.'
> and reformat.

It seems you've read through the comments recently.
Do you have more up your sleeve? (It could be lumped together.)
Unless it was an accidental catch.

Thanks,
Michal

--hlz2riwuijrgz4t6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ076JwAKCRAt3Wney77B
SQ3nAQC/D8tHiSjgJUFAf/I5kkvmZ98SUWI+t+N9ynF6TFJzTwD7BzbtDxUKY3QQ
ydLSSdHdUZ4H9BGBvnIennqoYyjCwgc=
=OV8p
-----END PGP SIGNATURE-----

--hlz2riwuijrgz4t6--

