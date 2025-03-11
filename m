Return-Path: <linux-kernel+bounces-555466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2C5A5B809
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE81892B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E167E1EB1B4;
	Tue, 11 Mar 2025 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="g2d7+pZ1"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0781BDCF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741668156; cv=none; b=bcv7Fj18LwjRw/q8PUKvjn9FVPNSEKMGQbanhiQ4U3a4eNDv7bNE8h61/UBbsQ9fiMgO5mETBTl5AMvhiYtqD1mAu7UFcV8ROdfBRAr2YZtF4HkVBJnD4NGJUZ1J/GeEB94GXMpU6bRj/NXXQgFcm9g+RKoWpa+QdDRU6yjiTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741668156; c=relaxed/simple;
	bh=TRlMg4YWyTJAWRRZBZ2c48v7xyNdjLFPJZVojWqhdbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPj9frh2iBLEvBaw2tEwh/JDbMMFok1RhjXfewbxuMV8RMqkAy8p04AT7MKVlT6CDqPtscgPV0+vxlAl5W8kww2lltqx/9VEPSdlc0fdvwHwv5QgVxZi6Ec7vypLdfyuwLZ3aHq53N02XB536y5Kztz/MBqSObCzO6BbeWBZmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=g2d7+pZ1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=vb6xeetaL8jP62Fry7Hfn6d0GboWfLUR6VyxlKaqI8Q=; b=g2d7+pZ1VmZrNZkRjeq0NuGJBA
	MAQmPZVxWfckDrRpYxwBeelhbrGoDYKtlepcTM3IIg0w11L9XM3ZVSX7P+pVUn7MZtq5Fz12fKkbR
	XcVwz087Z35gqb7VzaRdKC6ELLNZBKpn6PfU1FyoGRtSsHmEgxEQ4dH+mangma7s2ZQRVf9ctJ9uv
	Q/2DzyhNJjkE4SCR28PVCWAH2Oo/Q1kDqJhN6PcdKRDz9sEcLhQNdLYpd0QYiMzcSxwk5XHdV8Zfo
	ckK/1npZ4pOUjrLuzjprI2zekCCJ015zSN0cJQRm5lJctFZP5rJjecrjfw+Vmzg3sc5UBp9QkTLBB
	HrobSmbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1trrRn-00000003YSF-1X1M;
	Tue, 11 Mar 2025 04:42:31 +0000
Date: Tue, 11 Mar 2025 04:42:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amit <amitchoudhary0523@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching use-after-free easily in linux kernel.
Message-ID: <20250311044231.GO2023217@ZenIV>
References: <CAFf+5zj=KmBG0Avqy6cq9qtpGKR3HnYNc6rK6y8B_78Ajt4RhQ@mail.gmail.com>
 <20250311003554.GN2023217@ZenIV>
 <CAFf+5zjGKMSCYNZvOzaCNRFKHjWe2a6TKmmKqg7Fe-TLQW07yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFf+5zjGKMSCYNZvOzaCNRFKHjWe2a6TKmmKqg7Fe-TLQW07yA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 11, 2025 at 08:46:36AM +0530, Amit wrote:
> On Tue, Mar 11, 2025, 6:05 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > On Mon, Mar 10, 2025 at 01:24:54PM +0530, Amit wrote:
> > > Hi,
> > >
> > > We can catch use-after-free easily if we do the following:
> > >
> > > kfree(x);
> > > (x) = NULL;
> > >
> > > Now, if someone uses 'x' again then the kernel will crash and we will
> > know where
> > > the use-after-free is happening and then we can fix it.
> >
> > That assumes that no pointer is ever stored in more than one place.
> > Which is very clearly false.
> >
> 
> 
> I will do some experiments and then I will reply if I find something.
> 
> I will introduce a global macro and then change all kfree() to this macro
> name using cscope probably.
> 
> Then I will compile the kernel and run the new kernel and see if some crash
> is happening or not.

What would that test, exactly?  And why would that be any more useful than
adding global variables named wank and magic and replacing every kfree(p) with
((magic = wank++),kfree(p))?  That also would not introduce any crashes...

