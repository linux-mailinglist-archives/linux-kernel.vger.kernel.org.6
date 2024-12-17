Return-Path: <linux-kernel+bounces-449520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742B29F5039
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DCE16FD88
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B1B1F8AC0;
	Tue, 17 Dec 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIodXlFg"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF31F8938
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450442; cv=none; b=qRgwalmQdGF9iLopwVl7RR5rpE4jWvEKsi/RVsYd6kMezML2FSg/QKtK/XeeiQB3gQRCDVnAPtradb1CSBlr3A3R7XnhbxnNHJbO2szm/gjvMOxXQRfurQaUdrAVjPiQ5R2WGK3GWnh6rcSu+Y/PLCTfk37QYkak7HDvN8p0SYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450442; c=relaxed/simple;
	bh=SmsffRxiHrvcbmtv13M6U+b/+RcItZvvBWNEaOjqyKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfVwX/xQRnqodaW12yqORZr+s8MIFLWGDa3SyTWL6uN6x8Iqwlhj5CVpQUy5JiGsb8PSt2d63yfC1t1qDI/Yhs2E+PlH8Dgen8PLEycRA86+yG2PgmbwA1ItLKqfbzXsTO49YSpA41ym/EvHUa+XaAZGuOsYAIOe6+rzd52VGD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mIodXlFg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so9183988a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734450439; x=1735055239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmTBwLz765G6la21hd3l68WxQOcuNECsxaNLvoKan0o=;
        b=mIodXlFgXePcnpecKH5Y+NckXRqmirTARIsqOgWuENMytDg9QwcwAQ9ROO3xTDGpHx
         PjiO3Gq8yJyV1MAx+B1wHpxUkOyilMTh1a0lJR9PpBPUFPG/5tjGCZOUiLv0ots68nQA
         6sXk3LK3/FHYNKiX0ga1zsJ7TmTNXgQY9RfUN9p7yhndmvFOR5wgpH7UddQMQR71L5mz
         rTH5/k8bq5SwBu5yWCKuh4MfkR1sDuOY3A+DM/3Lflb9LYkcDzaLubOu+8t6rmH55tFT
         i++68Hrm/0buKChODffGO/chvREMhzL1WSu4uZ+aMF2AbsyDV5YlcYj1tfx6ED/HNLUC
         oolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734450439; x=1735055239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmTBwLz765G6la21hd3l68WxQOcuNECsxaNLvoKan0o=;
        b=usjY5HeH0OlK/g4IxjNIIX6e6lt+NfuubgvCYhuSJJbboOEtrvOuCJuhvwC33BFor5
         HRvI7Lxvycm7DHUOwnjcqhU4BsxZSVEt407vDmPYZh3pk9jFarx6mlxVLMFq3qeM6IN7
         i0V5s1PycmF52Xf+5pxy91RDF90MNXcp4gUkUH9LRKSQzzzzCcC4t71K7NMECkSzyl4Y
         5LpgT8wvZWSj0xPAImZ+FEKUt7TxSLXp42SlTwYKahFpUdio5lLaMQcMc502CYKdgkta
         dai9pf/jHFKaduF9nrPsabuMjJp2SoknT2dHiNTGgrcDkpIS7dZRZTlyNWh1WuOcZWU8
         yCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrLUAswuztTAJNELW/Rmu/zCuwalbOYfP9eCKUt59tw0YSrWBOZ5wD/U3ha+s+OobnogZ4JWSSFyL3j0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs89lSjFsrpiMuHjd9fnJKa8P6+Ahx75kY2GhvK4wxKQ7fhDlN
	4qUwHdEJmaCXoKQqOOWnRG1doZidscodiH+2cH/K3kBjxBmTMUopIWu/g/P0cFmLpTWlJYpo3sk
	udvQI59c8DF7BYzVeZlLaVK0ohOi0I/iry/3V
X-Gm-Gg: ASbGncsjzx4fPW+z36b5u5syF6qSAM+5uqCdQDEDp53rLlVzs4e/VFXbboPcGs+u12g
	i3CfKxd+bp7AobKLfZiZczDvD2P3d2mocHlqumxxmozDLnmsodiJk7cwQGzx35ZiIZt7W2avM
X-Google-Smtp-Source: AGHT+IE+A4Ntq5Co36HwJSOWn+xlmSxN3h9rnUqF/TS4fcTTdHu/vzmGmttm6hfPGlLzDLJlX2V/Il03N+f7M4BkZmg=
X-Received: by 2002:a05:6402:43c6:b0:5d1:f009:9266 with SMTP id
 4fb4d7f45d1cf-5d63c2f8266mr15551047a12.2.1734450438574; Tue, 17 Dec 2024
 07:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217140323.782346-1-kory.maincent@bootlin.com>
In-Reply-To: <20241217140323.782346-1-kory.maincent@bootlin.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 16:47:07 +0100
Message-ID: <CANn89iJ3sax3eRDPCF+sgk4FQzTn45eFuz+c+tE9sD+gE_f4jA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethtool: Fix suspicious rcu_dereference usage
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com, 
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 3:03=E2=80=AFPM Kory Maincent <kory.maincent@bootli=
n.com> wrote:
>
> The __ethtool_get_ts_info function can be called with or without the
> rtnl lock held. When the rtnl lock is not held, using rtnl_dereference()
> triggers a warning due to improper lock context.
>
> Replace rtnl_dereference() with rcu_dereference_rtnl() to safely
> dereference the RCU pointer in both scenarios, ensuring proper handling
> regardless of the rtnl lock state.
>
> Reported-by: syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/676147f8.050a0220.37aaf.0154.GAE@g=
oogle.com/
> Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support sev=
eral hwtstamp by net topology")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  net/ethtool/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 02f941f667dd..ec6f2e2caaf9 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -870,7 +870,7 @@ int __ethtool_get_ts_info(struct net_device *dev,
>  {
>         struct hwtstamp_provider *hwprov;
>
> -       hwprov =3D rtnl_dereference(dev->hwprov);
> +       hwprov =3D rcu_dereference_rtnl(dev->hwprov);
>         /* No provider specified, use default behavior */
>         if (!hwprov) {
>                 const struct ethtool_ops *ops =3D dev->ethtool_ops;

I have to ask : Can you tell how this patch has been tested ?

rcu is not held according to syzbot report.

If rtnl and rcu are not held, lockdep will still complain.

