Return-Path: <linux-kernel+bounces-557789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9BEA5DDC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096B2164964
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD57024502D;
	Wed, 12 Mar 2025 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b="Jfvn6vb0"
Received: from mail.mixaill.net (mail.mixaill.net [144.76.234.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AE64A01
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.234.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785480; cv=none; b=N62QYXFNgvEQWUSDchwkM8O1I7dw1DXMzwmF/SxIMlqYFl1xIiR9bQZFeuTKcl5qbeS8NWdFlulDhZv6yPJ9ToKXNzMHFA5kPPiWJFezi5i0eSaSZi4y6g6FvZytkciOkbEt92LzBbQytkyTD8bf/ADGzAucTWr3iX/PpW4fr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785480; c=relaxed/simple;
	bh=7z/nrmh5N+ZhnoVRQxxrFg29kWXCe5+G836Gz43HkV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCe+EAkh6pJCzpl9OT7lpt+HFiAwpGmzQ1E+/nqgupR14RYVwQarrFvodQliHpHooIzq6P2mqbBz75dxX9L6cGoY4SslS5pF4Y2jw8oM/LbC7Ql6KbS9dkowkzxx0+fFwlFknmLbu9z0/bpigLLboYqavjiHOZixApuCkhZGDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net; spf=pass smtp.mailfrom=mixaill.net; dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b=Jfvn6vb0; arc=none smtp.client-ip=144.76.234.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mixaill.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 089EE618C6;
	Wed, 12 Mar 2025 13:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mixaill.net; s=dkim;
	t=1741785476; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uApGfAkwTNuZ/0f/uziF7SShu01cdICgTAzmtr/PVtc=;
	b=Jfvn6vb0f4UmjlyAPM8y1aR6pvL0oQdMXGrzY2kTxiREmbG2e+MH8iKkqDB/h9lUqJqSj+
	hv5V1mWWADGbgR347Wo0/kViPCDE3dKbieWgvY+iLN11GUFx4EHS2aL75PIovOVJtfj5DQ
	wt5fIFTs+N9UmyQU5WROcsYh5fuATMgz8eCGxCCAyb+8q0zadhuLJtGGTYvCTGMwfcEoxh
	Cgc4kC5teSdfXoy+qgUV03BsoAXrwumYUYIt9VZ7zwKR5dEBrzNgKz40gO8K8TrLLlSqCS
	VyH2lrNceDhEs7rxr7nUPsLnp9v6eY7JP6H/dBBikBHfZZYzfSZHZoVIk7Wb4Q==
Message-ID: <10f010ca-b79f-4886-ba18-3013560905b2@mixaill.net>
Date: Wed, 12 Mar 2025 16:17:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] x86/rdrand: implement sanity check for RDSEED
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20250312123130.8290-1-me@mixaill.net>
 <20250312124006.GCZ9GApgQQ49dO_BMW@fat_crate.local>
Content-Language: en-US
From: Mikhail Paulyshka <me@mixaill.net>
In-Reply-To: <20250312124006.GCZ9GApgQQ49dO_BMW@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 3/12/25 3:40 PM, Borislav Petkov wrote:
> On Wed, Mar 12, 2025 at 03:31:28PM +0300, Mikhail Paulyshka wrote:
>> On the AMD Cyan Skillfish (Family 0x17 Model 0x47 Stepping 0x0), which
>> is a Zen2-based APU found on the AMD BC-250 board, there is a situation
>> where RDRAND works fine, but RDSEED generates FF. This leads to some
>> applications that use RDSEED to generate random numbers (such as
>> Qt and KDE) into a nearly unusable state.
>>
>> Although AMD has fixed the Zen2 RDRAND issues in 2019 with a microcode update,
>> no such update has been released for the Family 0x17 Model 0x47 core.
> What's the microcode level on that machine?
> dmesg | grep -i microcode [ 0.059689] [ T0] Zenbleed: please update your microcode for the most 
optimal fix [ 0.663746] [ T1] microcode: Current revision: 0x08407007
> Also, send
>
> cpuid -r

https://paste.debian.net/1362645




