Return-Path: <linux-kernel+bounces-209952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0F5903D51
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAC42891B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B78217CA06;
	Tue, 11 Jun 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhOS1BFC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548A17CA03;
	Tue, 11 Jun 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112529; cv=none; b=iyNqyMCS+dIMQe63OqKzVgNtrOW9B1uhsvTT4u9NllQWKGdeP6Kn48g++n8HDdZbRIvqs4HU8+bLidWxvPrOPcCsFZLr0wwM8MI5A+yrwuDBioZgPQpO8WDfQpJxZyY98U5haluR+rbRg69n0W2bifnFUvlo9Va4scHXbmnoc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112529; c=relaxed/simple;
	bh=ZEwkkTMQL/4fU2ogDD+72F11vuWnXpG/X2IJwXrbNJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tm9p+5EtVHDN5cKOpnoEI5OiYBWGVeogYhgHfmPC5dKOePlFJzLK9c6BJhWNW/17BLOhi1xKmLjaBIqjHqDd0H6HRv/QlxAmO7m8pnFhaAf2Z7gxv7QBMG/LWNZDosk0FNIRKwdlavP6hpQKCUFG7XZlQCLLvKoS0jNLKzCiHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhOS1BFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263DFC32789;
	Tue, 11 Jun 2024 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718112529;
	bh=ZEwkkTMQL/4fU2ogDD+72F11vuWnXpG/X2IJwXrbNJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rhOS1BFCh7cbbhKz1ccVOKRvbXIq1FJmo/rVJft3QXoyzzZafE0gQjXqMCnQZIlOa
	 4eetBZ1P8FUq/5CvclReuRediHZV+9TmOSkAbGIm7uesi803Q9/6OWEhnWPLoZwWrq
	 yJCm2A/4VnK8IolB2fSAvbxa6D87+QNvashqCXp2ifk+RA9qHpr8r0BG+unY7wo/iS
	 i3tQwiHDYjNjryXQXcWk5Bwjy479BwbaakUiw6OrPhScuGlpbja6QKH14Zr/73Ajii
	 NJoDL9NwrosR7EtP1FcMnVX/ftSb0qYDdJxjTaqK6jIkPCbdILeU5/aSIW2/OOIXlk
	 OpMCrVS8rSVZg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b96a95c5e8so3038732eaf.3;
        Tue, 11 Jun 2024 06:28:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfjOwzOaSUDFkO4T20G8AWrTsHt1OjyQbdi/2RyT+69TZdAziDqOAjvaXBJlx+gEoABT6ZCMGnWRUAYylx4VbP5FzzCM/PJIlSTsKd6J4WHqbpQzke/rBb4gcH7f7TD00eVZsmAio/CfobNO7/OZE0
X-Gm-Message-State: AOJu0YyRDmTAwI4/DIEVvTwQFFpcTdzKA7UE9/Wa3jbudtlTKLLkcUPx
	iH2KF+I7354SjwWpDLQapq3WlT3HqocbFrpEJuOF5JZ1mMzdz2JQZ50H7aI0ftKEHGqOhrhiXrJ
	6uFE1J7y9Jy3ZK5NdlCo8a080fb4=
X-Google-Smtp-Source: AGHT+IHlGKbtoqSzrPuKgTNyQwgeafZr4upSLMIYVozrJD3uFzQQvkgvs5KhKonxebKDoBlVg3RkcFYQLBO7Ux1UT+4=
X-Received: by 2002:a05:6820:168e:b0:5bb:672:404d with SMTP id
 006d021491bc7-5bb067242a8mr5150419eaf.7.1718112528431; Tue, 11 Jun 2024
 06:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024051727-CVE-2023-52666-802b@gregkh> <85948141-5eae-bb3d-cb39-62fc6ddfe476@huawei.com>
In-Reply-To: <85948141-5eae-bb3d-cb39-62fc6ddfe476@huawei.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 11 Jun 2024 22:28:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8HNYvhq6jiBUfh3sLwPDEsR43yVkUZuqsX+7ARezy52g@mail.gmail.com>
Message-ID: <CAKYAXd8HNYvhq6jiBUfh3sLwPDEsR43yVkUZuqsX+7ARezy52g@mail.gmail.com>
Subject: Re: CVE-2023-52666: ksmbd: fix potential circular locking issue in smb2_set_ea()
To: Wang Zhaolong <wangzhaolong1@huawei.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org, 
	linux-cve-announce@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 6=EC=9B=94 11=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 8:30, W=
ang Zhaolong <wangzhaolong1@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
>
> >
> > The Linux kernel CVE team recommends that you update to the latest
> > stable kernel version for this, and many other bugfixes.  Individual
> > changes are never tested alone, but rather are part of a larger kernel
> > release.  Cherry-picking individual commits is not recommended or
> > supported by the Linux kernel community at all.  If however, updating t=
o
> > the latest release is impossible, the individual changes to resolve thi=
s
> > issue can be found at these commits:
> >       https://git.kernel.org/stable/c/5349fd419e4f685d609c85b781f2b70f0=
fb14848
> >       https://git.kernel.org/stable/c/e61fc656ceeaec65f19a92f0ffbeb562b=
7941e8d
> >       https://git.kernel.org/stable/c/e9ec6665de8f706b4f4133b87b2bd02a1=
59ec57b
> >       https://git.kernel.org/stable/c/ecfd93955994ecc2a1308f5ee4bd90c7f=
ca9a8c6
> >       https://git.kernel.org/stable/c/6fc0a265e1b932e5e97a038f99e29400a=
93baad0
>
> Hello.
>
> Is this a valid CVE patch?
>
> I noticed that the introduced `get_write` is not being used within the
> function, and there are no follow-up patches addressing this.
My bad, I'll update this.
Thank you for your review.
>
> Best regards,
>
> Wang Zhaolong
>

