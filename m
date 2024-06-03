Return-Path: <linux-kernel+bounces-199685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042EC8D8ADA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B161C23829
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF013B2B2;
	Mon,  3 Jun 2024 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+DPStpo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A9136E17
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446403; cv=none; b=WjsMP6o48qUwA/KnC07n3EDDAO3RzGxir3MKI6H4LSTtYVtcp5FPEpOxDvzZLrAyf1DJGGjscCKL1XuSWdgY754ZCSUrNYEgRjlF6d5DsseoLB5e+IbVZLf52r5nj/TLqmY8TausZ4aPTY1PvDsVvIo/MDcYw2pUIEAQsktXxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446403; c=relaxed/simple;
	bh=6KED2x1S/AF4bVjAfBoJ8Vqth9qeQwkpN4AMgVXZgRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO86mYckTg9O26HMQr1pyvb+vUS+17VVRbRJaDuDXokWyWAXI6AphFJRqTGtuLas4Z+JMwHyHsjZWifpZ4zFmO7QlWFTDxMWmpPnrnPz14XukUaIMBgNz7DpEjCqOgP6tO4D/JHZahFDNs/rhPlwXRpNjrkT8XiYL18/BUZX87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+DPStpo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717446401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+S0TmYnUWJsVE+qAIQ7Ikzh2XCDPu61uY5s9c+MZA8=;
	b=a+DPStpouAuafEt3rHPtqOeCIbfD1EWFskEvo69d48jC0C2ZI+vPYpslT50+DaWxEoQiSN
	OOjEbGczmvz9lBZk82rrWpKFKgZpyk6zUZyErD6b+s3eRAGkPyxzb/OleWsK5gOUhJEqbN
	SisMvy36lJMo88eEIwLVIWvMdDm6dco=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-MR4QUJ_zMY-4zB9-Lr-mTA-1; Mon, 03 Jun 2024 16:26:39 -0400
X-MC-Unique: MR4QUJ_zMY-4zB9-Lr-mTA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d1bdefedb9so673432b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 13:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717446399; x=1718051199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+S0TmYnUWJsVE+qAIQ7Ikzh2XCDPu61uY5s9c+MZA8=;
        b=Oi7ZO237e5SG9HIK6gRUNeHporqxBU4GCYO/+Owz7rqb6d1yC1BGcZcGMwNtpOC4e2
         HTvOztnKMMcdS6QTfSyaDx4717NSOPx5oKlWttR2fgTcKnqodYs0dGvgYSQ0d6Hb4knB
         NlFxS7JBU8wGE2LZ+c0T83RhWeTwYzyBYVLsttgz6hbnvyxdhc+PIbHLLkmMM+33KWZf
         yIV6fXIat3iSpVy9MaVOg8LcpUU1tVcMnST8h1MVqTNIMTtYMya/TNGrkP2kRDH73yQx
         5aLeUZj2L3tGluOsx2m0bzUdoTH1T9hSQSELQrMLBAv7ExnKx9uqToKSsp+YyfXG4+zc
         N2aw==
X-Forwarded-Encrypted: i=1; AJvYcCVLlaNbwIKSNxX27TaRICVPlgLlxxdaEfT+bsUg01nPkVS/kqaK/xvbvCj11S1LmoBiT61htG+nqsRgBfDVSYTP5N3CFp6XXoc2hDJi
X-Gm-Message-State: AOJu0Yxw2sV+R0RSbKpqFtGs5lk57MW40pP6C2NFoR8wcTvMBV0b3KOR
	EpxVzIX07eRfQO/w9MgtgY2Nd1r7VOysf/+/1Rb6H5zB8PhnAdV78Mn4Zp29eKlU2a6pnnm98VL
	iZkLP4+QTv0aYqJC3lrKmUKIrnZRvhs1B+kfrKYw6gXKsj8bGNx3XFCehH4NOdw==
X-Received: by 2002:a9d:7e97:0:b0:6f1:20c0:9389 with SMTP id 46e09a7af769-6f911fc46b4mr11408294a34.3.1717446398188;
        Mon, 03 Jun 2024 13:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmQKyITcnJ2LSx16OQfyq5/LqJdCt26jP1ib/TsOV9aEhnRvFLpzfPL7T2Sz/Pb31GmODPOQ==
