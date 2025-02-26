Return-Path: <linux-kernel+bounces-533544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE0BA45BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 240EE7A3180
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC272459D4;
	Wed, 26 Feb 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acRHnWda"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75B2459C4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565900; cv=none; b=pk1xH1M3iOTRS7Egm+K6gHzFpQm2fIPApKujAXQqP42MMJl0n3p1vySo/HDLMWM2a8Ti2utVcaIg04gqlbqM06TYk7g2TRmVgiWXWeAhfPJh3AuIfY5hrd1+1DFGs4s1J99LQm85ZUt48oY+H/yCyHlTNpiwJCmgbwYmyqDI/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565900; c=relaxed/simple;
	bh=eE6TEDJjEUVFfIcxM8iKB9praMK7xTPiqSf/9sV1pC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AShvuJ2Vwvu6cV/N3m3jrv3/kpgKtWG5Xj4JJsd+6KeTTMMYzPGreB7yo1Vx+nZu5sq7Gekxnmm4g8tb/SWAhB8MK7ldR2reIbRD+4PBQ8CDwOLfjy5nKcxHe9cTjVtoMQ9DKMwuGd2xyGI59biZdsWxrL0tOZwbqx7xIOkPvrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=acRHnWda; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb81285d33so154198066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740565896; x=1741170696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YuDC37Jw+Zolzu5V30KigWgIEI9SejHaSTwT5Rkex4=;
        b=acRHnWda/Z+QO80DeZpxs2wq9NcRC9nQF845v45rzVYX5WKaM7mxKypjh5wsKPz/F1
         fXluH1LfTciao71Gcez7vuoNGBbL8I00Qmp8CouPqJFKpLNlAQXPr3ze0ec0TveCcBNu
         jstDLj6/E3+J1IXRwYutyGcxj79fYh4TGEnvKxxoZn/oJ/dRVHDWOeYkviMyYwTERfN/
         AOJ04Mu6f9egCoeEkm0qoPjpb3G22hWYhNlAA8kpP9ri99UyUHeUhGJw1RzlJU8To875
         y2NuD7Lj1bQ/ZLN0/VPrbZ61b+V3XqV75w2Tv8qhFM8Qcw9pZ2Uybc53LODVuYHN1YZ0
         SNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740565896; x=1741170696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YuDC37Jw+Zolzu5V30KigWgIEI9SejHaSTwT5Rkex4=;
        b=I0ZXDIvPJGObRVO4HhictKqxt1FZu1fmRCrYAfaHkGzPr5ZPhGRL2rdGwaoboQ7LCj
         vRGUq4CRJxKyokrNntByLNejiFAvjES83WNs/i+uyASOSXh8JVnBEGX4I7orw5CDXnJR
         sJ+gGctf98xHXQnKz+caknOSd+pnO+aNk2CXaOze9RXRLtJNtFGGlmgFuaCvmy6frSeI
         Z+MbR7CQy4gMjA5MixJ3lkMJY4xC69CJ29drCR7Zv/nMS51Tz6598SlinbN8+rQEwyTZ
         HZ0KB+y/YpP/g7trWpD3Gwunlo9XDkRRTiLJWeMZDjrRSRjuZKh8dJAIaMXJ4+UMpv6p
         APDw==
X-Gm-Message-State: AOJu0Yz002WuVq+So0CwZdvXVZAn7HmKg3xKurWIbxfJtrRKwPcTzytp
	gUPo0BM2MtFL2xcl5Bv87XNmnhaz2A/M6MuwbtNJpa6tXIxwTUwkDAmUOiy6z8BoIP8JWc+LBzF
	cImY0NY8mJt5oFPiZFUx6pCyoM+6JzWAcINbZ
X-Gm-Gg: ASbGncv/WzulDbzZCbz8J2DtK0n8IEeFNEkRcD/ygztcJuTecVKrYyStxNZiTQJeqyx
	68ylygdqlS1gk1dNdsn8hZw7qPERVl1zU5pzDR5FP4M+LAkNC/oDsh0YT6+ziiRzSGcdWEqEQXv
	kiYy9SAzU=
X-Google-Smtp-Source: AGHT+IFAtFSzX90h2Iaz5b1UCMdYq9wwFG9cA0Om7iVgOoxBp3Dkrx+53LsEBr0LX2IvgijhMM8CQeoEfn63itsLTZU=
X-Received: by 2002:a17:907:6ea2:b0:ab7:b072:8481 with SMTP id
 a640c23a62f3a-abc09c1a63dmr2056837866b.45.1740565895517; Wed, 26 Feb 2025
 02:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223221708.27130-1-frederic@kernel.org>
