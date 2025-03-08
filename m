Return-Path: <linux-kernel+bounces-552346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F7BA578C7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43031172B06
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 06:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1702A19006F;
	Sat,  8 Mar 2025 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdYqKpo5"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCE417A314
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741416102; cv=none; b=E+ZllHPN+3fHnJkn8HrOjb5LWRjcevsaF5dosw3tzttltIyXwwZLx0QIVULKm59YvoSUNdaXaXfRSZ8OC4uoTn4kaLMkwb3RmvUKWW0epRdMoWAhiuwU9jBOrd1kLLK+TIpOCnIyvTH0LJA85M3H+tmD3TJIHNJb5V2HfrfmDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741416102; c=relaxed/simple;
	bh=mjXPEAUzfnISY0ZB5Qdk6ZqkNFSViNSHUixjtjhaCsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adYUzpEbq0RRNumQBne4KkfxRfZSNoaiVZ0o333zaqUpXo0Bcgkpq+Z+WF9T71bKPbBqzDzCal5ueILjKw/GNy0yp8Ud8V66A+yMVTikoZmu+ZXj9xnUkuOyVAlQ9sYAh/DRU1ELRQavKdXcOX7FoY2fTeuPSKdtSD/dCZsOZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdYqKpo5; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47662449055so3443101cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 22:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741416099; x=1742020899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjXPEAUzfnISY0ZB5Qdk6ZqkNFSViNSHUixjtjhaCsM=;
        b=tdYqKpo5mktSxKY1FOn2TiNPTX/sYR8C0/Smr7KIz89eGpSvzxW7jtlR8SQ9GeOh/i
         Q8JRRCh6OXkQIuJWyEfNmugd9CuexhJbII1B85AubppeGD28u8gJVU4oRRSyHnaSgY+i
         XwQgXorFsprEO68HuDnGIBHRbB7Pno+R4WVVZE82OkPhbiC05fDJGIxmsbyS7Zb2M+Lp
         x7iVvm7W8v4VT4GZGxgCOZNcpitU2DewCeIEz5J1gesXKl7w7WURMsFoOMUs8WOFNeHH
         2Iej9yyXfqc1gfzVZ1FdcRrllRRNXi50icRRwnDvBk/6O3kh3ti03iwADk0OZJC0Xs2O
         rdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741416099; x=1742020899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjXPEAUzfnISY0ZB5Qdk6ZqkNFSViNSHUixjtjhaCsM=;
        b=RGrKnlvUWEvnLNWYrGIebwqbyosI84C8dS74a9GWoLAhffcQEaz5gt9yCyP533FAqu
         sx8H2cjQkJNAZiJjm9zqD/nLQxZ/hT92FjcUGYX4BMMrQYnXHlvC/S3zK72S5IcPYnHz
         iE3yQfCA/hedDLuz8QEYZxE1mvZLl6zSmtYD0ekYKjnu5eNnDMwyRHa8C0MnK+oqCvsY
         WKISQN/ILWaNtzPzC0DKcQX+IUaeDh2td6X8PxuMJi6+yhgATbbxmU0upR8AYGCxVKjA
         CAdhI9A2Uxo8UARg7HJ+4GlrNDc+skh499s5l4G+bL3WYX6mfGatdbKLK3ezlcIPkWGE
         oOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr9bywk/8ngCykXErfL7LTUg0Xo45qtqFl3exmor5HlB+dQDAzIDQyydOTtFYf9cbIdnUjYLi5SLMd+5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YysT1mX3ZbDmxaZz79QSRrkiKQhnj10FRhOljHJ64QeLPFdsUNZ
	0tR1pHUz6flA/tapRnWWO+cIrwPk9i0gEZJjM2sExYWrqmrWG8CCnvjdProItoW5IQQmDqQIAH5
	bT1gS/ox3SL49OfoTcxeiMlQIpu+egGPH92811yBUP/8NBQb/BHEyliI=
X-Gm-Gg: ASbGncuXgui36+00bga5m4IraMJN7ViLjZjVz6O24G0uHPAaawm2Ot2gJNwB5JU93RQ
	LKEtM1dTJF+bU4fzSqi7k4jRJqPrr/CKpAO+6Rm5MvKBR3nMA7q2hfJcaq3j8LU+LETyrWcX64Y
	0GOQ4O4zYZZEeAM8dj9apYa+/YTkmlkGGKa+8=
X-Google-Smtp-Source: AGHT+IH0eaLgh+XEDCWC3SYaInWPdIV9YE7cJpJB2zom7UsiOlycuB30zhF8t9x6msXH3oGPL8h6ICGxTYOXbXt0l5c=
X-Received: by 2002:ac8:5d52:0:b0:476:7327:383e with SMTP id
 d75a77b69052e-4767327436emr891981cf.13.1741416098891; Fri, 07 Mar 2025
 22:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308044726.1193222-1-sdf@fomichev.me>
In-Reply-To: <20250308044726.1193222-1-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 8 Mar 2025 07:41:28 +0100
X-Gm-Features: AQ5f1Jo-nG_abX2mxVG0F6FyAQP3SKkSj2fRU5w8sH3E0_u7XuD1N8-7npTR7nI
Message-ID: <CANn89iLV6mLh8mWhYket7gBWTX+3TcCrJDA4EU5YU4ebV2nPYw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: revert to lockless TC_SETUP_BLOCK and TC_SETUP_FT
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, horms@kernel.org, 
	corbet@lwn.net, andrew+netdev@lunn.ch, pablo@netfilter.org, 
	kadlec@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 5:47=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me>=
 wrote:
>
> There is a couple of places from which we can arrive to ndo_setup_tc
> with TC_SETUP_BLOCK/TC_SETUP_FT:
> - netlink
> - netlink notifier
> - netdev notifier
>
> Locking netdev too deep in this call chain seems to be problematic
> (especially assuming some/all of the call_netdevice_notifiers
> NETDEV_UNREGISTER) might soon be running with the instance lock).
> Revert to lockless ndo_setup_tc for TC_SETUP_BLOCK/TC_SETUP_FT. NFT
> framework already takes care of most of the locking. Document
> the assumptions.
>


>
> Fixes: c4f0f30b424e ("net: hold netdev instance lock during nft ndo_setup=
_tc")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

I think you forgot to mention syzbot.

Reported-by: syzbot+0afb4bcf91e5a1afdcad@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67cb88d1.050a0220.d8275.022d.GAE@goo=
gle.com/T/#u

Thanks.

