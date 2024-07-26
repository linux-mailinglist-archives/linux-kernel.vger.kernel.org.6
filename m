Return-Path: <linux-kernel+bounces-263387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F3493D539
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071791C22310
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C881CD16;
	Fri, 26 Jul 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnzaC8Yo"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475C182AE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004813; cv=none; b=eGUU76RPSLgYCir9A5Ro+jwsFIOkkGl8HiZ/ljMgBXldVv5iv+uQIUVYNwOWyQOo83Mz5eJ6k83A6BWyynz437gWNQRODZx6dd4t3uiaNlQkW1UNdtVSHJaLWxv9hbgo1qyIKpt9jS7Jxty6s00Ii2gKphphsmZY4EuyAlaKJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004813; c=relaxed/simple;
	bh=ulwwnhc+mAkGKfWxF/MrC5J/i0p/2VPb4E/VhhmcdpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sdb+EMw3S0injwvrBs0WXOhCifCMcvsPfYZahUwAzzDhkHCc7tHY5hQhObB0KzApXhhp9Q0S+FzdQyzn8RAdl7/QhW6esSH1b864VXh989hEynH55ddSAfiYoMYbqRWsUErbJTZYtURrEFjh/8Cz/ox1UYAOf7sCSKzq7T8IgHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnzaC8Yo; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-81ff6a80cbbso239701241.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722004810; x=1722609610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tV65IQg54aPZMNaUSM01ngj5YogaBYHcYLA+LYcxGps=;
        b=JnzaC8YopaWB7EYnNEtaDjsCbf4BIdOzFvsC2dczybBS3tEpfk5QDb9FIURDN0Wlm8
         3pMZUXlzT0rl3l7YLYSZ4ekEXwP2QU1IROE7aTCttcl/vstDhU3wO5zNK9i5Nc3/4dGB
         qJbIGHbfiCHZKOuQWSyb16BEX3yIytL9Ljs0FQBLgoHeYX3qWsQ0ky1lK12b2EoQipf+
         3VpDZCxamMAHOknskEZIVFxqaaX5nAMG8loek2eU5ezI1YUCbmrxbAShwu7BPNv7h/Z8
         ilvySLHwNCcHXxMpUOmzThEW6MU7E/9vnFkU9rnSvYcJYpGndMaKvI+tq2iEXcoayz7y
         UiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722004810; x=1722609610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV65IQg54aPZMNaUSM01ngj5YogaBYHcYLA+LYcxGps=;
        b=hptY5eJ1oNqjNvn2eKaOXqYdRieMz1svzLUK2Dltk4O+ufCpsN3Ol+OFSu1WjjhzRF
         xHGcTjr2FaNZp5fLu9ZOgMf98LTsvY1NFFZbjeNW+Y/bssNEuLqZ1+dGGibmbBi5izDM
         7lsF3d4APEXJbfH/ToHlMya6t1bbki/ED8+WNQI3EjnEwcZVS02bX5y4JdOcMc+CraAP
         Z6+kqHXWFRmguR39zWfpwD4TfQa81zWgDhb6VzAgCbqnGbU+LA7RozigRWcHD9ARqYhm
         uNl+SwiNOY07XEC5E11b/tb6zJ+//NSrtI4Y+MEcW8ZIW918CTMfbwTvIo77I9RvJOA9
         IQaA==
X-Forwarded-Encrypted: i=1; AJvYcCXotvSM5p3nROiGZihUc7QnciIfuu1QOt02nzeFEFX2cxWZSFkphrbA8bb2CSIwxrgtyvWHPxAAy0Hu9dUypIreeaUlZwGfQ/X/D1id
X-Gm-Message-State: AOJu0YxRd0JtEYFgzYNvvSbJJ4ybhM9RXd+9iFayw4d5mSch1Io1LVLr
	deA24b/lehWsmzvQXCqKr+gRRlq42SuD1WfQKX7KWErd1tI0tWygklEhFq+SMZyFPSCn1gj+3Nf
	d6KuPr9ZY/c+0TtHO13+H+x0+Vq5Pog8yvhfr
