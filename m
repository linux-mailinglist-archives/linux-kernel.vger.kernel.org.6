Return-Path: <linux-kernel+bounces-426819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C819DF901
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B3928170F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D2322EEF;
	Mon,  2 Dec 2024 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ajL5U/zn"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF618EB0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733107331; cv=none; b=qbw6eglGnRy46KQsHx6K7Aijz+zlXh8StTw491V3E1sr8bSJC7Z4HE6SSSGRGHr8ljdMgK5UXTEo/H9Fx6xiW2k07+G/yjeLxILwCs6q19/c+9+E8trYBpXR2hVcimGIZQbgT/lGDoaxfJT1Ft78I1a7YGiYi70D6M2weEytgSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733107331; c=relaxed/simple;
	bh=/KX+Tfbv92Lmjf+rJdwhcxTtxPddxp7uP9FRSk8uh/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lprE781zMyOIPuIwlLaNCSqe1eCzsjvQ/ZJqI0Cv/v5u4iNFv/GZrVPRZZKRLqu3W7PvX8bBHvSP/fMg0q1Ex56PcFVm6GRJrrMazdUzr64FjPTA3sbQembEh/ATm38L5DWE1h+CWwaMTcV0DFH9qYFEeKWbI5cRRw/B7S/5oMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ajL5U/zn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MBTyDYajn4rl/Fgtmnjv//roBubANP0rLkc6xINt3uo=; b=ajL5U/zn73HnMbrnYta+vsYu0w
	L9+k8x39tnSiTtwmSVgY+091c+lbHRakfTUt+/s8r51hXIbap1bZ9pQCpBSdk0dzeyJR7ULnYMJ9H
	FIRLKob2QluEOE7VjYeRKVWXqc5ZiILQADn6KNYsZ9CID6JQlEoInRFiZWuoMrm/KUH3LWdJdO+p7
	AT6Xym7XJH+FscTkcAkHvxfaf7uEtI3q2hEhPmwDwsCH5y60OJeTXvvyQWg572TqFbC+b1MttuKCM
	ATwqFMCuTJVPJx0kMSJ6ZQW0Ri2UXNLmDUcyqZHrh+uuhY87y9L3is+cLiZbbUGyf2PRsD1ZD2dK6
	WUo8YYwQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tHwNy-00000003tt4-1qKG;
	Mon, 02 Dec 2024 02:42:06 +0000
Date: Mon, 2 Dec 2024 02:42:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic: Failed to create the TCP control socket
Message-ID: <20241202024206.GL3387508@ZenIV>
References: <CAKHoSAuo37CMpkkij7SzPgra4VqJKUMWVV7rd=Mq6r5hXLmhvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAuo37CMpkkij7SzPgra4VqJKUMWVV7rd=Mq6r5hXLmhvw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 02, 2024 at 10:29:29AM +0800, cheung wall wrote:
> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 2.6.32, specifically on the PowerPC architecture.
> This issue was discovered using our custom vulnerability discovery
> tool.

[snip]

commit 22763c5cf3690a681551162c15d34d935308c8d7 (tag: v2.6.32)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Dec 2 19:51:21 2009 -0800

    Linux 2.6.32

15 years before your report...

