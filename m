Return-Path: <linux-kernel+bounces-242932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBCC928F20
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 00:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A43F8B23D24
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A531465B0;
	Fri,  5 Jul 2024 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="SYfbTbYD"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5413C9BD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720216862; cv=none; b=tU6jDFyihqLMH1NHYMF5MjEIgOW5nFzLqN2L0HClKozgzWB2X6n5h6Lrg5Wmcp3lGGF0CX/ShIhedkfrGwG8msr7i8zarhVOOoo9afiA96dy9xLNCEwwnE4Sj+mRZvrMF5ON9YH+jUMQjFkll/gJI4G2Uxuo+0q8ewTnKFmvj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720216862; c=relaxed/simple;
	bh=cRlLcPvgdYI+0d5Q121mKPf07KB4cpgC4kaVtDmI6ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=spcpAgJfl0GaX76/LODcqXxNmHqESzeF86NVHxfHr7asDk5qXTz2V/tusjUjZX+qNBk1dPCqAyby8Bd5NxCucaj4HNZR/LP58/t3sWykCosVy5fPYs+2ey8qTpm8qf0PgFE1eoKZ6QBdlVGHQdn569cXk9M5iDUjMqXKLS6v1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=SYfbTbYD; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea2f58448so2279852e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1720216858; x=1720821658; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBckyEFwh/Rys/nHKmjk7v967dXh+ZDDYWaIn/2UGq0=;
        b=SYfbTbYDQz/axrX9XOQUknkEm+d1tTBjJWWXVSyIa1At+3bylle2WqWNxuISyDerK7
         ynTu9RnePZlJGCNuphhLdn/S0PppuzUG1Jnmg2qkVLLILven1cYx3CXPr1AfW8vo2ppR
         zGbMa/Tc1wuuM6AoNgpYpy7/sPuRVanF3eIMpy31043E5aC1YmP/JvPkSMTbBzEhOOG0
         B6Jx3l4IbjVHohMW+ALxGT7ZD7858pQil+5WYbeDuy63gG8FxIUqFRH514wP+fFwRwzl
         g5+NKIgNEYArfKKkDXD9WgTiBmAoVNX7C8x4C26uDWRGkBNDoMikq0LEzslTVV6JakeJ
         ynXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720216858; x=1720821658;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBckyEFwh/Rys/nHKmjk7v967dXh+ZDDYWaIn/2UGq0=;
        b=D0/jZutKm+ZnSPACI5NUs+J1W+xLqS6kzE3ITL49cVbeT0fILUuqdKRju8VSE9FtgN
         jZVljQK5wtYcaBdrUd93EPpzzz21mZpeqpzfLAH4Olx343G7mhLbU7SNVo8loJ8zORlp
         4zpKlTC+YyO2841u5Wb3TkY9duT6cD8avv8vWDoOywlQYETxVy3RezdzEIN8tau0cpBe
         UE3G9uvy7KmE+z3v2cjdrq2F7l/+U1ZEDp1rc0Lxou/UYD7WT8eQPsKLzq5ZwLbqgtiF
         UkOs/CerROFsZxjhJkrZEZnla6mkWhkH6qm3nveFF4DB9rqSpsNICaFSGFBTbmF0eEdV
         u2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWsI2EUlnlueTONHsAevLlKcD+lL9uf6zdoRbFc76mmFXUi0YccG2k8n7W3DIkNcbG3NQkRs2cHpnT7Q1q8aOOm5gndOqRxng+/8Lgh
X-Gm-Message-State: AOJu0YxvAcU9aHOKFhYCH5qWnDZa9ldFStBSJiMnt7iq6OEYnj40AVuF
	ITXOfn2hYV0BdQnAdKU2ruDYloQ6KrMMFK3Tsjskt+ILWNkC2VIa88iXnXg2O5gmTCHA9b71a5W
	r
X-Google-Smtp-Source: AGHT+IEmnD1pltRm+NG29AdDzUwJcwOOmeDoXT57EhZSgEaLlRepCcFYfu+F9IeP4PfKXOWtcSR0TA==
X-Received: by 2002:a19:ca43:0:b0:52c:e1d4:8ecd with SMTP id 2adb3069b0e04-52ea061309bmr4021943e87.8.1720216858175;
        Fri, 05 Jul 2024 15:00:58 -0700 (PDT)
Received: from wkz-x13 (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea6493c4esm287838e87.113.2024.07.05.15.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 15:00:57 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, davem@davemloft.net
Cc: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, Roopa Prabhu
 <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: mst: Check vlan state for egress decision
In-Reply-To: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
References: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
Date: Sat, 06 Jul 2024 00:00:55 +0200
Message-ID: <87plrrfqi0.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On fre, jul 05, 2024 at 15:00, Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz> wrote:
> If a port is blocking in the common instance but forwarding in an MST
> instance, traffic egressing the bridge will be dropped because the
> state of the common instance is overriding that of the MST instance.

Can't believe I missed this - thanks!

> Fix this by temporarily forcing the port state to forwarding when in
> MST mode to allow checking the vlan state via br_allowed_egress().
> This is similar to what happens in br_handle_frame_finish() when
> checking ingress traffic, which was introduced in the change below.
>
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
>  net/bridge/br_forward.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index d97064d460dc..911b37a38a32 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -22,10 +22,16 @@ static inline int should_deliver(const struct net_bridge_port *p,
>  				 const struct sk_buff *skb)
>  {
>  	struct net_bridge_vlan_group *vg;
> +	u8 state;
> +
> +	if (br_mst_is_enabled(p->br))
> +		state = BR_STATE_FORWARDING;
> +	else
> +		state = p->state;
>  
>  	vg = nbp_vlan_group_rcu(p);
>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&

I think it might read a bit better if we model it like the hairpin check
above. I.e. (special_mode || regular_condition)

It's not really that the state is forwarding when mst is enabled, we
simply ignore the port-global state in that case.

> -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
> +		state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&

so something like:

    ...
    (br_mst_is_enabled(p->br) || p->state == BR_STATE_FORWARDING) &&
    br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
    ...

>  		nbp_switchdev_allowed_egress(p, skb) &&
>  		!br_skb_isolated(p, skb);
>  }

