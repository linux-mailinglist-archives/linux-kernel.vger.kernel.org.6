Return-Path: <linux-kernel+bounces-325613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF83975C04
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EABA2892CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B751A7058;
	Wed, 11 Sep 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFNxffuc"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F71547DB;
	Wed, 11 Sep 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087471; cv=none; b=hSmk4g4gqiOhe3xqxJwoxnLOG4ID49QZYPiy3Mr94jI89B4Q0O5dvd1CMUuNLyRiZE8VGX6dTLOoqIm9iTJya/R2aTSu/452Wtzw5lh8HElBUEEHWdIHfzZ6/js3FaWWoEvEtsPjrYnoy1Wy0M9av+/DYEVgczEzwguGNZlOt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087471; c=relaxed/simple;
	bh=9MtaWLSnyZ6/76c0si78rlJ738kraXIwsOwsgkr4Mzs=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=ZwoCptIdIU+PezrSw+BmMQYXhkyF0yo0NUqMnTsMHmon1JTQTRB+q0GUAYUC9Ck2EqSyoM9amZ+vQRkU9rTq/RGcNMCBOE7Qz5NBzBogQL5no380rcUIsY2Uk05vLA4BOEiu1uPkiyp+GnsKTorof4xHENV5cUtXpAbZ1izKZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFNxffuc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374bd059b12so196181f8f.1;
        Wed, 11 Sep 2024 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726087468; x=1726692268; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ViqsfLdoH/9c0iNlyIHceSBGbV7/zUWkrAeDfulkQZA=;
        b=cFNxffucclSa87HE/LZSgRfHhGGeg0fzVrHveAWqAuoplVd7ehoOG+OsBOfKb8AjAT
         9AaAlZw0onZMXG0bX9qUuWDMzQ3DI11ubsCPnwXejZuu73kgI9uSNcj8FUuFeIti5HKE
         j6eTO5ckRize6T2Px/bc3ljHkSVWYv8QXB1aVSiPoVSVcjl+r5Q0J+ICLbuJpd82jr8v
         icb/HjFV1omS1oa0YMgTpYkhx/MQ+42t3BjpKHuTdlGtlXtLHjvQWVBZvPOW9Y75hOMN
         bRbNaRIa4Cc8AYfoY6GrEsUVsJDx97yfH0ApvpO3LbRHGQh5XUJHgjG2vbhXnQUYWsxp
         NOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087468; x=1726692268;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViqsfLdoH/9c0iNlyIHceSBGbV7/zUWkrAeDfulkQZA=;
        b=NvcQDpRMLo17CH93pBf+Jdndm+QGJ7K1ezD9Y9dYT70m/UBt6205X2g+72Q2qMLoOx
         nlpCMrdptvkOmx4Y6wXW73Qxqrt30idC0zByc5wvw37mUonsCFYWBTfARGoh6Q4o8NWP
         cNcAF5nzD17ItBnwtgPMoLtClSr6VtNxWBQ3sRWmjTFFOyigJ+8l4JtH9tlGBSMyrjeL
         ofkVVrVGPTSGDSnk2dz581PbkR8H7TO/zwSYV0EwdyGou93R7wR+tNwMAWd8g5fHmbgs
         +iGTtjwqadl4r27OpPej0C4FADpfGt5L3JlsATLCiStkC7fAni+pyqt65e0AsnpcBTO8
         SxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCb/sEt8vxs2189gcq2VV414xrMrXiMYilmkY2JK8Y3WrKC5mHMlGKUqYTIB61wiSZE1w431bmH/p5vfNb@vger.kernel.org, AJvYcCVRQZ4o8L3wx/EHCXDZ+041QEStoVuikbLATlIY5ISJMyUPNs3F+6oQg4vQDsjWYpFujYTpTalLYo5v@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwSkQ9aYBznPwJQKmAH2dtD4f1JBkX6gac7BJV6Xs5Dpif4r2
	AX9XVNfhSQHzhpZgRB0Cgr7AURUY7eiQPPxP/ajpdGRXdYYE4zMX
X-Google-Smtp-Source: AGHT+IHdMbBYOwA1S8wlSSjvcwtqAkOAunF/8siNVbe8pcwj+w1ZyAflOjXVr010QMa9OZT4iht3gg==
X-Received: by 2002:a05:6000:18a2:b0:374:baeb:2fb with SMTP id ffacd0b85a97d-378c2d032d3mr279687f8f.35.1726087467749;
        Wed, 11 Sep 2024 13:44:27 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956ddaf3sm12450903f8f.96.2024.09.11.13.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 13:44:27 -0700 (PDT)
