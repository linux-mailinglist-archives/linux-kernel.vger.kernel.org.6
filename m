Return-Path: <linux-kernel+bounces-433982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6669E5FCC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D8F285366
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37421BD9CD;
	Thu,  5 Dec 2024 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBXYARqy"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F021B87ED
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733432316; cv=none; b=dh7e0Th9V5mJvp1OLt5k6H/8M5Xz1VGJt2bOohKF2x9Ldm2hNbytO/biAkGFWIk8VfQSAKMWR586IoOCnorA/PrJhdKe6P9sV2Um/ceEthMUKto3AXr0MK/avelscn3KZmo+WjkkWFrcUiYg7a+RuegM0qsVNdbDv5TOuaLnnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733432316; c=relaxed/simple;
	bh=bMicQtsMNQVm02WIs6cu0LU/nIJuALuKx/crjZaeWK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohUose4ZSvwrxSV7vDgN4HWhf4Ju32rHmCQl4+E+DI/cxPg5mj4Ohxe9YGZhmzvDDic9lhWvjksnfrdZnvAj1HXP2tGydoom//qs0rYnhr48N3fLLupj9kkAsQRSwyhggvrEUo1YXg7uj+4ATsrO9JDy7ZaR7SCHwNMg/mLGYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBXYARqy; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e1be0ec84so1675666e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 12:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733432313; x=1734037113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRmvhDyJMv49jiqonPHAeKnA3QIYKzHJY1yeXH6PQc4=;
        b=UBXYARqyKSHcUfJbZu2d1EpKlM4/HsivD6dq+RUfAz8BOY6PNnTN8znhcpRqyaW8Y4
         u8lK83CSR57JDbpAAHxlqMZmIeC7EUNEGNf2hXJfgfPjAyzqH9pqN6IcUFhxtW9yxm86
         w/P6lHEPLejrpCzYR5MEtQgG7Olk64/NrTWKuU5VtzOhCOe6uo3D6cOHLWtJ4GnvzQGb
         kzJAEsgdyIfxNPUtGSULyJsUG+lsF2IdG+wFYQKj3fwreHUd/XQRz1R+zO4c54rWvYI9
         PbIQ8DJl4/RREj2qUDx5hW039oTUkTOIznct/OZTeMjgy7qMbfDqJ7hir2pzojQafNWy
         N4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733432313; x=1734037113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRmvhDyJMv49jiqonPHAeKnA3QIYKzHJY1yeXH6PQc4=;
        b=tttZnkPSwPGAyCnrF6lw3e3qYsjmSmLrCrmd12Cuz7jdDY5T2uzS/qej6eJgCwb9ua
         7oYp2F4ww8S5fz/x4yl0L2XUiVLJ9LIlw6p6y7y3hYtTZ3B1i1CfDm8n+AZcnivM2IO/
         e4975d04/c956qUC819qOe6V7OGtTpHlTasOean6lqtDY13B5hCebFUJwH4/gMAAuCPk
         WkMAgsRaoPds/d45l4HGmt92jKIPMmvNsFfgCFEju5svaLLghcIccXhOuNGX00n+YF+1
         QfbXzR91r3qhXjpwtlPicRDDyFMYOjrlz4LnQnhlET7J22atfuBBFw3jGgztGMSp3SOy
         Gmvg==
X-Forwarded-Encrypted: i=1; AJvYcCUb+zlWHfhjDnt4PfTEGVWEM7cyqtQ2Fk6hzQjaT1NilWVbiMLBk3GlO9b4OZJo4LCYhTdXJTS7JIfW+LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxIfvYfB3MzKRv9votY7l6d0nhOXogPjc0CXHgKdr/wB/mC/K
	d5ruX5tyqYiR5pfvaudlLNNaJZuHz3R1mP0YPUzVEcXf6IhLT+NppEytPwRteNuF83FmmTpNa02
	bfLudLaqfzUegen3KqAvOfQSncHKlwlckE6NU
X-Gm-Gg: ASbGnct7WIhSdS9ji7dCxsY3tqNfP1DBNQfWDjrCW2kVphV9y3uJ5z558q2wlXN/p6N
	ozPWSPcDb/L6zyaPtsaFq3aVruwEIgQ==
