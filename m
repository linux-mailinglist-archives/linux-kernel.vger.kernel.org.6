Return-Path: <linux-kernel+bounces-382044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32D09B083C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3821F20EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1FC21A4D6;
	Fri, 25 Oct 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG204BnO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85621A4C8;
	Fri, 25 Oct 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870161; cv=none; b=s+FnoUGBBUkdCsCa4veSmKg2M9n2s+Lk/aBGvF4T9KkkxMNqH2gIhfZlsTuEUqi9gKZpKydYdraBHk3hLh+IN55KaJxnLODzCWW9xg92GTXbvbLWKjQwWc9DN5KJHaxkas7bRMijMih3VR4jQKzeK4Dd3ebpB2XUZCc/QeGQNw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870161; c=relaxed/simple;
	bh=+VVkpxPz1PkOKJ1Ggp+aWO/GdSOi60d28ezThI4PUsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDnvigSt9NNADu4nARwlie+xl2+oQ4Lhcxj1UZTRz5KulPFKKatCxH4Hfvr2HwCZPR/cZRdDam0qd24aBMdAHCHlPaVAJaaLTeeTkRCVgonpoK4oBtYtFLE9x+vQaxRYZCOshO2JuQpqnfvJyi9nX5fLYbKnhOO99C7WfmHWAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG204BnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D04C4CEC3;
	Fri, 25 Oct 2024 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729870160;
	bh=+VVkpxPz1PkOKJ1Ggp+aWO/GdSOi60d28ezThI4PUsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KG204BnOCzTaCP8BF7zEcCk+c9Xx9Xx5RqUDtfAJDNJY3u//4oFcGfl8bxanZWvYj
	 c5U8XkDx5rjAQwcJQSmr2rVI/DzltYVAZu0AuFrliq2PW3/68tBP+1ErryUs00+d0x
	 wCFnyjIXQIh9ERtzvcjYGHlTa9EogYgtDG3FDOkZFXJU6UhsQZu16pr0xXvlJhw5dH
	 oRRZrIh+uA8fbbk9xDp4GqYxsQpNXQO8bene+LxTSeGdfp97DbelytuXPncwn/Ee9R
	 lHFhEy5ZKxk4rWn+jBCzh0jGGaSuuaT5/gyu3YltaomScbSsuif5B1ZaD9RoqzJyYp
	 pSQGBpae7c15A==
Date: Fri, 25 Oct 2024 17:29:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Will Deacon <will@kernel.org>, ericvh@kernel.org, lucho@ionkov.net, 
	asmadeus@codewreck.org, Alexander Viro <viro@zeniv.linux.org.uk>, oss@crudebyte.com, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, oleg@redhat.com, keirf@google.com, 
	regressions@lists.linux.dev
Subject: Re: VFS regression with 9pfs ("Lookup would have caused loop")
Message-ID: <20241025-aberglaube-gerissen-5e1a9da4fffc@brauner>
References: <20240923100508.GA32066@willie-the-truck>
 <20241009153448.GA12532@willie-the-truck>
 <4966de3e-6900-481c-8f6b-00e37cebab7e@leemhuis.info>
 <20241025-ungewiss-zersplittern-c124bc48be5c@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025-ungewiss-zersplittern-c124bc48be5c@brauner>

On Fri, Oct 25, 2024 at 05:25:47PM +0200, Christian Brauner wrote:
> On Tue, Oct 15, 2024 at 08:07:10PM +0200, Thorsten Leemhuis wrote:
> > Hi Will! Top-posting for once, to make this easily accessible to everyone.
> > 
> > Thx for bringing this to my attention. I had hoped that Eric might reply
> > and waited a bit, but that did not happen. I kind of expected that, as
> > he seems to be  somewhat afk, as the last mail from him on lore is from
> > mid-September; and in the weeks before that he did not post much either.
> > Hmmm. :-/
> > 
> > CCed Christian and Al, maybe they might be able to help directly or
> > indirectly somehow. If not, we likely need to get Linus involved to
> > decide if we want to at least temporarily revert the changes you mentioned.
> 
> Sorry, I'm just getting to this thread now as I'm still out with a
> fscking case of the flu.
> /me reads...

Ok, so this seems handled already. Great.