X-Google-Smtp-Source: AGHT+IHNPh2FVgbB2r/p8bmQoYBQ59fCoxJ02nk4FCnb5rGKbLefzEPA9Uzesrxeg4pBgpeiiqkRiQzpb/qNkxIFni8=
X-Received: by 2002:a05:6102:50aa:b0:493:badb:74ef with SMTP id
 ada2fe7eead31-493d6527a1bmr7693288137.26.1722004810317; Fri, 26 Jul 2024
 07:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407251053.618edf56-oliver.sang@intel.com> <CANn89i+Bia9PdGhAVfRbbubYo37+g+ej68qp32JmU88tsLLuRQ@mail.gmail.com>
In-Reply-To: <CANn89i+Bia9PdGhAVfRbbubYo37+g+ej68qp32JmU88tsLLuRQ@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 26 Jul 2024 10:39:51 -0400
Message-ID: <CADVnQynLaT0rGcLDBB+T237x6aHx7K74kNPZz4hLFTK7U=CVwA@mail.gmail.com>
Subject: Re: [linus:master] [tcp] 23e89e8ee7: packetdrill.packetdrill/gtests/net/tcp/fastopen/client/simultaneous-fast-open_ipv4-mapped-v6.fail
To: Eric Dumazet <edumazet@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	netdev@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 4:07=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 25, 2024 at 6:55=E2=80=AFAM kernel test robot <oliver.sang@in=
tel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "packetdrill.packetdrill/gtests/net/tcp/fasto=
pen/client/simultaneous-fast-open_ipv4-mapped-v6.fail" on:
> >
> > commit: 23e89e8ee7be73e21200947885a6d3a109a2c58d ("tcp: Don't drop SYN+=
ACK for simultaneous connect().")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > [test failed on linus/master      68b59730459e5d1fe4e0bbeb04ceb9df0f002=
270]
> > [test failed on linux-next/master 73399b58e5e5a1b28a04baf42e321cfcfc663=
c2f]
> >
> > in testcase: packetdrill
> > version: packetdrill-x86_64-31fbbb7-1_20240226
> > with following parameters:
> >
> >
> > compiler: gcc-13
> > test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40G=
Hz (Coffee Lake) with 32G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > we also noticed other failed cases that can pass on parent.
> >
> >
> > 42ffe242860c401c 23e89e8ee7be73e21200947885a
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :9           67%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/fastopen/client/simultaneous-fast-open_ipv4-mapped-v6.fail
> >            :9           67%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/fastopen/client/simultaneous-fast-open_ipv4.fail
> >            :9           67%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/fastopen/client/simultaneous-fast-open_ipv6.fail
> >            :9           67%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/fastopen/server/basic-cookie-not-reqd_ipv4-mapped-v6.fail
> >            :9           67%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/fastopen/server/basic-cookie-not-reqd_ipv4.fail
> >            :9           67%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/fastopen/server/basic-zero-payload_ipv4-mapped-v6.fail
> >            :9           67%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/fastopen/server/basic-zero-payload_ipv4.fail
> >            :9           67%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/fastopen/server/opt34/basic-cookie-not-reqd_ipv4-mapped-v6.fa=
il
> >            :9           67%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/fastopen/server/opt34/basic-cookie-not-reqd_ipv4.fail
> >            :9           67%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/fastopen/server/opt34/basic-zero-payload_ipv4-mapped-v6.fail
> >            :9           67%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/fastopen/server/opt34/basic-zero-payload_ipv4.fail
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202407251053.618edf56-oliver.s=
ang@intel.com
> >
> >
> >
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simult=
aneous-fast-open.pkt (ipv6)]
> >
> > ...
> >
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simult=
aneous-fast-open.pkt (ipv4)]
> >
> > ...
> >
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simult=
aneous-fast-open.pkt (ipv4-mapped-v6)]
> >
> > ...
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240725/202407251053.618edf56-=
oliver.sang@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
>
> This has been discussed recently in netdev mailing list, one ACK will
> get more precise information.

This should be fixed from this packetdrill test update from Matthieu
Baerts that I just merged:
  https://github.com/google/packetdrill/pull/87

(For our internal versions of the tests, Eric provided an equivalent patch.=
)

neal

