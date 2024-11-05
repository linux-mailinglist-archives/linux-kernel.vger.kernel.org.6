Return-Path: <linux-kernel+bounces-397135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E15A9BD72B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825131C22078
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58BB2161FB;
	Tue,  5 Nov 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="nb0IBvxg"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48320D4FB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839338; cv=none; b=mmj1aIKRqKm31okKpCaWz32WQ2ytgBkb2cvQI0wqmhyLgXnjcaVT20lq+w5yKmViygVp7CY/OAlGbOJ033wJsAyD7kkBAxDCRyxViGoxOdcF4Rd5eUVTSYxo6EhfYzQT4DRCOI8j+eUfSXZC/1EujofZs32/Auq52Z5F3nPmXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839338; c=relaxed/simple;
	bh=7ON9W20Xj5wUtlNid6FvqrSm4m3tZah7hwTkMZJMwBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7WXHQjdHQCjRNRgzVFItcZGyY+LJ1+qnn1JEA2c4P1ob5fws1zBxFbugdY5kvgwMqHoeCXW/WeOx0dqnWVJbV0v6m+2LtE9nnul+JFEFSgXjJQWK82PnFrzojtGps+K0Ixh3sLCha2r7b7W2yJ9+nu/ZI8YNwr6C+1/sHPeKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=nb0IBvxg; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b148919e82so413907285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1730839335; x=1731444135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PKa9cHj9kGwvPwp2QSl7YFPTHIINj3Z23PWuU6t00+k=;
        b=nb0IBvxgqxmC9BvMTxW3mn8Ngqdiu1Amztlz1OX9ixMo1WnxVGrlIbuEJviwUN6nyt
         yd/yZuBcBXMUSdKXKwq1hF6EXaehOlpMTHb2OjOVgwX0A83dxksk8xL+xR5OFrT1LQwF
         OMECFRPwD1M4MXo0QyH5Zgp5LGW9aBocOmUpyLGo6TzsLEgAxAy0iYV1TTI7Ya9JwIHQ
         v37UO1KNrju5O9EQS8VfiJ6q5d9RxqNaeeA/546Dedsiz5ebzoidlcWJ5fqrOb4KTtjL
         CeDTui9Gx77fgX1m1ugEgs3qsApoGpwRFQNBi/a+NOXOfjk5EVLfZxs3yWBfHLs9ji5U
         JnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730839335; x=1731444135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKa9cHj9kGwvPwp2QSl7YFPTHIINj3Z23PWuU6t00+k=;
        b=qG4KchQpTAp2bM94gJRj9TKNUqN8JinpnRqENZ2+vsTnbY4EMH/oKIsLCJlDx9F9/x
         AWjy2tqDYDtnqyHbn6Dq0P4RYyZN+GgMnaeddvKPl6nzPMZbCCE7sLD73bkIHI/LpRwJ
         3YehBSrJ2ANj3bb2vSd687U8IRFoIo8mUraXTGKWc7ZWCArXNT35Haq1p0j3pUG6lNu8
         Aq/HfGjBhKSKfmVW8OVJ89OPoxBjsBQ8qo6LNq2P4WrL5c9VrwOKZX4hNozT/Bbksh7W
         Wjwzzx2ecplQk8to7Pa3mIWfctewAMpYuQB+F0EuS5nwv937R+a/pWD1wkZVeVc0nrOU
         rijw==
X-Forwarded-Encrypted: i=1; AJvYcCUn9KBUbvI01jrlpSqmZ5XlMjLtH2CiFiB28zri1NHbvL/mnafSSC4gSlVtpX8JW3oPcByOF1+RoiO3gh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIy/B7ZqCC0I06UHozBjIyC1LiZCVurIaYNj7UvMqn/RhFlLXV
	j343ymZ7v9tgnt/aPN/9vKykHlCgFmKiAcIxZjbKpas9g+29JI70VLxN8e9O0g==
X-Google-Smtp-Source: AGHT+IGLtHVQCozvs2LpnAtMWfAj3RRmkYSf+6MmmzJ7Zm3md0giCBLprcvqMrc91E/bZGIm2mFmlg==
X-Received: by 2002:a05:620a:2415:b0:7b1:50ba:76e8 with SMTP id af79cd13be357-7b2f24dd667mr2787603485a.23.1730839335584;
        Tue, 05 Nov 2024 12:42:15 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.12.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39fb2a4sm559966985a.47.2024.11.05.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:42:14 -0800 (PST)
Date: Tue, 5 Nov 2024 15:42:12 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com,
	linux-usb@vger.kernel.org
Subject: Re: [syzbot] [mm?] kernel BUG in __page_table_check_zero (2)
Message-ID: <c5a71213-ca55-4165-8e50-2686d05614e3@rowland.harvard.edu>
References: <67230d7e.050a0220.529b6.0005.GAE@google.com>
 <20241104200007.dc8d0f018cc536a4957a1cd0@linux-foundation.org>
 <f94f3351-be53-4d61-a31a-2bb07925c5ad@rowland.harvard.edu>
 <20241105110236.40819b7effad3f44de73dddf@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105110236.40819b7effad3f44de73dddf@linux-foundation.org>

On Tue, Nov 05, 2024 at 11:02:36AM -0800, Andrew Morton wrote:
> On Tue, 5 Nov 2024 11:39:59 -0500 Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Mon, Nov 04, 2024 at 08:00:07PM -0800, Andrew Morton wrote:
> > > On Wed, 30 Oct 2024 21:54:22 -0700 syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com> wrote:
> > > 
> > > > Hello,
> > > > 
> > > > syzbot found the following issue on:
> > > 
> > > Thanks.  I'm suspecting some USB issue - fault injection was used to
> > > trigger a memory allocation failure and dec_usb_memory_use_count() ended
> > > up freeing an in-use page.  Could USB folks please have a look?
> > 
> > Andrew, I'm not sure what to look for.
> 
> Thanks for looking.
> 
> > Can you read through 
> > usbdev_mmap() in drivers/usb/core/devio.c, along with the four short 
> > routines preceding it, and let us know if anything seems obviously 
> > wrong?
> 
> All I see is lots of USB code which I don't understand ;) It seems odd

Well, I wouldn't expect you to understand the USB-specific stuff.  I was 
really asking about the memory-management calls and error handling.

> that usbdev_mmap() calls dec_usb_memory_use_count() on some error
> paths, but goes direct to usbfs_decrease_memory_usage() on others.

The paths that call dec_usb_memory_use_count() are those on which a 
memory buffer has been allocated and needs to be deallocated.  That 
routine then calls usbfs_decrease_memory_usage() as needed.

> Did you try running the "C reproducer"?

No, I haven't.  I haven't had much time to work on this.  In fact, I 
couldn't even tell exactly which call in dec_usb_memory_use_count() 
caused the fault; the line number listed in the bug report didn't match 
up with any obvious suspects in my copy of the kernel source.  Was it 
the kfree(usbm) call?

Alan Stern

