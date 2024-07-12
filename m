Return-Path: <linux-kernel+bounces-251044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A659930027
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF5D1F24CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A913176FC5;
	Fri, 12 Jul 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrpbZEBd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA041426C;
	Fri, 12 Jul 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807274; cv=none; b=FpGdjNm60+P0VTePmY0szid6zJCHOiMSwivOTzaCsk7FyvfIyuKiRD9zwVYdMtqECAFozc3BNZfUnMdGHZRGbWxawrCRSmDzxQySfgxm6gNAxGT53ZuXL2cqqWW9sqWDv3/GC4AvQL7nj1aUcO2+6aCiU2TQ078IXNDiWqO/bc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807274; c=relaxed/simple;
	bh=G9CJB2XlEibvrQC7CgT9q0D1SmYxN9QvjlXhGDpJbE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3OfJCrajx8rWjqHrfYcvobZEytI/rqE5+Z/hOPtvb2Lkw0YXstrumr4PnxVZMkIn/vxFKO1Wi0inLXLM+AWItWFR+qmQsDAY1UNmxT7auDiydv95NS+ce4RSjKWr2lMn3mF0Qj119znf1iD6+YuzSiQXVf+4SkAuP6cC/fA58A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrpbZEBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03BBC32782;
	Fri, 12 Jul 2024 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720807273;
	bh=G9CJB2XlEibvrQC7CgT9q0D1SmYxN9QvjlXhGDpJbE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrpbZEBd2HLOE5ipzLRdK7HiKyYNaVgNFrX9nSlUu1jl+4Di79AlHcYnPZfzmVdLf
	 dliTSlCWluxrLl+U0AX6fuBHmMn5XyXmUCha73eJvBRWiYz/xDcXnvihr9b7IwJmC9
	 pVRDnmT8FE9uD2Dp4zjqXJEonyO/4MAGHz+aZS1mvsC/1orfqT4FQXrtVkpdqQQihM
	 dwM/3HyqlcKER4NX6j56NaA2qy4lywBUclUIS9eIunfVGtnLGEkxSXYpRTTQgE3H0+
	 qWC4dP4ZusQuObWH8j7llaN9hC1HBgg2xN6NZFLtmvyaGnlGuRprAzyJB1CtLT3CJx
	 0GnoZc7MJqQhQ==
Date: Fri, 12 Jul 2024 11:01:13 -0700
From: Kees Cook <kees@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2] bitmap: Switch from inline to __always_inline
Message-ID: <202407121059.9FC2D0DF@keescook>
References: <20240711163732.1837271-1-briannorris@chromium.org>
 <ZpFhv5VSYZ6jnsd4@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpFhv5VSYZ6jnsd4@yury-ThinkPad>

On Fri, Jul 12, 2024 at 10:02:55AM -0700, Yury Norov wrote:
> Hi Brian,
> 
> Thanks for taking over this!
> 
> + Kees Cook for GCC
> [...]
> But I'm not sure about that and don't know how to check what happens
> under the compilers' hood. Can compiler gurus please clarify?

I don't know much about GCC internals. I just ask GCC devs nicely to
help us where they can. :)

> >   Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline

We always expected them to be inline, and if we need to hit the
compilers harder with __always_inline, that seems sensible to me.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

