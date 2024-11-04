Return-Path: <linux-kernel+bounces-395205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8C59BBA44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF981C24675
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9855B1C302C;
	Mon,  4 Nov 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SppinLlP"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA41C07EF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737333; cv=none; b=jjRTzI4iSePjGZBNLhZpxxg5DmdkRipOSTQtUyq3PYKLSr81pE22DK7gblMpqLnfIKKCMOA9cjAb2wlDwDJl7HRmw4zETylKx5is4p8mNxc7zUiTIgWjrDs5gsG6LpiLz+A7rD9JONMlU9KpD9A325hc6WAvps7SJI/cm1XEPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737333; c=relaxed/simple;
	bh=1IJVTOdevInuCFt0TT64VQzJrQeBcyo57p7osJy8EOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWdEWKtI68uE3V2a/uEjJ7xzFOySpmXHABd8wO3RGO/Z0Cy8bGrM0tTWEghX4ajUNagiXT7Lg41U3jqZRiF821np9BFYLgwyjkbjuHNjMyPAOjdoqCy2YNsO6mdY7oChM7kRFVHyqrFR8CvHZwWvi71jBf49YXFLAyCJLgelrpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SppinLlP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a16b310f5so725050566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730737329; x=1731342129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IJVTOdevInuCFt0TT64VQzJrQeBcyo57p7osJy8EOM=;
        b=SppinLlPgyjmCh2MfqTsfW5HaAGziwj269neHwN6KD+zC93SZkd4fWQg9SFyzUiScQ
         i4DyIHpBEcEDwvdyuDVHZaiA/8lje9vusISReAXmuljOhFu+u0YXA5erRZkJDy2KN+QT
         fDq+x68uSx+Zgs+1RiiCjkRUxyd7W1BlJ7OuWZCFbnp6zsPKsZpazr6nUb5m9bu8KPpN
         Qmnxer5DYb3Au3eTHZTtgik9Mokj/89guk50+HCzxaH9hsHxwxRITgr+lCL49R5snTlJ
         9hQVW6++ijEiakI/jEDqs81BwVAz2HHgc/Tko3f+jGuGb0xkDdi6yhWBB9pk1N3laJg6
         YCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737329; x=1731342129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IJVTOdevInuCFt0TT64VQzJrQeBcyo57p7osJy8EOM=;
        b=pB22Xd/g7Of+HeICGaRTcvKPtt4QqZ7/vL97T4mHhEFJhI0v7fQbkUcHFzRWeTZQMB
         7aAJ3qH0tElyTjv1PUwvpHCzioll6tcp5P7DGrkB+p3ndYvRpHos5qUT5wsgzKYDLmsi
         tqCBDMaGfG2NJvCQtaBJQy7vFvbTePEjgn3r/Izlon63yU5/PF7UWKcqSw3aR4ipFBxS
         GXaYfT7VWNEcTVBVzaQh+xtkiGSicP9Oxxklv1fyemtxFNfoKEO1qd3i+9cJ2pL4tr8v
         nhQq5j1IooJhXfNOW+Iy8N4FvtaW13eyo/CHd9CIxMTYdOZ0Gl5nyeJvNHpL3U1ZRQ47
         f8+w==
X-Forwarded-Encrypted: i=1; AJvYcCWi87M1fjCU1ZLXmABzLeOj67a2a+H1+/NZoTDZR8TH7TRG9TipT04fnyIXlgfzjpnS+zfffGXUDuBvl2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcj5x9odmtnb3QwgQveISxFWjF2Cpywy0Hxo69D/q7wHSi0IqY
	ecqNi1n1pD5YE8g12h++G9KMzxmSG6b6vzfCMbq8csukEg44ICE4UnQYZdq0n8U=
X-Google-Smtp-Source: AGHT+IEIxI5kzSOoP15F+IAqnvkf4bEB0uP9CKSZmNbKww+N79Bfsg6uYpHMWT+RGeNBfeWTUF9b4A==
X-Received: by 2002:a17:907:7e8f:b0:a99:dde6:9f42 with SMTP id a640c23a62f3a-a9e50b935bcmr1467166566b.47.1730737329029;
        Mon, 04 Nov 2024 08:22:09 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16f85e8sm1618166b.84.2024.11.04.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:22:08 -0800 (PST)
Date: Mon, 4 Nov 2024 17:22:06 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Rientjes <rientjes@google.com>, willy@infradead.org, Vlastimil Babka <vbabka@suse.cz>, 
	David Hildenbrand <david@redhat.com>, Joel Granados <joel.granados@kernel.org>, 
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>, Sourav Panda <souravpanda@google.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-unstable v1 2/2] mm, swap: add pages allocated for
 struct swap_cgroup to vmstat
Message-ID: <427pnhob4jjh6shhwypbsvaqgqvikgvxche2llbieagksbu2je@dwneoygkvixc>
References: <20241031224551.1736113-1-kinseyho@google.com>
 <20241031224551.1736113-3-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xsnkmnsfnfqko6pa"
Content-Disposition: inline
In-Reply-To: <20241031224551.1736113-3-kinseyho@google.com>


--xsnkmnsfnfqko6pa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kinsey.

On Thu, Oct 31, 2024 at 10:45:51PM GMT, Kinsey Ho <kinseyho@google.com> wrote:
> Export the number of pages allocated for storing struct swap_cgroup in
> vmstat using global system-wide counters.

This consumption is quite static (it only changes between swapon/swapoff
switches). The resulting value can be calculated as a linear combination
of entries in /proc/swaps already (if you know the right coefficients).

I'm not sure this warrants the new entry (or is my assumption about
static-ness wrong?)

Michal

--xsnkmnsfnfqko6pa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZyj0rAAKCRAt3Wney77B
SY9LAP9/jdQUnp8MsUTsmirYbLEY5QeOWGUXcJ1lihd7wb/XxAD+M2sjppH7KZ56
DqztrEdrWYgFudgEBgGGKuXkH178EQo=
=xrK9
-----END PGP SIGNATURE-----

--xsnkmnsfnfqko6pa--

