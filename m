Return-Path: <linux-kernel+bounces-321547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7C971BE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A276D28178A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8033A1BB6A3;
	Mon,  9 Sep 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ri11GvoN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB41B9B45
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890169; cv=none; b=igKuQH3fw5LY9OxdMj5ZpLexxt+WQcjdGBPd70s0HC0ioB0M0nm+vVPfDkUFByvgjJjaIX7PNzNhE8CtslTOT6IcF2xxcG0JTaC7axOQjnqRpyqZ6k+Y9Aj/fWtb39+wKlrliqHlGzZPsSyYBEXqB/FylPh7O83+3vus7dciCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890169; c=relaxed/simple;
	bh=XzoRWEoEudmxaucEcd0tMqRYCLm5ezK/+O+cSJW9Nqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puUfUUWnro3O8PQkO+kGU8k4P4618FHW5Pa5ogQEwf+vwFEy1GRIkEdA53Bmg5SJalMknXchaBm8SskQdZdRpzGsKRf9eXi1vdze9sfWYYlvuJMRPkjm56Dqc/4BYxxtkhB7WlRFC3knC2bdTquGducDT1cVVmBNjprmkl929xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ri11GvoN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725890167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYhtjmyZJWBN50A78LZx2Nv8438j+9S4h7dYlc79Xpg=;
	b=Ri11GvoNxCI7fVd2O3uZlTZjAGc8QOdOHIjDI5qHWxH3NuGvjATOhec1fFsQxJAdbyqM6W
	u4cnV/AD3Bbq+uMGn7F9CLWbgKrpZGBBJykvzBMdLISk7eyBo0MvELWDU8PlKiONPhAOUO
	+KDdp3p7T2ETkuBnhFF4xs3t8vz4iKc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-XmCTAre3OZqQxY8bSgQ_yQ-1; Mon,
 09 Sep 2024 09:56:06 -0400
X-MC-Unique: XmCTAre3OZqQxY8bSgQ_yQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6B8F1955D45;
	Mon,  9 Sep 2024 13:56:03 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.107])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 590FB30001A1;
	Mon,  9 Sep 2024 13:55:58 +0000 (UTC)
Date: Mon, 9 Sep 2024 15:55:55 +0200
From: Philipp Rudo <prudo@redhat.com>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Ard Biesheuvel" <ardb@kernel.org>, "Pingfan Liu" <piliu@redhat.com>,
 "Jan Hendrik Farr" <kernel@jfarr.cc>, "Lennart Poettering"
 <mzxreary@0pointer.de>, "Eric Biederman" <ebiederm@xmission.com>, "Baoquan
 He" <bhe@redhat.com>, "Dave Young" <dyoung@redhat.com>, "Mark Rutland"
 <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <20240909155555.257e13eb@rotkaeppchen>
In-Reply-To: <D400W37FR01S.CLFIKA98YWX7@kernel.org>
References: <20240819145417.23367-1-piliu@redhat.com>
	<CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
	<20240906125438.1e54c5f6@rotkaeppchen>
	<D400L4YN4K7K.264IDL4O8374F@kernel.org>
	<D400OHF2ODNK.3JF7DJ87Q4BYI@kernel.org>
	<D400W37FR01S.CLFIKA98YWX7@kernel.org>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Jarkko,

On Sat, 07 Sep 2024 14:41:38 +0300
"Jarkko Sakkinen" <jarkko@kernel.org> wrote:

> On Sat Sep 7, 2024 at 2:31 PM EEST, Jarkko Sakkinen wrote:
> > On Sat Sep 7, 2024 at 2:27 PM EEST, Jarkko Sakkinen wrote:  
> > > On Fri Sep 6, 2024 at 1:54 PM EEST, Philipp Rudo wrote:  
> > > > Let me throw an other wild idea in the ring. Instead of implementing
> > > > a EFI runtime we could also include a eBPF version of the stub into the
> > > > images. kexec could then extract the eBPF program and let it run just
> > > > like any other eBPF program with all the pros (and cons) that come with
> > > > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > > > simply kexec any OS installer. On the other hand it would make it
> > > > easier to port UKIs et al. to non-EFI systems. What do you think?  
> > >
> > > BPF would have some guarantees that are favorable such as programs
> > > always end, even faulty ones. It always has implicit "ExitBootServices".
> > >
> > > Just a remark.  
> >
> > Some days ago I was thinking could some of the kernel functionality be
> > eBPF at least like in formal theory because most of it is amortized,
> > i.e. does a fixed chunk of work. Not going into that rabbit hole but
> > I really like this idea and could be good experimentation ground for
> > such innovation.  
> 
> E.g. let's imagine there would imaginary eBPF-TPM driver framework.
> 
> How I would go doing that would be to take the existing TPM driver
> functionality and provide extra functions and resources available for
> subsystem specific BPF environment, and have the orhestration code as
> eBPF. I pretty much concluded that there is a chance that such could
> work out.
> 
> Not something in my immediate table but it is still really interesting
> idea, as instead of using language to separate "safe" and unsafe"
> regions you would use "VM" environments to create the walls. In the
> end of the day that would also great venture for Rust in kernel, i.e.
> compile that BPF from Rust.
> 
> Sorry going of the hook the comment triggered me ;-)

I'm glad you like the idea :-)

Sounds like an interesting idea you are having there!

Thanks
Philipp


