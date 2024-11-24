Return-Path: <linux-kernel+bounces-419325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBE9D6C7F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 03:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEF3B2124F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 02:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FAF26AFB;
	Sun, 24 Nov 2024 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JdQxkdGv"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3F1CFA9
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732415518; cv=none; b=QogxO+wHeOOQE20PfucKr8hEO5ht43RR+PDiuXE7cXVOrpCY0RGXXlrABrke+dIFQAR+YrZoyZRZpErQSeKB+CmTFCrBGcQPzPaq2CUpoQGQDq/idPG/RUh+JxaZCXnqlu9Z/tV0Vy9biEok4WAOmLamftSLM5lf1f/mi074MbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732415518; c=relaxed/simple;
	bh=JVPNQKi05pxv8edbI23zQiTDhszhaVeb5AStLzYC6VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z12BBMhF4WnEDfVLpEd+H4I4owDOC28ZaksSkYS/mXPWWw3gtXNLQqiHF0abw+EdgFsC2p7HR3JzG5WJGe8OoQuE8ZhcdkYituairmCWYVuFCDgVlA4UxK9+Vus6My5e0FlOzBUywileXlfJ3+nDEq7Rik6zViprGM2yuD8m8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JdQxkdGv; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (syn-098-147-040-133.biz.spectrum.com [98.147.40.133])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AO2UPXs009591
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Nov 2024 21:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1732415429; bh=tMYA3FuEfBdwg4uY/IL9dl9TyQ4GzJOPWzyUfUCOSHA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=JdQxkdGvV2bFkTsn7WTIo6NEBtphYwCkSJ6xu+YMGMQ0uBY+Uozz2K7D3i2KdFEom
	 pzzViQesUzyVmQn9UCBQzytLm2nClYskc9bgiTHJl0ioCVtoGXMjWtZSMeLp07Ik0i
	 pjedn6lKdiZFbEJGjjHyEJH+t4nNXjl2txuLwBF4gmqNIztqUwyAOeowEVy48OkVyz
	 jSE3u5TNS8P/MskfjAjhacYpyl07VaCEkZ3pN9w5XsxO2a3h32yrSQfpMudJwrSObJ
	 JZlkcN/7lStPMw/G3srGEuOjrMa5xI1vpprVldBTcFV5KDCh1gN4S4/dzbej7fX0iQ
	 vzXBFmfESkWVg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id EA59E34125E; Sat, 23 Nov 2024 21:30:24 -0500 (EST)
Date: Sat, 23 Nov 2024 16:30:24 -1000
From: "Theodore Ts'o" <tytso@mit.edu>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jinliang Zheng <alexjlzheng@gmail.com>, brauner@kernel.org, jack@suse.cz,
        mcgrof@kernel.org, kees@kernel.org, joel.granados@kernel.org,
        adobriyan@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH 0/6] Maintain the relative size of fs.file-max and
 fs.nr_open
Message-ID: <20241124023024.GB3874922@mit.edu>
References: <20241123180901.181825-1-alexjlzheng@tencent.com>
 <20241123182730.GS3387508@ZenIV>
 <20241123193227.GT3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123193227.GT3387508@ZenIV>

On Sat, Nov 23, 2024 at 07:32:27PM +0000, Al Viro wrote:
> 
> 	You won't find the words 'IO channel' in POSIX, but I refuse
> to use the term they have chosen instead - 'file description'.	Yes,
> alongside with 'file descriptor', in the contexts where the distinction
> between these notions is quite important.

What I tend to do is use the term "struct file" instead.  The "file
descriptor" literally is an integer index into an array of "struct
file" pointers.

"struct file" is how things are actually implemented in Linux and most
Unix systems.  And while it's admittedly ugly to use an implementation
detail as an abstract term, it's infinitely less ugly than Posix's
"file description".  :-)

						- Ted

