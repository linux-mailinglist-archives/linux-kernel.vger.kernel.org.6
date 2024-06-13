Return-Path: <linux-kernel+bounces-213825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E5907B38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1BEEB24A09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BDB14B097;
	Thu, 13 Jun 2024 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MrMqolDU"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAB144D0C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303012; cv=none; b=arUfXRaTv9ChDTdXZ2sYq0Bbb12wIt0qMxCdogbu9DB3pqvSH21uMsCX5Cz4O4dcnuWl+IXdICxJJH5izZj0oGiZDpSAsiZODu0wqBBP9G4BmyY4cgKP6AfOudh5udWR8B/uTJZk6TUvpW5OWC+LNI89zQ2ppaKmbeF1whqwkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303012; c=relaxed/simple;
	bh=krCnTrtnkHB1D6bVOwKkRyMFqhSVLnQUJePCdLAPTDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti4uT2uo+/WnEaFqmarCb/aU7T4NRAVD5CaBY8oeEcH2I9X4pAkCs8N/240N+29/ai30v0nUeVS+QK3hCwcaRxJFvYPhm9Gzfh5R1BzPWeLb0QB4UYSX4seQXdGuFtqqNFTcafEDTHmleAcRenGAKQsfHJ6DnquZ0DHALSzvwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MrMqolDU; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfdff9771f8so1527058276.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718303010; x=1718907810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7FnJEUeHYST8KdquXXOOwJt3IXf3k8psfyOLW+siSs=;
        b=MrMqolDUAlzO/IwTF/IGKX2UT5qyxUTNn9DCi10W5dPT07/AkjTeQUapfuL+zOuWnG
         dBS7kyFdbOpfHtC0oZqGrrymabTVe1iQnNtN7Ftsfw+kZX9ZLIYUWNYyZDhjYzw149uG
         sal4RQFSAfd+AnOShUxqyWj5VOrVCw6Rt3XMvjk05zUOu0SEbUkwvdckXx5VLwfAFgZ9
         B2bzl48OgAetQRpB/iQsTY2vMnLj4xpYx1sip/7brXX0H1J5jzJHppAAal0yOFz4wnSJ
         oigpWpaJGgc0fyEuSLg+2WjG4f5uq5AdVdb+YX2bUgOZWRHpnWQr/DmhRT90KqgEQfbb
         AXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303010; x=1718907810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7FnJEUeHYST8KdquXXOOwJt3IXf3k8psfyOLW+siSs=;
        b=u5v3mXfQkl1qDDCxlU7ammkj3kcYnbLOf5AKP8b03toe17a4K2k6cV9jPJGMq7QOoi
         Hia1y9mjLj29Mn8XEdW1BN05ZG+orZfqSKh2g2gf9LgWPlPiEF/bMAdGDikd4s4RA6Lz
         SjD5s8WfioPnrwPszfjVg6wLXPILa0rAOmlT4c/mxLYW+PIiEFluXZbwZMH6oOgpBNfW
         AhX9JfXTMiceeTWqjCwBCSxLlWTMDsui/jwMv7jte8XGYYSTLfUhGXbKeezdyxEoJSG+
         ILP55lnTTXS72k0oJwS2LepQOwuVtrNujd7riYNIzuyXG++D5KI3xzKX7gbkQ9p0lWOy
         HPMg==
X-Gm-Message-State: AOJu0YzNjkBiNtIMFfTlIHHlF0Kxgscu0rdpUcTSyf0Mv28iaM4axsN2
	e+Zqzfx0muRceT0mLOXIP02UQs+E5XItuRUGJl1/Gb1PAmD1PD9Y9miP8+iz8CP3V9dtC2HSvih
	jBWCtg+KoIBCAKQrFntszYMSXeS9f2GXh+eEH
X-Google-Smtp-Source: AGHT+IE4Ltjey1yaGfz53sQ/9WLShdZ82+JIBb7XxCn7Eqt0EFUMoYYVjqNU2UFmX1J77aFxmDQczyuNhRm+3bZd5xw=
X-Received: by 2002:a25:dbcb:0:b0:dfa:584e:c661 with SMTP id
 3f1490d57ef6-dff153c3883mr320940276.34.1718303009863; Thu, 13 Jun 2024
 11:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvWXuWyd3NiX3WwRyorRiDRbxGmRW_7aVnBVKUVA_TaGg@mail.gmail.com>
 <CAHC9VhSeNGo4fPY0H5eM_fFsPSQ18xWUYMvyHBChEysXk-+00Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSeNGo4fPY0H5eM_fFsPSQ18xWUYMvyHBChEysXk-+00Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Jun 2024 14:23:19 -0400
Message-ID: <CAHC9VhRg3efo2J5VsxxskFW0ntotwswvLmn7cWEMmSTkEC4QFg@mail.gmail.com>
Subject: Re: security: ima_policy.c:427:17: error: too many arguments to
 function 'ima_filter_rule_init'
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 1:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Jun 13, 2024 at 8:43=E2=80=AFAM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > The arm and arm64 kselftests builds started failing on Linux next-20240=
613 tag.
> > Please find the build log and related links below.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Thank you, the same error was reported by the kernel test robot
> overnight.  I'm going to look at it today, I suspect it is a conflict
> between the LSM and IMA/EVM branches.  FWIW, I compiled and booted a
> kernel using the LSM changes yesterday without problem.

Nevermind, it turns out the patch is bad :( ... more on the LSM list shortl=
y.

> > Build error:
> > --------
> > security/integrity/ima/ima_policy.c: In function 'ima_lsm_copy_rule':
> > security/integrity/ima/ima_policy.c:427:17: error: too many arguments
> > to function 'ima_filter_rule_init'
> >   427 |                 ima_filter_rule_init(nentry->lsm[i].type, Audit=
_equal,
> >       |                 ^~~~~~~~~~~~~~~~~~~~

--=20
paul-moore.com

