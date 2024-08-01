Return-Path: <linux-kernel+bounces-271506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF5A944F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB03B1C23069
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A4D1AE87B;
	Thu,  1 Aug 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YKbKC4fJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8w4TCGhM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8519F48D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526127; cv=none; b=XimJQ1sXzT27MH5gXTrorvo9f34JeXLSWMIsT8t8mLW4njxUi2+e7X+Yb7QpJ1hRSddhMBkiqWIC6FXI01XtNPV+N2Kwf7UkQ5Q7c9MmnuaJO+NvpR0H7+c6GYFHL/1xTXdb9mvqDT163ca3un8BYKW23TaPRkbG6UGTmmjPH/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526127; c=relaxed/simple;
	bh=49/WMBsPjnKTpfp0dXsLbwNli6+OQl4a0z6rQ3OdGEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iKsS1frU2S6eD1zAld8h+L+96OmHDNO1XSQ1vMaSINyafScXUs+IOccANi3NfpQjTlWfDdWAYspXrqZVDfu1wb8kRaevaNeuqNE6Juo9/utdqdVHtmhhZpwwxgmXDpcOn2dy49E9ilOEIt0Gq3J2tswXp/ishy8URq9Z+ZTgygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YKbKC4fJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8w4TCGhM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 1 Aug 2024 17:28:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722526118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1fkaG1f8lTsaLbUwdzOTX3astMr3rS1HhR0Oy5cox4c=;
	b=YKbKC4fJt3mqyfiO9b6JMsFNq++lF1hqEd2QsBRQuKy3ERtK+MAKgpJDAoo6ibnWaGmP6n
	i5oerLRIR/icXL6x4j6ri4gu0dq7mubLT2ti6ba+tkgmOKB8NHJCAjqR47sSwuScMySpNA
	xKEEvu8tlKHeWY81i6SEenk6hfZXBnq/fh+VDR9POjBaX+FoDGfgCxHJlSdTThL/X/sTMc
	Ohd5JG1AJweaAKdmmw75vHQ3p2r3+FoIZXxQnblZPaSCDhEHmC3y6ajrpJ2Uq7dDNTVPmV
	teIr1lUEAi7gXMfr6K4obccd0dat/g31Px7BV77uAJcaDq6lTzk9scQVXmbnFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722526118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1fkaG1f8lTsaLbUwdzOTX3astMr3rS1HhR0Oy5cox4c=;
	b=8w4TCGhMGXrA1UMuymzX3qFkXn7nvx/BZrePETkuoH763Yj5A6sCuQQhZEqXg0BI8VqluG
	pXZdAFbA4rkyy6AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [FYI] objtool: =?utf-8?Q?=2Eexport=5Fsymbo?= =?utf-8?B?bOKApjo=?=
 data relocation to !ENDBR: stpcpy
Message-ID: <20240801152836.xOJc9iaY@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

defconfig on x86-64 with gcc-14 I get this:
| vmlinux.o: warning: objtool: .export_symbol+0x26980: data relocation to !ENDBR: stpcpy+0x0

objdump ->

| 0000000000000110 <stpcpy>:
|  110:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
|  117:   00 00 00 00 
|  11b:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
|  120:   f3 0f 1e fa             endbr64

okay, no endbr64 on entry label.

| $ make lib/string.s
->
|         .type   stpcpy, @function
| stpcpy:
|         .p2align 5
|         endbr64
| .L30:
| # lib/string.c:193:  while ((*dest++ = *src++) != '\0')
|         movzbl  (%rsi), %eax    # MEM[(const char *)src_8 + -1B], _1

an alignment request after the function label before endbr64 which gets
expanded into NOP_11+NOP_5.
I don't see this with gcc-13.
Reported as https://gcc.gnu.org/PR116174

Sebastian

