Return-Path: <linux-kernel+bounces-264976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A88A93EAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B102817D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226612BD04;
	Mon, 29 Jul 2024 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj4JMshJ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342403A1BF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217785; cv=none; b=EYE8HppnM124NYi95FuGgaai6bgBseIDSQlgJUBI11150zhiWZLU5CWcCa4Cq665NkLMtl/qL/bUau3Q8pjTZay6wVv+k+4fh7Aat05aWtMKz/J2PR21JAbv+/RanTqCws+gYaq0YneqWo8c+ZGm/53EFfsi6eJzrMQaOghO2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217785; c=relaxed/simple;
	bh=UUo6/dRq6l3OlDqJSzuo4MrvihPD4VajSaoYXEG8Bk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRCipKuENi4T/6GHavbEXVtHOvRB71dSOYwpjdUrEEq34BYOhI8fJMkQniK7sasxn4l/RzyTGOLLmKlyKVVAnFmD+o89HIC70mD5LNw3hrKUUrF3dASKK27BUYRn+t0VwbGphsDKg4cr5JSuwbI0sz4H5KWWkQJPtrlrBG4ilLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj4JMshJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso2125689a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722217783; x=1722822583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBNtM6HampY+wCLGFKyRWbvyF/WMXMtXmi68+imgPFw=;
        b=Uj4JMshJgJiCSJh44Wi0P+zwXPgRjFpiCnIdBDynYKOUIj7Gn0rm3JfD77o3DyVuRr
         gg4DpanTPaZDa6mVVKCFs/3lUAX0vfX1W7FHn1yHD2NmLC9k9Tvx24UuwDs7JqADEsTr
         b0754NUXT6wci5A2UxTFQ3DvkdY4B7eyRc3WPLkscX74IVfXYrUtfBVVOsAEvxpd/9fO
         OXmxulD7GDtU2ftCFWzaMvaOCrix44rtgNYn0DXXEN1C6DTdAERGLS+zCSBKInZDqmHa
         lY8K4Ju0LKJt7Q9VOgnNfp+TSQyqB2Pwjw5o6ZIyutU51TeRszltRcLeb7s+C95FMToc
         VBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722217783; x=1722822583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBNtM6HampY+wCLGFKyRWbvyF/WMXMtXmi68+imgPFw=;
        b=PQGJZUpibfOq59GiRzWohhXRiDtTZ+XHbnh4FwB4yMhCku43s9k51DeD5O4hPtRIUe
         VJHyMAZM0twIU3xFzV9VMLeFD48gz9uJv3hNUhPPE4qkRE9CblKavgfBWOb7L8TISWP2
         0vug/GkPhWH9/BShjlC1cy+bnjF33qeqw6SPHOlHpl8hR9/Oz9PCBVbUq8gAAjEmCeIL
         zSZwXzDNEAiaXQbZh3/l4uCH03ULKnCXnfuc11HJjX8OvrWyNpcdjgCuVmT2wnQgyX2J
         2ndg8zrzOo5K8tNg62og0WEnQs3z5g1NTuWOJSrf97cLoRZM/3IwUkUJF+iDz9bxh6Ar
         3/Kw==
X-Gm-Message-State: AOJu0Yw9rhx+naFihZe0Q7cqO/oHzmbjgs5xqKI2uCMUR6GSf69PvGBk
	RDUpUN6ljti18tR/QcxRStaoOpbrQD8bMMBJs2qNHBa9hfA3WxdU6Tht+ur7ODDyFYSI/vM0o1S
	VfeXUI7I4vyK8N44I+6sC+3H6+Ls=
X-Google-Smtp-Source: AGHT+IHozl/1sK3in4eQ2tK2K2fI7d7eyervMHZqsvMk3t5swzAHKK5bJDahvV3w1LjJMo9x5f4+6cq5pmROyRr8ILc=
X-Received: by 2002:a17:90a:6b4c:b0:2c9:7ebd:b957 with SMTP id
 98e67ed59e1d1-2cf7e1df0abmr6708433a91.11.1722217783320; Sun, 28 Jul 2024
 18:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621073225.3600-1-jiangshanlai@gmail.com> <20240621073225.3600-2-jiangshanlai@gmail.com>
 <87le1sjd2e.fsf@linux.ibm.com> <CAJhGHyCXYhfPX-_TivLP9rs8AYPnF8qBZKgp-4yZ-aJun6DHfg@mail.gmail.com>
In-Reply-To: <CAJhGHyCXYhfPX-_TivLP9rs8AYPnF8qBZKgp-4yZ-aJun6DHfg@mail.gmail.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Mon, 29 Jul 2024 09:49:31 +0800
Message-ID: <CAJhGHyAkGHAje0z89tW-NaXT_u7xgL_CT-4jJKRZn=XcNjLgKQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] workqueue: Reap workers via kthread_stop() and remove detach_completion
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Marc

On Thu, Jul 25, 2024 at 8:11=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.c=
om> wrote:
> > 2024/07/23 18:01:21 [M83LP63]: [  157.267727] ------------[ cut here ]-=
-----------
> > 2024/07/23 18:01:21 [M83LP63]: [  157.267735] WARNING: CPU: 21 PID: 725=
 at kernel/workqueue.c:3340 worker_thread+0x54e/0x558
>
>
> > @@ -3330,7 +3338,6 @@ static int worker_thread(void *__worker)
> >                 ida_free(&pool->worker_ida, worker->id);
> >                 worker_detach_from_pool(worker);
> >                 WARN_ON_ONCE(!list_empty(&worker->entry));
> > -               kfree(worker);
> >                 return 0;
> >         }
>
> The condition "!list_empty(&worker->entry)" can be true when the
> worker is still in the cull_list awaiting being reaped by
> reap_dying_workers() after
> this change.
>
> I will remove the WARN_ON_ONCE().
>

Here is the fix:
https://lore.kernel.org/lkml/20240725010437.694727-1-jiangshanlai@gmail.com=
/

Could you take a look please.

Thank you for the report,
Lai

