Return-Path: <linux-kernel+bounces-550462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3AFA55FDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DC11894639
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F083418EFED;
	Fri,  7 Mar 2025 05:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRO6U2ay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922538DEC;
	Fri,  7 Mar 2025 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741324752; cv=none; b=LA2XWY2gIuOM4adAzloinKT2iz/kqSUETmO2hVDUf5421DwiQKXFATs83vhHoIIHKU4Pi7kl4riLT1LT93obwLT4IOzGBAFXer0xvqvX/NWIqa8aDRsyNN/Yx9voZki2tUGEWDSWdcJnmLtUBUyLK9Fq2z17auOkS0TZBmBa/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741324752; c=relaxed/simple;
	bh=oTV3msnFDyQULua9BT07OYqshaGZ2Ju8fMOiNnd0ekM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AedLSd3eT+bpdA+HvGhEb3EgwBuny1ocpMO1zHWqz7Se23ndKEp1xrgHZXyADZhaW8KLxTDs2+Z5PlW6hC+yPMwnsVbCmUIwiq05XmL54RU1iF6wkBrc6dL8Ke9yRojNfM2yDTTQU51K25u33L2fE42zqBc8p6IBqbVV0TasRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRO6U2ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B29CC4CED1;
	Fri,  7 Mar 2025 05:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741324751;
	bh=oTV3msnFDyQULua9BT07OYqshaGZ2Ju8fMOiNnd0ekM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRO6U2ayNV1PvmsoXfH3qlGyJNy3tNNv5QnLxM+w9cQaz58h5bmw8Hdd54in6qYmg
	 HwAmSS65rhBwIJOKk42dKk+ay+KxeWpzU9DGKHrZJ+Vg9gdjEipTqNXK5GtFM+dirc
	 QWlokc2/cQDRWZDZc9PBpvq5UPOJa6QAbRLbjozfYvkUrgxWioEo33ESHYIvSTjF6R
	 sRpyH1l69gamht5yKRWiRPl1iVYrFblAW8kxdLLvcBAxs/xkSZF+h+TCdKki52GuaA
	 pd2Tas7zMA7heIq2hfD1cu9m83hATtxncdASDmJDjoTpogYj1rAL+vSDpqn8nxJTcd
	 3yXTa+7ENiO/w==
Date: Thu, 6 Mar 2025 21:19:09 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf report: Fix memory leaks in the hierarchy mode
Message-ID: <Z8qBzTvjQmwldwcD@google.com>
References: <20250306075147.195435-1-namhyung@kernel.org>
 <20250306075147.195435-2-namhyung@kernel.org>
 <CAP-5=fW=Gs2ATy8DhcZFjGP5tcEemoZp9q=voFV8HRisY9ki7w@mail.gmail.com>
 <Z8nWNBKuYc0x-sN8@google.com>
 <Z8pTaVN1uEqjrgRb@google.com>
 <CAP-5=fV1UCF3D9rrNzMbH8CNP-UAAS13TAjm_0-3rZSLD_+PdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV1UCF3D9rrNzMbH8CNP-UAAS13TAjm_0-3rZSLD_+PdQ@mail.gmail.com>

