Return-Path: <linux-kernel+bounces-406638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74389C6325
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9993B308F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2667F218958;
	Tue, 12 Nov 2024 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNo0OggE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1B20B218
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440291; cv=none; b=Te263hJRuncCTA+6LvoM1rzUZBuxiWn3x04Q3zLCxSo9spgourg9xsPHDMwI4qVho62d9VlzC7HCiXkMvMHZjeZHJKTr+Aaii2YxfM/qTvzSprIrMScwYx6jOt1KYhwgCAiTZhvp/R2fvvoGnfY7AvhjYF/0OSLHjYIrjKt04pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440291; c=relaxed/simple;
	bh=uPGX03XvvV+XtqpiDWYPrHffFCLZCQeL5FDfGiGpSGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjBz4HQYtFKemkTGwF8OSJllcYBPbzNNriCjsxagNfyQkgzcR0FdB3XnUkKMlm5iVTqE0ngZo69ivVo1vcZTwzcXB2nsZTESoNfT0LTbTbBTb+SxUsrBPJUoNc+o62ODmbM9Aw170X8DliW8EQIUeUgLGwbiPzLy/lcIB+676os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNo0OggE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731440288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+pEWGwDV42qZ605Ox/qRGT5wCc1jBMka21/Df9UKjYs=;
	b=iNo0OggErkjfubfYXySEPDyT9frVyA7oAJ8/P5UqN/eehPZOP+5hcBrqo03CaQ3RBE3Iov
	svqHFqJjRHgeyay/DqxkrasKivF7sf9mkdfHa2U0nPdBaLRT1IaA8ri4OtZd6+2Pn/3lfw
	7iuW9/fqAhkRDKFceEdxOTFbFki8evo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-sQXeUOb5NqWfBZxRfASG6Q-1; Tue,
 12 Nov 2024 14:38:04 -0500
X-MC-Unique: sQXeUOb5NqWfBZxRfASG6Q-1
X-Mimecast-MFC-AGG-ID: sQXeUOb5NqWfBZxRfASG6Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64D541955F2C;
	Tue, 12 Nov 2024 19:38:02 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E80D19560A3;
	Tue, 12 Nov 2024 19:37:59 +0000 (UTC)
Date: Tue, 12 Nov 2024 14:39:32 -0500
From: Brian Foster <bfoster@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <ZzOu9G3whgonO8Ae@bfoster>
References: <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
 <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
 <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
 <ZzLkF-oW2epzSEbP@infradead.org>
 <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk>
 <ZzOEzX0RddGeMUPc@bfoster>
 <7a4ef71f-905e-4f2a-b3d2-8fd939c5a865@kernel.dk>
 <3f378e51-87e7-499e-a9fb-4810ca760d2b@kernel.dk>
 <ZzOiC5-tCNiJylSx@bfoster>
 <b1dcd133-471f-40da-ab75-d78ea9a8fa4c@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1dcd133-471f-40da-ab75-d78ea9a8fa4c@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Nov 12, 2024 at 12:08:45PM -0700, Jens Axboe wrote:
> On 11/12/24 11:44 AM, Brian Foster wrote:
> > On Tue, Nov 12, 2024 at 10:19:02AM -0700, Jens Axboe wrote:
> >> On 11/12/24 10:06 AM, Jens Axboe wrote:
> >>> On 11/12/24 9:39 AM, Brian Foster wrote:
> >>>> On Tue, Nov 12, 2024 at 08:14:28AM -0700, Jens Axboe wrote:
> >>>>> On 11/11/24 10:13 PM, Christoph Hellwig wrote:
> >>>>>> On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
> >>>>>>> Here's the slightly cleaned up version, this is the one I ran testing
> >>>>>>> with.
> >>>>>>
> >>>>>> Looks reasonable to me, but you probably get better reviews on the
> >>>>>> fstests lists.
> >>>>>
> >>>>> I'll send it out once this patchset is a bit closer to integration,
> >>>>> there's the usual chicken and egg situation with it. For now, it's quite
> >>>>> handy for my testing, found a few issues with this version. So thanks
> >>>>> for the suggestion, sure beats writing more of your own test cases :-)
> >>>>>
> >>>>
> >>>> fsx support is probably a good idea as well. It's similar in idea to
> >>>> fsstress, but bashes the same file with mixed operations and includes
> >>>> data integrity validation checks as well. It's pretty useful for
> >>>> uncovering subtle corner case issues or bad interactions..
> >>>
> >>> Indeed, I did that too. Re-running xfstests right now with that too.
> >>
> >> Here's what I'm running right now, fwiw. It adds RWF_UNCACHED support
> >> for both the sync read/write and io_uring paths.
> >>
> > 
> > Nice, thanks. Looks reasonable to me at first glance. A few randomish
> > comments inlined below.
> > 
> > BTW, I should have also mentioned that fsx is also useful for longer
> > soak testing. I.e., fstests will provide a decent amount of coverage as
> > is via the various preexisting tests, but I'll occasionally run fsx
> > directly and let it run overnight or something to get the op count at
> > least up in the 100 millions or so to have a little more confidence
> > there isn't some rare/subtle bug lurking. That might be helpful with
> > something like this. JFYI.
> 
> Good suggestion, I can leave it running overnight here as well. Since
> I'm not super familiar with it, what would be a good set of parameters
> to run it with?
> 

