Return-Path: <linux-kernel+bounces-184371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32F08CA636
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA5F1F2228F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3636B10A1A;
	Tue, 21 May 2024 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxHIaNQn"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA428FC
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258859; cv=none; b=Y8h9E9vWZBIuR/OZ84UEjj6wDFV/pIDZYAGrzWtGG+Nyg47A9asR/bme0SmtUVbncfQsUO9tPtGh9qMHXz0wut/CrFkHPzzozp3mSLcMHGlIcj2SREUJ5bQPz09JMK/LSWnEWAoHJsI7zvlNaD07YmmebvGf56X1w8X25pztta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258859; c=relaxed/simple;
	bh=UuOcM4yXXKH9kiRYc4ONl3OrkP8Y+eilGhPsOSUwRYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOWAk7Rbo61eDB1m4XdbKFKQDJapqKTtj4/zN1P8exK4KB9ETiRrdwLE9mtGDU40mSSWjPty9vIvQPrI78KA23SPXJH0qQ6ktvJwieV5nbIcm2/CmFxBDfI+6qBcF5nnN0cUj6iZSLF3CBKukB/t1dr0vTPUGOaOsQaA74C2A9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxHIaNQn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6a077a861e7so27662996d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716258857; x=1716863657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdN7nsvVB6FOZQ0AKh9nuQvNlEhhIX+Bl8dWGYeyTw0=;
        b=FxHIaNQnkwOtH7LRRrRorVrChBpc82pO172lYXtvTVDn/iJh3z7Y7E/txGw1hFfHNJ
         oiOtS3a34z8xxJAYHs5L7PXd9MmtqmR8TbBPMqpEW6HuvP0U5zDVvKEpfX+4IJDfT5/M
         ppgSSzL7dleKz6tBDDvSURmt9wSgZP0cjyU1Aoop2D8i9WCSCvdyTLyTR7h3ukEGDgpd
         qFN3BUJWHy7IVQzNs94hpLB7JuW63HmVqHzMxf8jyw55jLCZQcW93IbHw69rX0hDumVS
         v/s+kHpvZ5ManQObYDOAqPi8racIfx96qm87zuB5pHuiwlMw0XVD/Z3jaXfddlMzrn2X
         U4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716258857; x=1716863657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdN7nsvVB6FOZQ0AKh9nuQvNlEhhIX+Bl8dWGYeyTw0=;
        b=V4y41j6UEYcKmPPBCF0+VKkzXdCpa4wFxhsx0eP+7mHi9Tm9l8Z41V9Mj9g4AoMusK
         iDSRMS0rFE4oXp+e0u093d4lFdUcDCIEtwIrxAaOP7qob8d37JNH3tO25rulcB6xmq74
         gZcUFxg1okF6QSuQIn+/Zb3WNYU65Jk555q0fzZIMJgMVHwNeJms5/2XwjqSkQyfTXwv
         bTbHMlu4sqivICZIR+Qp6Eak/3Tc4a6Sy0AMpXVeXKKiLQuRYgG1rkWpEt/G94QxFO4/
         WyNeY5Kq7TkwO492Tnwo3gw+0t+3d+OfTDZ6Znn9/WwzRelzVp1m3+cCLAi/Z5Ex+z7M
         FEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyJpv0iwUH1RDgxLU/Zu8Oo0JICcJ2MlA+sRxR+xuCD84WjvOACzNiUmJFwchclxWggZMKtPEUjxgb39q6tTWOCxh2rihcf+ybfeur
X-Gm-Message-State: AOJu0YzRv0ktYRDhXy0CW3qbNtgnT0MmrC4Umh5f5EFLzIIzx2dVxaAV
	UmC/JxCuXyU0bKyCLME803IhJYR9KoEgebzy4Y4JwqYLefGhxSpTIfKKbuAGtcjX69y60uI1tMQ
	BKl4MnOcVdWsEeVVgC6pYv5+0Bbg=
X-Google-Smtp-Source: AGHT+IGI+EJHth3yDwTRb7CYKh2urjAuw0u2gmHzvYHvj3/ml9gzggM9N5cUyZTXUSBMMvmE4Voj/wNDpTkPgMVzdNE=
X-Received: by 2002:a05:6214:3386:b0:6aa:c84c:4c06 with SMTP id
 6a1803df08f44-6aac84c4d66mr42671226d6.0.1716258856816; Mon, 20 May 2024
 19:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org>
In-Reply-To: <ZkvO-h7AsWnj4gaZ@slm.duckdns.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 21 May 2024 10:33:37 +0800
Message-ID: <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jan Engelhardt <jengelh@inai.de>, 
	Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 6:30=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Currently, worker ID formatting is open coded in create_worker(),
> init_rescuer() and worker_thread() (for %WORKER_DIE case). The formatted =
ID
> is saved into task->comm and wq_worker_comm() uses it as the base name to
> append extra information to when generating the name to be shown as.
>
> However, TASK_COMM_LEN is only 16 leading to badly truncated names for
> rescuers. For example, the rescuer for the inet_frag_wq workqueue becomes=
:
>
>   $ ps -ef | grep '[k]worker/R-inet'
>   root         483       2  0 Apr26 ?        00:00:00 [kworker/R-inet_]
>
> Even for non-rescue workers, it's easy to run over 15 characters on
> moderately large machines.
>
> Fit it by consolidating worker ID formatting into a new helper
> format_worker_id() and calling it from wq_worker_comm() to obtain the
> untruncated worker ID.
>
>   $ ps -ef | grep '[k]worker/R-inet'
>   root          60       2  0 12:10 ?        00:00:00 [kworker/R-inet_fra=
g_wq]
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Jan Engelhardt <jengelh@inai.de>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> (cc'ing LKML and Lai)
>
> On Mon, May 20, 2024 at 10:17:00AM -0700, Linus Torvalds wrote:
> > Oh well. I suspect this would be trivial to fix. I think the
> > get_kthread_comm() should use the full name, and only *then* attach
> > the extra worker pool information if it exists..
> >
> > Tejun?
>
> Yeah, looks like even the unbound worker IDs are getting truncated on lar=
ger
> machines. This patch should fix it. I'll apply it to wq/for-6.10-fixes so=
on.
>
> > Also, independently of the WQ worker issue, I do think we could
> > possibly expand TASK_COMM_LEN a bit more. 16 bytes is too short for
> > user-level names too, and while it's seldom used for 'ps', it's
> > visible in things like oops messages etc where it gets truncated.
>
> That'd be great. ISTR this being discussed a while ago. Am I imagining th=
at
> we were going to raise this to 32?

We discussed extending it to 24 characters several years ago [0], but
some userspace tools might break. Therefore, we ultimately decided to
dynamically allocate the kthread's full name instead[1].

[0] https://lore.kernel.org/linux-mm/20211101060419.4682-1-laoar.shao@gmail=
com/
[1] https://lore.kernel.org/linux-mm/20211120112738.45980-1-laoar.shao@gmai=
l.com/