On Thu, Mar 06, 2025 at 08:50:46PM -0800, Ian Rogers wrote:
> On Thu, Mar 6, 2025 at 6:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Mar 06, 2025 at 09:07:00AM -0800, Namhyung Kim wrote:
> > > Hi Ian,
> > >
> > > On Thu, Mar 06, 2025 at 08:55:05AM -0800, Ian Rogers wrote:
> > > > On Wed, Mar 5, 2025 at 11:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > Ian told me that there are many memory leaks in the hierarchy mode.  I
> > > > > can easily reproduce it with the follwing command.
> > > > >
> > > > >   $ make DEBUG=1 EXTRA_CFLAGS=-fsanitize=leak
> > > > >
> > > > >   $ perf record --latency -g -- ./perf test -w thloop
> > > > >
> > > > >   $ perf report -H --stdio
> > > > >   ...
> > > > >   Indirect leak of 168 byte(s) in 21 object(s) allocated from:
> > > > >       #0 0x7f3414c16c65 in malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:75
> > > > >       #1 0x55ed3602346e in map__get util/map.h:189
> > > > >       #2 0x55ed36024cc4 in hist_entry__init util/hist.c:476
> > > > >       #3 0x55ed36025208 in hist_entry__new util/hist.c:588
> > > > >       #4 0x55ed36027c05 in hierarchy_insert_entry util/hist.c:1587
> > > > >       #5 0x55ed36027e2e in hists__hierarchy_insert_entry util/hist.c:1638
> > > > >       #6 0x55ed36027fa4 in hists__collapse_insert_entry util/hist.c:1685
> > > > >       #7 0x55ed360283e8 in hists__collapse_resort util/hist.c:1776
> > > > >       #8 0x55ed35de0323 in report__collapse_hists /home/namhyung/project/linux/tools/perf/builtin-report.c:735
> > > > >       #9 0x55ed35de15b4 in __cmd_report /home/namhyung/project/linux/tools/perf/builtin-report.c:1119
> > > > >       #10 0x55ed35de43dc in cmd_report /home/namhyung/project/linux/tools/perf/builtin-report.c:1867
> > > > >       #11 0x55ed35e66767 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:351
> > > > >       #12 0x55ed35e66a0e in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:404
> > > > >       #13 0x55ed35e66b67 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:448
> > > > >       #14 0x55ed35e66eb0 in main /home/namhyung/project/linux/tools/perf/perf.c:556
> > > > >       #15 0x7f340ac33d67 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
> > > > >   ...
> > > > >
> > > > >   $ perf report -H --stdio 2>&1 | grep -c '^Indirect leak'
> > > > >   93
> > > > >
> > > > > I found that hist_entry__delete() missed to release child entries in the
> > > > > hierarchy tree (hroot_{in,out}).  It needs to iterate the child entries
> > > > > and call hist_entry__delete() recursively.
> > > > >
> > > > > After this change:
> > > > >
> > > > >   $ perf report -H --stdio 2>&1 | grep -c '^Indirect leak'
> > > > >   0
> > > > >
> > > > > Reported-by: Ian Rogers <irogers@google.com>
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  tools/perf/util/hist.c | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > > > index fbf131aeae7ffe9b..bbc6a299b5106c3b 100644
> > > > > --- a/tools/perf/util/hist.c
> > > > > +++ b/tools/perf/util/hist.c
> > > > > @@ -1385,6 +1385,15 @@ void hist_entry__delete(struct hist_entry *he)
> > > > >  {
> > > > >         struct hist_entry_ops *ops = he->ops;
> > > > >
> > > > > +       while (!RB_EMPTY_ROOT(&he->hroot_out.rb_root)) {
> > > > > +               struct rb_node *node = rb_first(&he->hroot_out.rb_root);
> > > > > +               struct hist_entry *child = rb_entry(node, struct hist_entry, rb_node);
> > > > > +
> > > > > +               rb_erase_init(node, &he->hroot_out.rb_root);
> > > > > +
> > > > > +               hist_entry__delete(child);
> > > > > +       }
> > > >
> > > > Thanks for the fix! A nit, iterating the rbtree of N nodes and calling
> > > > erase on the first entry, an O(log N) operation, means this is a O(N *
> > > > log N). rbtree.h has rbtree_postorder_for_each_entry_safe:
> > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/include/linux/rbtree.h?h=perf-tools-next#n81
> > > > ```
> > > >  * rbtree_postorder_for_each_entry_safe - iterate in post-order over rb_root of
> > > >  * given type allowing the backing memory of @pos to be invalidated
> > > > ```
> > > > which is O(N). I think this code would be better something like:
> > > > ```
> > > > struct hist_entry *pos, *tmp;
> > > > rbtree_postorder_for_each_entry_safe(pos, tmp, he->hroot_out.rb_root, rb_node)
> > > >         hist_entry__delete(pos);
> > > > ```
> > >
> > > Thanks for your review!  I was wondering if there's something like this.
> > > Will update with that.
> >
> > I found that the following comments:
> >
> >  * Note, however, that it cannot handle other modifications that re-order the
> >  * rbtree it is iterating over. This includes calling rb_erase() on @pos, as
> >  * rb_erase() may rebalance the tree, causing us to miss some nodes.
> >
> > So I cannot use this here.
> 
> I thought the tree is no longer in use after the hist_entry__delete,
> so you don't need to maintain the child/parent pointers as everything
> is going to get freed. Here is what I think is a similar use:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_stat.c#n51

Oh, I see.  So it should not call rb_erase().  Will check again.

Thanks,
Namhyung


