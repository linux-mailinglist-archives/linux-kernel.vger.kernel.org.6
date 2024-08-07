Return-Path: <linux-kernel+bounces-277957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B007E94A8A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48FE1C22C08
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B71B9B46;
	Wed,  7 Aug 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L9pd7MSz"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B411BC08C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037586; cv=none; b=OnqQJH3VPK7ra1LRv3H6h4EcYdXa7CKMtMplLpqGebPUL1HXCHgBkZiZwdn9wYjL8b1PjJK9zStM/mRo5AIzmV9zSlvlWEM8v6Wvm4D+qZKWIFPwzG2zXSJaxwstuSG1ktMyxVlWW3Rv4DV1QCLSxYlPHgUHgsKhw7Dqp0hB9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037586; c=relaxed/simple;
	bh=uTE2j/MDaHnN57JGWh3Wx6tZO0vxTSBFt1dcGvofWHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYG8TxmyZ9K30DKp0LsLhLczrDKFWbGKAVMbv/TSHN/9CSnRP3iRw7Acpxfd6nu9G2OQufbEiKfH6AwLBmEHhwxsVbSZJieJ977ejBIirM9Dy4Fxxfak5sGUut6x7mmeoH/Q5ge+2IiZQM5sv1STygVe2TKvJjYPr1tm8CwitYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L9pd7MSz; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f189a2a7f8so20915491fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723037583; x=1723642383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zoVvV2xOoCXu/RR2NJeonReacx/neR8WigegY62LXok=;
        b=L9pd7MSz88b3N84h0DsGzpoV5bf+AYgsE2y8VpxJo9L7bGtgXlMo+SHFq38TOXbgKh
         olVoS6WkA2K5Y5gZBaXIPO6OVD9hPXtawzgC94NdTgPAUPq/c4hF6vNTHsXbFxtB3Jhv
         5cxnB8BR0O+A4Izgnv+yEnI3gcy0UVi08IbfqWoIE3PMOb1+7G5TYVbLO9BQRQkizpNa
         jkTUglCcrvf8Ec64+1rraDvXKZl0YvDXYcY1f9p0tqEnNbkFeLXT9sOyShzy8Q9B2pkm
         fiQ+bDM0TciaqlLaiKR7vs0UKtBxO05gDriz8R0mzFpiZgf/zQkqwHBRokN5gZhk8FdH
         SeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723037583; x=1723642383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoVvV2xOoCXu/RR2NJeonReacx/neR8WigegY62LXok=;
        b=Pg/ga/tESpwsIsz0ssQ4NlBhMjS8bc8f0JwFhiZtlIQhpZ6yVsLDgES2RSKN5r5uAa
         2WMB+m2uZpxEKRoPWV9B6X3dC4dFiimskUtdTnp5OrPm+zqbIwOLLozqGPyVCXwTvGLH
         fFLa5ZmeBG+hqRwPh1KPlOmCu96L8rbr2HUraqYvEu8JWIRuRGFYoD58Y7iRONm6mHEG
         cI7GIqR8pTbU3diQ3yfEh3obySgdszICGYCK8FT31n/T3myqWsdkprRBHEAdArZuDk6D
         p5W1kiTKRkkafzV5mk6M5/Zzvd6cbbE/CZkqcjuRSZnYV+Htv9BjI914WxYPAm8pVtZa
         7N1A==
X-Forwarded-Encrypted: i=1; AJvYcCVeaAwR29UeQg7BHy+F1CcZlQdNpvWtiN/B5/0mQdicnIsy7XtczZrKuQjI+ZW/l60aO8Jf+M93BDBNO95aXoIpQinN//uF1ICjxP+f
X-Gm-Message-State: AOJu0YztrJ7RYiyMrI/UmkegTDvY7618AuhobKmjfCdKrRH+gxreZAbB
	+0M7K1zl6nqbryH1/56eIFGScrhnBVuApWMcM6dItKM8eyYYNOaBIp1uU+fUze0=
