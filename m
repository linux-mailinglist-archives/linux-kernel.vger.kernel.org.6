Return-Path: <linux-kernel+bounces-331365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E75A97ABDF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DCEB24F55
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B013E14A4C7;
	Tue, 17 Sep 2024 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DW8eoDor"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9215098E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557182; cv=none; b=WF82PcPilgCZRVIYNT5aTE5uf2G2eGZehBOddVbNoiiyJ6vvRXt3Rv0YgMGO0RDvkDP7FyRB3BXCSmGfHJArZff9bMHAItfpOP3MN1rQDxvGko//Ki0VbiH00hJ+Izz9T4InBq5HfPhPfeLH7lFvt+BE1/WB4WgFv++lGuxsIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557182; c=relaxed/simple;
	bh=IE+3C3g84cz30u/b0CNzVmU9Aw4tATRwHirzrYlKs6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+aH0kvVd8RjBFacRR8E8jkQlW/uWXqb8nNHDSpO7QyL6emfpHJpVAJ5/KzB2tiRAL5ShaLl5NXwIrOZswCNY1tps0+K+dxHvbdk7r6+TlZiQ8ikz6EvMx8gxHZVC/akNbycZu8yR8fnUXT7BZi3ovrnGJhBQNGLZ3pd1DWlh7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DW8eoDor; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f74e468baeso45350251fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 00:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726557178; x=1727161978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7LFR1rv+7Akqa0do3CKpmebvkg7hGgIFgJWjbCPkZo=;
        b=DW8eoDor5wUWEzz00Rjyzy3HNwDgZE2g2JJNtJU4oW34KG5C1G1Zu3XG01y+0Y/HbX
         BZdbtPHruTtwmMy4oP8Tn2gcHWgCNSQjQuUkLw/zg6njeKGBg10aBqqqAn00EEEDppkY
         1E8uJjeTBTMqjoMQpC+EKa603JNEneLfPUbAXHLgBbgMxbmM5C5FISd8nrJH+DP7JIMX
         nVQaPRqbENz+jwuDFPfLSkiqkeKkio2wVkoJXWDk1g/FvgN987vwQDX4JtDr0Nxel4mT
         cD9ooM8nLzerhVekEacLecevML+3mgvn8fDd11Mlte5xYGEne9c0zwDCFm/joDSqCwXF
         juUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726557178; x=1727161978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7LFR1rv+7Akqa0do3CKpmebvkg7hGgIFgJWjbCPkZo=;
        b=Lg2heUP2y2blWdR7svGSsZFViV2ioOMdGGQjXQYTVP+8m/TL0xd50RsRcoy9RyGCrz
         XLn/WeqbAyUQ+27Z6DamAU4Bc75+IG9L2bqK8BMqtQafcG6vjCa9q8YBLTOYD5MyM+rT
         3qYDSvZMeZif27s1SwSk/HOxA6SuDsG+f917PK+3OQThhbisMFwCjWPCwysVj0zTk4+0
         WFy0tTj8NN5QAaU7MXkrup8eHDElfjSN4vke7TZIToIdSbA/fY0Uqu67QNqOSw0a4r70
         oKL9WXtAG0otyeB4qE/i4065wyxioQAsFw43vU/fgrqQMxJWSNiRnj3BJOgAbpu4qaW7
         NG2g==
X-Forwarded-Encrypted: i=1; AJvYcCVK2PXk4pdRrijSBe4GBVPqF8IxWHeQx4NlYSL0yaWdCZTzw82tzIua6dKDl4l7k5Fb0OfsxZitsimGLH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybtD1QruRDR1OJ6bYinr7Q1Cjwr/8K7LbEX3/GgvPpVzyGLGoB
	mpIap1Nf8HjvBkR6V5FUfv5dGHPDKGpkbLiZBgQ8A6LhH0J9jOrojbaY2TBksHk=
X-Google-Smtp-Source: AGHT+IGCdObUy+bqBccca8v5viPB+aM6GI00PUDLsPOKmVs1fra2Q70Wj39B8JxVmFwUd//ZkS44aA==
X-Received: by 2002:a2e:4e02:0:b0:2f7:669c:93c1 with SMTP id 38308e7fff4ca-2f7919042b3mr53980281fa.14.1726557177938;
        Tue, 17 Sep 2024 00:12:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7e5bbsm4692681b3a.124.2024.09.17.00.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 00:12:57 -0700 (PDT)
Date: Tue, 17 Sep 2024 09:12:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Song Liu <song@kernel.org>
Subject: Re: [RFC 00/31] objtool, livepatch: Livepatch module generation
Message-ID: <ZukrwP5IVV8Gmoby@pathway.suse.cz>
References: <cover.1725334260.git.jpoimboe@kernel.org>
 <ZuGav4txYowDpxqj@pathway.suse.cz>
 <20240911162005.2zbgqrxs3vbjatsv@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911162005.2zbgqrxs3vbjatsv@treble>

On Wed 2024-09-11 09:20:05, Josh Poimboeuf wrote:
> Hi Petr,
> 
> Thank you for trying it out and doing the research to compare it with
> kpatch-build.
> 
> On Wed, Sep 11, 2024 at 03:27:27PM +0200, Petr Mladek wrote:
> > Without -ffunction-sections -fdata-sections:
> > 
> > 	$> time make -j8
> > 	real    0m58.719s
> > 	user    3m25.925s
> > 	sys     0m21.895s
> > 
> > With -ffunction-sections -fdata-sections:
> > 
> > 	$> time make -j8
> > 	real    13m28.126s
> > 	user    15m43.944s
> > 	sys     0m29.142s
> 
> That's bad.  We should figure out where those bottlenecks are in the
> toolchain.  I know objtool definitely needs improvements there.

It looks that most of the time is spend by the linker "ld".

I have be running an incremental build which basically did only
the linking:

	$> time make -j8
	real    10m46.911s
	user    10m46.533s
	sys     0m13.062s


It has spent most of the time on the line:

	LD      vmlinux.o

I have been monitoring (very ugly way) the linker process.
The last ps output is:

	$> result=0; while test $result -eq 0 ; do ps faux | grep 16785; result="$?" ; sleep 1 ; done | grep vmlinux
	USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
	[...]
	pmladek    16785 99.6  5.2 869892 853364 pts/5   R+   16:50  10:03  |                       \_ ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments -r -o vmlinux.o --whole-archive vmlinux.a --no-whole-archive --start-group --end-group
	                                                             ^^^^^

It has been running 10:03 minutes.

> For kpatch-build, the production kernel is built *without*
> -ffunction-sections and -fdata-sections.  Then those flags get manually
> added to CLAGS by kpatch-build for the comparison builds.

It is great that it works this way. It might make sense to use these
flags only when klp-build is called.

> We rely on ccache to speed up the repeat builds during development.

I see. Well, it does not help with the linker :-(

> So I think this should be merged once the x86 support is complete, as it
> will have users immediately for those who are running on x86 with IBT
> and/or LTO.

It looks to me that many parts of this patchset do a clean up of the
objtool code. It might make sense to merge them even earlier to reduce
the size of the patchset.

Anyway, I am open to split this into more stages. Big patchsets are
always painful. And it seems that there is a big interest to get this
into a production ready state. I am not afraid of ending up with a half
baked solution.

Best Regards,
Petr

