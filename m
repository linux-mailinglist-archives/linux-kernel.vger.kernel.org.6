Return-Path: <linux-kernel+bounces-517470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D42A38159
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B30518833D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF18218AC3;
	Mon, 17 Feb 2025 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YQ0WIRqr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04B21883C;
	Mon, 17 Feb 2025 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790234; cv=none; b=iDP1j83qbL6ZSEagIKbC7ViUMOgr5s3EUlnHejQ+1dbewottEtxx9V9mVBePl7v77vnig6mS2VIOS4ypALnvBNe4H9xn3bSa+gel32Amx2AjJIIjO/ZswdKPbxcECGIH39aRwIdA3rZosSoueiaT8AWRSd/0yQseLckOEFwy6+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790234; c=relaxed/simple;
	bh=kQ9ahJoLUAa6eg+bXrlnGmnOJsZB6csYPykuKxx+kbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b620dMeUOzdlyasmDl6upBJivYzeRbIbEEQ13efEVBn8vU0N7sMwDxTTuY6BeR89LBmiuFsxBMQp06HzGIJvsjssdqLI7M2AYKgZRsTCCrRM4wxMosgXmYEwirMlNrH2SjC0x5n5n1xM3qHLBJ7x5Fu50mZmvjdvBkJSJDUoWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YQ0WIRqr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DDABE40E0202;
	Mon, 17 Feb 2025 11:03:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qW0rLXdjDKyi; Mon, 17 Feb 2025 11:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739790225; bh=OOMwHALIFx6ihAv83FsqwxXXoVcZoHEsKhOSw9w7d54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQ0WIRqrRtq2km0LeuZ7vUmZd3Xscn4YogsmNsBDI89g43/OynuycHZQdEt73xEpp
	 5mUehe3lnTOZZLLLtvxcbT+7vi3xBBNJHc4a++tn12HmXQqlX255bIavFci2rqmhQ7
	 vHJLDKH7To91ex5a+qB/W4ZYwZKdvw4rnKRaelwkbOFdiIwtRT7ej+en1XILKChy2t
	 ITsydsjJpFlB1oGmmdYgd4ffoMp8pbBO7YYC2BxZ8OIaJ8r+DjrDdD22RfTm4wqdxa
	 Bl1mDoY3LGXpLcVl8vl0FS7x07InbyG9nsMwx//Q+gFqT3ij4nE6pZpbJ8WmY1GBKE
	 4LE6fK2yoYuvPcw6qzPUaaqBGc6JEGp/oPWwjM0y4U7FMl8lTsfSMtZZvR7PLGfM6Q
	 p0XDXj0ow1+9KAqZ91P6/wbq4u1FgNLgNVV+VTz9mBU/TuGjWkAQjauWKp5CYCr8pv
	 ll/rayEFmE/+hlhS3U0aBzOwxSxFkid8Nka6EMD/14rWjy7EYTAbNu/rM4qkEDdNv4
	 9GfW6sYuS8hInJ6I4Ov3XkmA6uSknrsvofx0UoWSKAcEgXkwrnl2ZtArDLu4lXTLMc
	 oJTeSY4hCnibzUcqSQMWEx39IyBh3iOe6P/RRwi8LP5kA9eeJv89SaWTY2A9uO9tWa
	 1BJMWhHzLO2yJHqSlzVmCxYw=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1932C40E0176;
	Mon, 17 Feb 2025 11:03:35 +0000 (UTC)
Date: Mon, 17 Feb 2025 12:03:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/3] x86/cpu: Add setcpuid cmdline param
Message-ID: <20250217110334.GHZ7MXhq4xNWSkKHCH@fat_crate.local>
References: <20250129-force-cpu-bug-v2-0-5637b337b443@google.com>
 <20250129-force-cpu-bug-v2-2-5637b337b443@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250129-force-cpu-bug-v2-2-5637b337b443@google.com>

On Wed, Jan 29, 2025 at 03:35:40PM +0000, Brendan Jackman wrote:
> In preparation for adding support to fake out CPU bugs, add a general
> facility to force enablement of CPU flags.

"... to force-enable ..."

> 
> The flag taints the kernel and the documentation attempts to be clear
> that this is highly unsuitable for uses outside of kernel development
> and platform experimentation.
> 
> The new arg is parsed just like clearcpuid, but instead of leading to
> setup_clear_cpu_cap() it leads to setup_force_cpu_cap().
> 
> I've tested this by booting a nested QEMU guest on an Intel host, which
> with setcpuid=svm will claim that it supports AMD virtualization.

Move this sentence...

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

... here as it doesn't belong in a commit message.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

