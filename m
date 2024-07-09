Return-Path: <linux-kernel+bounces-246771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A91692C675
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1701F22D0D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE0118787A;
	Tue,  9 Jul 2024 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YTkbSOBR"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8E156F3C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566828; cv=none; b=eDowTTjM5F1F3MRVBF9Eee3RdOgz9CyQrQPHLc5gJ19AJBB51C4Td5TPW7pUZYx4DK2wQCFn1MnWOJRxZkaxM9nYcEOJ+bRl15BQZs8un+t8qimvdSSGY+ZvfCIIOmXTTCD+sP+6Gt5QL3Jhpvf7MACKOxGtFzm4IgakW0C0R70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566828; c=relaxed/simple;
	bh=DDG3TE8Tj7wXuOW1XCEGC+yaI3BIS1r+9jx6G/XG4uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q341a4spLS8CKtLNjYPhnqycz+/9Lris0tN8vpziIrFcACfFnJQa04IjKEXP2qbd/GRRfm3r4a12cKRAPafnMRi5ZTw2Mz2vpQpEsQtZLA1Y6hTUvcUbvVn7GgpC12Lhqa/egFRkjypjkzAg4vkQccKWa0CBMxhy5j/XCOVhcas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YTkbSOBR; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-650469f59d7so50625617b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720566826; x=1721171626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2M6TIe4a9DT8/78y438PlsE05xBzY4oBMJP1I0gw2M=;
        b=YTkbSOBRkyFJ9W/yDzRw/r1bNkD4BroYh+f/y/1Rjk9uwDMtBAgpL6UTRowF300ZDn
         8HAhvPkDGBN1lQ/pKmqJnQBRUXxPOA+8mrlLpekVdqCJqABeadsKvJR4kxVy30bego52
         HfSdSzF2KX0+i8GYgCmwBroHycX1LAwqwK9AuQBW/mO3Sw103qg0yDAqzrsi/ROGVGrB
         e63hWDoAFqEQeN4DS+7uYBt8RpH2gcApqB5gildXIw6ntsSdOd5d1eUUUbkK7gVradJM
         j/ygUENYl3P9JfSgt/lY6VblAkU/aF5u4I4q9y1wfhE4Ok/1R4tWB1PLijZBBxsw92sP
         QFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720566826; x=1721171626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2M6TIe4a9DT8/78y438PlsE05xBzY4oBMJP1I0gw2M=;
        b=vG6O7SqEiLvU1SMarXy5FUXRvtecZ2MkpgN6IE2AU5grwWNpeoBR/HApfDohhD7Sd5
         ASWMqMlioapIKvjLTQfGNoMzmtmamY0VKwxL0kFvxmm9LqCOzvwxyJnnkHfK7gJduJmN
         HUSQxtErrHG5KDhwJCp8Dbb3hFCe1LWthlW7lMYqzxPD9/gbpobV6DUFXgcV4C9H9KZT
         XuzcvhIwQl9nWUDEOeFqkfiNDqGfCREKlOtHvipgp9IN9R5Y6tSojT6ABxxpvUgnXymU
         r9yyZTFFbQCi3CWza03/JiZdTdpO4mfBU4JHaRNvwjIwmJJgGj9jfXQ5AqKFYN9fUOUw
         qUbg==
X-Forwarded-Encrypted: i=1; AJvYcCUonXrS11kQJbKRYYvYuR5yJ9BUR/kQlP2b6joy2rj1ydTyokyO9fk9TLyt94MBXOHr2v9Bh9IlWl1wOSMayIQNel+fcgOeKe2lvoo7
X-Gm-Message-State: AOJu0Yx+BLQFng9wHzfdRmUt8/9YylpTCsWcFUVYW2T5oAYaG6XB17Rg
	gpLYlpWIwmxHCaRoM0ZZx+xksdwX55EQO/WzDqrCWgYeK9h2wVJhOUFdqMPcW4aTB565psUE9qO
	obMqdFjabUqWk1NNfLCUHdO2ixNrNfpCIlomv
X-Google-Smtp-Source: AGHT+IFURzMl62B50V6bv7pkhDaaWMWC6GI/Yco9aDcZD0sGEVPUaa47A1Tw56Fqci4vHYAd8SZ0xzuprR9uFyD8iQE=
X-Received: by 2002:a05:690c:728:b0:630:d0a3:d2e6 with SMTP id
 00721157ae682-658f08ce64emr42146487b3.49.1720566825868; Tue, 09 Jul 2024
 16:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000076ba3b0617f65cc8@google.com> <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net> <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net> <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
 <20240708.ig8Kucapheid@digikod.net> <20240709-bauaufsicht-bildschirm-331fb59cb6fb@brauner>
In-Reply-To: <20240709-bauaufsicht-bildschirm-331fb59cb6fb@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 19:13:35 -0400
Message-ID: <CAHC9VhSPAgCCT6CfUbgSEG=zhyXVbHZRsGywi5E_1iScKnUdQA@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] general protection fault in hook_inode_free_security
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 1:47=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
> > > ... or we find a better placement in the VFS for
> > > security_inode_free(), is that is possible.  It may not be, our VFS
> > > friends should be able to help here.
>
> The place where you do it currently is pretty good. I don't see an easy
> way to call it from somewhere else without forcing every filesystem to
> either implement a free_inode or destroy_inode hook.

Micka=C3=ABl, let me play around with some code, if you don't see anything
from me in a day or two, feel free to bug me :)

--=20
paul-moore.com

