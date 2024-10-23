Return-Path: <linux-kernel+bounces-377948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB84F9AC8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832601F22FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B91AAE06;
	Wed, 23 Oct 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHZUcYEq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018E1CA84;
	Wed, 23 Oct 2024 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683049; cv=none; b=pENK+K9ZLYivG0Ljz+LWhGAvOEu0BBNEH8AFx9eGqJnUlHQ7RDZ6l6YUhUrshprkmKVfuX65gO+E/tslCJgxoSPIlzT3JISfpk0G1ADK4ZmVeQtDcY31N+W5UxsuG8HXhMW2HGfpxLz5H8FmOrOLN8z8bf8hcXTwmwQ/nzXfvF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683049; c=relaxed/simple;
	bh=oV5yBCvSY/I5nvYmeJJWIoBisEBeBCIXfe1qmu3o4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+AX7gG4YKcjxo1gydbwdkDEddc3jAZ2vaJSiIe9kol+PumhYe1HFT9KUWSC9LtJJySTqs8LIIikqpgtGox0CO33JIs+wj1PsRNxr29V9C4YFE/PZGINIqj8c+B7dPbVCFgUw/eJLWKFyk4L48zkkd9WNbZL7FwVRQjWMvNwvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHZUcYEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88803C4CEC6;
	Wed, 23 Oct 2024 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729683049;
	bh=oV5yBCvSY/I5nvYmeJJWIoBisEBeBCIXfe1qmu3o4Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IHZUcYEq7qL91FC+WsF7IOCp7SLTUj5nBcyMpkym6lOX8CAAOCanK5xz8hksYiiyz
	 UgYavvcpStcvdUnfB20o31CkVkekGSNC5sJ0BxHIoj1kuT+8SF/xOp7NQl49+RL0rb
	 czrH43eDVGHMqZMXZNd3wG/OEOB3xb9++IqaYdAwZxMyZNMNUVjAN06yb3JnEY5vrx
	 1B25VctE5GeG0sKC+ynnoeIqbqRzIHSXQUxEig+Kn0vUCiP0nsY525ijYloEwsvO5V
	 P+P5pi/ebod3wR+2ff05Rhh3OkvQlgmrYc4MfrjKH3nC+V+6BVenQjdhSKSvQURe4B
	 hmPUb/Lt3pOeA==
Date: Wed, 23 Oct 2024 13:30:44 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, aliceryhl@google.com, dakr@redhat.com,
	linux-kernel@vger.kernel.org, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com, boqun.feng@gmail.com
Subject: Re: [PATCH v2 3/5] rust: page: Extend support to vmalloc_to_page
Message-ID: <ZxjeZH4fz6ihRRkr@pollux>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-4-abdiel.janulgue@gmail.com>
 <Zxi287W_MJcMB4YO@pollux>
 <74db5f3b-c329-474e-9a9d-de67d7cb888c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74db5f3b-c329-474e-9a9d-de67d7cb888c@gmail.com>

On Wed, Oct 23, 2024 at 01:26:37PM +0300, Abdiel Janulgue wrote:
> On 23/10/2024 11:42, Danilo Krummrich wrote:
> > > +    ) -> Result<&'a Self, AllocError>
> > 
> > Please don't use `AllocError`. We're not allocating anything here.
> > 
> > Anyway, do we need this as a separate function at all?
> Thanks. Would it make sense to squash this function into
> `Page::page_slice_to_page` instead?

Probably, though in the future we might also want to add `virt_to_page()` if
to `Page::page_slice_to_page` if it's not a Vmalloc address.

But I think it should be fine to handle both cases in `Page::page_slice_to_page`
directly.

> 
> /Abdiel
> 

