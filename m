Return-Path: <linux-kernel+bounces-168846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D368BBEC4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 01:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA831C20D83
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 23:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A042C84FB8;
	Sat,  4 May 2024 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nuY8doZR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCC84E1F;
	Sat,  4 May 2024 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714863805; cv=none; b=o+B+Jze9djbnEtBv5nCv4tAaNwZdP+LCChJJqkoS4T4SUCn5CjyplCFe6MtTJeI0uxDvPwKqOzVtifqI8RSlBorxpX+8FHv2+7XSxooZseHYDXCtSzi1lL3DH5dET9F/4xpvkGsahv+eTRZ7Uga6X7eY0oi9glrZcYlGVeLr2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714863805; c=relaxed/simple;
	bh=ZInlZsOkTWK0vvjZbnibAQPQae7tkslsf9UrJVVqEVs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QW/zc1djcNAL5+89ijpeXaxN3VZh7sWjuz4XWMFlI7XYn7w29yT/8Y9SC/LcFULBkfbfTJTiov/iwyVlqJ23Ly7TSD3wncPJPeOZw2zAGZfQtucm34wZkkT/aGZBO77I3fEW96v5BEeZbUaCVD147sbvgrZxyfWz0QmIHFt3KAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nuY8doZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A7DC072AA;
	Sat,  4 May 2024 23:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714863805;
	bh=ZInlZsOkTWK0vvjZbnibAQPQae7tkslsf9UrJVVqEVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nuY8doZRVNRzroY3YxRsdC1Ol3wcauUk6s/2q3pKvgrXdV0oAiSM/eVwICYRxfTe6
	 3FNErWgTeE4+YgfdBtCdh2dRGxaJNaUDnaD2GJb6b8wAT3vZTbDf3GoHTrJw898ye4
	 6zTPUZ7+fMkxeveKKwJirHntws+i9R/ZvN/3CkhY=
Date: Sat, 4 May 2024 16:02:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, Liam.Howlett@oracle.com, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, linux-kernel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, llvm@lists.linux.dev,
 jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] maple_tree: Fix build failure with W=1 and LLVM=1
Message-Id: <20240504160257.02e20addebc407cb4a18da48@linux-foundation.org>
In-Reply-To: <20240503160821.GB3960118@thelio-3990X>
References: <20240503095027.747838-1-visitorckw@gmail.com>
	<ZjTWkM9hTnoIhzqV@casper.infradead.org>
	<ZjTgEsuxYF29AVFJ@visitorckw-System-Product-Name>
	<ZjTmqM4ePSZgSt9_@casper.infradead.org>
	<20240503160821.GB3960118@thelio-3990X>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2024 09:08:21 -0700 Nathan Chancellor <nathan@kernel.org> wrote:

> This patch has effectively been sent four times now:
> 
> https://lore.kernel.org/all/20220914101829.82000-1-jiapeng.chong@linux.alibaba.com/
> https://lore.kernel.org/all/20230217084647.50471-1-jiapeng.chong@linux.alibaba.com/
> https://lore.kernel.org/all/20230319132903.1702426-1-trix@redhat.com/
> https://lore.kernel.org/all/20240503095027.747838-1-visitorckw@gmail.com/ (this change obviously)
> 
> Your first comment from the 2022 patch:
> 
>   They're not used now, but they will be in a release or two.
> 
> I think a few releases have passed since then :) I don't personally care
> if there is a solution here or not, as I don't test with W=1 (there's
> enough to do at W=0 :P), but maybe it is time for either __maybe_unused
> (as that strikes at the heart of the issue) or at the very least a
> comment saying "hey, these functions are currently unused but there are
> plans for them to be used, so don't remove them", rather than just
> saying the status quo?

We could just slap a #if 0 around them.  But I don't think it'll kill us to
have to type them in again one day ;)

