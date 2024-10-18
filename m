Return-Path: <linux-kernel+bounces-372181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A59A455B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE881C23C19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA284204012;
	Fri, 18 Oct 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="WYT6y7qJ"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300042022D5;
	Fri, 18 Oct 2024 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274375; cv=none; b=hhRug5zqIOSfdSzno1jmWXbVcqsP4l22WsuWzmX4JOcG4a0/YMYbUiyY8M03bmafF2muMElh7IT0DCL+ih+k39m1x4XCnV+zLVL7Ca6lrM4o6rXF5eMPfcPjbVg0YpzVO6Sg2ZfJfsZktAt1ZfzDB7Cl+mEGAUZfRLv+rTkoXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274375; c=relaxed/simple;
	bh=r9j7j25oHOBzRT6hWz/hG0iwhrLF5+gF3nWX+EiB48U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsyIfsM7f5RwRva7ZDowt5AUuIi0HqyHQXh5Tjpmbi4pX45alT8eW4GGGCzR2ELwdQeD6AWqOlKq6+0jHEeCVrNAYyPXS3VrQxTAGgT5S4VNw95btJq7GZ/G5elskvYCm8YJ9Bd/E6y4319ebSZhMGBx3X8lXdEOdnwjBmdqJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=WYT6y7qJ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=7Oqc+vBn3lxQjaQqKVwQ/VCImNzHkqEeRjsxwIHFjLI=; b=WYT6y7qJGSHlTmNy
	AytG0Gr8oiYLp9cR9LyclAGUyiVVMu5dGTTXG4tLqqMRMwQdYu5rzhT6hsQppzWcWZJfBpsc8FcUo
	bfHTWPQEa/21Pe3+iig6n0ospcZTpbYmVlbzEHMF7nrldCGXNTXu6DL3cq8ARRpHpDnXOgAhMWYkk
	1IJc4GWelZL/fLc9p5TCBwshfZT/Lb5SOJy+sgQA1rIaX2FtP1dJvTWoHwjbcYB7/bd0Jj0AEriTh
	mhqN1Egy7LOVb4KIVi4IsYRHUd5ENld3wUgdRE7k/DG78/JVV3ZeNGx59/kEZYMhF6AjQF6j03hn9
	/H9A68vclspJcqAnxg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t1rG0-00CBue-1B;
	Fri, 18 Oct 2024 17:59:24 +0000
Date: Fri, 18 Oct 2024 17:59:24 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <ZxKh_AWoRLgafKyC@gallifrey>
References: <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
 <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
 <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
 <ZxKQux4I8We0Ax3-@gallifrey>
 <aaf25389-e0c3-408a-ae05-a166c1720bf8@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aaf25389-e0c3-408a-ae05-a166c1720bf8@kernel.dk>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:59:10 up 163 days,  5:13,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jens Axboe (axboe@kernel.dk) wrote:
> On 10/18/24 10:45 AM, Dr. David Alan Gilbert wrote:
> > * Borislav Petkov (bp@alien8.de) wrote:
> >> On Fri, Oct 18, 2024 at 07:30:15AM -0600, Jens Axboe wrote:
> >>> At least on mine, the BIOS has an option that says something like "L3
> >>> cache as numa domain", which is on and why there's 32 nodes on that box.
> >>> It's pretty handy for testing since there's a crap ton of CPUs, as it
> >>> makes affinity handling easier.
> >>
> >> Right, so two boxes I tested with this:
> >>
> >> * 2 socket, a bit different microcode:
> >>
> >> [   22.947525] smp: Brought up 32 nodes, 512 CPUs
> >>
> >> * your CPU, one socket:
> >>
> >> [   26.830137] smp: Brought up 16 nodes, 255 CPUs
> > 
> > (Probably unrelated but...)
> > What happened to number 256 ?
> 
> Quick guess, maybe iommu was off, will cap it to 255. IIRC...

Ah OK.

Dave

> -- 
> Jens Axboe
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

