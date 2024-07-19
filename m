Return-Path: <linux-kernel+bounces-257411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD1593798A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439091F2325F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E85145B29;
	Fri, 19 Jul 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="R1vGEDai"
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57514532F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401615; cv=none; b=CDOreygMcT6e8b5hOsNVFBcnSDLkPdlwLwu2FKwoWGX0Tqq8u00NZMHs4o++dnoNvcKtdCst5ej2g8fqFnnt13YT0XNGRfFvouSnpF/6XVI7tLUAwnFIwsbzIsVtlaRoHXZlcWGhj1M0F8TAacRSdT0+gCCIGu2igZLGxG0Msrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401615; c=relaxed/simple;
	bh=R8UECAoOpn6Z9VyU8XWdVP4VJVlOGQ/d9Y7jGVbdA50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+M/EZRssVykXuX8/0aC/IK7d4xYU2buWAXLLEcJy/PXP+qftxkuR8pAsVJw19K+gpGJN7/kBUNhXX1AMs7RCSEXm6B+i+6Unyn5UcAQkKkj/dlC+AzRC3YwhUGK3+P34VPhNa9Bkky/o8GS/7pU8/l33VAw+zRw3MPR4pfx7Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=R1vGEDai; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WQY102ql7zYG1;
	Fri, 19 Jul 2024 17:06:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721401604;
	bh=MlvNcRdaWPCv4piayBnreztb2E0SfctcFZFdov4MJHM=;
	h=From:To:Cc:Subject:Date:From;
	b=R1vGEDaiOLE+63hKxA8+FlULKos0AYSaDhRQj6FydQIyKTFheCvHucyRs4jdV/EtN
	 c93xAKYjB8auzzIyfshrfNrsyktxu4QKufpY2Fd77crcH/PRFi/vFCB17VQesgJULV
	 qTvJNn4IHrP8P4kILn5By5R9HM8lyxgPpJwHFeAU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WQY0z2nrYzxKb;
	Fri, 19 Jul 2024 17:06:43 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 0/3] Use socket's Landlock domain
Date: Fri, 19 Jul 2024 17:06:15 +0200
Message-ID: <20240719150618.197991-1-mic@digikod.net>
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

While the current approach works, I think we should change the way
Landlock restricts network actions.  Because this feature is relatively
new, we can still fix this inconsistency.  In a nutshell, let's follow a
more capability-based model.  Please let me know what you think.

Regards,

Mickaël Salaün (3):
  landlock: Use socket's domain instead of current's domain
  selftests/landlock: Add test for socket's domain
  landlock: Document network restrictions tied to sockets

 Documentation/userspace-api/landlock.rst    |  4 ++-
 security/landlock/net.c                     | 22 ++++++++--------
 tools/testing/selftests/landlock/net_test.c | 29 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 12 deletions(-)


base-commit: f4b89d8ce5a835afa51404977ee7e3889c2b9722
-- 
2.45.2


