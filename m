Return-Path: <linux-kernel+bounces-350839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8397990A58
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5211F1F21E33
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03C21DAC8C;
	Fri,  4 Oct 2024 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="czXVXQa6"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC415B149
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063960; cv=none; b=KG1B2oMQY4Dvb95DhavDKWvO1zdg33cG1In2QJB2NRKzq+vgSxheDpu6wxFCcvs2EeZIPKig0Ta6HSbXoGNjiQTksemd5G6VtGSxUWo2wjQGQTtHMnG5utZK1tKyxuM5PqjqDIhz4IZBVdT1mwD/37thzzWkoi196rZSNelQI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063960; c=relaxed/simple;
	bh=TI6mcXb4V5s95OY28ThDa+Nttx+DA0b7i9XYbIv6P9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iG1lBPNbsCqZNm3gk+HPGXT83HQqjllZ/cah72m+H4hpXGom9SoYx2uHl4ZU2hp8vcVCZu6r487freZQZC3SGssZLiQ3P4u8iVq0OyTIs0efQMOLacbPWBVZxUWJ8nT/YGwf8h0GWAN23v4xmrva85G3GBG9RteM8mFR8Q04F7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=czXVXQa6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e09fe0a878so1779914a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728063957; x=1728668757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hTEi2pGCxMRGUpF5+1bzMouLoBbQyVgP6nKgujfGZc=;
        b=czXVXQa6G8RKpVl+LXqeGG5NAMDaNjrmc2aFC9su4i+4o2mYNhGVUZuerndqTUKZr3
         s8IGpIJY4nefcD2RayfvF58nsfOXNj/UMjvFhl2ckpP0qbZFnyw/EHW23r4IMwrZBBDD
         qyHmSa1Ru2pqQO/eszofGVSeV91wCIVWWC6cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728063957; x=1728668757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hTEi2pGCxMRGUpF5+1bzMouLoBbQyVgP6nKgujfGZc=;
        b=jt845BCXCUVg68TvL4kb68dBws46ZfkXZwQ9rOw49OLNaSWpUMegVmuFbb5LgZ7yJ8
         G2nfqkIdGrX4Q+M1picjLR/Q/Pfw517W/PjVWGTg3NAfiP/HJM6iXgVNsKm67IXYrPhF
         MqCIbnG9OHRYl5tlC+MSQA6iZBxuLqs0aiLlvJwdStXno+2s6ALfSzfGB/J8xhe69dZV
         hlCU7jDz0JINnu+xilcSUP1qeFjD0pzgNxghd1uMlk/kUtexb1kPYfpEnt4PAAYdHwXU
         pHPQX0PpqDCcM10hdsd0fVTAgzTozvNfi38JnuplD8IIq9lzAvhW8vGgJ3iY/fYRWAsU
         7whA==
X-Forwarded-Encrypted: i=1; AJvYcCVcUMNaP9s/RCVgAhSvENHrI/t43I6AL2lGm43nAqRiXyRg7V++utRFsJAvyrEfmm6ZcuIKo7xuXrk09GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXux4RV0N/+/v3cXpNwqnupSMRFxU44aUmij4hNBif5YGHSrrr
	CCC/buSNmvpFUNNjw+872Xa5V0Htzx4pUXOJzKkH6TjXxd+OMpEZeS5jYDPfv9zTCgaXtron6pc
	=
X-Google-Smtp-Source: AGHT+IFGMFBoNNNard1Lfzi4uue5YCLpWqP+VEeLpPYgy1VhvsvO+TSTaxt80VhsNOKdGw7LbktG9Q==
X-Received: by 2002:a17:90a:d56:b0:2e0:58e8:264a with SMTP id 98e67ed59e1d1-2e1e6296d1amr4592170a91.20.1728063956666;
        Fri, 04 Oct 2024 10:45:56 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e7ec5253sm1130965a91.1.2024.10.04.10.45.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 10:45:54 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso1749075a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 10:45:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/47fHFu6FYVVl1+oUFamFhp2RVTY+0a+goK2XUSTGmUHR3061cKNl8UuUP8dxBU7uv5RPnMsC6mrI3qM=@vger.kernel.org
