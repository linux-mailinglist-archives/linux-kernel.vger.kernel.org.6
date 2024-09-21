Return-Path: <linux-kernel+bounces-334879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2683797DDC9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DB71C20D75
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4DE176FAB;
	Sat, 21 Sep 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e2SAnVp0"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268F172BA8
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726935137; cv=none; b=X3xkvirIugueAe78rmO7Eevjoafb6n6QhX/EdOFWzC4yJnvRSDe5HbpLQDQfbCEUX9W0zNpMY1rWydNyyn+J19dHPFAjdyA4FMakH3VtsVMghS1941Vl229q3WT1pqVE1UWXMJD87EVRzlOjgf4x9YGDuhMHy8DahOsJZm63dNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726935137; c=relaxed/simple;
	bh=wnUAzHE51MAj3Np4uvoAkqzGcmUs1B905iYI1q4uCqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnBwiytzBHOURC55AlYvqyCV4UDSdcfDfI8/pfrkjXD5/ry/9zfVIO+WMtBhG2swqQ3xxUyNIhSyGUGJeTfa4iAKEvX9A6Ac4sbmB/C2/roqN4PBDnQjV25T1fC/jGfSrIh2FSMv2OI9kvoOzdBBRcLqvVgP2pTp9aLLLnLJnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e2SAnVp0; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 21 Sep 2024 12:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726935132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vm/3YfNAdiY98KQ4jw68VIADaqbq9dRlSfZfNb2kIMs=;
	b=e2SAnVp0UKYsfVqjR2nxFaljK2RvCZhcVsn331OhDp66eH+ZI73KI1kn0DuUBLbShqux36
	WGm98TGPSekqmouGi+r8wJYQve7387SGBkXapoiyDQcMrIC/E/xX5XgT87R9u3AIuky96R
	Tu618ztUc3AGXh/xVEoOP5Qw1IDQePg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Wang <00107082@163.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] bcachefs performance: read is way too slow when a file
 has no overwrite.
Message-ID: <p4kifs3bwqe2ibq5ezx26c6jse7cjtkourlmkectx4sznrpqjk@ncvqp7rqjt6v>
References: <ka3sjrka6dugdaab2bvewfbonc3ksixumue3hs2juhajhjm37w@bnxvz5mozpgr>
 <20240907103437.71139-1-00107082@163.com>
 <ebqvaqme76nrgr2dh7avy7yjwxsgnnybxuybgxejahupgbrqw5@a6d244ghjqis>
 <531cddb2.430d.1921551ada4.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531cddb2.430d.1921551ada4.Coremail.00107082@163.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Sep 22, 2024 at 12:02:07AM GMT, David Wang wrote:
> Hi, 
> 
> At 2024-09-09 21:37:35, "Kent Overstreet" <kent.overstreet@linux.dev> wrote:
> >On Sat, Sep 07, 2024 at 06:34:37PM GMT, David Wang wrote:
> 
> >
> >Big standard deviation (high tail latency?) is something we'd want to
> >track down. There's a bunch of time_stats in sysfs, but they're mostly
> >for the write paths. If you're trying to identify where the latencies
> >are coming from, we can look at adding some new time stats to isolate.
> 
> About performance, I have a theory based on some observation I made recently:
> When user space app make a 4k(8 sectors) direct write, 
> bcachefs would initiate a write request of ~11 sectors, including the checksum data, right?
> This may not be a good offset+size pattern of block layer for performance.  
> (I did get a very-very bad performance on ext4 if write with 5K size.)

The checksum isn't inline with the data, it's stored with the pointer -
so if you're seeing 11 sector writes, something really odd is going
on...

I would suggest doing some testing with data checksums off first, to
isolate the issue; then it sounds like that IO pattern needs to be
looked at.

Check the extents btree in debugfs as well, to make sure the extents are
getting written out as you think they are.

