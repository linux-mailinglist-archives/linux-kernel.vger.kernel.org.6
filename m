Return-Path: <linux-kernel+bounces-349017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F83E98EF78
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9781F21F88
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E195E1865EB;
	Thu,  3 Oct 2024 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnZt3kqd"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA43824AF
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959383; cv=none; b=oKOdTPySHn1KBqoM78exUr/1M5RkPiSDBRXhVW2oZs5SSgPgI0tVptxmak0XbXT6Dim5fnhBJwz4XBfKJv42CGzcAL0ULl9ApJXTyxNDhzVJjoih/H6yETb7kUa8Uu8HhlAyLFc5DzJAha3XjA72weMXKdWerJTO6b6WdyqlQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959383; c=relaxed/simple;
	bh=qcVamlRvigeaXVXnl3jCWAjMMrMI99igfpThQdYaWeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG5z6+uiywsjIK4BpHT0TvJlO8oh+i6HvB3MtJpXpmfreiYefV909lW++z1r5jqi2MDKdCpzqbSeLdQv1BJnWQCan1t9Vfkv728tZTIxr2DUuDGosnMn5MoRQ8OIiFYb/eSzlYdL/SoUbcOLltf4t5RiujHW8+cjATTv6voTJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnZt3kqd; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e6b38088f6so139163a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727959381; x=1728564181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcVamlRvigeaXVXnl3jCWAjMMrMI99igfpThQdYaWeM=;
        b=UnZt3kqdUCwg3bzE0PDYsUweanlcQ8YneSA1fWhohuX6KM2mMid86HYd8/Nk34vnht
         yabRhRro5OLIE5scCgwCnhvv85fusQ0YSjIVH9cHTo14nmjcpylfDqpUdylYCdkET7y3
         m7Me9sbdMACj68wyCnKXdXgVrlZfqAMBqIJgLDJV9M9H+TB3QptOSXGXhJIcIP7nNipf
         i0QABu4RmXgHEcnLKfBT31FAPHeHtAKEJ1ojZcbSUqVDaieJ30j22ArQfpmMcOEIiIMH
         0NduHQQP6DTMq/PEAUiYL0X9cSX4/NOp67FMbzDEWvAy/O3wkksxiBIWTPlZoTmaxz+o
         sYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727959381; x=1728564181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcVamlRvigeaXVXnl3jCWAjMMrMI99igfpThQdYaWeM=;
        b=jamv2GLlSeisIMfZzWk4juYgn/OQy8dlV5rir/pYpkc14R3DFKb46f+NH3GGwBx8mk
         +C2wuqDnkzhFi+5HbvQv3ChGiYHH9HgbEJz1fPwn5vk/YR7QVERwXy7s7YSY8GuuDgNG
         5M9h6KxtgRGAtp1tz/1NKpP5sfvkd3OyouwdWzAbRnQyfhKTExSlJ9pJy481Y0PP0L+W
         uw34QkroVVJq2LgQhjuC3Lbhpo4WmRuS2QIYYiVP09+NNUtfEG7PkTF56APrcFp3NyDY
         JTzVvlforB7Nupi14YbFIxA604x4NhHA5DlbZkx31Cy7iFNSEMqAHfiu8Aaz+kwg4sQj
         nCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj6OmgLAFvZ/5EIaw9oj2l5cvSfwJ19ebChJKYl7ceiikCKPAYs6b4TQ3/mhsoOxY9WDsKkzO2E6YuaEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH7v726mr89NNdkH0s+car0sZB20/Gh1wGouEvPeeapC03+4US
	ZYE9DrmADtPo21XvaacN9/tP+7sb6HgeI9tzgVdNzU/SVANncIfWkrtzrYzkwhuVIPABQpldMTV
	tt99GijzCQeoBH4CXBMIFQYzIKOA=
X-Google-Smtp-Source: AGHT+IG7AYaKItfMhcr8eEzmPhpgpWAomQZKmXVNy3kcIWN37iY5tfFFOnmJs+Ygy67Y27047bpFLIdsItj6kTZ97XE=
X-Received: by 2002:a05:6a20:7483:b0:1cf:4dc7:e4fc with SMTP id
 adf61e73a8af0-1d5db121f1amr5163299637.2.1727959381510; Thu, 03 Oct 2024
 05:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
 <87zfnmbfu7.fsf@igel.home> <CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
 <87iku9r300.fsf@linux-m68k.org> <CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
 <87ed4xr22r.fsf@linux-m68k.org> <CANiq72k3BBCCChVhDRALxX=mrtq2dZYR1RzdVU00n2LU=sGXjg@mail.gmail.com>
 <87h69t75do.fsf@igel.home> <CANiq72=2MnRZKwVmDU7-XytFuA6BMSf5diOTfecXMTOa2oChDw@mail.gmail.com>
In-Reply-To: <CANiq72=2MnRZKwVmDU7-XytFuA6BMSf5diOTfecXMTOa2oChDw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Oct 2024 14:42:49 +0200
Message-ID: <CANiq72nGYFVFhhR_q1sHuLX4DsU339k=y4fdNc9L0e6vxRC8pQ@mail.gmail.com>
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tony Ambardar <tony.ambardar@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 2:28=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Oct 3, 2024 at 2:11=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.=
org> wrote:
> >
> > A simple gcc version test definitely does not suffice.
>
> By build-time test, I meant compiling/running some small program to
> check whether the compiler supports the feature or not.

Ah, sorry, I missed the "definitely" in your message. I think I
misunderstood your message.

Cheers,
Miguel

