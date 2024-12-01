Return-Path: <linux-kernel+bounces-426595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDEF9DF569
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 12:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA2F2811E6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 11:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A42A1482E2;
	Sun,  1 Dec 2024 11:40:31 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4054740;
	Sun,  1 Dec 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733053230; cv=none; b=fRo7+zEXkohzglakFNkN1wZw3plQ8IIjuOooNQ4bEF/m5jMN9/gEpuSAOZ/BhG8Xxfic9xw/lQ9blxAoAjVat/dZzzRQUD+WvWNKC4On99FXGy4HUybFGh/nLSkgdP+AaU2honZut/5HOEk4Ruo2bbfrXkr/2bdT14zmHcLNrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733053230; c=relaxed/simple;
	bh=iWDNxsHrtPUAlk41QnqhB0130Fqs3XG4xoKA/cJ90Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRqBnsEucHZHZSwJmL1MzZJd2Em01YOM4FDpWkN7XKZite5d6b7y/t64duT2P7aLMMMawcX85x/201UyAUMozlBbAAv9aohhIWxDTdjFAZyyo5MBB2a30JLM5CP/hjR4hmGzcFIwolN7LQqu+4t7lMxJfqW3KYbVSS1KlPQ39aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85bc6a1a48cso320760241.0;
        Sun, 01 Dec 2024 03:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733053226; x=1733658026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX9mEwT8YtZcUIRrMMSNryCoxMkOz3X92NPDWa+V9e4=;
        b=Kjq0almmQmIpQUl30wPjmSezzaz3e/ZznMqyFj/VPt2x8hkkbdJYCJcPibLQwIPxZm
         LVQjedUDA/l8nXIUxygrcW3h5mxlJ51uhxgsKY+iQrqycc9gn2f4jY45e2WRPe+4NCcF
         fS9z84qtL8/TqfKA1t2MU9504oR/zl9Urc4MpsrVvJMK0wBxnlM1B3QnzVnDE95B/8P3
         OauwNIaFVmVXyqLYd9fb8ouon49mVJtIgwcqnewYzylXcJprIr6yUX7rwIGYvC0Imyg+
         /IxSEbpCQrr3FUQg8TVE4CI0pbdrLOP0T9weeoizxO/j/IFrciTRy1he02NlYvQvtIOo
         nk6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS6hbnKFonrobAuJvIMPJ1lGFIHPybQIH9IFB6i+Zl5SjLhb88MRQ3fm7kuDxw9v827pB9mbB62/jR5oQg0g==@vger.kernel.org, AJvYcCVLIDuzsfrg1EZ4lFWueujV0Kj0IhLQEQuXxmqEP3siG4C3JJuz5SisOF/J8trU964YYZ5FVuqRl+1mBXws@vger.kernel.org
X-Gm-Message-State: AOJu0YxRLYxnKp4kgWqmyjUMI/me3TaG8tAazl3marxbQRZKKeCql97C
	EXO1g0J8L95kt4zH1PfUnajRD8QTEWpjTFKcQpvoaYEnrnVskB7QpZxua69z
X-Gm-Gg: ASbGncuzhUJI5UFFWAVVD3V8k3NDCdiBo6YdmrKLCfsgv3jhqAw35Z0Wo7r8thUHxX8
	V0VMv3t4NUb6BNFRBQ/fGTlc5J3HcF3+vwc7g1vkR68AwB/Cgl+xz2IFnxkOmfNctKV/GGCDOIg
	ie7ScJa4LUuDNXrS5/9u3Js8hOVJBcUh2YewZmpgo8yiIPERn8csG9fec1h6+CqTZac4W8S/gn9
	1oeQksoZqIAjMKjCaNEWRJo2F4qGVuqwV75sktOL1BHNY0Fe/ExGQKeo8veSFPoIi3gFIzJSZcC
	IpTt7j6nsITs
X-Google-Smtp-Source: AGHT+IHascmDbNafGnGK8lj23dTOxLf+AZbmnyT2Hx2mP0f+fMrmH0A4aI1fL8zokOZGPEUxgz36HQ==
X-Received: by 2002:a05:6102:c51:b0:4ae:f51c:6f2e with SMTP id ada2fe7eead31-4af55647043mr15933312137.6.1733053226346;
        Sun, 01 Dec 2024 03:40:26 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af58ef585dsm1475539137.0.2024.12.01.03.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 03:40:26 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-85ba8b1c7b9so832340241.1;
        Sun, 01 Dec 2024 03:40:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWO2SIK/Fe3mKFda7RF0iFSL7T6j62HRazWwytp9vpZRV6TaWXBxk9GfDzkjvW/JotE45WqH1GaCC+ewNrdzQ==@vger.kernel.org, AJvYcCXiB+V1dCXMcD0kCH0qpwd+l2oEbTFDhpm0n6StQ1s/1xgv70g8Zogur9whgBhxnNkI3xHvCYIdSRd1n2EW@vger.kernel.org
