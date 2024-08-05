Return-Path: <linux-kernel+bounces-274967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F863947EE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265D7285126
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7DF15B97E;
	Mon,  5 Aug 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAaX9rGk"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9615B98E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873607; cv=none; b=fINqot2ICHxjBy4zTHTkHZFYZaPqIQtE9HFmCrglwKdM6XTHhVC/GMCUihtsmHIM+MaTZNZ5a+Ckj4P5aYRW7Lq5AgC550pU2mNrefJaqNHsyRfwRHlarTuZ5CHPkSCspAqf7A/QkbamFWxATlfXXCJLZaWhvtuE9n/wEJWzbjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873607; c=relaxed/simple;
	bh=XnjuPksvsijw5+5rRW9TMki7h+0LIhdSonPYw4BGrOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRvOnHn3RCDmeQxDKo/otDV4fe1N3ybvPj3CA1AzOCzUb9Y97UheRZN1yuz3BEsiHsH8SwMmMz5kk+dMWV/QjpOiAPelxZB3hIxMMBYMlFXabyfl/rAk4d5KHLs6ekxjJQqAVSdZGp53AGFl+Pv8FkIDJbxluOZiPjIkqQC7Ydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAaX9rGk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc52394c92so97423255ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 09:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722873605; x=1723478405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdCrHP91H36g9yeRzm+woZl5DnIMjF9rd+/+vz1xtE0=;
        b=jAaX9rGkBSJEe04yxpJ3VFc0z9IyteHDoAJceJ34hbCeWOnkE+nY8awCMWbep+8P2D
         gUIZXWKp6aMwkEDnCkEIGGaU9WW3VpLBdSGVCbH7KTpy/5VWGH2WBeTaPMh+Bk9x1FbI
         3T3AxE8hez7GBzjQyBOs7hYqhI2qsbkPKHcfcJv4LVkvq3uCqOi2BRbfNmOyz2w+Vct3
         70CGalr6k+BCLQPglJ6GdBJZEHUc5r7K3rkdCBAh9/fLH6AxSxuHW5/1KkiFi9oLfdTH
         oSR58+5nYRYt3g39P2kn6e4OA3oqEqAHw541IB+cRWqKxbbwqlQ6vuIaj+aO5D3lORnR
         J2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722873605; x=1723478405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdCrHP91H36g9yeRzm+woZl5DnIMjF9rd+/+vz1xtE0=;
        b=CMCEcWNI0tdrVSTdZdysyyG7hnKWPH+4yzZh0nHClB30mzUOUmyFBWiMaxFe25h+FM
         ZKu8E3sshxWf4TKn8qBWnoUZ4pImhgLFfe/lcHYT9ap18c1tDD8yigrOGNZPFdRtysDF
         U4Q73iYrk4GDHsNnMLZ9BwMQqMUY61sE3AnZeaaohrp9HlwZ700ZABeliN9+bqmMVh3H
         3AzTw+fAJAxukB3xQL2TZpPivSvQMvF+UhfaW3d8dCoade/MFcJLSbDqvFZjG3fia62R
         PAdLF2Sj7S7aWZpKlTJ7JHVOQFrEdCGAs617xlni4YlNJGfyC78PuHJncFLMtz/IYr9L
         dfZA==
X-Gm-Message-State: AOJu0YzceVgP4kv3O3hIaj4JOeIfF04dl+JIuahwm2wCmMHvnOMm2Rd5
	Aom2Oobiq/bhR3dyhosVH5FRB1Y/MVXgd4fX1Qz6USOl2cHO9a3wCUmsaA==
X-Google-Smtp-Source: AGHT+IEXfwQUwXfgK9W7S482tcTjZ1ILuCG5QBotJXGPQDwrqxiv+JeeihL2+JhkG7rzw/vd0zbm/w==
X-Received: by 2002:a17:902:fb4c:b0:1fd:664b:224 with SMTP id d9443c01a7336-1ff5745b49emr121164915ad.56.1722873604399;
        Mon, 05 Aug 2024 09:00:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f5a222sm70117355ad.112.2024.08.05.09.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:00:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 5 Aug 2024 09:00:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.11-rc2
