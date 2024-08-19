Return-Path: <linux-kernel+bounces-291714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D109565D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB671F23DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D015D5BE;
	Mon, 19 Aug 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD7DGSOn"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED44415B98D;
	Mon, 19 Aug 2024 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056936; cv=none; b=VSSu70q4q38opAABPtEXJsVzBHDBow9bgAdwjGw/dB9Nxb5VAU9JXAmUqOs8ltqhl9pvthxrPEU+iEvT0+nKLyEHdeoZ7GIQJ4dZFN38c2JT6T87ddAbTBRuck9qmn7Z/2l1fxyuvLd0DzwcLOr7p8YG0TWYYRMb7olwFwmwXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056936; c=relaxed/simple;
	bh=PGZHOvJ3I/sGSsvElOZ3BaRzkT4FOqGOtisCrn6fvqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvCYLahSwC7i148/SG2tZJySBHdNyekAGuI2Aa5M+7eLkDiGtwDPk+fAGN3XgBObeneIhqmYPgjtLuM6Z0/XJBUuJcGEyoysvUWrJjRZFWkhfCbLaevu6BBBsQzorvaLWceiTPGGnylhLdfgvgOhnqjmULaYy35tKrHYHKaEOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD7DGSOn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2020b730049so18003735ad.3;
        Mon, 19 Aug 2024 01:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724056934; x=1724661734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGZHOvJ3I/sGSsvElOZ3BaRzkT4FOqGOtisCrn6fvqo=;
        b=hD7DGSOnD+OzSOHGCdCEdwmAJtPR+tZQ5NjrNY6K+xO8I6Xv/zpkA2jzSdOs9Eg3O9
         sInGMlWeZsR9+R0Mb8SB0DM3rJPprRCs1afTPo3yAXlpRoAuNYfbbfQ5YYUJRAWDs1me
         9NYEd07D8yD7uAXi/mlFSbr/MXo3ChvTwib7puMOE6brfxAFrUnwu3BuCSvf+4bSU1uS
         jdvLjU2PuFo+CTX8K7nAjkh76JOE0eAkhr/ndc+g/fDSKr/Sv+cxVfYosv+KA7HRxrW1
         pB8m1bvM2qzWlTpZ8pd8n9Whc1X6ICHX8FFK5UaWL5C6k5Vcu0l++EunpfanHwUOo/HF
         MHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724056934; x=1724661734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGZHOvJ3I/sGSsvElOZ3BaRzkT4FOqGOtisCrn6fvqo=;
        b=X0Ad1RIZsJvh6oC7QeROojdLscuWN04XfJsxoFvTroJTaLmO9UsI5tso7ALAIy1OAK
         Kb+AkIMkOe1Sw4acidUoFr/2CVm4y6Mhc2naHh9iZSb/hE28sF0Sc5DXXQIbHreFvKV6
         OWPTY5r7sIeDKxzprDCGcQMxqFY2B1q+VQCeuN3XDEba4srwhfnIYYbtdwaV0PnqIcPB
         kBVbukF2yqH4jM9UXjDNTkcjTvA9+aB3Jc+fzNo1VXPDQJWzqHDTIUfW0RESNuIRGuTI
         5Wa52p11lmkV6Tudp9ckPIStXuRXowFCHCMvXvk0RkZ3d5bzRZEYKgrYzsgCrxLzmxkj
         XYzw==
X-Forwarded-Encrypted: i=1; AJvYcCX3ekUbjNj+fB4K/53TFw8ueduAVPctdXzQaLFEc2jMhoKh9s6I0t6ddtmlJEiYM8a4xWOoZZgNpyNZTgVn7cwjS3NJnNeQed4VzFE/aN/O8RbDGaAG/n8zdzOOHGvzFtK9DW/wGdEt
X-Gm-Message-State: AOJu0YzGALq7+stf8hxFh14OcaZaXA0wxIUAYz0y5syv/WPCRuhj9URL
	g1AaSmmp05wj+9ks/afMXtkEwKva8SZq5mQAFmVGC941XdX3tXYW
X-Google-Smtp-Source: AGHT+IH8SJoDTYfYGz7l1cO0TAPnu6MgibpGDFz1bUdQ2iWqX54EE35IqxQA8L2v7vNWAVB3QWu/QQ==
X-Received: by 2002:a17:902:ea0e:b0:202:3e32:5d3a with SMTP id d9443c01a7336-2023e326545mr24339245ad.26.1724056933917;
        Mon, 19 Aug 2024 01:42:13 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037895dsm58858255ad.155.2024.08.19.01.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:42:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 923474935788; Mon, 19 Aug 2024 15:42:09 +0700 (WIB)
Date: Mon, 19 Aug 2024 15:42:09 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Thorsten Leemhuis <linux@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v2] docs: bug-bisect: rewrite to better match the other
 bisecting text
Message-ID: <ZsMFYRzba6cf5v_E@archie.me>
References: <fbeae4056ae8174f454c3865bc45633281bb1b31.1723997526.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pS632mJ10TyJMNVd"
Content-Disposition: inline
In-Reply-To: <fbeae4056ae8174f454c3865bc45633281bb1b31.1723997526.git.linux@leemhuis.info>


--pS632mJ10TyJMNVd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 06:12:13PM +0200, Thorsten Leemhuis wrote:
> Rewrite the short document on bisecting kernel bugs. The new text
> improves .config handling, brings a mention of 'git skip', and explains
> what to do after the bisection finished -- including trying a revert to
> verify the result. The rewrite at the same time removes the unrelated
> and outdated section on 'Devices not appearing' and replaces some
> sentences about bug reporting with a pointer to the document covering
> that topic in detail.

Looks good, thanks!

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--pS632mJ10TyJMNVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZsMFWgAKCRD2uYlJVVFO
oxYKAP9O/K/Lvo59SJjRHKJ2qQp3tKXCIPyg2s7DnlLhwr2GqQEAh2Vl4S5BD3ez
BDuXXN1nrniU70JJvlrxiZVKQmS8NQ0=
=O1gW
-----END PGP SIGNATURE-----

--pS632mJ10TyJMNVd--

