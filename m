Return-Path: <linux-kernel+bounces-325214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA61197564B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A0F2859D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3315B1AAE20;
	Wed, 11 Sep 2024 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h68HPS2l"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AC1A76D1;
	Wed, 11 Sep 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066786; cv=none; b=lls3q1MfpRhwSs5xF/wwkMhhTZTFD9NwZmkFMnEA8Ii/udcU7QykseHOLS0vCB3PcZ5bJmVKQ/ECA0GIgkifkDjrwlLOkID+RDr6Cmm1d6Xa7n0yJZJgsUH3uQgDSmWXIB+BltzOG3hQkaRPpIgXHw1swUHXTRYRbjGZ0NS92T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066786; c=relaxed/simple;
	bh=UJbKAzpoA0Kzv6Jj//Qm4/uvIRTw+Wh+5UZkaP4eW2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHHds/4OZnPFK1AnkIGfZZwT5b1pi7jGRLDognGCDcbAvXxt5nLMN+lo8DRGG5I4oumICt+2JIEV/Qj3UJF64Zhu6lM2Thdrkn/gX7rEfX3rsd1Vjp6dZLH5eKuzLkHgJklVmpZ0QCJy9jVwifqsEbxkocHspS4QLAgdeHaxci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h68HPS2l; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3780c8d689aso4376998f8f.0;
        Wed, 11 Sep 2024 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066783; x=1726671583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UJbKAzpoA0Kzv6Jj//Qm4/uvIRTw+Wh+5UZkaP4eW2Y=;
        b=h68HPS2l7aAJNXSQI5b+0yWm58ZkL3ooHFXndT6kPJ5Zn1DQOkZovmZYsF4fpVs7cw
         cjPYLoJyd4vPKcyujaNYKJ+kKf0sh8R1JRXGAqdu1dX20NjBcOVqlF4/2o+KcTOVuVBt
         2RVtv3duD587J8QIWvTWKQ2Px7MBDEaw6bEvcPKoBfnNEuN9ZRPYz7wd91rpJhM07Ioz
         1waVcIIUCuF6RS4rN5OCvUzvJ8RSYNos4IZ5TTOR5zs2XSDIBfRd2+IpIzz/sca/f9ph
         tpDNwdnoZf4sE2hUjkO/n7TebTRTqiekXQeaZGW5e2oo1X7TQlBETIMUXaYPBlrVT6FQ
         9vTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066783; x=1726671583;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJbKAzpoA0Kzv6Jj//Qm4/uvIRTw+Wh+5UZkaP4eW2Y=;
        b=F+qsaYkWFBu+6hlpCLPVcTrE6QFu1RrcEfgtaNV5bZCQ9gPAL+D7U9FdaC2iIphhic
         iZ88ZRZLsuPz6rESJ7LGcJT2dBCeChD3LUtEo9a9+fy4tnS4mMlBo8680kyG+wGXUqD6
         3W0TBGk8b0qTmg+XOPi2E9ggX8t4+nhmumgte2qGdgdiodeK5f89MlUOE3EvOakidu0g
         ZmfiOSTWbhtffcUiqJC6ALhpgNqge2FOxyWug9wxsPhfVVr53j0gROWm6W7EQZVxZj3+
         ySMd40/eX6A+TgRWzIfuwUooyLWpmOlULXKxWisI3n+WW1L4PGd0BS1l+aMiVp/yT3J7
         AjXw==
X-Forwarded-Encrypted: i=1; AJvYcCVtXBVhI8/P0/ZzR7X3WSYeexBCbNwTILyM41XbT2Ok68M4N4p0F9CiZ8Sk1ANC3wkjeMT9af2gySF0E8IF@vger.kernel.org, AJvYcCWIIoop7Rjr1TAXOHdpU7BMh+WFfFzwVwWxe0DeFa2XZW3Q8+OiP6onwDsJn6Ur6VacZ6QR4H62dE7j0c7c2lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwhBjIg5MwWS1oEDEWQFFJ2raLE0wOXrve3wgx3G4lcHGqIVQ
	AKrOE1S1tvgqSyGQtkBfHU/6YUL/jha4403LQk0PfEKb5fohKXVC
X-Google-Smtp-Source: AGHT+IFYkvCW+c9TuCPJmiVI8o2vP7AuZHROvSNybQpWJAoJA9bQB5SF5MIoe9/Z4QcRseO8AG/Irw==
X-Received: by 2002:a5d:6290:0:b0:374:c847:852 with SMTP id ffacd0b85a97d-378895de57fmr10078743f8f.29.1726066782850;
        Wed, 11 Sep 2024 07:59:42 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de4b9sm11813507f8f.111.2024.09.11.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:59:42 -0700 (PDT)
Message-ID: <548605182873dadad9ee33dc6ed70e0eba4bf495.camel@gmail.com>
Subject: Re: [PATCH] ep93xx: clock: Fix off by one in
 ep93xx_div_recalc_rate()
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Nikita Shubin
 <nikita.shubin@maquefel.me>,  Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Russell King
	 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Wed, 11 Sep 2024 16:59:54 +0200
In-Reply-To: <a1ceab99-f26c-4edb-8f72-12abf20eec9f@app.fastmail.com>
References: <a05454f8-e409-4f60-93f7-6aa2ea0a2a23@stanley.mountain>
	 <246de2986dce9d867894bb006a1b2b3601e94a4e.camel@maquefel.me>
	 <a1ceab99-f26c-4edb-8f72-12abf20eec9f@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Arnd, Nikita,

On Wed, 2024-09-11 at 14:54 +0000, Arnd Bergmann wrote:
> On Wed, Sep 11, 2024, at 08:14, Nikita Shubin wrote:
> > Hi Dan!
> >=20
> > Reviewed-by: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > Alexander, Arnd
> >=20
> > unfortunately, the ep93xx DT conversion series is also affected by this
> > bug.
>=20
> Here is what I did now:
>=20
> 1. applied Dan's patch on a new branch
> 2. applied the DT conversion series on top of that,
> =C2=A0=C2=A0 removing that file.
> 3. applied the first patch (with minor context changes)
> =C2=A0=C2=A0 in drivers/clk/clk-ep93xx.c again, along with
> =C2=A0=C2=A0 the MODULE_LICENSE fix I did.
> 4. finally, merged the entire branch into my for-next
> =C2=A0=C2=A0 branch so it actually makes it into linux-next
>=20
> My plan now is to keep the branch in linux-next for at
> least a week and send all the other pull requests for
> the merge window first. If no other problems show up
> (either with this branch or my other 6.12 contents),
> I hope to send it all later in the merge window. If
> something goes wrong, I'll send only the bugfix as part
> of my first fixes branch for 6.12 and we'll defer the
> DT conversion once more.
>=20
> I should have merged it earlier, but wasn't sure about
> interdependencies with the parts that already got merged
> elsewhere and with the comments about DTC warnings.
>=20
> From what I can tell, the current state is as good as
> it gets, as we'll always get more comments or conflicts
> with new reversions of the series. Let's hope we can
> address any other issues on top of what I've merged
> now and stop rebasing.

thanks Arnd for resolving this finally and Nikita for
your relentless efforts!

PS. I've archived Subject patch now in soc patchwork
(because I think I've messed up the author info, but
all of this seems to be obsolete now)

--=20
Alexander Sverdlin.


