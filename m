Return-Path: <linux-kernel+bounces-270922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF094471A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F27B23EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AD416EC1B;
	Thu,  1 Aug 2024 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NS4aLaVG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Ry0wp/z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E123161326
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502422; cv=none; b=ALzVZbxM4p4rWR5NUDVZTum1XK3pamsfp9galoR8UF1CijkxnQyjoUhVWbTt1LU4FNRQEEiJV0JL7cBd8zy1+v/Hcb7Gd2c5rE8kf+F8cA8HGVdbde4kKz38FqJOtcRbT+KKl2cTQPYZAXgdqCqffKVqzjDjopNEmGB+GA3ypuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502422; c=relaxed/simple;
	bh=/KOS6FtXTMxJbMhlV3mr5UkCQVEkk1vsr+779WxmaOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IfoGx/OShRPjMa0MvfIk7uuCbxIb5IiR2QuICXEtWwQWDMtI+H7pNd1NzxHeV5a0pcZexI8eGTMfBXA7qnJGKhZQIL/jBtjGsfMysW8VFg1z03Ql7ct5217cRbPsmnIfYH6FPXfLPjm8j2ZswS703fCPiLeE9/AWPIvyMIQ6NUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NS4aLaVG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Ry0wp/z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722502419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KOS6FtXTMxJbMhlV3mr5UkCQVEkk1vsr+779WxmaOY=;
	b=NS4aLaVGOqiTa9A+pQXIlbHYnh0NQ5YqzVEAy0Xda+5es5B/ln9PP4Q6X5kFmKqa4qnSDw
	C92xVkpjbOwjh+xJ1kw+oMYGO4r3inOtQuFBXVOHOUDAWuI2T8ib3E4u5QsGpocN2/gjGN
	aJnsIj5rh77JIfb02xn5HWZWj271/0Lxsreee/tR34vWPuGFFaOA80oz0ROEYj0eIqjnn7
	uqO5QFryHl41mzL8iYZqpUGYNquWVA3xlHhzXrnBX8RQxbBPeRFzdEFI/ttT0ZjXKpMTci
	MU0wN+y7yT8um+JqGApRZgb2H7WwQGfDJnpSpaOYIjSZ23fJ9KkfzNmVWY6ZWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722502419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KOS6FtXTMxJbMhlV3mr5UkCQVEkk1vsr+779WxmaOY=;
	b=9Ry0wp/z5NuPtDoklJgYtMZMEkvzNvc1M4cIdLuY1D/g9/SEkBj/alDwUNzMeBSanBhiYn
	cUxjsQ9B7cFJ8WDA==
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, pengfei.xu@intel.com
Subject: Re: [Syzkaller & bisect] There is kernel BUG in __jump_label_patch
 in v6.11-rc1
In-Reply-To: <ZqrpoHTJZBA7TeGO@xpf.sh.intel.com>
References: <ZqrpoHTJZBA7TeGO@xpf.sh.intel.com>
Date: Thu, 01 Aug 2024 10:53:38 +0200
Message-ID: <877cd04oa5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 01 2024 at 09:49, Pengfei Xu wrote:
> There is kernel BUG in __jump_label_patch in v6.11-rc1.
> Found the first bad commit is:
> 83ab38ef0a0b jump_label: Fix concurrency issues in static_key_slow_dec()

Known problem, but thanks for reporting.

