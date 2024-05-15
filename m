Return-Path: <linux-kernel+bounces-180298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421228C6C97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8531C22359
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC441591EC;
	Wed, 15 May 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpDT236e"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D823B2F877
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800143; cv=none; b=q4s4oZaycob4Mq39LML+ZbTLFriJVzF35Shg+m1RcMZNTgGDeLZrjegTP3jkmu99hkuEF/33kHPQ7/hBVwQNFosw5oJIPlb+yxtilaN1oVCalrzQ/dq7lu7+E09rTBWufOIdMglLzsebFkQu3cW9c9g1FNTHV/+CYENTnLNfYVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800143; c=relaxed/simple;
	bh=ErIr00wXxDjcXFJgmN4QAVA5jti/sx5rcnZ7KKraRNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okmnjrleyJkVymD3I7pJSvUeqRVvTf2C3VfJ3EWJ/BggkZe6PIhoE+kFhRLHjUtAhivVJT1WnLwA4SH5M++P3h7uPIsBQnIgn88k2QE4HeuLBFVyllhEz5M/yMgvuNggLqt4faRz7KDvwPuStQVi1/js7opzOufnHLhJ5BxnoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpDT236e; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so5913404b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715800141; x=1716404941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ehPClfdjBHxvY5ZJUAcGEgSYOzt9FLCOTq+5QbE//0=;
        b=BpDT236e/ECDtRabh5g+o66IqaX81PobsURjJW6L7UUT6IDPV6L1HVrGKQVD4M79so
         hzIW/FI2szQrj9vwSfswj750fC/dToqu2jo6HzSDASvqZ62JHirgOxq6UFT+ddklyxwG
         O634hcu3raMOasq34rsm9Nx+YHLuJEDTq1C77gC+RZFDWlNSVRotJwfFTzx6lidyXiR5
         IfJO6zYSx+jHZvpy7Q+7ghSLpNLdhcHLX3afVcr0yJQvIVhlsHsNSNoEMigs5rrcuAhq
         vBV/xFov+sbTY/vbW7Kg6I7D7ZoJTr+EZy/FaKxHShw9YcTIAz8VYk6fszGWcTgNqc0Z
         JkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715800141; x=1716404941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ehPClfdjBHxvY5ZJUAcGEgSYOzt9FLCOTq+5QbE//0=;
        b=OVIR8Dvy8ZBdO4oRpIrBRIcxER/D3t0JXCHXeJ/3EZPfBXf9+sbztgQgDGxTiQuI+J
         NWGg2rnbpiASsKpEB9V25q+R+KxcZ1ReGl6klID9JRH6UFLmHNU0sEfqlMf+snRgruV1
         zx4ZCr16naccUTLo6uxwPCjcFZTV2Wn0VkPA0PUa/9nH9qKBjjiv/DRUXE1XAJrty51j
         RR1GpF9F9GdhquLHrWrNOsNySIBVO6R4/fX75e30tGx3i1XPibXZ+nqD6RQlJ6GJELgw
         kuo73bWAQ4L16bNE3lmKOOG2xDi8Oyl5ruWbvZ4svZp8HbN4PgbxkKS5YcBnpucMPqp7
         ENCg==
X-Forwarded-Encrypted: i=1; AJvYcCXH2/SENK6zbIKWyqdw1icdnLQfKughd6eR5mn3cGBvhWrfGMli6ayWtqx7HevqhdZyehXfLqyMiEjQF7RWMcXqwxMCbosCCxEbpHL1
X-Gm-Message-State: AOJu0YxzsL2HGblaayWtTu3in2Z9+tzYMBO751wBLCH9DQQBScUm25we
	d5VPPMSTqjAFalqw0jlGYYmRt+bPZBJNLrD2BAfayU3NW1jz1zvX
X-Google-Smtp-Source: AGHT+IEmY9NqhOOZ1ywBjKs7LJU1K7EJD8Y2DRKDjjIwwxf/G7CS9SKJdajbQJoKXYdKTaPV4+K39w==
X-Received: by 2002:a05:6a00:2289:b0:6f3:ed26:e4ef with SMTP id d2e1a72fcca58-6f4e032da79mr23155457b3a.34.1715800140985;
        Wed, 15 May 2024 12:09:00 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a82896sm11463303b3a.69.2024.05.15.12.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 12:09:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 May 2024 09:08:58 -1000
From: Tejun Heo <tj@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: syzbot <syzbot+93cbdd0ab421adc5275d@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in kernfs_remove_by_name_ns (3)
Message-ID: <ZkUISvtAdooOGyC7@slm.duckdns.org>
References: <00000000000047624505d0453c58@google.com>
 <20240515162944.GQ4449@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515162944.GQ4449@suse.cz>

On Wed, May 15, 2024 at 06:29:44PM +0200, David Sterba wrote:
> On Mon, Nov 08, 2021 at 03:24:26AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    ce840177930f Merge tag 'defconfig-5.16' of git://git.kerne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1516eb12b00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=647adc5a101c9bf3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+93cbdd0ab421adc5275d@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > kernfs: can not remove 'nr_tags', no directory
> > WARNING: CPU: 0 PID: 352 at fs/kernfs/dir.c:1535 kernfs_remove_by_name_ns+0x96/0xa0 fs/kernfs/dir.c:1535
> 
> #syz set subsystems: kernfs
> 
> Remove btrfs from subsystems.  Multiple reports, injected ENOMEM and
> sysfs cannot remove the files and warns
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/kernfs/dir.c?id=d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7#n1662

I can't tell what's happening just from the backtrace but it looks like
kobject_del() is being removed twice or removed without being added. The
kobj doesn't have kernfs_node attached but then tries to remove the files
which triggers the warning. Could be a bug in blk-mq. Can't immediately tell
from scanning the source tho. A repro would be really helpful.

Thanks.

-- 
tejun

