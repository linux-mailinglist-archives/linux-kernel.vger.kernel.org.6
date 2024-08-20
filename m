Return-Path: <linux-kernel+bounces-294631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF8B959075
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF381F230DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D461C8221;
	Tue, 20 Aug 2024 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OxBB/1CM"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D71C7B78
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724192842; cv=none; b=okU9wyOwgqlH1bd+elEKspzW8OnU/yR57csNtSYJyy/UGWy8LkZDYGyMX52f54/tYRBFTFudMoDa4cHUcmwBePrZnbocLAIfPFd11h++MwuozoDRvondqdbAn5Cn0dYjmzPECPu+FLfiDerhujk2mS1vvaariRa1BKTfKpR3/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724192842; c=relaxed/simple;
	bh=3wLsl2ZHoJzQIpDGbh/f6Cmbvg8iijyYfOI55rR0ciA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qV2E4FN/7CdgYPxCx+IgrilFAYPtOuUirwxLIFbEjT2a4PF+mZ55tOtFP+7TKdxGRsyt+rAz5cHhOftZAbSCmwJ2RBlW+FLJBmE9IjsWycNEy6kjA+9MKUlflF1gFvsLqNgaYvNPxfHZnvtzBW+Gxzt3CuvxlRTiSPwpFvW4rcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OxBB/1CM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-713eeb4e4a9so2093122b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1724192840; x=1724797640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/7PBdgCtKdBDSQVRqHsAp4nX8OMVMTx7HQRmu7c+ziA=;
        b=OxBB/1CMOKHXIJ0SWg/rSFmASo5Co43yiLSYe+5ODAlNNrR+b9I16j+vQSKNHg824/
         vRByy0DmQDV7pOoliFgh03bpZdNlc3MBAJXn0oOk5rHK6oAjBFGa2Ubt2Nn0re/jkFL4
         shMDGspmjRBwWZJsHk6q7JLv70l9k0YLklDk0VX1gyfpKCTgRSxy83CXvHliyj3xUASF
         9lYHbu8i4QRutuJI8fCtRxxm+ap8J4AU5bRO97t7EY4EVb99bM5K9Ht3e7duVmv6nak5
         SjtAwEkw0zU48x8yxXcgiNCZ6QWuyrb9//KwkZ1/R/G7I52SrFBQ9omZZNYt08Phk4Cd
         jVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724192840; x=1724797640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7PBdgCtKdBDSQVRqHsAp4nX8OMVMTx7HQRmu7c+ziA=;
        b=vdrK58d3ZdE1/G7UAguC2uZEmIe+P4WqOfx7LgEdN7MbyjlC9vqJdXEQQUFsEBlNz4
         5X/bFByjOATsguQhwVXBu2R0BppUaRD/q2KTu/I2arZoGmNf5kR33ddTIF4s/GraIZVB
         o5NSCRRbQCWtqivwa9uCKj/JcrzhsJuPPczf6OOkaHsZtLr3aZT3nz8fN1v4Fw9Rqdum
         E16j/fU5ar7hTunZ8Vy99qCWgJFljS/H7mhCKJCIvjQ7qqURps1Uxk9P+zCc0XlGRvbY
         dglQAaKZrua6FHDb2ixFmkEPkZFYboNoervgVG3nwzE/KcRIPIUH2lSeSDNSqESSvrtC
         tA6g==
X-Forwarded-Encrypted: i=1; AJvYcCXIp/xN25m52tH85ffUhZuFXnK484E68gLrD2qu9ekWcqWZbpGoo9Ztna2wgKkDg5evwl17mq2htZ9DNzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKe+o6fJU5ygBb8BexF8WHol72fG4vzx1hJkLD3ki0WZIsI7B+
	/NXTKuQQjSkWYKSzPosbuJYmso6OCG9YT3nonwo+iSzy2Yt667srtNDIPPhwWwA=
X-Google-Smtp-Source: AGHT+IFWMD5F4SH16dywqQbMV8rHePgqcq9oQeCHks+FITqauivG5roMZKIICdQlMRQ5xlVuRGYS5A==
X-Received: by 2002:a05:6a00:4fc4:b0:70d:3337:782b with SMTP id d2e1a72fcca58-714234b3aeamr612621b3a.18.1724192839732;
        Tue, 20 Aug 2024 15:27:19 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af3cd84sm8642793b3a.209.2024.08.20.15.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 15:27:19 -0700 (PDT)
Date: Tue, 20 Aug 2024 15:27:17 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shay Drori <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Added cond_resched() to crdump collection
Message-ID: <ZsUYRRaKLmM5S5K9@apollo.purestorage.com>
References: <20240819214259.38259-1-mkhalfella@purestorage.com>
 <ea1c88ea-7583-4cfe-b0ef-a224806c96b1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea1c88ea-7583-4cfe-b0ef-a224806c96b1@intel.com>

On 2024-08-20 12:09:37 +0200, Przemek Kitszel wrote:
> On 8/19/24 23:42, Mohamed Khalfella wrote:
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> > index d0b595ba6110..377cc39643b4 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> > @@ -191,6 +191,7 @@ static int mlx5_vsc_wait_on_flag(struct mlx5_core_dev *dev, u8 expected_val)
> >   		if ((retries & 0xf) == 0)
> >   			usleep_range(1000, 2000);
> >   
> > +		cond_resched();
> 
> the sleeping logic above (including what is out of git diff context) is
> a bit weird (tight loop with a sleep after each 16 attempts, with an
> upper bound of 2k attempts!)
> 
> My understanding of usleep_range() is that it puts process to sleep
> (and even leads to sched() call).
> So cond_resched() looks redundant here.

This matches my understanding too. usleep_range() should put the thread
to sleep, effectively releasing the cpu to do other work. The reason I
put cond_resched() here is that pci_read_config_dword() might take long
time when that card sees fatal errors. I was not able to reproduce this
so I am okay with removing this cond_resched().

> 
> >   	} while (flag != expected_val);
> >   
> >   	return 0;
> > @@ -280,6 +281,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
> >   			return read_addr;
> >   
> >   		read_addr = next_read_addr;
> > +		cond_resched();
> 
> Would be great to see how many registers there are/how long it takes to
> dump them in commit message.
> My guess is that a single mlx5_vsc_gw_read_fast() call is very short and
> there are many. With that cond_resched() should be rather under some

I did some testing on ConnectX-5 Ex MCX516A-CDAT and here is what I saw:

- mlx5_vsc_gw_read_block_fast() was called with length = 1310716
- mlx5_vsc_gw_read_fast() does 4 bytes at a time but the did not read
  full 1310716 bytes. Instead it was called 53813 times only. There are
  jumps in read_addr.
- On average mlx5_vsc_gw_read_fast() took 35284.4ns
- In total mlx5_vsc_wait_on_flag() called vsc_read() 54707 times with
  average runtime of 17548.3ns for each call. In some instances vsc_read()
  was called more than once until mlx5_vsc_wait_on_flag() returned. Mostly
  one time, but I saw 5, 8, and in one instance 16 times. As expected,
  the thread released the cpu after 16 iterations.
- Total time to read the dump was 35284.4ns * 53813 ~= 1.898s

> if (iterator % XXX == 0) condition.

Putting a cond_resched() every 16 register reads, similar to
mlx5_vsc_wait_on_flag(), should be okay. With the numbers above, this
will result in cond_resched() every ~0.56ms, which is okay IMO.

