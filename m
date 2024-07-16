Return-Path: <linux-kernel+bounces-253415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AAF9320FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CC41F21AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56828224EF;
	Tue, 16 Jul 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BzyrCzIk"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107141CD31
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113886; cv=none; b=rA5qxKWEBFtQgeiHUk2ln/2RqXFh6iqjpx9HTQTAUWoLNlWgkxD5Jy4H6GMwZmSx6JaedB9/Gi74bm/ABnPDC3TvZVmd+49ob5P85GB7HYUR44QQvas6Kxw2ZLbD/VMkm1+7gBuG0bIW+9XOxocXQiXNsxYVIybsKumfGnobHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113886; c=relaxed/simple;
	bh=StBSlGgK+tRpqrxRZebJd4g4zN1CiKmmkFvrZaHtKgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7RgULOGHH4G3UY6q1syYncLvMLYZZ+Il98Gix37ShHXEH3NILrIiV+oQE9nBGeQsJKF0kryT/dn5qQr0wzZb+OGuIfcdKgQdiIli2JmDMUAi+8DowryVLQut4GG3Q9fU3eppUzeLcItz9yE9UbXyeCFd8mRBI5xdmSj5pGoHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BzyrCzIk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so11513a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721113883; x=1721718683; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=StBSlGgK+tRpqrxRZebJd4g4zN1CiKmmkFvrZaHtKgc=;
        b=BzyrCzIkhIaDGqdhFGYALjPpF7ssFMTePlMpgaBjJT0WFxezp/XbOE3E4hlfMd1h94
         w+RFfl3a+qDWozFeD5T4tT5z4GTOzd/dwTQV5+PvmBts5dL3R1tfGVzmLVuklPkFZ8f9
         pWnTbCnE6I2hoduSVc8cJa6rTu2BnzkRgMG+A+uyrwbxL6ujaaIHUFf4ofMTqUGLss2R
         IXya7SXOYdpG59PTu7zjjBNshxWeU7Afg+1sOyZiOURveYi3LJWaw692wR45bJTSmsRV
         O3JtxPj24Av717GIetkmJOqqRJXytJurPnEEvlhhMfifKgiISIqmXw34NsZ5j0AAymN1
         SN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721113883; x=1721718683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StBSlGgK+tRpqrxRZebJd4g4zN1CiKmmkFvrZaHtKgc=;
        b=K6J4eeDbJIX0F3grTUkppvjqd4L0PD2aVJ5MqaECMFIKg5DOSQQZmChleCOUhDRM7D
         4sWhOdux2LkXLiW+hBKFlScuq53hEyQ+veDsXVNWZg0t1utwgYu2c8G3BOcmKZnBmW7Z
         Iyx7mFFbtxeAemWiYfNeXgLQfeKWZctL1SGrDBLzESqotRwWBGWuAAzICrzGldbnYDSC
         QPszTTpahwbaENKHxA7drUkzwm7duqP8Ckm5D3Wy9ZXiTTphZdTdN/njVTZdGea7oGuh
         uZikwJP2+/PFj2PgifY5QLIT55yezBVShwxbB2nvWw1QYlfNgPlt6J+kU6ESV091kpsZ
         oyYg==
X-Forwarded-Encrypted: i=1; AJvYcCUPma+frNTvuCj8vqfWTH7t8GC5Xtic31RfGxvTOjOIeU5GNt928ZATNGrrMw2Yc0UyYuycrEw6Demqu/R7N8ZvCvNTcULC+b4qG1bh
X-Gm-Message-State: AOJu0YyAGJf8COlE8gCOiWd1NyHQbchTLHShypdZqJZcXutwn2EARl6i
	h7y3ZVyAPoylEbDImJcJEOYyaUhN812k2Vrp6h9bgeMZ+Eh8BYvrZTqo88VAsjQpRo9iJiacEVK
	64yI9DNhHwu1LdQ19ccqAqcdQ7gzWC3cGtzJU
X-Google-Smtp-Source: AGHT+IHHL37KYg2xCyZi65ikeUkhu6PK3eRJPl1bvadZrXzf0wYY6A8jWEsTAxCUmhUb/BZyytZnyPQfUd+gSwDvzlw=
X-Received: by 2002:a05:6402:34ce:b0:58b:dfaa:a5cd with SMTP id
 4fb4d7f45d1cf-59ec5704798mr195928a12.2.1721113882567; Tue, 16 Jul 2024
 00:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419222818.50719-1-namcao@linutronix.de> <22344b13affea741ee41b0acb3c62884aac3e1bb.camel@perches.com>
 <ZpYD9dDKYYK0BIA7@google.com>
In-Reply-To: <ZpYD9dDKYYK0BIA7@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 16 Jul 2024 09:11:08 +0200
Message-ID: <CACT4Y+b0D-RmYznZ_+M98hDWiAZ-FG=eusagoeLGGQN4ZOB22w@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: add "Reported-and-tested-by:" tag
To: Carlos Llamas <cmllamas@google.com>
Cc: Joe Perches <joe@perches.com>, Nam Cao <namcao@linutronix.de>, apw@canonical.com, 
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 07:24, Carlos Llamas <cmllamas@google.com> wrote:
>
> On Sat, Apr 20, 2024 at 09:22:45AM -0700, Joe Perches wrote:
> > On Sat, 2024-04-20 at 00:28 +0200, Nam Cao wrote:
> > > The tag "Reported-and-tested-by:" is used all the time. Add this tag.
> >
> > General nack:
> >
> > I think that combined tags should be avoided
> >
> > see:
> >
> > Documentation/process/maintainer-tip.rst:Please do not use combined tags, e.g. ``Reported-and-tested-by``, as
> > Documentation/process/maintainer-tip.rst-they just complicate automated extraction of tags.
> >
>
> If combined tags are discouraged then syzbot should perhaps stop
> suggesting the `Reported-and-tested-by:` tag? I would imagine this not
> only applies to the tip tree and that other maintainers agree with not
> using combined tags.
>
> FWIW, this tag in particular though is quite popular:
> $ git log --grep '^Reported-and-tested-by: ' origin/master |wc -l
> 82056

+syzkaller mailing list

We can add whatever text you will say. What is the official position?

