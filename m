Return-Path: <linux-kernel+bounces-373290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890F9A54B5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50872820E5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFED192599;
	Sun, 20 Oct 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="XrdwaG6p";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="LkDgzIg4"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB814A90
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729437470; cv=none; b=Pz/lFnwA6XBmh6oM95+NF8IukH/pNhoCdUZ4aTS1RZlyafcd3E5lPHnjnUAINWHrAdN0CDOg2ntxCoJfiK+jPqB0wANBj7MBWTPtVmApbF+TZGy0a9YA2BDsO2suLVnCmVqJbGuBBXLlGiS/Z+s2I9Ze6XHzkkGXEQ6VXLDKYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729437470; c=relaxed/simple;
	bh=FOjFsCqYMPnM+VIioEfmbYshhueLM/VvJe3VtJCEGYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7k6Jrfs4TvJshheXaimaOM22zwV+I8LV3fvPv301jTDV8DegAFfvqF0To9MjMBFQGY6d8XzIEbmZO5F/oyTcT5kBvqQOuZ9hvRp2tY1hBKsCCXXjLVMD3mfG+w4TGOUHOnd4GJzJ/NQJQuZk4uzqIiruEKYpOSBD799n37ZL4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=XrdwaG6p; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=LkDgzIg4; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=XrdwaG6pi6bdhTfW6fxOU2i47jRNGuiG1nYis0HXZtWzHVAxONofUYFE9DUmMlWxVygLQzlYGORSnkU3S8Ma1g2kSvY4TC6YZIwvxbqQ1Y+SLBd1mlhmKzS4pdnC5TTTMfGI6wDCrtBBZ7HV6VDY6T8rQqgIVi7d2hUVMFjXN6qXBmthB3Enh8sbFNDgzerW9PNA9K7PvtNHgFK9cXcktXwydRnuYUbOy7KfbWuCGYans3imD1MzpP3p7LM7k/OiKa/uwqxBudCLYicfeM3zHrKt/9tUcqzVqDXaCh8qxGR9vClMJa11tdfMo9WJaTiu12xpGidfVk1MzVe6ZCsw0Q==; s=purelymail1; d=lkcamp.dev; v=1; bh=FOjFsCqYMPnM+VIioEfmbYshhueLM/VvJe3VtJCEGYs=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=LkDgzIg4EbPxueJ7jgMGDd3hyrJLNP0FNZpFXuOSRkB2Tg3OfgueaoRcAFCHPa5QgMT+o08yqBnRzr642QdEH08vixQN9oF8hNFFIuWOYlQuo3NTX3EUYNQJmz2dNDivGxxeeGORio3fSQ90wi3cAK3mN9k0fVr7U1NqH+yV2w6gP2lBHy4T069BJEPQOICf5cIX98cRGANQytm+4PwNWCp6qmowJ36sZNl7ftABThnWBCfWu1jSE+s91ws5V1+q7BtT6v7+Tis0nWNhGKPruxXLlmXGDSXrwtduFmWM/dWlRJI4mxytUxLQeZ6lDEiNmKT2SHKT8Ow5t8LtZKEVBw==; s=purelymail1; d=purelymail.com; v=1; bh=FOjFsCqYMPnM+VIioEfmbYshhueLM/VvJe3VtJCEGYs=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 40598:7130:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1500207236;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 20 Oct 2024 15:17:32 +0000 (UTC)
Message-ID: <cdfad67f-1725-4c95-9016-07b2543bca9b@lkcamp.dev>
Date: Sun, 20 Oct 2024 12:21:55 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] checkpatch: add information on warning about `help` in
 Kconfig
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-kernel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
References: <20241003192012.3736-1-gbittencourt@lkcamp.dev>
Content-Language: en-US
From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
In-Reply-To: <20241003192012.3736-1-gbittencourt@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi all,

On 10/3/24 4:20 PM, Gabriela Bittencourt wrote:
> When writing a short help paragraph for a new KConfig option, developers
> are prompted the following warning:
>=20
> `please write a help paragraph that fully describes the config symbol`
>=20
> However, developers might get confused about this message, giving that
> they do have written a help paragraph, but checkpatch is not happy about
> it, which can be perceived as a false positive. That happens because
> checkpatch considers a fully descriptive paragraph one if at least
> `$min_conf_desc_length` lines (as of now, 4 lines).
>=20
> To make the warning more clear, output in the message the expected
> length of the paragraph, so developers know better what checkpatch wants
> from them.
>=20
> Suggested-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> ---
>   scripts/checkpatch.pl | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4427572b2477..8a6b6c22b175 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3660,7 +3660,7 @@ sub process {
>   =09=09=09    $help_length < $min_conf_desc_length) {
>   =09=09=09=09my $stat_real =3D get_stat_real($linenr, $ln - 1);
>   =09=09=09=09WARN("CONFIG_DESCRIPTION",
> -=09=09=09=09     "please write a help paragraph that fully describes the=
 config symbol\n" . "$here\n$stat_real\n");
> +=09=09=09=09     "please write a help paragraph with at least $min_conf_=
desc_length lines that fully describes the config symbol\n" . "$here\n$stat=
_real\n");
>   =09=09=09}
>   =09=09}
>  =20
> 2.46.2
>=20

Gentle ping, it's being a while, is there any chance I could get some=20
opinions on this? :)
I didn't find a specific mailing list I should send this patch, but if=20
there is one, I'll be happy to know and add it in the cc.

Thanks in advance,

--=20
Gabriela Bittencourt


