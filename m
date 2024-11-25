Return-Path: <linux-kernel+bounces-421561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A092C9D8CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC7F16A1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A221B87EC;
	Mon, 25 Nov 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jEuGuSX/"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992216DEB3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732563443; cv=none; b=cXwiBIxTdhzovsyLWq2svD0GF2Csv2acf1EV5ZBburhWNtMaSuKJ9X+HhWDJRFwraSwe8k6ovnqjI4Dn7gTcNzcjdSoP3k5vmYwWRB/3Ysj6XNwG8xU3MpYN0D9DfJV44sAel2uhT1TQHqXloFBetY8Ch+wO33MwFzJtU15i/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732563443; c=relaxed/simple;
	bh=IIgkdc6NtI8B4n6xjMvuZXXX6QDHqCT/HVvrCkacUnc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Y72vhkxmxwqPC7789uIEMy374jC22acoJCTEAKNDT6HK/a6tIO9yj6PhJWEs+dFVGgPRuTmE2IPIeI4wdFxlyzKj47NlSJ9TLhGeseiBT/LZp5mNb9iWnqWxJoLaUpGR+KGpQXZLrum9xPlmcTxm4Ig590EZ4NxeIoHNJ25cEdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jEuGuSX/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=U5rJI5dJSpORspRIgPJSzFJ/vO7BoKUyaeN3OT2GWAw=; b=jEuGuSX/9qBEhA0/IJathPaqDi
	Vx23+sjJ/fS7x27labYotnZhw7Iy4CfH85tGeM/lTzxhAFirO66I1qZoeULYzqJHULS07s8+HeUdn
	J4nqssyxE4G3WZdn2rr1nef79QF11YWIfWBiydYNtw31lGLIjOGe5NPWKRRqYcKmB6/cYlKTZ1jI9
	lQLA4qfvqITUBbJ+pmU39NiUExFCK6mzxUjlqU+K9Ml3pO2syiuxyMDecg4/875KB+ezazmp3RYXF
	wgN2ZBDCSQEaMYdqsfq6T7Hlsdf6THtY6hFioBI5eyfmNrWKLVRjkZ8Dd1wqo37FzyZ8XtUCGRH7Q
	y7QfI0ew==;
Received: from [172.31.31.140] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFetJ-000000017lv-0s4h;
	Mon, 25 Nov 2024 19:37:01 +0000
Date: Mon, 25 Nov 2024 19:36:03 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>, kexec@lists.infradead.org,
 =?ISO-8859-1?Q?Sch=F6nherr=2C_Jan_H=2E?= <jschoenh@amazon.de>,
 Rik van Riel <riel@surriel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
Subject: Re: [RFC PATCH] x86/mm: Disable PTI for kernel_ident_mapping_init()
User-Agent: K-9 Mail for Android
In-Reply-To: <5633d50d-0d61-4d18-b43f-11311b5ec920@intel.com>
References: <20241125100815.2512-1-dwmw2@infradead.org> <20241125100815.2512-2-dwmw2@infradead.org> <8b7cd35ab5fec39b80eda8d5907b641af14c3272.camel@infradead.org> <7f75150e9d5d358c8fdc38b591f99a252071fba0.camel@infradead.org> <7e7cb9b21f17b345d8539962093d0c030cca3e34.camel@infradead.org> <88a87314-45ad-47f7-a93a-a9a53d7e8745@intel.com> <5d385e4c06ebd218cfdc20ef4f208ee4abcfa252.camel@infradead.org> <5633d50d-0d61-4d18-b43f-11311b5ec920@intel.com>
Message-ID: <2C6F6BDC-16B5-41B4-AA3B-F2C23F4EBB75@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 25 November 2024 19:13:02 GMT, Dave Hansen <dave=2Ehansen@intel=2Ecom> w=
rote:
>On 11/25/24 10:53, David Woodhouse wrote:
>>> I think we have a lot of software-available space in the page table
>>> pointer entries=2E What would folks think if we set a special bit in t=
hose
>>> p4d entries that said:
>>>
>>> 	"I don't need to be propagated to
>>> 	the user portion of the page tables=2E"
>>>
>>> It would obviously get set in this code that you're trying to fix=2E I=
t
>>> might _also_ be able to be set in in "_USR", like here:
>>>
>>> #define _KERNPG_TABLE_NOENC=C2=A0 (__PP|__RW|=C2=A0=C2=A0 0|___A|=C2=
=A0=C2=A0 0|___D|=C2=A0=C2=A0 0|=C2=A0=C2=A0 0)
>>> #define _PAGE_TABLE_NOENC=C2=A0=C2=A0=C2=A0 (__PP|__RW|_USR|___A|=C2=
=A0=C2=A0 0|___D|=C2=A0=C2=A0 0|=C2=A0=C2=A0 0)
>>>
>>> like:
>>>
>>> #define _USR _PAGE_USER|_PAGE_SW_WHATEVER
>> In fact, do we even need a separate bit? Any PTE without the _PAGE_USER
>> bit set clearly doesn't need to be mirrored into the user page
>> tables=2E=2E=2E?
>
>I can't think of any exceptions where this would break off the top of my
>head=2E It seems too simple to work=2E ;)

I'll throw something together and see if it explodes=2E

