Return-Path: <linux-kernel+bounces-560980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCFEA60BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F0F17EDA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586451C7007;
	Fri, 14 Mar 2025 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b="b5GPxC5t"
Received: from mail.mixaill.net (mail.mixaill.net [144.76.234.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1991A8401
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.234.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941638; cv=none; b=U6DHVpkkaRy3tE3LyS/2VMaYpm05coc6N1ndhBZjrZr6e9EYje+sTc9/DGohiektMkk10uH1SDZGJK6aMu+mrQq6LqvuSX1RzrU9EbCAUV9t2ouRq9xlLen0gMixvOq5A/tlP4oKf/KoHC9yGIpK3LZfZ2drtvI7+JMpjX+yL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941638; c=relaxed/simple;
	bh=ymZJE5zAaKC5pDreT85G+3DnxIxN5wwiQ8dIrrWayP4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IMlNmMb8V/WX9mHxlr3yEN9AVHlsQzgFstv6RBvi6a3ndrkuROzI/ExEgUkzuQOuuDgBfhy+xuHzizU3TlRY4RClEzrZRx669t9NavfMx/N87OrMq/shR6jz3n57IOMlzWW/M4IWnl2e/GRWkrM3soi3cxfp7z3nrUiZMaID2AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net; spf=pass smtp.mailfrom=mixaill.net; dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b=b5GPxC5t; arc=none smtp.client-ip=144.76.234.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mixaill.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E60E46CB4E;
	Fri, 14 Mar 2025 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mixaill.net; s=dkim;
	t=1741941634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=tt/+Z53CFv+48F7kyaZtu0b6hI11nI+nv/7Uk8SctiQ=;
	b=b5GPxC5t5dMGhUdveHCgwIr2WIC/IAlZXJzGh5YnKXo4lCPjfSQBMKCoKL/kkcDfCflz28
	+Cvi1gRCoTCcoTft4HlKQQzVhpxx3BGSwslYNzvEJXVrLmXmMy8EQCl6l7Rfai1pCSRSDj
	liJ8iEBtVEPpMhW1eI/7Mo5RlZz75lpzaSmBclmrW30s7zp+A8HCaLbwZL2GXrU/Uv5/CO
	y0ut88SEqlogOJGSZ3ThCg/XCryi1ra86gUEUEeFH3o/whT/DVF6a5OktXJVdKP8OKIYyK
	Sl/dZRnLgRP5XeTAUImRFgx9CSirOaRmR01aiiJi/rPOgylyBkFZ/gHVo0IwtQ==
Message-ID: <d9fbfeb3-a0dc-4903-8e75-bf384260e6d0@mixaill.net>
Date: Fri, 14 Mar 2025 11:40:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] x86/rdrand: implement sanity check for RDSEED
From: Mikhail Paulyshka <me@mixaill.net>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20250312123130.8290-1-me@mixaill.net>
 <20250312124006.GCZ9GApgQQ49dO_BMW@fat_crate.local>
 <10f010ca-b79f-4886-ba18-3013560905b2@mixaill.net>
Content-Language: en-US
In-Reply-To: <10f010ca-b79f-4886-ba18-3013560905b2@mixaill.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 3/12/25 4:17 PM, Mikhail Paulyshka wrote:
> On 3/12/25 3:40 PM, Borislav Petkov wrote:
>> On Wed, Mar 12, 2025 at 03:31:28PM +0300, Mikhail Paulyshka wrote:
>>> On the AMD Cyan Skillfish (Family 0x17 Model 0x47 Stepping 0x0), which
>>> is a Zen2-based APU found on the AMD BC-250 board, there is a situation
>>> where RDRAND works fine, but RDSEED generates FF. This leads to some
>>> applications that use RDSEED to generate random numbers (such as
>>> Qt and KDE) into a nearly unusable state.
>>>
>>> Although AMD has fixed the Zen2 RDRAND issues in 2019 with a 
>>> microcode update,
>>> no such update has been released for the Family 0x17 Model 0x47 core.
>> What's the microcode level on that machine?
>> dmesg | grep -i microcode [ 0.059689] [ T0] Zenbleed: please update 
>> your microcode for the most 
> optimal fix [ 0.663746] [ T1] microcode: Current revision: 0x08407007
>> Also, send
>>
>> cpuid -r
>
> https://paste.debian.net/1362645
>
Link expired. Permanent link: 
https://mixaill.net/linux-kernel-lists/bc250_log_1.txt

