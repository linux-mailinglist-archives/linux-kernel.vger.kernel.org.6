Return-Path: <linux-kernel+bounces-310686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052F0968023
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263741C21E2C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3881714A4;
	Mon,  2 Sep 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQajwe5O"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB991714A1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260910; cv=none; b=dCeLtjvWKGq9misYu80YVPVs0TWAl6u0aVX+T6EKRNPxseCz2VxQdTLCe6Xkpz1fkjcEReuaGJP9AmCOeAu7dNN6A7Nbxgq87zlGKmWxdj2GYc+LnFGBgs85NL8Y+Ef55JWvySkb0WaIESCZkSApscVav60zw8OUJiMnpa9jTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260910; c=relaxed/simple;
	bh=qz2xxPcUhMmqHx0R8zeEBobaiXKQqG5PktPaGfVNlDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3DkpmNdKUYWhDUrIJbdCHZtHTuk2VilWFjHzkf60w+BxsOv025I6WEBXVUDTZdfUs7VqnbxTETaLscELYAgVM59XF+suFxiborsk9JMDBZ8PrrE6QvSfSml7ilBDyJZ3MT6RWIIRyBIf/8Epxx5Q/i4+xk9E+cTYjMOGtysCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQajwe5O; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c2443b2581so8988a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 00:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725260907; x=1725865707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dH+gKZniEI3v7+0LpRiy8ASOw0/wvRv4BM3n+1kO5jw=;
        b=mQajwe5O0K6oQZnugtOk6fvpxYXU3cpcjb1wOcywphrHXbJTVhW6lN7HI5reFJiQbi
         VE0K1ATXhnfXMc8tNRafKHjTtCiG2C/+tf01Mh79Wlu5KCi9xeKnB3wrampm7HxmRLU8
         TyEsvt+FuHXD1SA2ip6VAL3L8NEF0eMVGGYlWxGTofB+gwFowpIYpC+bs8v8kOzzYQGK
         qWmir1zmKE3G4Jx2fA54tvcP2TgIZALi3JSmY0dVpSGNhtB5MnU5nlf1lLyTCdMsc5I2
         F+IDZ01Lk+dedUivv0mMTi58YSFyXLnXOTMbb9Nj8e6lcbiBZARGDgspicyjl8N9ffTv
         AmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725260907; x=1725865707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH+gKZniEI3v7+0LpRiy8ASOw0/wvRv4BM3n+1kO5jw=;
        b=jzs45iuI4Qs8pXkKQjyMVnsnlnCJDfweQgbwQK4g64GDF4dfV9Dn+WuxIgh+Toqa3J
         OAvuysycj2JkO/BZxRAhBdAoFqkJAGFjoAYDbFOl6DANtRxrl0kQ4FoJ3fzGp4DfpkHk
         +oDwSiNkekOmHwmGgjjV/748DmfpYebWIma7/S1i9gmYpv4Gjdk7VNK0m87tyz/jasfV
         q3dQ0sfOKeTjHNgg0TQOt+Bd2m8fV9WZrCwYF5YIome45lvRz8y9e9ZJx96u5xhEiaUl
         UxR2Q5w5dFLRk9D+fWXz3BwgLcw7J9O5ed+WSkGuDYyylZ1/KPvq7onTCirlf3LJymn1
         kaug==
X-Forwarded-Encrypted: i=1; AJvYcCV6cLwJE5rf+W7815Nsp3N6bxo05Zdn+7+FvtbiQQaNYAqYKKsheuoDsbfDIYM3I1EguYG7I/scbT+AixU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKf7Hg+kssjAMEaZKxu5JZru0o9XGVZvFi5casKxc0z+8AuRvi
	42kFc7DIo4Ysa9g1AK5l93wHqrY8FR09+F1UmIbREKC1pyKeiXKLSbjdlgWYnA==
X-Google-Smtp-Source: AGHT+IFoF66DMu3YJdmK/srN6fY+dEN2koeeRQ0q+8VZVMngCsfM3z7RwNnlHbO5MRJO6ZKoo5r/kg==
X-Received: by 2002:a05:6402:5188:b0:5c2:5641:af79 with SMTP id 4fb4d7f45d1cf-5c25641afb6mr61789a12.0.1725260906279;
        Mon, 02 Sep 2024 00:08:26 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba641dad0sm161741835e9.30.2024.09.02.00.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 00:08:25 -0700 (PDT)
Date: Mon, 2 Sep 2024 07:08:24 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	vdonnefort@google.com, mark.rutland@arm.com, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v9 0/5] arm64: ptdump: View the second stage page-tables
Message-ID: <ZtVkaMO0dG082KNK@google.com>
References: <20240827084549.45731-1-sebastianene@google.com>
 <864j72vzmw.wl-maz@kernel.org>
 <8634mmvyx0.wl-maz@kernel.org>
 <ZtVW-CQ-G84lHUE5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtVW-CQ-G84lHUE5@google.com>

On Mon, Sep 02, 2024 at 06:11:04AM +0000, Sebastian Ene wrote:
> On Fri, Aug 30, 2024 at 04:00:11PM +0100, Marc Zyngier wrote:
> > On Fri, 30 Aug 2024 15:44:39 +0100,
> > Marc Zyngier <maz@kernel.org> wrote:

Hello Marc,


I tried with a 16Kb host under VHE on Qemu starting a 4kb guest with
kvmtool:

