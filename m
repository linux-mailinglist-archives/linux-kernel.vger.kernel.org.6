Return-Path: <linux-kernel+bounces-285272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA6950B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C978E1C20F07
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC11A2579;
	Tue, 13 Aug 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bU6KibrZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Yk5DG2t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB718C3D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570387; cv=none; b=JfSmjq3HvxuosxFMbQrtEIswB6KJewPnWO7eS4GVHQE3UTKtZT+jPl13CIdVC0O3useF6Bs/GK7al+hAKUmeXkxVT1Tagv9WBHjJvXD7ndqtZTdLI5DyBeEzv0kfpfaDXZ8vwInIczDwxXD4HB9TZUdfoVk8+0Wh6bW68r2N05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570387; c=relaxed/simple;
	bh=MIlrSk7SgXvMrIEjjWC8Je4dhxIyuPX/L2G7QvgIAjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WUY5DVBZHskSBstaL311EKjiur7oTSDQXu2KbxPy7L7w0Zhut4+klmcRxgl3xRzqbsuUGmgLWVSgnNregw3y4SrpxPgNli5sdb/MQtnP2ddaesP5oKfIHXk7cvUNQF+499OctrGqNVClM8hkUngXjoLLBlEn9xKuUtIQH8EInFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bU6KibrZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Yk5DG2t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723570380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCeddw978sFZNifYTaABplpibXMqPeWXWLsqy4nR1LI=;
	b=bU6KibrZLcT+dRuYXHs59WqGHWD1Bxu/QMm/LxiTzJ0pxmY+hQeVs+9cURfpbR96ye6AIT
	65qd69QPlFcb/z9j9Od9oER7QrnsE6hbSWZamyFR3bASIa97MxKksfSVBkLu8bM2cQIJsP
	GQUxim5ytCRBO0mqpmyJtLGcO+vFVzBBuDoL79C8gw4famC43uyyY5/6QCQSGRgcMQRHkC
	UOQQCHx1B45yKSPFRL3UXzScRYVYagN9Fu0iOXtr1/dVG+NdZM3glsmZ3CR/S1b/p6d7b0
	2ztzBe1mXcYN3ehbc+fMWQbjWOXO0qPOmUtQJ/tkw8dT0K3+DWL31GeBTK+0FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723570380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCeddw978sFZNifYTaABplpibXMqPeWXWLsqy4nR1LI=;
	b=+Yk5DG2tsARz6KagXaDT8SHmXod7ExkoaeHVtXDkf4s7oVQ88JjcpR32sUQg64JVGVoZEu
	fGf0IbyuYBE3TuCg==
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 x86@kernel.org, qiuxu.zhuo@intel.com
Subject: Re: [GIT pull] x86/urgent for v6.11-rc3
In-Reply-To: <20240813031522.4544-1-qiuxu.zhuo@intel.com>
References: <87le12rw26.ffs@tglx> <20240813031522.4544-1-qiuxu.zhuo@intel.com>
Date: Tue, 13 Aug 2024 19:33:00 +0200
Message-ID: <87o75wpbub.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 13 2024 at 11:15, Qiuxu Zhuo wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> On Sun, Aug 11 2024 at 11:07, Linus Torvalds wrote:
>> > I doubt it actually matters, since I think this all is fundamentally
>> > just in the slow-path, so the "do a branch or a no-op" is likely
>> > entirely in the noise even if I followed the code right. But it looked
>> > off to me.
>> 
>> It is off and yes it won't matter much in the slowpath maze.
>
> static_branch_unlikely() matches that 'virt_spin_lock_key' is set to false 
> in default after the commit,
>
>   e639222a5119 ("x86/paravirt: Fix incorrect virt spinlock setting on bare metal")
>   
> although it offers little performance benefit since it is in the slow path.
>
> Thomas, do you think it's worth making a patch to convert static_branch_likely()
> to static_branch_unlikely() for this check, as suggested by Linus?
> If so, I can assist with this.

Sure, but I'm not so sure that it actually matters and makes a
measurable difference.

Thanks,

        tglx

