Return-Path: <linux-kernel+bounces-349239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C7998F2EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C47F1F220C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD31A76A7;
	Thu,  3 Oct 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="fIxK04aj"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513241A76A3
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970197; cv=none; b=AATL8yNTK4ryUtjFNP+Dao7t9GXx2uwiCuLLXjnbHbAwcDw2V4a/46zMtKrCQ/vsDWsSTKu1OsVFWPE9PryQ6glaBFoYewOx1boDSoNRrTmKDKWnyZGJ3wWlRKwLUsDJ8IR1F3DRWQ4ytis+JDKgp+JgSKBFeamX+qGZKH4gGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970197; c=relaxed/simple;
	bh=4cByRes9hrKBJG9/bCV60PAdcwINxJmEjyX3U/JtJ/8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iynTb2CD31unTtrh566S6ptMMMtjYiB12VUcG7S+Xr47f83y0vDtaYqgS8yHyS4HXY4oE4BLVkcXzpLyZGDIYv8y+YCU+QuUnFq9J+sBhKDRWFkrwpww1Htkqu1EJLPEW9jT8BI3mxJXRPBk5ezzQTiJ2GDy1mFxsC95KTL9HfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=fIxK04aj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cebb0485aso117249f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1727970195; x=1728574995; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cByRes9hrKBJG9/bCV60PAdcwINxJmEjyX3U/JtJ/8=;
        b=fIxK04ajrvBO8SFs/CPUK844QgYKcImf9I2loas7mxDq5SOGOTpx2kPNRBr0oXIeku
         tQm0zN8tp8XXvUaSwYcdo51eUzVLJYw0BnVPI3kMYB2eyd8c+jZzI+sSiCnooFTVORP+
         6hTKFqk4d1tGolo/2YcGZxSz/7UoFkFKi6gd/953YPD0gLJA24avQGv0EfkQ+GaEpzEV
         GcixIjcZdhfst49SFG+HvxV1VEiTXroFgXFXj3AU2lDoR33LWRbl8lOWv7JO5d8Bld2l
         Ir/awZhpy6Oz91Qv8jYzcMXDOYe0Ahn1o92TZb2iELSR5tE1MYUtlU5hzd9BcIbaB565
         26qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970195; x=1728574995;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cByRes9hrKBJG9/bCV60PAdcwINxJmEjyX3U/JtJ/8=;
        b=IKeNn4UdqpidLo1J/XhzCAn2xYso0JZDTqoOH9Wfyi9/9gNIwEFa81oQSqAg5nG6lX
         6iHj0oO9EluYXT2Y3Is5ftkA0CEyIBzao2mdyhpCbHqYgvHaYV6WNI3kR7L9FnKcRzxT
         pvRiFG6FbJtvmkOBssGO6lNIwpcE5ifw1ModOSedU4tPGpMRtR3er/u5UNQI14laRBaR
         HD4ueoMrrYMuP9QledvA6ql5AY8CHYN5Bl60xx4GDU+e+CEqGnUmrzEZwO9rVtP9mnp9
         0WSUc8Zl49aBOtM8CpmTPIsYueqoHV+Ov88grD8nM7M2oyEkDrqQCsOM6tZDnYTeSRPO
         ipwg==
X-Forwarded-Encrypted: i=1; AJvYcCUDRzAr0ofOP3aRjQB6nbXcERO9zUKEAmfhR6CEueqflxZIusCqrhTi5El0hvRsyMmJ8P4erOqg1vaYqmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWi/TCVbVfCPTwFu2WNg8dJkkZ58Hva6PvDvrNNbYCA5vaDs6L
	VadYVo9pQZYb5gQqALaRo7o7Ntju6p2O2rZ9PqOHQ9hROd5vURElAVpPy0gxpws=
