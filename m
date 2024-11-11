Return-Path: <linux-kernel+bounces-404307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3139C4231
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581BFB23504
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A691C19E7F3;
	Mon, 11 Nov 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qcDp9IRI"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA925777
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340586; cv=none; b=Q+5Ko3DhnoCy6jthjF7lbXGAJTI/UtP+Bw4mLfnlnZWuPUS3TeWG7BYdlgJiI6+MHcItyC30V25dGzlncHlIrk9ylA/u4REyOEZh4OmmJjGyY6pwzBN0CIDHcu1UKTnub+H45aGfygp9c0AQZrZUmbX3O86Q80W+SZZARpn4qE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340586; c=relaxed/simple;
	bh=cCNT2ol2RaNL8QVF2pjDveoEZz7Jxa2QkNQhEUYkYo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWZj1Ar4u6AjvHiTol8fv5jFdPtEZmQgWz5jJ2XRMV60N0m8N1ZjHTzahVGylW8Wwj52CLPp/MUWr4W+vAWCNHlvXZ6D/2dbZVTN3AxNOXdV6IPNfkvo/XxSXny168G+1nBSrk2ZE4/oc0TFOxnBZj6JTk62ky46PwvORBYLpKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=qcDp9IRI; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso4429297276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731340583; x=1731945383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eepnCx5XvB+VM5l1QUXLjJbZ0P2/X2OA8fzFLl3SzU=;
        b=qcDp9IRI9iJBZNlEGJd3YJndvhXX2M1Zd7TSbri24s94kaMYvMgSAkW50EjPpUk6+0
         wc12h/bMw/vMz9CjoEnaMdmMrysche7bjQc67bpj5zl4vzPu+b1wSbkq6yp3R+5014e9
         DJyRHaPdfMTzdzQ9QGFckt9CQ6wE/tOVHCfLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340583; x=1731945383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eepnCx5XvB+VM5l1QUXLjJbZ0P2/X2OA8fzFLl3SzU=;
        b=uoPMcm1Z/Tpt3ASio3RgXzRlnG7HzIz6EhPrdd5tT2SxgEsjdN1jCH7iX96ONDthbd
         qOBn+0wO8Km0OVr/k9atjCLhH0pkGs+2GP0OMmks/j8yij993LLtQVQ0T8+l05sqHF4o
         ceNUrcswa55wHSrG/lyeWJB/7z6t1IU8ftaO4HBfa9f+f2NbtOt9GqNss4fVtfue0mNO
         gYAeWeiVeuajEOIUhHzS3a6JVfY/tPHBpvz4ru43prFlk8p8afQFpa8PzwruliV+ffpY
         ivqdJblOiRMa3QBGjl4mWmz4UPGMHvB+5eULB7LdmaWtAssdkU7mZVFEeAB82K5oJn5/
         BYMA==
X-Gm-Message-State: AOJu0YzPDrUJXWfvyp2NXg1Wp+nGmD5hJAz9cpDvzoxo7LVvZ7gT1S0P
	iKs4gD9lE4b+EtbKtYfQ7oz2UoE9dLb4ZC4crpLzumrgcQ56PKpT8/xKYE+QVmn1V5pPn45KJXn
	XvsrCt4QmAZU5DYujjiezOy/tPO04C8HBIaDGxg==
X-Google-Smtp-Source: AGHT+IEsYe8rSzyy5OhUBmXTPMZEtvHUcFj0mASzLRnereBtuYGoI07J/H8OkIFWUNj7aFDjt1XNoPm72ujSF5LeyX4=
X-Received: by 2002:a05:6902:2846:b0:e33:2e:eac1 with SMTP id
 3f1490d57ef6-e337f88bd3cmr11064673276.30.1731340583346; Mon, 11 Nov 2024
 07:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-3-joel@joelfernandes.org> <a491e879-364c-4b57-aa69-28608d8af4f0@arm.com>
In-Reply-To: <a491e879-364c-4b57-aa69-28608d8af4f0@arm.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Mon, 11 Nov 2024 10:56:12 -0500
Message-ID: <CAEXW_YTxgpEzA4Vo5+pX=iNYG=xioN=J+bh9YLdSFEc4bEXhLA@mail.gmail.com>
Subject: Re: [RFC 2/3] tick-sched: Keep tick on if hrtimer is due imminently
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:38=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/8/24 17:48, Joel Fernandes (Google) wrote:
> > In highres mode, the kernel only considers timer wheel events when
> > considering whether to keep the tick on (via get_next_interrupt()).
> >
> > This seems odd because it consider several other reasons to keep the
> > tick on. Further, turning off the tick does not help because once idle
> > exit happens due to that imminent hrtimer interrupt, the tick hrtimer
> > interrupt is requeued. That means more hrtimer rbtree operations for no=
t
> > much benefit.
> >
> > Ideally we should not have to do anything because the cpuidle governor
> > should not try to the stop the tick because it knows about this
> > situation, but apparently it still does try to stop the tick.
>
> Any details on this? Which governor?

I noticed this in Qemu (virtualized hardware). Actually I need to
update the commit message. I think it is not because of the governor
but because of lack of guest cpuidle support.

static void cpuidle_idle_call(void)
{
....
  if (cpuidle_not_available(drv, dev)) {
    tick_nohz_idle_stop_tick();
    default_idle_call();
    goto exit_idle;
  }
...
Over here dev and drv are NULL for me. I will also test on real hardware.

Also maybe the " if (cpuidle_not_available(drv, dev))" condition
should do some more work to determine if tick_nohz_idle_stop_tick()
should be called instead of unconditionally calling it?

Pasting relevant parts of my .config:

# grep IDLE .config
CONFIG_NO_HZ_IDLE=3Dy
CONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy
CONFIG_ACPI_PROCESSOR_IDLE=3Dy
# CPU Idle
CONFIG_CPU_IDLE=3Dy
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=3Dy
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=3Dy
CONFIG_HALTPOLL_CPUIDLE=3Dy
# end of CPU Idle
CONFIG_INTEL_IDLE=3Dy

thanks,

 - Joel

