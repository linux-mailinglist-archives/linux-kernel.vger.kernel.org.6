Return-Path: <linux-kernel+bounces-299461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3515195D500
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1131C227EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654B7192B9E;
	Fri, 23 Aug 2024 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTVHf8za"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF571925A1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436875; cv=none; b=HRt9JIWTQStLAsrv4eyTmuniRAYvsStwhYI9fdZsKdbxQrvpRwikzrV1QE33jSy4UNl0JvhcLIOE/+zUtcgqDVxgNjyWwz9SYvL4SQvI4UxbeeV9M4C9LzsWNN2JXNu+hkywpKqXYSMytI8GOd74MbO9SLQy13I5nJ2SNAgFbDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436875; c=relaxed/simple;
	bh=8sw5V/0Vx/AqF9UlgQYKp+MNUgO9dz7166zLYZ/mMJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgiuTkP5iQTd/fR21xAOc0M3FP+3eR5YMYUfm+M5xaziMHLEMd3mQlCOZzAXej6p86nSgYUmy1kx84TGxaPSlhH9Kzj2zCLXIrmnKkbQpWynuu7sV2/omdVLcw6b0S9iBvQg+ZUGeRaj8GihH0ujzlLmn41SP+o3ruQ2WNcxpEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTVHf8za; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bed83489c3so2912382a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724436870; x=1725041670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPsPFCSnkfLRuqb2lViYWuaO6obf1zZLalxAD4al8RI=;
        b=RTVHf8zaiWyQFfBt5AxW6vyVV1W922CDGQYc5FjpdDLyLBrCLmjL0citjoZ4eAdKJv
         PJXcJ0Ft+KPy2R+jELZuW43QCdvFkEMWEZZo0gGZdrMcLgbCwkNaW2+NdhFkvn5pLVkD
         GUXa/FLbgQjx0P/J7s+WfNNrrvnFe5SM5UJR8Nt1HNlcRnYJUtKsK8jeJCR/LSpL4jjA
         5Y5b6kaGFU1/cWxDopCuBrV2LsJv1QatIDHnFWRRCT/ylAiRxTqQITvzaT46qQHDdPf3
         pQ5fnSGrhXUlSqKzIoE5fFXbJEsnq1fvXVh9b0zo5ne2pENdj92EhgfT2zaCK4RhquRO
         ZoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436870; x=1725041670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPsPFCSnkfLRuqb2lViYWuaO6obf1zZLalxAD4al8RI=;
        b=WFFZA8MgRsYdhOTzGVBPzjwIIA06S/zFfqOlir3ezdTAmGwCBN9gMtxaWr+VRNK1Tn
         oYMT9sbWU7EvCAM3stq8CSSKJ2IsoPXEsDNR7gWEcxDNHrUmzttNy+fO3UgIgNJTCHOc
         1B+GIrNug/oWNYlcOCNQQY1ti9OAChpSLBLi0CeG6EZu4uB3d8bc9VejtdkvZFP9FD0m
         BQ/ZZzgIn1hmiFvwbr4tz/JNTQKnL5+ygRC/WIAjPPz4m/d2L0Bmq9XPru8ggBTrwr/L
         ljrtq0R95LDQydBtw8r+o0sZPq/m2y9qNudbRY/1d2FTkeRAJZEwe2hGFNsOXjhjsoB7
         57mg==
X-Forwarded-Encrypted: i=1; AJvYcCUrQOntcPOm9sJZORUBdGVuJ6DBNYNh4LmqjijUfPwoYHaRDNnCgu3QNaowAfrFVTqZ6RqwwPPiWTONzB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBGhCCbweDKBsASwIdnfINHYd6lyaw0ItIH+YBthSHwTHwZ0oV
	oBSUyoYtZH9jGnzknbZzRSSL7oFvVpbgczdAVbDXtGqrM/s6u2YwXCJlFPQ7tns7cQtRgZ05J8F
	PJC9qHii0TXVsogFxNBretCIz5bf9rVdk1O9w
