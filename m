Return-Path: <linux-kernel+bounces-511189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91814A32761
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07423A904A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C7521CFF7;
	Wed, 12 Feb 2025 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ObAogfSp"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1A20F078
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367726; cv=none; b=sO0Pqr0B7DsYnJRjjpsj92jvmCS43wR87hM5WRUh0F/lTtOhHwHdydEqcFeanZEvVBvGx2DSMF9r96ebhAv0c6Z3hZzPXFNAMCZkhALhZoqpCQz9XODT+oDUsly+ltY+97P3gmKdOdhLAfY5f3afKXe1waGNrrvH7dI3OeETqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367726; c=relaxed/simple;
	bh=HzA97DPnn+U2gZkXV8YQI5t4LN4Nd9v0u24mxG8tzFo=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=NTOk8dI26flPi+EG53R1/zds4/6aMY1D+30uFJBCANZcZmZmFaM2D06PLnuuzoRkGZBqW3kr85FQ7h8318ReUyvuAHr5LAjMj+l/4UoDDbRXGFgZRLuojx5JCuVwlV3eahto7c3B8ZUvT2pqm9QOBSXZ6pnJtGMISLkr/q7TqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ObAogfSp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de74599749so5484148a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739367721; x=1739972521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vx4K/GwJmSxxuxEf9CYEVojUHCwqS7V2m4wDGfnHgXs=;
        b=ObAogfSp60miJjwQ2qilScjFLmjvSMi58i905OlYlQxPJxDUpLIIIiPpeQPDsnr8Oo
         fn2QLXm+eRI9aodVrw7FVGGz/I/KiARDksK0Q0jUNXZx6RtuHB7uhzv4T/d94hzOBaii
         gF2xLtnYxowDS5lGEP4f4rjWtq8Qg+1oEskR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367721; x=1739972521;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vx4K/GwJmSxxuxEf9CYEVojUHCwqS7V2m4wDGfnHgXs=;
        b=lHEW3Bkn5X4kq/kyydLfRlVMS0HvNj9R3wRjZgexFNrEsepir4p7R/4IKOwSDWbgkd
         Uo2rMjNLdUCVm/GyyRXktT9qsdJRA8Dan3hm/2FaTLiH5HkqzlIYOV7fduDL2d0BeNxu
         RqrYm/VWZgkbH77s8NB96O6qb9vhO4t54IsSJZmBJm3TxckH9JKH4gFb+bCt0cFzdG/K
         gJt+srimHkJmUvHAAS3BuWva4NWKz0i0e/vOpg/Zr+lX3w1/XVdvLODJZEeIiDKZq2ek
         LUvtCvdG2vrI4w3LvanNrZApgvTZt2Uq3vxF/rPQQ/kjaNNyXwA6rZUM4flPKGMYAm+D
         UmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3W1JpIkbwC03+zqYoXp5iPAzn6tY1WCNnTAgr1R8PnKlTwH3sxtf4EaW9cK9oxuawhtiJ3gnkUHo1D6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZg0EAjl0lMyxTQMlGBwYwoJZvKwpjANY/EZVOOTkcvWSsArg
	UYl0M+wO8GDJ+gjV56yyBYSXeUoFY8ND/TQm0VuJ9m+a10r34Y8Szwtwzo420EEqesMKXjpOO0/
	iFYinK+R4ZADKUNePiitvT+Ut90vrMWy/+8wQJw==
X-Gm-Gg: ASbGncsgICyWl4q0xbjc7r7fGzcjvedDo4nlfdv3mwciDcCsTYvvhuJAgB1KCXhRb9F
	V71NS4Ajiy6/IBNkpmt5lIj3CKk8Q3nlIlBZc+ah+j2K7bvHV61wkHNBMQTEbdMDEqJe28Jt/SV
	WKIepIlWtUpYYhsT1bRUyqOzyc
X-Google-Smtp-Source: AGHT+IExY+577RFSkgohoQb2qPrtldLo7ZoR+uTGSWF+pFLzLK8mEvgKjNwZyU3Yafymz93SmD9UC67l3DwKniJi9kE=
X-Received: by 2002:a05:6402:4606:b0:5dc:da2f:9cd1 with SMTP id
 4fb4d7f45d1cf-5deadd7ff22mr2750686a12.14.1739367721337; Wed, 12 Feb 2025
 05:42:01 -0800 (PST)
