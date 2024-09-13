Return-Path: <linux-kernel+bounces-328284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0895097816B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338A51C22600
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C521DA627;
	Fri, 13 Sep 2024 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VDLWDshS"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F71D7E46
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235145; cv=none; b=PiSDmcC9YZ17/b0FLMWepknQ69jOnfb1adC+Kn8w+PchA+1Pv1UBR3LwjDg+YzgnQCFbENiOpbLTp2UlLEJbuAfyOL0UAcNw2SNGZgb6IDqbCdvw6BgcVEEUBxB5pkMIeemZ0+cZQBmgGggAbzPaSUq7DL4ag70TlyKHiPYD7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235145; c=relaxed/simple;
	bh=aviylsYmGCSXBAL9QBooOZiPJR0L/Lmo3/rF0QbeHI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVtJHbzyYBoE0vzsYF6FFlMQtyWT8+ve6VW6B7wo3lyuMepGf7cX/wNyFcimlP2UISqCrqoPpRJIfORgNWs1MPeMAD3jae/ofGtxAf89M/G5HIyeq/k1Ps3fmmBqUgb/6Jdi6TPOUTA489xBwTj9ah5V9LjTeU7sBq4jD1bYEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VDLWDshS; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E369F3F5B4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726235135;
	bh=aviylsYmGCSXBAL9QBooOZiPJR0L/Lmo3/rF0QbeHI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=VDLWDshSzNljSLTK74wnAc7m+kBHITv9TCgtXQ791taPljenN3sYUt1mUmcrmGxRa
	 E/FzReIkfuR6JiFxgHal28833T4ulZwpb0m+Y1CkK1H/XTW+weWScLT9Z3l2pLVXLj
	 BYjk1JUBPFNOE6J0LGYOIwtv+eWWTNa0JJVmaEaBrSUnLiOT2/BORW2D6kPHk3gPNg
	 TyPQHkW/n328mngWB3nixEIW212xftZznPQ2B2jXVubxu1RQ6kg9Zg7kixEhRPg5DT
	 xjcRYdXh6oZILH5ZKqSPsCw2G3IIRy4xv1iuTwAiiHkMjO8r24bMD+WnUGVSNRcz0c
	 EXjLrFiCZx2BA==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c24b4a57b4so558962a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235135; x=1726839935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aviylsYmGCSXBAL9QBooOZiPJR0L/Lmo3/rF0QbeHI0=;
        b=Nx0r04kA88nMDg0LXaQ7Aatcump50z8EcmelH6640Z94KJATxc/cAiXqQJAHZwjS7J
         ZOvnB9ZNlBQyCDKdUNhul3ZWX+r9hetWzSuCumyVETkaM/BmAWgbn+8fuCr288aZsdtK
         kWuz3y4yjiOvGzKxbhAtIW0hfdrWpB2dYV67NCgUJZNOxDNMjJdVpfU6jdIyvw+hrH6f
         QN7NOsUUnhqDwtz4e3f3rpHqGPWxq0ehpAK9Y6V3lFv8lEjEhwEcp8F9WqGycozOhxvu
         xXlYBiPlF4RvMYnxfl5vtmVG2TZ8JXT0wumxa7bSwWhRPnCflB1s50ZLPuP387RI6tB5
         +X/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVi48j/9s6xhSUP/fOLdiF9M4dBCeNUXYAk+7wEdv8qgw4O5yFob6PLmIoRfz+fK02zm9X0sJZNluxnLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl2I14v5Q/qZ86go/Ry/g8qA6TZrjN3cd0RiXR/QVAnAgtoZA8
	JwKt8VjOxF+BKEpKdvRmj2poINAjgLfDIhQ+RxMNQN2USb7oXUj09vRXNs3uPS1h30/+7uWvahE
	vVv1Kiqbm6CJ/Hbboro97F0WRrylbVdmZWW7y+n9JkCuJB8/IMLydbQIDJh8MXdKmxhipx9OmI/
	++cPzkrLBKgQpFGJxgWQ3XW+Bgc+wmUEIdc1CNbbEWRTI4cSHrkDWq
