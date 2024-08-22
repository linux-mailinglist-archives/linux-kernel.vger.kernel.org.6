Return-Path: <linux-kernel+bounces-296525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9DA95ABBF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0B8289E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E21CD16;
	Thu, 22 Aug 2024 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c8NnB9un"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1BA1BF2A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724296030; cv=none; b=LrVZrdePHM4MRGS6D7/jmYLC6haJHw10Ow0p2czlHvp5xAoVmb/kHfl5QQBrkujy8YdqxY1TcSpgX0Mr6KoHGlwJ51em59RqaMI8/qAv5F0w/P+PKzikIlu6Db5BR8HOBcCQmVYNwa+CtLFnFNQgZ3r2+9TzMH40+5XCVSKJBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724296030; c=relaxed/simple;
	bh=o2dtl2JT6nrj+9GJIMSkKJjAr/7Xcve0erpuXfg/EDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d19eGDE7DHrJQjtIlKOqc0Eky06zHgYnnCF70ja6hTIUskTnR4tS7Try+zNhp/jBD2fc11sPwZQlXA5H1OgRfFTFrvYrFkDSV/6SSHazEChLZlzw0rpPG/X6qS8lsfWVKdFbn/biZjmVC1v0MxunzChnT/AehrqYCo/WriMSVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c8NnB9un; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Aug 2024 23:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724296026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2dtl2JT6nrj+9GJIMSkKJjAr/7Xcve0erpuXfg/EDs=;
	b=c8NnB9unkmWNH97qzvmj+YNQeTZ3BV3KNh59HK4alOx2VYkidL7DErk1H1/xuJgQH3kMkm
	dMfBG51+gFtGkvBG5siAfi07NgtwX4pM5fV/bCJzwPkFUZnZ1k5zwg45zZf0axF5UnIKRm
	hMS1Op9V7KcPMxwGVHbBG0HS9MmiFq8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+50bcc3c92dc2516c4ca7@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in __replicas_deltas_realloc
Message-ID: <thnmgxo6aa3zbxirxa2pkdmgcw6tl3hkgiijowzkhzxdfnsvzn@clwx5pjpghfs>
References: <0000000000007b5313061d7b897d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007b5313061d7b897d@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Disk space accounting rewrite

