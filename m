Return-Path: <linux-kernel+bounces-354333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B911C993BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE801C20AB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8BBE4E;
	Tue,  8 Oct 2024 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9id5lYj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05AA94A;
	Tue,  8 Oct 2024 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728348698; cv=none; b=CJqeRJ2SOrsWSGeldslW5afJORpV5a4QLkCVMeFUJYNLUrGmRgp9+2JDn+OiRENH5M0ruvlGUkDk0XHID+LQPyTe2kFJBhD7hNk1Y3pKylMVUQRSWz2dBDCIXXNd1RCwIl4nSidBvBmG8WwHdLHNxmtZ4V+mOpa2UPiVvmYHZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728348698; c=relaxed/simple;
	bh=9/RtIWdpgDZviXbTfuEqrXyHXgxiDx1Tc7Y5xLmLFcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxmZ6Yvi4UVNwbzLTgrjdeAyYWVBHl+ukfawPtZ7ZGiaJ6Lo/6BldFaknMSTWiMpptC2O+rkMX859QcCjx1u1RloPHLucR44+JABCX7Qutj8x0pDjNTarFwv+Aq0539edUu1nIQkoLB60yKv3g+b0EEyANG5C3t+mj9NJXGOP0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9id5lYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB72C4CEC6;
	Tue,  8 Oct 2024 00:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728348698;
	bh=9/RtIWdpgDZviXbTfuEqrXyHXgxiDx1Tc7Y5xLmLFcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9id5lYjK92n5sZ/VTqlQbGQctviZIqwCK1nGi3B5hj2XxbSzzg9Jjk5VBhM08L63
	 yGG34m6wGabcqhIO/0rs1SI8NDY5MD54ArcRXrgKPOrCWbcbZiSoPW9EPMNsRm9eZK
	 LaBkOwQ1o5ydbMLsJdPuLIpOrJkAGrfp2622cW0s6iZWDp/yDa+0AllA953/b1/uLY
	 D9mB14Bf3pPjSl9HdjhodKzpwvDt68SZdCRhY8qVX5FGi+6w1Aqrg3VjqHYm+7+G7D
	 tY6uqbDGbtZV6ysFwr/tOPnKPRavrXwnfg5DDyk2BjEiaH/lLj2qFXdlnD1v0umAYS
	 L9EhlrvSjjiJg==
Date: Mon, 7 Oct 2024 17:51:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Aleksei Vetrov <vvvvvv@google.com>
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, vbabka@suse.cz, willy@infradead.org,
	hannes@cmpxchg.org, anna-maria@linutronix.de, tglx@linutronix.de,
	arnd@arndb.de, llvm@lists.linux.dev
Subject: Re: [PATCH] mm/vmstat: Fix -Wenum-enum-conversion warning in vmstat.h
Message-ID: <20241008005136.GA241099@thelio-3990X>
References: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>
 <ZwRA9SOcOjjLJcpi@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwRA9SOcOjjLJcpi@google.com>

Hi Aleksei,

On Mon, Oct 07, 2024 at 08:13:41PM +0000, Aleksei Vetrov wrote:
> Hi Shivamurthy,
> 
> On Fri, Jun 21, 2024 at 01:16:04PM +0200, Shivamurthy Shastri wrote:
> > A W=1 build with -Wenum-enum-conversion enabled, results in the
> > following build warning due to an arithmetic operation between different
> > enumeration types 'enum node_stat_item' and 'enum lru_list':
> > 
> >   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
> >     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
> >         |                               ~~~~~~~~~~~ ^ ~~~
> > 
> > Address this by casting lru to the proper type.
> > 
> > Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
> > Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > ---
> >  include/linux/vmstat.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > index 735eae6e272c..72ecd46fd0c4 100644
> > --- a/include/linux/vmstat.h
> > +++ b/include/linux/vmstat.h
> > @@ -511,7 +511,7 @@ static inline const char *node_stat_name(enum node_stat_item item)
> >  
> >  static inline const char *lru_list_name(enum lru_list lru)
> >  {
> > -	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
> > +	return node_stat_name(NR_LRU_BASE + (enum node_stat_item)lru) + 3; // skip "nr_"
> >  }
> >  
> >  static inline const char *writeback_stat_name(enum writeback_stat_item item)
> > -- 
> > 2.34.1
> > 
> 
> We have encountered the same problem after trying to update Clang to the
> latest version and this is a blocker because we use W=1 to compile the
> kernel.
> 
> Do you plan to address review comments about casting to int instead of
> enum node_stat_item? Or I can submit another patch myself that addresses
> it.

For what it's worth, I never really saw Matthew's comment around what
value does this warning provide addressed. I was the one who originally
moved it into W=1 at the request of Arnd because he felt that instances
of this warning could be bugs and they should be audited.  However, I
have not seen many instances of this warning pop up in new code through
0day build reports and the ones that I have seen seem to be intentional,
as they are using enums like integral values, such as here. If that is
just going to result in a bunch of patches like this adding unnecessary
casts, I think it would just be better to consider disabling this
warning altogether or at the very least, moving it to W=2 (which is for
warnings that are noisy but might contain bugs), since more people are
using W=1 as their normal build configuration nowadays.

Cheers,
Nathan

