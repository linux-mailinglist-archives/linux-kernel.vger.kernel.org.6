Return-Path: <linux-kernel+bounces-306955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5149645FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A401F2910F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371251A76B7;
	Thu, 29 Aug 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LQ+lpXsA"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8694115CD62
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937177; cv=none; b=DqE6PIK+Zx+dDhSGZ9SbI499jXRdadHGqy57Udr61evyDJCx4DlBdF3fKI6IAFu81rrlpSgVMDJxcn2Lb9er8FQzTZ7/Uzb1shYdRow88s3nT7Qwfcp7Iokw5pN3AcqWRHSVSbT4T5rncxXpQB3xFRRGbBgulxkM1vNwImnDOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937177; c=relaxed/simple;
	bh=W/1LfhbjRimnJDGS596SlMFLHo5vuTBlZ/w3hRkrd8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M0d56GCS72GvvOfthd6FZZtE1NMwfr5gR/gfs9CD/XNO1ZRLmd3wLnQNEPic6pQirvRp8DWNUrEkvOIcXd9cuEy3aXUt2xDcilwvqkiQJ04mLbosP/AkSRigCvusFgpfiFn5EO8ymWf/JQ0IQXuGBax9PqmZ9uRtBhT8hGL+Wbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LQ+lpXsA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20227ba378eso5439165ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724937175; x=1725541975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7eTS3eeXVwPrTwK+lb5D5mdVs6X406fMnAORyEKIvww=;
        b=LQ+lpXsAZuwOMUpnLjFG5zTuZhMg0FaP2wVc23dq+wWaIl6bpdhhMxRTjwlfFChpeV
         38CLvA9/1YlpwIIi80nyg+Xh6ybwRqmGrjkCb4dF9oE5xOTxoHkNLI7bjumdF3ocvFvF
         aictCx0CAyKStM2wiBAFckgkU4S6Q+Uj0NtRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937175; x=1725541975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eTS3eeXVwPrTwK+lb5D5mdVs6X406fMnAORyEKIvww=;
        b=jJmouJo9b+9FasAtp2K27LQ9QE+t1AONXJDdOoq8AjR3rN5vTRwt86EpUkAP2NOtft
         NdNg0Ymja8RM+CF7VD1u5hYOWTNOLYeDJjSeVAHJrIN6lFn3VeqmXDBd5KQNcBJj22hs
         CM0gB9T2i9s5/cckw6N8g99NeQhN6T3AtAVNZ5nW20jwT7Esp1tQqFh6gdjVXqhoiu4/
         vnFVAc6hJwIW3RWZtP3V8iRdnolpvrjhUrYd0TIRgLR9urJFOW38NFPZo1BRqi/Ro86L
         4fTBnXZi14tfeqVfPzOjmMJvZEO3ym2F5TTuTIWn99bOESYOqxIB+RT5qpakHHLnIKvm
         fzgw==
X-Forwarded-Encrypted: i=1; AJvYcCV04RzrwunoYeMRse8MrN9WHieaUCNB0tP+ppt74U3PK3GtTIDpwDl/kpcu4fLD4DRHaaezSeA4M/TMd24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwEqDpsMv7YruZeUn9bU7fHcAB/KSNDh37DO27fZny0visMxP
	O12fKTnYZLSoRmKJQvhy/Kx57pxAC8RrdN3A0GBNyAosmEBglpEv6DwSHZlOL5g=
X-Google-Smtp-Source: AGHT+IFoVrhP/gP+tZAafbwHf2HaN+A4kRXFVXFaQ5XNWgswLFhlJX4c/7hFU7m4NevAj4phXmF6FQ==
X-Received: by 2002:a05:6a20:d707:b0:1c9:1608:ae97 with SMTP id adf61e73a8af0-1cce0efae07mr2259636637.0.1724937174502;
        Thu, 29 Aug 2024 06:12:54 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b13c9sm10991065ad.62.2024.08.29.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:12:54 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Daniel Jurgens <danielj@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-kernel@vger.kernel.org (open list),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next 0/5] Add support for per-NAPI config via netlink
Date: Thu, 29 Aug 2024 13:11:56 +0000
Message-Id: <20240829131214.169977-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This makes gro_flush_timeout and napi_defer_hard_irqs available per NAPI
instance, in addition to the existing sysfs parameter. The existing
sysfs parameters remain and care was taken to support them, but an
important edge case was introduced, described below.

The netdev netlink spec has been updated to export both parameters when
doing a napi-get operation and a new operation, napi-set, has been added
to set the parameters. The parameters can be set individually or
together. The idea is that user apps might want to update, for example,
gro_flush_timeout dynamically during busy poll, but maybe the app is
happy with the existing defer_hard_irqs value.

The intention is that if this is accepted, it will be expanded to
support the suspend parameter proposed in a recent series [1].

Important edge case introduced:

