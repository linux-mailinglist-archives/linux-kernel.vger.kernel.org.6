Return-Path: <linux-kernel+bounces-375094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8088E9A90D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A2DB20EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6FD1FBCBC;
	Mon, 21 Oct 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f5dDGPMj"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140201DFE22
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541773; cv=none; b=LWliViiVeswxhZ8HOHsUhTOZvzkTtVWePfDt0WcAbZdSrMVQOKulvU39aZZk5wGpDYepKtY7T7KDE0SWoQ02ujllp2rF/t1GgyZ76BnATg5tAFr2Xn6K66rNj1NU5iLsBGpEZ4dQTzKqBrRDz7v6oUBxuq4+Eluw974CeqbpMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541773; c=relaxed/simple;
	bh=YFwzr5dHaLpfBFmugZgbppOyLruS2DUUmkleAkWdFGs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0JILz/2DHDl3qC2Pd92wQMGUlUFYeY8kUt25pYzuZdRduf21CtPhkvj+ONxepYEgzKODvuj5vmpvcw8//ArUV4my1ZUG4UcOfYgD3YIkSPES2WnagQI8Z/ko26OESdfQAyO8jYqfIebsHiz+JkbqbyqCCoYYe3AQy8gImQU7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f5dDGPMj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so6315638a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729541768; x=1730146568; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFwzr5dHaLpfBFmugZgbppOyLruS2DUUmkleAkWdFGs=;
        b=f5dDGPMjPqSoTXkPFy3H57ZqHFDsZGJXZeeve2dCfL1Mr/8IVIbAUkEQQbWuZSQmyx
         oVAmwAoZoRVE8RXBs/zNpIocFpM6DI2hcTDTWzY9bzTo+l+XXrKnJBzz/Z+l8XHWImMA
         fWwNXGNeKA4HdKRFLFMUeCcmdJs9RZI8smA4YqfmWEL/MX/xHZq2zWPg+KRAf3PnzDhf
         WLIFv/pPYJYoukPMLVLeUnPC4oL3LQkFypDWr9g51lRbK8TTDzfmy+AyPQ7eceKGp5ey
         ARYUq/Djxq7LrhNedTDEkTjcw4ElgvdDfkRVBC4cWK0HhrVbFe/Ln6AZkpDE6DC2eTk/
         N8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541768; x=1730146568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YFwzr5dHaLpfBFmugZgbppOyLruS2DUUmkleAkWdFGs=;
        b=Nf5B5u7cyG45rOBXZkM4+Bg0EfO/mnLCU+MpT7Ez1ZNPDb6zH0+d3ne4uonlONfc54
         q6EhjQ/F27lfW3IY3XkVTfpRofbst93CIXx86q52lzunAidpzJrc80+p0xJuxiHovkrH
         3noojAmpXTmhSlI97bXo9hej8xtZCjzxaaP2CQhvbhArIbyVxUS8S7JZ0X9sbZ1uyclN
         c73Nc1DZvq48FQ3p6EtAFSlai8jcavTajmEOD/KyCcuFbN1/2a0PExSnagdNqhMJQXNu
         M1hYYrs2tsTA1AMGLmg8CedXpSPyEQbmR0d7klsZld6zNtQfSYhTRvpgntcltcid1w7Z
         XyBA==
X-Forwarded-Encrypted: i=1; AJvYcCU1xpR2G9nkYkH4FbcPxkyh0nJ9r1iTkgfY6fhDQI1hSHw5OfTFj++5fTDOqsrgBexzrh7nPQXPe/v9XxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXptMm2HPgef1YJZtopRfLdrkbc6IPx0LAR5+V93ILPuUOLUlX
	zcFEz9pfCYOS1HYM3mLu9m0qk0gfxN7VRIS+64TYE7miklaox+xnVm9TFInPHYI=
X-Google-Smtp-Source: AGHT+IGbLDt8ZDXNCiOg6R8VCnpkVelDlKHWtxr/WdbCXV+AQpiE7tEgEa04LNydACGk9Ydg88ChrA==
X-Received: by 2002:a17:907:9711:b0:a99:ff79:51a5 with SMTP id a640c23a62f3a-a9a69772b2emr1345823966b.3.1729541768510;
        Mon, 21 Oct 2024 13:16:08 -0700 (PDT)
Received: from [192.168.3.33] (61.39.160.45.gramnet.com.br. [45.160.39.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91571e3asm249542966b.147.2024.10.21.13.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:16:08 -0700 (PDT)
Message-ID: <985f11db4b861a7fffcc29b74f9025649cf510d3.camel@suse.com>
Subject: Re: [PATCH v5 0/3] selftests: livepatch: test livepatching a
 kprobed function
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Michael Vetter <mvetter@suse.com>, linux-kselftest@vger.kernel.org, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Oct 2024 17:16:02 -0300
In-Reply-To: <20241017200132.21946-1-mvetter@suse.com>
References: <20241017200132.21946-1-mvetter@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 22:01 +0200, Michael Vetter wrote:
> Thanks for all the reviews.
>=20
> V5:
> Replace /sys/kernel/livepatch also in other/already existing tests.
> Improve commit message of 3rd patch.
>=20
> V4:
> Use variable for /sys/kernel/debug.
> Be consistent with "" around variables.
> Fix path in commit message to /sys/kernel/debug/kprobes/enabled.
>=20
> V3:
> Save and restore kprobe state also when test fails, by integrating it
> into setup_config() and cleanup().
> Rename SYSFS variables in a more logical way.
> Sort test modules in alphabetical order.
> Rename module description.
>=20
> V2:
> Save and restore kprobe state.

With the syntax error pointed out by Joe resolved, you can add:

Tested-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>

>=20
> Michael Vetter (3):
> =C2=A0 selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
> =C2=A0 selftests: livepatch: save and restore kprobe state
> =C2=A0 selftests: livepatch: test livepatching a kprobed function
>=20
> =C2=A0tools/testing/selftests/livepatch/Makefile=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 +-
> =C2=A0.../testing/selftests/livepatch/functions.sh=C2=A0 | 29 +++++----
> =C2=A0.../selftests/livepatch/test-callbacks.sh=C2=A0=C2=A0=C2=A0=C2=A0 |=
 24 +++----
> =C2=A0.../selftests/livepatch/test-ftrace.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0.../selftests/livepatch/test-kprobe.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 62
> +++++++++++++++++++
> =C2=A0.../selftests/livepatch/test-livepatch.sh=C2=A0=C2=A0=C2=A0=C2=A0 |=
 12 ++--
> =C2=A0.../testing/selftests/livepatch/test-state.sh |=C2=A0 8 +--
> =C2=A0.../selftests/livepatch/test-syscall.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0.../testing/selftests/livepatch/test-sysfs.sh |=C2=A0 8 +--
> =C2=A0.../selftests/livepatch/test_modules/Makefile |=C2=A0 3 +-
> =C2=A0.../livepatch/test_modules/test_klp_kprobe.c=C2=A0 | 38 +++++++++++=
+
> =C2=A011 files changed, 150 insertions(+), 41 deletions(-)
> =C2=A0create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
> =C2=A0create mode 100644
> tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
>=20


