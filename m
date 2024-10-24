Return-Path: <linux-kernel+bounces-380235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512969AEABE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F307B2118D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977EA1EF955;
	Thu, 24 Oct 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cNhOP4Vc"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EFA1EF087
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784407; cv=none; b=VPuWFg/eYaLVeJt369PTCRaZ6mHCRkuZbcXya1+Kk1si93lymHqzfBfknWUMknIWX00p8Ufxtz5/F1rSUhGjbEdQqE5kLbTn/G3aTSrm8Rl3ckMThoI5kC6Ct9/dgPIB3NZAoHU8JogGytKjLyPK/lWrHztXN9cYwxuZxfWlshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784407; c=relaxed/simple;
	bh=DblN9Y42IOqBTNneicO666YPFxWmamv8tk/d7WmC25c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkULbbAspa9x/dF+oCoFEyNq2r3lnUv8KqAv0aVZjcqe/va6mHVzkp0YBT51xvoMsQGZ656aRgZF8chSusybUMbx564N4Ux/nSSZ/4ONU51DWoL+ldMBaj6v2No5cXBB7VdIV6R42N8FvA5p6LIe+LYDaDTiyrFlM5MZWgD5+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=cNhOP4Vc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4fa3ea7cso770660b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1729784402; x=1730389202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoVf10QaQboLo+ZHzxkCJ8CzAtGV4rQmJMGoMf2nO9Q=;
        b=cNhOP4Vc0TPcAjw2eyTF/HqfOrjqV2utU04Q+F/KlW+qIZZLpB5Zo4bZjLDNqowGj7
         TEPZDy8VacRmiTwEUtsL79OHhjbmIEVlArtHqTwKVqlY/oyEHA/ccLCDhRvGG2d55I0Z
         FYxBWmIW7kqLWg2dV1LTd6Hp5h2m4pWinjY9vYrZ2mmCDWHokQ8EkAow3wdaJeZ1Mf4l
         NhXDXQkJolYydpjf+4W6luo/WKN/fQGXK4jBpgL+lQ6EmVEAfePYNQe6WRu5mtwQAjbt
         vgJTiTIxZBdwluQ0MPgn1FkWVOHT8DjoIwbesVudJ0Bn6MN/k0Jk5NPldUjP7M4UH5PK
         qVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784402; x=1730389202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoVf10QaQboLo+ZHzxkCJ8CzAtGV4rQmJMGoMf2nO9Q=;
        b=v64xdldD0GqLAjjUe+VePr89DVNEKAC03HV1OEk0ujKHqAN7/Hww6nMuXwddDLIbwJ
         eoNKwJ538PokP88pjCIJtEQWxY0zArc5W6pLoluGPWib2dO2GIrkTcYPjSoB8LAPEINa
         R94EOeTDgwMop9iIVk7Sju/g03+oCTd5Qx5nUSp3NaYdMZ0ghKR3zWV4+p10o5OPn+X2
         L3pH8UQl8yCxhnme5JQSjxnkHo+4OP+GAg7aKpO1jgOf0guqQooGTPyZ3SR79W9NY3vG
         EzBm9VJiItRkrnxlwzDywNoJ63arUEmwfPeISoTRXkrdchvQmnH90cDaXv4MicfOV3Zl
         rLnw==
X-Forwarded-Encrypted: i=1; AJvYcCVuCT5rLYN3kIv3UNeEeD7m7eQxM+aOnDs1dhZTd14eLUEPR5F6MJFxXKnPHyoHL/rPZwXMe61+yvOZUao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKNmlAOAG6+0hwNqclKjZJHoHWeYuRCkfFYI6YrS60MubbPXG
	q711JLeeGZ7Vffo4FdY86jiexw5nAIXBYmzaEk5MqK9Z5u/D0xJWqQe8AZiXrqty/+QIw1SLsqa
	eZUbUyU7QNeGhFfO2kkdNgylpXxOPd9luLk5I
