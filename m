Return-Path: <linux-kernel+bounces-202951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8C28FD376
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29943B26061
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F719412A;
	Wed,  5 Jun 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fbcteorc"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D719306B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606804; cv=none; b=jTrdJi4dzOS/h3KHEqg2NTUnjMKiHc7nh8MgxBO57N2DDVcFJqVTX/JsyGkKNqMsuk/oEhDTSKwdIUc5a/Ke7G+ndEAuSB5OyWKlfXi4UXmd1rZs3jJo74bOA951+Bw+txNc6ttIU78bLuavJQM0LFsnc45ei4qK/xN1yXCkvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606804; c=relaxed/simple;
	bh=lpIq1caDdKiMHyQdV9qBvSXjzC7XEcEix/PC/mrNJoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnVGkomagh9qKA3kHpOolUtcFEBW/e+TJ06OcnrXAJuvVZhwzlRjF0NnlPnEjfGkXbGctDM672Z2r4uUPcDmvwbu30HdGtEZMIeVHFci/+Q7QX5AaVsFvmwePTeVRgDRoY+vs+4lFCFxpNLCUTk2l/Pbya7/ZyS8ZbJYEqkbDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fbcteorc; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso419591fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717606799; x=1718211599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVZuE776yGSMDe8Ul9Ea1lg+Z5ediOnv6+D7nuf0GTY=;
        b=FbcteorcxDh+Wou1oPCvW2kIcv/NSB1vG6+WalsTmoEzB1guC0f8GpHNXiVK7Sqzux
         2xP+EpKy76gq7evJNQhptSd6BuZZg7dH4B5IRdQerd05uZgvKfqbKBUVlcpfKB8WJfLh
         Qc9SON2bita2W6BgtRG+02K+R508tBZ2jDaO8py2L5e6tk7GFjf14AMRzkxMuoi76jiZ
         0HAOgp69e7GTlfJH3k1/o/Bg7tqC3kysVos1VeYRJVbbmK6AZojSzmuB8W2Y6HDcGzLJ
         pV5zGjPJzrfb5Vk9CWwehwSa2LIq7fr8SA8fB6UYc5rAVe3EMlgsMfiLvYWMCh6FCF7j
         EiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717606799; x=1718211599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVZuE776yGSMDe8Ul9Ea1lg+Z5ediOnv6+D7nuf0GTY=;
        b=rqCcQB9i+iwhW690nzMRtndciDaM5x2oLXyxG/PnUdmPqB3hgWqYe4jUtwAZ5IxoOL
         DuArmxvgRZFJrV/bwSl7bQAdQ//GBsnJLvjA7odScyvCko4LfvcGreu5P5NjB438fPos
         rU7hq6NDiXK9foqBxhjGDRWbHR8mberOrpv3L0xvSJQ5PGZ1CKpIynlPvgWAjxHlnVI/
         H7uxvWFQwLumtC0VgZyDig2CMojBZAHz5w5q+a6rwmlt9EyD+yG2W/VmSZEx77mtQYg3
         gFRG1Ff24O8hBEqMsWdkEky+jMGYULCJ2ojXq4pgcxxZwW10+PuYZzSNCQLGN20UrNJ2
         PclA==
X-Forwarded-Encrypted: i=1; AJvYcCVGaxDxbjTyNOaD3q6HwSs9Ltcd92qgHevbMVHSD1OqgHn4dkmv2zEXbo4cf5qS+T5dlsbMOHp6NwZT4acHpesYfBm26Y/RWbs2zScF
X-Gm-Message-State: AOJu0Ywus//0YI6dqevoXUA9WQk+s4f2XFOZ9UCeAMl+KVpmQNt3LpNO
	Va5iQkFJXqIjTtwsP8t7feFrAv2CtDVanq3neJ71cudvJbUzjTkn7hYCH9nA3po=
X-Google-Smtp-Source: AGHT+IGQyIYcT8ih8hAmI0CtJkO6gMwk7cz7wAGc278J5vblyTgqD4RkWPSXox62BLmAEN7tcNeptg==
X-Received: by 2002:a2e:3004:0:b0:2ea:7e51:5166 with SMTP id 38308e7fff4ca-2eac7a4c786mr18777771fa.41.1717606799005;
        Wed, 05 Jun 2024 09:59:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c355cd393esm8733569a12.49.2024.06.05.09.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:59:58 -0700 (PDT)
Date: Wed, 5 Jun 2024 18:59:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] printk: nbcon: Fix
 nbcon_cpu_emergency_flush() when preemptible
Message-ID: <ZmCZhcmrVcwpZyYe@pathway.suse.cz>
References: <87zfrzvhsp.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfrzvhsp.fsf@jogness.linutronix.de>

On Wed 2024-06-05 11:57:34, John Ogness wrote:
> nbcon_cpu_emergency_flush() can be called in a preemptible
> context. In that case the CPU is not in an emergency state.
> However, in order to see that the CPU is not in an emergency
> state (accessing the per-cpu variable), preemption must be
> disabled.
> 
> Disable preemption when checking the CPU state.
> 
> Reported-by: Juri Lelli <juri.lelli@redhat.com>
> Closes: https://lore.kernel.org/aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos
> Fixes: 46a1379208b7 ("printk: nbcon: Implement emergency sections")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

JFYI, the patch has been comitted into printk/linux.git,
branch rework/write-atomic.

Best Regards,
Petr

