Return-Path: <linux-kernel+bounces-340477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F109873DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EF91F23235
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BCE1C6A5;
	Thu, 26 Sep 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gWSDKa2Y"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C727733
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355232; cv=none; b=VIeJmJavqTUBee17T4pOROLF96VISSjQprbGpb6zGR58qepgo2dKngtzngEMU6Nm+8shzVpp0Z/PKShbCCiV1fVdc6S8W4nDQNhmDv494IaT1LoE13BiUhW4VPHarHaXbGzzevqpD2JnRzpTRcNVcM78DQmtz14/DIDoieWucak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355232; c=relaxed/simple;
	bh=X89xNk17G/8E9HbGDqrSspN3vndS+/7k3ckRAeR0/7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NylxmWyqBKsTEPM/56CmT5CSL5kStoMCd1KGIz27uSujqPV+qYS8HJGCJiXQnOR2IFUI8LP7XKCbHSS228XgXJd/Bee7Cn9shOaWz37QG7ywvlfdSIBFkQg7ZViJzNK9F2mWydLV/kVWXg9sTAPInuLBxa6DzkmZwzXM2MwJmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gWSDKa2Y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso165976266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727355228; x=1727960028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=un2ZftB/QvIThKy8PygPlso/havi1tlGyYEDU34wreQ=;
        b=gWSDKa2YgLJbvooReEVEaIYjeGmV9amptE/FLoVpcNzAtWzlOVTC/hBl/u0qkk3k4y
         2vHu0WJX5hLa26aSf01mMMoi7FgcjDhqgCX75F+rVbCOOWNvRYplCwAr6t1tFF38DLdM
         kcoWScgoUN53NqiL2xinm/V4Hx2ngDi7J8UFzqVOTqZ6EzfHmdMwWBCHNO62iH5rumoD
         cPT2/Hw6T0GmXxmaANBK/iHR+jovfzNvX/HsEzGhi8eN0bZK5EJKfpDAfbvbETIp610L
         BkFLCGMO/X6qwihF5CR05M0RlGnT8DCCfiw0lfMzxJqY7adKaOW37ixHyuPgo47WihX3
         EDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727355228; x=1727960028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un2ZftB/QvIThKy8PygPlso/havi1tlGyYEDU34wreQ=;
        b=E5Rir87T25/9/x7wTxbBgudNrK60H1iw03RUphmzOuce1eHGGbdHGlp80MmOUjr7iH
         vatpk+MyZoyIq7SHKR0t7HjyY/lF7DSBnii1FFa8BbZKxVYC4iCevhGMjjOKAuc+PSuy
         SEfNyY9WxV0AmOUq5ACt/DQk7MBiciVGSxf5ELPV2FjREidEQz1XANo7z8UYLV8rGvMj
         bIh6l2LTIGPu/qzFKKWjgZ/ZLFbQ0OB6ekAPKOF7zhHOO/3oKjM/SeJ32pVHsMakUdNt
         QIdk2/9yuLp9ptRr/2iA+mn+Zdnnd9kcJcqUVtYkQ6toXEYm9zsRN0bjCOUx9jFuiene
         2M7g==
X-Forwarded-Encrypted: i=1; AJvYcCXfUaOivIuQaV6X6mRAHF/WkX3kHCt2ekkDjb8RznmGMir4PF4Q0qpT3N8RzL57oIOKUxYOeiDINnmmJ7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSrYNyFc5c+QWhZiAYHROIFm+2bX1g0jXFrI8J/9tv1A35JT7
	q7oC4j7zBDCB+DrMu27idT+TkJDnX0dI7rKAC2OcI8/hsdxdx7tWr6tYYWsga70=
X-Google-Smtp-Source: AGHT+IFic7O3nzCV5/Qb+u62Wfq9FpBMgDwA8rBfzwGPmA7j4RYSn01XdRM6mQGNEhGxnNV1lAkiXA==
X-Received: by 2002:a17:907:3f26:b0:a8d:481a:563a with SMTP id a640c23a62f3a-a93b165ddd5mr316650066b.25.1727355228253;
        Thu, 26 Sep 2024 05:53:48 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cace4sm345927866b.117.2024.09.26.05.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:53:47 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:53:46 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Chen Ridong <chenridong@huawei.com>, tj@kernel.org, 
	cgroups@vger.kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Boqun Feng <boqun.feng@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
Message-ID: <4fee4fydxuxzee5cb5ehiil7g7bnhxp5cmxxgg3zszc4vx4qyc@6t2qmltutcrh>
References: <20240817093334.6062-1-chenridong@huawei.com>
 <20240817093334.6062-2-chenridong@huawei.com>
 <20240911111542.2781-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gy2wjruyn6u7rypn"
Content-Disposition: inline
In-Reply-To: <20240911111542.2781-1-hdanton@sina.com>


--gy2wjruyn6u7rypn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hillf.

(sorry for later reply)

On Wed, Sep 11, 2024 at 07:15:42PM GMT, Hillf Danton <hdanton@sina.com> wro=
te:
> > However, there is no ordering between (I) and (II) so they can also hap=
pen
> > in opposite
> >=20
> > 	thread T					system_wq worker
> >=20
> > 	down(cpu_hotplug_lock.read)
> > 	smp_call_on_cpu
> > 	  queue_work_on(cpu, system_wq, scss) (I)
> > 	  						lock(cgroup_mutex)  (II)
> > 							...
> > 							unlock(cgroup_mutex)
> > 							scss.func
> > 	  wait_for_completion(scss)
> > 	up(cpu_hotplug_lock.read)
> >=20
> > And here the thread T + system_wq worker effectively call
> > cpu_hotplug_lock and cgroup_mutex in the wrong order. (And since they're
> > two threads, it won't be caught by lockdep.)
> >=20
> Given no workqueue work executed without being dequeued, any queued work,
> regardless if they are more than 2048, that acquires cgroup_mutex could n=
ot
> prevent the work queued by thread-T from being executed, so thread-T can
> make safe forward progress, therefore with no chance left for the ABBA=20
> deadlock you spotted where lockdep fails to work.

Is there a forgotten negation and did you intend to write: "any queued
work ... that acquired cgroup_mutex could prevent"?

Or if the negation is correct, why do you mean that processed work item
is _not_ preventing thread T from running (in the case I left quoted
above)?

Thanks,
Michal

--gy2wjruyn6u7rypn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvVZVwAKCRAt3Wney77B
SdrvAQDdyAACNlgcJdQnyAt+OfXdAkktYdx4C6u8rnjrJAu51QD/YburBvJewCr3
kvYZkYjeabzmop5dtSCAodkwILFEfA0=
=ms1r
-----END PGP SIGNATURE-----

--gy2wjruyn6u7rypn--

