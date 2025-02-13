Return-Path: <linux-kernel+bounces-513222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB4A34462
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3B616A132
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC20165F1F;
	Thu, 13 Feb 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4qq/u4M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0063D156237
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458460; cv=none; b=GW1bwt9ZyX7huboMuQ/S+y+eR+CyWnrETxBuS49rw8841adQJYeq8khYhHV8YiqhyexBjKOidxHd/xjBB1grpcmzOz9ad8Grth/xB82Tds31PjgaUDcko90b4Q7h2Z7s22zz3LF1YIdDW8rLzzPg1KSppGwG0GvwROzxdwva0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458460; c=relaxed/simple;
	bh=lcVmYAw7gPVEK6CO5X5CU1Pom+wwmvtORxzdjYPVJnA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rM9iLgkIc70ru6N1Hn6cnL5t9+zMpOX4ao98aRF8880dRdIsA5PpzjufykTYJ2W24riameHW+cPvvWCmN1RlSUfveJFmDwupgVT0YzIE3qLRQCUhev3MUsiW5aVk4IwYp8GYdqaMBtNW7vbYzi/Hr2bONgOKh1QdAf0QlzA1Ik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4qq/u4M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739458457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lcVmYAw7gPVEK6CO5X5CU1Pom+wwmvtORxzdjYPVJnA=;
	b=S4qq/u4MowyuN1ww4pToyXD8kj36CQE+6eYE6Mwu6nrme7y4VVQo7GL6OQh1pXhje7TTQ1
	I5poyhyFVYLPpr/L+44gZyYg9q8Uytdqm2JUou0Pkcx8sqko6895jYJh7urhVmuuVlBpIJ
	WPrlnk7v3aiSCqiRtw9KaWP5sg1XW0E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-YC0VeryRPymmAUf0e-YBYw-1; Thu, 13 Feb 2025 09:54:16 -0500
X-MC-Unique: YC0VeryRPymmAUf0e-YBYw-1
X-Mimecast-MFC-AGG-ID: YC0VeryRPymmAUf0e-YBYw_1739458455
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43935bcec74so5545705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739458455; x=1740063255;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcVmYAw7gPVEK6CO5X5CU1Pom+wwmvtORxzdjYPVJnA=;
        b=g/OKGfh6BHwZ7fmsWLsp6QSx/RWYJSuUQr6oXzUnnEpKoJe9EnbLy1miJTr19QLYqb
         Q6FsWtTPu12eRgX1NvF0b07tX61txNSyD0N6bGI3b+TNP9j2hZSe00hb1+ZYdsb7Ov4Z
         0KXnchBREBYDR9vvYmhMyq0RKbf/+m+OA4TQk9kGqIBXvgE9EjbWbEbdV8Ds8/htlhpO
         bLz/Wz8AIcN3MmPR8+sW63YFH3FGmkVdhoe0nNQb4x4J/zc8/h9c0EZKVaoDVHzgaOiO
         xWUcAAtL/q2I4KxVXprs5qfyHYFgqb3Mo3Ew3rqPu4sLOBpI7otrPXIMpbnlJ7Tw44LI
         /CRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV61uh2prJEg0ziDl8tdlT0uRgM+Fu6lf3JvZfeC/FiMtsknfBhZjU6/7fA6EGwUfmsGfN182KvyIt0x80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvF9wGJ05BVqR0dBp+wvBsOoHT78ROdXS0SpF7rMo7+LIC9l+T
	RXebmYaehH1QnEGE1Lk38vDO9W/kFQBfZxwKLxO+SuwKHg2h+0ueNyN4I21sdt99OUug2WfBPMD
	BfgNiZH0CW7CpW8bcPp9vK51zga5YNxqllKnWNacwokTYqSVTO74pGAG8beTu4g==