In order to keep the existing sysfs parameters working as intended and
also support per NAPI settings an important change was made:
  - Writing the sysfs parameters writes both to the net_device level
    field and to the per-NAPI fields for every NAPI associated with the
    net device. This was done as the intention of writing to sysfs seems
    to be that it takes effect globally, for all NAPIs.
  - Reading the sysfs parameter reads the net_device level field.
  - It is technically possible for a user to do the following:
    - Write a value to a sysfs param, which in turn sets all NAPIs to
      that value
    - Using the netlink API, write a new value to every NAPI on the
      system
    - Print the sysfs param

The printing of the param will reveal a value that is no longer in use
by any NAPI, but is used for any newly created NAPIs (e.g. if new queues
are created).

It's tempting to think that the implementation could be something as
simple as (psuedocode):

   if (!napi->gro_flush_timeout)
     return dev->gro_flush_timeout;

To avoid the complexity of writing values to every NAPI, but this
approach does not work if the user wants the gro_flush_timeout to be 0
for a specific NAPI while having it set to non-zero for the rest of the
system.

Here's a walk through of some common commands to illustrate how one
might use this:

First, output the current NAPI settings:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 914,
  'ifindex': 7,
  'irq': 529},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 913,
  'ifindex': 7,
  'irq': 528},
 [...]

Now, set the global sysfs parameters:

$ sudo bash -c 'echo 20000 >/sys/class/net/eth4/gro_flush_timeout'
$ sudo bash -c 'echo 100 >/sys/class/net/eth4/napi_defer_hard_irqs' 

Output current NAPI settings again:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 914,
  'ifindex': 7,
  'irq': 529},
 {'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 913,
  'ifindex': 7,
  'irq': 528},
 [...]

Now set NAPI ID 913 to specific values:

$ sudo ./tools/net/ynl/cli.py \
             --spec Documentation/netlink/specs/netdev.yaml \
             --do napi-set \
             --json='{"id": 913, "defer-hard-irqs": 111,
                      "gro-flush-timeout": 11111}'
None

Now output current NAPI settings again to ensure only 913 changed:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 914,
  'ifindex': 7,
  'irq': 529},
 {'defer-hard-irqs': 111,
  'gro-flush-timeout': 11111,
  'id': 913,
  'ifindex': 7,
  'irq': 528},
[...]

Now, increase gro-flush-timeout only:

$ sudo ./tools/net/ynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --do napi-set --json='{"id": 913, "gro-flush-timeout": 44444}'
None

Now output the current NAPI settings once more:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 914,
  'ifindex': 7,
  'irq': 529},
 {'defer-hard-irqs': 111,
  'gro-flush-timeout': 44444,
  'id': 913,
  'ifindex': 7,
  'irq': 528},
[...]

Now set NAPI ID 913 to have gro_flush_timeout of 0:

$ sudo ./tools/net/ynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --do napi-set --json='{"id": 913, "gro-flush-timeout": 0}'
None

Check that NAPI ID 913 has a value of 0:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 914,
  'ifindex': 7,
  'irq': 529},
 {'defer-hard-irqs': 111,
  'gro-flush-timeout': 0,
  'id': 913,
  'ifindex': 7,
  'irq': 528},
[...]

Last, but not least, let's try writing the sysfs parameters to ensure
all NAPIs are rewritten:

$ sudo bash -c 'echo 33333 >/sys/class/net/eth4/gro_flush_timeout'
$ sudo bash -c 'echo 222 >/sys/class/net/eth4/napi_defer_hard_irqs' 

Check that worked:

$ $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                           --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 222,
  'gro-flush-timeout': 33333,
  'id': 914,
  'ifindex': 7,
  'irq': 529},
 {'defer-hard-irqs': 222,
  'gro-flush-timeout': 33333,
  'id': 913,
  'ifindex': 7,
  'irq': 528},
[...]

Thanks,
Joe

[1]: https://lore.kernel.org/lkml/20240823173103.94978-1-jdamato@fastly.com/

Joe Damato (5):
  net: napi: Make napi_defer_hard_irqs per-NAPI
  netdev-genl: Dump napi_defer_hard_irqs
  net: napi: Make gro_flush_timeout per-NAPI
  netdev-genl: Dump gro_flush_timeout
  netdev-genl: Support setting per-NAPI config values

 Documentation/netlink/specs/netdev.yaml | 23 ++++++++++
 include/linux/netdevice.h               | 49 ++++++++++++++++++++
 include/uapi/linux/netdev.h             |  3 ++
 net/core/dev.c                          | 61 ++++++++++++++++++++++---
 net/core/net-sysfs.c                    |  7 ++-
 net/core/netdev-genl-gen.c              | 14 ++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  | 56 +++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h       |  3 ++
 9 files changed, 208 insertions(+), 9 deletions(-)

-- 
2.25.1


