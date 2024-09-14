Return-Path: <linux-kernel+bounces-329531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA85D979295
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 19:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F3D1C21AD0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45941D130C;
	Sat, 14 Sep 2024 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CL5II/rp";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CL5II/rp"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74B1D094B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333838; cv=none; b=NCT1YYORkt3wR3giuwegt39i9qqKpURJNV8ERKpbtCDE8nVxiz8hFokA9d/3iBQ9cjnUxd8GNZ33elbPPzT2dg5+TT3HoO6DvGcXqcOPrgFinAees4OFJq6Ls+GqaIOv1C8vvnnrmQCOiZDkLBr+xvfuDlfe4ikzYg6O9x6mQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333838; c=relaxed/simple;
	bh=qzXab2xEBWrdgOGSa/rRgdbOQX+UsmLfxOHNi08U/Ys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5szQ/mcBmQrJjMBnDiP1Pp/N1BgcWQYojnIkxGJS6y5RqwCgJCeT/rtghzVlrLfwT2duLaPCGUIISYsOdd+o08bRqUU9k9qtdV7n+PaQ1euYH9pwFSYli4TJoRU7wVUuxh+ze+YhiV2/+swI3GzDwByEalIInC+LpqrK5koyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=CL5II/rp; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=CL5II/rp; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726333835;
	bh=qzXab2xEBWrdgOGSa/rRgdbOQX+UsmLfxOHNi08U/Ys=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=CL5II/rp8untIeYsdjJGTJDtpt1uZbXpI+uAHIFfZqjtxtmFrW+UXEIe5BQwp+ijl
	 9Um+tSLFPJ5lDGhRel/UvHTzqAyYjAzltEwOz4i/y0lKok+9UMcV8bvWK00AEZJqsF
	 HsFgFEABRcFf1kbcFsEg1vIijR8ijLY2ZQKRzYyE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 848901281086;
	Sat, 14 Sep 2024 13:10:35 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id i0ms-_NzGopZ; Sat, 14 Sep 2024 13:10:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726333835;
	bh=qzXab2xEBWrdgOGSa/rRgdbOQX+UsmLfxOHNi08U/Ys=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=CL5II/rp8untIeYsdjJGTJDtpt1uZbXpI+uAHIFfZqjtxtmFrW+UXEIe5BQwp+ijl
	 9Um+tSLFPJ5lDGhRel/UvHTzqAyYjAzltEwOz4i/y0lKok+9UMcV8bvWK00AEZJqsF
	 HsFgFEABRcFf1kbcFsEg1vIijR8ijLY2ZQKRzYyE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7A78D128022D;
	Sat, 14 Sep 2024 13:10:34 -0400 (EDT)
Message-ID: <529689b46df6a99a4a284192c461d16f7bfbb9f0.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC 3/3] tsm: Add TVM Measurement Sample Code
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Lukas Wunner
 <lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao
 <qinkun@google.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Date: Sat, 14 Sep 2024 13:10:33 -0400
In-Reply-To: <796ebe16-86a4-4109-9b80-91a238f975f0@intel.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
	 <20240907-tsm-rtmr-v1-3-12fc4d43d4e7@intel.com>
	 <86e6659bc8dd135491dc34bdb247caf05d8d2ad8.camel@HansenPartnership.com>
	 <796ebe16-86a4-4109-9b80-91a238f975f0@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-09-14 at 11:36 -0500, Xing, Cedric wrote:
> On 9/12/2024 7:28 AM, James Bottomley wrote:
> > On Sat, 2024-09-07 at 23:56 -0500, Cedric Xing wrote:
> > > This sample kernel module demonstrates how to make MRs accessible
> > > to
> > > user mode
> > > through TSM.
> > > 
> > > Once loaded, this module registers a virtual measurement provider
> > > with the TSM
> > > core and will result in the directory tree below.
> > > 
> > > /sys/kernel/tsm/
> > > └── measurement-example
> > >      ├── config_mr
> > >      ├── full_report
> > >      ├── report_digest
> > >      ├── rtmr0
> > >      │   ├── append_event
> > >      │   ├── digest
> > >      │   ├── event_log
> > >      │   └── hash_algo
> > >      ├── rtmr1
> > >      │   ├── append_event
> > >      │   ├── digest
> > >      │   ├── event_log
> > >      │   └── hash_algo
> > >      ├── static_mr
> > >      └── user_data
> > 
> > I'm not sure this is the best structure to apply to logs with
> > multiple banks (hash algorithms).  There needs to be a way to get
> > the same registers measurement for each bank, but the log should
> > sit above that (appending should extend all active banks)
> > 
> > How about
> > 
> > /sys/kernel/tsm/
> > └──<measurement type>
> >     ├──reg0
> >     │   ├── <log format>
> >     │   │   ├── append_event
> >     │   │   └── event_log
> >     │   ├── <hash algo>
> >     │  ...  └── digest
> >     ...
> > 
> > That way it supports multiple log formats (would be the job of the
> > log extender to ensure compatibility) and multiple banks.
> > 
> I have considered this before. But I'm not sure how to
> (define/describe criteria to) match an MR with its log format.

This is already defined for every existing log format ... why would you
have to define it again?

>  Also, MRs are arch dependent and may also vary from gen to gen. I'm
> afraid this might bring in more chaos than order.

I think I understand this. All measurement registers are simply
equivalent to PCRs in terms of the mathematical definition of how they
extend.  Exactly what measurements go into a PCR and how they are
logged is defined in various standards.  The TCG ones are fairly fixed
now, but if Intel wants to keep redefining the way its measurements
work, the logical thing to do is tie this to a version number and make
measuring the version the first log entry so the tools know how to
differentiate.

James


