Return-Path: <linux-kernel+bounces-263280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFBE93D3A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD211C23468
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AF717BB03;
	Fri, 26 Jul 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XGRZdgJr"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2E23A8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999076; cv=none; b=EwzjWJdIubO/L0AkD0uJuo7FEkT4JxyrIdqnCBN7U8jHbbtCbcuYFqiFkmArbddC8THiB5xnrLFcFV1GhX81qpc+efYvnM835W1P0jKkEldovz/UaUaai/L6vcemnTn38IuEVYkaqhawByuZ9rgQrqOJYodDXlZa2fjrVVelwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999076; c=relaxed/simple;
	bh=KKESGORhcoQA9Aqe3oavXhCZhKC98kmZdXj0F7j0ZAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/MtQ89kk0kS1nYvKaqT9dWctX5mfqW9aHwqDJT1VyjYol5hSmrX0Do/9d08jtGCWlN3Rw4LQWhYlOUvZoVrUzG6/QrMH3YAMIgnFBQCRlNVy02jhzrBtx4CAt5SySRvtEpzv5OJF02yB5F8tZj6VhIqtrtLcjH0y+Njwgwb6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XGRZdgJr; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso13427121fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721999073; x=1722603873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Om+9chWRNNEpAfdZtTQ/mtLwGJ1z59DIgJZDHwgmqW0=;
        b=XGRZdgJrpHSRNSiX/oyKBgkp6gHVLpZ3YX0MlN8RkKNgG6z/J+AUQOPLV8bvMQAhGt
         mdAsP6vR0F5hfzbp513aI+zS3mrHuCFDrsCNcqj9cGjYWgrsP+xs/OzR5NhMlQ8V57/S
         BVc71OID8RmGtKiKT2kdhanAIMTm4wEQP4NKpCJBp73t0EKnQM9ARYmhXN8kQ6jRQ6tG
         pGtMob0ymLy44AZkHTgpXO7PT1eBl8sodY9oGJWU+v7jxUDUOs2Z+j+GVAHaqpzhMHqA
         pjyUbx5We+I5mKP+RMD60WZrFRBAd3+q7tlZJ7Uerx45ERlcRKllu/VzASlQrG/YjfK+
         X6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999073; x=1722603873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om+9chWRNNEpAfdZtTQ/mtLwGJ1z59DIgJZDHwgmqW0=;
        b=KxqB54DMolU7oOCn++Jk/dgERN8rYsmXbZ4WkRRud63cbVJ4wr1T50SOh/g8GZwC+z
         yNHoY5wqP0zOyO6XN7QfKpaJz1QeLvi0+ZaYqL3ATveK7gWIuGXo0xT0Mw6lBNDTWWBo
         JLM0ZSHrnm+3/QuFZvoWB/VCCuTqcAiqm1sD0xxHCCVDzP2/DhFdpOPKB7iXJEG0rGRN
         JsfTvzIG68r5eMTKSdgrmkTr8a0bRtU3JaV1qIX4RM724vmgC/M0AcNwHThkdwOan/0J
         jpAAz9lwNVn/VSHYJhl87VfnhBcEizMUALt3CnBQae9JOFHP/0w97rG4F88hasaRAjg9
         fklA==
X-Forwarded-Encrypted: i=1; AJvYcCVPh7OMS5YbWvIi5eM23FEfSB4/ot606dRE9HC7Bv7O2CHqLI1HeLZvjrFK+NT9Rtk+8EQegfd+l2ppxMrz4YlrPmt6FJCvQ6ZTwOnn
X-Gm-Message-State: AOJu0YwlbfNzL7tSTHNF+PZa6Qq6f4Voecptyo+dHR1CQlRkrpKsiW97
	N2UnTszUolBE6nO3yyuXbPSudGSEwjuw7Wb1/1JVYa1msW3hgXtZOcdz4D2kFP8=
X-Google-Smtp-Source: AGHT+IEVfulzR9d0qzgqQVFEoqrvluyhlK+ugJ916FpIw4lFOSjmSOUX0/K6QrXV3XvrlVp9jAX27A==
X-Received: by 2002:a2e:9d09:0:b0:2ec:6639:120a with SMTP id 38308e7fff4ca-2f03db70dc6mr33413951fa.10.1721999073011;
        Fri, 26 Jul 2024 06:04:33 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8128d0sm2640375b3a.118.2024.07.26.06.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 06:04:32 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:04:24 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: chenridong <chenridong@huawei.com>
Cc: Hillf Danton <hdanton@sina.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, tj@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
Message-ID: <ohqau62jzer57mypyoiic4zwhz2zxwk5rsni4softabxyybgke@nnsqdj2dbvkl>
References: <20240724110834.2010-1-hdanton@sina.com>
 <53ed023b-c86c-498a-b1fc-2b442059f6af@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvccf7izdphyux7k"
Content-Disposition: inline
In-Reply-To: <53ed023b-c86c-498a-b1fc-2b442059f6af@huawei.com>


--wvccf7izdphyux7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Jul 25, 2024 at 09:48:36AM GMT, chenridong <chenridong@huawei.com> =
wrote:
> > > This issue can be reproduced by the following methods:
> > > 1. A large number of cpuset cgroups are deleted.
> > > 2. Set cpu on and off repeatly.
> > > 3. Set watchdog_thresh repeatly.

BTW I assume this is some stress testing, not a regular use scenario of
yours, right?

> > >=20
> > > The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
> > > acquired in different tasks, which may lead to deadlock.
> > > It can lead to a deadlock through the following steps:
> > > 1. A large number of cgroups are deleted, which will put a large
> > >     number of cgroup_bpf_release works into system_wq. The max_active
> > >     of system_wq is WQ_DFL_ACTIVE(256). When cgroup_bpf_release can n=
ot
> > >     get cgroup_metux, it may cram system_wq, and it will block work
> > >     enqueued later.

Who'd be the holder of cgroup_mutex preventing cgroup_bpf_release from
progress? (That's not clear to me from your diagram.)

=2E..
> > Given idle worker created independent of WQ_DFL_ACTIVE before handling
> > work item, no deadlock could rise in your scenario above.
>=20
> Hello Hillf, did you mean to say this issue couldn't happen?

Ridong, can you reproduce this with CONFIG_PROVE_LOCKING (or do you have
lockdep message from it aready)? It'd be helpful to get insight into
the suspected dependencies.

Thanks,
Michal

--wvccf7izdphyux7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqOe1gAKCRAt3Wney77B
SQ3bAP4zZwhoMlp7s0lfIHJRH2FNHqYst96qUlJGjpM8tZLEuQEAjMbWp2LRL4Wq
RebdIf7Erlmd/BknyFNRjYv1GWv0Swg=
=at7/
-----END PGP SIGNATURE-----

--wvccf7izdphyux7k--

