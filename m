Return-Path: <linux-kernel+bounces-402785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC629C2C25
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C281F21D2C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0CC155A43;
	Sat,  9 Nov 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fXowEyyw"
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5064A154C03
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731151515; cv=none; b=m84WNobhrbWy8LNL1RMfkxmQ6Ch8alyuFg5c/eMWvu+TMbj9/lB5vm2EV1DsLmaLKZ2KYbcuIejBxTDmMHVxHkUg9Akuqf/B5HkeZyfiKZd2VyBYkrWRgB8jPEfKP0MheZAKnfMwfnuOpPvFlrW/e2e3fgBIBOtr9aq10NyKiRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731151515; c=relaxed/simple;
	bh=B3C1QePv8fC71z0Q10ApzjWz/s5Z40930CTXEhqZ4rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BHQCY+hRe4virsBtq4ZEub+yFcJsCCa8G4FsV+LzhoP9Iu1J7mnECIqgifLoRXOK/LrDh3CWP8QdYX0e8iVdYBEJK+TRw8aSZEsA+OjBhbkfBWrhl0fB8TyUguLRIvNHRzHk6Jn6EPB8KIW/5zv0fp0KHImJQZlvJbwwKDpI7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=fXowEyyw; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XltNd2r3Bz73X;
	Sat,  9 Nov 2024 12:09:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731150545;
	bh=1K5VAMOUt+cFZmiu/YQwXOJJdvhzdZS4If1pmDVNtow=;
	h=From:To:Cc:Subject:Date:From;
	b=fXowEyywx/SzmSczM6SyTdiqfaOckybLooMW1enpY3oz0iem8ZDt8KZItdQNYsFmo
	 /cv2rjX05V/2mvCS+/y4q2odPZqt7DksGTXnhrh/scIKpldzRC7iQDLz22ofWGOmtz
	 cUBK+qlj2uLQsz5qpFME6EiNRNvP5NfrQC0e3mtg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XltNc5tWnzjhC;
	Sat,  9 Nov 2024 12:09:04 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 0/3] Refactor Landlock access mask management
Date: Sat,  9 Nov 2024 12:08:53 +0100
Message-ID: <20241109110856.222842-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

To simplify code for new access types [1], add 2 new helpers:
- landlock_union_access_masks()
- landlock_get_applicable_domain()

This fourth version mainly rename these helpers.

The last patch uses these helpers to optimize Landlock scope management
like with filesystem and network access checks.

[1] https://lore.kernel.org/r/3433b163-2371-e679-cc8a-e540a0218bca@huawei-partners.com

Previous version:
v3: https://lore.kernel.org/r/20241022151144.872797-2-mic@digikod.net
v2: https://lore.kernel.org/r/20241014124835.1152246-1-mic@digikod.net
v1: https://lore.kernel.org/r/20241001141234.397649-1-mic@digikod.net

Regards,

Mickaël Salaün (3):
  landlock: Refactor filesystem access mask management
  landlock: Refactor network access mask management
  landlock: Optimize scope enforcement

 security/landlock/fs.c       | 31 ++++-----------
 security/landlock/net.c      | 28 +++-----------
 security/landlock/ruleset.h  | 73 ++++++++++++++++++++++++++++++++----
 security/landlock/syscalls.c |  2 +-
 security/landlock/task.c     | 18 +++++++--
 5 files changed, 95 insertions(+), 57 deletions(-)


base-commit: dad2f20715163e80aab284fb092efc8c18bf97c7
-- 
2.47.0


