Return-Path: <linux-kernel+bounces-382053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F99B086E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C3A1C22B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CFD158D9C;
	Fri, 25 Oct 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Tbf8574P"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76DB1422D4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870581; cv=none; b=D5JhzAqFwSxo8tqflTcnyTcra/Sc2bU2DOVKt0tBj5YHP3SwXDEZ0e5OvzeMdR6BwjG4UxwpejmNkK8BJ9DoapTZJ5vzvv/6JMxSpkQsmaXf8hhBrTUIv1q93ogwUJquY6IvVVI49WcRET8bC5EKz2Kzf7mWZVtQKuv+JsR/K1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870581; c=relaxed/simple;
	bh=WpdISieohoad+YNC6k2U8bM3/xsuQCOGp0WMuc/iLSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWQ8e+b+c5ycZNU9WgU17HHe5kqZDy7ettOZTQlT2OkkTi0AHmlDAXCUscf9JtJeNjppcudXHyN9SqxwOXWlwFba9ddKbHedDSBoi9prK6ZfPREShCWpsw5Vw4jSQrcflPKmCT4xkJS4OFGIzB3c0L2KFsFzTu7Yn0I/+vU5XrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Tbf8574P; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ECF463F29C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729870568;
	bh=Nx066kipOXLdYty/I8QCv4wA3g8dfnPUeu0/o7OwRfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Tbf8574PqanaYqeb+PZQK6jvW1Tv4IDhbpv2GBs0F03MxCd/2G+2Ft8ZNOvxQ7rgI
	 ABmIZzU9YXz064Fxv/QEymO9SAswHRfJFhDZqnbnXJvSTFjDp/rYQhcton3iVOnObA
	 i0B7LhZWNZkcCafp3dlDKFRvxkbTCGbMlmqH7akrvuzUICdOOl9ltW6mOoxdPwqFQ6
	 9sGRED8i+8iAPnq5l8bL5Pxx22HBf4LyWRbyHD1fS2j3ZU87gsIRlIyq3ksD8+vnbF
	 irRGdQvXKX01dmGxgvDHxFq0TkHLnfjwB61aje01BJI3XkzVpQimehwNdlL9/+8cpa
	 Rbdwgfz2FgRnQ==
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-84ffb72a4ffso503630241.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870568; x=1730475368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nx066kipOXLdYty/I8QCv4wA3g8dfnPUeu0/o7OwRfY=;
        b=WI/RecgAWphiqwP/wEjHfoSANOOUs0U2fNbyoXDuywRZ1ZH7efIeFh9uKpNb+o+H6M
         RFO7FQZaYP4Jy958m7yXDWej4PAPgtdRsWEv6cpQ8p+FLK0DFuoFIwEITfJqqq3vau9W
         fFHU4f3DlldOztl+vL2dHVhTLFpOnh+Nyu6hSoxtaLdpxIgU9ExKqY6qF5li/jUqLq2d
         z7d/hvKp/RGu1qpUcR1E9Yyq7f4Ywz3EFZbtx7Qx1DrbKha7QPBbZqDbbZHm5675z/G1
         /n5NkdHsdfxUVSGxLBspJ1pGU1b242gIf0G+T8P1ixZPlywwg5QnHzB7TzctzAnMtIOw
         P15A==
X-Forwarded-Encrypted: i=1; AJvYcCUdjsY98XLc9kfUDPvdmYpOhk1o4Jouz/yVlyt6YNbYaneVHfL8iQILkjCx4JeH3jph7/Skn1tJn8FP+lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWxwNA3QfPsg+6pDPYGKDuKVoVZVRbLhgJwRQ/QsGXb6g0UIeh
	94W/uFW9ura2YMPjaQRYiTVDPGqvEU4O9duykgm1TGCxej6b7lNm+eSdXeo3LzVRKtpf4CemuE/
	RjaFeD3LiiHxWXzlRsza0fOuKzEaxSEM9DbsSBZSj+fyjMqnBX9DBU7fjo4/emwn4vf3m+RHRxn
	86swZEfPoOiP6RVMB8YrOFhsCku39QjldEjFmdSIVMd6nMZw+lBpgB
X-Received: by 2002:a05:6102:955:b0:4a7:4900:4b83 with SMTP id ada2fe7eead31-4a751c0b89cmr12865636137.15.1729870567824;
        Fri, 25 Oct 2024 08:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL6anytCtSqtUoB0Uwyr/P37dCM5OWnRmQOOry0BHRuplM4Se/SmcNOo7+2LVdnrGxSEtFihZsZRmyRH/31Fo=
X-Received: by 2002:a05:6102:955:b0:4a7:4900:4b83 with SMTP id
 ada2fe7eead31-4a751c0b89cmr12865594137.15.1729870567415; Fri, 25 Oct 2024
 08:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017102138.92504-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20241017102138.92504-1-aleksandr.mikhalitsyn@canonical.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Fri, 25 Oct 2024 17:35:56 +0200
Message-ID: <CAEivzxdUC=R1oTdrwRDdrfdU7AUcRdTQum_cUUt__Zvi6xr+3w@mail.gmail.com>
Subject: Re: [PATCH] sched/cpuacct: show only present CPUs to userspace
To: mingo@redhat.com
Cc: James Morse <james.morse@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Gavin Shan <gshan@redhat.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, Simon Deziel <simon.deziel@canonical.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

On Thu, Oct 17, 2024 at 12:22=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> After commit b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CP=
U_DEVICES")
> changed which CPUs are shown in /sys/devices/system/cpu/ (only "present" =
ones)
> it also makes sense to change cpuacct cgroupv1 code not to report CPUs
> which are not present in the system as it confuses userspace.
> Let's make it consistent.
>
> A configuration when #(present CPUs) < #(possible CPUs) is easy to get wi=
th:
> qemu-system-x86_64
>         -smp 3,maxcpus=3D12 \
>         ...
>
> Cc: James Morse <james.morse@arm.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Simon Deziel <simon.deziel@canonical.com>
> Closes: https://github.com/canonical/lxd/issues/13324
> Co-developed-by: Simon Deziel <simon.deziel@canonical.com>
> Signed-off-by: Simon Deziel <simon.deziel@canonical.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
>  kernel/sched/cpuacct.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> index 0de9dda09949..0f07fbfdb20e 100644
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -213,7 +213,7 @@ static int __cpuacct_percpu_seq_show(struct seq_file =
*m,
>         u64 percpu;
>         int i;
>
> -       for_each_possible_cpu(i) {
> +       for_each_present_cpu(i) {
>                 percpu =3D cpuacct_cpuusage_read(ca, i, index);
>                 seq_printf(m, "%llu ", (unsigned long long) percpu);
>         }
> @@ -247,7 +247,7 @@ static int cpuacct_all_seq_show(struct seq_file *m, v=
oid *V)
>                 seq_printf(m, " %s", cpuacct_stat_desc[index]);
>         seq_puts(m, "\n");
>
> -       for_each_possible_cpu(cpu) {
> +       for_each_present_cpu(cpu) {
>                 seq_printf(m, "%d", cpu);
>                 for (index =3D 0; index < CPUACCT_STAT_NSTATS; index++)
>                         seq_printf(m, " %llu",
> --
> 2.34.1
>