X-Received: by 2002:a05:6102:3748:b0:4af:14e6:a45f with SMTP id
 ada2fe7eead31-4af556c3502mr16151212137.9.1733053225922; Sun, 01 Dec 2024
 03:40:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930184826.3595221-1-isaacmanjarres@google.com> <ZvwZV5MDlQYGJv9N@pathway.suse.cz>
In-Reply-To: <ZvwZV5MDlQYGJv9N@pathway.suse.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 1 Dec 2024 12:40:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX_r05iUFw6-Jj8Utry5bHdE6=U46uB4Za1NTsdZOuOMw@mail.gmail.com>
Message-ID: <CAMuHMdX_r05iUFw6-Jj8Utry5bHdE6=U46uB4Za1NTsdZOuOMw@mail.gmail.com>
Subject: Re: [PATCH v2] printk: Improve memory usage logging during boot
To: Petr Mladek <pmladek@suse.com>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, surenb@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Linux Embedded <linux-embedded@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr et al,

CC linux-embedded

On Tue, Oct 1, 2024 at 5:55=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
> On Mon 2024-09-30 11:48:24, Isaac J. Manjarres wrote:
> > When the initial printk ring buffer size is updated, setup_log_buf()
> > allocates a new ring buffer, as well as a set of meta-data structures
> > for the new ring buffer. The function also emits the new size of the
> > ring buffer, but not the size of the meta-data structures.
> >
> > This makes it difficult to assess how changing the log buffer size
> > impacts memory usage during boot.
> >
> > For instance, increasing the ring buffer size from 512 KB to 1 MB
> > through the command line yields an increase of 2304 KB in reserved
> > memory at boot, while the only obvious change is the 512 KB
> > difference in the ring buffer sizes:
> >
> > log_buf_len=3D512K:
> >
> > printk: log_buf_len: 524288 bytes
> > Memory: ... (... 733252K reserved ...)
> >
> > log_buf_len=3D1M:
> >
> > printk: log_buf_len: 1048576 bytes
> > Memory: ... (... 735556K reserved ...)
> >
> > This is because of how the size of the meta-data structures scale with
> > the size of the ring buffer.
> >
> > Even when there aren't changes to the printk ring buffer size (i.e. the
> > initial size =3D=3D  1 << CONFIG_LOG_BUF_SHIFT), it is impossible to te=
ll
> > how much memory is consumed by the printk ring buffer during boot.
> >
> > Therefore, unconditionally log the sizes of the printk ring buffer
> > and its meta-data structures, so that it's easier to understand
> > how changing the log buffer size (either through the command line or
> > by changing CONFIG_LOG_BUF_SHIFT) affects boot time memory usage.
> >
> > With the new logs, it is much easier to see exactly why the memory
> > increased by 2304 KB:
> >
> > log_buf_len=3D512K:
> >
> > printk: log_buf_len: 524288 bytes
> > printk: prb_descs size: 393216 bytes
> > printk: printk_infos size: 1441792 bytes
>
> This should get updated to the new format.
> If I count correctly then it should be:
>
> printk: log buffer data + meta data: 524288 + 1835008 =3D 2359296 bytes
>
> > Memory: ... (... 733252K reserved ...)
> >
> > log_buf_len=3D1M:
> >
> > printk: log_buf_len: 1048576 bytes
> > printk: prb_descs size: 786432 bytes
> > printk: printk_infos size: 2883584 bytes
>
> and here:
>
> printk: log buffer data + meta data: 1048576 + 3670016 =3D 4718592 bytes

Thanks, this is very useful information!

Isn't this kernel log message bookkeeping becoming a bit too excessive?
E.g. on a small system:

    printk: log buffer data + meta data: 65536 + 204800 =3D 270336 bytes

Why is the meta data that big (> 3*log buffer)?

    #define PRB_AVGBITS 5    /* 32 character average length */

    unsigned int descs_count =3D log_buf_len >> PRB_AVGBITS;
    meta_data_size =3D descs_count * (sizeof(struct prb_desc) +
sizeof(struct printk_info));

    struct prb_data_blk_lpos {
            unsigned long   begin;
            unsigned long   next;
    };

    struct prb_desc {
            atomic_long_t                   state_var;
            struct prb_data_blk_lpos        text_blk_lpos;
    };

i.e. 12 bytes on 32-bit, 24 bytes on 64-bit.

    #define PRINTK_INFO_SUBSYSTEM_LEN       16
    #define PRINTK_INFO_DEVICE_LEN          48

    struct dev_printk_info {
            char subsystem[PRINTK_INFO_SUBSYSTEM_LEN];
            char device[PRINTK_INFO_DEVICE_LEN];
    };

    struct printk_info {
            u64     seq;            /* sequence number */
            u64     ts_nsec;        /* timestamp in nanoseconds */
            u16     text_len;       /* length of text message */
            u8      facility;       /* syslog facility */
            u8      flags:5;        /* internal record flags */
            u8      level:3;        /* syslog level */
            u32     caller_id;      /* thread id or processor id */

            struct dev_printk_info  dev_info;
    };

for a whopping 88 bytes.  So that totals to 100 bytes per entry
on 32-bit, and 112 on 64-bit, for an average of 32 characters per
printed message...

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

