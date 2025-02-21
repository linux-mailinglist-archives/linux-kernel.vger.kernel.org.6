Return-Path: <linux-kernel+bounces-526045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94A6A3F91D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E6217A456
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7A61D7E50;
	Fri, 21 Feb 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XecPJcC+"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23801C5D62
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152480; cv=none; b=Z3kXa/Ho/QkiMWGlirVZeisucIOaw/SfVNHvHppLbzMemLxDoLWEaoi+afr7wk+BhW5f+1C1nV/JELNLIW49B37PQm9O5SxbFSwxR+OvCLSemHGMlu83xnxAstfSQbT4NKYwqU5JxSpjVwPbE1M0PoKKu348EH1dODPY8COi3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152480; c=relaxed/simple;
	bh=FYE/XaLSpZzHV3UAYCqEEhw0Z6Xwh3vFV1VBGMVXrqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHXmoFD9NXofR5gtR6JnB3ib1+yfff5pNoxLq3zjyMgX4NQBSZBh0BI52ya9KIWCkD1TOnrnxRT2vPvNcFGofLCW1XqcO28DoN2PuGs2l2bHaBOzJRTtpTeC6Z7R4/KnGRQfLF+QgXxBZq9zWHMBEWSsCzoomvhbi7kzdX0zM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XecPJcC+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so4131325a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740152477; x=1740757277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpwjCzv4LKgUYN/jIekCLcNNtxWtAtGntsZBcDkghxc=;
        b=XecPJcC+zb5WpCO6eSYfW/X6QMOACZzCzDv8Oag7tgmH+fbk85WYqd7T+NvrE1pkRv
         bcgl8JhTtyPlNGBTqC5E+K6jfP+wcgvy6wjBlsGAm2FJQtY4elDuUrl1qV+MEpInVELb
         M5rjyxhAvD4DMm16IsIuENKxyt2HjOFWxOrVQtTFqJP0ilqrIlF3HHOaP1xUMKrAchHK
         7/0+Hq793/2jL8TzT+5113/dZwNBdX/9TvioWLHFbiVlFkaV0MEkkAcdZQ9BqROEJUzt
         cPatO9envdcw9Y3GO0MTYTk+1LKQB+9VcLwpdOcuN62yzf8yZIxQAXmcC5gMjQw+a5MK
         N9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740152477; x=1740757277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpwjCzv4LKgUYN/jIekCLcNNtxWtAtGntsZBcDkghxc=;
        b=FhKz0sSibGcsAMMPKKOz41bxYbUOuurWDVENhINNQPl/GJ+0Kx6zS8TaPRvX3CdctK
         DGdnpDDAT4QzJ3cSJjdEH1SYSPufW2hNQSVzAv5Qy5QRzsSIkxzhVTLb1YMYvPnOaJg1
         6mNR41udly+q858qiEkd/AcwvkEU2ZT8fVnwG9W9mysDTGoWO0CHfm+vyFH0kXXUGuqm
         CQXOWjlb/E4aVDXTC772I57iNPA8j1zBVOrVjvYfKWTCREnFjUA4w6j7UZPopy4uIf9i
         Z9k+Z8P6ZM9Zfq0mpmBaHw9OI0MSokIF1Nvkial5vRk7KZWhLZAlfIXeFYbnXFYvaWnA
         vpDg==
X-Forwarded-Encrypted: i=1; AJvYcCU/IUx/+/M8DqDH/W3UecMUXh4YAzxjOdLGxs+MFWaRd2e6Ciu5h17bxxh2UlE7xq+nuYG7XA4caOVjHxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvSJirFO3UOk1XR+X4s9dwIViVdLehu10UZ0454P42NOBgcl30
	izX6PV5JxtK5ox7ABeR+u//xISZTluU9EHiv8o+DDV/AIF6erMmLZ0+EITSPWcA=
X-Gm-Gg: ASbGnctwxi414sU8oqILGjkT/260QclF8+cv+Ch5nlgfj9qs5rW+1fvR8NN45pYYo7q
	up68U6SHS80+dKFFDigq3xinj6XSFL1mGxzYO6sb+HcNiQjDnmvDm1dPirI9V9l1thmkaGIGOF5
	Kf/0/rmEh0n5jo1Tw3hqqflYCedBWRe9BY6IHe4L9CGGlOQNSWc0xLmWOd8SFPDgI36KbQBnY7W
	buV8Mnd+9x7Z2+PpYzvWEPA/1NXJkWGwwXPy9zY0GEH/gDF//+sV2b55V1K7ClZkaRWBlrcZN08
	1zN0jfUsv+X5mOOxPWCxF5ES1JBN
X-Google-Smtp-Source: AGHT+IFoGQzBBs1QEqa8a+/ZOxTGf25HGli0bYTE/TaoWJzEs883/D07QzveegE43BogfPX1KTlIwQ==
X-Received: by 2002:a05:6402:440b:b0:5e0:52df:d569 with SMTP id 4fb4d7f45d1cf-5e0b7252db5mr3912491a12.28.1740152477187;
        Fri, 21 Feb 2025 07:41:17 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece28808fsm13714461a12.75.2025.02.21.07.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:41:16 -0800 (PST)
Date: Fri, 21 Feb 2025 16:41:15 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Yury Norov <yury.norov@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bitao Hu <yaoma@linux.alibaba.com>, Chen Ridong <chenridong@huawei.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] Fix and extend cpu.stat
Message-ID: <puq53yk7guef3itr4d2uq5ka2m6cdbdflzzdumuvs2giyefwns@2e5ynejmu5ht>
References: <20250209061322.15260-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="boga3dtsvv5zrl6a"
Content-Disposition: inline
In-Reply-To: <20250209061322.15260-1-wuyun.abel@bytedance.com>


--boga3dtsvv5zrl6a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/2] Fix and extend cpu.stat
MIME-Version: 1.0

On Sun, Feb 09, 2025 at 02:13:10PM +0800, Abel Wu <wuyun.abel@bytedance.com=
> wrote:
> v4:
>  - Fixed a Kconfig dependency issue. (0day robot)
> v3:
>  - Dropped the cleanup patch. (Tejun)
>  - Modified 2nd patch's commit log.

But the modification isn't the usage examples that Johannes asked about?

Also as I'm unsure about some plain PSI values (posted to v2). Maybe
it'd be good if you could accompany the =CE=A3run_delay with some examples
showing what different values tell about workload.

Thanks,
Michal

--boga3dtsvv5zrl6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7iemAAKCRAt3Wney77B
SQo1AP9KEg+rebuhZQwOkT+QXD/la48d+6E5IDI2HbAlGtlVywD9FON965afUo4W
D9fw5Iux3ogkW0/9rAgcYZnW1dVUCgA=
=OUDn
-----END PGP SIGNATURE-----

--boga3dtsvv5zrl6a--