Most things are on by default, so I'd probably just go with that. -p is
useful to get occasional status output on how many operations have
completed and you could consider increasing the max file size with -l,
but usually I don't use more than a few MB or so if I increase it at
all.

Random other thought: I also wonder if uncached I/O should be an
exclusive mode more similar to like how O_DIRECT or AIO is implemented.
But I dunno, maybe it doesn't matter that much (or maybe others will
have opinions on the fstests list).

Brian

> >>  #define READ 0
> >>  #define WRITE 1
> >> -#define fsxread(a,b,c,d)	fsx_rw(READ, a,b,c,d)
> >> -#define fsxwrite(a,b,c,d)	fsx_rw(WRITE, a,b,c,d)
> >> +#define fsxread(a,b,c,d,f)	fsx_rw(READ, a,b,c,d,f)
> >> +#define fsxwrite(a,b,c,d,f)	fsx_rw(WRITE, a,b,c,d,f)
> >>  
> > 
> > My pattern recognition brain wants to see an 'e' here. ;)
> 
> This is a "check if reviewer has actually looked at it" check ;-)
> 
> >> @@ -266,7 +273,9 @@ prterr(const char *prefix)
> >>  
> >>  static const char *op_names[] = {
> >>  	[OP_READ] = "read",
> >> +	[OP_READ_UNCACHED] = "read_uncached",
> >>  	[OP_WRITE] = "write",
> >> +	[OP_WRITE_UNCACHED] = "write_uncached",
> >>  	[OP_MAPREAD] = "mapread",
> >>  	[OP_MAPWRITE] = "mapwrite",
> >>  	[OP_TRUNCATE] = "truncate",
> >> @@ -393,12 +402,14 @@ logdump(void)
> >>  				prt("\t******WWWW");
> >>  			break;
> >>  		case OP_READ:
> >> +		case OP_READ_UNCACHED:
> >>  			prt("READ     0x%x thru 0x%x\t(0x%x bytes)",
> >>  			    lp->args[0], lp->args[0] + lp->args[1] - 1,
> >>  			    lp->args[1]);
> >>  			if (overlap)
> >>  				prt("\t***RRRR***");
> >>  			break;
> >> +		case OP_WRITE_UNCACHED:
> >>  		case OP_WRITE:
> >>  			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
> >>  			    lp->args[0], lp->args[0] + lp->args[1] - 1,
> >> @@ -784,9 +795,8 @@ doflush(unsigned offset, unsigned size)
> >>  }
> >>  
> >>  void
> >> -doread(unsigned offset, unsigned size)
> >> +__doread(unsigned offset, unsigned size, int flags)
> >>  {
> >> -	off_t ret;
> >>  	unsigned iret;
> >>  
> >>  	offset -= offset % readbdy;
> >> @@ -818,23 +828,39 @@ doread(unsigned offset, unsigned size)
> >>  			(monitorend == -1 || offset <= monitorend))))))
> >>  		prt("%lld read\t0x%x thru\t0x%x\t(0x%x bytes)\n", testcalls,
> >>  		    offset, offset + size - 1, size);
> >> -	ret = lseek(fd, (off_t)offset, SEEK_SET);
> >> -	if (ret == (off_t)-1) {
> >> -		prterr("doread: lseek");
> >> -		report_failure(140);
> >> -	}
> >> -	iret = fsxread(fd, temp_buf, size, offset);
> >> +	iret = fsxread(fd, temp_buf, size, offset, flags);
> >>  	if (iret != size) {
> >> -		if (iret == -1)
> >> -			prterr("doread: read");
> >> -		else
> >> +		if (iret == -1) {
> >> +			if (errno == EOPNOTSUPP && flags & RWF_UNCACHED) {
> >> +				rwf_uncached = 1;
> > 
> > I assume you meant rwf_uncached = 0 here?
> 
> Indeed, good catch. Haven't tested this on a kernel without RWF_UNCACHED
> yet...
> 
> > If so, check out test_fallocate() and friends to see how various
> > operations are tested for support before the test starts. Following that
> > might clean things up a bit.
> 
> Sure, I can do something like that instead. fsx looks pretty old school
> in its design, was not expecting a static (and single) fd. But since we
> have that, we can do the probe and check. Just a basic read would be
> enough, with RWF_UNCACHED set.
> 
> > Also it's useful to have a CLI option to enable/disable individual
> > features. That tends to be helpful to narrow things down when it does
> > happen to explode and you want to narrow down the cause.
> 
> I can add a -U for "do not use uncached".
> 
> -- 
> Jens Axboe
> 


