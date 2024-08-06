Return-Path: <linux-kernel+bounces-276832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CEE9498F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52C21C227C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA61155726;
	Tue,  6 Aug 2024 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeHwzW+r"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FCB73451
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975656; cv=none; b=h1Uybch0ywtDxwcGHGEbJh7iHoFLaSY0O9/iNXYdiW69rsz9v8kqf+YzIypprO4wzSRdd+dqEtQWjjxfl8syCb7FUPCdzNccP2MEKJOIGKH/Q5CKhjJV0Z9Rgp7flTDvt/1GvHwdjtadH9tZvCU7CrcYuvkqBYyQzeBRx4iTPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975656; c=relaxed/simple;
	bh=lbD2yN7+U0zSlm4dKUDg6s57Ahi2A+OIRdKwppqjUGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPanJo3M1+zNhBfH0M6J//sFWBlzMV7mFD2C02ee6HmlcFqL2mExLcdB7ZwyKTVZsiYF0StjjR/Zw1WKevcgxHotoQJrXioSHcfBVPvSx1fh876P6UmiefzaXybDgwRP1ktQVxv3kO+tlqrMeyfuRwxU7n+6/jWymofZ5kRMtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeHwzW+r; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd9e6189d5so9225425ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722975655; x=1723580455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S01QFwPjAI6in0wYYdm17SnJVb2Cx1kFLtFbTqFHpRo=;
        b=VeHwzW+rWvJBubEMBgOdY8qsBqgim8ABELINgS5dP66RCgZ/pakb7DB0SXN29+e/Hm
         Lyb6NZxflD1utaa4/d7l+SgOwO60u+KwNYxG8+3kaef++FVLggBCeOcva5ER4tULT7w0
         Ov7lVuBdPegPgN0sbABK9Oxvbt27/MOz/K7CgUEON2dToKI9aojRBC2C/c5y9shZVhwK
         bBJnKsub+d8FkmMYlWyLCi87b2TAPiHy16bhipAoAnXDmNKVzACUciyO+Ch0S9EpIQAc
         qckx9Y9WDfqgykgMox6DccNpuYq9HNCqfKyVa8HR2cvwjn4iHq+ZjVHYdxRp4xEtkgze
         GRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722975655; x=1723580455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S01QFwPjAI6in0wYYdm17SnJVb2Cx1kFLtFbTqFHpRo=;
        b=L3UY/dWoOjS0RLnUGg8OMOU9mWKLWOas+2wReosoWaX0t/HgDIfkoXBejFRWNosSqT
         oLjgpcYqhhwox/a4hFfNdGHlRgG3QPKPRNvW1kxLFVohvZitf12TA2efxVgaqFjh9u2R
         2QKK2z0s2tYPouF94ZRTI1R4c9L9VLpKQRagOWqZ/CLD7mIQCt5hrDKb0bheq52I4xNV
         Hp4QbnlmDJdPmvJ+iLSuEV4CzuFbwEng/Nh2GxENcV3hIM7QGkN30s0tQLU4mu0xeUXX
         pTZN9mcY4OovxEhAX6fazSOV2u6IPw46UGmIQRxNs6L1FXNpM7H3i2qD8Yl4Fc3d+ea7
         2zdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEFd+8ecEtJeGdWXw5Ufjx6UGJJwTDrcU8Ye4AnULBbyKzLgMs9oteHILuS9k7VZR9RGw7406QrrT1QP9bo7TNTJ665WvpOcyyoXxL
X-Gm-Message-State: AOJu0YwukXIxSnfaCUgJzu9md5HtvbbFpAGTrON0g0lPb0cWXPR9Ks7H
	7B2DbNeZKb16UQK/IhjLIvjLvbLiEV2Z8JoWdGUPs0jrtsGupFyJ
X-Google-Smtp-Source: AGHT+IFmLGVSduRWWrQpg7B0OrScjCWZ7oUp7n6LTZv/4VMXccfTsOilTQNlNTt+QfIHmITZgw+vRA==
X-Received: by 2002:a17:902:d4c3:b0:1fb:68a2:a948 with SMTP id d9443c01a7336-1ff5728183emr175162085ad.15.1722975654528;
        Tue, 06 Aug 2024 13:20:54 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905ca1bsm90924455ad.138.2024.08.06.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 13:20:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Aug 2024 10:20:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <ZrKFpCz2hbSjvE5M@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZrJ_9OF3TaXA3xtp@slm.duckdns.org>
 <20240806201845.GY37996@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806201845.GY37996@noisy.programming.kicks-ass.net>

Hello, Peter.

On Tue, Aug 06, 2024 at 10:18:45PM +0200, Peter Zijlstra wrote:
...
> OK. So my plan was to finish reading the for 6.11 pull diff, and then
> merge that eevdf patch-set I send out. Post those patches I had in
> sched/prep that re-arrange the put_prev thing. Then merge those, and
> then ask you to rebase the whole lot on top of that, after which I'll
> pull your branch.

Oh... I'm planning to keep the tree history and just send the pull request
to Linus. I can just follow the core changes and update accordingly as
necessary.

Thanks.

-- 
tejun

