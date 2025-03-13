Return-Path: <linux-kernel+bounces-560107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D7CA5FDD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E103B1D85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C311615747C;
	Thu, 13 Mar 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cXwu5YhN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49C225D6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887141; cv=none; b=G3EMQH2pQUl0j+dufo54qDE5wUOjWQjmN7SqF4rd4KgBAoSii7ycpSNTomDkw6vsypHBWEq2kUYnByVnbD20ImZgg2FcgR5vMdB9hyvbM4JMqgvNdub3I8ZtkAPqWbbNw+zR5smoNaq3bcNy1JMV9P/DJi0T3ykyFYgQjyulhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887141; c=relaxed/simple;
	bh=QAuAl850I6QdcB7lI5gFymuEiwx/gXSYeJzM5XAa5ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW6+/14A/UIVy6MT9kZDWh+maCc/NPaH6hErRnLN6yuH4jE5ABsulgUd+GzwZVdKPvPS2ie9bxiu2YhdCHnGTKUrpnUqxWVvbp95fzGfQd5OcNkgUSc3UpXPLPc6/sgeuLUGDN0Cmg7duEUnCmMZavZ6IfDcWR3WJRsCSInQ9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cXwu5YhN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2211A40E0219;
	Thu, 13 Mar 2025 17:32:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QwhDcVMCdGvI; Thu, 13 Mar 2025 17:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741887132; bh=PiNJKpsGFrssL1pPjjaACmR0ZB5HZ6p8FVxn5aKduPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXwu5YhNy2o2WmiQ0RpmE18Uvh6KF0/1qG4tLnZAFmW608aYKFiKK6rwR4zr4P/0n
	 VrvF068PR/8wIK0fTt3wZPf6h8/J4ZGkOhJ7t/n8PN5hau0mli8dbsCjucTQJj7Img
	 slTkkPD9zb5b/JMZyQ29feNtx1dQpQsMo1MOM0EVl1WCGYy3ucdxwpudxgYCSLRI8I
	 nNzEetN9qbrsMq65q0/NsepVG+3ekLPITIMco9UnrUOYBRkhM/nJeR8RRZwwasCVil
	 nkCulu7D31+p3QOrpokfBxiIDOsWuTxfP1kJRwfGuwE4W1hU+0NjLEn88BJO/qHtqI
	 luUYKR2YpJHqE8mXutj7PyYv0l2hWEJeguPJQ+Rl+KQ+NZEDET99UeAvUJu1fBRwGO
	 cgo+25Onvwu9bo6RBKSiQeEi/Pjo4KJ1PuzFiR48gegEeEP5CNf0IxW8PtovbY5hAD
	 3IDw/Ol5oWAXVSFH8jAYBBSaPsUUgj88AAk62dFatGhaMjbeHWOIIpgnRp5mqzmcG8
	 2qw5hemC7ErT7TbXpR7ZoqIm7vZS9RGR/+LJaukZgjQv1iaq0GllbM9JSIkCHYD+2h
	 oBinxcov8d9POqKVwABN5aOFAHs9owf8ZR3oL2rWTr9XtmZ/Oblf9DbIiapx+vOhw+
	 +N3x5kp2YqjJRcuhxje7L6M8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8056D40E0213;
	Thu, 13 Mar 2025 17:32:06 +0000 (UTC)
Date: Thu, 13 Mar 2025 18:32:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mikhail Paulyshka <me@mixaill.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/rdrand: implement sanity check for RDSEED
Message-ID: <20250313173205.GIZ9MWlT9ElklGPSrD@fat_crate.local>
References: <20250312123130.8290-1-me@mixaill.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312123130.8290-1-me@mixaill.net>

On Wed, Mar 12, 2025 at 03:31:28PM +0300, Mikhail Paulyshka wrote:
> On the AMD Cyan Skillfish (Family 0x17 Model 0x47 Stepping 0x0), which 
> is a Zen2-based APU found on the AMD BC-250 board, there is a situation 
> where RDRAND works fine, but RDSEED generates FF.

On every read? Or only sometimes?

Is CF clear when it returns FF?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

