Return-Path: <linux-kernel+bounces-188267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAC98CDFDF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8138283AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8268437707;
	Fri, 24 May 2024 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U/W/eTrJ"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B322F03
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521984; cv=none; b=IIA2H6/F1t4cSKAIr69rTNI4O+acfGNgUY81n3bcH8he683i/b2YNaiPCynYjfblZMYRMM9yDqyd1Eg9FHt9RCTot3bGvxO/QNvTIE8UN70PcVxMyi5df+nKLp3QMIgV1ox1ZaoJWhk1w76V5eH+1Vk98XdDY1D8D2uE2aizOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521984; c=relaxed/simple;
	bh=P8hmXNe9pVfxehRdEFph7gYxFMRHhtBZuM9VKZou2o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GkEd2prHRYQZ0ROn3K1RwRledpaSEMQmjo7njlI4keX/cNgztEnZV4TPQAS2gaf18pbk/0aZgegwOSHiLKJHedETbkYVhCBeHCHK70oLLgKMd+TOPwHtCx8RjDZxt7j62toXGgGoe2Cu6IMm9PX91jSkS651aT8vJ8SuL22+Fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U/W/eTrJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-657a07878easo2656839a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716521982; x=1717126782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZM+C443YkAbqJrVfa7/d/V0qYnAraDfxHHb3nzF0+w=;
        b=U/W/eTrJ7Ed6VUBIzN5zPDPOZz6RZvoLRrQHLJ03VSYFLfEHQx5dLddic6gvUSSoWY
         VjwDP9OfGDToWqcKtf4LBNKI+M/8amM/Jc93Boy/q6Wf0vSbmMtiU20bIlxVL+5f210F
         vxVlEnzN5YKJF+RNmPPoiRmYd7z7psp2e6Sag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521982; x=1717126782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZM+C443YkAbqJrVfa7/d/V0qYnAraDfxHHb3nzF0+w=;
        b=CdHr1Utqn4DH8fbE4vzGsU1h3+LyneB+0iHo+4uH4uclThgIuiRhbXhY9blW58jdzH
         otMNILSq3N75nvffdZNnNzOBRpp7ua/NDckIxXB1ZoIx20plNeCBGTekwoU9s6kb5xTh
         7MiSANzQEWw3sb0zVx9ITlChVzFajIglsj8CrlxO3Bck+3giiBFcFl7sUwbGsHAOqvhN
         drW8IOAJvhq9A53VNhDpAUPAqUzl21tAjzu0SUaZMsTXksepw5PQJ7EPLFAhkQbe9maS
         XKojPbA+zOfe0w+31k3qjz7mpWHovZ6eAtyrMkAx86hdUlOJtb6BPOgytp8EnfOhvU0N
         yXAw==
X-Forwarded-Encrypted: i=1; AJvYcCXvqqdFJs7x05V+F+PZpAVixvqZpjFjRFpaHw2pyctqqkCzzbG0re4DCiROkJ2caxrW1kaAXJcz0QdNTYeabNbJ4NHZmZWLqjfjoh1c
X-Gm-Message-State: AOJu0YwEOm1mROeEMfRUaQKFoLjEtfIkx46ZDH28NPDg+nsFEqTojwej
	efkVEkm71ukQMzI7zy10q8kMrKkHGDupF04+6Q4N3Zk/N+A6QYTaKKFJs3p7ag==
X-Google-Smtp-Source: AGHT+IERupiu47qJljsmVu1JdjLbKzVfc9DMWEHXDw9WaIvbcwYeeqWAwGzBdeP97EVsJttoCi5QSg==
X-Received: by 2002:a17:90a:d18b:b0:2bd:92b3:a18c with SMTP id 98e67ed59e1d1-2bf5e84acc5mr1266399a91.3.1716521982456;
        Thu, 23 May 2024 20:39:42 -0700 (PDT)
Received: from localhost (197.59.83.34.bc.googleusercontent.com. [34.83.59.197])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2bf5f61272fsm405503a91.27.2024.05.23.20.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 20:39:42 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@google.com
Cc: jeffxu@chromium.org,
	akpm@linux-foundation.org,
	cyphar@cyphar.com,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v2 0/2] memfd: fix MFD_NOEXEC_SEAL to be non-sealable
Date: Fri, 24 May 2024 03:39:29 +0000
Message-ID: <20240524033933.135049-1-jeffxu@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

By default, memfd_create() creates a non-sealable MFD, unless the
MFD_ALLOW_SEALING flag is set.

When the MFD_NOEXEC_SEAL flag is initially introduced, the MFD created
with that flag is sealable, even though MFD_ALLOW_SEALING is not set.
This patch changes MFD_NOEXEC_SEAL to be non-sealable by default,
unless MFD_ALLOW_SEALING is explicitly set.

This is a non-backward compatible change. However, as MFD_NOEXEC_SEAL
is new, we expect not many applications will rely on the nature of
MFD_NOEXEC_SEAL being sealable. In most cases, the application already
sets MFD_ALLOW_SEALING if they need a sealable MFD.

Additionally, this enhances the useability of  pid namespace sysctl
vm.memfd_noexec. When vm.memfd_noexec equals 1 or 2, the kernel will
add MFD_NOEXEC_SEAL if mfd_create does not specify MFD_EXEC or
MFD_NOEXEC_SEAL, and the addition of MFD_NOEXEC_SEAL enables the MFD
to be sealable. This means, any application that does not desire this
behavior will be unable to utilize vm.memfd_noexec = 1 or 2 to
migrate/enforce non-executable MFD. This adjustment ensures that
applications can anticipate that the sealable characteristic will
remain unmodified by vm.memfd_noexec.

This patch was initially developed by Barnabás Pőcze, and Barnabás
used Debian Code Search and GitHub to try to find potential breakages
and could only find a single one. Dbus-broker's memfd_create() wrapper
is aware of this implicit `MFD_ALLOW_SEALING` behavior, and tries to
work around it [1]. This workaround will break. Luckily, this only
affects the test suite, it does not affect
the normal operations of dbus-broker. There is a PR with a fix[2]. In
addition, David Rheinsberg also raised similar fix in [3]

[1]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46f267d4a8784cb/src/util/misc.c#L114
[2]: https://github.com/bus1/dbus-broker/pull/366
[3]: https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.eu/


History
======
V2:
  update commit message.
  add testcase for vm.memfd_noexec
  add documentation.

V1:
https://lore.kernel.org/lkml/20240513191544.94754-1-pobrn@protonmail.com/


Jeff Xu (2):
  memfd: fix MFD_NOEXEC_SEAL to be non-sealable by default
  memfd:add MEMFD_NOEXEC_SEAL documentation

 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/mfd_noexec.rst | 90 ++++++++++++++++++++++
 mm/memfd.c                                 |  9 +--
 tools/testing/selftests/memfd/memfd_test.c | 26 ++++++-
 4 files changed, 120 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/userspace-api/mfd_noexec.rst

-- 
2.45.1.288.g0e0cd299f1-goog


