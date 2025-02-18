Return-Path: <linux-kernel+bounces-520297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB1DA3A826
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D90B188C576
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6261EFF94;
	Tue, 18 Feb 2025 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzW+KkBx"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD41EB5CA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908429; cv=none; b=SeQV5NUjFGhOsuJW9QwEOuviOjvFcaIk8PgUig2ZpNLWUj+opIIRV5uBpQW9hoMs2dDOS5yLOrWa5+CWbpd8u0Njtw/E4cfgEdmpkqqmZjJTqx6S+j8Z/bp+H9wXhfkmO5vjk/O4b6ee/ndwedzK3Tjw7c0tIuLiMxRQKQVcWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908429; c=relaxed/simple;
	bh=etJYd6VC24ah8kdBhkG4rqY+vIZaUIDWL/AZdFtvCOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IH5lV3W0Skx6Mw/W8I5h/oJnWCxyvEthaBsAbiYQa2Fl6p4va+2mHpEMdD+1Bl5yOYPDMYZSdk64zcWRs2qVYlNDTFRNk17ME2WR0+9cAYeb/Lz0hf2BdgYZZSz1Hh4g1gqaPc0SRkNiwvWIG/fDwf9WWTZaWpqc11KYkwfsOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzW+KkBx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-438a39e659cso41053735e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739908426; x=1740513226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYMHtedu2RkDcedr/ZB86DaCSOrnLAFrvmqyAZWKjac=;
        b=AzW+KkBxb7VuSH8jRdBXu+X7h6/8yF0HfBXHlPAFOyE7PD3J5pk7RijPqnaLw1ZgjF
         lKx74tpulwDfZ5+43kYYAkLmttg89trAidwJ2n/LR44VDSkUnds55xcUnI/HH85Svda2
         guBmVxh2KIS++DJ7kQJpZ/MWqppxsPeYLR9Yim2bKZVWYNyDrHKkxCOfQL8NrITPm9ws
         VRfBW2iyh1FRxne4vK0Fgqcl9B6cgrs8eOlNMiQJcq4wqiACamPIKxEEIgVGsc+rSAr+
         wuFqQBYsUk3gAhIW7OwWQgrcs5Fha8PrVzx+wVhzWy4Jg3e3+D6PhwOb+tDSymidzSbu
         8BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739908426; x=1740513226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYMHtedu2RkDcedr/ZB86DaCSOrnLAFrvmqyAZWKjac=;
        b=d6OXOyjdabzo7eqzthacroPDpVelYh76CF/k8UUjfJJAH4lB5JyTA2Tbkc6mIJZSC7
         XH2fUi/QuWeYYV+uor4Mtlc4c3PqkF3gYNffi8+fnBgdX3kxzNCO92yvHfb41p92cRyF
         8diyT5QAi11EuEAHPpWXdOMXed3rVfJJVK1cFkYAIZ6WnR8fC7vflNj79RAhI1dfCJFJ
         dZO27JLDKJXPsKhGab2FpMrqp+DFfNzg5noY23RSW/GC9cDibyKpSvh0U33llFfj3kEd
         DghbkdRYcPjogesPaQxzQ4ot4s++jMQQMPMbcmP+RBSBY3AKIv+wsjlTuuQ+hCINk9+q
         lRkA==
X-Forwarded-Encrypted: i=1; AJvYcCXUbGjXDCmEjzutS6rX8QR8QF4Q+e2TttK1TPV791bvL7GXvm62kse4HS+/+93zUhU2+iIM911XMduC97A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5OmxM8lMt1BYSjp7qEg2MDh93wP9i45p8OCRelAvsqjZZVi3
	SXDlJR+TUNLOWarqZXm0yLkenwAbC2M0Xu1DLDxqfJUFjDb0ffP8
X-Gm-Gg: ASbGncuPVSbYgAe2dO014pYagO8YClx0pDjxD+kW1UL8Qa6dmkKQhSTLIefG/q8DxJQ
	3/v2wgSzDfSDu6XhL/FJwhGpRkV/a10/NeeukD1xQelKgAJH8aBEgRSRA92zagbjva6xhA1pPmr
	ItVmebbCsT03AuN4J4ll2pzhrjFNGuazakumqw6r6h2CsMof6n04mBUJqn+YwvhNM5MWDeRQFxC
	iJeQhizbvZIX5nySjv8iglmFeXP2bZI3RZt7rivZAxiBofBxpWSU42n6ZRcr40p1iKyH3dzB1uC
	7IYM2ktiXmfPH+n99wvUlFexMXnnvStWpQMMTIxSpmMxzqgUQax6eg==
X-Google-Smtp-Source: AGHT+IEVzhGLDFw0m2CxrU8xE0NL3g5D882Hv0CJvkZ5WneGTfQV7aWsK7afVUQ8OMm7xDV09B8LJA==
X-Received: by 2002:a05:600c:3548:b0:439:8e95:795b with SMTP id 5b1f17b1804b1-4398e957b86mr60901585e9.31.1739908425796;
        Tue, 18 Feb 2025 11:53:45 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5f4fsm15885782f8f.78.2025.02.18.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:53:45 -0800 (PST)
Date: Tue, 18 Feb 2025 19:53:43 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Carlos
 Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-riscv@lists.infradead.org
Subject: Re: fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x'
 is never less than zero.
Message-ID: <20250218195343.10fa6eb9@pumpkin>
In-Reply-To: <a14347d2-6189-49bc-a1cc-e5959e76e6c2@ghiti.fr>
References: <202502171326.j4Xd3I0j-lkp@intel.com>
	<20250217092445.GA29568@lst.de>
	<a14347d2-6189-49bc-a1cc-e5959e76e6c2@ghiti.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2025 13:06:49 +0100
Alexandre Ghiti <alex@ghiti.fr> wrote:

> Hi Christoph,
>=20
> On 17/02/2025 10:24, Christoph Hellwig wrote:
> > On Mon, Feb 17, 2025 at 01:53:08PM +0800, kernel test robot wrote: =20
> >> New smatch warnings:
> >> fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x' is neve=
r less than zero. =20
> > Looks like this is an issue in the riscv virt_to_page implementation
> > which also shows up in various other places.  Any chance this could get
> > fixed in the riscv code? =20
>=20
>=20
> To me, the only test that could give rise to this warning is the last=20
> part of:
>=20
> #define is_linear_mapping(x) \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((x) >=3D PAGE_OFFSET && (!IS=
_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
>=20
> But given that the config is a 32-bit config, it should not be evaluated=
=20
> at all.
>=20
> Could that be a false-positive and then an issue in smatch?

It's not managing to try to build when:
#define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
is zero?

I think that is supposed to be (near) the user-kernel boundary.
So probably 0x80000000 or 0xc0000000.
(or 0xe0000000 for some old sparc32)

	David

