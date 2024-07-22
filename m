Return-Path: <linux-kernel+bounces-259134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D909391BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8B11F21D59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43216E863;
	Mon, 22 Jul 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sGhiOb44"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1933F16DEC3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662016; cv=none; b=nUJV/exYDXOW/Du9b/vKQJI7lvnJhcM02eYfJWR2ywPBJCg5CZrefL6ZLaB+Rz8djRPugo31pMm5EWj9wDKkj+jYqxXP1oxzoYEOJsXGUlsBXOhNlnGPbK93MvUGDBfL/OEfoKITX+z74wIdir4XabDBlr1UT+t8H+gn0bAMtRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662016; c=relaxed/simple;
	bh=zROLnWFUOH9//DnXFkvEIzheV7uPIgEQmuaGwINSTbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrwNJX/8h4/OPqX2gU66NuIlJiY6Pn9VzX0qKpxJXElmwnRtqNkgU31wWL7vi7fdOOJ8OumhNx68BjC1Cd4S7lkXJXEFieiejWK7cPWyBZ1xLvxob4rMl2BgbDt8Av9QDqokk0O5u0hhQlbkzTbINWaLxxtJgAW9IoW2wkGouKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sGhiOb44; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+f765e51170cf13493f0b@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721662011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zROLnWFUOH9//DnXFkvEIzheV7uPIgEQmuaGwINSTbY=;
	b=sGhiOb44IM/zpozOFhFMC4NhJw5i0ahW2iqOU7gAcyeQbk2FUzWS4zyXpcbwLxQqguTS7P
	KfoE4BSzNoo71JclKMSpj+8HMneTh+8ihoda/OtwRnUseQVgAWW+pQ1nNhqCCbzLGAtAaH
	OR2YSidYS+667ob0NNRJgFfHKwe5OBU=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Mon, 22 Jul 2024 11:26:47 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+f765e51170cf13493f0b@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] BUG: sleeping function called from invalid
 context in bch2_printbuf_make_room
Message-ID: <vynklplials4rgqztoysaclfs3nyv75t5wm2g5yov6aoy5kqwy@vng7wfpmwicd>
References: <0000000000005aed00061dd70e04@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005aed00061dd70e04@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix printbuf usage while atomic

