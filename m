Return-Path: <linux-kernel+bounces-429274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A798D9E1A25
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46498B62F5D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BC11E230E;
	Tue,  3 Dec 2024 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FrREfCdS"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A21E230D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222646; cv=none; b=BiSd4z3L0YVK7tAwvI7bOVr+wHB4NE35oFCOWIgLiP+l1Bx8oyJ1hZHA4qde+2MokuWd8YAcHJci3auh9LHlroUh+vJDmdV5O7ir3Or9+sVR/8bnIFWTaz2hOU09oGZ+rz1PIM7crd0qP+/DZH1CRrMvkbX/Vtz5pBHy3C5VdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222646; c=relaxed/simple;
	bh=iL+OdIGkXYlFltzIJA5/1Zmew0K54VlsMV2aPYAo6UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuRtodtD8YDlo5u+fFk7kk+gisXF5D5loEG2i60gKvO/9PQrt4Vhcw8F/ipR4x4MHqrMpBtQUr/ucYmyR94F5lJRL1Df23qinKUTTVqimZD+kscNPwKJDqazqwKgZoCQxUuLfy8yaf5mkpGCE9cLAQN9E5RbK9YY8xH/F2LMuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FrREfCdS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4349fb56260so46673115e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733222643; x=1733827443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U03OPGQRaXmE1ghscIoxpSXZHQUjfrvCB18PsXKgzhs=;
        b=FrREfCdSV2/aYsFXHTO5+1VisvRSH3XhkkNnwg2dePJ4vo5G+7A51+Lv69Aq2OccOX
         CQ8v1u0LbsDbncdeoSWDUj7zq/okhSnr5dmnyR+AabbVY7iVJX+F6896zpBFR/1przUQ
         y/r7AslBCTRCq+P09s9wizR/5V3sStFKw4yO2LxeFzZAvezUKrY+0iRnAmjCwfwHxHVM
         MBUxjDnCoxFhNoZg2lA0/xByj7Hv/wS3MhwIkSrQqmMEtiJLhLIMSY6Lnqqi7ZTPsLst
         cbQsR2qEqSxUC4moFMXwqXsJde74EubSqTPOYdq47Sdf694cX+MFBEqO0Oy5Fx5ML9wG
         hW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222643; x=1733827443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U03OPGQRaXmE1ghscIoxpSXZHQUjfrvCB18PsXKgzhs=;
        b=QtKBsV97phe224ZvQZl07+q2Y/uyyjbz0f1CjOzQr+T/xtho+c6bVCsDaGJe9NVOa+
         VroXuKYufaje3ns5uw0PEfpn8Xq3RLlVfpoCyFinrIdU5UU0YZqElmN/ATCkC4uaeUkA
         sknWGhlPuxzLLiiEK8qBxRt7kXUKpX3j3HAlOkpc9tvm+S29+x4vOZC/NKoLOF7FoxNC
         zrLpsWfMdm6GO1zgYVKccFVqOElHWUlaKi/pR1toZ8JUrjruZtFqZakXiyyU4Fo28HuE
         30LEidW00u3TiQ/NbFbEd5IPCagC31mMcYqig6bc+fzdP+mTtUQbE6EO8qfMj0iePtyd
         sFuw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ13QoLr67FuNWxvnSA9I/+U49oIrnuJ9Kf3z5F52pbvODe2K2t9P7xGzo8Kv9LKeVIrPIEHGTXc7B8+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEOH+MCKqC5yKO4wcKIh2ZRFtRm4K832uUPIbUMomsWy8/TX6O
	c9amiKKiUUeldXaWqPND4hG+YykJzuXegqVmlYF/co2Rh7EDptymbHy0Z7ZSZyycorpW3yhZCE+
	o