Received: from 155257052529 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Feb 2025 08:41:59 -0500
From: Joe Damato <jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 08:41:59 -0500
X-Gm-Features: AWEUYZlwmvHKRwI2fJFJaa53LoTAcn2hU8f5TdJuaF-vAvBD-4SwZmnDN9AK2pE
Message-ID: <CALALjgw_h9ToEaiQdKebyp0KLgJvaHJuxyLh3ZXAYgz6v5SL-w@mail.gmail.com>
Subject: [PATCH net-next v7 0/3] netdev-genl: Add an xsk attribute to queues
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, stfomichev@gmail.com, horms@kernel.org, kuba@kernel.org, 
	Joe Damato <jdamato@fastly.com>, Alexei Starovoitov <ast@kernel.org>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Daniel Jurgens <danielj@nvidia.com>, "David S. Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Mina Almasry <almasrymina@google.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

Greetings:

Welcome to v7. Added CONFIG_XDP_SOCKETS to the selftests/driver/net
kernel config in patch 3. Updated the xdp_helper.c to return -1 on
AF_XDP non-existence, and updated queues.py to skip the test if AF_XDP
does not exist (but fail in other failure cases). Tested on kernels with
and without CONFIG_XDP_SOCKETS enabled.

This is an attempt to followup on something Jakub asked me about [1],
adding an xsk attribute to queues and more clearly documenting which
queues are linked to NAPIs...

After the RFC [2], Jakub suggested creating an empty nest for queues
which have a pool, so I've adjusted this version to work that way.

The nest can be extended in the future to express attributes about XSK
as needed. Queues which are not used for AF_XDP do not have the xsk
attribute present.

I've run the included test on:
  - my mlx5 machine (via NETIF=)
  - without setting NETIF

And the test seems to pass in both cases.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250113143109.60afa59a@kernel.org/
[2]: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

v7:
  - Added CONFIG_XDP_SOCKETS to selftests/driver/net/config as suggested
    by Stanislav.
  - Updated xdp_helper.c to return -1 for AF_XDP non-existence, but 1
    for other failures.
  - Updated queues.py to mark test as skipped if AF_XDP does not exist.

v6: https://lore.kernel.org/bpf/20250210193903.16235-1-jdamato@fastly.com/
  - Added ifdefs for CONFIG_XDP_SOCKETS in patch 2 as Stanislav
    suggested.

v5: https://lore.kernel.org/bpf/20250208041248.111118-1-jdamato@fastly.com/
  - Removed unused ret variable from patch 2 as Simon suggested.

v4: https://lore.kernel.org/lkml/20250207030916.32751-1-jdamato@fastly.com/
  - Add patch 1, as suggested by Jakub, which adds an empty nest helper.
  - Use the helper in patch 2, which makes the code cleaner and prevents
    a possible bug.

v3: https://lore.kernel.org/netdev/20250204191108.161046-1-jdamato@fastly.com/
  - Change comment format in patch 2 to avoid kdoc warnings. No other
    changes.

v2: https://lore.kernel.org/all/20250203185828.19334-1-jdamato@fastly.com/
  - Switched from RFC to actual submission now that net-next is open
  - Adjusted patch 1 to include an empty nest as suggested by Jakub
  - Adjusted patch 2 to update the test based on changes to patch 1, and
    to incorporate some Python feedback from Jakub :)

rfc: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/



Joe Damato (3):
  netlink: Add nla_put_empty_nest helper
  netdev-genl: Add an XSK attribute to queues
  selftests: drv-net: Test queue xsk attribute

 Documentation/netlink/specs/netdev.yaml       | 13 ++-
 include/net/netlink.h                         | 15 +++
 include/uapi/linux/netdev.h                   |  6 ++
 net/core/netdev-genl.c                        | 12 +++
 tools/include/uapi/linux/netdev.h             |  6 ++
 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/config    |  1 +
 tools/testing/selftests/drivers/net/queues.py | 42 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 98 +++++++++++++++++++
 10 files changed, 194 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: 4e41231249f4083a095085ff86e317e29313c2c3
-- 
2.43.0

