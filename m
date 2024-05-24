Return-Path: <linux-kernel+bounces-188859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03D8CE7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC17D2822BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE7F12DDAE;
	Fri, 24 May 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F5J4VWSt"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BBB12DDA1
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564540; cv=none; b=E3uSBBzGqYgWnTsdOqToaxPbr04uUZmNv/9v14pjdqOvrxFeCV8lGJEw1965mf1hjMVyf+mxfeZze3CoYyQ/wgeeBpAsEaiGZxfl03TRDUzima9KPP1eHHE73pG1aiwApgaDHKuZmPH672DwKau/nnkUtbNHytR34fPNQD8No0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564540; c=relaxed/simple;
	bh=ZrwkY7OA74VPWeSi0lczYx2yoEjce3Xx1fX5oGEkMso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auAtbMczmMxRRZrmezQbb5X21ojonrUBC2+j6yCod1FYsP0Fjy1XzdX1NYBnaYA+B1lSOoAUBgkON+C6twDGn5I1vtG+KK+pKrTX6Wdr+Y/xX06A6SGkiF188SyWcFklq1+eMvds2cVcIzfhTW3Vh8+NnYDbUtCb90Uo3Sh21Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F5J4VWSt; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mathieu.desnoyers@efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716564537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=irywiOY5cPEy6qsO/OYQSwObBpFKOwGsd5mBaePILQA=;
	b=F5J4VWStavQIRb2LNU1s+W29wn72CfvGB170e/PtHoEA2FnFyjfXjBnI/sEFRvwuzIV1+D
	Klnwitr49HjGYUEHUdFmkKTe1lw0cEhFvJxAlVlcagFvtrXFWuiukj72BmR6XG/GWcj2DO
	mcVG+g98Wi0laMkf3yg7sQrdthKE6nI=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: keescook@chromium.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-bcachefs@vger.kernel.org
Date: Fri, 24 May 2024 11:28:54 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Brian Foster <bfoster@redhat.com>, Kees Cook <keescook@chromium.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-bcachefs@vger.kernel.org
Subject: Re: Use of zero-length arrays in bcachefs structures inner fields
Message-ID: <vu7w6if47tv3kwnbbbsdchu3wpsbkqlvlkvewtvjx5hkq57fya@rgl6bp33eizt>
References: <986294ee-8bb1-4bf4-9f23-2bc25dbad561@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986294ee-8bb1-4bf4-9f23-2bc25dbad561@efficios.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 23, 2024 at 01:53:42PM -0400, Mathieu Desnoyers wrote:
> Hi Kent,
> 
> Looking around in the bcachefs code for possible causes of this KMSAN
> bug report:
> 
> https://lore.kernel.org/lkml/000000000000fd5e7006191f78dc@google.com/
> 
> I notice the following pattern in the bcachefs structures: zero-length
> arrays members are inserted in structures (not always at the end),
> seemingly to achieve a result similar to what could be done with a
> union:
> 
> fs/bcachefs/bcachefs_format.h:
> 
> struct bkey_packed {
>         __u64           _data[0];
> 
>         /* Size of combined key and value, in u64s */
>         __u8            u64s;
> [...]
> };
> 
> likewise:
> 
> struct bkey_i {
>         __u64                   _data[0];
> 
>         struct bkey     k;
>         struct bch_val  v;
> };
> 
> (and there are many more examples of this pattern in bcachefs)
> 
> AFAIK, the C11 standard states that array declarator constant expression
> 
> Effectively, we can verify that this code triggers an undefined behavior
> with:
> 
> #include <stdio.h>
> 
> struct z {
>         int x[0];
>         int y;
>         int z;
> } __attribute__((packed));
> 
> int main(void)
> {
>         struct z a;
> 
>         a.y = 1;
>         printf("%d\n", a.x[0]);
> }
> delimited by [ ] shall have a value greater than zero.

Yet another example of the C people going absolutely nutty with
everything being undefined. Look, this isn't ok, we need to get work
done, and I've already wasted entirely too much time on ZLA vs. flex
array member nonsense.

There's a bunch of legit uses for zero length arrays, and your example,
where we're not even _assigning_ to x, is just batshit. Someone needs to
get his head examined.

> So I wonder if the issue reported by KMSAN could be caused by this
> pattern ?

Possibly; the KMSAN errors I've been looking at do look suspicious. But
it sounds like we need a real fix that involves defining proper
semantics, not compiler folks giving up and saying 'aiee!'.

IOW, clang/KMSAN are broken if they simply choke on a zero length array
being present.

