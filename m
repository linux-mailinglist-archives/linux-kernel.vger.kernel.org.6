Return-Path: <linux-kernel+bounces-388507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1938A9B607F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718F3B22EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C652C6A3;
	Wed, 30 Oct 2024 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RhOdic5A";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="HVPoQOAc"
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86E21E22FF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285407; cv=pass; b=VCXnO2tmrgu+gkGJa03FYdTT+AwNy4GxGcXeK85FBCiyMsMqAGYLxkYlufAkU173h+crPEqy+l+g1jlRc15d7dMoJIQQhMGKmPa1M3rRk3pEaVx5+IKBqENo4dBneD5ikcZfRj6BU5Bo7ydE0E7QJqg/fhM2wnAL88ezHVHmPE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285407; c=relaxed/simple;
	bh=XEeyjwQU738ho+qQtWRqpo/KZOjw+p18vR6Ynjnq/4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RB4RcgqrEEe1kRzTDflMUIVz92Thpb909mGzK6rZCA0GQjRWRyTCn1tRkdBrMJxGZurq0h5ln/00BE2I2W5rCLwVaN7WeLbyHnonX3HADxiJQfcTTn4NXOvXis91s2nozSXlizvbeYNejsc3L1+aLsvH8tZ7XcMcsSm6hS9nAuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RhOdic5A; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=HVPoQOAc; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1730285395; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iFEjSX003YrfGE/9n70F1RwwuOGHL1O1cpTzYNw1QwB4ah1qexmEANkI8ZLHsOEyoc
    MK9fkuxqrEqVWfpJ+RZwpkKIRtAUBpHwE1qteQDobM28HE/OXQ5rk3xqvuOQvZ5qgl7T
    RTMiY2JLmHjOlWAFyvuI8IdsXSwzl7aD8RlhOIeASlgIG7wNsyD/qsjopMlxOQbsIaX6
    yfHxckOM9MGnfGL9OoBia9c/+6VV1bM7G/BcsLdgIg3GZ0pyP+7YPOXqv/r8KZf6tmdl
    e6AOBxiNrehNzO0Cx6kTUTAyxy7ZWqGeORxochLC19psFGMSXR9ypnjyOee/AcQa77vG
    jrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1730285395;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rn7JjCnSzO4SL8uFXscWDbsjMnV8tIao5xG3HFvjQRI=;
    b=DwwlIo8jkPqgj3otzC4JnJnlckdMfkZdlHw84FI98/9fgOEdArfwPdvOp7nCyirwR8
    6h8OF8aKTaHTA/N9wBbaYDuvybbWB3d1TEowsP00ofgTKOEYw6sY4WAoxStVqNweKzlQ
    uB4wPZ0N3BuDXP+mLRrsT8ryQKsecA4Eb0KAdlnW1SCavFhGu5OK3buKoI6zfz1W1gC4
    aQh8BHjEaCQ7IjENpqksFsF7vFhnKujZ5Ou5ahVaHYMlR9fdVUxmb9S8EvbiCPkKVEns
    Pufk9TZl8V3JXK1C/mfPjTvlEjPd+fyJfZdyCc437TeYJf8FMwK+U+ripGcpHyuiO7Sf
    S/Ig==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1730285395;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rn7JjCnSzO4SL8uFXscWDbsjMnV8tIao5xG3HFvjQRI=;
    b=RhOdic5AcxvYdx2rHhJK1yWhWwr67QyiUG8fXuddcYl/RztF0wCCYDcQOxs/XK0ZSE
    BMxvnWIqH5s5t+4Vp0Iun8uTKShjOWTF0XscqAfYLbhn5XL838DI46mjzUobcxc5C3C+
    mY5rE434+r19/XuJZmYsl8PWSVqUy7Wqo2c9MX8XURkTDud20RS+qHoG9y/HukpFeGLO
    1iKiKo9z52fYZzhJJaN4TRLY9Tr9+/24QiG7fXkLY/nuYtKs8xZFDgiz9ZIne/nLCLE0
    oSQImsTdF/BnBo0ZxKGJEkGrq7jys/Tgcuz+l3jEkwQDLJ6OTRQ1vjKWzRKpRLSrFaE4
    S/6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1730285395;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rn7JjCnSzO4SL8uFXscWDbsjMnV8tIao5xG3HFvjQRI=;
    b=HVPoQOAcIp1JPDNGmCqwv7ihGzaZJ7V8pcFDbvBa7pRBC93H2gq/vjGUJwn57WoR1b
    fbdhBTq8iiO23b7M/SCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id K63ada09UAntKU6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 30 Oct 2024 11:49:55 +0100 (CET)
