Return-Path: <linux-kernel+bounces-307300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F34A7964B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B121C20C13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CA21B81A1;
	Thu, 29 Aug 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eExrMeiB"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A61922FE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948284; cv=none; b=tRW8HB5hQuqLL3pnLCng++mLiR6kYUdqsk3v5CQzRi3sx09FufIY7XfFaSxQ4dRrOF8YfaaAtAnIpax/2qGf8lvoCgEjOaCltiLYceGQEQnuZ6mmDdKmGyCxE86hAfySt4qDuJ44BQUqxZq7n46I/FbqKzQHKtBHSTaTOMCKYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948284; c=relaxed/simple;
	bh=cbJAMKxXww8yvz4UFEB5fS8WEI+MbDZrb/jPY+MHTDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CABuBKXJal76fn7VlzdZOg/pPSf0KSpTYCNcDy0YYm6b7DHb/GyWToyGqf9dZTXwXtKPqSlBtgduOBd1qp4YxGnA4/IZW0AG33WYDxIxbtDtrQoqZficaaw0MC/JJwWMqOhH5CgP18/mxRwSsX3tBQZwZTS4m67kbkc+wSYqmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eExrMeiB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86933829dcso110935066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724948281; x=1725553081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=COwbHVOt1r56SG2JuuV/PgR+aLtkhx1pNzDMhZuXgw4=;
        b=eExrMeiB1++LSJ973kvLbKQJ2jpUYV60amhqp/s1Dw9k4vkrJDHTjqz4AbD9YDJ2On
         COmL/Kyr2mZOXrKo5YM4KkZ/UAAKyDTqJUu/sga/Qd8AtHoaFqX+gmQociRy+HohPcs3
         PVyK5hzqVMnZNQvuSqhPVsaWPJ5jSVAfc8JcaVaE9rRZKjL6mB87JuVlFXl95zuXb9xt
         on4tV4L3CjYZnWeqqjBH1ndsBk1T2hd2/IeSW6lHFveqM2oHtX8RMCtItqgitqcBrr7H
         o3lHCoLhDnIC+nu5YdD72SJpTul+rDXD0oPWcxO62hjGqe4K++cNOTIirKU8YJ4N8Prf
         qY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724948281; x=1725553081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COwbHVOt1r56SG2JuuV/PgR+aLtkhx1pNzDMhZuXgw4=;
        b=vvRg5SISkJUH99fPW5xJpNT+8cj86gRXrCSfX7MPZfIIiS014Slt57OJiRNyePs6QS
         4vjt4V/rTXnAk50OPxYhuRB8fuW/IBxAZ/ZJchUItcNlI2svXqL0chuXQl44deoVg9/7
         ERQ4DJjaEwdoz0x5H8nPpochHoJz4aQu1Oyr7+WY5TBaJcE1dhnJF/Hm72ixgs/kI5ud
         U2JW/dlNxYoWRfJpJipsfI1PUvl/aMsgkYd7AAlUbteTJCyKByjCunyYqeX3jNTko3hM
         nWAquYIOZ2+WM5B3ByQfH0frGHWW+S4S69HwndM4VPFeFFf7l4SHWlDOhdHhKFSUIZjH
         IJ6w==
X-Forwarded-Encrypted: i=1; AJvYcCXf66jHqumXTm04L4UB2DGobxs1ITQwxenjykcHzM4+UcxEawSYSEM4WhqtuM8D3pM2mjyLoTyiGHMaU/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjGJgW05bMb10YSkgcunejxYhfY+y7SmB0Xbrcc6PguoS7R3Zm
	BrXLjgcm0HD3N4DhDeghugo5vCrUZWNZqRGqio/4ss4vjAyTaTPFnCizJDhKMzg=
X-Google-Smtp-Source: AGHT+IHH6suzNkazxzI4rMNO/vh/EMc5E3tPX44rnkcdBJ2k1g1/3FoXmnODIMOi71P4DSzyaA1wNQ==
X-Received: by 2002:a17:907:1b1e:b0:a80:f6a0:9c3c with SMTP id a640c23a62f3a-a897f1b5c1fmr303933366b.0.1724948280521;
        Thu, 29 Aug 2024 09:18:00 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196bc4sm95902566b.125.2024.08.29.09.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 09:17:59 -0700 (PDT)
Date: Thu, 29 Aug 2024 18:17:58 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Willem de Bruijn <willemb@google.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org, 
	Tao Liu <thomas.liu@ucloud.cn>
Subject: Re: CVE-2022-48936: gso: do not skip outer ip header in case of ipip
 and net_failover
Message-ID: <jsnwzpmezgju7r7nkcauaicthkzizsqglb6p43zq25cdvdgbgt@dlkgwkch52qi>
References: <2024082224-CVE-2022-48936-9302@gregkh>
 <z3hh3yrf5wym3obgol6obh3dkmqoc3rwbkj23qcmadf63b47h2@nn2232wngans>
 <2024082854-reassign-uniformed-2c2f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxyentzy5dodthvg"
Content-Disposition: inline
In-Reply-To: <2024082854-reassign-uniformed-2c2f@gregkh>


--lxyentzy5dodthvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 09:30:08AM GMT, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> > What is the security issue here?
>=20
> This was assigned as part of the import of the Linux kernel GSD entries
> into CVEs as required by the CVE board of directors (hence the 2022
> date).  If you don't feel this should be assigned a CVE, just let me
> know and I will be glad to reject it.

The address of original author bounces back. Willem, could you please
help explaining context of the change? (~the questions in my previous
message).

Thanks,
Michal

--lxyentzy5dodthvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZtCfMwAKCRAt3Wney77B
SckSAP9j4gd/Tcc3QZ10c+GJhPk6QE4iQ1jyw2uZezw2Ij6hBAEAkLvhHDOFQvrN
yrB3B1hvATG9Y35GIjPNTeKVH2dGng4=
=TZpN
-----END PGP SIGNATURE-----

--lxyentzy5dodthvg--

