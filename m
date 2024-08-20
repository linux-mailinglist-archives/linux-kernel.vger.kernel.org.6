Return-Path: <linux-kernel+bounces-294263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F137958B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58574B230C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6A8193071;
	Tue, 20 Aug 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="grO2KMK4"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D618FDAB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167928; cv=none; b=IRvCBiGVwrmYCnkCXeSiOZcH82UYiyWp+BWCQDWJvewAD4AD+lf9B0vYfAYZw9NaK1PnNwOyi+KWgUYLgk/KXUyuPkANzqerK6MJj/nkITKiGlP27onYbk63dMwDk6n6iWoxVJINUtgT4koaYJ3E9cAnrgaBH7+s2oUVLgHBxiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167928; c=relaxed/simple;
	bh=3yCP30jdwAbUdBmUfnky5T4ssOQ0GYBd00wukhRdjKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDiWQ+ffvpHlZouEMiNbu3FlYfAnd4peIKTiKNY4oF5rtBA8DmxSyTySJK0yxxZ00ZvTfPyBjJfwNXSFsC4bBKN+c6cWSOWzWFgPUjxe56ux7YQK5T6wAd1CxnTFF3UqRVriEBjTTGtyYWLlKfDegMqxq4BUJl5Iq+gn+Ma0u4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=grO2KMK4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f01b8738dso4719511e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1724167925; x=1724772725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlyfJep8bXqi70eRVjMGb/QXN5I6JkTieSqA2LKChBk=;
        b=grO2KMK4W5G8fOy6j2CTJK3m1NqiAtWe2w5LBSN+yuU5PaMg52PphVAAl8u+32KFMj
         ZdM+ArZyP4o/my6dA3qLAjFe8PYwyyVsap2nYfJ+xDDE1LrPFuEyvR9lSGq/Si80c5vj
         vczWsxMlrcLYHi1ax50RbiWdIoiiPzgwMTk439wriQen+CHGZdUaEjNvwVv+/SgN3l6r
         kaloag0iGwD6Fc17EmnK1Mm/Lot0Yszja76ZoXclaw35TZFiDdXmABvGEa+s/cvjE5h7
         bsM6/DkkalbiR9YxLcWwbaHQ4L852mKOQhzh5DcAfuW0NGeNiHa/Cu6H43w51J31VcXk
         EQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167925; x=1724772725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlyfJep8bXqi70eRVjMGb/QXN5I6JkTieSqA2LKChBk=;
        b=POQlfm8X6v+AV5UpZqwScC4ytgSIXndFkc3cy4eZEF0QE77ezyBO62o63LxVRSR9Ea
         8tdo8AEJ82tOPcsVkIJ+8zzLIg9tdrtnBKStKZ2EgZzkj0VxDCtZ1KdsX3YiBjNgWsUb
         lwtosjxu+26azAKKZj3ND1ueuoXHgRX6UaNnKjW4a8XmhDQ7R28AIhHO4zF9yCKC2zhs
         FMyBkvgo7O8z5XEZ1EM4+BPofzhQs9JV60Ii6cyRhSEOep6oxsBhrO1s6uMafrRW7H9s
         iziKRxD/PgMVTBQrk+aIXMWhrLf5IiC6wOYy4OhQBvImZ0pHqLL178AWUGFYAoahHPP7
         xwFg==
X-Forwarded-Encrypted: i=1; AJvYcCUkKNN90fAYCoEkzMf7Rv1/6sBGBJ65xVzwQ0xgDsJrWv3ul/QhHgSkfpQ8mKIQEVKXq4O28G072Z2KbItsFx9bzEeW6BZ5FmwID405
X-Gm-Message-State: AOJu0YyPqSBKYcgYr3XvHNfAayj2pQFvf6ziQlygIGP4K2QQvViUF9Nz
	hLMWLVSfAdyse1jh6Rn3atNX4BSEiWQQPXBDx3L/C8/ht0jhJ0Nuwr1vzVOS3whmbR6I7ozFhCp
	hRUUCCec0CVqCisnKfev4jEa036+A5xe1Ing7AA==
X-Google-Smtp-Source: AGHT+IF/cRUYBlGy/+csRyVZc1LkNT2K43ekUV0jTVvwQYEMgOK0RYgE5xpnKqeJiERELBJeMoQ6otcKFqAWQXMqc+8=
X-Received: by 2002:a05:6512:2243:b0:52e:7656:a0f4 with SMTP id
 2adb3069b0e04-5331c6dc3b3mr9669498e87.41.1724167924215; Tue, 20 Aug 2024
 08:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816065458.117986-1-iivanov@suse.de> <Zr+Up+94gmPEHwcJ@mail.minyard.net>
 <84eb700ee647cc40e9e99b086a8648e3@suse.de> <20240820102005.4l2j73jpt7lmwloh@localhost.localdomain>
In-Reply-To: <20240820102005.4l2j73jpt7lmwloh@localhost.localdomain>
From: Corey Minyard <corey@minyard.net>
Date: Tue, 20 Aug 2024 10:31:53 -0500
Message-ID: <CAB9gMfqj2KJ8=dxhKvJewYB8cE04F2y6pqCtHbXnKVJCjTBygQ@mail.gmail.com>
Subject: Re: [PATCH] ipmi:ssif: Exit early when there is a SMBus error
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: minyard@acm.org, openipmi-developer@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 5:15=E2=80=AFAM Ivan T. Ivanov <iivanov@suse.de> wr=
ote:
>
> On 08-18 12:27, Ivan T. Ivanov wrote:
> >
> > >
> > > 3) It appears the response to the GET_DEVICE_ID command, though a
> > > response is returned, is not valid.  The right way to handle this wou=
ld
> > > be to do more validation in the ssif_detect() function.  It doesn't d=
o
> > > any validation of the response data, and that's really what needs to =
be
> > > done.
> > >
> >
> > do_cmd() in ssif_detect() already do validation. Perhaps,
> > ssif_probe() should just not return ENODEV in case of error.
> >
>
> Oh, I wanted to say ssif_detect, not ssif_probe.

Yeah, that's probably the right solution.  I'll look at this a bit.
But I see the problem.  Do you want to do a patch, or do you want me
to?

-corey

