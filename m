Return-Path: <linux-kernel+bounces-429922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13CF9E2900
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881D2167D11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9E71FA252;
	Tue,  3 Dec 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KX/JK9dn"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34771FA143
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246493; cv=none; b=Vq48NJlP9eLvrw9T9yDHNlrw6vzan6NRFwt38cR69VaYtxom+gccSp4aGpgiIPPtvtaxuo275TBGUJOVSdI9Wyb+CsJoZQBZUFTh19wTRwFkS7qt9scLUM3vWUCYNkgx4lQbCu+OHhxryC+PNkFoUXOjctnBNd/t5FR48DW7AZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246493; c=relaxed/simple;
	bh=UabdAmxW4iE3HCj923Mvs/XV3GeZRVmEV4euSp39PTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV26IM3/u3VHva7kb+vxthzv38V75OGOwHSaVSVGoGCPTTibgEv1uRrITxRMWtGIV6gvt+UBL61UPRbniXdtwWgpX3KQ5s3pe1H6tpFtOsW/tjPlA5wvE++5v45b4L67wsSvMHYKWMnewxcBsY3foT9gFkJHRZJpcHVf1wX11+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KX/JK9dn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385ea29eee1so2223450f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 09:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733246490; x=1733851290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UabdAmxW4iE3HCj923Mvs/XV3GeZRVmEV4euSp39PTI=;
        b=KX/JK9dnNw8P/YQqyowMXw5y7s4z9hn+6nmeRHba86UIEuDPJgZQy4R13rqCBREZ1o
         4VwKgGyPbyYBaTSxmOklQnpGmS0dg79SlqelRBcN0btizg6HHuAkqInS/XVCJtAB7e1Y
         1I0tXoDsozdjYRaF57OVuTJ55TYcOMHq0dNjGaQ2dFFXs1JLik8FzThowrrxtb1rUQ/s
         4rKHYYMPpOaOXwXPWZGCuc8U4UoeOZ5qRH0wfTAheFnfgaskSk569cPI1ajpurwqXuIR
         ekZkdR6CFxEc/bhXbZ+qvuY52oor0AUILZZeinZXddXu2cWlUin17r+Wy88Wb0raJXuZ
         oBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246490; x=1733851290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UabdAmxW4iE3HCj923Mvs/XV3GeZRVmEV4euSp39PTI=;
        b=JusbJ0SeBlADIqPbsOksdrqZtOCkvYL6AO3Dv5oJndjcwa/ZIs76+HqK5sTlwz2baX
         KTaJZ1JuQ9vBi9QSgg2xKi5XRUgOq0MBlw9E/Gplx2XhOFiE9uIAiZEvZQj74uOq1W4k
         MTTs9tBFU8I/K4oNueyBzawRSiQvbzl6PENjoDfGNERCYqa9t3A3leeTsvYfG/hjXV9d
         3SYt1Xsk2k4G8OjP5tfqNNiSpweU/0km6kzn7od9kno3ozdeVvzjKhYeS7hQLj7RAdob
         rvG5IhoQcKhNahJpnfo3UgJ8kafQprIiYvJ8Xdv9e34gXH7j0EO+JtrPMSbg3/5JPp9K
         Dcug==
X-Forwarded-Encrypted: i=1; AJvYcCXEYJPiGZobAbSh3+OIMd/0aIiNr4bNO6LTHbWr93EqkynfaF1wYGfMk2ZF2WLHNiND019fL7g5kRi4mGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUReYED86pdiLgvRVf2mcoQAWkACmgSIN8OThz3PoUbnrIwlc
	Byq0n0wFUFqdBtjVwcsAKOHLi54Kpkjfk2VnDlVmLAEDzMP5bN9kHFzg1mPGYMs=
X-Gm-Gg: ASbGnct37ldSxHDqusizaDP/mg2uYb3fSQROTAGtTRYFRyigPvJs2vzcPBUyHXijfrp
	RWejlcSovPA1g8wQSho8k6PWZ57Qt0QUUNIB+cTG1wMjvyfyBOX3V5Lc2g7gd+AUNzZ2l0Vpz6/
	KBxupax7UA5F06Cb8L9/+sYCACq6WM4e0ViXvk98Pno3LhVxCUUmifSTvqVqlxR2m/4jcLjqIjI
	JkpHJXBIrGWXUXqP1SzWpZ+yV44MHegnjo1ZuqSrpcYrQxOpsTZ
X-Google-Smtp-Source: AGHT+IFAVLeR/VCqDDivv5WBkU6ndwqS+HtMqvj1VsZPkcypvVdGfMDVfTRGiVRLl8k2UTyFOb34pQ==
X-Received: by 2002:a05:6000:1f88:b0:385:fb34:d585 with SMTP id ffacd0b85a97d-385fd422f21mr3008006f8f.34.1733246490004;
        Tue, 03 Dec 2024 09:21:30 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385deeb6acdsm13557678f8f.81.2024.12.03.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:21:29 -0800 (PST)
Date: Tue, 3 Dec 2024 18:21:28 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Remove stale text
Message-ID: <hjyhaosr2c5dsldlgzzsqedxzy3xd2e74ibtpxguz6ymbzqu2g@zs436iuhlnll>
References: <20241203095414.164750-2-costa.shul@redhat.com>
 <8a50e837-a1a0-4636-802b-4573c3779aca@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ni7zsj6n6jf2dduc"
Content-Disposition: inline
In-Reply-To: <8a50e837-a1a0-4636-802b-4573c3779aca@redhat.com>


--ni7zsj6n6jf2dduc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2024 at 10:43:26AM GMT, Waiman Long <llong@redhat.com> wrote:
> Thank for noticing the stale comment. There is actually no task's cpuset
> pointer anymore.

Yeah, that likely evolved into task_struct.cgroup css_set pointer. The
"guidelines" for it are in sched.h/task_struct comments + comments for
struct cgroup_subsys_state.
Also, users may need css_get()/css_put() if they needs subsys state for
longer. (This info isn't actually cpuset specific.)

HTH,
Michal

--ni7zsj6n6jf2dduc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ08+FQAKCRAt3Wney77B
SSKCAQD5u/68QHfqvtaQT1vC4ECCc5Ost7uNOG2bAMS6QeICqgD/XS/xB3P7ys1f
mM4dOhUm6qULlkY1+KSiTv0mjwdkWQI=
=Vuho
-----END PGP SIGNATURE-----

--ni7zsj6n6jf2dduc--

