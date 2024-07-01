Return-Path: <linux-kernel+bounces-235900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7BF91DB0E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A29D1F21C65
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A63784D04;
	Mon,  1 Jul 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfj2ubxg"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A555C614
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824874; cv=none; b=hDd+gbKDzihW/F/kdg73PyLUBWG4P5Vd5LAjaLlAgE2Ch+ZzJDmapQ83HB3f/D+gggziw1Oxzd15dz0F2zDRkv/2Yo1781RJDjAvv6EXTp4a1g3HxwBjoYk5hlyXu2ZU05W16wfRPQEQ+jMW8xUpGkgA6GXNAi1v3xerlJgiEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824874; c=relaxed/simple;
	bh=x/KFL51JXTIkDF6sc0VQ2KeqoC+PcGy2ITuElz//u9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhc06KUWr0Gfj841y/siJImikFEoeuUQmELzZOUeIK84Xd2bKLslADi1VI1CULq3s065c6YXsoaaeBC1PFJujxm+PIDsLDRiVClrL0dIn969IlUPC9TN9LT+OcrQ1xA9tSS9CoFsWmau8AtlYHMbvFJVo5L8U3/OGBROUYMape0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfj2ubxg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9c6e59d34so21203045ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719824873; x=1720429673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x/KFL51JXTIkDF6sc0VQ2KeqoC+PcGy2ITuElz//u9A=;
        b=dfj2ubxgF7tyjU5qtWpvRkmR83HCJuoAcJxIhA7zvji84EUfinIGa+7hqQokswiH+q
         PNtXyTpvRAJ+tFAYqfH9nuxntTWRWlbhLbE3OkTrucyEZ6dctFYtLFsjOtS08K5Rh+W4
         BOn/9c1BxLr6+r84M8mq9mxuuD5G5ruAdjMQTfHdQJ/8AVd2twGpKCahd5A5wCzpyc5E
         HPl9NNfXrM/tql0IyUSQpwtkiw5IfLSDLasaQzBclsCfuT4nL0hS82T1IiAzb46KQLSe
         PSHxROnOwqZIfOyCTN7ykbEOriqxKorZ1FQUO+BJPjQoFUMdSSkfO0AjlZYbVe9E9KAv
         rEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719824873; x=1720429673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/KFL51JXTIkDF6sc0VQ2KeqoC+PcGy2ITuElz//u9A=;
        b=tlZoo6V0x5RbxVFKMF9sEiM/7Az7fa1w4U7ExfwlRuDVBaY85n2H2MADxj8+7pWypf
         c+ZhpLyU9KbpLCbhVQf/gvuIhefsw47HXQpsFX2rE2HGjfFRZVF2SEYzsgxTEUXjgHKD
         yvmpzCyguDtb96XvA/Us9bxa5x4b27L0Iro3UQ9EyqKpWUjjoRW5Rdpv4vhHj71TTEXV
         qZYrcrrjol0l7ADLur9L2tovHPJ5uKRoXMK8Jv9Yqassj/3PNYIfEjGMK7BMU6tJ10YU
         YMfE37j/1wAavu48YGFhTc/3KFfNJuEIqfnSyq/VsZHcbU1HewMjvNnjyakeYTp878SM
         XktQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjEIEtw8+Dgdb/KQwz8huYQI1L2o1sykZLVOfNKlWSxFY7zqrdhTcIz16ekWF+IeRrLqkZ/1ZwsHCA+eAuq6UzMI/akXubXDhYcMr6
X-Gm-Message-State: AOJu0YwQXWj+qC6MxjsD7gL2gx/FiOHANJL8KY62UtFxRf2bIxmEwQga
	+K/rJIeXeClcIgEwtShuINcHdMMQKnz9hTw74OMLXPGNRd6rfi67
X-Google-Smtp-Source: AGHT+IGM+NYZFbKhzIiWcx1bGBaLftaof+ZWtjw8RcmMRMYuUIS8FOSkXjb+dA670b841i2/X+m6Ig==
X-Received: by 2002:a17:902:f60a:b0:1fa:1ebb:eb79 with SMTP id d9443c01a7336-1fadbd08b30mr57004885ad.58.1719824872603;
        Mon, 01 Jul 2024 02:07:52 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568dd9sm59437925ad.182.2024.07.01.02.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 02:07:51 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C59EB186E01DF; Mon, 01 Jul 2024 16:07:48 +0700 (WIB)
Date: Mon, 1 Jul 2024 16:07:48 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: David Polakovic <email@dpolakovic.space>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: proposition for fixing Y292B bug
Message-ID: <ZoJx5GaBDHg7nayw@archie.me>
References: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space>
 <ZoFgga45QCh2uA0i@archie.me>
 <9e3b638d-76f2-8520-2a24-7de0cd0bc149@dpolakovic.space>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="92cRUBLdgfOuwnAu"
Content-Disposition: inline
In-Reply-To: <9e3b638d-76f2-8520-2a24-7de0cd0bc149@dpolakovic.space>


--92cRUBLdgfOuwnAu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 05:27:24PM +0200, David Polakovic wrote:
> Thanks for reply.

Please don't top-post on LKML, reply inline with appropriate context
instead.

>=20
> My proposed solution was to create this BigInt datatype, which
> stores the value in array. The functions for division, multiplication,
> addition, subtraction and comparison could be stored in separate
> ".h" library for manipulation with BigInt datatype. The paper speaks
> more in detail.
>=20
> And yes, this truly is an userspace solution, but for kernel space
> implementation I have zero to none experience. Therefore I wrote
> here.

There was a proposal for adding 128-bit unsigned integer (see [1]).
The signed counterpart should be analogous.

Thanks.

[1]: https://lore.kernel.org/lkml/20220722145514.767592-1-alexandr.lobakin@=
intel.com/

--=20
An old man doll... just what I always wanted! - Clara

--92cRUBLdgfOuwnAu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZoJx3wAKCRD2uYlJVVFO
o1aEAP9IP0FK4gFNO4JrVAySvKbtwJDvtLCwhwcKYmdor5AZFQEAnS2qOTk9SGdm
ccgkqZZPpk7xSE0TToAc9dBDE4KXdwg=
=CNX4
-----END PGP SIGNATURE-----

--92cRUBLdgfOuwnAu--

