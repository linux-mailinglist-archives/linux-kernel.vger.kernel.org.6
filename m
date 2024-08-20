Return-Path: <linux-kernel+bounces-294142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A59589E9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FFF9B236F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0721922FF;
	Tue, 20 Aug 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+i2ezUJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6xWpS0XX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F818E756
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164688; cv=none; b=U59ALI457TqXvqcBS/O5NgPJjAbkafaoXwQaN+2WkB4AeTzt5oMZxRkUqprK1g48gJIqUi0Kp+cvbLCE078/aZUfanU77P2N1ci+VQ4LyLeHujR6fpHlrUhYVFDIZZmjd+lXuZnySu+jGq7amGjGtxe1BMxu3NuDS4chYjQQdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164688; c=relaxed/simple;
	bh=nODFqS6CN0mWIBN8ERVZa/btlM1ABw8JXeLY4aldHFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DhSMp33fZeBsDiJQWbEQPOdr0+H1U47sgPfL6XoWclhX5f78cYYCrXsbEeLnwJlVln7cJi9+nb/ilZX6WUtP/I2t4A8smt7U4+G3VM0b/AcKY+BpVSrVlsERi+jpRVUxgpd4d95T3H16NqZttRBAquq9dfp9WlNiE9+mueYsgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S+i2ezUJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6xWpS0XX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724164676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=byeYWXj6yolKWlKTfBi1/ykakpCaZGf7Apb0T8ezLhs=;
	b=S+i2ezUJPXnPW51loEpwdzTuwXgAg53vhteEz8aGmNQDWIBsiN6CwpZFVc/UfL1IrybqVx
	mRbnS9n4RNQ1oMKq0XYNAe6zrFntn4BuE7wiVjlgyjF/D1ZVt/uyOr1lQzJSVHsUsyqCrP
	oYKFc5bs22GgiP+W4bOr4Hq6u42IzUqGPAyq8/wF2W3dBF29U+kXw0cl81OZ6B5VHTHygl
	uRJffUND7IJx7gqdo1A2hniJhAIuNekyv0pcM2MSN1qy2Z9fZkpxVolhvt5cD/N+kkRJMU
	644HFzjyTjaJIBNoC4ZawyWDPujmYnprpWzST9qrad9LkwMuz+IdNnyfkIv0ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724164676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=byeYWXj6yolKWlKTfBi1/ykakpCaZGf7Apb0T8ezLhs=;
	b=6xWpS0XXe4uIPdWYbLDTogHrn1vZ4iAUgkPrs6+Y/ZEYk+s9aqLhf8Y13FLFkJoMK0Z0mc
	C+xMPHPkuw8fd4AQ==
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, Max Ramanouski <max8rr8@gmail.com>, Alistair Popple
 <apopple@nvidia.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook
 <kees@kernel.org>, linux-mm@kvack.org, oliver.sang@intel.com
Subject: Re: [tip:x86/urgent] [x86/kaslr]  dfb3911c36:
 kernel_BUG_at_arch/x86/mm/physaddr.c
In-Reply-To: <877ccbl840.ffs@tglx>
References: <202408201529.498d4d4d-lkp@intel.com> <877ccbl840.ffs@tglx>
Date: Tue, 20 Aug 2024 16:37:56 +0200
Message-ID: <87seuzjm4b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 20 2024 at 13:57, Thomas Gleixner wrote:
> On Tue, Aug 20 2024 at 15:16, kernel test robot wrote:
>  		/*
>  		 * KASLR trims the maximum possible size of the
>  		 * direct-map. Update the physmem_end boundary.
> +		 * No rounding required as the region starts
> +		 * PUD aligned and size is in units of TB.
>  		 */
>  		if (kaslr_regions[i].end)
> -			*kaslr_regions[i].end = __pa(vaddr) - 1;
> +			*kaslr_regions[i].end = __pa_nodebug(vaddr - 1);
> +
> +		/* Add a minimum padding based on randomization alignment. */
> +		vaddr = round_up(vaddr + 1, PUD_SIZE);

Due to the guaranteed PUD alignment of vaddr this round_up() is actually
pointless and just should be

		vaddr += PUD_SIZE;

No?

Thanks,

        tglx



