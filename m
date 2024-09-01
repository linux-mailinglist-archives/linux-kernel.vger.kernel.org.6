Return-Path: <linux-kernel+bounces-310073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B6967476
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 05:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA6BB219CC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD72BB05;
	Sun,  1 Sep 2024 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="V6a5eHlJ"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F771DA23
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725161735; cv=none; b=HU1jtUatdZOaJM+255HAkDAq+VZth6vDwnkmXYQ+lcMnKMM/3RK43qXKjaP5QOnuumKU2of610Okh7w+MtEiATCEYDQ6/IVB6gTmeOhyLvxeSmDMkNWAzz/Z8trA0b9xN3Oi4bOdOgJtLoHAD/CwJDh5WoXwazTYopTr1AzXmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725161735; c=relaxed/simple;
	bh=JYpeIFxDNlsg41d8x+D4nO73R/974DBaOVfx9WRxIC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUsITrnLrcHtX6pbG18uLnw8dvDVFdRTHmsvEmxBLp+m0yko3Ts+w6yFIPrOzivnJM8uQGjzcoODKJdfdaXkBa6U5aMpdTw5WFSBLLCVyGEqxhQRzG0Q9yAne9hl6FmQ2W06IHcXvNCb8a08koK7dppTYBtLR6vpT6DKz9TA56w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=V6a5eHlJ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70f6732a16dso1747926a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 20:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1725161733; x=1725766533; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w16C/dsCRPyIteVCdQ7/x1WEr4oeyIf5x83o5J8691E=;
        b=V6a5eHlJa5bCLPo1qX27dXIqI1IE21mHDLkYCVvGDvpgkICA6wD9xg3kVo9tx1ndOr
         wVYMPFl+pB9g2Mw0993FULLrGE65tj0q4bcr9y8v/Rm5XmgCybmpHtyRWrIAd7fbgL7c
         OMHEd/dzxNFMGQmn0WZIQk1y1Cu5Yx5klc/eaWLCv5ZkwB6RwIXndD5VRCH8zrxImcac
         6A3OuXc4sU7rC+4F1Gmg7pMOTrZ7YcPOP7O5uSDI9rlnnLQP53454/GshPogOgTt9Zaj
         V5IEdFpSIkWn2AyNGJbZ+pCWQ+Ylu82vq6cLNxKm5I0keaGxCa5hn4o/df3XcmO8RcFk
         w8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725161733; x=1725766533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w16C/dsCRPyIteVCdQ7/x1WEr4oeyIf5x83o5J8691E=;
        b=MeXg7mb09OGdEYs7zTdg/azYyso2zCRiFtz+YvUClk7MQMq3ZF0TdT2z7b6rxiAben
         z3cBMjjACYJgb6xe5cFKcBi2AdaencwccphjTyuA9a13tH+BnqgM5TlNvY/mjoUN3yWE
         Dl0jK1xTC70dtART+UEBUzF3oGF2nl/goK99Xy7O3ZG9XhK2MuqNXuKepQSZsbY27PqC
         2sGTe/ctG5kHlnJ7zehLT59BdHApfn6BqIUh61prw/6aYa4sbE+Iv8BvCNbtTm/XINZg
         KkH9jkLDnGLMyjXf3v5D8ldYHMQUVFM09SAgRwboNDXTRS9w033hYCOnXOGta7qqaduG
         SJSg==
X-Forwarded-Encrypted: i=1; AJvYcCX7RBfR1vJX+sz8ss9D8gzEtSN6hvZVUpm2RZTcTjhArmrdAtCqLnFmA6nOfI6vpIs8Ww/WqnrFHKwYdYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCETOdOnVv9If1XJlrsXVZtX0H/vso71VlgU4ryo2HZNLWjNFw
	Y16jiyGu7uC+psqBdNdNxYZl8LbYybzSHjIfT5gCJCcvge84pt0UDwK4BN7iDjg=
X-Google-Smtp-Source: AGHT+IEROnVTbJpSKcYM2An6IRLRNqxVW8qijP9SjeKOdQlOe3qMET8T4FdD9PUv71Bc9UcQL0ol5A==
X-Received: by 2002:a05:6830:6883:b0:709:4552:1f70 with SMTP id 46e09a7af769-70f5c3e68f5mr12020746a34.24.1725161732882;
        Sat, 31 Aug 2024 20:35:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445d5ba3sm9000029a91.11.2024.08.31.20.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 20:35:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1skbNB-002Qac-2a;
	Sun, 01 Sep 2024 13:35:29 +1000
