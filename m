Return-Path: <linux-kernel+bounces-235661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7191D818
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F50C1F21C00
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475AA383AB;
	Mon,  1 Jul 2024 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EZf7mYrB"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31894A0F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719815539; cv=none; b=uX86hjLF7evMXdylJs+RMB8c5F3w20tyB7wLFupQA37qR4neQk7hLF0Zyzy9+UJMgLe2f6PGGfgye4klfMC4aeELzQwztozqN3jDj+6xfiL6UEt+fqryqLvONn4ygQpXcJ0z4A8rELowTI3iAzu+/bJ1bLSGgPO6UnK+a2W70WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719815539; c=relaxed/simple;
	bh=Q5sboihfEW/Pzgn6/9EY8AX0teY1OvwAtmewLL6R6N4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oNfWNGjik3Xx7VwU2GN4RX4zwwRQAJbSX8587+NzU3GUxveFzf8d1EMuj/7iQe1bwkMyDF06B1V83eS8etPfMev+Az5q/VxRjf8i1/xNCe766MPFHWEq53F9JQywJF8bBWdVFJLQoPST4LajsvucQXwx82HQ07TnKsfUrIKw3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=EZf7mYrB; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4616VgDc4179286
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 30 Jun 2024 23:31:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4616VgDc4179286
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719815503;
	bh=zrTEEemGctpMM/kz5Y+JNaQpnhhyAoic/rQxqpHSzGQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EZf7mYrBfVpwK3UT03ETnOJ5pOzQfLWKxDP/bSzRRWCeKrJAhXzaNDrlpbaJv9G4m
	 1icP5+SYk1JrLxv5OK5PSKqIq7xfe5LwyL5B/QJHZTiX5QS01N4ywVClWBbb4AxT6r
	 iy4cCgRLfH91gzNshQ7jpQuKI6K5iTV8oeBzDb9JTgyRJn6VsoePDnK53tiEq2ybIa
	 uMk0wvF+Z55eVcEaeIv8p/7F7sOAUiS8O13TdSEPySJ770cb+vNEYP51q4gzozKgr9
	 IkaGOpWpQvKoOi6lb12GUQO5EMPIvDaqKkfVm5+JriJRiAP3rA6JjGJfQrG1+Kof2Q
	 qS/o4q2UEqsvw==
Date: Sun, 30 Jun 2024 23:31:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>
CC: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, brgerst@gmail.com, chang.seok.bae@intel.com,
        jgross@suse.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_5/5=5D_x86/gsseg=3A_use_the_LKGS_?=
 =?US-ASCII?Q?instruction_if_available_for_load=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240701060841.GAZoJH6XpJz6qyo-Lr@fat_crate.local>
References: <20230112072032.35626-1-xin3.li@intel.com> <20230112072032.35626-6-xin3.li@intel.com> <20240630160448.GAZoGCIHXRuBY8sLqW@fat_crate.local> <3A846C73-305E-4C55-B846-AC00657BA95B@zytor.com> <20240701060841.GAZoJH6XpJz6qyo-Lr@fat_crate.local>
Message-ID: <38C69EA0-DB74-4D2A-ABB5-CB3F1D31FB0C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 30, 2024 11:08:41 PM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Sun, Jun 30, 2024 at 07:34:42PM -0700, H=2E Peter Anvin wrote:
>> It is much like "movl %edi,%ds"=2E=2E=2E
>
>You mean =2E=2E=2E,%gs"=2E=2E=2E :-P
>
>But yeah, that makes more sense=2E
>
>Are we saying somewhere that when moving into a segreg, only the lower 16=
 bits
>of the source operand are used?
>
>Both docs say
>
>8E /r	MOV Sreg, r/m16		Move r/m16 to segment register=2E
>
>and I read that strict as r16 so I'd expect a "mov %di,=2E=2E=2E" not a "=
mov
>%edi,=2E=2E=2E"
>
>Thx=2E
>

Yes, all loads into a segment register are truncated to 16 bits=2E

