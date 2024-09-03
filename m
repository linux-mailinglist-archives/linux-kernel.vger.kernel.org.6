Return-Path: <linux-kernel+bounces-313235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C673296A228
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9EF1F244A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C72189BAD;
	Tue,  3 Sep 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekLeCHYR"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916718953D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376740; cv=none; b=hbDJMen9HUX3LpExguJatd1JdjimPnsJEROZ8Cm6WenS7iAOSQNvvGpozDXZWQdCb1VzgjFfKkMg+sh6o4SOKT48CxdeUmFeDhPrjN2mhzEeu8F69H8bA1XjQmhgYa/+4laGE90YiUWXkTusMpUHiFPO1+oJFYYDYUTPDCz3DPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376740; c=relaxed/simple;
	bh=ZfbxVl1glz8Vb6LZs4MHn8WObItPWAp5Hu0aYunUFeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsnCHc251Cx8K2B+LBsCiU8SQ08YS+80ipmdIe9h1xS68MaMDXb/3C5saE84db+G7oOtuRb+pQ+x/UaR6GhtGoJWkm5u9Q631aLo+pg2Wmk6U/anFTMTQCR0XzqzPnucFoKneHjz/8CkxYHAnUe5CMjcmaMOaaoPxYjc2lNjJm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekLeCHYR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86abbd68ffso907428566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725376737; x=1725981537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJsBRI3EdlxNC+/ozkYJ5K4YtqaBU+Qz7tDZo9enfoQ=;
        b=ekLeCHYR3A3kj/Em6cx5+ujichj/rVRJ5AUdg23e1altPG9gVdAsJt1CEe0LOVOoYy
         gHLYPlivZQbXdHITMofbrAm3b9EWT7bjsm/jQw+aNZKIihfLMR7vtUY44dq7MItjielN
         UBmrfW9o672VkkqzxOcMujzq58US6maU09+gFFhAZk5Tp5joslOGvahYbXZABB9B9mcu
         IjvWOdphmwq3y1yYz9nhAKVZzNAcSKZEA4qUUOUI/Xclh1fzCcw/9w7z38y2rt+yMnvl
         6jl0jUN8jJS1dssNSxePvRi/VLgS+pfiHQbXRS9UsC43LuOi7FnZpT1ogDt+2vVNgCMY
         ji9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376737; x=1725981537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJsBRI3EdlxNC+/ozkYJ5K4YtqaBU+Qz7tDZo9enfoQ=;
        b=POfHJHgUywqhcUubGCFdiZaVVHgWM41ZIDLBgqVvjRPhfdook8766EYC+w4HbL5RF/
         1oNl0QuT7in0EurUufOM7MifMOhcUqFDIz42Kh4oCbpXGiFoYt1D4H+2jXpO4eJyhuZA
         0qGKKnAufsW5Qp5bZiDfsLywajzhF8zApQfjbLDHP1vV91ixtywlAVYhHxtXjiy2vvGw
         FHl3pE2Awl7n9r/MhsIWBrBt4X0cz5gy0g0F/G4jksFEn0udNS2q9cx25bWlsAH1lzgQ
         u683UHiYxF2cjjgE1/UGxlmCJ/0+kXIaitK8n2NQa58DH+foXXqvaCvyMF1MNUQIkIyG
         xSkg==
X-Forwarded-Encrypted: i=1; AJvYcCWa1IqA4TEoT3FKlur/0z6y777PWQHKhLktogWi5mepYIYKrbSLomvcKpeAccDH0QZkFsCLd3Dw1yr4+0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe7Drh5UKvrGJzedAV0p9VhvSs2A9cWHyWPZ6ziiey2pMx5YoT
	YmIaQjSAaqGnbgc914Ig2HJ56DiNqB791gyHkqOPnoqPV1tWO+zGgLoOth6q7ynK1NyVRPCy13g
	vHQIKZNNrg1xJWCT6v0V81UJnu+CpoxkKVjOJ
X-Google-Smtp-Source: AGHT+IGJJzBIkDzFW1Sjp3ZP4my3ZSX2A8AzHH2EQ2hAxnP3UhDE2BBhdsJQm6BR5aRg54MNzRlcOiw2WpTTTHJTtnI=
X-Received: by 2002:a17:907:1ca7:b0:a7d:895b:fd with SMTP id
 a640c23a62f3a-a898231fd75mr1775714366b.6.1725376736022; Tue, 03 Sep 2024
 08:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b341bb062136d2d9@google.com> <tencent_274B82754376EF66A23C0D37029644374609@qq.com>
In-Reply-To: <tencent_274B82754376EF66A23C0D37029644374609@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Sep 2024 17:18:42 +0200
Message-ID: <CANn89i+93oK80FtHijdYJMid=ChsXP+2F1=Dn7K8tuvLy7xNHA@mail.gmail.com>
Subject: Re: [PATCH] mptcp: pm: Fix uaf in __timer_delete_sync
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com, davem@davemloft.net, 
	geliang@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 5:10=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> There are two paths to access mptcp_pm_del_add_timer, result in a race
> condition:
>
>      CPU1                               CPU2
>      =3D=3D=3D=3D                               =3D=3D=3D=3D
>      net_rx_action
>      napi_poll                          netlink_sendmsg
>      __napi_poll                        netlink_unicast
>      process_backlog                    netlink_unicast_kernel
>      __netif_receive_skb                genl_rcv
>      __netif_receive_skb_one_core       netlink_rcv_skb
>      NF_HOOK                            genl_rcv_msg
>      ip_local_deliver_finish            genl_family_rcv_msg
>      ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
>      tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
>      tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
>      tcp_rcv_established                mptcp_pm_remove_addrs_and_subflow=
s
>      tcp_data_queue                     remove_anno_list_by_saddr
>      mptcp_incoming_options             mptcp_pm_del_add_timer
>      mptcp_pm_del_add_timer             kfree(entry)
>
> In remove_anno_list_by_saddr(running on CPU2), after leaving the critical
> zone protected by "pm.lock", the entry will be released, which leads to t=
he
> occurrence of uaf in the mptcp_pm_del_add_timer(running on CPU1).
>
> Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Df3a31fb909db9b2a5c4d
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/mptcp/pm_netlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 3e4ad801786f..d28bf0c9ad66 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -336,11 +336,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>         entry =3D mptcp_lookup_anno_list_by_saddr(msk, addr);
>         if (entry && (!check_id || entry->addr.id =3D=3D addr->id))
>                 entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
> -       spin_unlock_bh(&msk->pm.lock);
>
>         if (entry && (!check_id || entry->addr.id =3D=3D addr->id))
>                 sk_stop_timer_sync(sk, &entry->add_timer);
>
> +       spin_unlock_bh(&msk->pm.lock);


mptcp_pm_add_timer() needs to lock msk->pm.lock

Your patch might add a deadlock, because sk_stop_timer_sync() is
calling del_timer_sync()

What is preventing this ?

