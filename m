Return-Path: <linux-kernel+bounces-401610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC69C1CE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CCB1F243FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EF51E7C06;
	Fri,  8 Nov 2024 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2eopDYR"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ECE1E765D;
	Fri,  8 Nov 2024 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068744; cv=none; b=PlE1PgNpLZ6mB6ZNhA2p0MKiduzjpwY9xThtCYUh0VornYeLmPHmbdOjMI1I5fhTHw46GGkTocYDVP18ZPJoG90KNEf5aoI/XLwzuNmdHzG3MtTAglKsIKMf7RQ1TFKqwj5Jty7wCH8eGdgPK4BfM49rC6JEPtXSq2IHlVYd2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068744; c=relaxed/simple;
	bh=98fO9xQB8CvgioBDPij7kcJTdEqb0xwMJhO0xcW8HFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM/nO7Te3jdurRvd+2RpOGy3acMNLFWz3e0DK/XvvrEU8WFu8MRIAAyZOdGzFh4GI4Aiw1JRuddEqr4vBeTrAyN59UZf8UcA1CHr8ccxcdnqJXspIeDkxQ4VcMfqkeYqjdSyWjr4wumXhmeb2mIW9k2ZJMIooG5I2LzmxMqGH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2eopDYR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c767a9c50so21276895ad.1;
        Fri, 08 Nov 2024 04:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731068743; x=1731673543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOmvvKhJbEZ8J+lBfNZjxAZ1KpCrP3dOe3+qAGNbpVU=;
        b=Y2eopDYRaAWG8ITORhH0XBee5w25082Nx8zXZLxQNYHObGRAuLTf8CIV3enyWnyiZ1
         bWUEiz5c+lYXCkmYsUBlotf2bBQzjebRgmA0QC2z4NGkWw6t3PvBCaT1wX0qo4Y5DF4p
         /ZN44XWLOOP+cEUCeok2eiGG2VyWXQbJIiYcBP255GzNzxZHMj/UzL7Mc0ACr6xa0Nzs
         4Y368i+5AqoKUCIvWcU8kIIP1eS4GcpU11ZTbaoi2Y0dZXF1C+zc2XEV7YmHzZMFc1Jg
         FgCj2xShGYRHw6qeV29g7wPuUeZewSIACJ8NViJFUoHY3TJnRNTjR023fWS1pLrCy34e
         EeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731068743; x=1731673543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOmvvKhJbEZ8J+lBfNZjxAZ1KpCrP3dOe3+qAGNbpVU=;
        b=Jgid95m0zIDuHopbhKXQbMFHQy7WtnglcK5QtkNcRenAXmr6ZHypVw8w7b38dEVOWp
         WJDEFc6xnHY+TrUZ6PxlQIMHp4XpxoBSWDR2MvKeJrVPG0/jJhDsigm++EXH6Ica+/z6
         K1KHUXerw8cyat1niOVZU9rAH7/v/m3tjqb8zGYyqJFyFSPUEZpdZ1TyLg5ZYJr+bbpj
         LDzfYtDrLglCdxNv/pLfFhHrAXAF5PIG59T9f1lA6TqL9UnDVYXwtS2bDAYSy1zPL0CI
         JTMoEgVczUT+bswn8MVdYFpR6L7ocVrdknPa1Bn8nix5bKGUp9qXQ0gi1WM3D6V7u98O
         LbVA==
X-Forwarded-Encrypted: i=1; AJvYcCWu0cy7XGtyU4kt/kHU8JxzZewg5C+hbvslFq0uWwrCD8PueXBCdzF6mLrcB6+l/p2BYuFWx0PfRkXyqbDO@vger.kernel.org, AJvYcCXbHVxkev0HEMvqaQuYOStKniXjfO4W9WLvWsDMQPuYXON7y/AcqhRDwxF5pBsZJRMNShx8Zj60+n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR20pF3zICx6KZV4PixP/DQvF3G5UygzATNtr+lNfRGDr5keQX
	z+b6F0H6bsv8F60uwTUxh+t9kcCac3Syj0eGCYmVpOiHoA+/49Eg
X-Google-Smtp-Source: AGHT+IHJ5/cQ9rbRvukjTnPNpTp4++CL+48QStdopubqXyhfVkP8jV4apmehVMsZ0ui4hRbniSZJMQ==
X-Received: by 2002:a17:902:c949:b0:20b:8bd0:7387 with SMTP id d9443c01a7336-21183d7cc6cmr29256495ad.52.1731068742350;
        Fri, 08 Nov 2024 04:25:42 -0800 (PST)
Received: from archie.me ([103.124.138.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc9073sm28931265ad.1.2024.11.08.04.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 04:25:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 44A6741AD6C8; Fri, 08 Nov 2024 19:25:38 +0700 (WIB)
Date: Fri, 8 Nov 2024 19:25:38 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
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
Message-ID: <Zy4DQmWHpC_QMGTP@archie.me>
References: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MO04lssU+mkApaAr"
Content-Disposition: inline
In-Reply-To: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>


--MO04lssU+mkApaAr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 07:01:37PM +0000, Lorenzo Stoakes wrote:
> +.. note:: In instances where the architecture supports fewer page tables=
 than
> +   five the kernel cleverly 'folds' page table levels, that is skips the=
m within
> +   the logic, regardless we can act as if there were always five.

What are being skipped if e.g. we only have 3 or 4 page tables?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--MO04lssU+mkApaAr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZy4DPQAKCRD2uYlJVVFO
o3s+AP0aUDqcRJ0rPGFSjziXj9/+tetBw9hi8dExw5A9cdVnQAEAyESYXfMxc9wq
44VY1iUrCTd6+/4QbgicjMDx/9xQ1wM=
=4GGZ
-----END PGP SIGNATURE-----

--MO04lssU+mkApaAr--