X-Received: by 2002:a9d:7e97:0:b0:6f1:20c0:9389 with SMTP id 46e09a7af769-6f911fc46b4mr11408251a34.3.1717446397492;
        Mon, 03 Jun 2024 13:26:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44015cda8fcsm6933851cf.95.2024.06.03.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 13:26:36 -0700 (PDT)
Date: Mon, 3 Jun 2024 16:26:34 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>,
	kernel test robot <oliver.sang@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Subject: Re: [linus:master] [mm] efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
Message-ID: <Zl4m-sAhZknHOHdb@x1n>
References: <202405311534.86cd4043-lkp@intel.com>
 <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com>
 <ZlpcRnuZUEYJJ0JA@x1n>
 <CAHbLzkrRw-xf819gYJwRQ=-u971LQYnB2FNJMkN=s6u-pJ4Z8g@mail.gmail.com>
 <CAHbLzkoB+oFTxtVYpeXQvko2q9HUVzUYrr83S6M6PUmXDQpkag@mail.gmail.com>
 <0edfcfed-e8c4-4c46-bbce-528c07084792@redhat.com>
 <Zl3cakfiRsPQDb8q@x1n>
 <8da12503-839d-459f-a2fa-4abd6d21935d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8da12503-839d-459f-a2fa-4abd6d21935d@redhat.com>

On Mon, Jun 03, 2024 at 05:42:44PM +0200, David Hildenbrand wrote:
> On 03.06.24 17:08, Peter Xu wrote:
> > On Sat, Jun 01, 2024 at 08:22:21AM +0200, David Hildenbrand wrote:
> > > On 01.06.24 02:59, Yang Shi wrote:
> > > > On Fri, May 31, 2024 at 5:01 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > > 
> > > > > On Fri, May 31, 2024 at 4:25 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > > 
> > > > > > On Fri, May 31, 2024 at 07:46:41PM +0200, David Hildenbrand wrote:
> > > > > > > try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()
> > > > > > > 
> > > > > > > Is called (mm-unstable) from:
> > > > > > > 
> > > > > > > (1) gup_fast function, here IRQs are disable
> > > > > > > (2) gup_hugepte(), possibly problematic
> > > > > > > (3) memfd_pin_folios(), possibly problematic
> > > > > > > (4) __get_user_pages(), likely problematic
> > > > > > > 
> > > > > > > (1) should be fine.
> > > > > > > 
> > > > > > > (2) is possibly problematic on the !fast path. If so, due to commit
> > > > > > >       a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? CCing Peter.
> > > > > > > 
> > > > > > > (3) is possibly wrong. CCing Vivek.
> > > > > > > 
> > > > > > > (4) is what we hit here
> > > > > > 
> > > > > > I guess it was overlooked because try_grab_folio() didn't have any comment
> > > > > > or implication on RCU or IRQ internal helpers being used, hence a bit
> > > > > > confusing.  E.g. it has different context requirement on try_grab_page(),
> > > > > > even though they look like sister functions.  It might be helpful to have a
> > > > > > better name, something like try_grab_folio_rcu() in this case.
> > > > > > 
> > > > > > Btw, none of above cases (2-4) have real bug, but we're looking at some way
> > > > > > to avoid triggering the sanity check, am I right?  I hope besides the host
> > > > > > splash I didn't overlook any other side effect this issue would cause, and
> > > > > > the splash IIUC should so far be benign, as either gup slow (2,4) or the
> > > > > > newly added memfd_pin_folios() (3) look like to have the refcount stablized
> > > > > > anyway.
> > > > > > 
> > > > > > Yang's patch in the other email looks sane to me, just that then we'll add
> > > > > > quite some code just to avoid this sanity check in paths 2-4 which seems
> > > > > > like an slight overkill.
> > > > > > 
> > > > > > One thing I'm thinking is whether folio_ref_try_add_rcu() can get rid of
> > > > > > its RCU limitation. It boils down to whether we can use atomic_add_unless()
> > > > > > on TINY_RCU / UP setup too?  I mean, we do plenty of similar things
> > > > > > (get_page_unless_zero, etc.) in generic code and I don't understand why
> > > > > > here we need to treat folio_ref_try_add_rcu() specially.
> > > > > > 
> > > > > > IOW, the assertions here we added:
> > > > > > 
> > > > > >           VM_BUG_ON(!in_atomic() && !irqs_disabled());
> > > > > > 
> > > > > > Is because we need atomicity of below sequences:
> > > > > > 
> > > > > >           VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
> > > > > >           folio_ref_add(folio, count);
> > > > > > 
> > > > > > But atomic ops avoids it.
> > > > > 
> > > > > Yeah, I didn't think of why atomic can't do it either. But is it
> > > > > written in this way because we want to catch the refcount == 0 case
> > > > > since it means a severe bug? Did we miss something?
> > > > 
> > > > Thought more about it and disassembled the code. IIUC, this is an
> > > > optimization for non-SMP kernel. When in rcu critical section or irq
> > > > is disabled, we just need an atomic add instruction.
> > > > folio_ref_add_unless() would yield more instructions, including branch
> > > > instruction. But I'm wondering how useful it would be nowadays. Is it
> > > > really worth the complexity? AFAIK, for example, ARM64 has not
> > > > supported non-SMP kernel for years.
> > > > 
> > > > My patch actually replaced all folio_ref_add_unless() to
> > > > folio_ref_add() for slow paths, so it is supposed to run faster, but
> > > > we are already in slow path, it may be not measurable at all. So
> > > > having more simple and readable code may outweigh the potential slight
> > > > performance gain in this case?
> > > 
> > > Yes, we don't want to use atomic RMW that return values where we can use
> > > atomic RMW that don't return values. The former is slower and implies a
> > > memory barrier, that can be optimized out on some arcitectures (arm64 IIRC)
> > > 
> > > We should clean that up here, and make it clearer that the old function is
> > > only for grabbing a folio if it can be freed concurrently -- GUP-fast.
> > 
> > Note again that this only affects TINY_RCU, which mostly implies
> > !PREEMPTION and UP.  It's a matter of whether we prefer adding these bunch
> > of code to optimize that.
> > 
> > Also we didn't yet measure that in a real workload and see how that
> > "unless" plays when buried in other paths, but then we'll need a special
> > kernel build first, and again I'm not sure whether it'll be worthwhile.
> 
> try_get_folio() is all about grabbing a folio that might get freed
> concurrently. That's why it calls folio_ref_try_add_rcu() and does
> complicated stuff.

