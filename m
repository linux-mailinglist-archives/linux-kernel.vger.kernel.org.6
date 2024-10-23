Return-Path: <linux-kernel+bounces-377967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217BD9AC944
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFD21F21769
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC96B1AB6DD;
	Wed, 23 Oct 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eTYmSh8U";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eTYmSh8U"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5E1AA7AF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683697; cv=none; b=HBGh43JLgKwfsHUN0fbLFe5jQVP4XsqBoPGAwPuOzEYHhwoYhTpKMe/uZJKzQ1sYHZzT24Fw/V4s4zGrcbZlG4l74aAUV8SWvFCNK4dRWB68b5gFqOdqDzpvOe6xd7kNjAxPUPI7APdVNPEZCQ51mYP7d8RuTU43wc+6OlTRSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683697; c=relaxed/simple;
	bh=oSCwQkr4IzishRO805JEjPuzC0Ufvggxbc3IuYF/kVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lgFikD4UmVYJUDS1yIouxQll647G2eixQwPeW/uF1QQPDFCWg9vb/6L4D4nNO5sTmWOPieiasz4Msj8mcNDgaLz4bgA4vMVTHzcOpRoWlZp4PaHMcUgG5oTnVqyYyrQnOo/Q2hdTtnc6qjFLYp8PrsHBAF4Q3Ugo0CWLunx5YMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=eTYmSh8U; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=eTYmSh8U; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1729683694;
	bh=oSCwQkr4IzishRO805JEjPuzC0Ufvggxbc3IuYF/kVc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=eTYmSh8UZTtqjMgOSMJD7iqti03kC6v0fzpJoBoVAvBROnM1y8wl/JaT2kV4Umz43
	 odNxTKnTsu+5YGdZcQwEyLCN9SkwJMlSGUt2Zek9h2ySrIDWyvbnaKkWMELKvrjzHE
	 iJlGxT3AsouMzRoW7J6WEeyKyCeZ0eivE5/ZzgTc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id BEFCB1281A09;
	Wed, 23 Oct 2024 07:41:34 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 0UzoeRZ0RvAb; Wed, 23 Oct 2024 07:41:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1729683694;
	bh=oSCwQkr4IzishRO805JEjPuzC0Ufvggxbc3IuYF/kVc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=eTYmSh8UZTtqjMgOSMJD7iqti03kC6v0fzpJoBoVAvBROnM1y8wl/JaT2kV4Umz43
	 odNxTKnTsu+5YGdZcQwEyLCN9SkwJMlSGUt2Zek9h2ySrIDWyvbnaKkWMELKvrjzHE
	 iJlGxT3AsouMzRoW7J6WEeyKyCeZ0eivE5/ZzgTc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E99EB12809C2;
	Wed, 23 Oct 2024 07:41:33 -0400 (EDT)
Message-ID: <12e62493ac3ebd47f92e7f26260780f5f4ea2780.camel@HansenPartnership.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Steven Rostedt <rostedt@goodmis.org>, Christoph Hellwig
 <hch@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	torvalds@linux-foundation.org, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Wed, 23 Oct 2024 07:41:32 -0400
In-Reply-To: <20241023042004.405056f5@rorschach.local.home>
References: <ZxZ8MStt4e8JXeJb@sashalap>
	 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
	 <ZxdKwtTd7LvpieLK@infradead.org>
	 <20241022041243.7f2e53ad@rorschach.local.home>
	 <ZxiN3aINYI4u8pRx@infradead.org>
	 <20241023042004.405056f5@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-10-23 at 04:20 -0400, Steven Rostedt wrote:
[...]
> I did push urgent branches to linux-next some time back, but never
> found any advantage in doing so, so I stopped doing it. As the code
> in my urgent branches are just fixing the stuff already in Linus's
> tree, they seldom ever have any effect on other subsystems. My new
> work does benefit from being in linux-next. But since I don't find
> more testing in linux-next for things that are already in Linus's
> tree, I still don't see how its worth the time to put my urgent work
> there.

What do you mean "push" to linux-next?  You just give Stephen a list of
branches and he pulls.  I do have a single for-next tag that he pulls
so I merge both fixes and collecting merge window stuff into that, but
I do this so I can see immediately if we have an internal conflict,
which is the most common problem.

If you don't want any work at all, just name your fixes branch and tell
Stephen and then he'll tell you if there's a problem.  In this model
you don't have to do *anything*.

Regards,

James