X-Gm-Gg: ASbGncuxXg23mSwz727BdRKwUjKUuw4tCBbtAS9A1jo1R5oxlHPPD0rvNnJErLxJRfd
	oY1e8jgXSWY7fxdmkZA0sqU5FwucLEiLLXNnzxnFsg7lzdRtqQclq98VHyPxOfvRzKaivSyy0/f
	zxNLtfia3oQugrL/gnC/MngfoVv6sL/z2XYLdAeJvUqCPu5kgUujXgECDEOBv1govnIxkr+BYv0
	Z3lVkRPk3GL1Y1UeoZ76v8CfT/qTim9ugbuhi4I9nTCxvaD4qb1
X-Google-Smtp-Source: AGHT+IFjjbvEeALxzGnisfRqO1VWpGZ6FOPcBFJVA64KLUcBabiM0AVQuu2EXYMYgxb4LiiFJ5aWzg==
X-Received: by 2002:a05:600c:3546:b0:434:9fb5:fddd with SMTP id 5b1f17b1804b1-434d0a07350mr13720895e9.23.1733222643100;
        Tue, 03 Dec 2024 02:44:03 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f32594sm187382555e9.32.2024.12.03.02.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:44:02 -0800 (PST)
Date: Tue, 3 Dec 2024 11:44:00 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Dave Chinner <david@fromorbit.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Linux Memory Management List <linux-mm@kvack.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, cgroups@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] What memcg lifetime is required by list_lru_add?
Message-ID: <siexzzafqmgtya5jas4v5pjpartt2h4l2amimjhaaztqidapht@2rexlquzrdsx>
References: <CAH5fLghFWi=xbTgaG7oFNJo_7B7zoMRLCzeJLXd_U5ODVGaAUA@mail.gmail.com>
 <Z0eXrllVhRI9Ag5b@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7hgwm4vbrllohur"
Content-Disposition: inline
In-Reply-To: <Z0eXrllVhRI9Ag5b@dread.disaster.area>


--f7hgwm4vbrllohur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 09:05:34AM GMT, Dave Chinner <david@fromorbit.com> =
wrote:
> It's enforced by the -complex- state machine used to tear down
> control groups.

True.

> tl;dr: If the memcg gets torn down, it will reparent the objects on
> the LRU to it's parent memcg during the teardown process.
>=20
> This reparenting happens in the cgroup ->css_offline() method, which
> only happens after the cgroup reference count goes to zero and is
> waited on via:

What's waited for is seeing "killing" of the _initial_ reference, the
refcount may be still non-zero. I.e. ->css_offline() happens with some
referencs around (e.g. from struct page^W folio) and only
->css_released() is called after refs drop to zero (and ->css_free()
even after RCU period given there were any RCU readers who didn't
css_get()).

> See the comment above css_free_rwork_fn() for more details about the
> teardown process:
>=20
> /*
>  * css destruction is four-stage process.
>  *
>  * 1. Destruction starts.  Killing of the percpu_ref is initiated.
>  *    Implemented in kill_css().
>  *
>  * 2. When the percpu_ref is confirmed to be visible as killed on all CPUs
>  *    and thus css_tryget_online() is guaranteed to fail, the css can be
>  *    offlined by invoking offline_css().  After offlining, the base ref =
is
>  *    put.  Implemented in css_killed_work_fn().
>  *
>  * 3. When the percpu_ref reaches zero, the only possible remaining
>  *    accessors are inside RCU read sections.  css_release() schedules the
>  *    RCU callback.
>  *
>  * 4. After the grace period, the css can be freed.  Implemented in
>  *    css_free_rwork_fn().

This is a useful comment.

HTH,
Michal

--f7hgwm4vbrllohur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ07g7gAKCRAt3Wney77B
SWSLAQDYSjM8dIWjMx78MOe0HwHi7Jr3Zy7NTu/rfkCngqsLhQEAq0eCFBipF6FO
zr4LRLdBi2pGv+clMNdjT1BSgdjqBQo=
=UtFx
-----END PGP SIGNATURE-----

--f7hgwm4vbrllohur--

