Return-Path: <linux-kernel+bounces-335516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5F897E6CA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4E61F2104D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735774778C;
	Mon, 23 Sep 2024 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjtyHXJB"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2318039
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077537; cv=none; b=IESYrt3Ungs+XV5nCrLY8Tp6tQLTBSnPz9I+UrZWrGDRhky0J2r+TcoGV+uyzFtCRSIdRgtSPylN88nYPwzdVmwDuxR4p2Y1uEsXZE3/QS8lhMKpj89tgDuCqeyTo729UyXd2JGc/uL1A8u8IaJhwnI3QJu2XsSIA6Povmjj1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077537; c=relaxed/simple;
	bh=QrQXKavQ3kAABvu7IsbQ/w0uI/OqFs7EBjA3NkiLJ9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/tPIt0HhJQpoeWubLFbnadYzH0Ha1VKhZjCtkkN0owvJbk4HWdyEahdB4wt8NSY/e1BceMz+ikimyAGAyR6kYqB6CGmjfx54NDozSdJMfbNz7fSVbXAwrvqTchnUZQAZO/nWd3qWCfbzkezciErwgt0DjPmF4QL4BM2onpQ2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjtyHXJB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso1778954a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727077534; x=1727682334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtumo6vJ3j8mdCTUgzYikqHbLFWBv6wsqW8Um5r7las=;
        b=LjtyHXJBEAnZ9MTHfi2W6OEck0SbYHoeeT/lebINzw+PlvWNRrOSI4RQDP2dUk8Heg
         oL6NuqYR61ns6gVLGgOWqXC/WySrCyEwpi5R395cRt2jYZBzKv73buP12NaWanb8FnzL
         E3Pmo56JF5lmPPr1HXss4J7SHcnhxD8e9sEuB0jLtVGH0ObHASnNYtpT+BDf+GDWQBqj
         wpp5IDCABJTWd8YZNT5k8zn7A8BCaxRa5tMPxtAYaOQ8edrED5Ih63ASifQCrgG/E9TO
         NDQDdDGP5yRVU/xglG2K/WwX1PYC3o7bD5owOM0U39CgHkaJQZlo5kSziQMrt6aCIiER
         QvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727077534; x=1727682334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtumo6vJ3j8mdCTUgzYikqHbLFWBv6wsqW8Um5r7las=;
        b=OBUp2q5657rYpBkJHv8KVoADShXVr8ixlY3R803phgeVITdOiJ8qmbb7b8P7K102c4
         f0RGz+CQ10K+1JBTdD3qjuQvcgR87QvUBSJB4+CR848JJvZ2+7fyiaqOS2yExidRLFzg
         Sef52JBwIccZc1W5GBQhj3Q0eofqYMpVDcYmizcIGON6sT382OsFGXPI86EApzs8mdnS
         Kgz+6/MC5zzvFme0JKdvp2JDNoBGjMimWkDUppaHLapN6w7aRLfNUy7JTSW4Aii2umOi
         XQctqLxersLxX8eGo9InWCTG0KxPfFYvLmGmPAGUk7swtaLBlPfrEscak2MOieqSX98O
         HCYA==
X-Forwarded-Encrypted: i=1; AJvYcCVrHpyUAmnZBCNr2QESjEnXfhrfW0stmSUPsFtXlvK5mQ3g9IsBwC7kHhA0G8bmx2Wihp6zknvoKUghiNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXftijuiz5ZGk9KNnp9UCUi08ADL85oH+vOuFxxo3Jar9x5t0
	CCcZddkxqVhARSe7SDQfH4ZoJSSBFIk9fKHp/NHTliKzkD9wJzK39eJuIQ+VzPNrePbWnYH8J6L
	eyoIWzE9JpGgvLTI282cbKMzsBKSjt56tV/98
X-Google-Smtp-Source: AGHT+IEDzuCBAfmmgyAaScURt34uswQWh04lq4DlOHTmMt1iJsKsfOdPvYgM+YV4rL0rd6uyFkzu29hioKHFLOazdqo=
X-Received: by 2002:a05:6402:3506:b0:5c5:c2a7:d53a with SMTP id
 4fb4d7f45d1cf-5c5c2a7d69amr2000932a12.12.1727077534319; Mon, 23 Sep 2024
 00:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923072843.46809-1-liuhangbin@gmail.com>
In-Reply-To: <20240923072843.46809-1-liuhangbin@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 09:45:23 +0200
Message-ID: <CANn89iLoVexJpUbZzwAYtGpLiTZ36tFh5GpJU=mYH6YazJeTPQ@mail.gmail.com>
Subject: Re: [PATCH net] bonding: show slave priority in proc info
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 9:29=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> The slave priority is currently not shown in the proc filesystem, which
> prevents users from retrieving this information via proc. This patch fixe=
s
> the issue by printing the slave priority in the proc filesystem, making i=
t
> accessible to users.
>
> Fixes: 0a2ff7cc8ad4 ("Bonding: add per-port priority for failover re-sele=
ction")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_procfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond=
_procfs.c
> index 7edf72ec816a..8b8580956edd 100644
> --- a/drivers/net/bonding/bond_procfs.c
> +++ b/drivers/net/bonding/bond_procfs.c
> @@ -210,6 +210,7 @@ static void bond_info_show_slave(struct seq_file *seq=
,
>         seq_printf(seq, "Permanent HW addr: %*phC\n",
>                    slave->dev->addr_len, slave->perm_hwaddr);
>         seq_printf(seq, "Slave queue ID: %d\n", READ_ONCE(slave->queue_id=
));
> +       seq_printf(seq, "Slave prio: %d\n", READ_ONCE(slave->prio));
>
>         if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>                 const struct port *port =3D &SLAVE_AD_INFO(slave)->port;
> --
> 2.46.0
>

proc interface is deprecated in favor of rtnl.

slave->prio is correctly reported in IFLA_BOND_SLAVE_PRIO attribute.

No further kernel change is needed.

