Return-Path: <linux-kernel+bounces-177387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A468C3DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4C02846F0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3EE1487DE;
	Mon, 13 May 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hApS0ODJ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9C1474A2;
	Mon, 13 May 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591391; cv=none; b=ulldJp4IyV895gmcZCtxdvxTEy3qhJCt++SZBDOGRPaovUYGsBSuZzkRdlzBlrqbeoma8XMyaZAa4VycmQer25DcR+KbsSi8xbInFER3dkGkt0V3WnDEyHbRf51/GB6/iemHws4D90KSpDqiTKD+Mnjb91htsx+tGC9k3Hw1iTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591391; c=relaxed/simple;
	bh=35parTJp+jKZKjJtoHwW7Fi8fa+9bQDeP0JhKWVJeKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f33XYooTqcprVBYWVXBPu6e6Zd7+TayPbdntBqaEb+pyBEkoXOu0whFGqyZ8pQ5ebIs7mOHbhWQiA+6mfNI/QabQO6RQ0+XHUecrU2O7t3wJ5TdCCP8i9QsYH7Mrf3IfQSFh+4mZvRiUieQ+ygXhRi6yjB03DSMW6FDfpaetBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hApS0ODJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee954e0aa6so30378325ad.3;
        Mon, 13 May 2024 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715591390; x=1716196190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zqXFTG/UsEGp/a5otOk5W3+y5hWj2D7lzRkWmSN8zUQ=;
        b=hApS0ODJoZ+xc3xE5hn158fM3CK6ezkI8//NzAdc0M1sfCJq5xXXs7tLXi8uxIRuWV
         CpZuwUOUEIKEnjQGhML6iBwME9T13CjeouvB5JBgxNDrkv0OAdRPKJRUBYqHriitGj8R
         tyYoS9T38QQnxMmdz2/L5rrcn9WB3mFxq205LlYBk6DaJa/e6w93b08TzMuTM4JLimUj
         3WwhqiuR1ndGoA3j15kwqlX9X2cgVZZ8HoQNivQrVZRr858w1YWajgj/pVKjL1S4fBRJ
         OS4x5GmiQcJumB5EntFFBHRevcwoiMj4iMJIfMK/GuZBF2t1GcK32AOq3n26p9vXkqPE
         h+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715591390; x=1716196190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqXFTG/UsEGp/a5otOk5W3+y5hWj2D7lzRkWmSN8zUQ=;
        b=IjSxiFh9umte+rXTEb2UiiyfIvWbn8boKeYEGxNXhE1UcQFo8hT6QDik/rvdLw5J1s
         y6GYo1k9Pse4Ag0/ZSEeWzsqwYaPlcu6Gxbob2fjn65boA04vCilASUbVu9nomRll8TT
         P0HUiTIJLSbAWbDtEWgYyuoaU0bUMf9qk0vUKPi8uPiIE1Muj8nCYXbrC2r69e5enZkd
         MDvPTS8V7Ei5N3FmBGhLyYxPxy1rkyxKt7+nvwsLbN+3rL5WUelWZhdQ+W565VAJ9ABE
         TG+z4wibfxYAQ4+Vbd5nKQ3QFaBQfUMzbEcTdTKP8ESBuTKoBspT8DClS75cq1wsC0rW
         hClQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdz0cpUfldbmCon8Wkj/qPWWXUDoxO0Gjp1tMPZ3NpCR+eroWrf61OV08BxqUPYsqn76YXLDNEaHHTjmPhLoWqrEXIPVA61ljgnsAbHypSdpGyNFdriO746BKAlDABMTHMK/O1Pwgg
X-Gm-Message-State: AOJu0YxAQErU0/EMChK3YlTVlrXKbGK/fWhn0MLJ7MrUg4ZtHWuxKIhb
	n7hcJswOHYHhnMTUTfAwIcG5qMfpUI2P7DaSTu4q4R3125YQiMr0
X-Google-Smtp-Source: AGHT+IHjhm3ct3fZIyK9rW9/JPt7Mo9iUNvdzbhCzIEAmlhLG4cF8py8h5nFpQJD6eYBcsw+ILQhaw==
X-Received: by 2002:a17:902:f605:b0:1df:f681:3cd8 with SMTP id d9443c01a7336-1ef43d2e288mr117782885ad.12.1715591389652;
        Mon, 13 May 2024 02:09:49 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13908bsm74600455ad.265.2024.05.13.02.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 02:09:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 88AE8180716E1; Mon, 13 May 2024 16:09:46 +0700 (WIB)
Date: Mon, 13 May 2024 16:09:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mao Zhu <zhumao001@208suo.com>, Ran Sun <sunran001@208suo.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>, LihaSika <lihasika@gmail.com>
Subject: Re: [PATCH] Refactor phrasing for clarity
Message-ID: <ZkHY2sYUOXVSWDMO@archie.me>
References: <20240513022430.17626-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G+nCITxMkLxwGcUH"
Content-Disposition: inline
In-Reply-To: <20240513022430.17626-1-luis.hernandez093@gmail.com>


--G+nCITxMkLxwGcUH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 02:24:02AM +0000, Luis Felipe Hernandez wrote:
> * Updated title capitalization for consistency
> * Fixed acronym capitalization (e.g. CPU, vCPU)
> * Added usage of hypenated compoud adjective
> (e.g. host-side polling, where host-side is modifying polling)
> * Added missing verb "as" in "basic logic is as follows"
> * Added missing articl "an" in "guest_halt_poll_ns when an event occurs"
> * Fixed parameter definition in 4, all previous examples started with
>   descibing the parameter in the first sentence followed by additional
> notes
> * Replaced C-terminology Bool in favor of formal form Boolean
> * Cleaned up phrasing in "Further Notes" section for clarity
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--G+nCITxMkLxwGcUH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkHY1gAKCRD2uYlJVVFO
ox4xAQDSJzIXK/ubTuy+ucT6toBdOYC5pnOD3av5A5Mhf3oCyQEAhL9yg69u0SDc
Hr75AvMHVpqR8mxhp9UJoPs1SpfQbQY=
=I0Lo
-----END PGP SIGNATURE-----

--G+nCITxMkLxwGcUH--

