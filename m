Return-Path: <linux-kernel+bounces-514443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23516A35718
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC68E18920B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B2200BA8;
	Fri, 14 Feb 2025 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQburBFk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D117E;
	Fri, 14 Feb 2025 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514638; cv=none; b=QdDNMiR2KXp3mPhbJEY/H4rokDx2EgOu4eQFa/4o4+gLEph4/hkkdcU6As4pDi31pmwcj1E2EO9eeK3w8nL31XcPOpdc/bgxp5HCU7MPL7C/HclM7kQ9vt6dTqYFP9LATu9yzVCE405jdl1O+czHpufvNKGg0T13gJJXkNVDZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514638; c=relaxed/simple;
	bh=sc9N/uNaRNgOeJWUsanP4id4E/Fnl5devE1ySb7Fy94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiZ+HKyHNo+ua+wxNJYTHQYeYlQCDFRD5rPVuPbv+DZ2q6bMiDIlunmjhad6a1Me5aMVCN8NBFDyCBU+pTDIBSCyLkwNy0T3KjvthqnI1sVv9ps+MOrYohK4Qh29Ml1ZziIkJV1W0i6HNd9aEmG4ftvRc1cdfZCGPwY+270QhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQburBFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D05BC4CED1;
	Fri, 14 Feb 2025 06:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739514637;
	bh=sc9N/uNaRNgOeJWUsanP4id4E/Fnl5devE1ySb7Fy94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dQburBFkFGaghvvgWMBt5at99Dy86yJe20KM+alTJlaayPItw6j6f+VQpiUa07wvy
	 GIpVCigG9iF4VO1nXP3OBRDd1FVCKmu82en1brOdeKF8Zmdc6rL53vvPhYK+GguHoH
	 NYHqHD1eSUweGLuCvoPcTaNdViziAB1duGW+sCKaltC/RXhlpYFFJ6cB8bH03rLrJw
	 IsvbduPfBslf9X3VJhvO1frO57gi2iT9jdnKGSyLhO5dRKOom7r5PrVzGXEscgNpu7
	 sRd3o8DFjX0uOzP4h8atC0loEF9k92ZiTXcniRvnkE3d3Bj8BrgSqyGaDye53uFG4M
	 UXnqejim3XIeg==
Date: Fri, 14 Feb 2025 07:30:27 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: remove an obscure logic from
 kernel-doc
Message-ID: <20250214073027.28aedc63@foz.lan>
In-Reply-To: <45cec6dc-2071-4d5a-a0bd-8ad895b19000@infradead.org>
References: <fd3b28dec36ba1668325d6770d4c4754414337fc.1739340170.git.mchehab+huawei@kernel.org>
	<87wmdt6bv5.fsf@trenco.lwn.net>
	<20250214032457.6444ee93@foz.lan>
	<45cec6dc-2071-4d5a-a0bd-8ad895b19000@infradead.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 13 Feb 2025 18:38:47 -0800
Randy Dunlap <rdunlap@infradead.org> escreveu:

> Hi--
> 
> On 2/13/25 6:24 PM, Mauro Carvalho Chehab wrote:
> > Em Thu, 13 Feb 2025 09:35:58 -0700
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >   
> >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >>  
> >>> Kernel-doc has an obscure logic that uses an external file
> >>> to map files via a .tmp_filelist.txt file stored at the current
> >>> directory. The rationale for such code predates git time,
> >>> as it was added on Kernel v2.4.5.5, with the following description:
> >>>
> >>> 	# 26/05/2001 -         Support for separate source and object trees.
> >>> 	#              Return error code.
> >>> 	#              Keith Owens <kaos@ocs.com.au>
> >>>
> >>> from commit 396a6123577d ("v2.4.5.4 -> v2.4.5.5") at the historic
> >>> tree:
> >>> 	https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/
> >>>
> >>> Support for separate source and object trees is now done on a different
> >>> way via make O=<object>.
> >>>
> >>> There's no logic to create such file, so it sounds to me that this is
> >>> just dead code.
> >>>
> >>> So, drop it.
> >>>
> >>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >>> ---
> >>>  scripts/kernel-doc | 19 +------------------
> >>>  1 file changed, 1 insertion(+), 18 deletions(-)    
> >>
> >> Weird ... I went and looked, and can't find anything that ever created
> >> that tmp_filelist.txt file; I wonder if this code ever did anything?  
> > 
> > I wonder the same ;-) Anyway, better to remove this now, as, if people
> > complain, it would be easier to revert than after switching to the
> > Python version.
> >   
> >> Don't put that functionality into the Python version :)  
> > 
> > Yeah, I started implementing it, but it sounded a waste of time, so
> > I dropped it from the RFC versions. It sounded too complex for people
> > to maintain a separate tmp file when make O=dir would do it on a much
> > better and automated way.
> > 
> > -
> > 
> > With regards to the Python transition, since our Makefile allows
> > switching to a different script since ever[1], I'm playing with 
> > the idea of sending a patch series with:
> > 
> > Patch 1: 
> >   - drops Sphinx version check from both kerneldoc 
> >     (-sphinx-version parameter) and the corresponding Sphinx extension;
> >   
> 
> It's currently scripts/kernel-doc. Are you planning to change it to
> scripts/kerneldoc and break other scripts and makefiles?

No, the idea is to keep it as kernel-doc.

I always confuse the names as we have both, depending on where you
look at:
	
	- scripts/kernel-doc
	- Documentation/sphinx/kerneldoc.py

The Python version was written to support all command-line parameters
as the original one - although I introduced both a single line and a
two dash alternative.

It also expects the file name(s) to be after the parameters, just like
kernel-doc.

I just changed the logger formatter to be similar to what we have
on kernel-doc:

	Warning: <msg>

So, I expect that such change will cause minimal impact on existing
scripts.

Thanks,
Mauro

