Return-Path: <linux-kernel+bounces-261600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CC493B9B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D5B2831C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E2A7FF;
	Thu, 25 Jul 2024 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8eKLpW1"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A03181
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721866308; cv=none; b=Jtqcx2avHmWBlzAJW6gu6MZTAG6YpKCjz0FDYlZGHYF3fpHNtLCt4uhW8JHgDssp+gQQtSTtN3R3TtnHAPs7Wut5XODr/PKrCBUXQLK2I5IvoW7LMXz/7OorqyyCblYyGOLnW/Tebx5GfxVGhSny2TCLAAkrTHvzQSXWAlu56EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721866308; c=relaxed/simple;
	bh=DnoRRbnk09b0B8+1qooGyYGkdWOHvoZ1oCvjxyFBrdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgBts2KXga6R1A/r6YSgo20ioTSQodWqTjGvLFAaBr9OyGDfsq4VumzLJ9lwnd8QKz1+JooaRp3A33N1zBkAd0rBdX5AwIarPpmUCcUtjsIoNaK8DV2tlDzOmfBbuQwRPWjzfOb0g/Jfx4cn4VBxI0G7pdRvs0qVs1tcmTLgboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8eKLpW1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2caff99b1c9so274715a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721866306; x=1722471106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZXhqa1DQ3bCazASLlqpaBv4zjXIIaPzDkd+EFR7iuY=;
        b=K8eKLpW1YP7YnBp1UH2yzHoyJQ+HvtD1Eo02TItCSfWAYaz/LfbHRDYTKhLzRo6ekF
         AGZPxFkyPwtqlxG30rFixLGcF8yaayvGpn4o1C6w+4a6iS6kaZ9cTrufACitNALuiBc1
         ufIzJ5Xy5VgjDkiqyoW65Lbm2cyedDLdjslbxiFWdkChrI4Nj5efQMxUDS1Hz6WphVwI
         J+kWVPiaEWoaTm/yPVbWz7NcawaiSCmGGFgawqBWJlbidwvlvjmT9Y0gs8mY+aVfeFtM
         hsWMQzZ686DxdRKMqoIwJiOyHFXRe+uDTc+2iXyoThHPPve/vH4ThGk2Z9MUNSOj7OGR
         TiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721866306; x=1722471106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZXhqa1DQ3bCazASLlqpaBv4zjXIIaPzDkd+EFR7iuY=;
        b=TTLsB18JTgi+Ky3wLDUOVt01a7P6KnO4JUKXJgENo6sSs2cxpHZ9RPv+6jb8IdGfrS
         mOtRQSdP0w8bxZWpf/QgAsHjOf8aSdOrJZd5T5UFiaRen2o5RWl7PhAaGmLU3NeZ+Q90
         elhE1fVkJxDGk9pTD6x1Ke9w9qs24vRsCN9GBOjbYrNy1kc1FQ/UsPVjC/XVh0MeBN2y
         zewBgIfZnJXc9jC9ZnopDjkWERgZq9qq2PEWSaeuOXctWdWcsESiOGukKraLmS1/6/Jm
         XrD8rqjApD18n1PBG0KamYV7V6nnGVCPznpq0CdNZ0N3F59iWc0aLE9+cxvBDXqOgXw0
         aeqA==
X-Gm-Message-State: AOJu0YxuoPAKOotTCu4GG3HZurfcqGnXIn7sBwY4VQ5E+ny732wRO/WR
	8gpscxZKJCHjCxo4l3KRArxmdBEaGU16sx/NVQFqUkPJP0v9fpFcjO9Iq/XgZITpt2oYDPHZ2W9
	2bvd3yL5pF2qRW4D43TuYDBjJj8Q=
X-Google-Smtp-Source: AGHT+IEuFi9W/T4IUh5eBaExnLaq7VjDRJJ/QfKQu9HtmAUc8fJ/3+EvOykTSHZIJA3TZ5M3zV61Cp2L4wRJwr9TxT4=
X-Received: by 2002:a17:90b:1052:b0:2cb:674b:8b20 with SMTP id
 98e67ed59e1d1-2cf2eb04531mr143238a91.31.1721866306200; Wed, 24 Jul 2024
 17:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621073225.3600-1-jiangshanlai@gmail.com> <20240621073225.3600-2-jiangshanlai@gmail.com>
 <87le1sjd2e.fsf@linux.ibm.com>
In-Reply-To: <87le1sjd2e.fsf@linux.ibm.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 25 Jul 2024 08:11:34 +0800
Message-ID: <CAJhGHyCXYhfPX-_TivLP9rs8AYPnF8qBZKgp-4yZ-aJun6DHfg@mail.gmail.com>
Subject: Re: [PATCH 1/4] workqueue: Reap workers via kthread_stop() and remove detach_completion
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Marc

Thank you for the report.

On Wed, Jul 24, 2024 at 12:19=E2=80=AFAM Marc Hartmayer <mhartmay@linux.ibm=
.com> wrote:

> Hi Lai,
>
> a bisect of a regression in our CI on s390x led to this patch. The bug
> is pretty easy to reproduce (currently, I only tested it on s390x - will
> try to test it on x86 as well):

I can't reproduce it in x86 after testing it for only 30 minutes.
It can definitely theoretically happen in x86.

>
> 1. Start a Linux QEMU/KVM guest with 2 cores using this patch and enable
>    `panic_on_warn=3D1` for the guest kernel.
> 2. Run the following command in the KVM guest:
>
>   $  dd if=3D/dev/zero of=3D/dev/null & while : ; do chcpu -d 1; chcpu -e=
 1; done
>
> 3. Wait for the crash. e.g.:
>
> 2024/07/23 18:01:21 [M83LP63]: [  157.267727] ------------[ cut here ]---=
---------
> 2024/07/23 18:01:21 [M83LP63]: [  157.267735] WARNING: CPU: 21 PID: 725 a=
t kernel/workqueue.c:3340 worker_thread+0x54e/0x558


> @@ -3330,7 +3338,6 @@ static int worker_thread(void *__worker)
>                 ida_free(&pool->worker_ida, worker->id);
>                 worker_detach_from_pool(worker);
>                 WARN_ON_ONCE(!list_empty(&worker->entry));
> -               kfree(worker);
>                 return 0;
>         }

The condition "!list_empty(&worker->entry)" can be true when the
worker is still in the cull_list awaiting being reaped by
reap_dying_workers() after
this change.

I will remove the WARN_ON_ONCE().

Thanks
Lai