X-Google-Smtp-Source: AGHT+IFxkiPUrEtdYeOd3jzt9BaP4DW4fxVd0ulmgS/b7yl6AxB1T10qLc5q9Pao4dCx8B1rRkolTA==
X-Received: by 2002:a2e:7e10:0:b0:2ef:2bb4:2ea1 with SMTP id 38308e7fff4ca-2f15aa84f28mr122563931fa.4.1723037582387;
        Wed, 07 Aug 2024 06:33:02 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bba48b7310sm694937a12.92.2024.08.07.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:33:01 -0700 (PDT)
Date: Wed, 7 Aug 2024 15:32:59 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: chenridong <chenridong@huawei.com>
Cc: Hillf Danton <hdanton@sina.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, tj@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
Message-ID: <mxyismki3ln2pvrbhd36japfffpfcwgyvgmy5him3n746w6wd6@24zlflalef6x>
References: <20240724110834.2010-1-hdanton@sina.com>
 <53ed023b-c86c-498a-b1fc-2b442059f6af@huawei.com>
 <ohqau62jzer57mypyoiic4zwhz2zxwk5rsni4softabxyybgke@nnsqdj2dbvkl>
 <e7d4e1ce-7c12-4a06-ad03-1291dc6f22b5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uymw6r4jmmktmozg"
Content-Disposition: inline
In-Reply-To: <e7d4e1ce-7c12-4a06-ad03-1291dc6f22b5@huawei.com>


--uymw6r4jmmktmozg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Sat, Jul 27, 2024 at 06:21:55PM GMT, chenridong <chenridong@huawei.com> =
wrote:
> Yes, I have offered the scripts in Link(V1).

Thanks (and thanks for patience).
There is no lockdep complain about a deadlock (i.e. some circular
locking dependencies). (I admit the multiple holders of cgroup_mutex
reported there confuse me, I guess that's an artifact of this lockdep
report and they could be also waiters.)

> > Who'd be the holder of cgroup_mutex preventing cgroup_bpf_release from
> > progress? (That's not clear to me from your diagram.)
> >=20
> This is a cumulative process. The stress testing deletes a large member of
> cgroups, and cgroup_bpf_release is asynchronous, competing with cgroup
> release works.

Those are different situations:
- waiting for one holder that's stuck for some reason (that's what we're
  after),
- waiting because the mutex is contended (that's slow but progresses
  eventually).

> You know, cgroup_mutex is used in many places. Finally, the number of
> `cgroup_bpf_release` instances in system_wq accumulates up to 256, and
> it leads to this issue.

Reaching max_active doesn't mean that queue_work() would block or the
items were lost. They are only queued onto inactive_works list.
(Remark: cgroup_destroy_wq has only max_active=3D1 but it apparently
doesn't stop progress should there be more items queued (when
when cgroup_mutex is not guarding losing references.))

---

The change on its own (deferred cgroup bpf progs removal via
cgroup_destroy_wq instead of system_wq) is sensible by collecting
related objects removal together (at the same time it shouldn't cause
problems by sharing one cgroup_destroy_wq).

But the reasoning in the commit message doesn't add up to me. There
isn't obvious deadlock, I'd say that system is overloaded with repeated
calls of __lockup_detector_reconfigure() and it is not in deadlock
state -- i.e. when you stop the test, it should eventually recover.
Given that, I'd neither put Fixes: 4bfc0bb2c60e there.

(One could symetrically argue to move smp_call_on_cpu() away from
system_wq instead of cgroup_bpf_release_fn().)

Honestly, I'm not sure it's worth the effort if there's no deadlock.

It's possible that I'm misunderstanding or I've missed a substantial
detail for why this could lead to a deadlock. It'd be best visible in a
sequence diagram with tasks/CPUs left-to-right and time top-down (in the
original scheme it looks like time goes right-to-left and there's the
unclear situation of the initial cgroup_mutex holder).

Thanks,
Michal

--uymw6r4jmmktmozg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZrN3iQAKCRAt3Wney77B
SUGZAP9Y5qficVAEpKZ0n5YgNOwLfulVjcudCztVl+mKxiFf5AEAtzECB/1Mp9dH
/zzEdSAo+FNWF+1B1IXuJhVgAO0+sQ0=
=nCuG
-----END PGP SIGNATURE-----

--uymw6r4jmmktmozg--

