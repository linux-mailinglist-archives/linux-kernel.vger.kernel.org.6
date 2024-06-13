Return-Path: <linux-kernel+bounces-213757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F559079FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48291F23143
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBB114A0B6;
	Thu, 13 Jun 2024 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qcx6dxXR"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8314A0B5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300180; cv=none; b=CNOTW1r1HmgZ3Zg/kftAf9p5Kf6htuxyQya/7u9Ta8oelLtSzNpQh+jH0nC+Ns89VJi9aIXV/kr78E+T/zKlJerVYhMDfigE2SJIS85dwWd43WRAh4kw5NQUq3Kepv50Hxf8ESnhBzriEpsXjfIH2z+WJc5pmOv+NpWcssJnx3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300180; c=relaxed/simple;
	bh=wpYAeO3qLDmEbVwjk+bLqgGvh+uERDkZc9Q/nNwO7LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1i/kEEm+FZ33E0ghXoWzSTEjUXMmVupcaZFvqrbioc3mEHLvpKN4y6fsJRYn8B0L4QqfJGNAELZSMONFCril6RXIqLIkWkJBS8uB6MKfiCyTwcTabriQAQ/dOHmgIRT7mvYRKAtu0hTnq87p5KTP/D2mqjLvl5rQZM2lwu8Aho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Qcx6dxXR; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dff06b3f413so922989276.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718300177; x=1718904977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GErvgxd9rMF9jDiySOwKqOC0vAMN90Lf+q/hWMcRinA=;
        b=Qcx6dxXR7cTRqw4bTrXKAE9KIAZDV7W2/9M3fk92BTGuLOGbURN+ts6xyNb5MpBtOu
         GnbfZa5FbTpeiYdAwaqMN+cXcuDRDCpZ7Cy2uNbrag4NY83LdHrTEpqz1FPgixmS8y0p
         YRAMK1wyls5lHikDrJRsKRJeFuDQI1Q8BaO2LXQ39KeYUHlrykmx9WYiEw9f3DRMq0Eb
         lLcVQXrXw6/2Uoy0kP76NZrQ2Bz2q9QuyTsccNlV3Qe7wW0btrzNsBsEq578UJ5yCPTk
         Z5i9cZ2J8LLwpEXxH5D3MLklVBV/6VbjyB3RYmClkxCf4qdyBPWFF2AHchWdy+XU6n73
         d4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718300177; x=1718904977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GErvgxd9rMF9jDiySOwKqOC0vAMN90Lf+q/hWMcRinA=;
        b=BaiohNp6A0Gyw4qaZqpyqB0aKU8OIvUI/bYpaWP/IOEk8UHeVpN9tlf6Ubr3HkgtaL
         v2DvXWJAE2W6L5X8BcT1whoG2PX55zAmPnQ+iPwsj3ISlRQREMEcAAHIlcuvw6Yr5Hhv
         MSgYh8CL6QIQ5xWGNx0GSDYkpVFUWXbtd0mxjC2VDGG/EL+gukZK0ITqwN1QZ0eUgdq6
         ggJE98QCefStpWjgCROyVWVIGxMiNoplXrjk6qzh3rI1rZ22PRwSxwq9LGKeE8yfmpfc
         dF4qdqujieGvK30K7QouL6HCzjD2Y8CscLl4N+EtXobG6DqWwwozWMZtVM+QVYZQB8YM
         g+0g==
X-Gm-Message-State: AOJu0Yz5OkDM1dwi2QZ7oT8CMbui83A8qdkkRLEgBXMdM15W8hMeBRSn
	bPdIx46yiUAXFLb7X1xMZlDMdz1Y7xCz/740NbOZUB9nmH4zW+zaD/FTnqe9iqQIg/nwOPnYHWB
	bzc68EqK3LuusCBU3CgRKApnb8iSP/fvMT7nn
X-Google-Smtp-Source: AGHT+IFHmbiArDsXZWAVYs3rjmdh3ys4tk76bUfvWftcy8jvKjto9zOVodRX/SH/AwXV4pGdCMt5fhvB8xha1GEmN7I=
X-Received: by 2002:a25:260b:0:b0:dfb:d69:5657 with SMTP id
 3f1490d57ef6-dff1534f118mr168388276.9.1718300177648; Thu, 13 Jun 2024
 10:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvWXuWyd3NiX3WwRyorRiDRbxGmRW_7aVnBVKUVA_TaGg@mail.gmail.com>
In-Reply-To: <CA+G9fYvWXuWyd3NiX3WwRyorRiDRbxGmRW_7aVnBVKUVA_TaGg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Jun 2024 13:36:06 -0400
Message-ID: <CAHC9VhSeNGo4fPY0H5eM_fFsPSQ18xWUYMvyHBChEysXk-+00Q@mail.gmail.com>
Subject: Re: security: ima_policy.c:427:17: error: too many arguments to
 function 'ima_filter_rule_init'
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, GUO Zihua <guozihua@huawei.com>, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 8:43=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> The arm and arm64 kselftests builds started failing on Linux next-2024061=
3 tag.
> Please find the build log and related links below.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thank you, the same error was reported by the kernel test robot
overnight.  I'm going to look at it today, I suspect it is a conflict
between the LSM and IMA/EVM branches.  FWIW, I compiled and booted a
kernel using the LSM changes yesterday without problem.

> Build error:
> --------
> security/integrity/ima/ima_policy.c: In function 'ima_lsm_copy_rule':
> security/integrity/ima/ima_policy.c:427:17: error: too many arguments
> to function 'ima_filter_rule_init'
>   427 |                 ima_filter_rule_init(nentry->lsm[i].type, Audit_e=
qual,
>       |                 ^~~~~~~~~~~~~~~~~~~~

--=20
paul-moore.com

