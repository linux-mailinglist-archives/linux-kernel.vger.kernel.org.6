Return-Path: <linux-kernel+bounces-379061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9889AD922
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD031C21078
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A13322EE4;
	Thu, 24 Oct 2024 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANm83Ya5"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F6A29;
	Thu, 24 Oct 2024 01:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729732709; cv=none; b=QYs+e0zPLORKqKVgpFVL+VHMn7Gtyl14SXTG4RAv8OR/vC69Y5dYbZKryA+ia4YQC9NOslTB6ct7w0CwI9eFz8yNorW5jgSHBmEd5Bik+KxybRJuL1wNDJT5fAvK4KkCbO+2g0wjQzvSk5cE4V7cnyCbyE1kfEMv6gcIXgbwKCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729732709; c=relaxed/simple;
	bh=wfvUhbRsigRardEPWk/OQhQlApwHgXf+JgwSDkRvgNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaTNhhKuhqdjLZcRBdr0uVkYFEIPIrGXP4qPN6g6/mRUpJ9kQoGgwjepO8ZBLTxu7V1UsqjLmbn9JCCiYlplpJn5uSGRYRJaDBu8MrLhxV18zXV0go1ZS7SEJfQVd+X+bSaIa7Z9dssklPW/V+DLI2UP6GLexyqhUacuNL/R9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANm83Ya5; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc1af9137so185794eaf.2;
        Wed, 23 Oct 2024 18:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729732706; x=1730337506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfvUhbRsigRardEPWk/OQhQlApwHgXf+JgwSDkRvgNE=;
        b=ANm83Ya58MZQe+insvb2YZ+j5IQOp/R4b57YSOD5ndJifOlWI4IIQ/jlpUB3KB3aB5
         iHpxrBVUoCawkeLCkwqmLvGLt8FFiTkJFKpuZbgNJO6rKT7wckjBCbgtKMGWFa37Q1Ob
         E+KNJOvTwQtfrj6BpagsCH5X/w/0eKRLPomhCJnrhDiwIny3Y0CsIIlarrJ2xRKmaHxW
         QD5njQel/7wPYGYyvkkCAiKFgR6Otafb8Y2WwXYHmdFDYY06vEbPmZUfXZ2GMrKroGqc
         ca7XRiGqtiQcJYruwoULWqeD0lOShgbixcB93Ag8G/NR3N5kq8OVVby2lsRP4n5uJy7v
         GA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729732706; x=1730337506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfvUhbRsigRardEPWk/OQhQlApwHgXf+JgwSDkRvgNE=;
        b=HOBxAGk+YMDP9GnKluSVxOVZBNhhqaPDyzDHklVPMrmYc+JCI133ubR/2MdzeYYWsI
         GtGhy0nsbve+V5UdrHodIlXzFrfrGCcpNdZ+b/l6kS1S+elpR84e91fmMxhby1eTfPql
         aeqnfrpVxWjCgbwcUWvh8O6+1cFzlP3+c0fLYUI8ldh9XOeIlmrhzv0mC6+KObKLAogp
         4L99OEKl4yaiBp+zVD9YlpWKNjVfxOUoBMBxsqtsNPSK1i0vCe+4RaDtTmAqERS9h+bX
         Wqegw4I6XBfX+fwU5C/TTUxZvPqLdR9SPQpvXUlNCu9YMpCUUUIReekEZKOhzOvfv/IP
         BX+g==
X-Forwarded-Encrypted: i=1; AJvYcCUccl9LXyXq0lFDwi5RiF4+gmECm3+g5ARsNOeE/Je7plOAli7fPc88JbV4qao7WInLESrBA7xNvopFBl3a@vger.kernel.org, AJvYcCWFldGvvJbHekBmHPbNlsqz6b53tBWHptCL7L5WgPoblVQgb+Ze9GRlo8YVgX4+fJIGiHN0FYxXk1QhIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQFNd/sQOIIfmkrIRQJtktMF9D+zrrYbCbmQPMfs+snfB+Ct7
	xu/LJHhZXjO/x39U5OlKjZQeRkEJeREwuBhDpSR5gc19Ear/t91KMJ13s+OF5VIfUZRFRlL4OCp
	kwJKbYkBJPbGtAdb/lvausBwYqSs=
X-Google-Smtp-Source: AGHT+IG7UlTTS9bQ2jL6HG9AOU8zrKrrTDGdTQpMfWY4w1t+Su615+BiB+tucAPqj+RvqCguaFww793L08x8FwP29N8=
X-Received: by 2002:a05:6870:1719:b0:278:1c68:9c03 with SMTP id
 586e51a60fabf-28ced111533mr225031fac.8.1729732705953; Wed, 23 Oct 2024
 18:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023201334.250764-1-mezin.alexander@gmail.com>
 <e78714f8-ab24-4853-99ae-4ace59ae25ca@roeck-us.net> <98dc2657-ac1c-41e7-b9c7-302bae5a3556@gmx.de>
In-Reply-To: <98dc2657-ac1c-41e7-b9c7-302bae5a3556@gmx.de>
From: Aleksandr Mezin <mezin.alexander@gmail.com>
Date: Thu, 24 Oct 2024 04:18:14 +0300
Message-ID: <CADnvcfKQ-Ei0QS_R=QqoQ05s3GZo5pYC=jFJWMsRCWOWR4MToA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove me from nzxt-smart2 maintainers
To: Armin Wolf <W_Armin@gmx.de>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonas Malaco <jonas@protocubo.io>, 
	Aleksa Savic <savicaleksa83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 1:24=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
> I am assuming that you are not a Russian troll and are instead offended b=
y
> Linus comment regarding the maintainer de-listing.

I'm Russian. Whether I'm a troll or not - depends on your perception,
I guess. After reading recent emails on the topic, I decided I don't
want to contribute anymore.

> It would be a shame if we loose maintainers because of this. Is there som=
ething
> i can do to change your decision?

I haven't been that active, it was just a hobby, sending a small patch
from time to time. I think you'll not lose much. After all, maybe I
should have been removed anyway - but was overlooked because my e-mail
isn't on a ".ru" domain.

