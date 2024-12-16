Return-Path: <linux-kernel+bounces-448268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BF19F3DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C06C7A6116
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87851DA2FD;
	Mon, 16 Dec 2024 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LHjUJxnw"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F11D935A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389933; cv=none; b=DrccwZNAd0rW7NaS6Fi/1gdgwZt07/0ZgAMcR9CMLbr5Kdra4eFbq/0Mcs/J9to4U3BcN/upH87AQIM1vDkCYHkj4DXY/vuuuJuDaW9C430wWNvBNyEapVJDjIeMk42c6b2LyruEMACJ1QT9Jv8B1Mdpk/YONP2ZklNalJ49JnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389933; c=relaxed/simple;
	bh=yO3ABFgaRA6gQLk+jKRulrwSj3yPIlDRR9FUiP+tIUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+nck5hCdp7Gy6gTObWT891TZbN7usezhXVgW8PweElJDaCu1xS+gPp/OPHWWpqFQGQT4UJVC4MWF87XZAjifOE+FjbycvAEfOG2RLXnfe6BCHcNdZFBYL53uCuIcDfj3MQ2ntdek8gS0syiosy7OeUD7YgeDgaMgLv1uJA6IEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LHjUJxnw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215770613dbso31348185ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734389930; x=1734994730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckzL0oeGyqxBSfgSo+iDPJ0MToAoPZLjRSeCSLdBC4E=;
        b=LHjUJxnww0YcecA/jMMoaWHyV5FeHjwZJN3WXASQPMrZ2AEBzl0Z7RfoKTr/s6G9Wp
         bJPnms5iQ2QsvbuwmKj1rYYr5TecXvMSR+yv//TmubdRSmFUZqCZGDd8jmB2VG2FH65Y
         qroJILftfQyXKP1v1FHtQ+GAuVlSHVpu4bzJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734389930; x=1734994730;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckzL0oeGyqxBSfgSo+iDPJ0MToAoPZLjRSeCSLdBC4E=;
        b=JxJ6Ugn1Dlx7nAUTXb9DE6ISfVrehAmHrDCTfkEBA6urn+/u3AgG93gwlDpPMCqDW9
         z1rzBL3kl4w++Rb3mseUbnP2p0VX0IkrYwh6WZ3h65LQ9+SwOu9gjcqXYhiOsBVKwRPF
         E8V6I8uRpd9PBYnIbMWhJvX/akRIrFC3CcUFxfAuWsvyb9Y1yuZ6XcR9dZBcTfWWEDvg
         Rr5+/2OtS93H0SOgmYhVGOMvOdrAY7odCPRNjWnO5UsoiBcT7p1umIEs9aX4EeECpY8a
         LfPAcTEfWNw293MAop6A7aUjHBSB1cOpAdSOjuKRJScRxuM5OhWGXQ0bYRjqKt+0SvCk
         UaNg==
X-Forwarded-Encrypted: i=1; AJvYcCWM5CHHTll4gOenEaops5vAw1ZyIET7lOIbjhbKsS/FJJsMf4B5NbcHcgWzohp1eP5YbK53GiBIRNQqgLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWG9HRR+29KaGE+CgWHPC7Ss7A2AEOL63Cgoz/e2svNv/YUJUt
	LMygdzR3wd/gv2X4/RlKas5xLMil5V4cPoQN5u/IX4Xp+mHNkGc3tnYxIU9HFcc=
X-Gm-Gg: ASbGncsg+WWaaTdpwpNk7qr5lkZbW7SkU101XuURISFBmCmx4IQ0Q7UNU3zSyMgH7rp
	Syl0QUcGjK7NM1GzQmfFqwrY+h2KJvk/IB7z+HAhFdvODUhkILqIPwvdCqpdyPDyGX6V66/w0Tv
	2h2FbrPki0ifkwJFKRMFKqu8J2UUO5xsvo0+QalOdlJ2SCZXc1GFmr/9ZIZrKHMzNPU/AFDPctm
	8G8gqKJp94RjNz4xO7iENnJ6UBLGZtdxSJtYCNAOOv2+D3cY4vkHEBw3SgI9DUtJU9YLjvctszi
	rAlszps796MeS+LAYMMZnls=
X-Google-Smtp-Source: AGHT+IEhS4a23hLc5yRiE+reTRzwxEtxicFqcw6AdK1K55/wi9yfudPn2pEhLuYgK40BExGRzrx28w==
X-Received: by 2002:a17:903:1788:b0:212:4aec:f646 with SMTP id d9443c01a7336-218929e88fdmr186237555ad.33.1734389930253;
        Mon, 16 Dec 2024 14:58:50 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e4ffd9sm48022275ad.142.2024.12.16.14.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 14:58:49 -0800 (PST)
Date: Mon, 16 Dec 2024 14:58:47 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, stfomichev@gmail.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] tools: ynl: add main install target
Message-ID: <Z2Cwp2Qbbodl3x48@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jan Stancek <jstancek@redhat.com>, donald.hunter@gmail.com,
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1734345017.git.jstancek@redhat.com>
 <6e41a47b9ea5ede099d9ae7768fbceb553c6614d.1734345017.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e41a47b9ea5ede099d9ae7768fbceb553c6614d.1734345017.git.jstancek@redhat.com>

On Mon, Dec 16, 2024 at 11:41:44AM +0100, Jan Stancek wrote:
> This will install C library, specs, rsts and pyynl. The initial
> structure is:
> 
> 	$ mkdir /tmp/myroot
> 	$ make DESTDIR=/tmp/myroot install
> 
> 	/usr
> 	/usr/lib64
> 	/usr/lib64/libynl.a
> 	/usr/lib/python3.XX/site-packages/pyynl/*
> 	/usr/lib/python3.XX/site-packages/pyynl-0.0.1.dist-info/*
> 	/usr/bin
> 	/usr/bin/ynl
> 	/usr/bin/ynl-ethtool
> 	/usr/bin/ynl-gen-c
> 	/usr/bin/ynl-gen-rst
>         /usr/include/ynl/*.h

[...]

Thanks for including the headers and doing all of this work.

I tested this on my machine using one of the sample C files and it
seemed to work:

mkdir -p /tmp/myroot/local-inc/linux
make DESTDIR=/tmp/myroot -C tools/net/ynl/ install
cp /usr/src/linux-headers-`uname -r`/include/uapi/linux/netdev.h \
   /tmp/myroot/local-inc/linux
cp tools/net/ynl/samples/netdev.c  /tmp/

cd /tmp
gcc -I./myroot/local-inc/ -I myroot/usr/include/ynl/ -o netdev netdev.c -L/tmp/myroot/usr/lib64/ -lynl

./netdev
Select ifc ($ifindex; or 0 = dump; or -2 ntf check):

Reviewed-by: Joe Damato <jdamato@fastly.com>

