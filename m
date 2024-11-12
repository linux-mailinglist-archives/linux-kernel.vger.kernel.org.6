Return-Path: <linux-kernel+bounces-404999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056F9C4B91
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1060B21884
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B4720370F;
	Tue, 12 Nov 2024 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaxTe/nb"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A605234;
	Tue, 12 Nov 2024 01:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373979; cv=none; b=gRMMrK0Af7V9BMR32mDLU75K3zcF+1DjFVIqhKIg3QYuxw78aheXrk7goybd9/vTtI8YuM0ecqOzwI/UXTjNM9hQR7Mu2qLY5SBHNTPUi1QVn6nbjkxYnGpe6BingadlGiv6vdECDSq6jkYy47KPJ3bGrCwtDXm45oV/LCXLbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373979; c=relaxed/simple;
	bh=ftmn0imYn37BRWPPROC0VBNKjMLbbrW8+cDXcgpP2SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsHNtLdxQUkQDXt4SlG++gJzeWpxRgtgV3Q6C9+lTIgBToYllo+9L3SMVYMfA83Loyb6tFg43FWABq8lRMt3y9mUUV8Ewf200t8sAIANQXtEyxaYyoBa9TfqZimK6xP3LTTcCR26DHUMcXeNMRK35uebpettzl5SHvJiOKZ/uiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaxTe/nb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so3571904a12.2;
        Mon, 11 Nov 2024 17:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731373977; x=1731978777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeFGGUGpEi1sr9HlTgC6+whcNglqJKLIMlkMEduoEoI=;
        b=IaxTe/nbP2rLpcYIFD1Dhcq2i5L3sB11Y83ZDbpfUCRIGwcy9C1PMLM0J2AwPu1lMG
         wT/0TY8FKVOFmdnq5AvQNQb/8BkurdJl+xqA9v92X/ZWYIOKeU7fvoWZQcV7peGfQuiu
         5otGo1WhfEKNEulvzzMqGjmZYGtmH67bT7nJ6fkeuBFJ0ckCa8nKAtGPGAW+mGbwyVGh
         EP4WFpxBaCkeoDEaODru/X/rXJ83JmtA+wAagwkHmhcW/wjkbyRnS/chEXXT5tIlDn9U
         nRxY6mt+S1GQLDW+QS3/9Rw7ZsoeV5z1fWQNzd/2xMRg4EN8zKa8ZwCtykKBYpl7KVdE
         N1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731373977; x=1731978777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeFGGUGpEi1sr9HlTgC6+whcNglqJKLIMlkMEduoEoI=;
        b=hpJEW53v9tUScURS4FuG9JQbYkoKoVaKtIxQuxt7sytUSzVjI0InQ570DVlLJDcPqX
         2YW/N35hlcn97G8uPTd/iXjuY+gMevDEbeiIa0tgnhPkksH5eGPqig0WRUJV4nxEn+4Q
         ZsIahGQfbUH8pBv+6RSmWNQ+jaHf05FZhg1EvtJNPqZp6GdFgcsC54nkRm/20BoF+TWW
         A7yg3XJ9xUy4KqdDxHIhon0ypJt91KM0nY+gGcPAyX+kTnC7JxeAU6jRD5r48DqIWgL3
         k3WZ49aB/UjrXtOH0qRvGfhl6wQrgPFEAlIEskOmffkqRFWxoyqcWpzPvsd+22V42u3x
         nN4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6KKZ/d/fozxnL7HxGfbWJS5H+CkJiuZNot7hNX9WauRGkutgUtzFbHM3GnQdStAW8TizAycu2F8uUF+Q@vger.kernel.org, AJvYcCWh4E+lhiUknZ4QVG2zb1E/GeXych6De6vem/uG67tOHtdrU1S5ucqUMicAWPEJcNfu/I70AY1BWfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHkDlA8ZJ59KldtEU+0De+1hXOmRfc2GIAzO+XF+pp9c/6zAam
	h4nJyNRMk754PuwsqUQotNU5+0yiEJNSaYd/gjBY8pb6qk/5ZNoq
X-Google-Smtp-Source: AGHT+IHV65Fyb7uDakHlevNL5cpnf3GAtcrRB1pAKYFi4Ty++DVmIHYNNPVEBBb8riwugg9HJnK1ug==
X-Received: by 2002:a17:90b:3811:b0:2e2:bf7f:3369 with SMTP id 98e67ed59e1d1-2e9b16eb57bmr19784671a91.5.1731373977187;
        Mon, 11 Nov 2024 17:12:57 -0800 (PST)
Received: from archie.me ([103.124.138.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5fd329sm11378008a91.37.2024.11.11.17.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 17:12:56 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A0CDE4209E61; Tue, 12 Nov 2024 08:12:52 +0700 (WIB)
Date: Tue, 12 Nov 2024 08:12:52 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] docs/mm: add VMA locks documentation
Message-ID: <ZzKrlEAjzZ80M0ik@archie.me>
References: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
 <Zy4DQmWHpC_QMGTP@archie.me>
 <b81e4cc2-fc86-4ed2-996a-ad78a3524f31@lucifer.local>
 <0d540192-3372-48ff-99fc-e8bfb960e3bf@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Gp0QloTQ6LSDedi"
Content-Disposition: inline
In-Reply-To: <0d540192-3372-48ff-99fc-e8bfb960e3bf@lucifer.local>


--+Gp0QloTQ6LSDedi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 12:34:23PM +0000, Lorenzo Stoakes wrote:
> On Fri, Nov 08, 2024 at 12:29:15PM +0000, Lorenzo Stoakes wrote:
> > On Fri, Nov 08, 2024 at 07:25:38PM +0700, Bagas Sanjaya wrote:
> > > On Thu, Nov 07, 2024 at 07:01:37PM +0000, Lorenzo Stoakes wrote:
> > > > +.. note:: In instances where the architecture supports fewer page =
tables than
> > > > +   five the kernel cleverly 'folds' page table levels, that is ski=
ps them within
> > > > +   the logic, regardless we can act as if there were always five.
> > >
> > > What are being skipped if e.g. we only have 3 or 4 page tables?
> > >
> > > Confused...
> >
> > Page table levels, see [0].
> >
> > Typically achieved through stubbing functions out, etc. So in the code =
you
> > actually write and _conceptually_ there are five levels, only in the fi=
nal
> > compile you might have things like p4d_present(), p4d_clear() etc. squa=
shed by
> > the compiler into nothing.
>=20
> I have updated this note to be a little clearer and to explicitly state
> this. Thanks!

Thanks for clarifying.

--=20
An old man doll... just what I always wanted! - Clara

--+Gp0QloTQ6LSDedi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZzKrkAAKCRD2uYlJVVFO
o+QEAQC3UUEVhh8+C8OxopbfJxfhQ2VLPMXNmz8Pj5PI6SrwiwEAyWHohtsNEZLZ
noRnYz2AfUf9iN/zzJYJsrQcPjyjxAI=
=BwYe
-----END PGP SIGNATURE-----

--+Gp0QloTQ6LSDedi--

