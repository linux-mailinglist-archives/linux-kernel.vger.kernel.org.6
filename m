Return-Path: <linux-kernel+bounces-235079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E38291CFBB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 01:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580CA282C3F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51264D8D0;
	Sat, 29 Jun 2024 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Bwldry"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0042078
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719705281; cv=none; b=iGGExfie/Lf/SWsudkDpbHvky4pkTJEY7sZgCyRR0q8Ntp++ooD9hoHDTtqQvb/QVZv7/YZ+lDr6ab25sBpjkyhe4mv306t3KPrtHCGLfICxN0AxD0ENQHYzJmdcn9mV/X5Ckm05bxoucsMMQnqJVlmnsdlGBdxTtmMCPL9Yjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719705281; c=relaxed/simple;
	bh=HNKSnvjndFDSHXGnRsk2y67Mg3MJw2O1ab42oLbeluM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTrIcQGLgOeyNYMcDzNw2PWhcas8DBvskXEkyWHCEeMqnmE/HFCYkp4ggpnFVWqloHDEFi65H3uWh2dDpcgYP5VO72Y3dhJ+86jnUkYu3x5NzZ8ptBB1jsNRmjBiw2497NJljArChlEhSn46Y/h0WfXXqzr5jPaO7jWkcHkw8Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7Bwldry; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3762c172d93so8800735ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 16:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719705279; x=1720310079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNKSnvjndFDSHXGnRsk2y67Mg3MJw2O1ab42oLbeluM=;
        b=Q7Bwldry85ef5Ts4sFUVjaDMU17a9aOZCChovvKqNJk79Xm/aOPmWgxFjdJbOeKqYK
         aOLUgbzJ1HA95KYug3T7hAYhp0hU7COHP0u87ZcNLCp6o2cbVQr3OY2eoiINGlVjPv7r
         Z7ngrfum7+8nXBP8lRVCqVGAtGHNnB3kKImKr+1moYn7p08htOe5LFGPVfGOZ9a08wb1
         exYqMAQ9uOCuxLqvAAPIDiZpBRMqAEmEhUIj+bXaQ00DnlmHrWa7O2PTJ9fzb8fjjokN
         4fvRzK8dll7nwDQGo0GLfz9FMwZLCIBTQDamCDAbzK8Hilax80pZx2uuKdiZd1OV7epq
         8M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719705279; x=1720310079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNKSnvjndFDSHXGnRsk2y67Mg3MJw2O1ab42oLbeluM=;
        b=drZCRLp8QXOs+DvsyMaWpTpzVJWV2QtttUYWegwgS1CzsExa8x+jt3xCMDdCJQfyjm
         1XcHVUrSiwvrIKHajjNo1DyaqhgUUWXgse2btpekYcyshsc/9OnNosrJn2k9yaNYP6w4
         yCEP7eL3XsAXEkFClAc/ex1rDzuTWOTRtyXJo+i+6udgczAespP88UqDaUheu+eITGwH
         JnN7QCNpO+w0pZJSyUCxCCq7Bf+qv/xhY+uI1BEZB4xrZmxQJSmCdoCVKjuuDhpNLljH
         9ljWoFfQHtRZJmBJHAbukZOxjbpjU6q/n7/Py9SovlN6ath3O4BQYLqwdq226FcucF0J
         XHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEXKQb9Uqt8/nzuBDJkiCT3qBjIIhpEIJwph7cAFNE9v5rHXwA+yeJ9zwqdwXZA7yi4G+MtD8X9bUh0gSrkuTfZXtsQwnuO70ffD/v
X-Gm-Message-State: AOJu0YzBwWWCtX24pc5ns9EBQ5OyRJxJYwBI30g3u1GS3m0YzYZdHGl2
	/gBE9YmkhDvLwaTooXqZS2z44WnzbBCKfwlRL8MRIx149skvY7StERT1nQ==
X-Google-Smtp-Source: AGHT+IHzkEWGzka9+7sZ/fPfgApaRYQew1kLnqeJ5l8qDXOb+dRdERKLjHPG8Ok9L3fCttLw5kh5PQ==
X-Received: by 2002:a05:6e02:1a4c:b0:375:da94:e46b with SMTP id e9e14a558f8ab-37cd0de9cafmr25528895ab.5.1719705278878;
        Sat, 29 Jun 2024 16:54:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e2cc5sm38521475ad.80.2024.06.29.16.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 16:54:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8F5DF1852C705; Sun, 30 Jun 2024 06:54:34 +0700 (WIB)
Date: Sun, 30 Jun 2024 06:54:34 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Yusef Aslam <yuzi54780@outlook.com>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Staging: rtl8192e: rtllib_rx: fix alignment
Message-ID: <ZoCeul3pAjZLOT8E@archie.me>
References: <CWLP265MB65165E806F938F87CB67BF87FDD62@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
 <2024062727-diabolic-lusty-7baf@gregkh>
 <CWLP265MB6516AB499D407C0AB0CF106EFDD72@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="91Qoq1IeelA5QvL4"
Content-Disposition: inline
In-Reply-To: <CWLP265MB6516AB499D407C0AB0CF106EFDD72@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>


--91Qoq1IeelA5QvL4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 07:09:50PM +0100, Yusef Aslam wrote:
> On Thu, 2024-06-27 at 15:43 +0200, Greg KH wrote:
> > This all should not be in the body of the email, please use a tool
> > like
> > 'git send-email' to send patches.
>=20
> Oh k thanks, I was trying to use git send-email but in the end I just
> copy pasted the email into Evolution as msmtp was not sending emails
> for some reason.

Authentication issues?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--91Qoq1IeelA5QvL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZoCetQAKCRD2uYlJVVFO
o6I1APsHLrevLZMMM0lYJnxtWSvhmiuZ6aAFFByjryG/++/10QD/YcCo8RNKbXVA
8wPGTFp+EaEp6BP5jD6AcZm7cOj8RA4=
=3B0Q
-----END PGP SIGNATURE-----

--91Qoq1IeelA5QvL4--

