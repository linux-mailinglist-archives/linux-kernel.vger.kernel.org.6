Return-Path: <linux-kernel+bounces-442328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE79EDAFF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1821688FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E61F2389;
	Wed, 11 Dec 2024 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FxpQnYjJ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBA8632B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958678; cv=none; b=tmWjlLO++UJIpgvDFHZG14Kmend2Zt/eYNr+yTIEjjbzqY3NsAVNqeaiJhJf2a+p0wJ+pPny36eUay7wNeWxJDxwmYegIg2Ov7EXoohAoAE+kptXTdf7luihXf2qfrEvRh8lh5piexRgCUG1uwnu5Tz34wr7Zcegc7/4HC1+90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958678; c=relaxed/simple;
	bh=psVmGeeg0n7RVxiczhCqGqOFpNNo+GLWphU/k4sH8ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwWTXQJ2DmRkbfE0Cth2vKtV5DQVk82VVYIO8qMKw+R0nNI/WwXgm7dzXcRK40MgmI4g13eMOKCZIdYgc0ynAMHeI5W2r0wW2Eswsb35tQkXJ563fZojA+wElxE/tZrs5VUYOHOYNTkha9SD7kQ5NKhoLe4H1D6OjFGo7PAIbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FxpQnYjJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2162c0f6a39so11780625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733958676; x=1734563476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+EG/7WO9rnxk/UMBYPJNbuOKya+G3HT2A1S4Lm93oc=;
        b=FxpQnYjJPrzOz6AZPzU8TIkBwkMdI5X8KhMLEcK/63ErMf2pqXczNrSPTwARnpkjnr
         S3lj81gjWc4LbEmyDPH6xfnpH+kBJkDhPIQ6uil7CtmESbMSFwU1AuiBwbNcXoZh+I9j
         NBnaGTFwRqLyVszgWGPdkHXFvnL510M03rBr9m2QgPgTuthOVSqz9tmAHFR9wG57QDxx
         +9x6rPzUq5mzOJe3zjqXW8XeAWeyDH5j3P6h3QZTmOM6nz+snkQwdbigjaSBrSEoh8hN
         VN9sa46cdGg5tmalsUYRCUCH0/5CYgtoEYTSWfYghf23R/z0MLiDx/oK4y1O62w6Hj8p
         ogzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958676; x=1734563476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+EG/7WO9rnxk/UMBYPJNbuOKya+G3HT2A1S4Lm93oc=;
        b=SABDORuEpAc4nPKW3VryEiOgHlAMTZPTwSHzLTRASOstbNwZCEN4feOazv6ycDFtex
         gUdqimGeT9y6d8W8qiC8Rcy/Ybm+BuTblbYukjk8YR01HH1QJtFyGKCbhsjKyXu79pTu
         FOwr9MdLK0Z+cAT3NTZXK5lUTR2VlMBYumdAf5tnodqLEBb9B4Ny8qkN/kGev3RIIlon
         cTm9l8Zc66PqGhYrn/n+Em7oe1LAjU7xRyr4tKqVWWsAnUxBB0ZOuZnIaaLGNGbeLMM6
         pbhiGI2MpwITQjH6q+++jV2sFsnY/1sGn1rx3dPlFoKaM6l2HQFghKbcRWeMouX7TFRu
         FGag==
X-Gm-Message-State: AOJu0YyNhPkhJIyF3dkjLNiutfGXDZASFsWgDEo8/qInyBgN2uuNEEy7
	QI4cU5bawSrpi59gEgrUXHwJIQ/j2wA6gZwgroVrdRsXewkxxMUq7eOjErAIDgY=
