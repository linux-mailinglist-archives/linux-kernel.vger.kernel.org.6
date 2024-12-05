Return-Path: <linux-kernel+bounces-432779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5689E503B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A70281981
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136041D357B;
	Thu,  5 Dec 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQXisr+p"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DDE1CF7AF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388636; cv=none; b=tQ/ZDUeWZef3j+mo5v32hHsgdEEjgkV1BzKPPfjDvdQSvjtMqQe8wfvowqf3/iVKEw6PwPMi5jTgN7+D5IG+nmczj6hHXWeggWvyEoloqj6ukQsHENECRLgqyBsqR1fWM43YRgGhumUWMajy4GzjUdTjKJG7Dt+cbhEQU0DDeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388636; c=relaxed/simple;
	bh=j/m0UPXMsKQrYD9d8ddoEx05ZLKsRfgAsCZuyjezaik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oq0CYFm2LsJCoJLWKqLlUtoQoz+f7gIMje9jHMsXua76oTbHcX5ea7QY1pdWFmO14O3uSVsjAYxZ6k3LeVkqT0dSs1qa0V3i0Xf0MHrWMPIXARAKrvnuT5v9cTbhkdcFZt8IxycKzEYcR4JEITeQw38A7T6UQyuD21Ao7eH2+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQXisr+p; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee4f78493aso537235a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 00:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733388634; x=1733993434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m6k/n43Jh5sqlQ7n3aLi7VnP/EOz+MXchs7oB6O8o0=;
        b=BQXisr+pe4gINeSthZ+quddSSsARD7lq8+M+7XX7HtddP84UW4CCx/eNUXVcJlHnAk
         c+VDWZa1lUUGBHrgcQtYgG+JBs8i78cxDwAgPsJxqpNH0Fve1GDy8GbomGvK7r0ev/mU
         FtbOPowtQqWRxg1m7n3G0P4fS9Ocw8jgD2/NQJMdxk9tb/E3PQ1Yt+hdfARVB3hxP2xP
         sIII48D3B9Rt1fAtxOD02kudsoQg7Aj20W6EWq30b4WHBTLicmV9jHN06XzGr7jctpSa
         5zm4q0DVhPrb0KsuJKlLQJjNHEpuAmm0a/InFcElGHvFoEUw2xvlnfrDpAyj9r2+I/Wt
         glmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733388634; x=1733993434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3m6k/n43Jh5sqlQ7n3aLi7VnP/EOz+MXchs7oB6O8o0=;
        b=nxxfrZo0NJk3w7uxUPbXBkb0Q3ufuU+MlayhU6hFOtuOyDKZU/ivaVV6dhgkOfB4GT
         38KAAsve4Up0zIC/f9AmLUzNhL4ey3461lnKv9XUfwoGOHsGey7XEZek3LEQrGwqegYb
         70c/CnuHS4HSgsYrxVdBe5RHgg0J9ZIFmphf3yIr0jrDFlpSjBIaqc4tIDEsLtC4I17i
         VU89Z3+HQhrLQCxQTyz1CB44EMoqKzAVdlJQFKX1/ssQFjU7c9nfnYbyVje+v4ql1MSm
         zJYuQlzbTUByeMCvuZyGIqaXqlkHDi08oxgbdkSHNzXBMCkS6agngHpnze7dD97H2mTE
         dZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdE2uJFJD+wfp0oA86Q9YEjyGN/7rbxwi/z1I7O13cXaWpHxur6+5ffHIvvW0fw8fKHhcPDT8nlwozfVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXJSjf5Z2RVVkRd0sQF7+GBCYQ95EGmW6H458ncrAJ7vMAGnhn
	kwb+4bGOapX8OEM593pIk4wAPCJAOBjQU9l+uOglpSiBFf99qJY+ahuw9ZlpVxZqhAg5itRDwcQ
	M0XrC1i9d+xNEO29wcF32kNqyo94RuQPIiTGG
X-Gm-Gg: ASbGncujiqZLEuLcIC190VIc5sLOUcb3HRV9tqdXBWHTIVdIz3qmWrTBcO7yqwfxaJw
	A4dJ8Tz6VyYISxiIKVMt8cl7ty4yNM6d/uEV9oFdCsR5DnjUGQW8SdtSHWiBKMQ==
X-Google-Smtp-Source: AGHT+IGDqjvjpP1LquBhwUILfI5GvXDrluDKyihDOfFq7WkEdDILd9Un2OXx2rTqJ+eRaFheNPrMW+7PvpziFj+P5Eg=
X-Received: by 2002:a17:90b:3890:b0:2ee:96a5:721c with SMTP id
 98e67ed59e1d1-2ef0120f308mr10246639a91.21.1733388633922; Thu, 05 Dec 2024
 00:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6751189a.050a0220.17bd51.0084.GAE@google.com> <f7ea7d2ea6efebf66a6c5a27409ac76e404c7241.1733387703.git.xiaopei01@kylinos.cn>
In-Reply-To: <f7ea7d2ea6efebf66a6c5a27409ac76e404c7241.1733387703.git.xiaopei01@kylinos.cn>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 5 Dec 2024 09:50:22 +0100
Message-ID: <CANp29Y7kk8TqW9a7jP1hjH+2OxvObHHYz9vEVTjO0Ud75MkVNg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] TEST
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pei,

Please note that if you want syzbot to test your patch, you need to
explicitly tell it about that:

https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patc=
hes

--=20
Aleksandr

On Thu, Dec 5, 2024 at 9:44=E2=80=AFAM Pei Xiao <xiaopei01@kylinos.cn> wrot=
e:
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index b31192d473d0..bbc86b7dce07 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5519,8 +5519,12 @@ static void mgmt_remove_adv_monitor_complete(struc=
t hci_dev *hdev,
>  {
>         struct mgmt_rp_remove_adv_monitor rp;
>         struct mgmt_pending_cmd *cmd =3D data;
> -       struct mgmt_cp_remove_adv_monitor *cp =3D cmd->param;
> +       struct mgmt_cp_remove_adv_monitor *cp;
> +
> +       if (cmd !=3D pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
> +               return -ECANCELED;
>
> +       cp =3D cmd->param;
>         hci_dev_lock(hdev);
>
>         rp.monitor_handle =3D cp->monitor_handle;
> @@ -5540,8 +5544,14 @@ static void mgmt_remove_adv_monitor_complete(struc=
t hci_dev *hdev,
>  static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data=
)
>  {
>         struct mgmt_pending_cmd *cmd =3D data;
> -       struct mgmt_cp_remove_adv_monitor *cp =3D cmd->param;
> -       u16 handle =3D __le16_to_cpu(cp->monitor_handle);
> +       struct mgmt_cp_remove_adv_monitor *cp;
> +       u16 handle;
> +
> +       if (cmd !=3D pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
> +               return -ECANCELED;
> +
> +       cp =3D cmd->param;
> +       handle =3D __le16_to_cpu(cp->monitor_handle);
>
>         if (!handle)
>                 return hci_remove_all_adv_monitor(hdev);
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/f7ea7d2ea6efebf66a6c5a27409ac76e404c7241.1733387703.git.xiaopei01%40k=
ylinos.cn.

