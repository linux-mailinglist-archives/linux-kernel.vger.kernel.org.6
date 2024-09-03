Return-Path: <linux-kernel+bounces-313579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89A96A736
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05B21F25206
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6090F187561;
	Tue,  3 Sep 2024 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoVaSlnn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333B1D5CC8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391092; cv=none; b=FB9ZVZCx7lLm3S72vlIcqrFm6AfuFgivbU6L1N7cktZKq/MN/igHG52OZi6C+2pVNqsD95LqdO7kxwdK9bR8RjV+x2KF5sZGH6nvKIVRVz8YSt5Z4tgjlhnSTg9b1061jfa7ijiuYpsBuuTVGSEbNvdqoudjzWP8pNJMhUz6Ong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391092; c=relaxed/simple;
	bh=H0STF5gGVbpHjJxcaZi15e59qY13oqe6Zquwi5vKee0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsRv+RU3b2rm4FvTeWY/nCbMuxCWi3YyytFgK7DYJ1FWRx3QvFyEzBwONxVu4ZKJaQIIlm/mu+jCb0t1I4Qb3Zx0wFVfZ1UlZkBeGnajTe9p2pViWyNr8Wf0IapTXj+cLkr16dL6dYFcs+t45lCU3LD73/tNUIHGZ3EBI2khayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoVaSlnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48770C4CEC5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391092;
	bh=H0STF5gGVbpHjJxcaZi15e59qY13oqe6Zquwi5vKee0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WoVaSlnngdYuggzOwSXxyrzpNEL2Uos4kDJj0ZlHlykKNVAVHKu1f3KH02S2AEejQ
	 IaMpIuVv3hcean8MF/eXFEj3tonkE3mt5wA+TqZsG70/PyowSU1SoNHVkPoTCd1TNO
	 rZD2Q2bGM10JbSIKHv0x/WAHaWgjuArMnqTgaiXVFUGZObCMx0C/VU50jeX6/88VIi
	 AmAzsX7k/OF8nB04H23BoIruXXouhq8vrF8wrHomypLjW9b2ooqiN5jJ8U/JUboKLR
	 Jchc/D1E9foEteXegqdl7qJTJhM44r/8Ao/6Mh9KlSEcvNS/KgU2COpN66r4rPXqJF
	 DQJLFxJQeGinQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533488ffaddso7086610e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:18:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YwuyYasMtxpSi73+Q0zW80Ty1xhWNT6J/yUrnQRL/HHxh5avfwo
	k5PIKpAngm5xO4HrH38tG1BaC44R6Siw5TSpAvyIJiKV1gncXwme+0zlxO0EEMZ/TMTl2R7sLof
	A86ViAx0mFxmW1iBdQvPxG9M5tA==
X-Google-Smtp-Source: AGHT+IEZQxL0WSRJ7yKHwE3ewZv68EXUMRQsPoX/N7CFhrbBXxS3I/480Ilgja95RNHhKrK7RONJARhK47j+PRh6icc=
X-Received: by 2002:a05:6512:398c:b0:530:9d86:6322 with SMTP id
 2adb3069b0e04-53546b8d897mr10488763e87.41.1725391090632; Tue, 03 Sep 2024
 12:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731201608.1840977-1-robh@kernel.org>
In-Reply-To: <20240731201608.1840977-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Sep 2024 14:17:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLzpDC42G35TDjgQpDCJhmy6_oQxG97uut9VKdYCHi_NQ@mail.gmail.com>
Message-ID: <CAL_JsqLzpDC42G35TDjgQpDCJhmy6_oQxG97uut9VKdYCHi_NQ@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Use of_property_match_string() instead of open-coding
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 3:16=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> Use of_property_match_string() instead of open-coding the search. With
> this, of_get_property() can be removed as there is no need to check for
> "mbox-names" presence first.
>
> This is part of a larger effort to remove callers of of_get_property()
> and similar functions. of_get_property() leaks the DT property data
> pointer which is a problem for dynamically allocated nodes which may
> be freed.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/mailbox/mailbox.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)

Ping!

>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index ebff3baf3045..d3d26a2c9895 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -450,30 +450,20 @@ struct mbox_chan *mbox_request_channel_byname(struc=
t mbox_client *cl,
>                                               const char *name)
>  {
>         struct device_node *np =3D cl->dev->of_node;
> -       struct property *prop;
> -       const char *mbox_name;
> -       int index =3D 0;
> +       int index;
>
>         if (!np) {
>                 dev_err(cl->dev, "%s() currently only supports DT\n", __f=
unc__);
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (!of_get_property(np, "mbox-names", NULL)) {
> -               dev_err(cl->dev,
> -                       "%s() requires an \"mbox-names\" property\n", __f=
unc__);
> +       index =3D of_property_match_string(np, "mbox-names", name);
> +       if (index < 0) {
> +               dev_err(cl->dev, "%s() could not locate channel named \"%=
s\"\n",
> +                       __func__, name);
>                 return ERR_PTR(-EINVAL);
>         }
> -
> -       of_property_for_each_string(np, "mbox-names", prop, mbox_name) {
> -               if (!strncmp(name, mbox_name, strlen(name)))
> -                       return mbox_request_channel(cl, index);
> -               index++;
> -       }
> -
> -       dev_err(cl->dev, "%s() could not locate channel named \"%s\"\n",
> -               __func__, name);
> -       return ERR_PTR(-EINVAL);
> +       return mbox_request_channel(cl, index);
>  }
>  EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
>
> --
> 2.43.0
>

