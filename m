Return-Path: <linux-kernel+bounces-239611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25D792630C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A342E289AD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81E17165D;
	Wed,  3 Jul 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIon9ft3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4BD17967E;
	Wed,  3 Jul 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015743; cv=none; b=ns9xVEg9KzEXy/7nTlySCViFG9/KqJSKo6JsA7CetTBIw2WlY9n0jDpT/BANcRoKwZ8zPGs8RxzAmNLtUHtY76pOMFx+93ifX87dteqhOOyDYGfUnwaQdpRpzbeltRkN/j6wXUmCviRTjsCwcgUCosH78cGx0LmAaDZXmEhZQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015743; c=relaxed/simple;
	bh=5diAuIlhWYpYvNMt5qTjK4gvpZvsIUUx5saTux7wVU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REJu4RkNJeUVBX9RUErycJdYglKiqlWjL7vslj77pFUS6k3pg7rixrmnPNqg8RefiCRxepRUKPvQnx8dC+M6VnjtRZVTqwJ6JuI8ga6HT3J3Qs4jPWe5BcW4Vm7JN9iq5CLheJn1/7/oFoOd9003XuX6MJhWDVxnJPENfkFhzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIon9ft3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F64C3277B;
	Wed,  3 Jul 2024 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720015743;
	bh=5diAuIlhWYpYvNMt5qTjK4gvpZvsIUUx5saTux7wVU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIon9ft3SeC38O+vPFHnF01jrKNgQPFlxEa5IXpsLMzcS1U9c4DG+2aGopwjNesUF
	 ceLyJnbxrdexJTOgff+9LRAYGJxALPHm4UA8T6ZTbsqVY4Q6DT2qr0O/IV3BlB2CH9
	 4cAVeAcmpgo9YTouEqSk3CpmAlQ2msxf9wqMiwI7KHZGAdivR6v/LmJ6GfUBJsju+E
	 KcjFip7moMdV7IeN3de6X2zLElLSDBVJn/e+XD7UsnvOC0uZFGBu2aVCTywL9y8oH1
	 Mvzm9w/cz7pTFoGOY91H+4me/sba/qVar8c4FdQQDoX90Nt46zAYXvtQdk+rOxbEsi
	 PDp78bQWtJwcg==
Date: Wed, 3 Jul 2024 16:08:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
Message-ID: <20240703-haftstrafe-anbringen-88ed445e77a4@brauner>
References: <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com>
 <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com>
 <CAGudoHH_z1a6MX8Z8Cqbz-jDTUoAjoxdV9KrQ6yvUkNszXO5aw@mail.gmail.com>
 <CAGudoHHg-T+ZOTm0fSpW0Hztfxn=fpfnksz5Q3=3YeCeEPo7LQ@mail.gmail.com>
 <CAHk-=wiBGSLNW6GGbnec-dCbn0kWvD+OXAa5VNXPBKLXYy5KOQ@mail.gmail.com>
 <3g3arsrwnyvv562v2rsfv2ms4ht4mk45vwdkvssxkrjhfjtpdz@umyx5tl2du7o>
 <CAHk-=wg6e8QMaBOyFaGon7pik_C1COrkmEz37mtUqpBoq=R44w@mail.gmail.com>
 <6knlkefvujkry65gx6636u6e7rivqrn5kqjovs4ctjg7xtzrmo@2zd4wjx6zcym>
 <CAHk-=whagTfq=EgwpuywUUu0ti7PPQuE_ftVjZOVrjnLwtS0Ng@mail.gmail.com>
 <du5vnvwygzbtal6qogmxckawwwxgbppuq5qi5aeqcs5unrlpz3@3k5degdvflzq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <du5vnvwygzbtal6qogmxckawwwxgbppuq5qi5aeqcs5unrlpz3@3k5degdvflzq>

> As a side note this is where I should also note the *current* LSM hooks
> are racy as is.  Suppose you can stat a particular file now, but a chown
> to 1234 means you can't. Then your stat call can race against chown +
> other ops. You can end up in a state where LSMs gave a green light and
> only then the state changed to one you are not allowed to look at. This

Fwiw, we've discussed this before. And my opinion is that we should
absolute not care about this. I have no interest in complicating path
lookup or any codepath to make these hooks less racy. This raciness they
have to deal with. This is not a comment on your patch but just that the
raciness of security hooks is not a problem we should care to solve
imho. If we go down that road we'll all slowly go insane trying to give
state change guarantees to layers that hook into the VFS in really odd
locations.

