Return-Path: <linux-kernel+bounces-417304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9709D523D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFB81F22DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B287B19E965;
	Thu, 21 Nov 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FEHaRU0P"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84DF57C93
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212148; cv=none; b=sO89kJI2DDU3kD08FdejgrnyreBONkXdgvClNR6uwlxUhLDrXHJdijD2zdXu2S0BsHUCuMGsG6HIOwzpQbjyH/fATMxJhjN6/8YW9t2hxjN31dFB1cJnYL7wkEnweCH7NzsIOL2AHnRXOXo6E2SMv24ItnXOK5IXVmggAvha7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212148; c=relaxed/simple;
	bh=zlWgAkM2Ikdhp1SAp3HjXwNtV5oORAHm+B9XzT1SlUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVfxFtoYBTV38sZ/ADT4dU8mDccwuAFU+Xhx4vGyDEL3X4pmamafva2bjYfS49nUmV3RDwaAjdJ32bX8MOLhTKpoDWzmLZbJx7DjE3YFz8aK8kKFvk8XQqJdJ9oClIeZ36sfEXMMXFxWCFYCAYs1HgyHHKinlhU8GpD7gvjVRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FEHaRU0P; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so216615366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732212143; x=1732816943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLVX4vpQohaTobkJbTrjiL0FHPodDugyoTBU3RzZLI8=;
        b=FEHaRU0PgE8L3o/PlHMgf1Jbv3HZVYfEq5lohvQveRRic9Pm/PRFJYgnYa482NYLaD
         f0AFLyN7XF+CfrVL084SAJNmSJ7xvD6WvuLAgwUwioJxQnZgzgX0t1gsbg1h/rkAM33q
         Vadrlet39LVa4UNOJRn0owxwrQjOgdHUZUYDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732212143; x=1732816943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLVX4vpQohaTobkJbTrjiL0FHPodDugyoTBU3RzZLI8=;
        b=kvhARRvLHP3GlBrwyErZmJI5lY/Fqnu+rw/fmFuCRNX6HEESinVaaOxwrbyQO2QGZM
         M9mGYRsFxqd4w1wbE6CJ2rAmgs15ppG1C9s6hcoq3o3wAdpR/m7p4d44l1MgZenK/ATh
         +F1+L/yJHAO09fsgY2NKxH6tAoofS+tO0ha9aw4q3NubyzZokkhX9iACTAlVlUnyLvzR
         2xgddue7TmZbIkU3O40psTe3hRaPVqyg2CiA7+r1yxSnADcYuWxuMZyQ3IlYV0Ouze6U
         nMj/4O386B+8JCkKE5fxT4a3Mxnd+Q+PRelfgqmEvRbSb4s/JA6cvEjpV4nKvp5iieLp
         4GDA==
X-Forwarded-Encrypted: i=1; AJvYcCXheqJITjtoP1su6hOqjG89XzbO7Q2WNkB/D2SDpm5a+cxClLtzeeNgnzXBL5EQqTY3fItTAxWEAjDT8No=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqfElKmpFePHKslJMh/We0W5cXDGvg6d+5rctyGlUxCMinf2YF
	NDxvYHogu6DbwcD5yFJBJmCl/WDMzbH2QJRx73LrsB4wB+LotMmCBj6LhPePGkSZ4TGayMEOzj2
	GCgk=
X-Gm-Gg: ASbGncvnvXZT1638hra3WL23bwG3crkOVPJETzjKKgP49fxVwyowf/Ut5/FelBoti/R
	bZMDPfC738JBy47zGJMWf4c913RiMvmKN2sLUBB20OtAd7NR29Ko3GySC277XxqAwg4EeF2AvVZ
	nwQM1LNtOYRdvgC0GKcBE3R8Fe/WzukCjNjlpmjDJl3jVKuLUwwWNWDm8enhSHGyVkDa/vIa6X/
	4aNxBmY0LIBLwqCSPyx24VNKGfBN+Thy5lI0amp4KUk8nlkU0D1rj7ZIqGmUTqOx+TkAtouvADA
	0LjxbHlfv0CE7cn+cGoVFTaA
X-Google-Smtp-Source: AGHT+IH2X71hH4XD9qzqS9O3H7Om/40VyN426eQDICqT4DI2C+lwC9UH0j6VoM8yR1VV4xoo5agzqQ==
X-Received: by 2002:a17:907:aa5:b0:a99:f167:47c7 with SMTP id a640c23a62f3a-aa509bca75fmr6606566b.55.1732212142349;
        Thu, 21 Nov 2024 10:02:22 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f42d33a0sm106718066b.105.2024.11.21.10.02.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 10:02:21 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa503cced42so18476866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:02:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXUmjurczt9+9SjrAXRIvpbs+8iQR/81G+8qfi/zN+VtL91ScjYo3lQOlVKyJXqVbcXOApGViWmA9sx9Q=@vger.kernel.org
X-Received: by 2002:a17:906:18b2:b0:a9e:c2b5:198d with SMTP id
 a640c23a62f3a-aa509b843b4mr7963066b.42.1732212140554; Thu, 21 Nov 2024
 10:02:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org> <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl> <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
 <Zz91LyHzxxOLEma_@kawka3.in.waw.pl>
In-Reply-To: <Zz91LyHzxxOLEma_@kawka3.in.waw.pl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Nov 2024 10:02:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whv4q-RBXmc9G7NZ4GiATqE_ORU05f=9g00HkQXbV7vqw@mail.gmail.com>
Message-ID: <CAHk-=whv4q-RBXmc9G7NZ4GiATqE_ORU05f=9g00HkQXbV7vqw@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Nir Lichtman <nir@lichtman.org>, syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Nov 2024 at 10:00, Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
>
> Identical =E2=80=94 as far as the callee is concerned.
> Basically, we'd like to switch the execve() that we use in systemd
> to start everything with fexecve(), but this should be invisible to
> both the programs that are started and users who call ps/pgrep/=E2=80=A6.

I'm not discussing this. If you cannot understand the difference
between comm[] and argv[0], this discussion is entirely pointless.

I'd suggest you just not use fexecve().

            Linus

