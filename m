Return-Path: <linux-kernel+bounces-370279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A31A9A2A45
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4D8282568
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE031DED5B;
	Thu, 17 Oct 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NWfaCSOu"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197A1DF96A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184530; cv=none; b=W0+9HPvpQ59KNKm5t0aT7ReAoDtARKc3uULbsXNmU1B83bdsWluVg1hbY7AypuHFmw/yafC+fDMxJ6ZAo1B6PptV/wm2AKJ2DkUXyVI5k14Wzk0zJOaBT1uh+KXZE9ISaVVyhBLKZ8dpV1LmmWnAaTuvs+uTIK4HrzNWNS4ZFe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184530; c=relaxed/simple;
	bh=9vEVSrXb7Vkp9JTRO/9k2XSu/s4ZMm6+yKyw7GARTfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiF9j1fwf82nWRWABnKRERxDGwlYMc2Px392BV44l0No24cJ26TEwm7A5gD9GpWm325/dtO99wQ4IdbeN/NwexEK9t7SM0JcwNoTleSR3kLwbKw1yE31rpYzHgaprSDR375SEZJVI0D4FLqkBRGERpzQFY61YZWrCRMEiLwC6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NWfaCSOu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2af4dca5cso200848a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729184528; x=1729789328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vEVSrXb7Vkp9JTRO/9k2XSu/s4ZMm6+yKyw7GARTfQ=;
        b=NWfaCSOubuNeZZV1pSUHE0LVYW8V+ebUPHUmRKhqrc9bgPc+hEPEVmSJHqWrlHR58y
         fZpaVy5Tif/ZeleHBUn7nszhA91SDDcL/zmQFIBbweB3IwYMjD8r9X7RH8ImL9c2LDsy
         grNWp7PmUAZGIVK/VsCowUixeIT0E9CAlLgqLAh1UEvfQdC3YRXCoD+nUpqckYgzyOdx
         pz/ehjHz5TZSJsFp0xh3coCq8anmaqjE9xIGylCPI8OzI0slkv3eLx2KQcdLDhJbTys5
         vmMgCjPmI9swYaWz1CWAWKuI9Owa5+ZWoaGKeVk/wgPnC3yFdsxWH+Kh0AsSvaD3Z0ea
         DPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184528; x=1729789328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vEVSrXb7Vkp9JTRO/9k2XSu/s4ZMm6+yKyw7GARTfQ=;
        b=I/MlRg4ygXHveE2SX3fwjdAOTpsX5CZJo3rDTJhbEegglPpwlFpjRDayoRwzZKoUES
         xnvC539UxG7YMs24oFFQxP38CI8SIh7Fba/g5VlO5wAL5XphwMZOk5FlqKwOUWcrZWRE
         mGPHx1jpYhc9sQ7R9UYCBgN3bDVcvgXh60AzbES7rJHkzHnyb4r404JncvV3SyWdvKoX
         qnTWt92GJQRpaIqknBggVOkTtHlyZN1Etp56wUl1MmMZademRoFbkEw3z9b6K1K+BYvq
         TkSkfduK2LYtMNZnaWBdzHstowEb9zsr19d84E5gk0+XLtFTSXZoVaf8+0CTrgaIWi9L
         jQnw==
X-Forwarded-Encrypted: i=1; AJvYcCWCMAE2A+/PHAQXm5aiiKKN77GyETAiuN72VA+zYwpc7fNl3IuyVIzhJT75V5FWywEXpU3TmUwvOiaX1t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNDveRIOSGowmkjs+5N69yXNg6VPuWxBLRiIIIIC6kdx8mIxd
	oiNP7EHzB6uYovokThsCoPfojb/ofkAlEOCtIXh+RPblZIiKw+6EUBHPjlLQGHZS3GMlegttR4U
	G7fG9AJpPkkzbN0PqV1bDlVyd/IFRuI5br5aKmw==
X-Google-Smtp-Source: AGHT+IHkxHHcRBdYrEyk6gHLJhWuuIDP4JRrLIRP9fJlf4vh+KGsBy//sp1vV+aoB7B27XSZBievJGZmdU5L87zQViQ=
X-Received: by 2002:a17:90b:4f4b:b0:2e2:cd5e:b25 with SMTP id
 98e67ed59e1d1-2e55dd697e2mr29221a91.6.1729184528131; Thu, 17 Oct 2024
 10:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016213108.549000-1-abhishekbapat@google.com> <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
From: Caleb Sander <csander@purestorage.com>
Date: Thu, 17 Oct 2024 10:01:56 -0700
Message-ID: <CADUfDZrvGJ8rNmwTu8WQYy9R03DLZwnMqRA-nWuVUzy1kXHXvQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring namespaces
To: Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Prashant Malani <pmalani@google.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree it would be convenient for the kernel to expose a generic "max
data size" limit for the NVMe controller. For example, nvme-cli
currently pessimistically assumes a controller's maximum data transfer
size is 4 KB when sending Get Log Page commands:
https://github.com/linux-nvme/libnvme/blob/8cdd746b324bd84a0666e7a265aa253d=
bda9d932/src/nvme/ioctl.c#L330.
Fetching large log pages results in a lot of Get Log Page commands. If
nvme-cli could tell that the controller and kernel support larger data
transfers, it could fetch the entire log page (or a much larger chunk)
in a Get Log Page command.

Best,
Caleb


On Thu, Oct 17, 2024 at 9:46=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
> > max_hw_sectors based on DMA optimized limitation") introduced a
> > limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
> > (MDTS =3D 5). This restricion was implemented to mitigate lockups
> > encountered in high-core count AMD servers.
>
> There are other limits that can constrain transfer sizes below the
> device's MDTS. For example, the driver can only preallocate so much
> space for DMA and SGL descriptors, so 8MB is the current max transfer
> sizes the driver can support, and a device's MDTS can be much bigger
> than that.
>
> Anyway, yeah, I guess having a controller generic way to export this
> sounds like a good idea, but I wonder if the nvme driver is the right
> place to do it. The request_queue has all the limits you need to know
> about, but these are only exported if a gendisk is attached to it.
> Maybe we can create a queue subdirectory to the char dev too.
>

