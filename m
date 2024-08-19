Return-Path: <linux-kernel+bounces-291764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F0395668A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872B41F232D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA615C15A;
	Mon, 19 Aug 2024 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zjzPWMPs"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0202148FE0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058828; cv=none; b=DqbT85Fj8XkyDZFqwjHORt//C2e4mKRmJQykmT+DF2ME+mOjet6bBXtufWDuiCcsKHsQpmUA5FyaWRoAO7mALW/T3/KasyqNMo7uyuzAM9DoFROQ2C1YjyGHs/bSDTLIyMYNTZkpJzgbVI6Wdp3Zr3jEWNYRokC71vCQZoi8ooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058828; c=relaxed/simple;
	bh=TtnJmSlrXyV6J/ni8WdY53wD6/CYK1VXWag9BG9YZ40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNYl/2JYeKuvAhxunOAFWq0ZPyD44ncK/OKi6WZeC3/cXHRVtpT9qkFd4uttGxWmv7iIH9cy4QJ+5fthPsgDQxHYI75rQ6f3xy/7UpYoB2mi8ss3JMlrD2yZn1eB8ozBeOOYRumPV/MT4Qc9E1MHOFgRZUE5YGwhjYn+BDqw4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zjzPWMPs; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso10074601fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724058825; x=1724663625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIMsl1ookSA1DyUgN8UuW8SMlUC0glIxT4g4JKXaVdU=;
        b=zjzPWMPsgTS5MAFE0rszbPO1O0PtIfXTff074GqJTRV9ANpBBLV1L8NxYo9LtdFK46
         VVK57WOWfH/6EW3ve6UyzOlxWs9rZODMrfKIbEliv04kA3oRtqBRgcJHefIyfiO/JsnJ
         fO4bGcqr78BVLwy3ZnZLZhwbQERfHeB1LDNnZzovK7J71vOTwS0FZjteOSaKT7hyxUDh
         57QtAnYjkCCyEj0/nAb59jZ5G1tyjfOD1N5taOKA0haVsivwsAfIdjPU2UbyLTdydtS4
         dOkIfQvwv95tpXxmLSQ/IArCdE/P74qgl8S73zskKfuVR1YZj07DS+UEFM4Z+1MPbSca
         INDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058825; x=1724663625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIMsl1ookSA1DyUgN8UuW8SMlUC0glIxT4g4JKXaVdU=;
        b=HPh2wNTQ3MYIGf13a7atk8+c9wSX3PZxKjdmNDDVPvRsCZ8MX9o0fVHry2cbfGLVFP
         JFXp8EjLd0h90Dl9U0Us7yX9fJW2p/whSbKPC4L3Ov/gMUqlzilYCTA+qUZHfo94qNjr
         InvoFPNlvNgSv7laitVHTq8388UL+H3e1TW66HxvR9/Z0pGsxjlx1cvr4AvySn8AGm3l
         0Qv9UOlkJfQAW2vQ+2xeqc+QcxKJZKKV0hk9WWRmqbjsL/NyXJV6p24okIo09BnJTGJZ
         gqbGvsNNpqAW049fX07gOfG6zop7XeehO/04u0tIe7z1cw3Ow8rKjOepROcEm61+/DLy
         hVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf1t9etO9YjpAUb5UO3AI5vMm9QywgXNF0QrcKCsC+E7ufEspUWqqaNPFKif1EvCNVbQ6gXG5TSgEwzM/DZ0iHxec/qJno0O+Ethch
X-Gm-Message-State: AOJu0YzZZ4htdHBwbv+9VpNozfM6we7WWpogimp6cKBzxJ6VEa4M9g9m
	FyxN2JZqpa49CS6h/sWb3TeK3Mjqz4TgWkq2o/pqDAkPWk3WcO9fO5fWE5mQExTGbNyirt0q911
	idS7o05ja5RXBgRv3gGKOYZV/OVb5loZrPjz5
X-Google-Smtp-Source: AGHT+IFOZG4WMA3ByLVTlGA87b7bgPZg8l2Jlfvs7m1bi8xHPKgfIE9xY9QB2B3aIl9fWxotTq3p7F1FeB2f8sINkIQ=
X-Received: by 2002:a2e:742:0:b0:2ef:2677:7b74 with SMTP id
 38308e7fff4ca-2f3be5f02eemr74527771fa.41.1724058824221; Mon, 19 Aug 2024
 02:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819082513.27176-1-Tze-nan.Wu@mediatek.com>
