Return-Path: <linux-kernel+bounces-448815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7FC9F45E3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DEB188DA0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D79189521;
	Tue, 17 Dec 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajqB7DlV"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62D1D63D9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423396; cv=none; b=X79ncgBXOuCpMi20hv+/sFxBLl5oem9k9tLjlRytdaeXRZHudO9srBayXhUH8vwi5hQ478Zej6dC5a8H2ZSJfc4B6350jcCg0kEBd3UfYfSMy/osEj0S+qpo5thBH8t9aDvAzGcMNwmkKBuiyyTnPa3/gIFeCqSiPzFK7iT3x/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423396; c=relaxed/simple;
	bh=TEQwfjMPGkhdsR+WurQ2jiRxK3ahF+A9mPh6oCOch4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFuGCXoETG9FyE6HJR111Sx7aO5eOedlUSR2zUVnh/OMPw/lkwwEnaSVBHLfrQDXWd/n2eMBGSz8z/s6TUYa+xGKYiowBQOluL8v80GNLFXsYmWYOr/iPP0XPga64+mS47TDbNs/xvsMwJsat/kgdDS6Ao7oDPg9s/vCCDz+6Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ajqB7DlV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso9170240a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734423392; x=1735028192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JL2feE5AJ6SSI4pvTMa55DednyFd7NS2A7NZzkYnzHo=;
        b=ajqB7DlVyyMvz3Jb6onUgI2rK1paJZDmsfk3fsgpLfl2yOSmW5TV05Vzo/aUkXAE+h
         LsXDpoJsQ+UAcRKszEcsadhYkUv5+ukYkCYpZdacHFB1MbSpDsxz9W0k+RZTDZp55PJT
         aAACnTz6QcSRraQQkHODNiLODDjYqgcH18TKxPG5Gha63X0fcMabAH4Uy+A/rMYctDEZ
         F6Z0z5lXRXF+/sYL97TFIS6KUuMITqlZVE+b9IXHVCepq1VOfJUamza5Q2Xt/46NXdxE
         DU6xsiHd2SIOhgzIZ2mtqMTQFzvh77EiZesLPyVoiS5wTNH7pUHyBcVK+aP7OqKMU4iW
         r3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734423392; x=1735028192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL2feE5AJ6SSI4pvTMa55DednyFd7NS2A7NZzkYnzHo=;
        b=ol+9GGx6mtvkiEobSviLVK7vRsjVcHGrEHlfnJtUDVZzb2/e9CIv3Lfgqd4oXSwdde
         Jbi8rTTp+CiPWQeFNN2wdilOlEDd+qPKB+5bf2758M+Od5YlpADLKHiZjg/ZUt8LX3p3
         j12Cisw3jsmOBAqWAUzMFe44oEh6rzGv/rYbPk8ejnumVfRtcdqA6rBEuuN8neuYdYN7
         Tlc4xPMvsdFgkQHjPETRbfX/UMbhqOdwaZRGJfEChugOpNlXOJHhB6FbodmalQ6mM+mm
         nmUS2i05YWvExVJJAr+Sa7BOUNGxaslD434sbv+mYJ77wpyIGumKxtoWdxu8cHdWT+lW
         xaPg==
X-Forwarded-Encrypted: i=1; AJvYcCVgAKjj6513rdAW0+Y+Fx1fMcUpdPb5IKYrNFZlr3mYRj1ZRNlz27Glq/y3y+GwlcRyx78nym5K2L2iGi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsv9BwC1ZKLS02iYklGrYdb0dwvsZYM+tiOMjVuKk1onwE5CC4
	bA66ygrTOxAlauhJDIZ0BW8pUBbpk/RNE5XHMGlxL58060nwCxb0QpZxJEqPy2WH04FvXuO6Gop
	nTxJev2kQlIF9mmbREsTm0LIBX7tDQGINeKtK
X-Gm-Gg: ASbGncuqo6s1Kojr8I7ojtEk4DVFjJQ6lY5FTUmiOg86XZiItM2sQZNbTaUO+O9zMzz
	IdngAdzgA6ieNx1lIZj8GkLyLwIo7UOdXN2qUG1WD9nI9mPhMuhocjP+wr80gdoZDJneLmP0k
X-Google-Smtp-Source: AGHT+IHvOQNHHUzZZhpakqGzbgg0f+KZLUwMpZirhCCXzghhhZojKMMtWfuof6FgPRbxHa3SPEkaCDyvaCOA0s5LVS0=
X-Received: by 2002:a05:6402:1ed5:b0:5d3:e79b:3b3d with SMTP id
 4fb4d7f45d1cf-5d63c42a44dmr14310743a12.28.1734423391517; Tue, 17 Dec 2024
 00:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
In-Reply-To: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 09:16:20 +0100
Message-ID: <CANn89iK1+oLktXjHXs0U3Wo4zRZEqimoSgfPVzGGycH7R_HxnA@mail.gmail.com>
Subject: Re: [PATCH net] net: sysfs: Fix deadlock situation in sysfs accesses
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	TRINH THAI Florent <florent.trinh-thai@cs-soprasteria.com>, 
	CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 8:18=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> The following problem is encountered on kernel built with
> CONFIG_PREEMPT. An snmp daemon running with normal priority is
> regularly calling ioctl(SIOCGMIIPHY). Another process running with
> SCHED_FIFO policy is regularly reading /sys/class/net/eth0/carrier.
>
> After some random time, the snmp daemon gets preempted while holding
> the RTNL mutex then the high priority process is busy looping into
> carrier_show which bails out early due to a non-successfull
> rtnl_trylock() which implies restart_syscall(). Because the snmp
> daemon has a lower priority, it never gets the chances to release
> the RTNL mutex and the high-priority task continues to loop forever.
>
> Replace the trylock by lock_interruptible. This will increase the
> priority of the task holding the lock so that it can release it and
> allow the reader of /sys/class/net/eth0/carrier to actually perform
> its read.
>
> The problem can be reproduced with the following two simple apps:
>
> The one below runs with normal SCHED_OTHER priority:
>
>         int main(int argc, char **argv)
>         {
>                 int sk =3D socket(AF_INET, SOCK_DGRAM, 0);
>                 char buf[32];
>                 struct ifreq ifr =3D {.ifr_name =3D "eth0"};
>
>                 for (;;)
>                         ioctl(sk, SIOCGMIIPHY, &ifr);
>
>                 exit(0);
>         }
>
> And the following one is started with chrt -f 80 so it runs with
> SCHED_FIFO policy:
>
>         int main(int argc, char **argv)
>         {
>                 int fd =3D open("/sys/class/net/eth0/carrier", O_RDONLY);
>                 char buf[32];
>
>                 for (;;) {
>                         read(fd, buf, sizeof(buf));
>                         lseek(fd, 0, SEEK_SET);
>                         usleep(5000);
>                 }
>
>                 exit(0);
>         }
>
> When running alone, that high priority task takes approx 6% CPU time.
>
> When running together with the first one above, the high priority task
> reaches almost 100% of CPU time.
>
> With this fix applied, the high priority task remains at 6% CPU time
> while the other one takes the remaining CPU time available.
>
> Fixes: 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in sysfs methods.")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---

At a first glance, this might resurface the deadlock issue Eric W. Biederma=
n
was trying to fix in 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in
sysfs methods.")

I was hoping that at some point, some sysfs write methods could be
marked as : "We do not need to hold the sysfs lock"

