Return-Path: <linux-kernel+bounces-416101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738FE9D4043
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9991F21AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C506153801;
	Wed, 20 Nov 2024 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XdbywSom";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ohY0Ra6p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A213BAD5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120848; cv=none; b=getc0VlHG7mg972T/xWfyAXH9ZRagToQI6N1klnNUdDX/gGp9jP3ok1VAp5mJ+4b/GcAjDtqCAxSDYkoWnGi6VXMPfvf/vSUhcnz50RcKTH5SqJ/UjKE9EbK5YoR3jxjh0IgCJWKes2rzG03NJJ1mWjS0U2YGvDAOS2u8xpQbM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120848; c=relaxed/simple;
	bh=a9dNUhI2QgLPA72+LOzAsUcyH0YlbCoeEvSVL8YwBSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9A7M3I0PZw0Nq2iTNeH20sP4qMsAHK2jV6qKP/LjloYVIVcKrahr+dIIYbuWCwXYQObOocmhVrGl5N2jbsXop3QhM4xg9uHjvAbL6kfEMqGQR7/TqU5HdxtxwI0VC72aw0nmx8zuaqxnlaQuOihdITCouCBiotPMmXH/usfXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XdbywSom; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ohY0Ra6p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Nov 2024 17:40:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732120845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9dNUhI2QgLPA72+LOzAsUcyH0YlbCoeEvSVL8YwBSs=;
	b=XdbywSomNMelXmfdhFqclN5FpQ/NThcQYPxw1MYKI/DNUOQLY1431cZOPCjwYI+h02gk8K
	BeQGaMvQEn2BoPudDfvDwRncZjzvHRTFhP7ou7GFKmgl8ijzFabI52TAP3YXec1X4q+aws
	a7dpwp+wH8rGWdIVDZRmNhNsH41FNSbTaLo1M1uYCh8qQ9QPq5pYQfL/9OeN34r+Hzt6my
	GlavEsvJRpQy9UqWTpD+NCsOyW2BDF/uQ7J4b5jBJ9A0Bn06zOlWv6f8xS5jS9qQuvxZR/
	qgQ9q3J5q3qX+IWOsgCR9ReirUmv/Uzdm1DZRnUk6dZyyX+rT4V/noO185t60Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732120845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9dNUhI2QgLPA72+LOzAsUcyH0YlbCoeEvSVL8YwBSs=;
	b=ohY0Ra6peMKylhOY2pL8Kelfgc0LvJzcCh7au4yHQj7ccjcMecxMxmD5zfYMpEXDqu4OBt
	6ZKeCWlKnpNObbCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
Message-ID: <20241120164043.T1JuBALe@linutronix.de>
References: <20241120102325.3538-1-acarmina@redhat.com>
 <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120102602.3e17f2d5@gandalf.local.home>

On 2024-11-20 10:26:02 [-0500], Steven Rostedt wrote:
> The "%pK" dereferences a pointer and there's some SELinux hooks attached to
> that code. The problem is that the SELinux hooks take spinlocks. This would
> not have been an issue if it wasn't for that "%pK" in the format.

That is missing check and I think Thomas Weissschuh wanted to add it. So
we don't call into selinux.

Sebastian

