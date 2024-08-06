Return-Path: <linux-kernel+bounces-276872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2543F949963
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2B0B26EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AFB158DDC;
	Tue,  6 Aug 2024 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="LNReBHc3"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1AF15688F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977020; cv=none; b=BtjHzZzm9CILrmGVYA/l3SQ5HuB+GWp2TrdeE6XIVP5fs7miBCdWyNwmxEsXcwAsn/xRDtZt478qg629wgR4A9lh7ZfTHPL4ScBBAXnTtGdHcUh46PmIaJM90jSK6Mr7kzr/rP8k5Eyuu5o5cp7UGV5/Vwyy/xCsP9bmvHektBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977020; c=relaxed/simple;
	bh=Ax0S2L6VP3O9Qok3UjfQKmHvYKiLekiBjtgbZhWykYs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BNc9jL257CMfT1IXHoQSD9CSiGfyM5qS6iPEqyyW/2nePDNUezgbHEUtXrMQQ+i1KcwwqpmtELxPglvoj8ybqILdhfQq/8PM+ACDGrHy77A5y+tac53FJMwVSyIHoHSVxAU0xpeblrWg2tUk2nulZD106NyplIeyf1f/LpKMBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=LNReBHc3; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1722976363;
	bh=Ax0S2L6VP3O9Qok3UjfQKmHvYKiLekiBjtgbZhWykYs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LNReBHc30XrJ6eq3mUaIskjI2Kxz/wFJY+B310B3RDTLqBlPZjXJwboWp2Pp37AlF
	 XDrY4nUJ2x4ceTJxw2Pyrxl517xqvQD/NaRiXI+IUUkxuEqoEbwG+t6Cyuy/PIsxO0
	 UFbebDBM5tLWf83IRDNdtpHzjW9cshRZ7HK9xFXI=
Received: by gentwo.org (Postfix, from userid 1003)
	id 4AAED4035A; Tue,  6 Aug 2024 13:32:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 495CB40250;
	Tue,  6 Aug 2024 13:32:43 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:32:43 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Uros Bizjak <ubizjak@gmail.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
    Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
    Nadav Amit <nadav.amit@gmail.com>, Brian Gerst <brgerst@gmail.com>, 
    Denys Vlasenko <dvlasenk@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
    Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 0/3] Enable strict percpu address space checks 
In-Reply-To: <20240805184012.358023-1-ubizjak@gmail.com>
Message-ID: <35c12a89-6a9f-0e43-5b84-375ab428a8bc@gentwo.org>
References: <20240805184012.358023-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 5 Aug 2024, Uros Bizjak wrote:

> Also, the last patch hijacks __percpu tag and repurposes it as a named
> address space qualifier. While this works surprisingly well in this RFC
> patchset, I would really appreciate some help on how to rewrite this
> hack into some "production ready" code.

This looks like good work to find issues with per cpu macro usage. Per cpu 
macros are a bit esoteric and it would be a good benefit if you can 
get this done.

Sadly I cannot help you much with the address space qualifier.