In-Reply-To: <20240819082513.27176-1-Tze-nan.Wu@mediatek.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 11:13:33 +0200
Message-ID: <CANn89iJ04bbS4iaB8dpgbtZTWF_JVt1JawwxFah16zN1aj3HWw@mail.gmail.com>
Subject: Re: [PATCH] net/socket: Acquire cgroup_lock in do_sock_getsockopt
To: Tze-nan Wu <Tze-nan.Wu@mediatek.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, bobule.chang@mediatek.com, 
	wsd_upstream@mediatek.com, Yanghui Li <yanghui.li@mediatek.com>, 
	Cheng-Jui Wang <cheng-jui.wang@mediatek.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:27=E2=80=AFAM Tze-nan Wu <Tze-nan.Wu@mediatek.co=
m> wrote:
>
> The return value from `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` can change
> between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
> `BPF_CGROUP_RUN_PROG_GETSOCKOPT`.
>
> If `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` changes from "false" to
> "true"
> between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
> `BPF_CGROUP_RUN_PROG_GETSOCKOPT`,
> `BPF_CGROUP_RUN_PROG_GETSOCKOPT` will receive an -EFAULT from
> `__cgroup_bpf_run_filter_getsockopt(max_optlen=3D0)` due to `get_user()`
> had not reached in `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`.
>
> Scenario shown as below:
>
>            `process A`                      `process B`
>            -----------                      ------------
>   BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
>                                             enable CGROUP_GETSOCKOPT
>   BPF_CGROUP_RUN_PROG_GETSOCKOPT (-EFAULT)
>
> Prevent `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` change between
> `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and `BPF_CGROUP_RUN_PROG_GETSOCKOPT`
> by acquiring cgroup_lock.
>
> Co-developed-by: Yanghui Li <yanghui.li@mediatek.com>
> Signed-off-by: Yanghui Li <yanghui.li@mediatek.com>
> Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
>
> ---
>
> We have encountered this issue by observing that process A could sometime=
s
> get an -EFAULT from getsockopt() during our device boot-up, while another
> process B triggers the race condition by enabling CGROUP_GETSOCKOPT
> through bpf syscall at the same time.
>
> The race condition is shown below:
>
>            `process A`                        `process B`
>            -----------                        ------------
>   BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
>
>                                               bpf syscall
>                                         (CGROUP_GETSOCKOPT enabled)
>
>   BPF_CGROUP_RUN_PROG_GETSOCKOPT
>   -> __cgroup_bpf_run_filter_getsockopt
>     (-EFAULT)
>
> __cgroup_bpf_run_filter_getsockopt return -EFAULT at the line shown below=
:
>         if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
>                 if (orig_optlen > PAGE_SIZE && ctx.optlen >=3D 0) {
>                         pr_info_once("bpf getsockopt: ignoring program bu=
ffer with optlen=3D%d (max_optlen=3D%d)\n",
>                                      ctx.optlen, max_optlen);
>                         ret =3D retval;
>                         goto out;
>                 }
>                 ret =3D -EFAULT; <=3D=3D return EFAULT here
>                 goto out;
>         }
>
> This patch should fix the race but not sure if it introduces any potentia=
l
> side effects or regression.
>
> And we wondering if this is a real issue in do_sock_getsockopt or if
> getsockopt() is designed to expect such race conditions.
> Should the userspace caller always anticipate an -EFAULT from getsockopt(=
)
> if another process enables CGROUP_GETSOCKOPT at the same time?
>
> Any comment will be appreciated!
>
> BTW, I added Chengjui and Yanghui to Co-developed due to we have several
> discussions on this issue. And we both spend some time on this issue.
>
> ---
>  net/socket.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index fcbdd5bc47ac..e0b2b16fd238 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2370,8 +2370,10 @@ int do_sock_getsockopt(struct socket *sock, bool c=
ompat, int level,
>         if (err)
>                 return err;
>
> -       if (!compat)
> +       if (!compat) {
> +               cgroup_lock();
>                 max_optlen =3D BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
> +       }
>

Acquiring cgroup_lock mutex in socket getsockopt() fast path ?

There is no way we can accept such a patch, please come up with a
reasonable patch.

cgroup_bpf_enabled() should probably be used once.

