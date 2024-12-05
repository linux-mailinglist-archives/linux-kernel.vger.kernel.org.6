Return-Path: <linux-kernel+bounces-432608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4E69E4DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175CF2814E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4863A191F91;
	Thu,  5 Dec 2024 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gacU3MCd"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8D391
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733380420; cv=none; b=RpGU27N4d89TXRg6Kl7UIAsKXuDREWwqPsBj2etLSPf8PJdy+n9r77mUmC4c+Q+Phvq5GHc0Aa6+f98tX2ZBKe3T4WUt2SOUVWlEZPqi2474A7eQlETslUK0OIIA2PGe4BpH9PNnDJF1OpBeUco8t55RIyaUFgRXqbB7+peBhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733380420; c=relaxed/simple;
	bh=pbI4hIFk6QgrwK/9bpiY75rpdjXp9Lynmy6ra6vDhDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJZVCof71yRO+3HBdmGgnw2DY6e/mqEDYSGG5/s58tbQ6X00IzeIt9p232lIXbofNw3tLt8E14UBkdmrmha4lJFf+gOKggFMQlkAEYFTqOtppZEwAlL0iCfdB6KX0cC8iX0v3X3YLWXuIHFfNhhovg1eqNk/cqAWV91GnL4aZZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gacU3MCd; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4aef1e4c3e7so135922137.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 22:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733380418; x=1733985218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY+b0xTb8ZmdemLjxSlbAotpStBS9jhlVR+fF3spJyw=;
        b=gacU3MCdBjqT24jdyZLK/jRwbUNmcmjmqKeDAxwTt5dXdOqhb1+Bpp5c6bDoW4wFaY
         upZtoxs8WzEhN05pnBWKk73iK06NQCAGW9/mjA/pM/yD5X4kdRfb4OnpyuAmygO3n3/d
         ozrQMt9FIDOCr94VMUZn9rLhlcl5kXHXLh9+BXKxLIw4J1mkdgSA2X4XEBlRajPTjFuG
         gH+j2uVgpfkVCFW74UhJ8fTCvs6Z80/3POb0w0r+N0nkhUFh43wRAG+WUB+fTvjvbm7k
         lxPPyh/Mst9qxA9W5NVZDtsdH4TwxyBb8lPL2RImNiMMaHOAeZrOHxsMVo16sHNvZ1Ar
         dUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733380418; x=1733985218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bY+b0xTb8ZmdemLjxSlbAotpStBS9jhlVR+fF3spJyw=;
        b=bV29AmFQFqcbBu6PoQR7CGM/DRdUorXj0xnjimzG0dz97SJT+4ZLcpogM8nlGxvOTj
         w9MKfWUWCp5R6NvKCGB2gyBZIFlTc/GEDCa4YeNSfO0qWSETucG0LmxdPla3pW8CK91h
         gUXsX4wJVCY0AeQz3oyP/eOi8x0iSLK7md40lRdOk+0VF73omTvcwOsyPJ0Stp5+NTgI
         T03MceIfwlKYAjB14IxdrYqc9yBElvcCK7e8VV7teez0jtqcUqbTgtRYJ3eQzEPy6QZK
         gxKy5XzZRY8m3T7UQuRRGVvhuhaLYXSIYsN5hl0+Fy79xR6QezzkM4Lp5aOVDhNeXkfo
         jIHw==
X-Forwarded-Encrypted: i=1; AJvYcCXR8I2GbK9MUmpNY+lYzrdiMzVxtWJfmxWYvIFsuO5Zt9aZjLbS+MP8oAi/i0L0kgGCYgO0JgUHwf6Srx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JZANcuVIvNgw5DYjqf9bLq7JkZyhUimCgkulLjgJfWlE5H+B
	/kVV3O+xknqC6IQcTL/kFitE+wl8c+TSNrgWTXYydRat9nGp22HiNQgfl415sjR6B3iyB7yGlqs
	tVSId82fWJXzMT5axnHYBk4H32X4=
X-Gm-Gg: ASbGncsqZUhX7ZiGD0Ma5EWctbQ6jznu9hbWIrWF9zgY/Of9IucseuNrqZ4CN/AoQtp
	ldXs4OOzHYX6oDn0BulPYx2HKA1j7g6qntx5QaZZDmV35nLOx3ZI5/tPGwv/pv3pbYQ==
X-Google-Smtp-Source: AGHT+IERqDzM5gmDIo/KivV3jGkklwe/H6ZETWS9YZLPfHPITYcompqQJJ5/bdWwEa45Q6bWjoEXurvkVvab1g9jrhg=
X-Received: by 2002:a05:6102:3668:b0:4af:a576:30b6 with SMTP id
 ada2fe7eead31-4afa5765438mr7735662137.20.1733380417968; Wed, 04 Dec 2024
 22:33:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5e191ae02c2ab63c70cdf44877fe14fc69f5ae8.1733368611.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4x53qO1r=6=gjkZQWvc2xYR8V-t4d3t4V4o9qFobqW2-Q@mail.gmail.com> <48fe508d-ecb9-4607-aab6-cc18b4bc78e9@linux.alibaba.com>
In-Reply-To: <48fe508d-ecb9-4607-aab6-cc18b4bc78e9@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Dec 2024 19:33:27 +1300
Message-ID: <CAGsJ_4xZDrCSjv5NA7T_yDyjKbCB8XsADPQxCnq2qRO8gU=VaA@mail.gmail.com>
Subject: Re: [PATCH] mm: migrate: drop redundant anonymous statistics for file
 folios migration
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ying.huang@linux.alibaba.com, 
	ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 7:06=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/12/5 13:00, Barry Song wrote:
> > On Thu, Dec 5, 2024 at 4:54=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >> Commit 5d65c8d758f2 ("mm: count the number of anonymous THPs per size"=
) adds
> >> a new anonymous counter per THP size, however, when folio_mapping() is=
 not NULL
> >> during folio migration, it means this is not an anonymous folio, so re=
move the
> >> redundant anonymous statistics in this case.
> >
> > why? Are you sure anon folios won't call __folio_migrate_mapping()?
> > folio->mapping is PAGE_MAPPING_ANON for anon folios.
> >
> > static __always_inline bool folio_test_anon(const struct folio *folio)
> > {
> >          return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) !=
=3D 0;
> > }
>
> Ah, sorry for noise. This just caught my eyes when reading the code, and
> I did not think about it deeply before sending a quick patch. Thanks to
> Barry and Ying for the reminder.

No worries. I recall encountering a negative count during the development o=
f
the original patch and eventually realizing it was due to forgetting
to increment
the migrated anon folios. Your patch seems to reintroduce the bug I encount=
ered
back then :-)

>
> Andrew, please drop this quick patch. Sorry for the trouble.
>

Thanks
Barry

