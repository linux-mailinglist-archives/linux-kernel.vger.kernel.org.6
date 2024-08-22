Return-Path: <linux-kernel+bounces-297705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A382E95BCA7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C37285EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2518E1CEAB6;
	Thu, 22 Aug 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TVtAne1U"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB21CE71E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346182; cv=none; b=tT3GKw7paD1cXm5psVVmOzXfSBxJqApozO9DiIo9F8YTMIoAykTtBCn/MDH+tYiRJeHOORTRacGp0YOAjZ1vxG/vKhdcgKML8nRdS6M4p42SOkZlS10kAQhMp9O+yzXhKNYEqipBkBkc/ytNZdq3u/Bizqb4PFkAbMlf5s72k/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346182; c=relaxed/simple;
	bh=qIyac7FRZS17y5NyPP/vvfgIoZ3YGywcMPcNzGHXg3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkO5Q9cdcznRWgW7vbDJWiT6ZVH/ytf1aHc0r3fBJz52Ur1MNlLvKrnBoduRoyXpVj+epavHTrRdG5gX/kz4PClf0hfytFDMCrDstgQ6FJdhDa5K9o1GKeNGzzP1FgxxHX6AtNopq5BotJbmk9HRl7rrBDgQaI3z6F0yz8OqreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TVtAne1U; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 13:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724346178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qIyac7FRZS17y5NyPP/vvfgIoZ3YGywcMPcNzGHXg3s=;
	b=TVtAne1UASl4LjNYmTz9GfriZWVUddP0cJor5c1GUBVgEarVr2sOZ3XWlgZYTV0NLOJ5rJ
	lzMgtrxGvbiy9HoLuKjfQfCtaiExlZeuYnKkGJOgGtlVzjcOrs/ng72T0pQWx6N66XRMDh
	LywHBXJmiu6Zfbwut0YQ7OOWuKLvtLw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+ee45465624ceb2e49b50@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_dirent_rename
Message-ID: <6rx4igja6voj4prmk5yk5ttxcv2qa54qcqn3n77dfqqikuts3p@fsn3vojycami>
References: <000000000000cce9c0061a1f1071@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000cce9c0061a1f1071@google.com>
X-Migadu-Flow: FLOW_OUT

#syz invalid