X-Google-Smtp-Source: AGHT+IHI9iChs+Rn7N7bDCiBPQMF9/kIK84pt8uRhLLLH7DgiUJitPd5/GOyga+aOHKTzhTfZ/A8EP7BjMfFnsX2uPk=
X-Received: by 2002:a17:906:6a1e:b0:a80:f7d8:5bbe with SMTP id
 a640c23a62f3a-a86a4e6209bmr189615166b.0.1724436869350; Fri, 23 Aug 2024
 11:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823173103.94978-1-jdamato@fastly.com> <20240823173103.94978-4-jdamato@fastly.com>
In-Reply-To: <20240823173103.94978-4-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Aug 2024 20:14:18 +0200
Message-ID: <CANn89i+Ryar9QPL+PCw8P4Q9Wy8U1S1+q1J+_V4E0qYu3cLnUQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] net: Add control functions for irq suspension
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net, 
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org, 
	willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com, 
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 7:31=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> From: Martin Karsten <mkarsten@uwaterloo.ca>
>
> The napi_suspend_irqs routine bootstraps irq suspension by elongating
> the defer timeout to irq_suspend_timeout.
>
> The napi_resume_irqs routine effectly cancels irq suspension by forcing
> the napi to be scheduled immediately.
>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>  include/net/busy_poll.h |  3 +++
>  net/core/dev.c          | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> index 9b09acac538e..f095b2bdeee1 100644
> --- a/include/net/busy_poll.h
> +++ b/include/net/busy_poll.h
> @@ -52,6 +52,9 @@ void napi_busy_loop_rcu(unsigned int napi_id,
>                         bool (*loop_end)(void *, unsigned long),
>                         void *loop_end_arg, bool prefer_busy_poll, u16 bu=
dget);
>
> +void napi_suspend_irqs(unsigned int napi_id);
> +void napi_resume_irqs(unsigned int napi_id);
> +
>  #else /* CONFIG_NET_RX_BUSY_POLL */
>  static inline unsigned long net_busy_loop_on(void)
>  {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 74060ba866d4..4de0dfc86e21 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6507,6 +6507,39 @@ void napi_busy_loop(unsigned int napi_id,
>  }
>  EXPORT_SYMBOL(napi_busy_loop);
>
> +void napi_suspend_irqs(unsigned int napi_id)
> +{
> +       struct napi_struct *napi;
> +
> +       rcu_read_lock();
> +       napi =3D napi_by_id(napi_id);
> +       if (napi) {
> +               unsigned long timeout =3D READ_ONCE(napi->dev->irq_suspen=
d_timeout);
> +
> +               if (timeout)
> +                       hrtimer_start(&napi->timer, ns_to_ktime(timeout),=
 HRTIMER_MODE_REL_PINNED);
> +       }
> +       rcu_read_unlock();
> +}
> +EXPORT_SYMBOL(napi_suspend_irqs);
> +
> +void napi_resume_irqs(unsigned int napi_id)
> +{
> +       struct napi_struct *napi;
> +
> +       rcu_read_lock();
> +       napi =3D napi_by_id(napi_id);
> +       if (napi) {
> +               if (READ_ONCE(napi->dev->irq_suspend_timeout)) {


Since we'll read irq_suspend_timeout twice, we could have a situation
where the napi_schedule() will not be done
if another thread changes irq_suspend_timeout ?

If this is fine, a comment would be nice :)

The thing is that the kernel can not trust the user (think of syzbot)

> +                       local_bh_disable();
> +                       napi_schedule(napi);
> +                       local_bh_enable();
> +               }
> +       }
> +       rcu_read_unlock();
> +}
> +EXPORT_SYMBOL(napi_resume_irqs);
> +
>  #endif /* CONFIG_NET_RX_BUSY_POLL */
>
>  static void napi_hash_add(struct napi_struct *napi)
> --
> 2.25.1
>