Message-ID: <378f3810-8b3f-416f-90ec-c81bb3f29123@roeck-us.net>
References: <CAHk-=wh01xPAWUT_=J1TehFOu3SST12UTNuB=QQTeRw+1N4pDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh01xPAWUT_=J1TehFOu3SST12UTNuB=QQTeRw+1N4pDQ@mail.gmail.com>

On Sun, Aug 04, 2024 at 02:00:57PM -0700, Linus Torvalds wrote:
> So rc1 had a fair number of annoying small build or test failures on
> Guenter's test matrix, which never looks good. But most of them seemed
> to be of the "stupid and trivial" variety, which obviously doesn't
> instill confidence in the process, but also isn't exactly scary. When
> the microblaze tinyconfig doesn't build cleanly, it may not be a great
> look, but it's also probably not a showstopper for actual use.
> 
> Hopefully we've gotten rid of the bulk of the silly noise here in rc2,
> and not added too much new noise, so that we can get on with the
> process of finding more meaningful issues.
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 539 pass: 516 fail: 23
Failed tests:
	microblaze:petalogix-s3adsp1800:initrd
	microblaze:petalogix-s3adsp1800:rootfs
	microblaze:petalogix-ml605:initrd
	microblaze:petalogix-ml605:rootfs
	microblazeel:petalogix-s3adsp1800:initrd
	microblazeel:petalogix-s3adsp1800:rootfs
	microblazeel:petalogix-ml605:initrd
	microblazeel:petalogix-ml605:rootfs
	mips64:malta:malta_defconfig:nocd:smp:net=e1000-82544gc:ide:ext2
	ppc:mpc8544ds:mpc85xx_defconfig:net=e1000:initrd
	ppc:mpc8544ds:mpc85xx_defconfig:scsi[53C895A]:net=ne2k_pci:btrfs
	ppc:mpc8544ds:mpc85xx_defconfig:sata-sii3112:net=rtl8139:ext2
	ppc:mpc8544ds:mpc85xx_defconfig:sdhci-mmc:net=usb-ohci:ext2
	ppc:mpc8544ds:mpc85xx_smp_defconfig:net=e1000:initrd
	ppc:mpc8544ds:mpc85xx_smp_defconfig:scsi[DC395]:net=i82550:ext2
	ppc:mpc8544ds:mpc85xx_smp_defconfig:scsi[53C895A]:net=usb-ohci:btrfs
	ppc:mpc8544ds:mpc85xx_smp_defconfig:sata-sii3112:net=ne2k_pci:ext2
	ppc:ppce500:corenet32_smp_defconfig:e500:net=rtl8139:initrd
	ppc:ppce500:corenet32_smp_defconfig:e500:net=virtio-net:nvme:btrfs
	ppc:ppce500:corenet32_smp_defconfig:e500:net=eTSEC:sdhci-mmc:ext2
	ppc:ppce500:corenet32_smp_defconfig:e500:net=e1000:mmc:cramfs
	ppc:ppce500:corenet32_smp_defconfig:e500:net=tulip:scsi[53C895A]:ext2
	ppc:ppce500:corenet32_smp_defconfig:e500:net=i82562:sata-sii3112:ext2
Unit test results:
	pass: 332158 fail: 0

The microblaze test failures are triggered by commit 721f4a6526da
("mm/memblock: remove empty dummy entry"). The fix is at
https://lore.kernel.org/all/20240729053327.4091459-1-rppt@kernel.org/
and should hopefully be sent upstream in the near future.

The ppc failures bisect to commit 6b0e82791bd0 ("powerpc/e500: switch to 64
bits PGD on 85xx (32 bits)"). This commit is related to other hugepage
related patches and can not easily be reverted. I don't know the status.
Given the context (changing the pgd sixe) it may well be a qemu problem.

The mips64 test failure is a networking interface failure. It started
happening a week or two ago. The problem is spurious and thus difficult
to bisect.

There is also a spurious failure with parisc64 images, triggered by commit
c37927a203fa ("genirq: Set IRQF_COND_ONESHOT in request_irq()"). The same
problem is also seen in v6.10.3 where that patch was backported. This is a
heisenbug: Any debugging added to figure out what is going on makes it
disappear. I don't know if it is a race condition or a bug in qemu or
something else. I did not see this problem with v6.11-rc2 but with an
interim image (v6.11-rc1-272-g17712b7ea075).

Guenter

