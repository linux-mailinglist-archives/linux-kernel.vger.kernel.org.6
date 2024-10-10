Return-Path: <linux-kernel+bounces-359696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DF5998F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0D128B799
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA08D19D891;
	Thu, 10 Oct 2024 18:00:08 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC819995E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583208; cv=none; b=Wai5+EtAhqS3YUhI5DLbFHNih4xPVCkRXibk9SXU/E8rhJCQAM7VK90uXkdwK9yxcQMjiFtnp92LH+pH+ytJHIE+5NtXRzZoBFT00SeJFOFYDn9DpbO/qG/yftag3ymiH7pIGisTc6dfVTzKwHX92AwHNYIv6V8cNJ7/kLvSJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583208; c=relaxed/simple;
	bh=QJ2zfq/ihM40bvo7jPn/t5ByhVqbqURE9eVS6//Wse8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSRBGcDWj/uDR1iG7K+eThIA1bsaiqpmBXcXw1j9Mh8NJ4m4FcAWfu69tEHgySItEcQ9JeaLHF8I6NebyNH4zsrzxHyk9MoL/1l878JHgZEoKhS0yO61BMOW2usMm6SjFncpP0bK6cT1F3H1X0B6lIsVenxdZJqMmSuGVDa8+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e23aa29408so22107467b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583206; x=1729188006;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ2zfq/ihM40bvo7jPn/t5ByhVqbqURE9eVS6//Wse8=;
        b=oOstqXYEwiDHvW1zkPZU8pL+gUBtND2ZqU+aZ6yJuIu40GQgh4vjnRoRzxBFviNwSr
         yyjrnChlufcDQDZgI5QQQ4YEqClisdNMvR6nCVGZ7nExQCSD/sJMG3sFDs0HWN6HHnjt
         UcdcaiXs1Ag6+yKnq0euZtxn4czzqf0YJTLeQxBxUXq/V3GUS7U/aUPDnP2YrhKJ07ox
         m7r6i1ln9P6xYMDpUv/P+3OgydU6VRbwOtY1btccnRkzH4gGdfTB0NA8HheTr33mzt3F
         jy7uBX1Vk4k0jFsRKz6MYaIrN8jUOuiF99F8HT+tLHCnSDAitD/JSXNNuHINM3Ffjabo
         KfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbHUG4jTEwhkAq5XAcCikrAHso+xvFS5sA8WBBJl5Lf++rrEoiHEVyASAqvecx2cQr5WkbOWmwao0eEQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vcyl+3i7945SWpVrnVGYYr5EqVbgJ5TAnATK8oSJxJEGQS6d
	JKbJuZ3LPRj7lxMg5NbKQHMBUJyzHeXE1eud9xOa5FeriJZlLnWJ
X-Google-Smtp-Source: AGHT+IGoYvMLLHvv3XkUvdfM9eJxLe6e57cIudjZpDZQNS1kgUqEmWiQDPHc0kyKAqngqmSoQtCpvQ==
X-Received: by 2002:a05:690c:e0a:b0:6e3:ceb:9e49 with SMTP id 00721157ae682-6e32f27caa6mr37167847b3.16.1728583205702;
        Thu, 10 Oct 2024 11:00:05 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332b61587sm2920317b3.15.2024.10.10.11.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:00:05 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:00:03 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 2/6] sched_ext: Start schedulers with consistent
 p->scx.slice values
Message-ID: <20241010180003.GB28209@maniforge>
References: <20241009214411.681233-1-tj@kernel.org>
 <20241009214411.681233-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y5PDlze9/8RE8Hp8"
Content-Disposition: inline
In-Reply-To: <20241009214411.681233-3-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--Y5PDlze9/8RE8Hp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 11:40:58AM -1000, Tejun Heo wrote:
> The disable path caps p->scx.slice to SCX_SLICE_DFL. As the field is alre=
ady
> being ignored at this stage during disable, the only effect this has is t=
hat
> when the next BPF scheduler is loaded, it won't see unreasonable left-over
> slices. Ultimately, this shouldn't matter but it's better to start in a
> known state. Drop p->scx.slice capping from the disable path and instead
> reset it to SCX_SLICE_DFL in the enable path.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--Y5PDlze9/8RE8Hp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZwgWIwAKCRBZ5LhpZcTz
ZE36AP9M46WDjTFZt2RAgH9stOw+fpXF2HXEUf3VXwln6nrnAAEAskFw1wyZgRmw
jj8ALw8B/dVpV3JR3NKn+5msf9U3bQ0=
=qSC8
-----END PGP SIGNATURE-----

--Y5PDlze9/8RE8Hp8--