In-Reply-To: <20250223221708.27130-1-frederic@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 11:31:24 +0100
X-Gm-Features: AQ5f1Jrx9yGutHY5PqKi7Fh2IVQ9c2aE4kyGGSpHRcRgB13e9kVMxTBIFM7KXuw
Message-ID: <CANn89iLgyPFY_u_CHozzk69dF3RQLrUVdLrf0NHj5+peXo2Yuw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: Handle napi_schedule() calls from non-interrupt
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Francois Romieu <romieu@fr.zoreil.com>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Joe Damato <jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:17=E2=80=AFPM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> napi_schedule() is expected to be called either:
>
> * From an interrupt, where raised softirqs are handled on IRQ exit
>
> * From a softirq disabled section, where raised softirqs are handled on
>   the next call to local_bh_enable().
>
> * From a softirq handler, where raised softirqs are handled on the next
>   round in do_softirq(), or further deferred to a dedicated kthread.
>
> Other bare tasks context may end up ignoring the raised NET_RX vector
> until the next random softirq handling opportunity, which may not
> happen before a while if the CPU goes idle afterwards with the tick
> stopped.
>
> Such "misuses" have been detected on several places thanks to messages
> of the kind:
>
>         "NOHZ tick-stop error: local softirq work is pending, handler #08=
!!!"
>
> For example:
>
>        __raise_softirq_irqoff
>         __napi_schedule
>         rtl8152_runtime_resume.isra.0
>         rtl8152_resume
>         usb_resume_interface.isra.0
>         usb_resume_both
>         __rpm_callback
>         rpm_callback
>         rpm_resume
>         __pm_runtime_resume
>         usb_autoresume_device
>         usb_remote_wakeup
>         hub_event
>         process_one_work
>         worker_thread
>         kthread
>         ret_from_fork
>         ret_from_fork_asm
>
> And also:
>
> * drivers/net/usb/r8152.c::rtl_work_func_t
> * drivers/net/netdevsim/netdev.c::nsim_start_xmit
>
> There is a long history of issues of this kind:
>
>         019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_s=
chdule()")
>         330068589389 ("idpf: disable local BH when scheduling napi for ma=
rker packets")
>         e3d5d70cb483 ("net: lan78xx: fix "softirq work is pending" error"=
)
>         e55c27ed9ccf ("mt76: mt7615: add missing bh-disable around rx nap=
i schedule")
>         c0182aa98570 ("mt76: mt7915: add missing bh-disable around tx nap=
i enable/schedule")
>         970be1dff26d ("mt76: disable BH around napi_schedule() calls")
>         019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_s=
chdule()")
>         30bfec4fec59 ("can: rx-offload: can_rx_offload_threaded_irq_finis=
h(): add new  function to be called from threaded interrupt")
>         e63052a5dd3c ("mlx5e: add add missing BH locking around napi_schd=
ule()")
>         83a0c6e58901 ("i40e: Invoke softirqs after napi_reschedule")
>         bd4ce941c8d5 ("mlx4: Invoke softirqs after napi_reschedule")
>         8cf699ec849f ("mlx4: do not call napi_schedule() without care")
>         ec13ee80145c ("virtio_net: invoke softirqs after __napi_schedule"=
)
>
> This shows that relying on the caller to arrange a proper context for
> the softirqs to be handled while calling napi_schedule() is very fragile
> and error prone. Also fixing them can also prove challenging if the
> caller may be called from different kinds of contexts.
>
> Therefore fix this from napi_schedule() itself with waking up ksoftirqd
> when softirqs are raised from task contexts.
>
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Reported-by: Francois Romieu <romieu@fr.zoreil.com>
> Closes: https://lore.kernel.org/lkml/354a2690-9bbf-4ccb-8769-fa94707a9340=
@molgen.mpg.de/
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Francois Romieu <romieu@fr.zoreil.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 80e415ccf2c8..5c1b93a3f50a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4693,7 +4693,7 @@ static inline void ____napi_schedule(struct softnet=
_data *sd,
>          * we have to raise NET_RX_SOFTIRQ.
>          */
>         if (!sd->in_net_rx_action)
> -               __raise_softirq_irqoff(NET_RX_SOFTIRQ);
> +               raise_softirq_irqoff(NET_RX_SOFTIRQ);

Your patch is fine, but would silence performance bugs.

I would probably add something to let network developers be aware of them.

diff --git a/net/core/dev.c b/net/core/dev.c
index 1b252e9459fdbde42f6fb71dc146692c7f7ec17a..ae8882a622943a81ddd8e2d141d=
f685637e334b6
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4762,8 +4762,10 @@ static inline void ____napi_schedule(struct
softnet_data *sd,
        /* If not called from net_rx_action()
         * we have to raise NET_RX_SOFTIRQ.
         */
-       if (!sd->in_net_rx_action)
-               __raise_softirq_irqoff(NET_RX_SOFTIRQ);
+       if (!sd->in_net_rx_action) {
+               raise_softirq_irqoff(NET_RX_SOFTIRQ);
+               DEBUG_NET_WARN_ON_ONCE(!in_interrupt());
+       }
 }

 #ifdef CONFIG_RPS


Looking at the list of patches, I can see idpf fix was not very good,
I will submit another patch.

