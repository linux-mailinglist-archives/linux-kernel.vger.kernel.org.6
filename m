Return-Path: <linux-kernel+bounces-552068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02587A574F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCE03B56E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFED3206F1B;
	Fri,  7 Mar 2025 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkEdM4Uj"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77A41F94C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386697; cv=none; b=KuBuw6VPNJcvJ5NXCqHXjug9VJBsSIOUlH7Blpll2jJC3YWA46VPpYzCiUGqpwzfLH7E2F6KP6SB4Hl8ggxxLZtdjM7lQWuKs5UUXbUDRh0qtqvyThgjYWfpPZOU7aBamRGj5y4tXBlCE4e/vo0WnIWM4n5x5pP2TcAda0PgBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386697; c=relaxed/simple;
	bh=rNJ9nZlJ+oBImadkrPL6xsFIFNfUe2GHUs774Gk1R5E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CQ9Gl4XCXnB7UafBHMEaXy7rPKZgJtSKpbDJLxuIouLmimWEZ1bHmkp2NUolQAiuwpcy2NMCwo/o3k18U7Pqh27lyLzGIipCuL2vWeMi3AAZaCd5OADGMl5vOgrkx9s8WSk1FhXUMbZIlv7xlD58bPNvbu28FnF1tefgrAI4F50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkEdM4Uj; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-60018b29f51so1472870eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 14:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741386695; x=1741991495; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tfwi5cmYZugDAUbt7FLDSmFz1JdoO1VkIU3HxB488p8=;
        b=RkEdM4UjOb7uqVcCxCLshFGWf6Tw/axCpHMKnYn5zMKBgOZbyAomIp2AwRHg7rxFst
         rtSnWpz2/NbC2KtEx8E9uAF4VobFJ7kHvkvye5CllltG7Gv7SuvgaBTkqy1iAJcgacns
         fuWixsh9SsfJ5tg2rvv+pOyka8OZwsvK3fLaPMcx/XfO1kNEihcZdOG9jQNzW84swyfY
         W/hWHlfYPSolYo1fa66T2chMkaMi7EQySuF5HyfwBaiV4bJTEh4Xx7GPwLFqya7zNVeZ
         qrXIE/r5ZwQePt42BrR8RX803xzlfVP1iyF4I6exn6KsOH0WCng+qwi4dj0k6tzKVrRt
         05kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741386695; x=1741991495;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tfwi5cmYZugDAUbt7FLDSmFz1JdoO1VkIU3HxB488p8=;
        b=f/KB6sRpTdZdiqHE/vblXlXxi0JsV7+pKGSDkwhvC/lolu0spB/J6sSXpiDKtaA6hQ
         0idOzHQShpnrzWqf07sshiLHBJ8cCG7SlKT5Raspuq/QVpcTecySsUoCAJyYStjSvllc
         Vgv5JZ6fYXHWBJCpn5NfnUOZv8GyPcDshm1b+JVRgUSmDNgx8NnfzmZXU4J2K9vBUvqi
         isfEaSJJv7aQ7uSiQSaGMu/rfdkouror/bRHNUgGPiSr4RuZ6JmXLgnHor2C1PtzaAnc
         j6JIkZwate9PHULhCVyxaK+rfMCXsVVz2Efq4DqvE9F9wHnXstF6FRUdKC8D6wYHmY0U
         zPXA==
X-Gm-Message-State: AOJu0YxtXs26M0g5PKcYlJPEoBNG2W3XmuPVNDtXPof0kXVZM02McyQD
	UqHOMFtn2DOaadEnRIZhP+iwfKDxAz+AdC2KeIczFR9jyyxXbqz+3KeWVQ7I5dthCjHC2qteAzu
	2I9F82jB18igfE7cZlYw4einJIkDqlNcFKf93yrN9vP2NzhNdJjY6ACo=
X-Gm-Gg: ASbGncsca2zbjaFOp0avFgnS7lV9xNNC5SQzhYAlRHFd5/tdLbMi28AIpf7/XoL6cNk
	V45FSwOOtqQlDoOuMyY2vbvHKSIHeOg2lTGTxvLmOWe5aXqIV4VPW+1l05TH0cZDLdkGvhrgCYk
	KTEmdJ1n9ty4McgBfZTkLxQBQ=
X-Google-Smtp-Source: AGHT+IHwm2CWZoU3ndQNXuMkc9t527wygvUVuMC+4iTLmvuipXDDb8zMhyI4UFxTAlD7OdHQF72VPJvHfR6DjONiJ3Q=
X-Received: by 2002:a05:6870:89a9:b0:297:683:8b5b with SMTP id
 586e51a60fabf-2c281fcb13dmr697251fac.10.1741386694627; Fri, 07 Mar 2025
 14:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: enh <enh@google.com>
Date: Fri, 7 Mar 2025 17:31:23 -0500
X-Gm-Features: AQ5f1Jr5EzBuqeM8LqRrqDm_nBE_xSa-__P7DpEMAfYiZvBF8lUn2LbtpM9E6_U
Message-ID: <CAJgzZoqz2Ev0WEDYR_etKKf7q61Jfw8SiMJ_1DFxNaEHM=DPhA@mail.gmail.com>
Subject: PID_MAX_LIMIT
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

i was clarifying the clock_getcpuclockid() and pthread_getcpuclockid()
code in Android's libc because the bit-twiddling always confuses
people (and the kernel header macros aren't in uapi), and noticed that
neither the libc nor the kernel side of the code checks that (pid <<
3) fits in the clockid_t.

it looks like we're fine because the limit is 4 million thanks to the
code below, but the warning in the comment about the FUTEX_TID_MASK
should probably also warn about this even-lower CPUCLOCK_PID()-induced
limit? (which is one bit less than 32-3 bits unless a cast to unsigned
gets added so we don't accidentally sign-extend the highest pids to
negative values when extracting them from clockid_t values...)

/*
 * This controls the default maximum pid allocated to a process
 */
#define PID_MAX_DEFAULT (IS_ENABLED(CONFIG_BASE_SMALL) ? 0x1000 : 0x8000)

/*
 * A maximum of 4 million PIDs should be enough for a while.
 * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
 */
#define PID_MAX_LIMIT (IS_ENABLED(CONFIG_BASE_SMALL) ? PAGE_SIZE * 8 : \
    (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))

i can send a patch if you'd like but (a) i assume gmail will mangle it
and (b) one-line comments seem like the kind of thing the file's
maintainers would have strong opinions on anyway.