X-Received: by 2002:a05:6402:350a:b0:5c4:14dc:8c91 with SMTP id 4fb4d7f45d1cf-5c41e1b26cfmr2473049a12.23.1726235135364;
        Fri, 13 Sep 2024 06:45:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9fHYAoyON92L3VmfYpW+F+XX76BHrLOK6VyOn4RM5Xc+9oLVWc+LhLEbJWZ/qhKfonAT3Rqf8scc52xb7zDk=
X-Received: by 2002:a05:6402:350a:b0:5c4:14dc:8c91 with SMTP id
 4fb4d7f45d1cf-5c41e1b26cfmr2472994a12.23.1726235134235; Fri, 13 Sep 2024
 06:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
 <20240912191306.0cf81ce3@kernel.org>
In-Reply-To: <20240912191306.0cf81ce3@kernel.org>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Fri, 13 Sep 2024 08:45:22 -0500
Message-ID: <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Martin <jacob.martin@canonical.com>, dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,
Executing ./pmtu.sh pmtu_ipv6_ipv6_exception manually will only
trigger the pmtu_ipv6_ipv6_exception sub-case, which only takes a
second to run on my machines, so you shouldn't need to run the
entirety of pmtu.sh to trigger the bug. It won't trigger on attempt
#1, but in my experience, when I do it in that while loop, it will
trigger in under a minute reliably.

> Somewhat tangentially but if you'd be willing I wouldn't mind if you
> were to send patches to break this test up upstream, too. It takes
> 1h23m to run with various debug kernel options enabled. If we split
> it into multiple smaller tests each running 10min or 20min we can
> then spawn multiple VMs and get the results faster.

This logical division of tests already exists in pmtu.sh if you pass a
sub-test name in as the first parameter like above, but if you think
there would be value in separating them out further or into different
files not all in pmtu.sh, I would be happy to help with that. Just let
me know.

Regardless, I will go ahead and work on a new regression test that
executes just our quick reproducer for this specific bug and will send
it to this list.

Thanks,
Mitchell Augustin

On Thu, Sep 12, 2024 at 9:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Sep 2024 17:20:29 -0500 Mitchell Augustin wrote:
> > We recently identified a bug still impacting upstream, triggered
> > occasionally by one of the kernel selftests (net/pmtu.sh) that
> > sometimes causes the following behavior:
> > * One of this tests's namespaced network devices does not get properly
> > cleaned up when the namespace is destroyed, evidenced by
> > `unregister_netdevice: waiting for veth_A-R1 to become free. Usage
> > count =3D 5` appearing in the dmesg output repeatedly
> > * Once we start to see the above `unregister_netdevice` message, an
> > un-cancelable hang will occur on subsequent attempts to run `modprobe
> > ip6_vti` or `rmmod ip6_vti`
>
> Thanks for the report! We have seen it in our CI as well, it happens
> maybe once a day. But as you say on x86 is quite hard to reproduce,
> and nothing obvious stood out as a culprit.
>
> > However, I can easily reproduce the issue on an Nvidia Grace/Hopper
> > machine (and other platforms with modern CPUs) with the performance
> > governor set by doing the following:
> > * Install/boot any affected kernel
> > * Clone the kernel tree just to get an older version of the test cases
> > without subtle timing changes that mask the issue (such as
> > https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/nobl=
e/tree/?h=3DUbuntu-6.8.0-39.39)
> > * cd tools/testing/selftests/net
> > * while true; do sudo ./pmtu.sh pmtu_ipv6_ipv6_exception; done
>
> That's exciting! Would you be able to try to cut down the test itself
> (is quite long and has a ton of sub-cases). Figure out which sub-cases
> trigger this? And maybe with an even quicker repro we'll bisect or
> someone will correctly guess the fix?
>
> Somewhat tangentially but if you'd be willing I wouldn't mind if you
> were to send patches to break this test up upstream, too. It takes
> 1h23m to run with various debug kernel options enabled. If we split
> it into multiple smaller tests each running 10min or 20min we can
> then spawn multiple VMs and get the results faster.



--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

