Return-Path: <linux-kernel+bounces-542484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34758A4CA02
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936077AD505
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698A5218AB0;
	Mon,  3 Mar 2025 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAGSqzCe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0AE1D79A3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023200; cv=none; b=W/S8AcREM5L2vlMYSbxrvjv4+2LhOBtSzQfrJm3MqCXEnnu/KoRWg2w3y/Z3VqnXg1FdMXZa15whtyQE8LND7lV/XLqOmo7pZAUMZyfZoVmwBymuJ08DSfWYMMajxm5944TpvwVnFjvtHgxoktEJUtG1UnqIK68ueKNfWNgKGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023200; c=relaxed/simple;
	bh=Kqke1zXRTdE0PHPb+71qhUA9lMSBTCX8sSQVT4I2Ut4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZquX6QibqUyAJILstoOVsZ5V7ebSk/TD0mAy7b690iR92qKaaj+BGpAHr+UaaKgaP3pzkmnfBV7BWO1Y3H9ahpDleiGWoxK7VVTqvb1AbLU+7RRqazAY9gN7v4aRR/SN3JlF4TFocAdwb78Xr8fqMMM3EYXTHTJKwbm+UI91Ppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAGSqzCe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741023197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=riX1iNIQhseaZsPbJjiHdH5ZxszgBUyrqDQWObE9EXo=;
	b=QAGSqzCe1ir92rMZd2fBt+C+zuirk+G/6LRPAP2UvnQ6I8RASUkiomPI/0AzBqj2ZM5n4u
	Q9SCaF8wrIE046n3cDDkwLIdno16iOHj7i4sJc9Ipr0lXYEEZhd80wBYlLzMx3WxavthHF
	7FXi4X9TJgq4Q8rGhW0lp21BaopEIVA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-ERzWVmw4OFqMBETvDi_x5g-1; Mon, 03 Mar 2025 12:33:16 -0500
X-MC-Unique: ERzWVmw4OFqMBETvDi_x5g-1
X-Mimecast-MFC-AGG-ID: ERzWVmw4OFqMBETvDi_x5g_1741023196
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390f9d00750so1378902f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 09:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741023195; x=1741627995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riX1iNIQhseaZsPbJjiHdH5ZxszgBUyrqDQWObE9EXo=;
        b=hOb5FNjWWhkh7OoAuAWenhSULNS1FL9JTAL8rlBtNnFhc/tBHLKwSL/Cwfxrjtejl1
         nuAlliVX8lcvVBRzWbSVoYw1rA+qWyAQXur2zR5lwc/XK5gfyDCW6248W+fvjC/uRb/C
         SWYPw2SkvO9XsPAYDh/A7kRGC3hTmTZyiHgOb6PSktQHDExuge0qiUWDpaSknoXJ2pE6
         DldZFKHK1+v96hMlPX6OIFL8IsfUFmQYN0+M2ktHwc92gAM9paZJT8WF9OZbZ1lA8aI/
         3PBn+vmgn9ehTanAMYbuB9KBndwaoz2Yw1wyprXxWNWwC/CTVaVJM3b5LBOjs7Egs+g7
         xzWw==
X-Forwarded-Encrypted: i=1; AJvYcCWGwzRbsQ4isAReuOkZXVrs0vOfqbSRxnSoOrW9tpMuw3bvUcENbalZF4N5Mb5NfUMaIJXIRXTkKzPLGJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6y9oKBtSktous9iqcu0yYcQgTYSkka4/L0s0280K01d5shCmj
	Kk3ffPxVgioXDEOs6uv4A3oHI6L6aKwK+7fhv374lE3Y5ehnIjOjLJwz3hX7zbnRWamhpLLgQh4
	Xkr2ppx5WTnoP5il3kgxnlHv9u7T/l795I2MkeC7zd45UyZLXqyF0Fs1anbdHiFMs4pHxXg==
X-Gm-Gg: ASbGncuqAOLxR/vPUdiCDTQu1dTrnJZe8avSDZkQmwuBx4O7Sd8d+Qcb0ky08HgLLUC
	WkF2oJhmNr4quS0kZU1GuoPIdliGbJWIxsinSmviqLItO6mjRfKpakKUH6QFyeOz+Kb8iT6/X9u
	0inYM8yFTRcYAbnQuLgmoH8O3gD9E8HxyFGbayHc6eqBwfLjWopl7pWPo0m80xTuOAA4lVQIbe1
	sE3HGPwoJWHpA7edsRhXsXnNGwQdfQWJsJjKQIrx28zLZhNe4xbhqJFys0n+SipzR1R4cMslkXm
	zrv9dckJOQ==
X-Received: by 2002:a5d:6da3:0:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-390ec7c8eb6mr11963054f8f.5.1741023195330;
        Mon, 03 Mar 2025 09:33:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0GmDlZsbzQlj1pj5FfLVE18PQfmrSwJDhwqCdM5eQRgnv/LJj6Wq+AmT8QxKX5JIr/1sNZA==
X-Received: by 2002:a5d:6da3:0:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-390ec7c8eb6mr11963001f8f.5.1741023194570;
        Mon, 03 Mar 2025 09:33:14 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1514:ea00:6409:9e94:fe6f:3eb6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db6csm15218056f8f.91.2025.03.03.09.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:33:14 -0800 (PST)
Date: Mon, 3 Mar 2025 12:33:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250303122619-mutt-send-email-mst@kernel.org>
References: <20250302143259.1221569-1-lulu@redhat.com>
 <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>

On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
> On Sun, Mar 2, 2025 at 10:34 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > is disabled, and any attempt to use it will result in failure.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/Kconfig | 15 +++++++++++++++
> >  drivers/vhost/vhost.c | 11 +++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index b455d9ab6f3d..e5b9dcbf31b6 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >           If unsure, say "N".
> >
> >  endif
> > +
> > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > +       default n
> > +       help
> > +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
> > +         userspace applications to modify the thread mode for vhost devices.
> > +
> > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
> > +          meaning the ioctl is disabled and any operation using this ioctl
> > +          will fail.
> > +          When the configuration is enabled (y), the ioctl becomes
> > +          available, allowing users to set the mode if needed.
> > +
> > +         If unsure, say "N".
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index fb0c7fb43f78..09e5e44dc516 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >                 r = vhost_dev_set_owner(d);
> >                 goto done;
> >         }
> > +
> > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >         if (ioctl == VHOST_FORK_FROM_OWNER) {
> >                 u8 inherit_owner;
> >                 /*inherit_owner can only be modified before owner is set*/
> > @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >                 r = 0;
> >                 goto done;
> >         }
> > +
> > +#else
> > +       if (ioctl == VHOST_FORK_FROM_OWNER) {
> > +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', return error */
> > +               r = -ENOTTY;
> > +               goto done;
> > +       }

why do we need this? won't it fail as any other unsupported ioctl?

> > +#endif
> > +
> >         /* You must be the owner to do anything else */
> >         r = vhost_dev_check_owner(d);
> >         if (r)
> > --
> > 2.45.0
> 
> Do we need to change the default value of the inhert_owner? For example:
> 
> #ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> inherit_owner = false;
> #else
> inherit_onwer = true;
> #endif
> 
> ?

I feel it is best to keep the default consistent.
All the kconfig should do, is block the ioctl.


> Other patches look good to me.
> 
> Thanks
> 
> >


