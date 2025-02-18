Return-Path: <linux-kernel+bounces-518522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BA1A39065
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 02:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DB9189004D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158A584D34;
	Tue, 18 Feb 2025 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQOPeFUT"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0144BE545
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842378; cv=none; b=Gfy4k5Zy5byB7WSPu02tfzOdVTBFmSb3JG4BItmZdO4vMheETIHH8nVXsIMbucgtZQGAft18R9O90/s36HDLNexKyHybH6f0ILh5vUX4xFEDfo1J7cRFUO93CGP1JlK0QHyiYyz9iyd/CPgm9gb80zFfr00WI7w/TbVByU0FbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842378; c=relaxed/simple;
	bh=XthJhyBKWxl5/8OfBCYvrSGWTL6qBx3i8n+seWfPPvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAkbMxMVeP9H26//W0DdJ/2A8o6kPdh/d2YDlMVtgnnv1XMbPRLrl57Mlq1Q4Ftuiid2/lPQJalMRnHXEiOXnch4RK8vzLJuDmIYgAjr0zk4XhWPiOCA6uuN1waaomtVcuoNrE1LgAJABtUhIELxWNDtOeQUh4N31MkukhUDrW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQOPeFUT; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5dab3f372aso3882264276.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 17:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739842376; x=1740447176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT9cTQ7SYk8M4XCMQJFfLhAN63w/VesJCF78+3guBLg=;
        b=GQOPeFUTtCtqiXkDV99eJN+HpAbSKrPe3/Nhj+u3BeLaHHuo5Tt8MrAYjEl7Yh+neH
         yQ4SxDGdEWFkq7kgPmh/bnjxIMJwMxxWy6FsrKyygGRlQ8dUxxKwDUJW2V4JvJf8sONb
         764HtU2NGzQZaGzfvNM4u3o3+S/m3XOIUHlPQutw4zq90AFBj86qsELYYdXnF0+VUa8q
         QykWOgTWp0A7xUGUe2XROEwlwNX13z7bH+gfEQD8qItOvyjbI/8mQ8GBEg7u22WHstpe
         33M8r7zgxCCMlOcBuW7OeMLzJuwLwwMjh8ov4SEgnm4F55PjUnBk+FGvkzSeQvb5sxWb
         jbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739842376; x=1740447176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oT9cTQ7SYk8M4XCMQJFfLhAN63w/VesJCF78+3guBLg=;
        b=THeihEPWfb0IOFCcClx6cg8GVUJEGdV8CYVqdMBOWPW1SuNm5XxaDG8AzTrILJdvX1
         ZiDs0lWNtCvK4eptLXIbOLa58YJ1IsYUKeog1jwE9hpw7hWvlC5H5AIzaFH61CvmLZXt
         5c7n9Xc31TbdQHDEt1PHfNtpILXffGvgI2aXkijZuxNNDIyfNwODrLaDoofQwsbjg6kq
         IjmMlt3ksaH5YkP+zA4JBxwzoFA9AzW9FHdr/e6w/XDDeOZ/ee6Jg7pocsPRVkI8xmMl
         Y7fSMlx+/RB3vDjVHoTRlQ33XigIddhIPwosIC+lQU0eclMS0D4VxoVK7shVGPIIuzHB
         4ZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuPgIhFycxO6B2tQOhdN6yXD+SPyy1ZP9Sla0A+xExRJl3b5EjjFdJboNa0PlxglwuKR5h5mnS7Z+YGU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVO9xLuVs3HKWLOCNR5hojHrKNDweAicE1qLCV8H0d8+qtksc
	rhDZwZqmipDh+CJ82+ZicUpSVFIVBcO8t1cPcWG6hHGrXOYTdAHdeUCWGOGIllfRn50qybMjp2W
	o9/9kTexzsZ792aaw1bNbTtpMuGB5G+UEdp4j
X-Gm-Gg: ASbGncvn3xGMjTKEQz6IFI0avZiCW+sWZ+BW3yqXBULwrPwh3qJL3gUr9q6T95jm7aR
	1S5VvsonrTzSjV2JNHd64Ht84Anth8L6YPv/aUxsUdGv1xLm9CxKNVrjKdLOr3tcHZSmAO39pHw
	==
X-Google-Smtp-Source: AGHT+IEOxbyZXlsmNukXxVXTJcKreG9LC/L/7hgVrzCaKIT85E/ITWgBLUIONugofALgdPoRDTUarfoslMrxDTHm6AA=
X-Received: by 2002:a05:6902:2492:b0:e5b:1351:ccdd with SMTP id
 3f1490d57ef6-e5dc98df5fcmr8836972276.24.1739842375577; Mon, 17 Feb 2025
 17:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214191709.1.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
In-Reply-To: <20250214191709.1.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
From: Hsin-chen Chuang <chharry@google.com>
Date: Tue, 18 Feb 2025 09:32:29 +0800
X-Gm-Features: AWEUYZkHkNh3wnRYDK_q8m5NNmkXTYr9xtET5ubclWQGd7UFDiTqCDTESnOuPUU
Message-ID: <CADg1FFf8aPk-urK9RUn2pdKQ+=f+9X8K8+nqEA_1g3qUO2ugZQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Always allow SCO packets for user channel
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Fri, Feb 14, 2025 at 7:17=E2=80=AFPM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> The SCO packets from Bluetooth raw socket are now rejected because
> hci_conn_num is left 0. This patch allows such the usecase to enable
> the userspace SCO support.
>
> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control US=
B alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
>  drivers/bluetooth/btusb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 1caf7a071a73..de3fa725d210 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2130,7 +2130,8 @@ static int btusb_send_frame(struct hci_dev *hdev, s=
truct sk_buff *skb)
>                 return submit_or_queue_tx_urb(hdev, urb);
>
>         case HCI_SCODATA_PKT:
> -               if (hci_conn_num(hdev, SCO_LINK) < 1)
> +               if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> +                   hci_conn_num(hdev, SCO_LINK) < 1)
>                         return -ENODEV;
>
>                 urb =3D alloc_isoc_urb(hdev, skb);
> @@ -2604,7 +2605,8 @@ static int btusb_send_frame_intel(struct hci_dev *h=
dev, struct sk_buff *skb)
>                 return submit_or_queue_tx_urb(hdev, urb);
>
>         case HCI_SCODATA_PKT:
> -               if (hci_conn_num(hdev, SCO_LINK) < 1)
> +               if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> +                   hci_conn_num(hdev, SCO_LINK) < 1)
>                         return -ENODEV;
>
>                 urb =3D alloc_isoc_urb(hdev, skb);
> --
> 2.48.1.601.g30ceb7b040-goog
>

Friendly ping for review, thanks.

--=20
Best Regards,
Hsin-chen

