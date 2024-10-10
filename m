Return-Path: <linux-kernel+bounces-359711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264C7998F67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE201F25CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BD21CEADC;
	Thu, 10 Oct 2024 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EiAtuRgr"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6D1CEAD1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583630; cv=none; b=i5bxd6GMcDn7tcYiH5sl7EruzQ1ygp1LwOErC40G3ja00KjQBShyzz6j6Yb0gZ37hM4K5SetRf78yqtWEjN/FQFizQI+9kTJSGR5Mg9DOYXSYEbwEuoELeXC0tpvg6n77HmYBdgfJxn8k8Jrwj2/1vJywYcb/FNkqsqz9Vh0WSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583630; c=relaxed/simple;
	bh=5Wrswp3HTHY9h9ggolwU27HTd3C3W+niiG0CzhVsSmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Og3Qum+eKitH8skzsurkFXyXDexwOIOPIOxS38q0wVNB6vGpug2AggQf+pwbVIwvUFDaWa8iS7cCdeMavB7nnmEehuF7IOWjGfpmFNrksqxqxoPRFUfQg1x+/7qF24OPLtc5ZwqC2OUGqxQsd4JAmiZP7KQEXFtBmHummLPBXhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EiAtuRgr; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tPB2gynU6TEMZoA70tNu1Ldu8HHpDnHQJdHzUIp9NlQ=; b=EiAtuRgriOt5Nv5kr66vrE1/j1
	Xdigf9xxEi6ta/Fp5Dn1wPv9O6Tw+XHQACCo4LfMh/Ab5PiQNygz+81KoUwpIW9G270pp3cteUZti
	bR/zmh1lextmfkAy4kQuEtXwHFC0XUM9UzE7+LLtstXEANG11RiiEY8gQllIur8wPw6Ms87TxM9GC
	OhT9bqGkJ5ODaBS/SXJk9ej6qFvUDQbVx0qlCqAMHNgKCTe1Z9U56EJNAdI7v+NBJodcsVP62Trlk
	/8/5wp1ID+acdg/HdFjGgcbCmPyKemuq+3eCsKob++YLoBqbuLUZl9RbX2/FCAeM5rBTIAb5wP0aL
	W/YltlaQ==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1syxYz-007QVg-Lb; Thu, 10 Oct 2024 20:07:01 +0200
Message-ID: <80c4060f-aea7-4620-afec-feacb234ee22@igalia.com>
Date: Thu, 10 Oct 2024 15:06:58 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] futex: Use atomic64_try_cmpxchg_relaxed() in
 get_inode_sequence_number()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20241010071023.21913-1-ubizjak@gmail.com>
 <20241010071023.21913-2-ubizjak@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241010071023.21913-2-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 10/10/2024 04:10, Uros Bizjak escreveu:
> Optimize get_inode_sequence_number() to use simpler and faster:
> 
>    !atomic64_try_cmpxchg_relaxed(*ptr, &old, new)
> 
> instead of:
> 
>    atomic64_cmpxchg relaxed(*ptr, old, new) != old
> 
> The x86 CMPXCHG instruction returns success in ZF flag, so
> this change saves a compare after cmpxchg. The generated
> code improves from:
> 
>   3da:	31 c0                	xor    %eax,%eax
>   3dc:	f0 48 0f b1 8a 38 01 	lock cmpxchg %rcx,0x138(%rdx)
>   3e3:	00 00
>   3e5:	48 85 c0             	test   %rax,%rax
>   3e8:	48 0f 44 c1          	cmove  %rcx,%rax
> 
> to:
> 
>   3da:	31 c0                	xor    %eax,%eax
>   3dc:	f0 48 0f b1 8a 38 01 	lock cmpxchg %rcx,0x138(%rdx)
>   3e3:	00 00
>   3e5:	48 0f 44 c1          	cmove  %rcx,%rax
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: "André Almeida" <andrealmeid@igalia.com>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

