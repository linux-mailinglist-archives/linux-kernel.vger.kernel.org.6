Return-Path: <linux-kernel+bounces-279961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4873A94C3E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B51282CA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661712FB34;
	Thu,  8 Aug 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="irNryyh+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ieZOeV5+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B46A635;
	Thu,  8 Aug 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723139332; cv=none; b=eDCezNalFD7TR2w3/vjrRNnnW8bgsm0SJ0rL75oml2hhMaJaIIEwpYFRKk5jhIVIrx8C83Yl3P36N77MSaG+Crx7DcmOilDfWM+SjTFRvRs/PUsKlax7jtiq9TRBiGklfmRuhQD3de0WOMCecZ+N2j5IpQIg4TWKmhDbS9zFJos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723139332; c=relaxed/simple;
	bh=CUTdKpb41t2LFkaA3LqO+J1tNTQlSg0do0eSEamUrD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dmISa8g7NPc/FcEptz2JtDr4NnBdgyL/PuwKfcHK4KAtXeB68BAbYRCSZ3Nh/nltVMjg2EMdqhjZAsqAW0+Cr7fWwhckHG4W2Dvb+kjWKYBpbcngbFIz/y8WqSAPxavitRW7cUPkCF9N/soRz00oIv2NWl49DzHkUfbpfS3g8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=irNryyh+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ieZOeV5+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723139328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L8M2hB2I8fuczZ80xfj4FcFcpdrArcEFMmjl0cyRZXY=;
	b=irNryyh+UUuOPAnk7YA3RYMjlIj+H6DhRLIu5VglE2Zs/NasHokJ99w1rkJnQLRMr7DYOX
	B2UiL6tPpcMm+T4/9pfwYo/MywEi05m5d7aYeiT5+P7MsI0FQrq4CqgW5pxMzkAva0pGOn
	zXJxhUgZ+YKROfpvaZz37x3iPBeBv+eT9ldDb00NddKH/qgiiKNyqlCHlC7ToET/X55p8Q
	ZpqSpdhtqJMTek5RS7KAEiBo0iFXYlg8B0QE1DkvGN7C8ToQPEookWCw2oZzBe6+PN5kGc
	zGXBryB4qH3QXeb14J578iwIfT2eopFE77DHb2VaaaD2KxxkzfIZHQcf7REb9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723139328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L8M2hB2I8fuczZ80xfj4FcFcpdrArcEFMmjl0cyRZXY=;
	b=ieZOeV5+nyOtBZ60qiMCrWrHM/aDRipIL/9paYV+fLyl0eJ0jEcUvpyZvU8UgOY0GGc1EN
	5qWQoDe7YJYO4iCw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
In-Reply-To: <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net> <87plqjz6aa.ffs@tglx>
 <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
 <87a5hnyox6.ffs@tglx>
 <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
