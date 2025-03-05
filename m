Return-Path: <linux-kernel+bounces-546502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF04BA4FB6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6EE7A7F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C31FCCE8;
	Wed,  5 Mar 2025 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="evPzm6hF"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B52063FC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169547; cv=none; b=GLcdpejYcj/wKtoSVBofiER+dqmfqtdBxE/KSgwlx83o91/dLT2vOtY1cQHYGGrstYxs6mOPw/LHaJX2xHOkP3UgVmZ00vQME18vSd+u4Bdu39vAszHBWa0PoY19TYuZOQzVBaL2WsnRaDEcIm5gGOhTYn80LxLmsxPCyGya42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169547; c=relaxed/simple;
	bh=4rA5mEK+MS4fNeVddqD3H/IjHGdBG/CHMImylytnnb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6T0dm7o5rtYrw9iZuw7vM083jTD3Hoot+7dP7n0NMnBzuIFm8zARZzNE4gQG7Bui56KjiGYTDQd67PcBNbiXNUPdhS9BFaAWg4xptc/liAJiUqyj2IVvqjxEKd8+tz53Lb/xiFRWi5aTJXnTZPPpQHNzOaKX9ZQA08jmL0nodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=evPzm6hF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390dd362848so5103814f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 02:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741169544; x=1741774344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JK8Y7F0M6yt4sxuseFTO5fZ7Aq9PRgVqCQhiIQOhMVg=;
        b=evPzm6hFp26Ik6t8XzJnpUCaz36cJSmmj9/vyllQTOqdID3VQ5DDSD63NCrNmNVLdQ
         ZNeH89PeUDjqYZRVxyGVCLpze9yMYENulKYXDeguvaqz3zUM4QLG99R205vwNIERsWcu
         BL5nNQ/ddFQwSUrtMuO3ow4ENIJajOwfOqmJb8TG/PKHVA4KjJLIBu2ZIf8eweLniTEz
         72JDBFFcODRwTahSod3o9lEav0g9DK5wPZB8mP82HSbhA3D3xEcCOFBdbHBi8JZQq+28
         4GnpKhF/lb/VJgEp4zXkRP2LU0/LZ2D8cOdcv5ilTTtkuP65AXL90bQ7w1LqfrEsQpSF
         OHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741169544; x=1741774344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JK8Y7F0M6yt4sxuseFTO5fZ7Aq9PRgVqCQhiIQOhMVg=;
        b=vu08U3XnDzTkUyoT+Nr5043ySSw5C0YlxNSW2juG1wYLN5RHpJAQteOCjg1YOHX0Px
         RltfvwDcbpRqtlAZH1BSp9ijcAfljpD6c0Xie7m0uSQL9ZxXCOzMpSkk8X1FN9UQGimz
         BUbIKDy87EjNB976LQLAk3y0V9Tder5CUbyl4HETOiC64rsRBW1akilR7Tfj9wyo92Xr
         SdW584/cmhm9DpYxDwHOdRoeaMxMwznUT9EUtL8eCuHW37fNhmQNd09/iT4N1RtO/ArC
         erFynxJkcJ9N98mv4iJD76f86cu2Xr03Kn+OAWeJx5w3huLP6Hy/dL1gsejaYkhyDuja
         Qy4A==
X-Forwarded-Encrypted: i=1; AJvYcCWcNfmf7gyk6y5JzfG/u/hlZhu+hprXimZ9ffBj3h5k/wnmwm28+jfj0tlU4p1KhL0cWZB0asKMA37Ik0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2xMSDBn7bscMzHNocalHak5EtxUHrzeKSzLjpcpmho+2hwZoK
	Eqd9Bd+DjLsgF2rH6tl3TUY1HcToE5+e4dymjwb+ZQTsDBCYe9tRtRcxtGFLq2A=
X-Gm-Gg: ASbGncuygUWZC8DlKiW/U/gZKXVCoQGJbeTUZHnS7fI0AIVhkmzScyQHuqw4JZtm/3c
	LItYwRMHVzAeBIvT70K8w4H/VQ8BnPdO5HSE8EYqskzFoovxvuYvhTax63usxN5O6urifNgWCZV
	8/QU/xa52JlIabqu9ERsiMKzgpPP9YbmTGKVzi8uboRSNIsvYvA2nnVJm7I1ZtFfbfILX4JfcHz
	nvI33Nzdynzql1De730OMQj5hlnN/yR9WTUEe4mAmq2mxhu/8dIVi2J/lFX3iNoQbDoMn7OJcSw
	JbarhhRXaTC931hQmcubBXO7xJyHPVsyS0uGtOtXS+pt9/w=
X-Google-Smtp-Source: AGHT+IEmna6voY68vbZUHryvS51Xec95FeWivkSUZHU6RdAxXB35kR9fsC6gZZj1O0MDgQ1mVFz4Pw==
X-Received: by 2002:a5d:64cf:0:b0:390:f552:d295 with SMTP id ffacd0b85a97d-3911f7c9ca7mr2048791f8f.53.1741169543647;
        Wed, 05 Mar 2025 02:12:23 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d8e4sm20168761f8f.85.2025.03.05.02.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:12:23 -0800 (PST)
Date: Wed, 5 Mar 2025 11:12:21 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
Message-ID: <5bw7yc6bacojk2i2ikhlmf2skfiix6t3ipchbnvyfttmyh644j@iyquxeuyapd7>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-2-mkoutny@suse.com>
 <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>
 <Z8cv2akQ_RY4uKQa@slm.duckdns.org>
 <n2ygi7m53y5y4dx5tjxhqgzqtgs5sisdi27sk7x2xjngpxenod@7behfsvlzhxi>
 <123839ed-f607-4374-800a-4411e87ef845@redhat.com>
 <Z8dAlvRnE28WyOGP@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kodlwgikrlg6std3"
Content-Disposition: inline
In-Reply-To: <Z8dAlvRnE28WyOGP@slm.duckdns.org>


--kodlwgikrlg6std3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 08:04:06AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I'm apprehensive about adding warning messages which may be triggered
> consistently without anything end users can do about them.

That means you'd distinguish RE (replacement exists) vs DN (dropped as
non-ideal) categories?


> I think that deprecation messages, unless such deprecation is
> immediate and would have direct consequences on how the system can be
> used, should be informational.

I could subscribe to that if there weren't so many other places to
evaluate:
  $ git grep -i "pr_warn.*deprec" torvalds/master --  | wc -l
  62
  $ git grep -i "pr_info.*deprec" torvalds/master --  | wc -l
  2

So is the disctinction worth the hassle?

Michal

--kodlwgikrlg6std3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8gjggAKCRAt3Wney77B
SRmCAPoCVnQ3mtHJRXQJXO38NpVCV2CLDqm4CBIDteO2hv5JfwEAx9LG33EQ1YVO
M4iXA2i0xMEByWsgAdo2c7ZXsyvvWQs=
=4wDE
-----END PGP SIGNATURE-----

--kodlwgikrlg6std3--