X-Gm-Gg: ASbGncvgpRjBMxnRG3WEFvKYeopdZ8MMTSh96bmcbv5ZfSK2/t7Cfqp9y4KaXTZQA9o
	l8frAnhsZX8YcRQh8ct/x4A5x0RAlh4BVGQklrzpLPcwWm10QI6Rq/Yk97CYlO1TOacJYETxh6w
	ZslQ7DFerczZwH7OsnjegpaYSY5seq75CX9pKuH+Fl1L87RdQUuVzogVXL8tT3tX9KVRyTckXQZ
	EWUWcI/VKnzaX1xrEVViYKuj5hE5FjNeE1SqGV5f9IKZzl7xdHU5LdhjCwqRrk6HxBPPQOk9jM4
	LiUQAG4pwaYJsQpoZpH90qtnPPA=
X-Google-Smtp-Source: AGHT+IHFkgcUiHAeKnVBbP1gE3ZyLIcHA/HyCyo9PcJEeIzeOwLROaeZQdHBUaQJg8wms/xI5OCDzQ==
X-Received: by 2002:a17:902:f60e:b0:216:39fa:5c97 with SMTP id d9443c01a7336-2178c7e8221mr17913415ad.11.1733958675715;
        Wed, 11 Dec 2024 15:11:15 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0ab8fsm111999735ad.190.2024.12.11.15.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:11:15 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLVrM-00000009ZwN-2aTK;
	Thu, 12 Dec 2024 10:11:12 +1100
Date: Thu, 12 Dec 2024 10:11:12 +1100
From: Dave Chinner <david@fromorbit.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [6.13-rc0 regression] workqueue throwing cpu affinity warnings
 during CPU hotplug
Message-ID: <Z1ocEDhfwJ0Q-WYm@dread.disaster.area>
References: <Zz_Sex6G6IKernao@dread.disaster.area>
 <Z1oY1qk-eWU8IcH3@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1oY1qk-eWU8IcH3@slm.duckdns.org>

On Wed, Dec 11, 2024 at 12:57:26PM -1000, Tejun Heo wrote:
> Hello, Dave.
> 
> Sorry about the really late reply.
> 
> On Fri, Nov 22, 2024 at 11:38:19AM +1100, Dave Chinner wrote:
> > Hi Tejun,
> > 
> > I just upgraded my test VMs from 6.12.0 to a current TOT kernel and
> > I got several of these warnings whilst running fstests whilst
> > running CPU hotplug online/offline concurrently with various tests:
> > 
> > [ 2508.109594] ------------[ cut here ]------------
> > [ 2508.115669] WARNING: CPU: 23 PID: 133 at kernel/kthread.c:76 kthread_set_per_cpu+0x33/0x50
> ...
> > [ 2508.253909]  <TASK>
> > [ 2508.311972]  unbind_worker+0x1b/0x70
> > [ 2508.315444]  workqueue_offline_cpu+0xd8/0x1f0
> > [ 2508.319554]  cpuhp_invoke_callback+0x13e/0x4f0
> > [ 2508.328936]  cpuhp_thread_fun+0xda/0x120
> > [ 2508.332746]  smpboot_thread_fn+0x132/0x1d0
> > [ 2508.336645]  kthread+0x147/0x170
> > [ 2508.347646]  ret_from_fork+0x3e/0x50
> > [ 2508.353845]  ret_from_fork_asm+0x1a/0x30
> > [ 2508.357773]  </TASK>
> > [ 2508.357776] ---[ end trace 0000000000000000 ]---
> 
> So, this is kthread saying that the thread passed to it doesn't have
> PF_KTHREAD set. There hasn't been any related changes and the flag is never
> cleared once set, so I don't see how that could be for a kworker.

....

> > I didn't see these on 6.12.0, so I'm guessing that there is
> > something in the merge window that has started triggering this.
> 
> I tried a few mixtures of stress-ng + continuous hot [un]plugging but can't
> reproduce in the current linus#master. Do you still see this happening?

I don't know. The machine that I was using to reproduce this has
been down with hardware failure for the last two weeks. I might have
it back up today, and then I'll be able to start exercising this
again.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

