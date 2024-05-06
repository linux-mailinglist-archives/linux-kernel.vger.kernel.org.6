Return-Path: <linux-kernel+bounces-170514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655568BD856
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965BC1C22510
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905F815D5BD;
	Mon,  6 May 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NVPGVK4z"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56E132C1C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039731; cv=none; b=R7Dp8RNOr3WXCWBMSlyd8ZXRXu6S0aBzzUvZwwQo4dWSUzVGml4cqGTkblzTRb+1M4a8jAG+dTjscwxMIaS20zKTjn8afih8PpibfnOD2eLjVhEl92bA6/SEUWfs/kxC0nDOC8mVKOo3J1aHuVqcNFs+T+mEhGKj329mGb9I/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039731; c=relaxed/simple;
	bh=8e4fvsxQ1sJk1bduJ9x+BSERMkzrawAfqNyJMNxFcZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwkNvQGqQm7ItW1jP7QkgH54oIeN/Qxu2Ds+FBqWf2+Q5tGzOV9bCpxEHhB6zjndHFGEhmnQF3uvPWT/qAsY2Z7DBb3MRqrFelrwlFcJko9I2kHfRjRbaJYOaWVuXZgrnAnrwpR4gJDrk/eM7B3Xm5PpjHd4sxF68Irz9EXC/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NVPGVK4z; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso1205185a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 16:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715039729; x=1715644529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8Fn/bjSjXq3GRFqpjbs/zhscOS5fTy8626e704w6fQ=;
        b=NVPGVK4zui6Bt/XfxEwWS5iRLs3F+G5+E9LX5a/M1ubNqNoH4U9+H8Pab0A/y4aiQM
         eArE5XGfTCsFXXxcn6bnFSlNb/a7XQDIpCLZiB5mHdvBRcfsNa66FLhOSrHoiZxkYWr3
         CDLrqCkMFyT+7fHIJOWifJXe+PqFO+XA+NcVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715039729; x=1715644529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8Fn/bjSjXq3GRFqpjbs/zhscOS5fTy8626e704w6fQ=;
        b=o8h/jceI1VTBUJhzJ/8i9V+uJUAc00azzlDFFHpRSaxQwiArLyE2IkJpWL/wlZfrkR
         e2VVLPDxKw2+pT9UeCumjFyJlDfpxw8MsgL1bANYZg49c8PbxjnhsWpbV8ZImTyAW/Aj
         9NMxfg9NGl6YX7x2IIx8634mZdzKkNOMjx1L+/H6lCMGB/EYmtZj1yt4116Ucau3VvSx
         NKrzsbBo4QWDuPLYfjy9TRDZrtydltHc5ae+sks2S0ekujAdvXxjJf1QkKKA1Z8tXUyG
         EfZUpCsUhSxIGonnkJTmbfs7BEXPbDpo/rDE3B45TYdNOATzeAs86tWOd8inBSGbs84h
         XarQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmrp5lSsKW4Y7GtRP2/Kzayuza4zfgbTfAAgC0d53EVNvR6TXy+PMkIY3rJywqnOMCRF6wfIPxB7lCE1br/LL7H8gwmECTJNTPpkMv
X-Gm-Message-State: AOJu0YyeL1RKlqrEmmXzXXoXzZAhe97dHpx58N1A2hwhhuPXC0nq8VPx
	VbobeFQ1dj0eE0Vin4dNVWoGnns8+KJB61NGBxKDUEVmf5oFVKqxFhJWIQZG8XSyz9IEelgXJLD
	zqB8EbjbkmLDkryp2gjze33ngu4TXvqSqgnk=
X-Google-Smtp-Source: AGHT+IGo2YaUuQD9slJOquB7SOCRbBHm03O2JfN5rKbbQI73FcFukWhB/LrIA2VMT3Y8lAHzOmRxn02kFEmO+wLKg4M=
X-Received: by 2002:a05:6a20:1596:b0:1a7:a6d1:2d09 with SMTP id
 h22-20020a056a20159600b001a7a6d12d09mr12588916pzj.55.1715039728903; Mon, 06
 May 2024 16:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430085916.4753-1-hagarhem@amazon.com>
In-Reply-To: <20240430085916.4753-1-hagarhem@amazon.com>
From: Vishnu Dasa <vishnu.dasa@broadcom.com>
Date: Mon, 6 May 2024 16:55:17 -0700
Message-ID: <CAF+opq1LksoebDGY6BGtVoD1FS6ujuJaEJMY0AOP1c3C6KJy0g@mail.gmail.com>
Subject: Re: [PATCH v4] vmci: prevent speculation leaks by sanitizing event in event_deliver()
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: Maximilian Heyne <mheyne@amazon.de>, Norbert Manthey <nmanthey@amazon.de>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dtor@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Andy king <acking@vmware.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 2:02=E2=80=AFAM Hagar Hemdan <hagarhem@amazon.com> =
wrote:
>
> From: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
>
> Coverity spotted that event_msg is controlled by user-space,
> event_msg->event_data.event is passed to event_deliver() and used
> as an index without sanitization.
>
> This change ensures that the event index is sanitized to mitigate any
> possibility of speculative information leaks.
>
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
>
> Only compile tested, no access to HW.
>
> Fixes: 1d990201f9bb ("VMCI: event handling implementation.")
> Signed-off-by: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>

Acked-by: Vishnu Dasa <vishnu.dasa@broadcom.com>

> ---
> v4: Added the testing state in the commit message and rebased on top of
> latest mainline
> ---
>  drivers/misc/vmw_vmci/vmci_event.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/v=
mci_event.c
> index 5d7ac07623c2..9a41ab65378d 100644
> --- a/drivers/misc/vmw_vmci/vmci_event.c
> +++ b/drivers/misc/vmw_vmci/vmci_event.c
> @@ -9,6 +9,7 @@
>  #include <linux/vmw_vmci_api.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/nospec.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/rculist.h>
> @@ -86,9 +87,12 @@ static void event_deliver(struct vmci_event_msg *event=
_msg)
>  {
>         struct vmci_subscription *cur;
>         struct list_head *subscriber_list;
> +       u32 sanitized_event, max_vmci_event;
>
>         rcu_read_lock();
> -       subscriber_list =3D &subscriber_array[event_msg->event_data.event=
];
> +       max_vmci_event =3D ARRAY_SIZE(subscriber_array);
> +       sanitized_event =3D array_index_nospec(event_msg->event_data.even=
t, max_vmci_event);
> +       subscriber_list =3D &subscriber_array[sanitized_event];
>         list_for_each_entry_rcu(cur, subscriber_list, node) {
>                 cur->callback(cur->id, &event_msg->event_data,
>                               cur->callback_data);
> --
> 2.40.1
>

