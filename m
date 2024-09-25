Return-Path: <linux-kernel+bounces-339610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9DC9867C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE31128529D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D2F1465B3;
	Wed, 25 Sep 2024 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F845A0rO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546118637
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727297227; cv=none; b=opMtimkpqYmGwocpbb++1K2y+TADqC7G10X7TKSySu2a1+SfJ98Nd274RApEb/fB4HiHTqLqU9MpQoJcFHPPVz2sgqYqrTfPeki3DSafZ1M6iyo7lhfXiPrKEklGHkhFgdcZ0gPmErKDRBb/58LziuDK1oyi/OqT00P36HLHKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727297227; c=relaxed/simple;
	bh=WD+jMqvgC8MnHU3Lhm2a0gl+Uu82ABZjkjg4bL/0m3I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nWvcUemEFY6NsA9YWLz3SdLP94hdQQ0QN/1IvrvnVo8lLBvURXx0obw6XCciRL6rVNHfC3R/cb1p+Gm11xb1ZlkApEW+V/Wu/cKlj6N5o2ZsD9jXb+bmu9nnuigcrPvgA6oDI20iIofgJpExlJ0q5xSgN0Az5c5wg1lwZFVYMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F845A0rO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD996C4CEC3;
	Wed, 25 Sep 2024 20:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727297227;
	bh=WD+jMqvgC8MnHU3Lhm2a0gl+Uu82ABZjkjg4bL/0m3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F845A0rOvyN/U53R+uSQ/BHfMMCq1WP5EVLnSVqkUXzMRjWB5Bkc9opYk7w9HiIvc
	 GPNNW505gW7LX88jmEOe72y9/UmSrNotcBN0dD/8ypblMvFZfyNdIkCBYAmunc5j3F
	 PIuEAAi7CjqVZZOprZZmcohl0+k5QJsn2D35gb9I=
Date: Wed, 25 Sep 2024 13:47:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Uladzislau Rezki <urezki@gmail.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Adrian Huang
 <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] kasan, vmalloc: avoid lock contention when
 depopulating vmalloc
Message-Id: <20240925134706.2a0c2717a41a338d938581ff@linux-foundation.org>
In-Reply-To: <20240925134732.24431-1-ahuang12@lenovo.com>
References: <20240925134732.24431-1-ahuang12@lenovo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Sep 2024 21:47:32 +0800 Adrian Huang <adrianhuang0701@gmail.com> wrote:

>
> ...
>
> From: Adrian Huang <ahuang12@lenovo.com>
> After re-visiting code path about setting the kasan ptep (pte pointer),
> it's unlikely that a kasan ptep is set and cleared simultaneously by
> different CPUs. So, use ptep_get_and_clear() to get rid of the spinlock
> operation.

"unlikely" isn't particularly comforting.  We'd prefer to never corrupt
pte's!

I'm suspecting we need a more thorough solution here.

btw, for a lame fix, did you try moving the spin_lock() into
kasan_release_vmalloc(), around the apply_to_existing_page_range()
call?  That would at least reduce locking frequency a lot.  Some
mitigation might be needed to avoid excessive hold times.