IMHO we can define it.. e.g. try_get_page() wasn't defined as so.

If we want to be crystal clear on that and if we think that's what we want,
again I would suggest we rename it differently from try_get_page() to avoid
future misuses, then add documents. We may want to also even assert the
rcu/irq implications in try_get_folio() at entrance, then that'll be
detected even without TINY_RCU config.

> 
> On !CONFIG_TINY_RCU, it performs a folio_ref_add_unless(). That's
> essentially a atomic_add_unless(), which in the worst case ends up being a
> cmpxchg loop.
> 
> 
> Stating that we should be using try_get_folio() in paths where we are sure
> the folio refcount is not 0 is the same as using folio_try_get() where
> folio_get() would be sufficient.
> 
> The VM_BUG_ON in folio_ref_try_add_rcu() really tells us here that we are
> using a function in the wrong context, although in our case, it is safe to
> use (there is now BUG). Which is true, because we know we have a folio
> reference and can simply use a simple folio_ref_add().
> 
> Again, just like we have folio_get() and folio_try_get(), we should
> distinguish in GUP whether we are adding more reference to a folio (and
> effectively do what folio_get() would), or whether we are actually grabbing
> a folio that could be freed concurrently (what folio_try_get() would do).

Yes we can.  Again, IMHO it's a matter of whether it will worth it.

Note that even with SMP and even if we keep this code, the
atomic_add_unless only affects gup slow on THP only, and even with that
overhead it is much faster than before when that path was introduced.. and
per my previous experience we don't care too much there, really.

So it's literally only three paths that are relevant here on the "unless"
overhead:

  - gup slow on THP (I just added it; used to be even slower..)

  - vivik's new path

  - hugepd (which may be gone for good in a few months..)
  
IMHO none of them has perf concerns.  The real perf concern paths is
gup-fast when pgtable entry existed, but that must use atomic_add_unless()
anyway.  Even gup-slow !thp case won't regress as that uses try_get_page().

So again, IMHO the easist way to fix this WARN is we drop the TINY_RCU bit,
if nobody worries on UP perf.

I don't have a strong opinion, if any of us really worry about above three
use cases on "unless" overhead, and think it worthwhile to add the code to
support it, I won't object. But to me it's adding pain with no real benefit
we could ever measure, and adding complexity to backport too since we'll
need a fix for as old as 6.6.

Thanks,

-- 
Peter Xu


