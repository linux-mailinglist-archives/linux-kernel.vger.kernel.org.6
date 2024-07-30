Return-Path: <linux-kernel+bounces-267419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA41F941139
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3989F2823B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DC51991D2;
	Tue, 30 Jul 2024 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aclbfGar"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA1918D4D7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340468; cv=none; b=K9kZn8m4AgvOVK5yJTq/zE3tfwKPXYb+eM4tuU+RRxG3eNwXQxIXFDzFU5cnHypRWLYXj+lxe4jnQqWhjFLAxEKWZfjjMUD1eOgOrbp3ydRTYWPyYS8kTsjdX1CgP6DiicHMRXFy56AWIAB7GQ0I8AKEu9UCef+cN0aHhPp5NnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340468; c=relaxed/simple;
	bh=W/s6nDXLW9d0EML2Z3CPr+n5bAY1YIeECW1FXd1a/Fk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=etY37PTA7Zr4L2ZNj7dCk4H7VhhME2BLNLvMXh5DYi6YHGCMmW2DzK6voQKJ7eOfQ1Vsl6aYkgDrG5PXaHcUHNS/5MVeyC8F7LOC8wfkXdpjGdT0kpoQUcxLTkq/69qtSyGoLhsSf7DIj1SRJeDBeU0sfoiKzUnu+hzmBloe57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aclbfGar; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722340465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oc8dGmgbI4v5yEHmaPEBetOUPJ7JbACJa4DEgTVu/ik=;
	b=aclbfGarDH7P7lKJC/H6gfBS6g9zKlhSm8ctKgiRUWG+P+xPXsKIFXOp7Ea30twAHESId5
	apnTmOggis1giG8wF8n76/StVjGZzMYrhQB1442xDdBfwbJfz0m7AjQwIi/q+976Udgt38
	8niBfu7ee9he+u4ydK/8k7kAwrwgxR4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-j5PXgc0oMTG87G2xrEWoBg-1; Tue,
 30 Jul 2024 07:54:17 -0400
X-MC-Unique: j5PXgc0oMTG87G2xrEWoBg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CF071955D4B;
	Tue, 30 Jul 2024 11:54:15 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DB90195605F;
	Tue, 30 Jul 2024 11:54:14 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 64E0D30C051D; Tue, 30 Jul 2024 11:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 6087F3E267;
	Tue, 30 Jul 2024 13:54:13 +0200 (CEST)
Date: Tue, 30 Jul 2024 13:54:13 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the device-mapper
 tree
In-Reply-To: <20240730200737.67bb4d4f@canb.auug.org.au>
Message-ID: <aa4b337-e1dd-4091-ab2-6b41de205fd1@redhat.com>
References: <20240709185733.4aac356a@canb.auug.org.au> <49ab648e-3c89-d4d-f2f7-3c1e2aa2cab@redhat.com> <20240710082824.30c8161d@canb.auug.org.au> <622b892-d792-382c-46f8-fe5cfdba4df1@redhat.com> <20240730200737.67bb4d4f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Tue, 30 Jul 2024, Stephen Rothwell wrote:

> Hi all,
> 
> On Wed, 10 Jul 2024 17:48:39 +0200 (CEST) Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > On Wed, 10 Jul 2024, Stephen Rothwell wrote:
> > 
> > > On Tue, 9 Jul 2024 11:56:27 +0200 (CEST) Mikulas Patocka <mpatocka@redhat.com> wrote:  
> > > >
> > > > On Tue, 9 Jul 2024, Stephen Rothwell wrote:
> > > >   
> > > > > After merging the device-mapper tree, today's linux-next build (htmldocs)
> > > > > produced this warning:
> > > > > 
> > > > > Documentation/admin-guide/device-mapper/dm-crypt.rst:168: ERROR: Unexpected indentation.
> > > > > 
> > > > > Introduced by commit
> > > > > 
> > > > >   04a1020ad350 ("dm-crypt: limit the size of encryption requests")  
> > > > 
> > > > How should it be fixed? Delete the '-' character? Or some other change?  
> > > 
> > > Looking a few lines above shows indented paragraphs without the '-'
> > > which seems to work.  
> > 
> > I hopefully fixed that.
> 
> I am sill seeing this warning.

Hi

So, send a patch for it.

I don't know whats wrong with that documentation file.

Mikulas


