Return-Path: <linux-kernel+bounces-180215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A0F8C6B81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E1928393B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2234D39FD4;
	Wed, 15 May 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd/TQBXO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BF4EB3A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794376; cv=none; b=pvopyk8dPunfKi4g0JB+hMCK+tsSiYkmeCk27MAjaeCxI/zqFkZ6FNpWDv3AAwfbKpxzGKZlNGf1iPzlvPSb8Cu54PlNFOyYROJf3N1H7MrSik+RmbTolWXbHfgFIzT1OQJBOiXGaSW26JvzL0HYfh1rcOU+QBNaBlaH3a1xFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794376; c=relaxed/simple;
	bh=qEcSw3lILLGvhKIjJLG6VoBEYR2tfcg32/p64k58ON8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NQ9M/5Y48T4dZ127Hy/hsoJyXJ4fWNgqpSBK8hvWd5A2cc6qBhA+ccAzQ4CsOsksCssaQ6TkCVPclrorVZHBEexNwelzZUMTOVmWMxF+eSPqhZoo3llnybm2R9O+/OV3s2h//LNDs4d2y1et0DAAFySLBfdcR06k+B0Kp4sbWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nd/TQBXO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715794373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOwdeJhBjSGNCAussjsFY04Bth4aIM7eWnKu5IfNLOU=;
	b=Nd/TQBXOK7qs9Lal+vutoItKN2UwzAuNtihaTe9nkJvLQR1njhw8ObCVJGt7d4OM7+3w0Q
	G4G0eiu8GBK/2rjXpO7CVyo3GScsLLt0FWry0nGCa7I2L6klkxvXXSByzihLMm/Hqi2qRS
	L0pxSj3BC2KF++ag0qSQUrpeOBflEVg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-SpQ7e2JDPX6uSPnR_ErIZg-1; Wed, 15 May 2024 13:32:52 -0400
X-MC-Unique: SpQ7e2JDPX6uSPnR_ErIZg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-792cefecd00so940488785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715794370; x=1716399170;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOwdeJhBjSGNCAussjsFY04Bth4aIM7eWnKu5IfNLOU=;
        b=TSp/NHTxxJLB6QXnNPJCl/FFk7xmQt1kf0tnmU66auLNEvi7chDZs4CbGXJCWoz+CV
         zccQkYH+3FyZMjbXhpdvmb2SQ2PgtLl1I9jlbSn8tQavSTKJalXSxef8DhwtjD3oIhfG
         S7haOFGlPj2mbDd7+Mru2qC+n/7Y4IiL7s2NmAcwxHKJ6N08XYVnKmPsH5I58+NVv5wk
         qkOfJqxW8JI7FFHFljHucMNceZscvsaPzMYCCB1Rvxz+IiGEN8QfFdKZpoCI1BEMYdOl
         mR+IjPcKknRo6CoLUPGa0dBjbW4FNo9YEkto1Dk56ZTZcBUVmuahaHveQ/x1gYT2S/k2
         0yUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO9NXoP7b0zKeGXfOvNgsnjmqOnkQtjqKD4D7ucGv89EwuV3x4OiJdo642iPXqcv41iiUdoLElOw8KYOba6i26fb6ObtqM3zfyVhlJ
X-Gm-Message-State: AOJu0YwJxs/g0xyVbPibBbMVnfq6JH607OAjXaQol22bHSyc0zkbMk5F
	Yr5WijQXi1m1xsp3NWVTjil7AHzCti40w6iKJ2/MmWyvUfgVBlMkk41Ft/WZAkOSv78dl+HLkdO
	4NcYEkubps1p217Dt9aWqrkniEIRWVMHIJsxTU+8OtgYaHeX7LGiVvInkmggEKA==
X-Received: by 2002:a05:622a:109:b0:43a:3502:8446 with SMTP id d75a77b69052e-43dec39be29mr341473721cf.28.1715794370170;
        Wed, 15 May 2024 10:32:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3J4mJbmHn1T6bjHxpYTkK8dZATZQr5Sa13WzDnCmuqUStezho5/sEVpt2rJSDEKrAgOg5Bw==
X-Received: by 2002:a05:622a:109:b0:43a:3502:8446 with SMTP id d75a77b69052e-43dec39be29mr341473421cf.28.1715794369830;
        Wed, 15 May 2024 10:32:49 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0e421dccsm54794051cf.53.2024.05.15.10.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:32:49 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/6] rcu: Remove full ordering on second EQS snapshot
In-Reply-To: <20240515125332.9306-2-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-2-frederic@kernel.org>
Date: Wed, 15 May 2024 19:32:45 +0200
Message-ID: <xhsmhikzfgev6.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/05/24 14:53, Frederic Weisbecker wrote:
> When the grace period kthread checks the extended quiescent state
> counter of a CPU, full ordering is necessary to ensure that either:
>
> * If the GP kthread observes the remote target in an extended quiescent
>   state, then that target must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it exits that extended quiescent state. Also the GP kthread must
>   observe all accesses performed by the target prior it entering in
>   EQS.
>
> or:
>
> * If the GP kthread observes the remote target NOT in an extended
>   quiescent state, then the target further entering in an extended
>   quiescent state must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it enters that extended quiescent state. Also the GP kthread later
>   observing that EQS must also observe all accesses performed by the
>   target prior it entering in EQS.
>
> This ordering is explicitly performed both on the first EQS snapshot
> and on the second one as well through the combination of a preceding
> full barrier followed by an acquire read. However the second snapshot's
> full memory barrier is redundant and not needed to enforce the above
> guarantees:
>
>     GP kthread                  Remote target
>     ----                        -----
>     // Access prior GP
>     WRITE_ONCE(A, 1)
>     // first snapshot
>     smp_mb()
>     x = smp_load_acquire(EQS)
>                                // Access prior GP
>                                WRITE_ONCE(B, 1)
>                                // EQS enter
>                                // implied full barrier by atomic_add_return()
>                                atomic_add_return(RCU_DYNTICKS_IDX, EQS)
>                                // implied full barrier by atomic_add_return()
>                                READ_ONCE(A)
>     // second snapshot
>     y = smp_load_acquire(EQS)
>     z = READ_ONCE(B)
>
> If the GP kthread above fails to observe the remote target in EQS
> (x not in EQS), the remote target will observe A == 1 after further
> entering in EQS. Then the second snapshot taken by the GP kthread only
> need to be an acquire read in order to observe z == 1.
>
> Therefore remove the needless full memory barrier on second snapshot.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Still looking at the rest, but at least so far I'm convinced this one makes
sense.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5e6828132007..58415cdc54f8 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -325,7 +325,7 @@ static bool rcu_dynticks_in_eqs(int snap)
>   */
>  static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
>  {
> -	return snap != rcu_dynticks_snap(rdp->cpu);
> +	return snap != ct_dynticks_cpu_acquire(rdp->cpu);
>  }
>
>  /*
> --
> 2.44.0