root@seb-qemu-pkvm-host:~#  zcat /proc/config.gz | grep
"CONFIG_ARM64_[164K]*_PAGES=y"
CONFIG_ARM64_16K_PAGES=y
root@seb-qemu-pkvm-host:~# cat
/sys/kernel/debug/kvm/263-4/stage2*
2
---[ Guest IPA ]---
0x0000000000000000-0x0000000001020000       16512K 3
0x0000000001020000-0x0000000001024000          16K 3   R W X AF    
0x0000000001024000-0x0000000002000000       16240K 3
0x0000000002000000-0x0000000080000000        2016M 2
0x0000000080000000-0x0000000084000000          64M 2   R W   AF BLK
0x0000000084000000-0x000000008e000000         160M 2
0x000000008e000000-0x0000000090000000          32M 2   R W   AF BLK
0x0000000090000000-0x0000000098000000         128M 2
0x0000000098000000-0x000000009a000000          32M 2   R W X AF BLK
0x000000009a000000-0x000000009c000000          32M 2   R W   AF BLK

This looks quite right I guess and I wonder how can I repro what you are seeing ?
What kvm-arm.mode is the host running into ?

Thanks,
Seb

> 
> Hello Marc,
> 
> > > 
> > > Hi Seb,
> > 
> > [...]
> > 
> > > I've been giving this a go on my test systems with 16k pages, and it
> > > doesn't really work as advertised:
> > > 
> > > root@babette:/sys/kernel/debug/kvm# cat 2573-13/stage2_*
> > > 2
> > > ---[ Guest IPA ]---
> > > 0x0000000000000000-0x0000000008000000         128M 
> > > 0x0000000008000000-0x00000000090a0000       17024K 3
> > > 0x00000000090a0000-0x00000000090a4000          16K 3   R W X AF    
> > > 0x00000000090a4000-0x000000000a000000       15728K 3
> > > 
> > > Only 16kB mapped? This is a full Linux guest running the Debian
> > > installer, and just the kernel is about 20MB (the VM has 4GB of RAM,
> > > and is using QEMU as the VMM)
> > > 
> > > So clearly something isn't playing as expected. Also, this '128M'
> > > without a level being displayed makes me wonder. It is probably the
> > > QEMU flash, but then the rest of the addresses don't make much sense
> > > (RAM on QEMU is at 1GB, not at 128MB.
> > > 
> > > On another system with kvmtool, I get something similar:
> > > 
> > > root@duodenum:/home/maz# cat /sys/kernel/debug/kvm/*/stage2_*
> > > 2
> > > ---[ Guest IPA ]---
> > > 0x0000000000000000-0x0000000001020000       16512K 3
> > > 0x0000000001020000-0x0000000001024000          16K 3   R W X AF    
> > > 0x0000000001024000-0x0000000002000000       16240K 3
> > > 
> > > and kvmtool places the RAM at 2GB. Clearly not what we're seeing here.
> > > 
> > > Could you please verify this?
> 
> Ughh, this doesn't look right. I will give it a spin with a different
> granule, thanks for bringing me to attention. I will look first at
> mm/ptdump.c if it works as intended.
>  
> 
> > 
> > For the record, on a 4kB host, I get much more plausible results:
> > 
> > root@big-leg-emma:/home/maz# cat /sys/kernel/debug/kvm/632-12/stage2_*
> > 3
> > ---[ Guest IPA ]---
> > 0x0000000000000000-0x0000000000200000           2M 2   R     AF BLK
> > 0x0000000000200000-0x0000000040000000        1022M 2
> > 0x0000000040000000-0x0000000040200000           2M 2   R W X AF BLK
> > 0x0000000040200000-0x0000000044000000          62M 2
> > 0x0000000044000000-0x0000000044200000           2M 2   R W X AF BLK
> > 0x0000000044200000-0x0000000047600000          52M 2
> > 0x0000000047600000-0x0000000047800000           2M 2   R W   AF BLK
> > 0x0000000047800000-0x0000000047e00000           6M 2   R W X AF BLK
> > 0x0000000047e00000-0x0000000048000000           2M 2   R W   AF BLK
> > 0x0000000048000000-0x00000000b9c00000        1820M 2
> > 0x00000000b9c00000-0x00000000b9e00000           2M 2   R W X AF BLK
> > 0x00000000b9e00000-0x00000000bb800000          26M 2
> > 0x00000000bb800000-0x00000000bba00000           2M 2   R W X AF BLK
> > 0x00000000bba00000-0x00000000bbe00000           4M 2   R W   AF BLK
> > 0x00000000bbe00000-0x00000000bc200000           4M 2   R W X AF BLK
> > 0x00000000bc200000-0x00000000bc800000           6M 2   R W   AF BLK
> > 0x00000000bc800000-0x00000000be400000          28M 2
> > 0x00000000be400000-0x00000000bf800000          20M 2   R W X AF BLK
> > 0x00000000bf800000-0x00000000bfe00000           6M 2   R W   AF BLK
> > 0x00000000bfe00000-0x00000000c0000000           2M 2   R W X AF BLK
> > 
> > So 16kB is the one that needs investigating, and I strongly suspect
> > that 64kB is in the same boat...
> > 
> > Thanks,
> > 
> > 	M. (signing off for the day)
> > 
> 
> Thanks,
> Sebastian
> 
> > -- 
> > Without deviation from the norm, progress is not possible.

