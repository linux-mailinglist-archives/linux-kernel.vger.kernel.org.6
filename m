Return-Path: <linux-kernel+bounces-228622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6197891625C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F96728106F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4993149C50;
	Tue, 25 Jun 2024 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CjQag9rL"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07271494AF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307951; cv=none; b=dPW26sXLoYh6tQvappKowemcTqM54/ibLa2GyJ+rzXmw8AUUwAc4AyrH++B1K8vodWDqWeNzPVCxTCMB/Cya494ECpOnRr8LPrmroQesi2OQFu6i3SzjjdS8UP4TY3t7GlwEv+jElD0p+42eO23rJzdj5i0W5NG8RPvfaNkUxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307951; c=relaxed/simple;
	bh=wv1Mo3WswpKUsE73KC474IURZEDnsXQjgmzkuzSb0eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfZwP39ViT7fZyNURBG9m57PgBWtNP0n7b9kvBL1BfFcdK828A4uLMp7CPmbZ1KjkxW/BsMeAUa5u3RDAhdidEZiFgq6tZPAdwfuwOTSFwrbxFKxmXWpuNZcv3ctcl+sSNXMlyg7r1VsLwySsDdOh0uYkjiO/Btz+apA/XJdOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CjQag9rL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec52fbb50aso36802641fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719307946; x=1719912746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqshuwDrjdoXUHKKVyNi7MkOthDOzOvgWLrkKM4nxgw=;
        b=CjQag9rLBHxGWG4DiiwdhpbjIHXla/vvX44MQ9w+y4r7HKmwiYEXZEiVOOg1z+7abb
         01EXIbhbGXqlUqF3cHMKkZu7nBPGB/5MHm7pjPj8OA0Z4GaAV2g5Qm7gy2SUCPeTQFU7
         c2GSmqkd4dRDom4ndv0lVpgrIufqygwq3KRws1HdEikPqAVXEG/LEqJPjzHFgxdeZCuS
         wffym17tK7rim08AOhVguUD5eDrv7/VgGrZZy2iws2UjjF+k3T/uOBHZtYE3ixLGo6jH
         +N7Q4hgqeaDW7Jd4S4Q0SjgmHahw2cklmjh411rN8WwPdamCOfCSit1afeK2ZQdMVsz5
         ZDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307946; x=1719912746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqshuwDrjdoXUHKKVyNi7MkOthDOzOvgWLrkKM4nxgw=;
        b=ZQWjpg9lRDKl5cMWVWulWHTKKReK68W7FkV+q1yNSVpPxSW3W2woSV6FtvFsEpQ7lO
         vnJFHOTucDPPzb2QYiL4gI+WkInTQy2SbR3nMwf+1F6bIIcsR6NhTq5GikWxAKor8F85
         9EgQb6gGMQpsxJv9kPY/BndPQdIm/EfGVPbt9eI3M99ZcdzSFydSOxJTLCPYKuwa4U41
         VxasFAXZmHod2DjbOWY35Klm9DIu95fnntnJ/2bmQKYbJwHL1kMCdtsYxeKWHmb4lw8N
         7zwyPEkMQ/e87JgzhjItA5WEjtfeK6PJGZumNZVpiBmUko0GGkNgooCR7b8iGIW7Grx8
         c3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz4mvTZOHtZTM4q89mlvC7XmPK/1Ei8ak1zD+E99Kkx6Q+A1i841s5zKo1wLrVDraTm2QDoQh4vHr6WYpTy+9ZlDLp2NPc2mU72nEZ
X-Gm-Message-State: AOJu0YwZgRZjZ3Lcz7/+g2hHIIy2Ph8m8xAUKhnwpv1DdFOuAqxJN87U
	h0RM9jHkGk5/AYHXbs6VNbDNcUzBXqJTexnLgtRXiifCAWXHSAaj6ot9RzwFPvQ=
X-Google-Smtp-Source: AGHT+IFsd4DsX2vKsfBhM47QP/hfmLV2dDS7lLtGrUFPiJkrN4N+bXqwZ4Ebe+haoZ1gZcv0bVpmFA==
X-Received: by 2002:a2e:9684:0:b0:2ec:507f:7319 with SMTP id 38308e7fff4ca-2ec5b36a98amr55201981fa.43.1719307945815;
        Tue, 25 Jun 2024 02:32:25 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819dcf158sm8196671a91.53.2024.06.25.02.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 02:32:25 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:32:16 +0200
From: Petr Mladek <pmladek@suse.com>
To: Mark Brown <broonie@kernel.org>
Cc: Greg KH <greg@kroah.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>
Subject: Re: linux-next: manual merge of the tty tree with the printk tree
Message-ID: <ZnqOoGjy7nAiV4MW@pathway.suse.cz>
References: <ZnmwwfMH50s9LiT5@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnmwwfMH50s9LiT5@sirena.org.uk>

On Mon 2024-06-24 18:45:37, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the tty tree got a conflict in:
> 
>   drivers/tty/serial/8250/8250_core.c
> 
> between commit:
> 
>   b70dc67cceb97 ("serial: core: Revert unusable console quirk handling")

I have just removed this commit from the printk tree.


> from the printk tree and commit:
> 
>   ffd8e8bd26e94 ("serial: 8250: Extract platform driver")
> 
> from the tty tree.

There has been a race between the changes in the printk and tty
which has caused these problems. [*]

The conflicts between the printk and tty tree should be gone now.

I am sorry for troubles.

Best Regards,
Petr

[*] In fact, I have removed the entire patchset fixing the regression
in console registration, see
https://lore.kernel.org/r/20240620124541.164931-1-tony.lindgren@linux.intel.com

The feature is going to be reworked. Greg has reverted the commits
introducing the regression in the tty tree, see
https://lore.kernel.org/r/2024062551-hubcap-bauble-fae5@gregkh

