Return-Path: <linux-kernel+bounces-553128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E0A5843F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5237A27F9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4E91DC04A;
	Sun,  9 Mar 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="M8119lH0"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194881DFE8
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526981; cv=none; b=QNQmC/0Y4O4ifgJc4vIhdTQRDoq81UTU7hMxEHX83szysic36PmfymH7i7HKnj28lKRfzqr0PBcRLKuHSK7cmi82tdOGaubrHDRhH2w1itqF6ItYeZUVPMTcN8E5Zc0cwAaaPQo8yd48JUOOlE+ldYReJZX9cn7YwpDfgl6UV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526981; c=relaxed/simple;
	bh=BFBez99hJQWF8yQf0dUSZg1LTudTSAcMT/T2RWUc2CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i9ffX2FLBX80j3/NtckjxBTTJFg/dsGjkmdWBiJXiip4yLhfK3yfGZcRK84pG+erSX+WmjmWyB1gJ9nLInDqf93VdanfhJeH1P6HIPX2IFMaA+J8ECHdHqJ84+cFjCva7cBD8YQWzpFqgX0CwwqWra4+xpbkJSUMzdQJ2X36M8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=M8119lH0; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4DE003F129
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 13:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526975;
	bh=mqFbLsvDYgZMcATbnfiiqW+yfZu2sdh4iXGZzYCmKWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=M8119lH0pfHCJbNhXIm2r/DHRXG4z7vOaLDab29P3gn6o9KHsx9F7dyE0U47u0Qaw
	 M+qaOskcoGWuYp3cQ0WqSr8NnK/zq1Nm2+FuTwf6DVdabsubrnjox0FmvQ4fSKjFbI
	 u5495eUJ5ufQWHO1PxS1D2VXeyN4XuZb/+m2n+xCcqXt4CNbWakfkP5w7DJ4kgkINz
	 1WDTsX1I+VnXcFaUIEigkcxekCRQBuEfj5LIEwMAaaFy8tlUiNAarWrpy37ntw4sEc
	 nn5dNaJVzjctqkv8IFCh7DDZHZgc6Xsiw2uQpCpN4EkD3gB1KG71OrAuVOM5MxcXMx
	 8kQZQmWKauJNA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac27ea62032so63499066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 06:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526975; x=1742131775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqFbLsvDYgZMcATbnfiiqW+yfZu2sdh4iXGZzYCmKWw=;
        b=rGjEOIRD6BGDRVztWkPX1h+qUWhuYltKq5Sl3kU4/AU498tM1YlKXhFfTYqGrxAhPr
         HE/ELE0dwzjs2GdITpc+afkEml7mKVVaFOoXBKybYgMIsPFt0fy2GVU3RtxRK/nAAdXQ
         tD+VFr/9+HGuU2QSLj4DyRThZFRWMtdUXyk+YCTYuR1Ik36R1WUrtbhaZaNHhpycA0V1
         I8Iy0iWjpb2FrMYRC7jwYu/r4bIIfC6JK5oQVYV3qEL6K7GvPBE+lQuO6pJZFuWe4xHs
         /+ASH0JnvqQuj7Iie+BMCa0Ba1AsY4w+SBK4Eq0qmHxJ8BgfeI9dS6wr2A93nO8G2JaA
         kbfg==
X-Forwarded-Encrypted: i=1; AJvYcCW12DeCrR5jbpSJdx3UmBkhI6/NTAolDrJfUc1H4Y/BXhTjhMeikWRt6/M+/tEkzys+QoykebQJf+RCzXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3Px+8Zh2GKQ0jejzNok2eBug52mTKnUtObY5hkB1Qi+A9MqG
	aLBpUhv3HqzDk/BUn9Ud5Zznzv0RU92Roypg7ipF1VKQ5Riu4U9bLsgUZlNuLsIXqRb+i4rT3AK
	+fE8Ac7DhF8cI9x4EH1pGzbPEwHlrnu1ephBX9wVBeQ9I8X3gATowqEq2UuZsZImcWIt9qzWnC+
	Hhag==
