Return-Path: <linux-kernel+bounces-273141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 035B09464EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3D8B21EEC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78726A325;
	Fri,  2 Aug 2024 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W07csFea"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF611ABEDC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633536; cv=none; b=gPV4GHFZmmqL4M4tBjzc4d5dtaOqp+/QnKv+dhi7PEf+bpvWhCCTtnwubHvbq58YuTtBqch4S3fFhVrs6IJNg8POn1mTeJ+trIiiJ49UKT2/PVmYX5zNyZE7HQsnQWXi4PjIFuPI/+hlqzeQieWmzquHIC3LUhuEazvkiDJ7TWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633536; c=relaxed/simple;
	bh=v3HZnKcZrPXLVKe4/bZ+Sg9EL/Zo5bHXDirYgTmAXJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKvXT28S7FUF72bI6zQW6JCsvrQ2m5iSybR1swA+xSv3SsOpwoq1UiKrFgoe7a1dixcdzwZxzFaHQAQLjSWEJpCrPG7EiOKwC1TTb7DOkZhZ019tnc7nsedxZyYMRqdH/FxBfkPZAOz6A4v3uwxkKhctaHWEa3uEwyzqOqVfKvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W07csFea; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d150e8153so2512900b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722633534; x=1723238334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8hn2btrRWR5QcXtzCR0MH3KvcjgIAfIrdUdoWIlFqFA=;
        b=W07csFeaSNb3l6AMgUdbHL4IPxAKMP8He606u5BnToA0wgN8gZEVhU2EAFkU9EJmEE
         /ElZjVqpjPIVE9nhMfFuFXTXaDyXo6gdcDPRAMfBWcKQamQ90ZtTtligx7bYN7hKxVnH
         2VT6F2pRRZjZxc9Iqd1DbNhf8BW9IxXjwcHqagkOUucjK87UP+nI+WKiMaCSc3wuCI2U
         5Shr1xn9ZFCJdJI1vLtsn1XpZdiCI09A8vyCjk5sBR6D0hg4kE+JSBVIVnP+eHZMydAP
         XJ74hLaw/54irKUybUewHVb0gFcNM6FpnBPP4YcnODowiEjrcNDdveD283JY6OlA47xg
         u83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633534; x=1723238334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hn2btrRWR5QcXtzCR0MH3KvcjgIAfIrdUdoWIlFqFA=;
        b=jetfGHnSp7zNze2nOe5dGwwmTN9u1GZmQjw0WAkNtg6+b8VUQAT3ADreSGhMi00po2
         ex9T8+efOZGXbh4Mu94yyEluf51sTVBaAGm7nSyHD3gbrFVvjJxecXugTg7RqAhMorPv
         np2kdcmcy43eI5SR1gm6Z2MWPMZMP2I9HO2CoCjjnS3ncrTQiZxzuqITVd6AbzR25eka
         PMlO6SY/VScm7YErtPuUscyIlkXrpTRaZSAazj/vHffqoc3rUg4QItivxXxUYiFVzjRj
         NiZrst3EzGeo3FdsV4o4MigQEjtJQ5cyGfOvvJKB+G3idadLwx4JJSSa5n0X4w1jRlJe
         VvRQ==
X-Gm-Message-State: AOJu0Yy1huhg1TQD3CW1OhcO3DFKUmopPC/QBA95Ir+aRX0H3luV7BUt
	OQyI9BICHli+tBTvUxFagQRM1jqFJh5hHZCwAeUUdP4NZBDZB8b+
X-Google-Smtp-Source: AGHT+IH87jGnUX7dR6KnQs8DHmfjq7dK0AHy0lSZrBHi394uk7eFnRhrNmCaf5K9uEWCrXe8yNdrxg==
X-Received: by 2002:a05:6a00:91d9:b0:705:d6ad:2495 with SMTP id d2e1a72fcca58-71065f1e22emr10250027b3a.12.1722633533841;
        Fri, 02 Aug 2024 14:18:53 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec54457sm1756226b3a.86.2024.08.02.14.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:18:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCHSET wq/for-6.12] workqueue: Use wq_online_cpumask consistently and make CPU hotplug unbound pwq updates asynchronous
Date: Fri,  2 Aug 2024 11:18:16 -1000
Message-ID: <20240802211850.1211737-1-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Make wq_online_cpumask more consistently which also simplifies the code, and
make unbound pwq updates from CPU hotplug path asynchronous so that we don't
add additional dependency on fork from CPU hotplug.

 0001-workqueue-Make-wq_affn_dfl_set-use-wq_online_cpumask.patch
 0002-workqueue-Make-wq_update_node_max_active-use-wq_onli.patch
 0003-workqueue-s-unbound_wq_update_pwq-update_unbound_pwq.patch
 0004-workqueue-Make-unbound-pwq-updates-from-CPU-hotplug-.patch

The patches are also available in

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git use-wq_online_cpumask

diffstat follows. Thanks.

 kernel/workqueue.c |  121 ++++++++++++++++++++++++++++++++++-----------------------------------------
 1 file changed, 56 insertions(+), 65 deletions(-)

--
tejun

