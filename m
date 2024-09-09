Return-Path: <linux-kernel+bounces-322170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 773CC97253E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E72F1F24B13
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D6E18CBEF;
	Mon,  9 Sep 2024 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cei6t3wu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73318030
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920537; cv=none; b=Mu4RFKC5ajhpSIZ6vAjXhk/n3wONUkw6KAvSeE07kj+7rz/PN4PIZRtobiSeQxegaUIIkFiE3sxFwPFjtAeaZVKCg8bRrWrTJDTcKA2tKhPqI82DjvUyxJJwZCZHlrfOUqp0vcu90xI0oG1O5WoOOrU4fHLG/oND7wdVQNhho3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920537; c=relaxed/simple;
	bh=4beClVqN7D/Iwc6KEaxsPgL+mJPV9ccOCqkLBcUS8eY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MDFPnMGxUaW03n5rKbeMRpjyTpgETI+Rq14k6mHkflc+tdJKT3xfB1Ho0LPGQu376XIZ/4ShEXepxNBH2weROXdot39ITfKpOSWb3iQ67b/6mSqJfuYUmbq45FtAHEbE0/J5whWGsJfksNf2RFN+EzZY6Mw1UQ1CfFDIGyNeFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cei6t3wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D09C4CEC5;
	Mon,  9 Sep 2024 22:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725920536;
	bh=4beClVqN7D/Iwc6KEaxsPgL+mJPV9ccOCqkLBcUS8eY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cei6t3wurYvcqLQ8H2fXgzvGtE6cRpVUyA8AffmgjAgAOfEYxygt4RCJBrALcO0Sp
	 tKa+a1VDEYYmBjjAScghRMc/j+hfnzXgjc/dymeTtOzywRMRjf9jlxXl1o4SETCQw8
	 nNa4ju2UOa82u21K1nS7yiqkywpr4ZHrbThOOBqw=
Date: Mon, 9 Sep 2024 15:22:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Barry Song <21cnbao@gmail.com>, Lokesh Gidra <lokeshgidra@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Nicolas Geoffray
 <ngeoffray@google.com>, Michal Hocko <mhocko@suse.com>, gaoxu
 <gaoxu2@honor.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li
 <shli@fb.com>, yipengxiang <yipengxiang@honor.com>, fengbaopeng
 <fengbaopeng@honor.com>, Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
Message-Id: <20240909152215.31e85028c4d09681f09e7509@linux-foundation.org>
In-Reply-To: <20240827022911.bcje3ofucegg6vjl@oppo.com>
References: <f29f64e29c08427b95e3df30a5770056@honor.com>
	<ZsXho27uAbQ5rEgS@tiehlicka>
	<CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
	<CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com>
	<CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com>
	<20240827021351.iq6i7zkwm32xili3@oppo.com>
	<CAGsJ_4wUrm1Q7Oxb5BHC2ypyf4wAH+UO9KYhCUwsEbhkcc7QGg@mail.gmail.com>
	<20240827022911.bcje3ofucegg6vjl@oppo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 10:29:11 +0800 Hailong Liu <hailong.liu@oppo.com> wrote:

> On Tue, 27. Aug 14:18, Barry Song wrote:
> > On Tue, Aug 27, 2024 at 2:13 PM Hailong Liu <hailong.liu@oppo.com> wrote:
> > >
> > > On Mon, 26. Aug 09:37, Lokesh Gidra wrote:
> > > >
> > > > IMHO, within LRU_INACTIVE_FILE, MADV_FREE'ed pages should be
> > > > prioritized for reclamation over file ones.
> > >
> > >
> > > > >
> > > > > Adding Lokesh.
> > > > > Lokesh, could you please comment on the reasoning behind the above
> > > > > mentioned change?
> > > >
> > > > Adding Nicolas as well, in case he wants to add something.
> > > IMHO, lruvec_add_folio is enough. if lruvec_add_folio_tail why not use
> > > MADV_DONTNEED instead? In MM the reclaim policy prefer to reclaim file cache, if
> > > MADV_FREE'd pages directly add to the tail, they might be reclaimed instantly.
> > > Also the benefit of workingset_refault_file cannot be convinced for me.
> >
> > My understanding is that MADV_DONTNEED will immediately free the memory,
> > whereas MADV_FREE will release memory only under memory pressure. If
> > memory pressure is low, the anonymous memory may still be gotten back
> > without causing page faults. This might be what Lokesh is aiming to achieve.
> >
> Hmm, IIUC, for the reason of watermark, the kswapd would do reclamation without
> memory pressure. I worried here is that the madv_free'd pages reclaimed too fast
> if add to tail.

I'm not seeing much clarity on whether we should merge this change.  I
think I'll drop this version - let's please revisit after -rc1.

