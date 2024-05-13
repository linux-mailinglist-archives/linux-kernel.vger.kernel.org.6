Return-Path: <linux-kernel+bounces-178146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0338C49AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03BB6B227B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3497F84D07;
	Mon, 13 May 2024 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="UrytV0QK"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383B134BC
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715639994; cv=none; b=J6VMRVJeqsEl93XQx9H8p5H+pF8NzDPIxJtUgqhM67FGMJb1DvbThr9+ETQhtHLD5wjBf+LKwqJ829QirH1DHp7xHOpF7I71wFGgtd1fVkgwKD3GOQ/3fSqBPYRkSg6LaqOXcYHKj8sSkjHbHPL1/S54pmZqDaBe84xJcmVGp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715639994; c=relaxed/simple;
	bh=BSN7Xy3cGgTmiOR56jzKBdth2uyQ80MxzKLMljOx1AM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VHZdisR/LZx/lqgekymNyK5QbnZbM1gwzc0jIiVc+eaLi10+1PwAoYgnJiN5tVbZiZeQB6CEygf4PO/VVjmM9fM+EhO9pK6F0IYOuSBTpsCe/ASUnukHIJjES4V2M50bj5wQRhlF1LjzjDgaT55kM8LnSp81f76Em0nWU6Kz/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=UrytV0QK; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1715639986;
	bh=BSN7Xy3cGgTmiOR56jzKBdth2uyQ80MxzKLMljOx1AM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UrytV0QKWFlEdF+Hn8ySUdjdNjc7JvrK9YOERxx7rGXk68GXZs059H6agzVTj6mLr
	 rrtXg3p5M0ENyH6WhUATfOY/fJecOYmF++Lx33NipqmDGsV1q+L+lg0gUa0BCVFe6S
	 hIGrkMC/UdNWH9I5QvKGeYFWGtRx6ys4E8cGNy48=
Received: by gentwo.org (Postfix, from userid 1003)
	id AE2A740A8F; Mon, 13 May 2024 15:39:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id AD19E4093E;
	Mon, 13 May 2024 15:39:46 -0700 (PDT)
Date: Mon, 13 May 2024 15:39:46 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
cc: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com, 
    will@kernel.org, scott@os.amperecomputing.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW
 instructions
In-Reply-To: <ea88e906-3219-48c0-884c-3bb13ca0d18f@arm.com>
Message-ID: <ec207271-623a-f2c0-0adf-7ecbc47aa99b@gentwo.org>
References: <20240507223558.3039562-1-yang@os.amperecomputing.com> <c9c3c0d5-bb61-4eed-8b89-b0341a2c6f5c@arm.com> <c1ba9ba3-b0d6-4c6c-d628-614751d737c2@gentwo.org> <ea88e906-3219-48c0-884c-3bb13ca0d18f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 9 May 2024, Anshuman Khandual wrote:

>
>>> Okay, I was about to ask, but is not calling get_user() for all data
>>> read page faults increase the cost for a hot code path in general for
>>> some potential savings for a very specific use case. Not sure if that
>>> is worth the trade-off.
>>
>> The instruction is cache hot since it must be present in the cpu cache for the fault. So the overhead is minimal.
>>
>
> But could not a pagefault_disable()-enable() window prevent concurring
> page faults for the current process thus degrading its performance.

The cpu is already executing a fault handler in kernel space. There cannot 
be an additional user space fault since we do not execute that code 
currently.