X-Google-Smtp-Source: AGHT+IGK1MAbWBO65ag8JQFr3JuHH7jl3Jlj6sjAdvMtG/HIraalYyXevkYEMF1iK+KsP8rtE3hLpD1JYNoji0HGzM8=
X-Received: by 2002:a05:6512:2214:b0:53d:e41a:c182 with SMTP id
 2adb3069b0e04-53e2c2c4b80mr111899e87.31.1733432312372; Thu, 05 Dec 2024
 12:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08f3bd66d7fc8e218bb6958777f342786b2c3705.1731554471.git.len.brown@intel.com>
 <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com>
 <f6621a09-d5e4-4d3b-9b5c-55294c22030f@rowland.harvard.edu>
 <CAPDyKFoJ45PZ_o6VdaCiyat+BC6XOZ5AMnxmsZVzk16cCxmDkw@mail.gmail.com>
 <CAJvTdKkqO5D8tZt3L_dbXkXftUOz+zijEjQiWHginn4t_o4gKQ@mail.gmail.com> <7c3c49e8-95fa-4382-a5bc-eccef6d89ed2@broadcom.com>
In-Reply-To: <7c3c49e8-95fa-4382-a5bc-eccef6d89ed2@broadcom.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 12:57:56 -0800
Message-ID: <CAGETcx8gG1_rRrt1fSJpY8c-J6RYMo5e2h_TSzg1FExu0Ge1pQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend()
 callback return values
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Len Brown <lenb@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:57=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 12/5/24 09:36, Len Brown wrote:
> > On Thu, Dec 5, 2024 at 10:33=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> >
> >> ...I also think this looks a bit risky as the current behaviour
> >> has really been there for a long time. Who knows what depends on this.
> >
> > If everything were working 100% of the time, no risk would be justified
> > because no improvement is possible.
>  > > But we run over 1,000,000 suspend resume cycles per release in our l=
ab,
> > and this issue as a category, is the single most common failure.
>
> But you are starting to enter the big number category here, eventually
> something is going to fail with that many iterations.
>
> How was this 1 million iterations determined to be a good pass/fail
> criteria and just not an arbitrarily high number intended to shake off
> issues? Surely with such a big number you start getting an idea of which
> specific drivers within your test devices tend to fail to suspend?
>
> FWIW, with the products I work with, which are mainly set-top-box
> devices, we just set a pass/fail criteria at 100k which is essentially
> assuming there will be 27 suspend/resume cycles per day for the next 10
> years, given the lifespan of the products, that seemed way overboard,
> realistically there is going to be more like 2-3 suspend/resume cycles
> per day.
>
> >
> > Worse, there is a huge population of drivers, and we can't possibly tes=
t
> > them all into correctness.  Every release this issue crops when another
> > driver hiccups in response to some device specific transient issue.
> >
> > The current implementation is not a viable design.
>
> Neither is this approach because it assumes that drivers that need to
> abort the system suspend call pm_system_wakeup(), which most do not,

Agree completely with Ulf and Florian. This patch series is way too
optimistic in thinking that all drivers are/should be calling
pm_system_wakeup().

I'd argue it makes more sense and is intuitive to return an error if a
device suspend fails and have the framework act on it immediately than
setting some global flag and then looking at a later point in the
framework.

Based on the rest of the emails in this thread, this seems more like a
driver problem than a framework issue. If you see a driver that's
returning an error when it shouldn't, fix it.

If you are testing this only on some specific set of hardware to claim
it works without problems, then you can also just go fix the drivers
for that specific set of hardware and call it a day. If that's "too
many drivers to fix", then the amount of untested drivers surely is
orders of magnitude more than that.

At best this should be a driver specific flag (why not just fix the
driver in that case) or a commandline arg that's default disabled.
Then whoever wants to use this sledgehammer for their hardware can do
so without affecting others.

-Saravana

> they return -EBUSY or something like that. There is a total of 12 or so
> drivers calling pm_system_wakeup(), that's not the majority.
>
> How about you flipped the logic around, introduce an option that lets
> you ignore the suspend callback return value gated by a Kconfig option?
> --
> Florian
>

