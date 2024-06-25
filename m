Return-Path: <linux-kernel+bounces-229366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66FC916EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56CF1C222E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043D176AA7;
	Tue, 25 Jun 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S1AyOMWM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VgUhfaEo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E011185
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335517; cv=none; b=YFfZF4Uh3gOyrcCkcDBU3Aa85THjVN+yf2zZLDm4Dmx6TJ1+9zSBaWTi9uKzukEq7Tod1O+swyn2Jjfou/sbMI6bFiEQcgm2FuylR1/AT8J+wTbIxHWFSuGrll6OsZAz2kBRGc4VC0n/95XJ+cdHBuVIXOS6LRU1aKnDTX4L7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335517; c=relaxed/simple;
	bh=CUatgzpieAiC/BLey6y2cezXTW2PlmdZL7qBTLhO/fU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WV+OHzpFiIRxxBw4v9u84VptnA5JQYtpF3Ip3FnPnO0p8ti5wMcTahhjGC7k2EGtwJDVj4QTm/JT0CsKaftHPYcZ6ZRPi5vzpaIcCZquH4vGSTep/KnVt13GvYIzWJH67ZVV053AvL28ncyDpCJic3BjB548+kM2s8L97Fl8FMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S1AyOMWM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VgUhfaEo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719335514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzejeiWt6Frhpn2cyv9NIwCZIOnBLRqlO9ZQOTPhD3o=;
	b=S1AyOMWM6cyZlm9pfgYzZkr6/GBihW1JWayK+n8r5DpHTfSVTtbvq/VIx3SrrTSp4OaWK3
	+yJfGNfbODWRTLxBUomiNbe88wxvsrC7d9c09Wd4ozNtFlmnWLLK7n9UJoma9dl9u8bgcW
	h4tCuz6hhdR1JLoNSx5eQX+pScI1i5l4QGKKp94niroWrien02jFWyJeF8Um5T6iKdWEEV
	fXiqZM1KfBDs8yZubRhw6grAUV8nrx50ehzJ19NJz+qQ+kavooccwslHqAFEMdgQQu47dP
	BWcHKgl9EzFFqpYft9SQsmzqgGJdl73Ejug7RWA2d9nX2kS3yRvoHTdxXsarnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719335514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzejeiWt6Frhpn2cyv9NIwCZIOnBLRqlO9ZQOTPhD3o=;
	b=VgUhfaEo+leIn2NrwOl8I/9GRGVrD9bNHtZsf9V0iMtjYOyKjf8AM0nKPu4NzQYAwvKtJK
	/J4o9oK1RqKb63Cw==
To: "Li, Xin3" <xin3.li@intel.com>, Xin Li <xin@zytor.com>, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H.
 Peter
 Anvin" <hpa@zytor.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: RE: [PATCH 1/2] x86/fred: Always install system interrupt handler
 into IDT
In-Reply-To: <SA1PR11MB6734FA6BBDD1BCD3086A51FCA8D52@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
 <2f632ef59c8c9cc27c3702bc2d286496ed298d65.1718972598.git.houwenlong.hwl@antgroup.com>
 <dca1635b-1e08-4dbb-9dbb-335cbdcf9b9d@zytor.com> <87jzid5hmb.ffs@tglx>
 <49c53a1a-55b2-441e-8ec2-1a2d87a3ccc4@zytor.com> <871q4l5542.ffs@tglx>
 <SA1PR11MB6734FA6BBDD1BCD3086A51FCA8D52@SA1PR11MB6734.namprd11.prod.outlook.com>
Date: Tue, 25 Jun 2024 19:11:54 +0200
Message-ID: <87y16t3q1x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 25 2024 at 17:08, Li, Xin3 wrote:
>> >>> And please put a comment here to explain why this is unconditionally
>> >>> done for IDT.
>> >>
>> >> Wait. If we need this during early boot, then why don't we enable
>> >> FRED earlier?
>> >
>> > Unconditionally call idt_install_sysvec() is still needed, right?
>> 
>> Not when we enable FRED early enough.
>> 
>
> What if FRED is disabled in the kernel command line?
>
> "fred=off" gets parsed in a later stage of the kernel initialization sequence.

You can parse it early on. There are examples for that like encryption
and other things which need to be decided way before the real parsing
happens.

Thanks,

        tglx

