Return-Path: <linux-kernel+bounces-529884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A5EA42C28
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F1F7A7B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC2B266B42;
	Mon, 24 Feb 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7JuHQqV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59A198A38
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423506; cv=none; b=cZxJReW8R3e6ONcYFni07bGhNqHBRfk/GADNuu0mqACmZpbNwO/7q1XINu8bxS6107eY8ruYuG9Rth2D3jy8wPxKx8aaS/TjCeX/bSnd+LdIU6jyia9DY8DjbSxeo/xLnMhxPBk5MOav6zBnrngxM+YwU5YDJ56DPbZuBg+uOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423506; c=relaxed/simple;
	bh=BHb9kF6SiOs8qZi975IWRiNDRw4tcBo+8PbCHcRr9JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tERD66NKDBl9YlMxZHrvOd6RR1WoeSZAqTqzKGY0p5LdK1SNGf6shtFMvkPtwJ/RSp9XkIcrLaG+ys8RnoYdR/wpzUcSNvkE1t+vTXmu9hDRsX0gFCYwcMMR7uLlQDD/pke4QbyOBfhP4QOx6mbYYvirDO4rcH0O0PnPKplj4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7JuHQqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1CFC4CED6;
	Mon, 24 Feb 2025 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423506;
	bh=BHb9kF6SiOs8qZi975IWRiNDRw4tcBo+8PbCHcRr9JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7JuHQqVakD9efmMyIW0LZOWLM52raCDy4DiJb4NzlQmn2Z84JBlbRmo+xTDzJaBX
	 PmrCD3VXImMTdSTmNcO5i5PZGYga3Yp6QAf7X/yDMANrtAOCuztWJ6LMGwf/buglsS
	 bxcBwK7OTszgJWX4hdOfaM6Y38DODIrdhBEl2M1czVu2axBIekPvtIr3iXpGFguSKn
	 nam6I669Nc2dczcj/h6mJNNgTRmEl/FZIVeX0AicQSHdSdVCEBVMl/1IQoXIG5VRA5
	 yaSqacdpGY0v5JTOh5UrlER0ig2Mpe4X3I1xdUwp3WBdlvOLTlP/XxSZr/C/P1kPzJ
	 kkth+/wF+tB6Q==
Date: Mon, 24 Feb 2025 10:58:22 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v4 03/10] x86/traps: Decode 0xEA #UD
Message-ID: <202502241058.13C1403@keescook>
References: <20250224123703.843199044@infradead.org>
 <20250224124200.166774696@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224124200.166774696@infradead.org>

On Mon, Feb 24, 2025 at 01:37:06PM +0100, Peter Zijlstra wrote:
> FineIBT will start using 0xEA as #UD
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Yup, looks good.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

