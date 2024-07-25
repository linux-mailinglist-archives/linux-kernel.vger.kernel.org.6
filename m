Return-Path: <linux-kernel+bounces-261910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A26393BDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F78EB20EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00219173343;
	Thu, 25 Jul 2024 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfS8JL2Z"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72653172BC9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894859; cv=none; b=OnQHe6DE67k1jrgh8NVft4cJlrPl4mGB7FATqZfxW8t9bGI5vMiEzXOHdLnkjxd0D64fnKPY30reSn7B4GPGxVZCI9E1IiE78UXk0WZJdOXEEhC7C3UfX4+gAXgR7GttTtwxv/XbkExP0ERfBl9MWm1Da38VV0cO6X8PoUWuo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894859; c=relaxed/simple;
	bh=r+M3o6SVfTD1vC9T28BpdhS5PBq7BQ34eYtryUx0Hug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSgU3sWsxsrhIJEJ9lChbXamY1eUSCXskTifU62ymf94PY7e5oC3wN/++0oIyTJUrzB8R3d2gYzUaV7GWxxcrFv7SddyVxqJkKBADD7gJko9ufbw8AUe7e8HDXcSLAla/Yx54RNZeJelJHsp7X9D1+j7tiEcFsAa/D3VttYXXBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pfS8JL2Z; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so7613a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721894856; x=1722499656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIQkCLUKnLONxhUVH4Hgod3J1H1l8mUYWFUy/48yoHk=;
        b=pfS8JL2ZPlLyJV5nglmj8azFy5FfgUOC0YyhWnMZ4zWoLT5NmivTGQvn/csnZutggF
         laNvy8WXY6Sw2kUF0ikg+LD10EteYOO4zB69VUB1Jo8B8MZxLwFteGIly5Fbumn23bxL
         tZ76dKHprGpKVaoRVb1YSe1odB+kMfxrGC+8+4jMBxFQdR0OQXoWyJcYrIhb3gPed2U4
         SDSTy8NbnmyL3QjZCfqFs0w0MdHsvtmBO+zS8y96PDhM/tsv+hhOfBKEDuw9j43WX/7S
         DwSOuwlW/WXZMnpKqFuzoEYS8CKlmdHDfum3lpFMWHT+EQ6iYMKdsGkcvhIcOTU8fo27
         Lgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894856; x=1722499656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIQkCLUKnLONxhUVH4Hgod3J1H1l8mUYWFUy/48yoHk=;
        b=rXBXU9OobpbwHNc3OFBB+lJF+KI6L0XJuQKQeAW/Lw58PVsvaA2vevi5WRQkA6IKqS
         qVDQXycxeySkv9g/YEEd1WnR5ggBzUaFG8cwtzBpdt1yU9q64lmI8wT1GAMrx8AoKbWg
         aZwg8ZtAn8xasUhD8dFABzSSj1qkUpGphM4cKkQByFxXzoRa+p1QVJnnJFzlqKc76AEt
         X9IQWcEkLs0lq8WpwD68ZL41RqU+d17ZNNCEQC3c07V2bz1REKoB+C9RQiI10siRCEBx
         56EkS9Rc2Sx8nhT35YHZ5t8/zzVRhk90QDgGU9c3BV7YVobFMBEzqg+0ZB0PM26a1mZS
         h0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUHgX2/zAE3AVAzCKXGudJdCtWAI1P5bNm0AhSQQpxZJHTZCf8820FNMDxAfC/hqJznkbwdrVZpEfhDXNCegxAjRV24PNKdg07yfMYs
X-Gm-Message-State: AOJu0YzHzktMmDd6XG0dtN4WXvGsF5OPXFsRPFAcISrRauc/T7YwEWPF
	RxX1tU5GQNyfG0tK59b2EVyoZsncqreRORneTE/wuk69k3wfhJ+wgUBCnaSxQ/voSWkQejS7u5q
	MYsyKJmEgdumTH93GxQurqpCl/60RRcbaCHuTQ2ZdnB45H0qTJA==
X-Google-Smtp-Source: AGHT+IHl0LhuIwDpRoXa6gfrudcKM9vX8uhEq/AZ3MBhrUx8F2WnDsHvrrDN5URTN7HjWmm6RbPaMKgp4O++3+UyhG0=
X-Received: by 2002:a05:6402:2709:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5ac4ce391edmr123068a12.6.1721894855222; Thu, 25 Jul 2024
 01:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407251053.618edf56-oliver.sang@intel.com>
In-Reply-To: <202407251053.618edf56-oliver.sang@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jul 2024 10:07:21 +0200
Message-ID: <CANn89i+Bia9PdGhAVfRbbubYo37+g+ej68qp32JmU88tsLLuRQ@mail.gmail.com>
Subject: Re: [linus:master] [tcp] 23e89e8ee7: packetdrill.packetdrill/gtests/net/tcp/fastopen/client/simultaneous-fast-open_ipv4-mapped-v6.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:55=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "packetdrill.packetdrill/gtests/net/tcp/fastope=
n/client/simultaneous-fast-open_ipv4-mapped-v6.fail" on:
>
> commit: 23e89e8ee7be73e21200947885a6d3a109a2c58d ("tcp: Don't drop SYN+AC=
K for simultaneous connect().")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master      68b59730459e5d1fe4e0bbeb04ceb9df0f00227=
0]
> [test failed on linux-next/master 73399b58e5e5a1b28a04baf42e321cfcfc663c2=
f]
>
> in testcase: packetdrill
> version: packetdrill-x86_64-31fbbb7-1_20240226
> with following parameters:
>
>
> compiler: gcc-13
> test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz=
 (Coffee Lake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> we also noticed other failed cases that can pass on parent.
>
>
> 42ffe242860c401c 23e89e8ee7be73e21200947885a
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/client/simultaneous-fast-open_ipv4-mapped-v6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/client/simultaneous-fast-open_ipv4.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/client/simultaneous-fast-open_ipv6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/basic-cookie-not-reqd_ipv4-mapped-v6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/basic-cookie-not-reqd_ipv4.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/basic-zero-payload_ipv4-mapped-v6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/basic-zero-payload_ipv4.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/opt34/basic-cookie-not-reqd_ipv4-mapped-v6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/opt34/basic-cookie-not-reqd_ipv4.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/opt34/basic-zero-payload_ipv4-mapped-v6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/opt34/basic-zero-payload_ipv4.fail
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202407251053.618edf56-oliver.san=
g@intel.com
>
>
>
> FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simultan=
eous-fast-open.pkt (ipv6)]
>
> ...
>
> FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simultan=
eous-fast-open.pkt (ipv4)]
>
> ...
>
> FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simultan=
eous-fast-open.pkt (ipv4-mapped-v6)]
>
> ...
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240725/202407251053.618edf56-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

This has been discussed recently in netdev mailing list, one ACK will
get more precise information.

