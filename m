Return-Path: <linux-kernel+bounces-201046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE92E8FB8E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67815B2BD87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEDB146D6E;
	Tue,  4 Jun 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BIvwWegi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NFaNIAN2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5A53BE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517407; cv=none; b=ExEUuxEepCdAxrnoWa37LkwpxhIjD/gYgg/hjzKoPz0/nFbvu3Mibdd8eoLIs+sYY34V7KxsB2L/V014xCtiZRDIrTcv8HXojGttHGt6LjA/Uu59eajxtxGQBHysxKBf0PXaoZw1JS1zJuWVDqv8oGWRhZ4T+WPnQtuA4n8kozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517407; c=relaxed/simple;
	bh=k/qLKUrFXNR9X5ncu7ZzLByVbnqxCevGaXRBjnYGXgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FjVKsDLhrsvIuydOfWQW3HbcSC9bOs8v6vFwLGepfpQHMj9oTgW1KcxZyi/sfY7rISEn6Q3g5QtQs12EbW+bhWhh2b6UDAoa4oDv4PyclmEeGsk2lyAy9zS8agz4PEOMFGHHTFT+WL3zbAN03uTxWKvf86tiNJbBX4zOWPg9MTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BIvwWegi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NFaNIAN2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717517404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDitCF42fLHdt1Ig5HhwFq8CPx2Qx1QENuZVXfNm13Y=;
	b=BIvwWegi7CD+kZNJ9sTl+y7f/7MCPyDa1WKqUw4DEWQAnTfDKVmIohW0jHcIj4Y2I93xY9
	OBpBAVel/k624TguD5vxr97nwwdjJox9iaqeXx6+4HmI5wmaqLMNv6lpI1Yo/Hj0whSy/M
	bnUotbQp+hL/IPt7k95ePa0JBJ9HSLR0KNnbGqkPDHm9+vPdFFGre0URtFbFSb94AUAVX5
	fqgIaw74DO5DxHJJ5Js8uBTScRxdzD6sWiIOzJavlOPr5KSyjN6qjhaCNHkIwPQUYPoeWg
	4KG38oBtnqMJmukuHtR3gH4sYCYQ/SY6kAmiSi0Wpn9FTmeejMSSR2jo5YELPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717517404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDitCF42fLHdt1Ig5HhwFq8CPx2Qx1QENuZVXfNm13Y=;
	b=NFaNIAN2rWRNzsnQdgBI6XcMfwPbZMpA3kZxiUPFFCL/ZBtQMWHNOuKWU5sCs4S0hx1ndW
	th+uAWi3nkL1RrAA==
To: Will Deacon <will@kernel.org>
Cc: syzbot <syzbot+558f67d44ad7f098a3de@syzkaller.appspotmail.com>,
 anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, Catalin
 Marinas <catalin.marinas@arm.com>
Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in __hrtimer_run_queues
In-Reply-To: <20240604133448.GB20384@willie-the-truck>
References: <000000000000deb5250619f9b5f4@google.com> <87tti86gca.ffs@tglx>
 <20240604133448.GB20384@willie-the-truck>
Date: Tue, 04 Jun 2024 18:10:04 +0200
Message-ID: <87mso0665f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Will!

On Tue, Jun 04 2024 at 14:34, Will Deacon wrote:
> On Tue, Jun 04, 2024 at 02:29:57PM +0200, Thomas Gleixner wrote:
>> On Mon, Jun 03 2024 at 03:22, syzbot wrote:
>> > * 10:	f9400821 	ldr	x1, [x1, #16] <-- trapping instruction
>> 		while (node->rb_left)
>> 
>> > x2 : ff7000007f8cf8e8 x1 : 0000000000000080 x0 : 0000000000000080
>> 
>> which obviously crashes. Now the question is how does the original node
>> end up with node::rb_right == 0x80?
>> 
>> I doubt that this is a hrtimer or rbtree problem. It smells like random
>> data corruption caused by whatever. It might not even be an ARM64
>> specific issue though the C repro does not trigger on x86...
>> 
>> Handing it over to Catalin and Will.
>
> I suspect this is a duplicate of:
>
> https://lore.kernel.org/lkml/20240604110119.GA20284@willie-the-truck/
>
> and there's a fix queued in the -mm tree.

That looks very much so.

Thanks,

        tglx