X-Gm-Gg: ASbGnct4hRchXDOxKYQpYvOmJtIvKTur3RH06vBA1O0Bp3xa/hMchuwPqIs3zHje/pM
	SfPkexQpgYfoGtjJb+8/lldVzJkZibXz0hw/aFpM5N9pC6gyHpLZbBj5EE7goUfGGBoEAVJm2rz
	b/6Kfr2WxsMVPBMX6TFeyZlTsFTGeNtXzVktMwPatEp0vcr+tGGp9bc5JsioKzDRbe1xETarC4o
	Qjhrp1kZSabp2ZtB/kcH+Pso6XerBdQOzjQERQBdw50V7DV22Na3CBLUg2N90WexTJYCmcYXCH7
	uGPDPVAn9+h016q84Mmegqhu4hXYnj8EgzF/2ZHj47dpKQmFD37PMB+XZevC+ZMkqxh6mw7exgo
	QUvrbK2l8fVKGEyONWQ==
X-Received: by 2002:a17:906:c514:b0:abf:4e8b:73e with SMTP id a640c23a62f3a-ac252e9cd5bmr962216066b.39.1741526974743;
        Sun, 09 Mar 2025 06:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWUIep2IRy9s5FbXJl+MjjuqqYaufw0PZ6Ppq51ixYq/v5+9VpIwIXq+cg1UIFg1fYCs++7g==
X-Received: by 2002:a17:906:c514:b0:abf:4e8b:73e with SMTP id a640c23a62f3a-ac252e9cd5bmr962212766b.39.1741526974364;
        Sun, 09 Mar 2025 06:29:34 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:33 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 0/4] Add getsockopt(SO_PEERCGROUPID) and fdinfo API to retreive socket's peer cgroup id
Date: Sun,  9 Mar 2025 14:28:11 +0100
Message-ID: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

1. Add socket cgroup id and socket's peer cgroup id in socket's fdinfo
2. Add SO_PEERCGROUPID which allows to retrieve socket's peer cgroup id
3. Add SO_PEERCGROUPID kselftest

Generally speaking, this API allows race-free resolution of socket's peer cgroup id.
Currently, to do that SCM_CREDENTIALS/SCM_PIDFD -> pid -> /proc/<pid>/cgroup sequence
is used which is racy.

As we don't add any new state to the socket itself there is no potential locking issues
or performance problems. We use already existing sk->sk_cgrp_data.

We already have analogical interfaces to retrieve this
information:
- inet_diag: INET_DIAG_CGROUP_ID
- eBPF: bpf_sk_cgroup_id

Having getsockopt() interface makes sense for many applications, because using eBPF is
not always an option, while inet_diag has obvious complexety and performance drawbacks
if we only want to get this specific info for one specific socket.

Idea comes from UAPI kernel group:
https://uapi-group.org/kernel-features/

Huge thanks to Christian Brauner, Lennart Poettering and Luca Boccassi for proposing
and exchanging ideas about this.

Git tree:
https://github.com/mihalicyn/linux/tree/so_peercgroupid

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Shuah Khan <shuah@kernel.org>

Alexander Mikhalitsyn (4):
  net: unix: print cgroup_id and peer_cgroup_id in fdinfo
  net: core: add getsockopt SO_PEERCGROUPID
  tools/testing/selftests/cgroup/cgroup_util: add cg_get_id helper
  tools/testing/selftests/cgroup: add test for SO_PEERCGROUPID

 arch/alpha/include/uapi/asm/socket.h          |   2 +
 arch/mips/include/uapi/asm/socket.h           |   2 +
 arch/parisc/include/uapi/asm/socket.h         |   2 +
 arch/sparc/include/uapi/asm/socket.h          |   2 +
 include/uapi/asm-generic/socket.h             |   2 +
 net/core/sock.c                               |  17 +
 net/unix/af_unix.c                            |  84 +++++
 tools/include/uapi/asm-generic/socket.h       |   2 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  15 +
 tools/testing/selftests/cgroup/cgroup_util.h  |   2 +
 .../selftests/cgroup/test_so_peercgroupid.c   | 308 ++++++++++++++++++
 12 files changed, 440 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_so_peercgroupid.c

-- 
2.43.0


