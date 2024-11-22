Return-Path: <linux-kernel+bounces-418276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B617B9D5FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC6D282455
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509A1DEFC8;
	Fri, 22 Nov 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="q8lzryr7"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA252309BF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732281930; cv=none; b=VXRC/DdI4V3sCF0OwWsd+XIJn5WQJRyIZZle8urt6O4WlnmCQkGcxZ3ESilzesSM29DWzg0JCPeLNfxAz7hplRYkMEIk1LF5A1z+Lu3mvVKm8B7c++DVS41PMn55spkBX8X0fQd/l92G+msdx4w5QfjQ5+yFpbA8ZBuqmgBc88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732281930; c=relaxed/simple;
	bh=K7qZLWjU+AMChnoUN1XQwmuBPqWYxPfH9hUuKgz+dHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZO3j9Ts2NWZOPoeoLToUpQqGL9ePK1cOqlSqt/pXpPRb5Ec7QyMrpbV3wj7fme4cTcDnEs0QMqwooJQWxUPaWdTaOkbXh/Re+eBh/JzpCYmEk337fbb7NpxP5a6b8bZjqK/+86exm7ZCfCbC5+UIHs5kp+njE9sJIA0vct5IgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=q8lzryr7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 954823FAE7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732281918;
	bh=GYsPYX3ofWydqhQzohB0yDKxCKqQlwNy/PrpBCrMoY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=q8lzryr7X0T5tcgOnVYhTP8N70q+uYExXofCGFBM+cQqXY/JiPCt5BEdakamIErFW
	 F4hCldgYvvG5HeiMRkGbsbgFADY4ytqKueSvKtoDSW1Oz6KXC7R/p0jfizF/HF9O9r
	 dz78EOW1yhr8CRWfRW/2/OHDTPuUUWsgG46swrc4gg02LTVweuSzEFa89gJ2N2w+Zq
	 21T16pSOEVniJH+zutNlyQ9Y54beA3umN+elRCYrO82r5mlNCbRNP+2KsE62OPSoFm
	 yfK142+YzG9a4xrJu0ZNSRo3SA6Xz89M5VGEm2A2VSY/DZRQNqYiHXQhdmjVznzVQz
	 EpkhWO2DxClbg==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5cfdcbd3a03so1543830a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732281918; x=1732886718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYsPYX3ofWydqhQzohB0yDKxCKqQlwNy/PrpBCrMoY8=;
        b=J3TaEgCCOVk/xQjG/bIEitfB6WWQTNfnqrJWnwr1ionjr6Vreryw6aw2eICbtuqccK
         Gw8TpL8ZdNRu1LcL6DsKFY5+QaUP0hhUQLBAA2S26toTvjDrErnTmRzFptc/kU3mNKBc
         8gCeG04EAGLTRubP+GSUKXu8D9G+9D6oejaODP0yUsZS5v/QslqIHhIXA15mEab9QYwe
         kFBRD19vtwKtzCMoTpO1SxZi1GZCoXPAPd9OqKHcX94M2vqE9IMwMSjpSam6NPv9dDSN
         fbxYzpcIWvOcwnPt+OUup8eef5a1G96JXD318lAMAzYoQYN/JoMFW6keUm8vyY5G6w7E
         8kGA==
X-Forwarded-Encrypted: i=1; AJvYcCWcQxokFPWalGYUHIiYq9UPf9BTQ2EGkemHqb2VzmVAfzdJ/AOg9UOxSu21AUFQRXo/w0NdKVDV5ZbRglg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBqSLeva4NvW+9XCVTuhU30imIJer/LFL4vlnzMpS9dcL1jwU3
	oX8/yfIjYMcIXMoF9tCYf84ref5zvFLB5Kartt9fAYo40rwko3kXQF7kR01X/rpWOrvk1jFtx8F
	BpQYaiVt20/JH510Djfm8J08dGfsjt2SMdwRhdizGCdlwO0OEEA9UXI3vJzvJxCrZnP0Mg1Ekvh
	hwbw==
X-Gm-Gg: ASbGncvx+0US7QaJxvXSgMyi0ORCAJ/0q0o00lC9LSUaEKce7pJdWnjx9qTBvtwKCBb
	RampLxif0fUQR+yN/cLwZLzSmIeo2g/QinUgBJUEQyLihKvJVbWYbPFcH+RI6vstkxH+1T10x8T
	ItYkuL3MY+tlgN3mKwHoS6oKCq2KgdyaiYj0zuSh4xvCNarjn2WSjryZj5xjgcsh8e4tRrj5lci
	yxQo2j9d/GjbHmWW/AjCc8uakcwp84NYETxqV0mCo/5ucrtdPXDdzZeBQwnctfyLaAIxUFaj3N5
	BQ==
