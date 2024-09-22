Return-Path: <linux-kernel+bounces-335190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6680797E263
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9438A1C20DAD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755AA208C4;
	Sun, 22 Sep 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTi9smHS"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB1173
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727021525; cv=none; b=U8/5W/+O094gDl/+KkoqX+ItbQjwRF1S4yHHQPqU5DVkvGd4GYYDjx8jNMSWk51qGSLlxRv9OVHfPnVqD4UYJ/zUP+atMtREIPdkx3NL9Zg6aoYxzOSZqXo9MLJrj6w8M/Dz9E9YkLmDs438SjJxoLOHXsFqD2IbxN1sTptCZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727021525; c=relaxed/simple;
	bh=51l6XNUexh8/qlbrJv3BrjdxPtewTYNWQkCT5YXc6iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R50VpJdsVYXeFYqvMyXl/fs4xhSM9OgcKYAgOiS7iUU5xumYaHAHNXAGlc57PxZ2x790/FMs7fBdWJq1Qvsw1v670YIPRpI4jNmx8Nw4kSlebE/tzvLxvrhT2SlzgSvoQsXmh53L6JtByADXt/HZbiHiKP0ZO9boBXrtH1N+k50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTi9smHS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d3e662791so240325766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727021522; x=1727626322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZScRIIj0rv/9Bd3qE2ut3bquV/pUYAID0m18B2cH0Hg=;
        b=TTi9smHSOI3d0KgHXQw24VWzFEjgnJ4iC8rFmYn+wCChH1PG5ZEOCo0lH/IGa53o/H
         6GhEF+4MFnCixcgYj8juZGMTSJeI0nIMfbzr/pSKBRRyoHPySE3B0P/9g4bEIcamKIpB
         TV1TpawWCjz1SG4Uqh/fsrODQ8nZn2fdUuSWZpE1FvZ91yHEplLIkHof4UTvwAhBvxZG
         TPMWCqbl2IlMiUr7c39//PrPjvNOQzhKCJf5mnT7EWPe9biEgNJG2qJU6j4mwn86ed1v
         Y0rc76N/diPFYUyvXM/Bf0ttF/wBK5QmG7+eWclTRnz+1STv8oPFoaT2n3Fx8CpCWfRo
         3iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727021522; x=1727626322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZScRIIj0rv/9Bd3qE2ut3bquV/pUYAID0m18B2cH0Hg=;
        b=IHOjvwBiayClhdXYks79pxFPiFqNsG33GjJoGU3dO5kKp4IolpJiyMD7loe6ofVq2Y
         salxjHlvLElPGpeCm0+452tn9tUa7cYZuVzNmy0C45PMItR8q+RcTuRqpfoABb+u9jJI
         RsLYp21vQIhNA9remVV5eah6p/sQiVDr9dlvrzYpMqM2sMgQQry24U/ZpOx0vLxaIFAO
         SpxcJplYFtZ53/cPJvQL91KwR2wVuQA7j6dq/lEDFT5jM8QTY9a1GavvJFtFCTX+kzNG
         7bgPwziEDkpVXfOPvt+c4M4FiNebg4A2wPPL/jjHzqRw0EsFziro6nD2Eu0Fa9ZGjaPm
         3r3w==
X-Forwarded-Encrypted: i=1; AJvYcCWJd4X1tLKJ6bD6lnJNgA3E08LwMM54g0Qlj4VLyamo2Y24R9LSDdHkghMsiRIfS/9/sGk+oBlNm9HHAMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60HXwShDM6sNB+cqzSBDM9NMykrRptaS5fkHmKrPD/30N7STA
	wbpkCf/bY0wY7U4WRTvEEBUHp+WH4DDEE4qKH3/hO0Cwi0XA838PYfb5mR4lKZbIL+GMZSb4cTf
	fLnVLR/OrBsJZEc6FgLIhtn7QYdkS8sgcUKYb
X-Google-Smtp-Source: AGHT+IEBBDd+e0s02cZWTCvVhg7H+5VDYTZaKO61q87uG4FaCjGDfAIb7LhgHE9AxU07Dhj1hFuBN+HkH88jWhjYRK0=
X-Received: by 2002:a05:6402:348c:b0:5c4:14ff:8a7 with SMTP id
 4fb4d7f45d1cf-5c464a3d154mr11335828a12.14.1727021522189; Sun, 22 Sep 2024
 09:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000055b6570622575dba@google.com> <20240917235027.218692-2-srikarananta01@gmail.com>
In-Reply-To: <20240917235027.218692-2-srikarananta01@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 22 Sep 2024 18:11:48 +0200
Message-ID: <CANn89iLxa6V7BZSzmj5A979M2ZObj-CcDD_izeKqtRCZj-+pmQ@mail.gmail.com>
Subject: Re: [PATCH] net/ipv4: Fix circular deadlock in do_ip_setsockop
To: AnantaSrikar <srikarananta01@gmail.com>
Cc: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com, 
	alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org, 
	dust.li@linux.alibaba.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, schnelle@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 1:51=E2=80=AFAM AnantaSrikar <srikarananta01@gmail.=
com> wrote:
>
> Fixed the circular lock dependency reported by syzkaller.
>
> Signed-off-by: AnantaSrikar <srikarananta01@gmail.com>
> Reported-by: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De4c27043b9315839452d
> Fixes: d2bafcf224f3 ("Merge tag 'cgroup-for-6.11-rc4-fixes' of git://git.=
kernel.org/pub/scm/linux/kernel/git/tj/cgroup")
> ---
>  net/ipv4/ip_sockglue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index cf377377b52d..a8f46d1ba62b 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1073,9 +1073,11 @@ int do_ip_setsockopt(struct sock *sk, int level, i=
nt optname,
>         }
>
>         err =3D 0;
> +
> +       sockopt_lock_sock(sk);
> +
>         if (needs_rtnl)
>                 rtnl_lock();
> -       sockopt_lock_sock(sk);
>
>         switch (optname) {
>         case IP_OPTIONS:

I think you missed an earlier conversation about SMC being at fault here.

https://lore.kernel.org/netdev/CANn89iKcWmufo83xy-SwSrXYt6UpL2Pb+5pWuzyYjMv=
a5F8bBQ@mail.gmail.com/

