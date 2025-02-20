Return-Path: <linux-kernel+bounces-522916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907FEA3D010
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C203B297B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0252C1DEFD9;
	Thu, 20 Feb 2025 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="by1e4sDT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127C1D416B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021886; cv=none; b=SfPGUhX5kDsKoCCYVNrcacwinbXzULMkajIG5mRfQO7GLXX5d3FO1Lj0MZsL4NfOJnf2hFYl3SnyZOM/bt8SCMONhXnw088rYCalrXU1yLKCpH5Cn0ZUmX9Thkxeyc2YErUtCtSZ3j05Fb/yoTxgwI0jBMn0qbVbtWSDxeVvA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021886; c=relaxed/simple;
	bh=hrH3gSSJua0XF6ylKhTxk9/7/HmWaV/IGstgRSn8BRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSQrC3eQEBocMrHXCy5zYbNPLCfH2wgoEqvGWhhPvYgUQN0wdkY9cKDbaDGx0CfwpM215cZq0hHQLAhURA+H4e2jfvKBKRtUWOMaKVA5V9MQWUUes90oeRKJEQ3/LSZLLWPK0+s5JJGRsXBZ1BtHoLRZ0bRWkDgFwT2+Hy+INHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=by1e4sDT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740021883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YwMMjZVnNw2vA2fx0hn8CT1DbaKYBifmxuPgJ8avEu8=;
	b=by1e4sDTFIwylUAlCaa8twr99Z7BAvB7yVezLw4zxRqlhCFBcQgBjUEDkO11LCxdjV98rO
	gIgKgqLPIaEZy1vC+12NdWIF8DlcWuvjlZ77lCkscuJD4Xxvl3uIMe8rJ2QEUhe1oI4xsh
	xVZXs4EPMC/m/k5vy5UkI+9mF2NA8zU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-Lz2G54FlNGWqzKqq0g1jtQ-1; Wed,
 19 Feb 2025 22:24:39 -0500
X-MC-Unique: Lz2G54FlNGWqzKqq0g1jtQ-1
X-Mimecast-MFC-AGG-ID: Lz2G54FlNGWqzKqq0g1jtQ_1740021878
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C06619373D9;
	Thu, 20 Feb 2025 03:24:37 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19B0E1800359;
	Thu, 20 Feb 2025 03:24:34 +0000 (UTC)
Date: Thu, 20 Feb 2025 11:24:30 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm, swap: use percpu cluster as allocation fast path
Message-ID: <Z7agbvvnshLwt0k7@MiWiFi-R3L-srv>
References: <20250214175709.76029-1-ryncsn@gmail.com>
 <20250214175709.76029-6-ryncsn@gmail.com>
 <Z7WOCvQq3xi9wxnt@MiWiFi-R3L-srv>
 <CAMgjq7C0Yg164SHJcP6wDC0od-xRuBMxLsJJwB0oWavpgsr8tg@mail.gmail.com>
 <Z7W4p0p/Qkke2LTp@MiWiFi-R3L-srv>
 <CAMgjq7AixL=Jn_c5jQFWWJt5+gPz0O+1rxtTWhzOmo2ef3dWhQ@mail.gmail.com>
 <Z7aU7wEx9jKo3TaT@MiWiFi-R3L-srv>
 <CAMgjq7DoV=ZdHeREeMq1=hKzD_O40NkfHCym1Wo9m=J=cBnUvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7DoV=ZdHeREeMq1=hKzD_O40NkfHCym1Wo9m=J=cBnUvw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 02/20/25 at 10:48am, Kairui Song wrote:
> On Thu, Feb 20, 2025 at 10:35 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 02/19/25 at 07:12pm, Kairui Song wrote:
> > >
> > > > n reality it may be very difficult to achieve the 'each 2M space has been consumed for each order',
> > >
> > > Very true, but notice for order >= 1, slot cache never worked before.
> > > And for order == 0, it's very likely that a cluster will have more
> > > than 64 slots usable. The test result I posted should be a good
> > > example, and device is very full during the test, and performance is
> > > basically identical to before. My only concern was about the device
> >
> > My worry is the global percpu cluster may impact performance among
> > multiple swap devices. Before, per si percpu cluster will cache the
> > valid offset in one cluster for each order. For multiple swap devices,
> > this consumes a little bit more percpu memory. While the new global
> > percpu cluster could be updated to a different swap device easily only
> > of one order is available, then the whole array is invalid. That looks a
> > little drastic cmpared with before.
> 
> Ah, now I got what you mean. That's seems could be a problem indeed.
> 
> I think I can change the
> 
> +struct percpu_swap_cluster {
> +       struct swap_info_struct *si;
> 
> to
> 
> +struct percpu_swap_cluster {
> +       struct swap_info_struct *si[SWAP_NR_ORDERS];
> 
> Or embed the swp type in the offset, this way each order won't affect
> each other.  How do you think?

Yes, this looks much better. You may need store both si and offset, the
above demonstrated struct percpu_swap_cluster lacks offset which seems
not good.

> 
> Previously high order allocation will bypass slot cache so allocation
> could happen on different same priority devices too. So the behaviour
> that each order using different device should be acceptable.
> 
> >
> > Yeah, the example you shown looks good. Wonder how many swap devices are
> > simulated in your example.
> >
> > > rotating, as slot cache never worked for order >= 1, so the device
> > > rotates was very frequently. But still seems no one really cared about
> > > it, mthp swapout is a new thing and the previous rotation rule seems
> > > even more confusing than this new idea.
> >
> > I never contact a real product environment with multiple tier and
> > many swap devices. In reality, with my shallow knowledge, usually only
> > one swap device is deployed. If that's true in most of time, the old
> > code or new code is fine, otherwise, seems we may need consider the
> > impact.
> 


