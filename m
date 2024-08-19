Return-Path: <linux-kernel+bounces-292717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6696195736A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE159B2453F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA73B1898F6;
	Mon, 19 Aug 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akvf6uuj"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A1C188CD9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092507; cv=none; b=uzFut3O08E+lGIinD8e012HcQHl27NnTy0PVjQZmx/oV+ueOPdmwyZmDUkmrUJYBrC16vG4DMdlyMf7WpVkkKNAFnjm5aBmE7UyKH0ktoLs2ygXGxZ1ClMFAuB74A3hUn5kvz7oNQYrAeLTcXbtPca5CFmHqHF6EqcgbYIbmiPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092507; c=relaxed/simple;
	bh=ZcVkigYWpjlr7iQuQ4MGhGbi2tR5jEY2SDkXCbkC91I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqsOaqS4D98MS550P0afS4o42zU7KJXTXk37p3ZvbihVchAjHLdWK6U520qFag49NV4kB9Jg804BIl/eCNn/9J4MXciyYzLe6jtJAPCmXgIEcrnQdCudoddyJ4dvoswjJughaQaS7nqqAB+od2aX7Rgsir1ET0B2JcCnjWpGmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=akvf6uuj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428119da952so37290725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724092504; x=1724697304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB2aiywFQ/7bZyWYjuuiDbccrZMhIclyQ2+n0baHXZQ=;
        b=akvf6uuj0QfAq/4CJa5leRq8yA9peg8Ko1Xbby4TwrJudROooLQDHSQCnJQ+VtAKZi
         SU5csd7WlmAe7AQJ2h8GPaT/ChrQ75FukMQ1gAd5UrjPuHF2lcJRIOw8lUgxtGRJQgpJ
         rdAutcKIY/KsXyjsTXIEsF5y9G2Z6zB5s1Zs6BrrVdx0WLiYMGZfbDzGbpT/+SW/MF4Z
         6nmlFSG3M2jom2jARXretN0m9dBPirh/JZezzEDBeTUd8pq+yfABHp+0VGKNuXXEGoqf
         HfRF7vq+kFrOstUrQ5q6lmLhnpeevrk6fcdkrVANc8+o7WdzhupcL3YIop7Oa5RSLjhw
         TSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724092504; x=1724697304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB2aiywFQ/7bZyWYjuuiDbccrZMhIclyQ2+n0baHXZQ=;
        b=Oqcg00dts7VG2ac2e8vL9RAgOdrUiFm0T78LG4iwZr6aNiTi5Gok9YPr6+vUlIzd4G
         7HS8F1X16eHGzV8wYpUMijzDhb3WMxAUfxQhDGdZy1ejPZo+XbrWf0GPjdm+rRYeWNg3
         Gn9Uo/xZtppLyoYqoXQ7GTHAzz+dYiTcyAS2txui+2Kxg0lSHyUH3Kx1hE/kgMIOuvmT
         X1yAuQTNkaNXoDm67CszL7c21xgln6/cvSSJWfzoyD04ZfqmN1AeYQha8xvOhKUsWfUS
         AuE2RBAL+sKC8c9/e/7ztxi6zljpPKwAN4aOuDK5TMPk2XkbSg/ResRNRlGTK4VK5hAZ
         iHaA==
X-Forwarded-Encrypted: i=1; AJvYcCXW+qR1FvPQoVd1w1nMgvWjGAj0+zu1OHYDBiU3yfdjJcwhUIGrc88FYJxnxzy5RkkilgOWqcfXg6vI25j8sSnAbK2uZLCWuv5/KtI6
X-Gm-Message-State: AOJu0Yw3GLTyrOfq6Brwv9EVQyvwnPYUtqubztc/bXdHAYj2uGvRNQ0p
	t7QeqYtlx3RpHlNwA3PMML+EpwqlyDv11Zbx1NogMiShFsAc4SHAaGOujB7GFeoHz8v8/EgsSjv
	mLEC0c1jCMiA+DJqMfgBbsEArjaMck+s52RQ=
X-Google-Smtp-Source: AGHT+IHL6SFDUfjBtUFeEhGMqyWAWM/b6qf0aHg/pO4x9FUknerMtwxQJBPOY2OU8LQd8gQ7KOq0NtLDi26TDPoBP0U=
X-Received: by 2002:a05:600c:4e8c:b0:428:31c:5a52 with SMTP id
 5b1f17b1804b1-429ed7cc764mr104616895e9.29.1724092503366; Mon, 19 Aug 2024
 11:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819174814.139344-3-pZ010001011111@proton.me>
In-Reply-To: <20240819174814.139344-3-pZ010001011111@proton.me>
From: John Stultz <jstultz@google.com>
Date: Mon, 19 Aug 2024 11:34:52 -0700
Message-ID: <CANDhNCqoHvvTUk7tmR7u+WPKQV1B7Eztf3TWYDpCQXgLXQijsQ@mail.gmail.com>
Subject: Re: [PATCH] kselftest: timers: Fix const correctness
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	sboyd@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:58=E2=80=AFAM Piotr Zalewski
<pZ010001011111@proton.me> wrote:
>
> Make timespec pointers, pointers to const in checklist function. As a
> consequence, make list parameter in checklist function pointer to const
> as well. Const-correctness increases readability.
>
> Improvement was found by running cppcheck tool on the patched file as
> follows:
> ```
> cppcheck --enable=3Dall \
>         tools/testing/selftests/timers/threadtest.c \
>         --suppress=3DmissingIncludeSystem \
>         --suppress=3DunusedFunction
> ```
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