Date: Sun, 1 Sep 2024 13:35:29 +1000
From: Dave Chinner <david@fromorbit.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <ZtPhAdqZgq6s4zmk@dread.disaster.area>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area>
 <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>

On Fri, Aug 30, 2024 at 05:14:28PM +0800, Yafang Shao wrote:
> On Thu, Aug 29, 2024 at 10:29 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 07:55:08AM -0400, Kent Overstreet wrote:
> > > Ergo, if you're not absolutely sure that a GFP_NOFAIL use is safe
> > > according to call path and allocation size, you still need to be
> > > checking for failure - in the same way that you shouldn't be using
> > > BUG_ON() if you cannot prove that the condition won't occur in real wold
> > > usage.
> >
> > We've been using __GFP_NOFAIL semantics in XFS heavily for 30 years
> > now. This was the default Irix kernel allocator behaviour (it had a
> > forwards progress guarantee and would never fail allocation unless
> > told it could do so). We've been using the same "guaranteed not to
> > fail" semantics on Linux since the original port started 25 years
> > ago via open-coded loops.
> >
> > IOWs, __GFP_NOFAIL semantics have been production tested for a
> > couple of decades on Linux via XFS, and nobody here can argue that
> > XFS is unreliable or crashes in low memory scenarios. __GFP_NOFAIL
> > as it is used by XFS is reliable and lives up to the "will not fail"
> > guarantee that it is supposed to have.
> >
> > Fundamentally, __GFP_NOFAIL came about to replace the callers doing
> >
> >         do {
> >                 p = kmalloc(size);
> >         while (!p);
> >
> > so that they blocked until memory allocation succeeded. The call
> > sites do not check for failure, because -failure never occurs-.
> >
> > The MM devs want to have visibility of these allocations - they may
> > not like them, but having __GFP_NOFAIL means it's trivial to audit
> > all the allocations that use these semantics.  IOWs, __GFP_NOFAIL
> > was created with an explicit guarantee that it -will not fail- for
> > normal allocation contexts so it could replace all the open-coded
> > will-not-fail allocation loops..
> >
> > Given this guarantee, we recently removed these historic allocation
> > wrapper loops from XFS, and replaced them with __GFP_NOFAIL at the
> > allocation call sites. There's nearly a hundred memory allocation
> > locations in XFS that are tagged with __GFP_NOFAIL.
> >
> > If we're now going to have the "will not fail" guarantee taken away
> > from __GFP_NOFAIL, then we cannot use __GFP_NOFAIL in XFS. Nor can
> > it be used anywhere else that a "will not fail" guarantee it
> > required.
> >
> > Put simply: __GFP_NOFAIL will be rendered completely useless if it
> > can fail due to external scoped memory allocation contexts.  This
> > will force us to revert all __GFP_NOFAIL allocations back to
> > open-coded will-not-fail loops.
> >
> > This is not a step forwards for anyone.
> 
> Hello Dave,
> 
> I've noticed that XFS has increasingly replaced kmem_alloc() with
> __GFP_NOFAIL. For example, in kernel 4.19.y, there are 0 instances of
> __GFP_NOFAIL under fs/xfs, but in kernel 6.1.y, there are 41
> occurrences. In kmem_alloc(), there's an explicit
> memalloc_retry_wait() to throttle the allocator under heavy memory
> pressure, which aligns with your filesystem design. However, using
> __GFP_NOFAIL removes this throttling mechanism, potentially causing
> issues when the system is under heavy memory load. I'm concerned that
> this shift might not be a beneficial trend.

AIUI, the memory allocation looping has back-offs already built in
to it when memory reserves are exhausted and/or reclaim is
congested.

e.g:

get_page_from_freelist()
  (zone below watermark)
  node_reclaim()
    __node_reclaim()
      shrink_node()
        reclaim_throttle()

And the call to recalim_throttle() will do the equivalent of
memalloc_retry_wait() (a 2ms sleep).

> We have been using XFS for our big data servers for years, and it has
> consistently performed well with older kernels like 4.19.y. However,
> after upgrading all our servers from 4.19.y to 6.1.y over the past two
> years, we have frequently encountered livelock issues caused by memory
> exhaustion. To mitigate this, we've had to limit the RSS of
> applications, which isn't an ideal solution and represents a worrying
> trend.

If userspace uses all of memory all the time, then the best the
kernel can do is slowly limp along. Preventing userspace from
overcommitting memory to the point of OOM is the only way to avoid
these "userspace space wants more memory than the machine physically
has" sorts of issues. i.e. this is not a problem that the kernel
code can solve short of randomly killing userspace applications...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