X-Gm-Gg: ASbGnctoCAgOKumTlTSy/UTIAkYV6Oaii/xt4GLCl2fRxOQs7C7d2ZPmRSEaq4Hp+tD
	NcUF56c+yU5bJ4jHCI+8i3KczI7Rw1swlL2sNuhhOWtK7XS6KgElRGwvGhm0JqDqL8ah9r0YIlh
	l34qSvRtRE8IaC28FQwQpe6Rcsw28AgKPAaZoFqGLJjC5y28ifkZvtpeKUzjl69Y/nbnudwBF2X
	Ff8vfteeAddXalfj1hxDtVe/nolroyJHDFHCYKwSfhfbYFyCKX8NG2F4wDkHqxhPGYkUN31dhrc
	gwauHF8+LkiC9Af6IRVOEtrlfHP8tNE=
X-Received: by 2002:a05:600c:45d1:b0:434:a529:3b87 with SMTP id 5b1f17b1804b1-43959a2ac8cmr79548695e9.10.1739458455469;
        Thu, 13 Feb 2025 06:54:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIHxEcPhPU5tvZqDsW+2y0vfS4JCl38CBshjdv1WEWrfZ1gLp7pPUcgZ+yuq2Gx7ZiBIqdMg==
X-Received: by 2002:a05:600c:45d1:b0:434:a529:3b87 with SMTP id 5b1f17b1804b1-43959a2ac8cmr79548165e9.10.1739458455026;
        Thu, 13 Feb 2025 06:54:15 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccd3sm2095537f8f.23.2025.02.13.06.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:54:14 -0800 (PST)
Message-ID: <053fceb18aa0cd3999b0c5de8e9d843e0d391945.camel@redhat.com>
Subject: Re: [PATCH v6 2/3] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, aubrey.li@linux.intel.com, yu.c.chen@intel.com,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra	 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 "Paul E. McKenney"	 <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>
Date: Thu, 13 Feb 2025 15:54:11 +0100
In-Reply-To: <32815949-dd1b-4cc2-9ba4-724bf6727010@efficios.com>
References: <202502131405.1ba0803f-lkp@intel.com>
	 <17bda9071b6962414f61668698fa840501819172.camel@redhat.com>
	 <32815949-dd1b-4cc2-9ba4-724bf6727010@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Thu, 2025-02-13 at 09:52 -0500, Mathieu Desnoyers wrote:
> On 2025-02-13 08:25, Gabriele Monaco wrote:
> > On Thu, 2025-02-13 at 14:52 +0800, kernel test robot wrote:
> > > kernel test robot noticed
> > > "WARNING:at_kernel/workqueue.c:#__queue_delayed_work" on:
> > >=20
> > > [=C2=A0=C2=A0=C2=A0 2.640924][=C2=A0=C2=A0=C2=A0 T0] ------------[ cu=
t here ]------------
> > > [ 2.641646][ T0] WARNING: CPU: 0 PID: 0 at
> > > kernel/workqueue.c:2495
> > > __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9))
> > > [=C2=A0=C2=A0=C2=A0 2.642874][=C2=A0=C2=A0=C2=A0 T0] Modules linked i=
n:
> > > [=C2=A0=C2=A0=C2=A0 2.643381][=C2=A0=C2=A0=C2=A0 T0] CPU: 0 UID: 0 PI=
D: 0 Comm: swapper Not
> > > tainted
> > > 6.14.0-rc2-00002-g287adf9e9c1f #1
> > > [=C2=A0=C2=A0=C2=A0 2.644582][=C2=A0=C2=A0=C2=A0 T0] Hardware name: Q=
EMU Standard PC (i440FX +
> > > PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > [ 2.645943][ T0] RIP: 0010:__queue_delayed_work
> > > (kernel/workqueue.c:2495 (discriminator 9))
> >=20
> > There seem to be major problems with this configuration, I'm trying
> > to
> > understand what's wrong but, for the time being, this patchset is
> > not
> > ready for inclusion.
>=20
> Patch 1/3 has been ready for a while though. Can we post it
> separately
> for inclusion ?
>=20

I would say so, there's no need to delay it further.

Thanks,
Gabriele


