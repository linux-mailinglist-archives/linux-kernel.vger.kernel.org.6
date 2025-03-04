Return-Path: <linux-kernel+bounces-543606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB04A4D758
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164B23AB1FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C612F201276;
	Tue,  4 Mar 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fgdednzU"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE5202972
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078728; cv=none; b=THPTJ3y+18Nhn5zTY7zCKg1CMwPuOWlPTsHGCcerleZ63mChUGCrAkAN2tYGNgy7OQAqSdff/NiZ7dnHK4ELs57VnehLU74raq2HVZr4vMXgpLqVAlEozsuLbvGF02loyX2T+GGoZGhMU2QHe2DcbUeRzmjKrHXD21WgzJGSxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078728; c=relaxed/simple;
	bh=nUmHrfzNp6jmDbZwNWVM32a5wL7mYYMwSCZDj8Gheo0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XkiLwoNK4KGUmwHdWcUJqbst9XIpnSJJHVc6ztr/p3Xomovle/zaPpLsuR/qvE7JICp92uukLP5fguChNPWfE2QTP7ulLU2x2prYZ1GHFzUO0yFBsRgEdBZ69hAYi1fCJm9CGJG5Cj6kprbou9px+AjVSDQESSCo+uWic7h9G54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fgdednzU; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741078714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/01Bti/qdBFlvVEApIrVpIxZmx2rAPTHByTEu+IQIFo=;
	b=fgdednzUcOniM5YeoiPiAdMMWv2f+kdYhdy7EFrkoNBbgHGQop+auflWqTvhBgwDY6JK9F
	hIawFE4YhARDHi0335OWnkNXMxpS70uI9gx3KxgDixg61XTSHpKaJgCUwjf3/q5td4/X8e
	I/r70Ebom6VgKEi6G829c3Rh08wslrE=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] mux: Convert mux_control_ops to a flex array
 member in mux_chip
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <202503031040.223DEF2781@keescook>
Date: Tue, 4 Mar 2025 09:58:21 +0100
Cc: Peter Rosin <peda@axentia.se>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <20A47316-D274-45DD-BA15-F66139654D44@linux.dev>
References: <20250302230220.245739-3-thorsten.blum@linux.dev>
 <202503031040.223DEF2781@keescook>
To: Kees Cook <kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 3. Mar 2025, at 19:44, Kees Cook wrote:
> On Mon, Mar 03, 2025 at 12:02:22AM +0100, Thorsten Blum wrote:
>> Convert mux_control_ops to a flexible array member at the end of the
>> mux_chip struct and add the __counted_by() compiler attribute to
>> improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>> 
>> Use struct_size() to calculate the number of bytes to allocate for a new
>> mux chip and to remove the following Coccinelle/coccicheck warning:
>> 
>> WARNING: Use struct_size
>> 
>> Use size_add() to safely add any extra bytes.
>> 
>> Compile-tested only.
> 
> I believe this will fail at runtime. Note that sizeof_priv follows the
> allocation, so at the very least, you'd need to update:
> 
> static inline void *mux_chip_priv(struct mux_chip *mux_chip)
> {
>       return &mux_chip->mux[mux_chip->controllers];
> }
> 
> to not use the mux array itself as a location reference because it will
> be seen as out of bounds.

Getting the address doesn't fail at runtime, does it? For this example
it works, but maybe I'm missing some compiler flag?

https://godbolt.org/z/qTEdqn9WW

Thanks,
Thorsten