X-Google-Smtp-Source: AGHT+IFxrq+DpxNVWVJKPiFbf34UvkGNfvqNRV//YF+LWWLt5xXTOOzsEFEFh0/yeM9A1iu1bgIksA==
X-Received: by 2002:a05:6000:1562:b0:37c:fa12:8cf5 with SMTP id ffacd0b85a97d-37cfb815750mr2415153f8f.0.1727970194539;
        Thu, 03 Oct 2024 08:43:14 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:1558:85f1:4dd0:3ea9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d081f7386sm1533137f8f.19.2024.10.03.08.43.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:43:14 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [REGRESSION][BISECTED] erroneous buffer overflow detected in
 bch2_xattr_validate
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <Zv65p8f4sxT4gKYs@archlinux>
Date: Thu, 3 Oct 2024 17:43:02 +0200
Cc: Kees Cook <kees@kernel.org>,
 kent.overstreet@linux.dev,
 regressions@lists.linux.dev,
 linux-bcachefs@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ardb@kernel.org,
 morbo@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <78AAE4F3-1C2B-4EE8-AC7A-B5F3730D1DB6@toblux.com>
References: <A499F119-5F0C-43FC-9058-7AB92057F9B3@toblux.com>
 <Zvg-mDsvvOueGpzs@archlinux> <202409281331.1F04259@keescook>
 <21D2A2BB-F442-480D-8B66-229E8C4A63D3@toblux.com>
 <Zv6BEO-1Y0oJ3krr@archlinux>
 <E8E64A72-3C1C-40D2-9F07-415F6B8F476E@toblux.com>
 <Zv6YInHiwjLeBC3D@archlinux>
 <63D4756D-31B7-4EA9-A92F-181A680206EF@toblux.com>
 <Zv62pi1VVbpkvoDM@archlinux>
 <83834AC8-0109-40C5-A80C-8BFFA8F16B19@toblux.com>
 <Zv65p8f4sxT4gKYs@archlinux>
To: Jan Hendrik Farr <kernel@jfarr.cc>
X-Mailer: Apple Mail (2.3776.700.51)

On 3. Oct 2024, at 17:35, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
> On 03 17:30:28, Thorsten Blum wrote:
>> On 3. Oct 2024, at 17:22, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>>> On 03 17:02:07, Thorsten Blum wrote:
>>>> On 3. Oct 2024, at 15:12, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>>>>> On 03 15:07:52, Thorsten Blum wrote:
>>>>>> On 3. Oct 2024, at 13:33, Jan Hendrik Farr <kernel@jfarr.cc> =
wrote:
>>>>>>>> [...]
>>>>>>>=20
>>>>>>> This issue is now fixed on the llvm main branch:
>>>>>>> =
https://github.com/llvm/llvm-project/commit/882457a2eedbe6d53161b2f78fcf76=
9fc9a93e8a
>>>>>>=20
>>>>>> Thanks!
>>>>>>=20
>>>>>> Do you know if it also fixes the different sizes here:
>>>>>> https://godbolt.org/z/vvK9PE1Yq
>=20
> Do you already have an open issue on the llvm github? Otherwise I'll
> open one and submit the PR shortly.

No, feel free to open one. Thanks!

>>>>>=20
>>>>> Unfortunately this still prints 36.
>>>>=20
>>>> I just realized that the counted_by attribute itself causes the 4 =
bytes
>>>> difference. When you remove the attribute, the sizes are equal =
again.
>>>=20
>>> But we want these attributes to be in the kernel, so that
>>> bounds-checking can be done in more scenarios, right?
>>=20
>> Yes
>>=20
>>> This changes clang to print 40, right? gcc prints 40 in the example
>>> whether the attribute is there or not.
>>=20
>> Yes, clang prints 36 with and 40 without the attribute; gcc always =
40.
>>=20
>>>>>> I ran out of disk space when compiling llvm :0
>>>>>>=20
>>>>>>> So presumably this will go into 19.1.2, not sure what this means =
for
>>>>>>> distros that ship clang 18. Will they have to be notified to =
backport
>>>>>>> this?
>>>>>>>=20
>>>>>>> Best Regards
>>>>>>> Jan


