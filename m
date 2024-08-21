Return-Path: <linux-kernel+bounces-294843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A9D95934B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BAD1B22257
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C50815C141;
	Wed, 21 Aug 2024 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bFRTC3sf"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BD158860
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724210401; cv=none; b=Ekh+3rvK6WfZKDqvLTwH4i01LMCyyj/j36RQbx8ZyJaWK2giGKw7aDksTtwxSCFT/kvZ53HfckXS2VsriT7+c+kYC+SqXhXO6t9faTv+L884tTDqtff25bsgxKKE1sEtoNwJWnkhp4QVdir7fDrpFBsz81abY1jgw41yPlnlZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724210401; c=relaxed/simple;
	bh=SlkfwSNe4hCwwmQ4L1TRUZdTyXG4Xrajh4qOFZls7NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBESusV4uB4aemXaswXzISC7nyc3t5tQjbEPbS2HrhalDFtpoAtzHuDnDd5Fl/vZvE5KI3p5Gs9e9TfYLebwUOhGB2Pr8l0OI/yiNWlons1cL6HdudeoVRdJ8qQVxJayyBxpOG9EqDG0WaClJehzHoibNEyy909P9q9qA9VmWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bFRTC3sf; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Aug 2024 23:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724210398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y49YwtJg+awpjenHVE6pR6nolkvsuR6eRg+b8rI77lU=;
	b=bFRTC3sfAD94EuTTdbpStdBH1uV7phqz4czPxgmTzwrOZdcrIXE3OgopDSlpB25mPHbu4Q
	V168rgJEsWR4ZrSQAwQPwAwu2mo/14NfFTHRWKihG3k3PD5ytQXaF8u7KzJg1ubsHZOFkm
	fBB+CLyfN9nOBMTKwZSwZJlfyf3lSSg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] bcachefs: Add journal v2 entry nr value check
Message-ID: <bij226lxay4fr3bpxpu6kcgdynxrq4rnjhxvpsjgzukqjf7w4t@4ntovo66d32t>
References: <zdrkmfo2ln2t7e3oh3mz3yr2xs67qm3ea4wfe4fnv6zw4fk4pd@k5peuzfz5ods>
 <20240821031000.2087573-1-lizhi.xu@windriver.com>
 <vr4n6n25sq5dtcr3njl44ev2dxrawpz6s6xwv6cpjfm33uqmay@uhieqhcxeuns>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vr4n6n25sq5dtcr3njl44ev2dxrawpz6s6xwv6cpjfm33uqmay@uhieqhcxeuns>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 20, 2024 at 11:16:55PM GMT, Kent Overstreet wrote:
> On Wed, Aug 21, 2024 at 11:10:00AM GMT, Lizhi Xu wrote:
> > On Tue, 20 Aug 2024 23:00:05 -0400, Kent Overstreet wrote:
> > > > When the nr value of a signle entry or their sum overflows, it will
> > > > cause the value of ja->nr to be incorrect, this will result in the
> > > > allocated memory to ja->buckets being too small, leading to out of
> > > > bounds access in bch2_dev_journal_init.
> > > > 
> > > > Reported-by: syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com
> > > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > > > ---
> > > >  fs/bcachefs/journal_sb.c | 16 +++++++++++++++-
> > > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/bcachefs/journal_sb.c b/fs/bcachefs/journal_sb.c
> > > > index db80e506e3ab..230ed99130e4 100644
> > > > --- a/fs/bcachefs/journal_sb.c
> > > > +++ b/fs/bcachefs/journal_sb.c
> > > > @@ -107,6 +107,7 @@ static int bch2_sb_journal_v2_validate(struct bch_sb *sb, struct bch_sb_field *f
> > > >  	unsigned nr;
> > > >  	unsigned i;
> > > >  	struct u64_range *b;
> > > > +	u64 total_nr = 0, entry_nr;
> > > >  
> > > >  	nr = bch2_sb_field_journal_v2_nr_entries(journal);
> > > >  	if (!nr)
> > > > @@ -117,8 +118,21 @@ static int bch2_sb_journal_v2_validate(struct bch_sb *sb, struct bch_sb_field *f
> > > >  		return -BCH_ERR_ENOMEM_sb_journal_v2_validate;
> > > >  
> > > >  	for (i = 0; i < nr; i++) {
> > > > +		entry_nr = le64_to_cpu(journal->d[i].nr);
> > > > +		if (entry_nr > UINT_MAX) {
> > > > +			prt_printf(err, "Journal v2 entry d[%u] nr %llu overflow\n",
> > > > +				i, entry_nr);
> > > > +			goto err;
> > > > +		}
> > > 
> > > This check is unnecessary; we know the sum can't overflow a u64 because
> > > we're also checking that the entries are nonoverlapping.
> > You didn't read my previous email carefully.
> > In this issue, journal->d[0] is 7, journal->d[1] is 18446744073709551615,
> > so the sum of their u64 type values will definitely overflow.
> 
> It doesn't matter. We're already checking that the entries are
> nonoverlapping, and within the range of [1, nbuckets), so total_nr can't
> overflow nbuckets, much less an s64 (not that that matters).

The check that's missing is that start + nr doesn't overflow, when we
convert to u64_ranges.

