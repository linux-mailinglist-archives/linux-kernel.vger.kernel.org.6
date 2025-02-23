Return-Path: <linux-kernel+bounces-527993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56221A4123E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4288717043B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9031E2036FE;
	Sun, 23 Feb 2025 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="ovT+WVlw"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30892155A2F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740352920; cv=none; b=ktlNt8qbfNJ/uFpw1x9Zi8tPnBdhUeIzidEZbOIPpfEP33Hs4oN7k4RC1GaCvPDsRaPC0g0VRkBWnL9JgSFCzfvMD3kyEQjzZPbll7h7sBuSJNUa2RjWB+D2UWzoznPISSbJCrRNZ4EPv97vTxJcCVTU2wJX//bvkQda+UM4x5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740352920; c=relaxed/simple;
	bh=YUpIX3p5KAT012WNBeDY80poqUUYGkSnPO+1asqVCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEteIJZexyGSOIPo4lrnoW9eP6Db9PWnyodLc5chK/4R3yTsgz14/NMadHDW/X0KyX4D++CxPxNd1ZH3ed2jVbH5eB8uyjkHAit2l8tg/9ZxVtWKi9VW9Et4jEaDFdPbgH4JaD0+kQDmsC/iIxan0bsANE+z+Ekv3p8bnPKkfpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=ovT+WVlw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f24fc466aso2916089f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 15:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740352916; x=1740957716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3948LJQT8mXQGK1uSw5EWn56hLyOoSGn19GgIOUKWtg=;
        b=ovT+WVlwupMs/zwlyvVd4n751muoE/CiGnSraD5WTJYsRbUMOIOGtNw5sSN4ctAEGK
         eWynzqR/OkWhlYVlyz0Gu53fp0IziU9KiqOMGKNVlePTgdWlCNCv0xtwqtKZuC8DOYql
         DUvjVC6X/F8+xmgWcrD8OwtVKzP9FifrzJW3B7PZQWjoqeBfhL9lUtqziaRt+5feYW1D
         Ngztk/rJU94OAo61da+dSUr/gQHXEKQRNCfFCzRmlr0i+MAUmxebUDgyKS+tHSx7hK8W
         65b1XPsz61QhO9fvwEByW5ZgiR2Sf/dvGN4Xg3wScUyvsa+RBngFolP1Wg21MEjcRtAE
         8mYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740352916; x=1740957716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3948LJQT8mXQGK1uSw5EWn56hLyOoSGn19GgIOUKWtg=;
        b=MKq3XRdyB8wPrnXkmNKEHOl1+MRJJz43gBNux/vZq71dEUlzioN/rWe0N5df0zul/2
         3H11KHFsZn2B/XZwWqDc38U2pSQO+1uVPOOj7yzziV5OLjOFQOQPyGZcE/ptYu+aAAN5
         LqfB0SzVgsOo+TxTKJxR/oFAnc8L3HqbLDOkHsWNtL1m2x3Yd4dXnEhsX84FJ6lRQWMQ
         0bF5byix5nqzLJklF2iUCNtwv5foa1yCkqnBWaANrMSrOYFTWNlv1FHRg/32FSsDk7OY
         CdtdJQVVCvsXgZcx7tEXZM1frwmicu7uhRZfy1Cq9ovMCseiLHFL8psF6xBy4ja1z0+6
         5VNg==
X-Forwarded-Encrypted: i=1; AJvYcCXB9uvzC67lxarBX2FVq+vgbyBlQqANktGBR14E1JdEbVOcmpueGGEg+SQFUc20V3MbRgAE8vThX823AFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWD1yR6Wj8dQ7ZJHZuwfRgPlt2w6dsen5pswY1swWR28eq+xre
	FcM5DITPYITNv0II5UgwhiOUV44JZ1rG1r53jJ0CVxw3PqOBb/NgxRWeVCPbslM=
X-Gm-Gg: ASbGncs6pwkj0K02qh6w9ah6rhOQvhBYXcWLkYtGlcZSjb/oB4gvYMvTh4+PAwiVwpi
	DRaUpixYdcM4H8oI16LX/5BNfs5K+IqdL/AsB+RqhF1UdxSxvsq6gq9GergdjyA6PWauzn8gl9Z
	x3dg7Kx31zkrBtzpiUgP/Slg8NeG3IX8qgBYqmeHRe3dLabIXSLHYgJFqeMMytTF+d+j40aRz5v
	SZU2epmTlcYl3iIvY+psyKhEDcVI7eQywzDnHZuK49opPRb0EzaCgXHO3QYFIMcpd43jAf+aZvM
	Tg4QSGksTCAQt4Q32wO7
X-Google-Smtp-Source: AGHT+IF/4LqtEeT+DONh96owC4K16mDeErj+C54WXDJj+XOfUMwszVF3GcC+Ead7Ayo982nBvK1xcA==
X-Received: by 2002:a5d:452f:0:b0:38d:d274:4533 with SMTP id ffacd0b85a97d-38f7087d88cmr6419397f8f.55.1740352916373;
        Sun, 23 Feb 2025 15:21:56 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8121sm29536254f8f.88.2025.02.23.15.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 15:21:56 -0800 (PST)
Date: Sun, 23 Feb 2025 23:21:51 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
Message-ID: <20250223232151.xtsobtuoaofotrxx@airbuntu>
References: <20250210001915.123424-1-qyousef@layalina.io>
 <20250212145054.GA1965539@joelnvbox>
 <Z7rTNxHcXWizV3lq@gpd3>
 <Z7rxuqIB38Wv557A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7rxuqIB38Wv557A@gmail.com>

On 02/23/25 11:00, Ingo Molnar wrote:
> 
> * Andrea Righi <arighi@nvidia.com> wrote:
> 
> > On Wed, Feb 12, 2025 at 09:50:54AM -0500, Joel Fernandes wrote:
> > > On Mon, Feb 10, 2025 at 12:19:15AM +0000, Qais Yousef wrote:
> > ...
> > > > I believe HZ_250 was the default as a trade-off for battery power
> > > > devices that might not be happy with frequent TICKS potentially draining
> > > > the battery unnecessarily. But to my understanding the current state of
> > > 
> > > Actually, on x86, me and Steve did some debug on Chromebooks and we found
> > > that HZ_250 actually increased power versus higher HZ. This was because
> > > cpuidle governor changes C states on the tick, and by making it less
> > > frequent, the CPU could be in a shallow C state for longer.
> > 
> > FWIW, I found the same about power consumption when we decided to switch to
> > CONFIG_HZ=1000 in the Ubuntu kernel:
> > https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255

Thanks for sharing the data Andrea!

> 
> The "HZ=1000 reduces power consumption or keeps it the same" is 
> actually a pretty good argument to change the default to HZ=1000.
> 
> These experiments and numbers (if any) should be incorporated in the 
> changelog prominently - as actual data and the Kconfig decisions made 
> by major distros will, most of the time, be superior to meta analysis 
> that seems to be the changelog right now.

I will update the commit message to incorporate data and the feedback received.

Thanks!

--
Qais Yousef