X-Received: by 2002:a05:6402:51cc:b0:5cf:ce41:9c79 with SMTP id 4fb4d7f45d1cf-5d0205c0d28mr2320548a12.4.1732281917860;
        Fri, 22 Nov 2024 05:25:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgyo6tX/0y499nk9RtF/ODzbByzMuJ82emcZJtxpSKXlrS4CD2CIR/CFp3GNJ7pEr7ioGpKA==
X-Received: by 2002:a05:6402:51cc:b0:5cf:ce41:9c79 with SMTP id 4fb4d7f45d1cf-5d0205c0d28mr2320528a12.4.1732281917470;
        Fri, 22 Nov 2024 05:25:17 -0800 (PST)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d02939a593sm403453a12.88.2024.11.22.05.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:25:16 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: brauner@kernel.org
Cc: stgraber@stgraber.org,
	tycho@tycho.pizza,
	cyphar@cyphar.com,
	yun.zhou@windriver.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v2 0/2] pid_namespace: namespacify sysctl kernel.pid_max
Date: Fri, 22 Nov 2024 14:24:57 +0100
Message-ID: <20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear friends,

this is just a rebase/small rework of original Christian Brauner's series
from:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=pid_max_namespacing

Christian kindly allowed me to take these patches and resend after small modifications.

Current tree:
https://github.com/mihalicyn/linux/commits/pid_max_namespacing

Changelog for version 2:
- rebased from 6.7 to 6.12

Changelog (from original Christian's patches):
 - rebased from 5.14-rc1
 - a few fixes (missing ns_free_inum on error path, missing initialization, etc)
 - permission check changes in pid_table_root_permissions
 - unsigned int pid_max -> int pid_max (keep pid_max type as it was)
 - add READ_ONCE in alloc_pid() as suggested by Christian
[ it is here https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com/#t ]

Original description from Christian:

The pid_max sysctl is a global value. For a long time the default value
has been 65535 and during the pidfd dicussions Linus proposed to bump
pid_max by default (cf. [1]). Based on this discussion systemd started
bumping pid_max to 2^22. So all new systems now run with a very high
pid_max limit with some distros having also backported that change.
The decision to bump pid_max is obviously correct. It just doesn't make
a lot of sense nowadays to enforce such a low pid number. There's
sufficient tooling to make selecting specific processes without typing
really large pid numbers available.

In any case, there are workloads that have expections about how large
pid numbers they accept. Either for historical reasons or architectural
reasons. One concreate example is the 32-bit version of Android's bionic
libc which requires pid numbers less than 65536. There are workloads
where it is run in a 32-bit container on a 64-bit kernel. If the host
has a pid_max value greater than 65535 the libc will abort thread
creation because of size assumptions of pthread_mutex_t.

That's a fairly specific use-case however, in general specific workloads
that are moved into containers running on a host with a new kernel and a
new systemd can run into issues with large pid_max values. Obviously
making assumptions about the size of the allocated pid is suboptimal but
we have userspace that does it.

Of course, giving containers the ability to restrict the number of
processes in their respective pid namespace indepent of the global limit
through pid_max is something desirable in itself and comes in handy in
general.

Independent of motivating use-cases the existence of pid namespaces
makes this also a good semantical extension and there have been prior
proposals pushing in a similar direction.
The trick here is to minimize the risk of regressions which I think is
doable. The fact that pid namespaces are hierarchical will help us here.

What we mostly care about is that when the host sets a low pid_max
limit, say (crazy number) 100 that no descendant pid namespace can
allocate a higher pid number in its namespace. Since pid allocation is
hierarchial this can be ensured by checking each pid allocation against
the pid namespace's pid_max limit. This means if the allocation in the
descendant pid namespace succeeds, the ancestor pid namespace can reject
it. If the ancestor pid namespace has a higher limit than the descendant
pid namespace the descendant pid namespace will reject the pid
allocation. The ancestor pid namespace will obviously not care about
this.
All in all this means pid_max continues to enforce a system wide limit
on the number of processes but allows pid namespaces sufficient leeway
in handling workloads with assumptions about pid values and allows
containers to restrict the number of processes in a pid namespace
through the pid_max interface.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Christian Brauner (2):
  pid: allow pid_max to be set per pid namespace
  tests/pid_namespace: add pid_max tests

 include/linux/pid.h                           |   3 -
 include/linux/pid_namespace.h                 |  10 +-
 kernel/pid.c                                  | 125 +++++-
 kernel/pid_namespace.c                        |  43 ++-
 kernel/sysctl.c                               |   9 -
 kernel/trace/pid_list.c                       |   2 +-
 kernel/trace/trace.h                          |   2 -
 kernel/trace/trace_sched_switch.c             |   2 +-
 .../selftests/pid_namespace/.gitignore        |   1 +
 .../testing/selftests/pid_namespace/Makefile  |   2 +-
 .../testing/selftests/pid_namespace/pid_max.c | 358 ++++++++++++++++++
 11 files changed, 521 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/pid_namespace/pid_max.c

-- 
2.43.0


