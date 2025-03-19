Return-Path: <linux-kernel+bounces-567554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD1AA687B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9EC4234F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BCC250BEB;
	Wed, 19 Mar 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="edF5KG9j"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478424EF61
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375724; cv=none; b=h34fMc4W9pTetXxvkMTUFvw4fhp6UUmOoISgs5uPlM0UvjNve5Hh7xzdEuQ3FxV8ivUDubuFAosumQTYG+TkrVWr8ainto/zYAhrBemTX0gQ1HtHtP7PiKB0d4xYMMTdb+vSH0KM5B3tUoLT5mhHKlrK03nGjWOLfunBrXCZXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375724; c=relaxed/simple;
	bh=sdoWtmP8lcFKkLO6YKHdSDaFP6raFIU4DI5wjtYIURA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdJp2VuyNMO/apk+0E1QHaeCaqz9IhjQNN6SVAnqSJ7X8mcoVhWT2q0rOPwJlUtWfIV3k6vp2EXomyhY4U4DnhFDbCaBBrA+n1FsVqkcimp9ClaMPhTslFVejdqVvFxLACEj6ZNoxGA6HycuhDnKQ5Xw5VsmFaUmb8PFqp6GQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=edF5KG9j; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so2958755e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742375720; x=1742980520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ahIpFM+QNyoBpC1gPfBS5sPiHVhg0tBQ7r3MPVtw/d8=;
        b=edF5KG9jLZLUN18XPd0AqVDW5B35OYV942dGR6Gam5ddWNuNE1O/QDkojmyhFLuJo6
         R5OHvmHwe1ZwV1uYmb3hg4UdrmyVyoEOdaQHmP5EjROsMVl2qj1okO2BJ0m3u61FiBfA
         TgDvnAlO4/tWPskMz1a9BzBevQU8dSBxdEpuy4deuveDuw4V40lbJg1UJRWszB133UAy
         8AVUcyngjPNm65vIcbBVVrdwhJKP3DA6PhANX7fWO0gsTK24Vw+2ZZK5mUafT5st0Jj6
         RVht+tdj//U7tIJ4ZxFrNQHwetJpV4ufw9hVmp5jxEQIkt49Amtn41U8mKec9BNVJ4u5
         j/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375721; x=1742980521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahIpFM+QNyoBpC1gPfBS5sPiHVhg0tBQ7r3MPVtw/d8=;
        b=VtKihNbt3I4R0BN0BdmlzKHMJTFbeJyTT92sZAYm4jsPmGQ3I+HKOCYS1CYGlu2BFy
         mPdZKG4R5ON7ni+AHTF1KKHt/L4MvlfJmKg+IfUAN9VdQoWFQE7Wdm4GHSCvT8vDfC+G
         HJXH6OxvKvF79v9l3c76GBCqqPQiuMlGz1QH047RlhFGHKSqgaBuNh4I24mT4nL4SVIK
         VDFwVnxTiAbEOf9yUPdD6Ah2V289Fiacse3YNAdI40kZ52KSHsDa7YnoQYv7YGl5yn31
         eRRFt2dDS+G63b8W4HFdrogr27IxG644Dw4DtK5CPYicPNddemjea/Lnxxf2WezPr2QH
         tVZw==
X-Forwarded-Encrypted: i=1; AJvYcCWb4X7SS7othTzVbTZchjVrP6CmQerLWXOT9h+XYHORLNO/q+KX38KY9KtMrfF6/PGqEGBFdbK+z32S3LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLTGXsdOID30jvAvokL2zPMYldAp3/mp2/sCP1/oRUcw+52+To
	Kt8v/UAr8zQJx2s3Xrs1HN+oocbMAs+zHMr5PPt4JQWWLXDs4GoF8SCqw5E2K7Q=
X-Gm-Gg: ASbGncvum4pF1AKdOwMLOI37aO8rJC0CpfOA3sfDISIf6KWSuaFbIToFhSaUXZXyXoq
	oTNVvHjwgPXGYeqlCRQvVU4tXtV8iLlot/cIlw+q7thO6u23qIMS2aGranwjhHNA8mIK6Gk1nKK
	zyMzAtzQHoxj947XFQnbZhePhqgjwKlapaIORvFV8aEzurwlna+3GF30QYiMNiVJAnQFTXsoWnP
	XsgGbH5icYP0FO3IkgHBf7iQAQFacbC5ZDxWVkvVnK/dxHzkhVOBCXh2dd/H0O/RPm3JOcW/HOW
	YlPogH/MwC/O8UfKpgxAyQqupOIQ6yMvJFU/t5b+/qGc9qU=
X-Google-Smtp-Source: AGHT+IEHJqVdsFhvFTJ0j9XFeF9mtqW2S/78HUhgtYFtcniJo8M+ZzwHHxF5ImTnWsi+nzTq3v24/g==
X-Received: by 2002:a05:600c:46c7:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-43d4309c628mr12508825e9.12.1742375720499;
        Wed, 19 Mar 2025 02:15:20 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f7460fsm12870405e9.28.2025.03.19.02.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:15:20 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:15:18 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, tj@kernel.org, 
	corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
Message-ID: <hvdw5o6trz5q533lgvqlyjgaskxfc7thc7oicdomovww4pn6fz@esy4zzuvkhf6>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
 <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
 <f62cb0c2-e2a4-e104-e573-97b179e3fd84@gmail.com>
 <unm54ivbukzxasmab7u5r5uyn7evvmsmfzsd7zytrdfrgbt6r3@vasumbhdlyhm>
 <b8c1a314-13ad-e610-31e4-fa931531aea9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2vr2zym4stjkfz33"
Content-Disposition: inline
In-Reply-To: <b8c1a314-13ad-e610-31e4-fa931531aea9@gmail.com>


--2vr2zym4stjkfz33
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
MIME-Version: 1.0

On Wed, Mar 19, 2025 at 10:38:01AM +0800, Hao Jia <jiahao.kernel@gmail.com> wrote:
> However, binding the statistics to the memory.reclaim writers may not be
> suitable for our scenario. The userspace proactive memory reclaimer triggers
> proactive memory reclaim on different memory cgroups, and all memory reclaim
> statistics would be tied to this userspace proactive memory reclaim process.

It thought that was what you wanted -- have stats related precisely to
the process so that you can feedback-control the reclaim.

> This does not distinguish the proactive memory reclaim status of different
> cgroups.

	a
	`- b
	`- c

Or do you mean that you write to a/memory.reclaim and want to observe
respective results in {b,c}/memory.stat?

(I think your addition to memory.stat is also natural. If the case above
is the explanation why to prefer it over per-writer feedback, please
mention that in next-rev commit message.)

Thanks,
Michal


--2vr2zym4stjkfz33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9qLJAAKCRAt3Wney77B
Sdz/AQDecvjUIrBbge909wB9b5M9WL2CyeFc32hNE+fRPTIFHAEA6LHJUMgFCinA
+J9mJe//Ur+z8K0lQBS3T8v+E9CbmQQ=
=VFn0
-----END PGP SIGNATURE-----

--2vr2zym4stjkfz33--

