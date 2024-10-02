Return-Path: <linux-kernel+bounces-348311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55198E59B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6A2851B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7456C1991BD;
	Wed,  2 Oct 2024 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CEsaK1CT"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D671990AA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906056; cv=none; b=XrjSiCc/gXyL9IkqA2yyQH16hQDGGajg8rFULxbjs+YBxqT+bXvJswnDmqc1Gwwfb9+azXVsbIWcLCTSOy/ndadZpdRnkcgwJp3jUPebTiX5mYckdzMVqdGfNXNthTAwM5siVwCJazITbYeTImfZvvLB6PtILPJKOrjda03falg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906056; c=relaxed/simple;
	bh=xDQ+qitQifVRYg24AujVs7NTMCQZL9cFaOM7ArdFmQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrQNdewTKCqDQeesDYnFE1w420XpiUSc3y7ET+P3Ti+bq9n4o1ZxXlTrUD0lVnhs3fbN1gSM5UOzTJGGkaqeNi3lOAu1+WfA0ThWrg5q9/Pmq5B8updCHFUMqUPL/t64rv5pQTmuMKe97QQU+8SQg3f2IQOv+Vy6SRBkK6FwjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CEsaK1CT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zSGb8e86RWNyA74n4ogo73u3GJbgtTSATRW7Vb/uo5Q=; b=CEsaK1CT+2QDhXZvnBDLED7WrO
	dW4ds7F6AbQFnZJLYs8l9WwDsyOPjRcfAqdqBh7+RukpL5JDDX3jy8sfdOBurYVhMLaEaw/c/Zxwy
	gz+x/ObmvADkD2s8d5dbhwmJXTbnFPKdD227+pzwTzWjXhpwGkxqR/KBZWHTtXjCVjKKMccXuwoGN
	eRCuo4zQKCnXfnqkcDn4zH4Gjo1gV2o5HZGb5q/eEk2lP2fJmqrgD7SeqnmmDvZmnsonFc3zlMBPx
	bZzmuh7uYlvZoYJZNl4TU9iADoFx1peIuzoSHnh/2S9q+JA6iR/bKebIxQDofCycU89BYRPqan8yO
	7KWYOUJw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw7IT-00000000KIh-0u1z;
	Wed, 02 Oct 2024 21:54:13 +0000
Date: Wed, 2 Oct 2024 22:54:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Brahmajit <brahmajit.xyz@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: Build failure with GCC 15 due to
 -Werror=unterminated-string-initialization
Message-ID: <20241002215413.GH4017910@ZenIV>
References: <ytw2hroanhyyvrh2ps24l2a6qsdke5m67ynfqcqpzo7wgp3ibv@spvsq3mzltnk>
 <20241002214656.GG4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002214656.GG4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 02, 2024 at 10:46:56PM +0100, Al Viro wrote:

> Huh?  That makes no sense whatsoever - you get a single-element
> array of 3-element arrays of pointers to char.
> 
> What you have written is equivalent to
> 	static char *s1 = ".\0\0";
> 	static char *s2 = "..\0";
> 	static char *match_root[1][3] = {[0][0] = s1, [0][1] = s2, [0][2] = NULL};
> 
> and match_root[0] is *NOT* a pointer to char anymore.
> 
> Just lose the last \0 in each of those string literals...

... and looking at the actual code using that, just lose the entire
array -
	if (memcmp(dir_entry[0].de_fname, ".", 2) ||
	    memcmp(dir_entry[1].de_fname, "..", 3))
		error = 1;
and be done with that.

