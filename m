Return-Path: <linux-kernel+bounces-440937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB429EC6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C19816737B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BCE1D31A5;
	Wed, 11 Dec 2024 08:14:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B26F42A95
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904855; cv=none; b=X70jtqYmuipdZMsz+f9Ql/HhIreP91F72Vp2ku+zCP37dYunAq+KDD3dQharhqwbPgPTgXn/Ht2oEoB2TgcqxdLVIYMfu4iVQATJ+ePeIFF1mNAz6Nc9oMwB2StGTm8upvgKtwd4NnQFzaV32A6/GXTwHmwSlhg5Sed4VCAyBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904855; c=relaxed/simple;
	bh=/JJp5QraSgq6Xjp6Qw5FDlW2f33Y6NlH8eFGS4xJ3/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lA2yYoGxLXsPMhH+KJ2TwOrj+miIrydEH3dfR8K1coXV73JQrVgYunRnzlXQvKCyEB5zEBsTHgQgT68zk36Fmqgc4h8tN/uBdQhzUNYDX8yXL37QLyOfkWKKOLsGpmwoW2RizfbcmtS1poQlChsU2uiTFN/5IeAm2vSLBB4TS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F2311063;
	Wed, 11 Dec 2024 00:14:40 -0800 (PST)
Received: from [10.57.70.51] (unknown [10.57.70.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16F3C3F720;
	Wed, 11 Dec 2024 00:14:09 -0800 (PST)
Message-ID: <490f7554-62eb-48a3-a45d-a65e68794b58@arm.com>
Date: Wed, 11 Dec 2024 09:14:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Remove problematic include in <asm/set_memory.h>
To: Christoph Hellwig <hch@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 dan.j.williams@intel.com, dave.hansen@linux.intel.com, david@redhat.com,
 jane.chu@oracle.com, osalvador@suse.de, tglx@linutronix.de
References: <20241210184610.2080727-1-kevin.brodsky@arm.com>
 <Z1kdQyHnPd0jgIgZ@infradead.org>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <Z1kdQyHnPd0jgIgZ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2024 06:04, Christoph Hellwig wrote:
> On Tue, Dec 10, 2024 at 06:46:06PM +0000, Kevin Brodsky wrote:
>> The need for this series arose from a completely unrelated series [1].
>> Long story short, that series causes <linux/mm.h> to include
>> <linux/set_memory.h>, which doesn't feel too unreasonable.
> It is entirely unreasoable. <linux/mm.h> is inclued just about
> everywhere and should not grow more fringe includes.

Understood, I did wonder about that. Then I suppose the best course of
action for the problematic patch in that other series [3] is to move
pagetable_{alloc,free} out of linux/mm.h.

- Kevin

[3]
https://lore.kernel.org/linux-hardening/20241206101110.1646108-11-kevin.brodsky@arm.com/

