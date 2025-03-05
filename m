Return-Path: <linux-kernel+bounces-546518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A8DA4FBA2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DF6188713A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174F207DE2;
	Wed,  5 Mar 2025 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dvu6ByZl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FA2066DB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169848; cv=none; b=kFiPlv41n3B6seJEpiepbG3YPrWyABgVSEEu82uhIJicTAgqmAaTksF7z2cucmZKDyLZ4erX7PA/AModWBusiGVR8AYwaIUM5JiBNWyLeaHDQdl77rjxjCCyLHWxksd86UB9tIOfr51bGCDIlZmQ7VjB9ELXZe1SKyKExA9YwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169848; c=relaxed/simple;
	bh=9VFnpLzeqiLEQnzyxmwLAEeQdzPt+zBgO7BAKw0gcDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EITOw9xdicx5lZlKyj3mJVTorgmWSqGosyAWzAMNqJW7TRNC8XriqStQAgM/lxvrGwTlZvhfTrV7L2lZnzKxEn9NcgkSWGJBpl6Vm9OJOXQeRHJhXZxuRL4Fky3Uiph/by5O/DreOIjI260P3NluU8pPAXo6Y247vdRr3669ayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dvu6ByZl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so35201255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 02:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741169844; x=1741774644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9VFnpLzeqiLEQnzyxmwLAEeQdzPt+zBgO7BAKw0gcDw=;
        b=dvu6ByZlNsq3YJAF3nkethVOu1W07Yic9t4IqZ7F4J+Y8ig4MFYN9GPA/ZZe+SxdNr
         NLbEKSF5g2pOhPAtcNYat1jwOtsXkdfTe0wF0/c6JSpeKH0WuLpsd4kRIYABWqu5P5iP
         J640KjGwh8jY2MKNAkERRQ4c7kQ8T3665diZ7Tv36vJtVzRsfozS+4e9g8X6lqXIJcxS
         EkZSZrNSAEsz3ktnhcTisT/yllZplI0HaBTS/HguTLdqFWL2obza1+R6Nk9TQJGumZJA
         xfyrE/kmiUQtbGvDkeDL8cC1OG1auWMszs9lTdqe59cJ2dAjXpCkC0ehQvU/0CBNdqQQ
         HDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741169844; x=1741774644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VFnpLzeqiLEQnzyxmwLAEeQdzPt+zBgO7BAKw0gcDw=;
        b=KS6JTqZyTpflKf6cRqS1S8uyKHnYkF2B1qHn+3C7mT3wpJv87LFSBzeFJ3HJm8W/JF
         4xYmAmtPQ7B/hlUHEip21Au2bIjoVXYZHkQz2uDd1Y/h0lpKm+HKKxz+6ReSIuFpmiuB
         5w7PwZ8mTo6YKMmgQVKXa6lEW9IHmaPzExjiPOrK6YYNwIY2eEgjULdqiA1BaRvxxEIG
         w+m4eJSqDmIYHRrOy2hsD4Pw+mA8x55vbs7+mPDDxZw1UdJm1KdXPz76OXanslEpDyf2
         17Zi2raUkv8ESQ8u2DSjYyRG2Sq+oYF5O8NOUFLn3CCkzbkRBPonynkJinAPUvGWFq6N
         GIfg==
X-Forwarded-Encrypted: i=1; AJvYcCVrg+9Kxmry4GZbOnfzjKzmlYDn4rGFTe6SGtcUNYbTBkHjkR2d5OTLotCg5TL6mmF4LutkU4WxSmHtQog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrhIshGHMmL4f8yCUs4j+eQXYim9BvmJIzFd/NjGrUC/u6vSm9
	N4pAdbIMeM1grS3I/bsHI/2X2HmxGjj89icJb10AGqpjPHGm5vSH4qPnjMQugoI=
X-Gm-Gg: ASbGncuQA/wQLlFom08ELr9z82yhwxwhbwnN559dZCVk3Uq8QZurTIpecjqP7VW/8tJ
	gDUj8AMIhI8mujNf+whQOwIkomxmU8m+hlWQgm+PeY1LDkBFTjedbiaZdn5C9aHiwciovLsz2iA
	WeeQOtdDymr8ohfGUlLxSajYzUODXJA3mJ0wJxmlhho6fIRbh1NG1tmbRZ7UnQIh8szTJzJxiET
	EA+jQ3qW5lGwLfOYiMhzXV8fHnifflvNQGmCasF4XzybqGrxjo0pE8XNrFZcgofeB/Rl8sx86VE
	+yXI38SHT1KFM/jfyGl+pZky5AZDkp8m7d40u19Kfc/kLoI=
X-Google-Smtp-Source: AGHT+IELkfto1B3InHIV9XHTEiZ3UPQqTL8SpSgi8S+aMDMwNuHKEJeXQooPvFBqukLw7JdjT+ZyXA==
X-Received: by 2002:a05:6000:1a8a:b0:391:13d6:c9e5 with SMTP id ffacd0b85a97d-3911f7403e8mr2072408f8f.19.1741169844335;
        Wed, 05 Mar 2025 02:17:24 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d12sm20945766f8f.58.2025.03.05.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:17:23 -0800 (PST)
Date: Wed, 5 Mar 2025 11:17:22 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 4/9] cgroup: Print warning when /proc/cgroups is read on
 v2-only system
Message-ID: <t35nwno7wwwq43psp7cumpqco3zmi5n5y2czh3m4nj72qw2udp@ha3g6qnwkzh7>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-5-mkoutny@suse.com>
 <Z8cwZluJooqbO7uZ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ofgmq3xmxytwmxs"
Content-Disposition: inline
In-Reply-To: <Z8cwZluJooqbO7uZ@slm.duckdns.org>


--6ofgmq3xmxytwmxs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 4/9] cgroup: Print warning when /proc/cgroups is read on
 v2-only system
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 06:55:02AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I'm hoping that we could deprecate /proc/cgroups entirely. Maybe we can just
> warn whenever the file is accessed?

I added the guard with legacy systems (i.e. make this backportable) in
mind which start with no cgroupfs mounted at all and until they decide
to continue either v1 or v2 way, looking at /proc/cgroups is fine.
It should warn users that look at /proc/cgroups in cases when it bears
no valid information.

Michal

--6ofgmq3xmxytwmxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8gksAAKCRAt3Wney77B
SZviAQDogAzaKM/NodQpleghspQ8p1cKGWmOtSjRgWhYW60iIQD9EI4pdnCLmyC6
WOgtU2xvERdR1ff2o77F39wQh+Dh7QM=
=z6i3
-----END PGP SIGNATURE-----

--6ofgmq3xmxytwmxs--

