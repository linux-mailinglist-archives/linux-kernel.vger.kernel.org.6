Return-Path: <linux-kernel+bounces-546290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6282A4F8CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EFC189259B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2278A1F3BB2;
	Wed,  5 Mar 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKSxjcym"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3CD1632E4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163303; cv=none; b=sPn6vxWvXg1zWAplGmg+yVG4l0FSNWLt5Yd4hr4MYGIRl5u1Gwgq7/nDofqW4eSWAfY0YAgflOIB0PFqrnJqdUs86uUkf8F/k+rBlNMzZRbApotFquAlKTFVFTuPkIaYRDzdHZ01sVLNOgwDmqGyCcz11YImsEg1xSKmKvXmorY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163303; c=relaxed/simple;
	bh=MSPn4W9sB23/uj/geVRBjgewqoRQ3KPp93gZGu1MohI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hn0zIwaOY/i95aOgvwXtb9C54a5kSFWrZzG/3RHUBRN0/2wwA7wSJL8G0OEwCklvluCV49h9SJomYs59X8q22azqdApO0EYGnlhx3Xu7jIwnuzsI8gdnpY8mPVweLyuF4UY2JmZIZTBDnO3hPr5LcqMHG/dCSjxzTvWsAJ2nA6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKSxjcym; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54973b49353so2146017e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741163300; x=1741768100; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2Us6lCHNOiYnE3yG6wUt2hVFrJOz646FHY6A1kK29Y=;
        b=gKSxjcym0YcZwWYXfbe5A2yMiCtqbQEg8ZEYtY2e3Frgyd67ChFIT5MyHsxV6XqUfD
         Chvi6OfRvQbJ6BR1r6LX568KY99MU/SwlmrrgBfwFxKsze8QRHz4roMpl9C72c1L1nE6
         iVn76sySzkNHawoi24mHdav3mPl8QBv3ZWSoI5f5q5h/yTDbpHEjWefgRA3pCgTkmF/A
         eymNcPxlREczkPCjd8IO+krfhrtgNBOAvbQehiVY3otFLRSbGfQFUv4SCAMPZ2aRY2Lm
         6b8ZZfe9Mr37oIwSeDVq7Z15va4X8f3AZUp7BDm2h8dVc5FCwJvXw9mmH9CiWPl4OSe2
         0U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163300; x=1741768100;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2Us6lCHNOiYnE3yG6wUt2hVFrJOz646FHY6A1kK29Y=;
        b=AKrZ1OKGE53Z4DIUWU5jhblTJt3hiElZ1mSAFOC0mLu8dVBWAKxyXbVDui14CZyod+
         R5RjE/hZUGgk30AVt8Yw1Yodw63oITJIAeJAXiT24RgDkwr35ufPrrAxwrAcQ4yKRDMF
         D+nMVNlyfmM4WeL6sU5esCK3ZBEtWK4h5f0A8OaqMACuMI+ybKSBu49smrbrP5J+vRpv
         +/RAMnPGsblG4bqnpvMo5JAnRpJJruuiLf1yrJBRtRmZSaP2YjE5F8LGzxryNXzuQmm1
         IQNqOsZvtUkj1wTxhdDhTA40wi4sXcopLlC3wDEZFyL0ny7rL1fcRzZRh6We2qQ5dk6Y
         1+yQ==
X-Gm-Message-State: AOJu0YyOOnPBws6NbR4bcjlfKpB+vgH2AmnYtQGahjspuCBn2zpkco9g
	//ap90BBCBw9CW7vUQQ7NSA9aaKdGGI8jcEsmkQ50T8HEYQ7/fah
X-Gm-Gg: ASbGnct/627NoJTxa3s00TgmZKsUhKk9RsGa0WEvLFpRriUfFs0NMYKQhoUqDqMYW56
	EtMJ4vJt/QMlyDIoP3v6HpbuEfyFcVzJUJp48POOvb+cAoNVX8rvgA0dFtLGyAWbLEXIT/da24W
	3IVoLW/69BHMKEqcmbYSfzBVth8dYX8Kk9NIbs6PytSHixOhxd6GT2uls+KAjSOpkVv37HXvNgm
	xcXV+47/bPs7Q/b+IS1SPDxvbivfn2zP43VENV1jBkI/SKSf2r4YwfOLZgYwhsBsDfVXLG2wkUA
	dFKd2nmNGuUDUXq6sWiBbs9K2TKzYnsYAZi20OmckSJE0g==
X-Google-Smtp-Source: AGHT+IGzMfHUOho20kCvu9RmiSvKriVr3+0EToSY1cdxlRJeyuHqpO2AnjX6LrlxbrcVlw8O+Ra9qw==
X-Received: by 2002:a05:6512:2256:b0:545:8a1:5377 with SMTP id 2adb3069b0e04-5497d32f8c6mr707749e87.2.1741163299475;
        Wed, 05 Mar 2025 00:28:19 -0800 (PST)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495831fd43sm1329742e87.109.2025.03.05.00.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:28:19 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 562D25A0136; Wed, 05 Mar 2025 11:28:18 +0300 (MSK)
Date: Wed, 5 Mar 2025 11:28:18 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 10/17] posix-timers: Make
 signal_struct::next_posix_timer_id an atomic_t
Message-ID: <Z8gLIne1nDPa1yp3@grain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.543399558@linutronix.de>
 <Z8YPQn0UpxucZLJP@grain>
 <87sentbyer.ffs@tglx>
 <Z8c-vvnMpPjYRvOn@grain>
 <87mse05yk3.ffs@tglx>
 <Z8d7tm5dQN6dZEvu@grain>
 <87ikoo53xy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikoo53xy.ffs@tglx>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Wed, Mar 05, 2025 at 08:31:21AM +0100, Thomas Gleixner wrote:
...
> 
> The traversal does not RMW the timer itself, it unmangles the signal
> pointer for comparison in posix_timer_hashed(). posix_timer_by_id() does
> straight comparisons. So both only read.

No, I mean that we read the value then allocate a temp value with 0 bit
excluded implicitly, so it is not a straight read, but whatever.

> Sure, we can mangle timer ID instead of the signal pointer, but the
> outcome is pretty much the same. The only difference is in
> posix_timer_hashed(), which must detect a taken timer ID independent of
> the timers valid state to prevent collisions.

Bah, I managed to miss that we need to lookup for not yet fully initialized
timers as well, and indeed it makes no much difference which exactly field
to mangle. Thanks a huge for explanations, Thomas!

	Cyrill

