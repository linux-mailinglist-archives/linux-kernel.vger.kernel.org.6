Return-Path: <linux-kernel+bounces-352581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6F39920FF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906851C20A12
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4FB189BB9;
	Sun,  6 Oct 2024 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TamOtnB0"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B16EAD8
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244850; cv=none; b=PZ19jaD6ZJPfWnAWafOLSUAlSlwfI5EZVpJSCrPqpvpjQgq+HqcPh29Gcqo9aMkg/FCjFPE2wVuUdivW8oqOme4NBY20VX+3Sw/AbXPTF94YI5NfEDu+3KLuOCCxmAjl/C/EESjMMODmu6C3Afz4iQ6OIlY/8iQxjFehYGi+fyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244850; c=relaxed/simple;
	bh=EFJ5znbEWq49VrtfItiZRXPo6AnegBFQLcUYA79CHKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azBhARLEv3NizgINqaiKaEQLlQJMVKru5UKmejdXKXEdVuipaLXKvBtpuLh4apRJUXnPPD3++a3hU/bALvtQkF9G5knPyht0WA2Say+FNeHUmpSKR/AeR27tqDHGogWVtWDIldFrkFv8jYP1FF0INIJe0KqI+3UCK4D5N5twvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TamOtnB0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5tuM+Y9p6eMLb4eUfE0M90vJXu80keX4OfG+gMrJJys=; b=TamOtnB01UzaU6nemCdO8RUCSF
	dXPAq+zqlxxvRwBLQMHVTIbajN/o7RbMWCfB/M2gScQSkyjiijxKc2SxZZugvCsyzoh3gGwXWyru4
	jIr2cqaMNDDfBganpywKqtskvXB0UqhLmmNUHAsgYvfv1ppkQzYSRSpaNCPnmnIpgilaBSbUrpK3i
	NQ+sEw5Sqs+YdA8fK/ik7ItM5y7fmGLPD5BRABASh1MsRonop24vKyvjm5N8suUpk9kiw+ZEc8y00
	uM2sLf4AFeGRdzS69Z/qJ8kUMyp2OfYqUSqpS7iTEcH3UWC6ifHd1oTmEgnrsASgC94U30VkBVB3D
	pCqXzifg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxXQs-00000001P9B-2s7r;
	Sun, 06 Oct 2024 20:00:46 +0000
Date: Sun, 6 Oct 2024 21:00:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Laight <David.Laight@aculab.com>
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] fs/qnx6: Fix building with GCC 15
Message-ID: <20241006200046.GF4017910@ZenIV>
References: <vch6gmzqaeo22c7473qyabrfwxlkdhx5vgvosjyp5l2nwgqnxl@5x3ny35qyfgx>
 <20241004094921.615688-1-brahmajit.xyz@gmail.com>
 <20241004184440.GQ4017910@ZenIV>
 <665bcd89cf5f4679a38e9a84fa0ba42a@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665bcd89cf5f4679a38e9a84fa0ba42a@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Oct 06, 2024 at 07:38:07PM +0000, David Laight wrote:
> ...
> > would explain what was really going on - the point is not to make gcc STFU, it's
> > to make the code more straightforward.  The warning is basically "it smells
> > somewhat fishy around >here<, might be worth taking a look".  And yes, it turned
> > out to be fishy; minimal "make it STFU" would be to strip those NULs from
> > the initializers (i.e. just go for static char match_root[2][3] = {".", ".."}; -
> > an array initializer is zero-padded if it's shorter than the array), but that
> > wasn't the only, er, oddity in that code.
> 
> Indeed - looks like it is checking that the first two directory entries
> are "." and ".." in about the most complex way possible.
> 
> I have vague recollections on some code that ignored the first two entries
> because they 'must be "." and ".."' - and then failed because some filesystem
> (and I can't even remember the O/S) didn't meet its expectations!
> 
> A simple:
> 	if (strcmp(dir_entry[0].de_fname, ".") || strcmp(dir_entry[1].de_fname, ".."))
> 		error = 1;
> would suffice.

memcmp(), please.  strcmp() is _not_ guaranteed to be safe without both being
NUL-terminated; yes, compiler will almost simplify that in case when one of
the arguments is a string literal, but it's better to do straight memcmp() in
this case.  It's not worth trying to be fancy there...

