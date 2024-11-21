Return-Path: <linux-kernel+bounces-417269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 635CA9D51CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D94CB26B37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7351BD9EC;
	Thu, 21 Nov 2024 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cPXwe1QV"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02371D9591
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210111; cv=none; b=lc7rU9STcjrcguIWWsqe/3SXCLQ9d5EJaxOyUP/4nP9dBSUJx2alEe75KU+EJW79HL9OoW2LXhJoLHX8a2UJFit1CR+dZ32UsL+bvIE3utXQUbhYwaYs1AoC+dYWkmbFgoG3Xdt1YLASYJ9jLHCINIKHXY9WJq+egmOxIp6L3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210111; c=relaxed/simple;
	bh=axuDJ2QE9SHOuDZAAkfRBgI+LeZ/kUeMPwZyuxxPjAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJeLKTaY6NGMoJFBmsBoVtNeZLWEs9sMr+BGu0P/jYkV4MLKGfOt5Uw4Jjn5cU/yOF4oLOmSkAXl5UxgDihERvaJGoesZzPWD2fq4ZOJHAkq9XvNt1cQvy3Xi8i9+Ldt8QtougengEFUebtCp7G8w6wkXgZc1/06ir1jrY2P35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cPXwe1QV; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dd1b4e01cso566203e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732210107; x=1732814907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj7SP4bYPK51uKYwZjwqzoRiq9ofYQdFXM5MlnbNaF8=;
        b=cPXwe1QVMhmJ8PFv/EBM+vRLe6HR4hlcNAJwT3a4FXqlG5kU6mg7VEWlSbc3vk0sfS
         smesYKomdG+RILvkzcENzbEe4vym4F3vAJSNLOnDp9rPLzI2oV61TBd4K8kGqTGS6FVr
         Y70LLegN8NM0770+dQGVyiRAXmDYr/7ofn6I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732210107; x=1732814907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fj7SP4bYPK51uKYwZjwqzoRiq9ofYQdFXM5MlnbNaF8=;
        b=m8ofRkgQYQE5a/lJt98y75rJLhBbu/tHYnIuYj0F7+nx30C8O94VFK/wEp5w8j47I8
         EjeWzjKtpA552lSefUzobQnk51YBx8W+ajwE+E3crH5kXRdW7BAE8o4vFH0iPAvS/QmQ
         tbf8wdYAEIm2UmnqDCT+1mnlGSBelAf57VTXUS2TKrvSlgxNGtXG7OWVARuGyicKPeJo
         RWto6TJVimRpnWxxV4OX2kOwxf6RwJJvhj90FeaQSHaxq3BgzU9j2oqm2Tw0jDWGgdUH
         Z7zYryO2FcrN2brGMg9Bale9N+vly6v56cniTDQh/uqRcKhIs31bwQXGrTH35PC06BJE
         r7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUQDkodaNQdX+3B2D0BpsMWYkWnzhIH+fOx7u33zZ/xBiwiv10bmbRhlV5oifBC+c5YhQ3HwgaLBgBvLY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxikLOtLaqDJR4e+yzc5alkAuj2Y+TcGwtksy7rTmcTlEWq1aze
	s0i6ECdh3tYUKyvR7orGg6jItMk541s4d8ufm0J8qJocgG62WXd3gR0WmU0MBAhhdg4k7+eCYd6
	zzvA=
X-Gm-Gg: ASbGncsgSBt8R2lGahxFoIRv/QNVhfmx15RLIw/owQMEJtMbKvD03GyMiiXLpOCRbqI
	TSgKpiAjqjUhcv0A9STsdCY6OnrIdY4GuPGbxPwrK2g2fSH+hgCMVgd1IuNjN1Nwaf90fFXJY8z
	m6IBG5Ftsd/J4sbw+H32B5R1UlM8Ddw0EvmKjDj3QvM6ARl192nrFQw5pq5xIJXoHoKGNKlJSrG
	XbA5aCZ60ZwVjJ0t8PcJ+SsmYGHVl4iJCRP43HkhInQ39UyBIik4rFlyciAOTRLhdPfPFICQdf/
	3PqnT2ZMUU9PFYMIz0wwbqvV
X-Google-Smtp-Source: AGHT+IGD7rn/M2JGi5xvqrYWqa1UWFZoS/5cW64H/lMOG6KE7PPLA927aABna0mHtw2uhlhmOInfjg==
X-Received: by 2002:a05:6512:281c:b0:53d:d0ed:9e06 with SMTP id 2adb3069b0e04-53dd0ed9ee7mr869169e87.56.1732210106649;
        Thu, 21 Nov 2024 09:28:26 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4384c65sm102561466b.197.2024.11.21.09.28.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 09:28:26 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso189850666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:28:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7qsmLq3T4zx3ngcHOr7n29HyK3/X1mUhIA6iu4hHs+Hbwf53JBpAyEBkHz9YAm3EcMPoMphP1wuGORz8=@vger.kernel.org
X-Received: by 2002:a17:907:86a0:b0:a9e:8574:dcec with SMTP id
 a640c23a62f3a-aa4dd74c845mr691934866b.58.1732210105563; Thu, 21 Nov 2024
 09:28:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org> <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl>
In-Reply-To: <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Nov 2024 09:28:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
Message-ID: <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Nir Lichtman <nir@lichtman.org>, syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Nov 2024 at 09:22, Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
>
> It'll "break userspace" in the sense the the resulting program name
> visible in /proc/self/{comm,stat,status} would be different than the
> expected value. Currently userspace is not using fexecve because this
> string is "just garbage". We'd very much like to start using fexecve,
> but we cannot do this (in the general case) if that'll result in a
> changed program name. If we change the value from the current
> (garbage) value to something that doesn't provide identical behaviour
> between execve and fexecve, fexecve will unused.

Well, then you had better not use fexecve(), because that "identical
behavior" is fundamentally impossible.

The thing is, "argv[0]" can - and will be - complete garbage. Yes,
it's *often* the same as the filename, but there is actually zero
guarantee of that. It can be any random thing - it's literally just a
user space argument.

And the dentry name *will* be the name of the underlying executable.
Again, it is *often* the same as the filename, but symlinks have
already been brought up as an example when it isn't.

See? There is no single solution, but at least the dentry name is a
*reliable* thing, not a random garbage thing passed in by user space.

End result: if you don't like it, don't use fexecve(). It really is that si=
mple.

               Linus