X-Google-Smtp-Source: AGHT+IHa5rdi593NqHjr/Lb/U2GbQiFgTjER/v/CQUm0jQcpjQrWFi0l2/4cubzX5Ak6l1s+mw92a+SfzxBA7JknrXQ=
X-Received: by 2002:a05:6a00:2d27:b0:71d:fd28:70a3 with SMTP id
 d2e1a72fcca58-72030cae1e9mr9099559b3a.24.1729784402490; Thu, 24 Oct 2024
 08:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023100541.974362-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241023100541.974362-1-vladimir.oltean@nxp.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Oct 2024 11:39:51 -0400
Message-ID: <CAM0EoMnV3-o_4L3Vv=TuEqC=iNKhNnW0c4HQiRqrJD5NtjKeOQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_api: fix xa_insert() error path in tcf_block_get_ext()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Pedro Tammela <pctammela@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 6:05=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> This command:
>
> $ tc qdisc replace dev eth0 ingress_block 1 egress_block 1 clsact
> Error: block dev insert failed: -EBUSY.
>
> fails because user space requests the same block index to be set for
> both ingress and egress.
>
> [ side note, I don't think it even failed prior to commit 913b47d3424e
>   ("net/sched: Introduce tc block netdev tracking infra"), because this
>   is a command from an old set of notes of mine which used to work, but
>   alas, I did not scientifically bisect this ]
>

What would be the use case for having both share the same index?
Mirror action for example could be used to target a group of ports
grouped by blockid in which case a unique blockid simplifies.

> The problem is not that it fails, but rather, that the second time
> around, it fails differently (and irrecoverably):
>
> $ tc qdisc replace dev eth0 ingress_block 1 egress_block 1 clsact
> Error: dsa_core: Flow block cb is busy.
>
> [ another note: the extack is added by me for illustration purposes.
>   the context of the problem is that clsact_init() obtains the same
>   &q->ingress_block pointer as &q->egress_block, and since we call
>   tcf_block_get_ext() on both of them, "dev" will be added to the
>   block->ports xarray twice, thus failing the operation: once through
>   the ingress block pointer, and once again through the egress block
>   pointer. the problem itself is that when xa_insert() fails, we have
>   emitted a FLOW_BLOCK_BIND command through ndo_setup_tc(), but the
>   offload never sees a corresponding FLOW_BLOCK_UNBIND. ]
>
> Even correcting the bad user input, we still cannot recover:
>
> $ tc qdisc replace dev swp3 ingress_block 1 egress_block 2 clsact
> Error: dsa_core: Flow block cb is busy.
>
> Basically the only way to recover is to reboot the system, or unbind and
> rebind the net device driver.
>
> To fix the bug, we need to fill the correct error teardown path which
> was missed during code movement, and call tcf_block_offload_unbind()
> when xa_insert() fails.
>
> [ last note, fundamentally I blame the label naming convention in
>   tcf_block_get_ext() for the bug. The labels should be named after what
>   they do, not after the error path that jumps to them. This way, it is
>   obviously wrong that two labels pointing to the same code mean
>   something is wrong, and checking the code correctness at the goto site
>   is also easier ]
>
> Fixes: 94e2557d086a ("net: sched: move block device tracking into tcf_blo=
ck_get/put_ext()")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Fix makes  sense.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

I am also hoping you did run the tdc tests (despite this not looking
like it breaks any existing feature)

cheers,
jamal

> ---
>  net/sched/cls_api.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 7637f979d689..2a7d856cc334 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1518,6 +1518,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, s=
truct Qdisc *q,
>         return 0;
>
>  err_dev_insert:
> +       tcf_block_offload_unbind(block, q, ei);
>  err_block_offload_bind:
>         tcf_chain0_head_change_cb_del(block, ei);
>  err_chain0_head_change_cb_add:
> --
> 2.43.0
>

