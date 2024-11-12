Return-Path: <linux-kernel+bounces-406328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 196D79C5D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50B41F227FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7EE20695E;
	Tue, 12 Nov 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8vmZfBS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65F2071E1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429501; cv=none; b=QZPu4yJaMiXAm1mVXxrFNPH4ZdWETow9p7KFJkpRIo5REsD/OiWxgqyCnC177dXfxdr7jp8gM7UmNB29fK2himTtrvCcz/kml4qoCE4b4D0BRo3l/3HxyAIpQST6bxssiTuMZH4FY1+8HxeJo0MVX8y0FidGNrR+wjV0Mf+BppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429501; c=relaxed/simple;
	bh=C6t37ZWzJ1PTsG088vbFrL23viz4/3RJrYbMt85bpp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHPrOOS1S2ESQxzg7r1J4iRLiW+UewzrDiWOUxL54XCWnCGGBBq3zr7z3Y5X0fXAXFMSPX4cyyYPeY+GXJTEPhB/xFTXhfIxvGvhzWM/mkHEUGuYfgm/9pVeJCw2bmtEA8PA2m5Wo61Q0MNjWSX1UT43O0Fol4/GFFX3Bmekreo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8vmZfBS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731429498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBEamZbjXMqh8LYkIi+wp0uylZlZEO5P3Ysc8nav4wo=;
	b=Q8vmZfBSoZVVSrGTs1ncxewNhPU7NKTYwBcdnIoJwvyK/Lyb0O32+vcXwBtb8n91wsUn8Y
	ExTDwwP/xrp8dIQhiCKd1Nu+zD2iPQN/Qpg7sb0OT5ql+4GnBb83oAuEzToBHZKtUFJpZO
	nbQMIXWWibrwjmWRqy4rRSBFaI+emSA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-iz8JA2gkPaqnHlgTCguJOg-1; Tue,
 12 Nov 2024 11:38:13 -0500
X-MC-Unique: iz8JA2gkPaqnHlgTCguJOg-1
X-Mimecast-MFC-AGG-ID: iz8JA2gkPaqnHlgTCguJOg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2A11195395A;
	Tue, 12 Nov 2024 16:38:10 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0FBC30000DF;
	Tue, 12 Nov 2024 16:38:08 +0000 (UTC)
Date: Tue, 12 Nov 2024 11:39:41 -0500
From: Brian Foster <bfoster@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <ZzOEzX0RddGeMUPc@bfoster>
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <ZzIfwmGkbHwaSMIn@infradead.org>
 <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
 <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
 <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
 <ZzLkF-oW2epzSEbP@infradead.org>
 <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 12, 2024 at 08:14:28AM -0700, Jens Axboe wrote:
> On 11/11/24 10:13 PM, Christoph Hellwig wrote:
> > On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
> >> Here's the slightly cleaned up version, this is the one I ran testing
> >> with.
> > 
> > Looks reasonable to me, but you probably get better reviews on the
> > fstests lists.
> 
> I'll send it out once this patchset is a bit closer to integration,
> there's the usual chicken and egg situation with it. For now, it's quite
> handy for my testing, found a few issues with this version. So thanks
> for the suggestion, sure beats writing more of your own test cases :-)
> 

fsx support is probably a good idea as well. It's similar in idea to
fsstress, but bashes the same file with mixed operations and includes
data integrity validation checks as well. It's pretty useful for
uncovering subtle corner case issues or bad interactions..

Brian

> -- 
> Jens Axboe
> 