X-Received: by 2002:a05:6a20:9f8f:b0:1d2:e1b5:2b51 with SMTP id
 adf61e73a8af0-1d6dfa1e516mr5534269637.8.1728063952820; Fri, 04 Oct 2024
 10:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid> <CAJZ5v0hmf55OA1f4egzE7F0ET+7af_+pcxmnOSxO5Snd6L5CrQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hmf55OA1f4egzE7F0ET+7af_+pcxmnOSxO5Snd6L5CrQ@mail.gmail.com>
From: Raul Rangel <rrangel@chromium.org>
Date: Fri, 4 Oct 2024 11:45:39 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CRYoH_-rY7hMgasbkyqEBpgVfH6PZRzuaU=2g4S_oGtA@mail.gmail.com>
Message-ID: <CAHQZ30CRYoH_-rY7hMgasbkyqEBpgVfH6PZRzuaU=2g4S_oGtA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: SPCR: Add support for rev 3
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-serial@vger.kernel.org, pmladek@suse.com, rafael.j.wysocki@intel.com, 
	ribalda@chromium.org, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Sep 12, 2024 at 7:39=E2=80=AFPM Raul E Rangel <rrangel@chromium.o=
rg> wrote:
> >
> > Revision 3 supports specifying the UART input clock. This allows for
> > proper computation of the UART divisor when the baud rate is specified.
> >
> > The earlycon code can accept the following format (See `parse_options`
> > in `earlycon.c`.):
> > * <name>,io|mmio|mmio32|mmio32be,<addr>,<baud>,<uartclk>,<options>
> >
> > This change makes it so the uartclk is passed along if it's defined in
> > the SPCR table.
> >
> > Booting with `earlycon` and a SPCR v3 table that has the uartclk and
> > baud defined:
> > [    0.028251] ACPI: SPCR: console: uart,mmio32,0xfedc9000,115200,48000=
000
> > [    0.028267] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '1=
15200,48000000')
> > [    0.028272] printk: legacy bootconsole [uart0] enabled
> >
> > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serpor=
ts/serial-port-console-redirection-table
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> >
> > ---
> >
> >  drivers/acpi/spcr.c   | 5 ++++-
> >  include/acpi/actbl3.h | 6 +++---
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > index cd36a97b0ea2c7..67ae42afcc59ef 100644
> > --- a/drivers/acpi/spcr.c
> > +++ b/drivers/acpi/spcr.c
> > @@ -209,9 +209,12 @@ int __init acpi_parse_spcr(bool enable_earlycon, b=
ool enable_console)
> >         if (!baud_rate) {
> >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, ioty=
pe,
> >                          table->serial_port.address);
> > -       } else {
> > +       } else if (table->header.revision <=3D 2 || !table->uartclk) {
> >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, i=
otype,
> >                          table->serial_port.address, baud_rate);
> > +       } else {
> > +               snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d,%d", uart=
, iotype,
> > +                        table->serial_port.address, baud_rate, table->=
uartclk);
> >         }
> >
> >         pr_info("console: %s\n", opts);
> > diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> > index 8f775e3a08fdfb..afe45a2379866a 100644
> > --- a/include/acpi/actbl3.h
> > +++ b/include/acpi/actbl3.h
>
> The part of the patch below is outdated - SPCR v4 is supported already.
>
> Please rebase on the current mainline kernel source.

Oh awesome. Should I send out all three patches again? Or just this
one? I think patches 1 and 2 can be merged.

>
> > @@ -92,10 +92,10 @@ struct acpi_table_slit {
> >  /*********************************************************************=
**********
> >   *
> >   * SPCR - Serial Port Console Redirection table
> > - *        Version 2
> > + *        Version 3
> >   *
> >   * Conforms to "Serial Port Console Redirection Table",
> > - * Version 1.03, August 10, 2015
> > + * Version 1.08, October 7, 2021
> >   *
> >   *********************************************************************=
*********/
> >
> > @@ -120,7 +120,7 @@ struct acpi_table_spcr {
> >         u8 pci_function;
> >         u32 pci_flags;
> >         u8 pci_segment;
> > -       u32 reserved2;
> > +       u32 uartclk;
> >  };
> >
> >  /* Masks for pci_flags field above */
> > --
> > 2.46.0.662.g92d0881bb0-goog
> >