Message-ID: <203a1560-76c9-4c47-b1b8-b44ddf40cd16@hartkopp.net>
Date: Wed, 30 Oct 2024 11:49:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] can: bcm: Don't initialized an unused hrtimer
To: Nam Cao <namcao@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
References: <cover.1729864615.git.namcao@linutronix.de>
 <4e7dc11aa9ffb116678574889cda35b3cd5b7385.1729864615.git.namcao@linutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <4e7dc11aa9ffb116678574889cda35b3cd5b7385.1729864615.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28.10.24 08:29, Nam Cao wrote:
> The hrtimer "thrtimer" is not used for TX. But this timer is initialized
> regardless.
> 
> Remove the hrtimer_init() for the unused hrtimer and change bcm_remove_op()
> to make sure hrtimer_cancel() is not called with the uninitialized hrtimer.

NAK.

There are several other occurrences of thrtimer that are not covered by 
RX/TX distinction, where the second timer is canceled.

This one-time init and cancel of an unused hrtimer costs nearly nothing 
and is not even in any hot path.

So this incomplete patch only adds complexity and potential error cases 
in some 20 y/o code for nothing.

Therefore I would like to skip it.

Thanks,
Oliver

> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> ---
>   net/can/bcm.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 217049fa496e..792528f7bce2 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -780,10 +780,11 @@ static void bcm_free_op_rcu(struct rcu_head *rcu_head)
>   	kfree(op);
>   }
>   
> -static void bcm_remove_op(struct bcm_op *op)
> +static void bcm_remove_op(struct bcm_op *op, bool is_tx)
>   {
>   	hrtimer_cancel(&op->timer);
> -	hrtimer_cancel(&op->thrtimer);
> +	if (!is_tx)
> +		hrtimer_cancel(&op->thrtimer);
>   
>   	call_rcu(&op->rcu, bcm_free_op_rcu);
>   }
> @@ -844,7 +845,7 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
>   						  bcm_rx_handler, op);
>   
>   			list_del(&op->list);
> -			bcm_remove_op(op);
> +			bcm_remove_op(op, false);
>   			return 1; /* done */
>   		}
>   	}
> @@ -864,7 +865,7 @@ static int bcm_delete_tx_op(struct list_head *ops, struct bcm_msg_head *mh,
>   		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
>   		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
>   			list_del(&op->list);
> -			bcm_remove_op(op);
> +			bcm_remove_op(op, true);
>   			return 1; /* done */
>   		}
>   	}
> @@ -1015,10 +1016,6 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   			     HRTIMER_MODE_REL_SOFT);
>   		op->timer.function = bcm_tx_timeout_handler;
>   
> -		/* currently unused in tx_ops */
> -		hrtimer_init(&op->thrtimer, CLOCK_MONOTONIC,
> -			     HRTIMER_MODE_REL_SOFT);
> -
>   		/* add this bcm_op to the list of the tx_ops */
>   		list_add(&op->list, &bo->tx_ops);
>   
> @@ -1277,7 +1274,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   		if (err) {
>   			/* this bcm rx op is broken -> remove it */
>   			list_del(&op->list);
> -			bcm_remove_op(op);
> +			bcm_remove_op(op, false);
>   			return err;
>   		}
>   	}
> @@ -1581,7 +1578,7 @@ static int bcm_release(struct socket *sock)
>   #endif /* CONFIG_PROC_FS */
>   
>   	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
> -		bcm_remove_op(op);
> +		bcm_remove_op(op, true);
>   
>   	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
>   		/*
> @@ -1613,7 +1610,7 @@ static int bcm_release(struct socket *sock)
>   	synchronize_rcu();
>   
>   	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
> -		bcm_remove_op(op);
> +		bcm_remove_op(op, false);
>   
>   	/* remove device reference */
>   	if (bo->bound) {


