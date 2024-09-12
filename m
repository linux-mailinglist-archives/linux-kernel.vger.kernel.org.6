Return-Path: <linux-kernel+bounces-326034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA920976197
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1C11F227D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A2189F2D;
	Thu, 12 Sep 2024 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hVZrSexi"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80E576025
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122979; cv=none; b=rBOSV5vAmHdcNTYHv5WV/D69QEefMrOkGAjhjnOB29Ddi7sRph586kSENxzygBGs7B0giefGnrG871d7Q9ACiCljiUtPuKoyjLsr1AoGXk/7eJtybu9vRKr1gwrGvU5o0mbtbkPH++eWTXW/7Zxo7/vM/P8+1scE4cCDTkVL6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122979; c=relaxed/simple;
	bh=fCGWj12dd0BCi/tTksYb1fX1b8UkwSBSZk7OWQIugm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iceFihuOZigO2loQ5YkY/GVsT5ieDZOAOMyzFfSZB5FMNYzBhVmXMgH6ai/StJy/OMUVqpB2pdMnqeTtLDh9wiRMxjNanCRSaahW0HQyI5rwwLw5YLsE2vqfyBg9DbcvTE5qVFJeeRZy8Pk7RhnHSw27qZzzMJ1wdi3OKxg5Jf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hVZrSexi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8ce5db8668so97424066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1726122975; x=1726727775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URZ00QgxLN/F7xgqjY2bty6V5M/5jqv7Yqq0C8IbfCU=;
        b=hVZrSexiS0VSZYGMz/oE6ERBW0jmxQyPhBbKpwNhUUbum5oELj+R2INz+7gj2nJesa
         46dJaCG/wi7uKeKzsZD83DBi9Eoe4gZB4+/HiXbiDVxSGr0UY/fglYoXLfXVR/A8E3fY
         nfFEXBLVxPYNzJRsLqhRakyna9/TnYcbKOUv82wMbrlkyO8XxuTb7yRJU+SS3rNIjwnD
         ZR0NYAxtVEOrGk6iCBYnPZ47EB6PcGFGJxcXRdF1KVN3PAEO5v5JbC98vVaDecFBaQYv
         ITZeiK/UOsVdq1K96nQ4VrbX4fHJX43otTUJ+YmgNzNrHVruWceOBHPkhDtK9fv4ah3E
         3jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726122975; x=1726727775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URZ00QgxLN/F7xgqjY2bty6V5M/5jqv7Yqq0C8IbfCU=;
        b=DWTnCn5FMuKXseALIwLw+HtK+zqLtHDelzkd0jtMycgioeh1eM12Mxcj0yLNET5F/q
         0ca5Q1ErhiPkO4ENUYOBI3vA58pi5AhenzMOOCXbSMxeayYRWAvEbNXBF+KGCa1ImOSu
         L/vwlHWc+fRQ9xxuJcU+2uoROofk3yzLESmSTkqhEszlMLH7zY8ORHr4Ldn8rmQ0s2uQ
         BrK5vTrz0kRnn3dttrFby2gZPrkJ/zjOhBD3jKfNow89PtbNgcNkQefvlrwh1wPyDYWv
         Kc7rY3jtlWMj+JGFWFXvZMHwgIVDTm6lFUwYmeSpqSrJv+6LbjGei5FA1ez5Braqluof
         gK4w==
X-Forwarded-Encrypted: i=1; AJvYcCXmCvqxpbS4xRTHNGSL2n3BGEIfV88X/6anufKDVm1ghTfL8YZBu0skR+MDxzTeFxTpXn8WyfWYXmsJo40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN8lfygdvgefHXA1/DGyYKWebc9T7LMBypcBuzYafq4/Yt+ypF
	ijgtDHYRlCY71kmGQCKNWmM+jaBE2zUoWn9rRpQ0+Gbmwo2qym6qR9Sxd4uo/URQ76qzfNWyxw6
	7XuF5Vi/msEwtn7mCndBm6xOFSAARGEJ1h+jXqg==
X-Google-Smtp-Source: AGHT+IFFPy4Mdfn71pHDnT1jEEYukaugMLuRiNrJBl2/BuilVYgDRWJKP5ccjKJM3VEuY8nWSy8SsDFnvh6fZu9Y3sg=
X-Received: by 2002:a17:907:7f92:b0:a8a:6e35:31ef with SMTP id
 a640c23a62f3a-a902961d872mr149463166b.49.1726122974733; Wed, 11 Sep 2024
 23:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4b6aec51-dc23-4e49-86c5-0496823dfa3c@redhat.com>
 <20240911142452.4110190-1-max.kellermann@ionos.com> <CA+2bHPb+_=1NQQ2RaTzNy155c6+ng+sjbE6-di2-4mqgOK7ysg@mail.gmail.com>
 <CAKPOu+-Q7c7=EgY3r=vbo5BUYYTuXJzfwwe+XRVAxmjRzMprUQ@mail.gmail.com>
 <CA+2bHPYYCj1rWyXqdPEVfbKhvueG9+BNXG-6-uQtzpPSD90jiQ@mail.gmail.com>
 <CAKPOu+9KauLTWWkF+JcY4RXft+pyhCGnC0giyd82K35oJ2FraA@mail.gmail.com>
 <CA+2bHPbMwsg8NkvW=FCSwCs9p2B0wBkrfW6AbPj+SOWNHAD45w@mail.gmail.com> <8dfd2741-a2a4-4fbd-9800-5d19de2c4377@redhat.com>
In-Reply-To: <8dfd2741-a2a4-4fbd-9800-5d19de2c4377@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 12 Sep 2024 08:36:03 +0200
Message-ID: <CAKPOu+8VdbrH6pc3vRgh+FnW=kzj1s6TYUEuQQGM_xKmpazXGg@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ceph/quota: ignore quota with CAP_SYS_RESOURCE
To: Xiubo Li <xiubli@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 4:00=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
> > If you want to upstream this, the appropriate change would go in
> > ceph.git as a new cephx capability (not cephfs capability) for the
> > "mds" auth cap that would allow a client with root (or
> > CAP_SYS_RESOURCE) to bypass quotas. I would support merging such a
> > patch (and the corresponding userspace / kernel client changes).
> >
> Yeah, Patrick is correct. This really will by pass the protocols and
> restrictions in cephfs and introduces inconsistency. By adding a new
> cephx caps we can broadcast this to all the users or clients.

I don't get any of this, please help me understand.

1. What protocol restrictions are being bypassed?
All the (user) documentation I found on docs.deph.com and on the
RedHat website about Ceph quotas is very unspecific, but it mentions
that clients can write over quota for up to 10 seconds - so writing
over quota, while not desirable, is something that can happen in
normal operation and the resulting state must be well-defined.
I found no protocol documentation at all about cephfs quotas. Where
can I find it?

2. What inconsistency is being introduced? Do you mean that the actual
stored bytes are bigger than the quota limit? If yes, then how is this
different from setting a quota limit on a directory that is already
above this new limit?

3. What is the worst that could happen if I ignore your advice and
just  keep my patch in our kernel fork? (i.e. without introducing any
cephx caps)

Max