Message-ID: <66e2012b.df0a0220.1eb799.1e97@mx.google.com>
X-Google-Original-Message-ID: <87mskdx6my.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: saravanak@google.com,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/of: Improve documentation on match string
In-Reply-To: <20240911164311.GA775781-robh@kernel.org> (Rob Herring's message
	of "Wed, 11 Sep 2024 11:43:11 -0500")
Organization: Linux Private Site
References: <20240910142422.341672-1-mikisabate@gmail.com>
	<20240911164311.GA775781-robh@kernel.org>
Date: Wed, 11 Sep 2024 22:44:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On dc., de set. 11 2024, Rob Herring wrote:

> On Tue, Sep 10, 2024 at 04:24:22PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> The description of the function now explicitly states that it's
>> an *exact* match for the given string (i.e. not a submatch). It also
>> better states all the possible return values.
>>=20
>> Moreover, this commit also makes sure that -ENODATA is returned if
>> prop->length is zero, just like it's done in other functions such as
>> 'of_property_read_string'.
>
> 'also' in a commit message is a sign this should be 2 commits. However,=20
> more below.
>
>>=20
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
>> ---
>>  drivers/of/property.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/of/property.c b/drivers/of/property.c
>> index 164d77cb9445..1ff51d93178f 100644
>> --- a/drivers/of/property.c
>> +++ b/drivers/of/property.c
>> @@ -452,12 +452,17 @@ EXPORT_SYMBOL_GPL(of_property_read_string);
>>=20
>>  /**
>>   * of_property_match_string() - Find string in a list and return index
>> - * @np: pointer to node containing string list property
>> + * @np: pointer to the node containing the string list property
>>   * @propname: string list property name
>> - * @string: pointer to string to search for in string list
>> + * @string: pointer to the string to search for in the string list
>>   *
>> - * This function searches a string list property and returns the index
>> - * of a specific string value.
>> + * Search for an exact match of string in a device node property which =
is a
>> + * list of strings.
>> + *
>> + * Return: the index of the first occurrence of the string on success, =
-EINVAL
>> + * if the property does not exist, -ENODATA if the property does not ha=
ve a
>> + * value, and -EILSEQ if the string is not null-terminated within the l=
ength of
>> + * the property data.
>>   */
>>  int of_property_match_string(const struct device_node *np, const char *=
propname,
>>  			     const char *string)
>> @@ -469,7 +474,7 @@ int of_property_match_string(const struct device_nod=
e *np, const char *propname,
>>=20
>>  	if (!prop)
>>  		return -EINVAL;
>> -	if (!prop->value)
>> +	if (!prop->value || !prop->length)
>
> This is redundant. If length is 0, then 'end' will be equal to p and=20
> we'll return -ENODATA.
>

Yikes, I missed it... You are totally right, sorry about that.

>>  		return -ENODATA;
>>=20
>>  	p =3D prop->value;
>> --
>> 2.46.0
>>=20

Thanks for the review. I will submit a new version of the patch just
with the documentation part.

Thanks!
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmbiASYVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlQHkQAMGrKDGsmJ7I85Fv1IHeZBfLuJrc
O50Scb0C6F8WKPO0fRWhcLMGghRotXXI2itdmvFVFwCkhyduumBdYWTPqvZYLoUp
KpBeN+2zQqbuClLiRx5OwjBFW2ib84PI5DLP8yr12I3nRNQh/AlY2/G2d0wPdt3t
RQcqtAMhU0QaDH33OsopbDkUiUJfW/4ozdol3Uv4AxgDxxAA4yqD5h0sNqtBE9PZ
hzRi7dLposU/oqu+RoR6u3W2aJhW8RYj3kCIlf/285TKfZnWnoPb15bm1D2wb9Yz
YWd+6gjyXdZsTYLcmbRXo3kkJGGoJ/zYlY/dUmorxqK8Lrjq2oInx/wSsgAgWNDQ
8SVz8efo86E2z2zAL5z+NRXgMwptjVPLyOE56YiKhXqpV0A2aKOPhFXMXlVa318j
z9pnCDQUnQRUFm8RGoBuyCN+Z/DMV6E2Its7lUvynFSo12rvtrSf79HOs6Ajt/Zm
HZGHtXD63AkbYrRSX3FcRwN7bJTEaTn2uumuLsmGr5K341GMkoIfdWaJHE5mYiyM
FdoorGxPc+meXbm6zV3FXHT5F3lfJBDZ9UMItOARxpoklLnFUmSG5mpE6Ta4YgnK
DCMbWFzSejjKDb41TbKglgLswgCflR+L2dj73kNiWwuZk0a59S9AEUQ8uL1IPs0c
QMfy+K7kaOQfq9dJ
=5HE0
-----END PGP SIGNATURE-----
--=-=-=--