Date: Thu, 08 Aug 2024 19:48:47 +0200
Message-ID: <8734nezz0g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 08 2024 at 09:33, Linus Torvalds wrote:
> On Thu, 8 Aug 2024 at 09:12, Thomas Gleixner <tglx@linutronix.de> wrote:
>> It uses $$divU which is at $$divoI + 0x250. I validated that in the
>> disassembly.
>
> Well, that does support "maybe we have a page crosser issue", but it's
> not quite at the delayed branch.
>
> Because that would mean that $$divU starts at 0x41218ec0, and that
> means that there are 80 instructions from the start of $$divU to the
> end of that 0x41218xxx page.
>
> And if I counted instructions right (I don't have a disassembler, so
> I'm just looking at the libgcc sources), that puts the page crosser
> not quite at the delayed branch slot, but it does put it somewhere
> roughly at or around
>
>         ds      temp,arg1,temp          /* 29th divide step */
>         addc    retreg,retreg,retreg    /* shift retreg with/into carry */
>
> so it's around the last few bits of the result. The ones we get wrong.
>
> Which is intriguing, but honestly, I don't see how we could get itlb
> misses horribly wrong and not crash left and right.

Here is the disassembly from my latest crashing debug kernel which
shifts it up a couple of pages. Add 0x10 or sub 0x20 to make it work. 

    4121dec0:	37 21 3f ff 	ldo -1(r25),r1
    4121dec4:	08 39 22 00 	and,= r25,r1,r0
    4121dec8:	e8 00 00 88 	b,l 4121df14 <$$divoI+0x2a4>,r0
    4121decc:	b3 20 20 00 	addi,tc,= 0,r25,r0
    4121ded0:	08 1a 02 5d 	copy r26,ret1
    4121ded4:	d3 21 39 f0 	extrw,u,= r25,15,16,r1
    4121ded8:	d3 bd 19 f0 	extrw,u ret1,15,16,ret1
    4121dedc:	08 39 02 59 	or r25,r1,r25
    4121dee0:	34 1a 01 98 	ldi cc,r26
    4121dee4:	d3 21 3a f8 	extrw,u,= r25,23,8,r1
    4121dee8:	d3 bd 1a e8 	extrw,u ret1,23,24,ret1
    4121deec:	08 39 02 59 	or r25,r1,r25
    4121def0:	34 01 01 54 	ldi aa,r1
    4121def4:	d3 20 3b 7c 	extrw,u,= r25,27,4,r0
    4121def8:	d3 bd 1b 64 	extrw,u ret1,27,28,ret1
    4121defc:	0b 59 22 00 	and,= r25,r26,r0
    4121df00:	d3 bd 1b a2 	extrw,u ret1,29,30,ret1
    4121df04:	08 39 22 00 	and,= r25,r1,r0
    4121df08:	d3 bd 1b c1 	extrw,u ret1,30,31,ret1
    4121df0c:	e8 40 c0 02 	bv,n r0(rp)
    4121df10:	08 00 02 40 	nop
    4121df18:	97 21 00 00 	subi 0,r25,r1
    4121df1c:	08 20 04 40 	ds r0,r1,r0
    4121df20:	0b 5a 06 1d 	add r26,r26,ret1
    4121df24:	0b 20 04 41 	ds r0,r25,r1
    4121df28:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df2c:	0b 21 04 41 	ds r1,r25,r1
    4121df30:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df34:	0b 21 04 41 	ds r1,r25,r1
    4121df38:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df3c:	0b 21 04 41 	ds r1,r25,r1
    4121df40:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df44:	0b 21 04 41 	ds r1,r25,r1
    4121df48:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df4c:	0b 21 04 41 	ds r1,r25,r1
    4121df50:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df54:	0b 21 04 41 	ds r1,r25,r1
    4121df58:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df5c:	0b 21 04 41 	ds r1,r25,r1
    4121df60:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df64:	0b 21 04 41 	ds r1,r25,r1
    4121df68:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df6c:	0b 21 04 41 	ds r1,r25,r1
    4121df70:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df74:	0b 21 04 41 	ds r1,r25,r1
    4121df78:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df7c:	0b 21 04 41 	ds r1,r25,r1
    4121df80:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df84:	0b 21 04 41 	ds r1,r25,r1
    4121df88:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df8c:	0b 21 04 41 	ds r1,r25,r1
    4121df90:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df94:	0b 21 04 41 	ds r1,r25,r1
    4121df98:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121df9c:	0b 21 04 41 	ds r1,r25,r1
    4121dfa0:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dfa4:	0b 21 04 41 	ds r1,r25,r1
    4121dfa8:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dfac:	0b 21 04 41 	ds r1,r25,r1
    4121dfb0:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dfb4:	0b 21 04 41 	ds r1,r25,r1
    4121dfb8:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dfbc:	0b 21 04 41 	ds r1,r25,r1
    4121dfc0:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dfc4:	0b 21 04 41 	ds r1,r25,r1
    4121dfc8:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dfcc:	0b 21 04 41 	ds r1,r25,r1
    4121dfd0:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dfd4:	0b 21 04 41 	ds r1,r25,r1
    4121dfd8:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dfdc:	0b 21 04 41 	ds r1,r25,r1
    4121dfe0:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dfe4:	0b 21 04 41 	ds r1,r25,r1
    4121dfe8:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dfec:	0b 21 04 41 	ds r1,r25,r1
    4121dff0:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dff4:	0b 21 04 41 	ds r1,r25,r1
    4121dff8:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121dffc:	0b 21 04 41 	ds r1,r25,r1
    4121e000:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121e004:	0b 21 04 41 	ds r1,r25,r1
    4121e008:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121e00c:	0b 21 04 41 	ds r1,r25,r1
    4121e010:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121e014:	0b 21 04 41 	ds r1,r25,r1
    4121e018:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121e01c:	0b 21 04 41 	ds r1,r25,r1
    4121e020:	e8 40 c0 00 	bv r0(rp)
    4121e024:	0b bd 07 1d 	add,c ret1,ret1,ret1
    4121e028:	f3 20 0c 00 	depd,* r0,31,32,r25
    4121e02c:	8f 20 61 10 	cmpib,> 0,r25,4121e0bc <$$divoI+0x44c>
    4121e030:	08 00 02 40 	nop
    4121e034:	e8 19 40 00 	blr r25,r0
    4121e038:	08 00 02 40 	nop
    4121e03c:	b3 20 20 00 	addi,tc,= 0,r25,r0
    4121e040:	08 00 02 40 	nop
    4121e044:	e8 40 c0 00 	bv r0(rp)
    4121e048:	08 1a 02 5d 	copy r26,ret1
    4121e04c:	e8 40 c0 00 	bv r0(rp)
    4121e050:	d3 5d 1b c1 	extrw,u r26,30,31,ret1
    4121e054:	e8 00 01 c2 	b,l,n 4121e13c <$$divI_16+0x3c>,r0
    4121e058:	08 00 02 40 	nop
    4121e05c:	e8 40 c0 00 	bv r0(rp)
    4121e060:	d3 5d 1b a2 	extrw,u r26,29,30,ret1
    4121e064:	e8 00 02 2a 	b,l,n 4121e180 <$$divI_16+0x80>,r0
    4121e068:	08 00 02 40 	nop
    4121e06c:	e8 00 02 aa 	b,l,n 4121e1c8 <$$divI_16+0xc8>,r0
    4121e070:	08 00 02 40 	nop
    4121e074:	e8 00 06 9a 	b,l,n 4121e3c8 <$$divU_17+0xbc>,r0
    4121e078:	08 00 02 40 	nop
    4121e07c:	e8 40 c0 00 	bv r0(rp)
    4121e080:	d3 5d 1b 83 	extrw,u r26,28,29,ret1
    4121e084:	e8 00 07 12 	b,l,n 4121e414 <$$divU_17+0x108>,r0
    4121e088:	08 00 02 40 	nop
    4121e08c:	e8 00 02 9a 	b,l,n 4121e1e0 <$$divI_16+0xe0>,r0
    4121e090:	08 00 02 40 	nop
    4121e094:	e8 1f 1d 0d 	b,l 4121df20 <$$divoI+0x2b0>,r0
    4121e098:	08 20 04 40 	ds r0,r1,r0
    4121e09c:	e8 00 03 fa 	b,l,n 4121e2a0 <$$divI_16+0x1a0>,r0
    4121e0a0:	08 00 02 40 	nop
    4121e0a4:	e8 1f 1c ed 	b,l 4121df20 <$$divoI+0x2b0>,r0
    4121e0a8:	08 20 04 40 	ds r0,r1,r0
    4121e0ac:	e8 00 07 02 	b,l,n 4121e434 <$$divU_17+0x128>,r0
    4121e0b0:	08 00 02 40 	nop
    4121e0b4:	e8 00 04 22 	b,l,n 4121e2cc <$$divI_16+0x1cc>,r0
    4121e0b8:	08 00 02 40 	nop
    4121e0bc:	0b 3a 04 00 	sub r26,r25,r0
    4121e0c0:	e8 40 c0 00 	bv r0(rp)
    4121e0c4:	08 00 07 1d 	add,c r0,r0,ret1

