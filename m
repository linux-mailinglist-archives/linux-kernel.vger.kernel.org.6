Return-Path: <linux-kernel+bounces-390722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F2B9B7DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEEA1F2165D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC631A01D4;
	Thu, 31 Oct 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNEyP1wm"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5B19D88D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387162; cv=none; b=Yr+G97O91Nc24q2tCoTXNmfDiFAjsmm3Zac00ORtJlxbHL1prsg9VdffDYRbNxhXDEVz7aKefoUU+/BRO/zbZ1Qdf9E6U4FckmHslxre+FAplZairBOlbVAgfEw6C1X1vDitQShZJn+L/YMl/X+U+JWwjmvslYUVtWLqYjrp5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387162; c=relaxed/simple;
	bh=okN6iKADsHDU5G1xc79CsdDuAzz4fO12E3NBBKkipAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAnpa9yj7iy8XMZvqiH7IqAPlKrUpvN1Sxp3//aXxX0XOgPfl9XJzE/EAWZxciEoemakTsXWru+pgZF13+yaj4B5jkVuphUJCqFhULisW1hfSQKNAhVZ8l4LGv4TY2ulbzFms3/TjnDwuEGuqrjve9HEbtMGGBLAgoIfoE/U3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XNEyP1wm; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a6af694220so918255ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730387159; x=1730991959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9gmY1X+Z6HaiDqI0rcQKxzw47LjvFY8Hd6hj/Hqn7c=;
        b=XNEyP1wmSQQiBdcR/uEfmgP18Cr2x3O5ite3FrX66XP4mrqvv0bg0yvD83fR7fgypO
         QXDiGnknz1SQ6runJ/idP5UZe5OaHkWTjy5Y2iZzThpOuK0D1eegNdVI7Imp14HavPQF
         xNn4GipGeeN3sYO6cgzfoinIdIlyt3jds1NrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730387159; x=1730991959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9gmY1X+Z6HaiDqI0rcQKxzw47LjvFY8Hd6hj/Hqn7c=;
        b=cihuyiSdzuTF+U7MWa0ZpCY75r3v71MeRv5HNaOfcdCjcXP9A6hEgwMDbZ1us/ZqnY
         0rkZ86uY40gH6tfiFAxAh6c4mRTGjC10HIV2vBDs1edxDxCZVWXCXtMlS4KpHVsrRRO4
         UDTJxeCNgG7vdpsYsgodokwIZzelvuFjKXv+OLomMl7a+UteSHVXY+fXbYWZemeNxYr2
         Z0Jz7CDcKCTgIaGvYJ8mXmTapunjVLufsnWIFbfLEH96KpbqqP2oCoKCRoGnRH8EjxMh
         rAVHXloouNwVzMtDGMZGKWCO/Pcd4YiMWe9ZUqFrMt1l0+Rn4nXaySlmHbdDkgIgroK1
         9NUw==
X-Forwarded-Encrypted: i=1; AJvYcCW2gOWBvT4iHuBfkdiFooMXqNvvdpVf9SRmO9Te3NQvBW74DtRJeH0yiipp23ycSFuIsBLa40MTu/K8uj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYBSGSMzqhRzChQFJRIeUrI7Es1KOYn01ixDxFhEVh/ezhXG71
	wBk0jfCDnb8L77vZursV0684JdPrrDZWnfd15eMW4MsP94QUvw5TSXC6j10DgwGOFeulzig84sg
	+uA==
X-Google-Smtp-Source: AGHT+IEtnAyHdFNGw83qQQ2TpCMZRoeVO8WNPS5dAK1NlQ56AmOpj1ee/qAGdMEGAgaA9PNi2by6Pw==
X-Received: by 2002:a05:6e02:b2e:b0:3a3:b45b:fb92 with SMTP id e9e14a558f8ab-3a6b03bfd5emr1254805ab.23.1730387158820;
        Thu, 31 Oct 2024 08:05:58 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6a9a2a14bsm3668325ab.61.2024.10.31.08.05.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 08:05:57 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso226675ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:05:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWI60LIXFihircK77TYeK593w10j6jF0PzDPMQRAn0QDOq45q9dEfJZZtHt6h58hnFpYyIGpDNdv5k+9VA=@vger.kernel.org
X-Received: by 2002:a05:6e02:2141:b0:3a0:a3cd:f23d with SMTP id
 e9e14a558f8ab-3a6a9361423mr2927785ab.5.1730387156524; Thu, 31 Oct 2024
 08:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910191117.1001581-1-jettrink@chromium.org>
 <D43HINLZGMXS.FYJOK0SVQFQW@kernel.org> <ZxckGbxzpWDuXG_q@google.com> <D59JJFBKKJ14.2KQSUSXP649DE@kernel.org>
In-Reply-To: <D59JJFBKKJ14.2KQSUSXP649DE@kernel.org>
From: Jett Rink <jettrink@chromium.org>
Date: Thu, 31 Oct 2024 09:05:45 -0600
X-Gmail-Original-Message-ID: <CAK+PMK45YwcV9S+nvB-QcjAKete889QATvv5jtVm=TbgRHZW2A@mail.gmail.com>
Message-ID: <CAK+PMK45YwcV9S+nvB-QcjAKete889QATvv5jtVm=TbgRHZW2A@mail.gmail.com>
Subject: Re: [PATCH v6] tpm: Add new device/vendor ID 0x50666666
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good, thank you!

-Jett

On Wed, Oct 30, 2024 at 5:48=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue Oct 22, 2024 at 7:03 AM EEST, Tzung-Bi Shih wrote:
> > Hi Jarkko,
> >
> > On Wed, Sep 11, 2024 at 04:21:24PM +0300, Jarkko Sakkinen wrote:
> > > I applied this (will push later to my remote tree).
> >
> > I failed to find the patch in [1].  Is it somehow overlooked?
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd=
.git/log/?h=3Dnext
>
> It is applied to my master branch now:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/lo=
g/
>
> Can you sanity check that it looks good? Thanks and sorry for the
> delay!
>
> BR, Jarkko

