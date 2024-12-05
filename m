Return-Path: <linux-kernel+bounces-433308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BF79E5643
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9D428164E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204CE1A8F80;
	Thu,  5 Dec 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UL/ChKsS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cas2wXUH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C67218840
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404364; cv=none; b=GzG0+QQ6YNahpUUIQV0ShTNzjLyZBoj5Js+fp/b/zHp94ffCajomEEvjQiXN63uRbtMcVMSB9HbszGRLaspcmWp3I+oGJt6xEQYK9jpgVo2psQSt3atUpI6TMoEpj7MgpAq/rr3V0qPZ4YGJesNseUp0fI5G26vYaMHofAAB7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404364; c=relaxed/simple;
	bh=zSAmUMikM9qyp2hwJeOchmUecjS3KRaaw3qokCCQvIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S554j4rcJBiJ5Lf3h8s1kkTXlLYSshteMVqBSaeV50daE/Ukxa9XP3Qdn+XRp1FhnKVd/pSAq7XB4RDWd/d4dlwF7XWFzNqQy33Ne8P03ko+qv0eMDbWI49YV7ESIlHGqhEmV2nWJDXNYcmd48lUASRp51EwHpBTZDp9mVl8zfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UL/ChKsS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cas2wXUH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733404360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wwZJaavYAts7b0KEi30IQ/HqLbi/kQzf73ZNMNUGUa8=;
	b=UL/ChKsSlIFDaowyD88bIOBwT+Gh7cKIruRWusTdh8WcwJvDYXLPC+bmTJMTfU0VxvOK5W
	y/WPH0mndhOqc6c3UMiNtpmcfgrpivDopfQ9ReqkTXP1g890p4RRK9QZVxi9m+WSMGnNa8
	odGSaSc1YmNzm41mQTOkpTFq7HZSkDCN5T2MKcL6tSh/C7QAw3YA7giAxCLdMh47GoLyKv
	0dD776A1AdVbrogwpYFrQjaoTyVD/1aYSxsUXmoNYcPy/9Zsi0aQxF279yOkZnG7RtYAsW
	moyZuLSWmHJPL5DZyY3jcFE3+L9DWHgt6G9uKX5wrgoI+YOZ2NJjaEsINzNDyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733404360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wwZJaavYAts7b0KEi30IQ/HqLbi/kQzf73ZNMNUGUa8=;
	b=cas2wXUHxwQknTqhaVHU4H4YBmOALDsseHoMBnfBZZw3FHLLkuYr2E7Jn1o3giUav+ykEm
	9EB7t9yd5ZTJxIDQ==
To: Waiman Long <llong@redhat.com>, Waiman Long <llong@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use
 it in nmi_shootdown_cpus()
In-Reply-To: <9765a61a-e832-4491-af02-97b8736411ef@redhat.com>
References: <20241203150732.182065-1-longman@redhat.com>
 <87h67jsif0.ffs@tglx> <7aa93137-4b5e-474f-a99c-47acffdf71a3@redhat.com>
 <87zflbqqar.ffs@tglx> <59b254dc-acf6-4114-b6b4-a7ae517bfa06@redhat.com>
 <9765a61a-e832-4491-af02-97b8736411ef@redhat.com>
Date: Thu, 05 Dec 2024 14:12:20 +0100
Message-ID: <87r06mqnnv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 04 2024 at 23:01, Waiman Long wrote:
> On 12/4/24 2:28 PM, Waiman Long wrote:
>>> I'm not convinced that this should be used as a general mechanism. It's
>>> for emergency situations and that's where it stops. If the thing
>>> returns, it's a bug IMO.
>>
>> OK, I am fine with that. I will put a BUG_ON() after that in the next 
>> version.
>
> Actually, crash_nmi_callback() can return in the case of the crashing 
> CPUs, though all the other CPUs will not return once called. So I 
> believe the current form is correct. I will update the comment to 
> reflect that.

Why would you continue servicing the NMI on a CPU which just crashed?

