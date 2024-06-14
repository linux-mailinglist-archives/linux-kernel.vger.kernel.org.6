Return-Path: <linux-kernel+bounces-214468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82D1908525
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA101C22E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760751836CD;
	Fri, 14 Jun 2024 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI5xFhOd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC8158D87;
	Fri, 14 Jun 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350413; cv=none; b=hzVfUrQUaJRLN3jouQnF34T/prmbDmLdTLsnam97qD/lg1+dv2F54wv6zwQNxy/4kQsnMjXxMPg7K3n+vfjC9Jk/PWKfSY7msU7sfZync9yUPA3ckLxxqAtBylGwqH7kSFYTI9JR380cH3ay3cAdNoTNHcdC1HiU3cypsnMfVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350413; c=relaxed/simple;
	bh=NnkmAXOOWVZBMmSqgujLFcgmwxn48aka8vwCP+88UZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdNKl1T7jmLjcbRi+wNO3Bfw71GO9Yqy3eK4xOyzZl8nM34Sq8ILqEHQYlMffmxYIXVAG+mUVWgaz7c3JWPA1aJ9fbx0CwK1SY1uU96ac1TznGBUTzunGJVtrJNrdbuVrBRKI88g4HYBL0tShy8WdjvcHUUahcRJb83ft2SPzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI5xFhOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F89CC2BD10;
	Fri, 14 Jun 2024 07:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718350412;
	bh=NnkmAXOOWVZBMmSqgujLFcgmwxn48aka8vwCP+88UZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DI5xFhOdjQNg736myA0URAZZXPnU4nkPBwlDT5j11/xqDepPKNTSeUJOZL0VzP78z
	 Gija8ZvzsBIvSQvQZgN2CKyBYONNbneV97Xw46m0pZ6iejHSj3QVukJgOHaw6n5vEJ
	 oPmNs7XQyKSovf9ZEFJM6K15LIm3xk4zeLcrYGHwDqPjUCQ1snvszipq3ByAXJg8iQ
	 bH22iOboDVQpyv1c0zS0BOBES5DnTQZ8taQOTO4VL6P5MvVJabccgtOreaS1mIayMf
	 Qki3z/jPfNl6nl++W+rT3j9EzUHaYd6pMBIRMyAoApsEr1aQyraU56QXk5+aQujBGv
	 Eojfa4GEc9Isg==
Date: Fri, 14 Jun 2024 10:31:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jan Beulich <jbeulich@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>, Narasimhan V <Narasimhan.V@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] memblock:fix validation of NUMA coverage
Message-ID: <Zmvxyc5xguxefBwo@kernel.org>
References: <Zmr9oBecxdufMTeP@kernel.org>
 <CAHk-=wickw1bAqWiMASA2zRiEA_nC3etrndnUqn_6C1tbUjAcQ@mail.gmail.com>
 <CAHk-=wgOMcScTviziAbL9Z2RDduaEFdZbHsESxqUS2eFfUmUVg@mail.gmail.com>
 <663e80fc-6785-4ac5-ae74-e5f26d938f49@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663e80fc-6785-4ac5-ae74-e5f26d938f49@suse.com>

On Fri, Jun 14, 2024 at 08:01:33AM +0200, Jan Beulich wrote:
> On 13.06.2024 19:38, Linus Torvalds wrote:
> > On Thu, 13 Jun 2024 at 10:09, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> Is there some broken scripting that people have started using (or have
> >> been using for a while and was recently broken)?
> > 
> > ... and then when I actually pull the code, I note that the problem
> > where it checked _one_ bogus value has just been replaced with
> > checking _another_ bogus value.
> > 
> > Christ.
> > 
> > What if people use a node ID that is simply outside the range
> > entirely, instead of one of those special node IDs?
> > 
> > And now for memblock_set_node() you should apparently use NUMA_NO_NODE
> > to not get a warning, but for memblock_set_region_node() apparently
> > the right random constant to use is MAX_NUMNODES.
> > 
> > Does *any* of this make sense? No.
> > 
> > How about instead of having two random constants - and not having any
> > range checking that I see - just have *one* random constant for "I
> > have no range", call that NUMA_NO_NODE,
> 
> Just to mention it - my understanding is that this is an ongoing process
> heading in this very direction. I'm not an mm person at all, so I can't
> tell why the conversion wasn't done / can't be done all in one go.

Nah, it's an historical mess and my oversight.
 
> Jan

-- 
Sincerely yours,
Mike.

