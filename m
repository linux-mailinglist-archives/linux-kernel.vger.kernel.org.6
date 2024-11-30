Return-Path: <linux-kernel+bounces-426343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92199DF1F0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B65E28148A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2221A0BFF;
	Sat, 30 Nov 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV8RfwgZ"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1119C57C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732983060; cv=none; b=K0aI0R9mWaHPzlQwQOgFTcUITCweRtItBwkuF1qGwLcs5JyqEHmIZbiFR880WRtEUreOUTmWCx3YgaW/TIXN2m1pEJnZTcQgGAAqg9orTm85PKkJ8V6crg76Kz4f8OAq5ODuT7jl/aLH4k1FApgYsLL3EucRGR99XyL3+CzqR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732983060; c=relaxed/simple;
	bh=s8qx9ILdRY5/vfgXPpVIOc/3EfHIjHor4WptV4rTTVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhRI5fYTmlSxz5G9tiOtJBp6cQpCowuKoMupnAnjOuuUJ/MEUis7PREDcccsM83UHSvUmTJIOSAY69UE6jXUIHAuCJvu5r5IQNF8kKTo/yfedXEMNsW2Cz2AopRmKtwSf6dhBswVYUo1Wsr0wvEVOl57UNy7FdZmq/CBvIn9xKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV8RfwgZ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1924164a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732983057; x=1733587857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xjXS7iEwahwlb5IPuoLHGAtPhMN0/BfMaTXkvfmBJ0=;
        b=iV8RfwgZyZcwnZ8+mYCYtlWG46inDpvz1Aoa0n6PNSXvRpGo+okB10ht6k9EG4iEvY
         kXyapcQOyl/g3fPoLxnczRUOL4dPMo6o632HSu7Vk1FcXkTmg4tMkZZI7nzR5wduUY1v
         SdvLC4RDbGBvaZ3Wrt7duyUZlPTQnWbzSo8JxGtniiw7Xgy3bywbOGMq3L7BQ6Gq3JyQ
         gk1fwIrqGZYB3OmJ5ErU1lT35S4vDi1s7RlVh6CybFXy6wJ+4M+5Kf5URVwCgMY1/tX8
         JWcY+jHQDJ+pmh4TAwak9ZApRg6MJRmJsAr3/sdCT3r2PHZFIHgY58NJ3WPe9x+15O9N
         khGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732983057; x=1733587857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xjXS7iEwahwlb5IPuoLHGAtPhMN0/BfMaTXkvfmBJ0=;
        b=jz5DvdxefdDJH2vdO1NSvohfheYZdCsqzhATvUSIygaeyn9EUJdD83rlUVGOmZi4BX
         Cr6xwfYjCVisxezO1LCUwq/GVLCUKZK1wKLRnVWq+YKFY9aKB71VaMt9r+n8VVTc3Z/Q
         SoHKiL7nFv4cNITxalYv5gBcWO4DlGkBYc9RRpqJz1kVE4iZo1owiqNHlpaCBWZXcP0N
         RByAM12Ejt5x1kQeLNXVFHP+P/3fGcIVTbPunQ/hZDQbFCV5oYqx+vSfa67nbEQrplpu
         VTGXttkMPetKS35AHQbX5Tcacs6sE0/gzv30ujCUrU7TfXDaizY1F/ycGdw4XFUEYdRP
         9UiA==
X-Forwarded-Encrypted: i=1; AJvYcCU6SJoIxDbBkndsphglvUS/4OgORYt3wEut0GIFUA2UEOH8UgBn8Vl78nM8nCTrMfWX/wwmtI8zqxCxCRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhP3iZA0pbfBx/uobYFIL90gNpzHzBlrFVK0bxG2bOHCosekWu
	nzKVuvMeilWIbolrOJh3Ncyqk2HseiTzKpDhixnUICagzVcS/+qT
X-Gm-Gg: ASbGncswkwCU15udLrBhjLargGUYzas9ER5/RJE6WaC6b8aBt4gDvoJ9nCWUuz79OH+
	JP/1Qm1vui44oWFh2WCWT/OUAdGi0YtatinASLP/bbycjLNx1m4rUK3rjxGQPjVEFvoqnDkRK0Y
	hli5AudnA7PQ3+VbA/FD1o16pGOZ8N1yFHf0ZQYeKCD4P55yLZqsnd/OTHBIx0fASU03G2B6oi8
	az4kfKvCsWyt/uRHCn0uyAL1E2d8qTGz9nSiB5V7cG5OBDr8GENpWqvEfT9npM=
X-Google-Smtp-Source: AGHT+IEC7NOyX7RkAVIyiXEd/Ox+OL7dOTXyEFcJOwr8dcfOywrkExJL++U46w7GD51IizWO8nZCTQ==
X-Received: by 2002:a05:6a21:39a:b0:1e0:d8b2:1c9e with SMTP id adf61e73a8af0-1e0e0b7e3cbmr21613882637.30.1732983057436;
        Sat, 30 Nov 2024 08:10:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541814657sm5354319b3a.156.2024.11.30.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 08:10:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 30 Nov 2024 08:10:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	Dave Penkler <dpenkler@gmail.com>
Subject: Re: [GIT PULL] Staging driver changes for 6.13-rc1
Message-ID: <f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net>
References: <Z0lCyXBV06VyH96s@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0lCyXBV06VyH96s@kroah.com>

Hi,

On Fri, Nov 29, 2024 at 05:27:53AM +0100, Greg KH wrote:
> The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:
> 
>   Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.13-rc1
> 
> for you to fetch changes up to 114eae3c9fde35220cca623840817a740a2eb7b3:
> 
>   Staging: gpib: gpib_os.c - Remove unnecessary OOM message (2024-11-10 08:04:18 +0100)
> 
> ----------------------------------------------------------------
[ ...]

> Dave Penkler (33):
>       staging: gpib: Add common include files for GPIB drivers
>       staging: gpib: Add user api include files
>       staging: gpib: Add GPIB common core driver
>       staging: gpib: Add tms9914 GPIB chip driver
>       staging: gpib: Add nec7210 GPIB chip driver
>       staging: gpib: Add HP/Agilent/Keysight 8235xx PCI GPIB driver
>       staging: gpib: Add Agilent/Keysight 82357x USB GPIB driver
>       staging: gpib: Add Computer Boards GPIB driver

I seem to be unable to find the patch introducing the problem (the link
provided with the patch is invalid), so I report it here.

With i386 allmodconfig builds:

Building i386:allyesconfig ... failed
--------------
Error log:
drivers/staging/gpib/cec/cec_gpib.c: In function 'cec_pci_attach':
drivers/staging/gpib/cec/cec_gpib.c:300:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  300 |         nec_priv->iobase = (void *)(pci_resource_start(cec_priv->pci_device, 3));
      |                            ^
drivers/staging/gpib/ines/ines_gpib.c: In function 'ines_common_pci_attach':
drivers/staging/gpib/ines/ines_gpib.c:783:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  783 |         nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
      |                            ^

pci_resource_start() returns resource_size_t, which is not a pointer, and thus
can not be cast to one.

Guenter

