Return-Path: <linux-kernel+bounces-376107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA639AA028
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43555B22808
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C419AA46;
	Tue, 22 Oct 2024 10:37:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E5B6F066
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593469; cv=none; b=fimtVP965a+1AxMaugs3zLjSBnBsLHiuLMd6rB4ngkYXqIvbxmymn3rzxQYlqSnulasKt2q1qcpaMU76Hx/5m//YBZ1EQgNNdh0coe+obC8XW+VqXcpW9Sv/JNU92Vk38hwwv4IpvTUvcFZFPpruix3sXumU64N/L0/nCOZxuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593469; c=relaxed/simple;
	bh=5luiPj52XH5zPR3cfTYWytGhwKxtEsVCaMWr1xu2igA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T89yNAkjU35ZvUHtF9OOABIn2sKwVWp6T0oAkS10Jl4642UtkKvaN44fY34j6lY3yK/OG8+huREQcyDjqwqcS6RCw8QLLeRul8lpwCfJLY7lF11zL1o9e6G2Bi4euVkarTsFCQSpcbt25RPWXoZFBef3/Wg+hho9onm0MDEQXFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C293497;
	Tue, 22 Oct 2024 03:38:16 -0700 (PDT)
Received: from [10.57.65.71] (unknown [10.57.65.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9405E3F71E;
	Tue, 22 Oct 2024 03:37:45 -0700 (PDT)
Message-ID: <8e34dbe6-ed7c-48bb-8029-db4c35a17ad0@arm.com>
Date: Tue, 22 Oct 2024 11:37:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: NOMMU: Fix exc_ret for stack frame type
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241013132520.2848-1-jszhang@kernel.org>
 <87ba9595-6229-4a79-aa65-d76567ef708e@arm.com> <Zw2xC39-YkNlL6qT@xhacker>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <Zw2xC39-YkNlL6qT@xhacker>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 01:02, Jisheng Zhang wrote:
> On Mon, Oct 14, 2024 at 10:54:00AM +0100, Vladimir Murzin wrote:
>> On 10/13/24 14:25, Jisheng Zhang wrote:
>>> commit 72cd4064fcca ("ARM: 8830/1: NOMMU: Toggle only bits in
>>> EXC_RETURN we are really care of") only sets BIT[3] for Thread mode
>>> and BIT[2] for PSP, it leaves BIT[4] untouched. But there's such a
>>> case: the pre-linux env makes use of FPU then the BIT[4] in 'lr' is
>>> cleared, this brings an umatch issue since the NOMMU kernel doesn't
>> Can pre-linux env disable FPU before passing control to kernel (which
>> is, as correctly pointed, doesn't know how to use FPU)?
> IIRC, I did a experiment like this by clearing the SCB CPACR related
> bits, but the stack frame type is still not correct. I searched in the
> armv8m arm or cortex-mN's TRM I didn't find the relation between the
> returned "lr" and the pre FPU usage.
> 
> What's more, IMHO, kernel needs to use the correct exc_ret no matter
> the pre-linux env does, I.E if kernel/userspace supports FPU, then
> clear BIT[4]; if no, set BIT[4].
> 
> PS: this is a regression: before the commit, the have-used-fpu pre-linux
> env + linux nommu combination works; after the commit, it fails to
> execute the init due to wrong stack frame type.
> 
> Thanks
> 

Fair enough.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Please, upload the patch in RMK's patch system [1]

[1] https://www.arm.linux.org.uk/developer/patches/


Vladimir

