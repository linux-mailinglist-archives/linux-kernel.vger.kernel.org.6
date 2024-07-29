Return-Path: <linux-kernel+bounces-266481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C2C94007F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E652C1C222D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5065518C33B;
	Mon, 29 Jul 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YXkcyotc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dGlYyPy5"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2AE188CDA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288921; cv=none; b=P12oa4biBwn6j5fvy7y4Mz3TZenta76QZv49DrekZhUZ+7SGgndQJ69FWFd+fUnxSrK5GRYRyitTUDEShDr1aalCLflAxhVcMV+CamQPXGBFrgVPorM1dOCie79jKFclJKQMbrKrNDsg8KQjkIHFxpZdJouK3Jg0cAuNFTuXAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288921; c=relaxed/simple;
	bh=tUPhZjVtaEkZ8n8sRtVLbRyC8I7wqh/kHwUU3YqRW/s=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=CHUZHpCW7Bd/UwVQ3+l1cwSSwX2iyzf9d0/jZAk3Imv7yGOb7v/6vOcbex5r0lEsItDUbxi82Y2BYYrDoqpMFyGuKhchQ/X39ri0p/KFAaFaoNiTFPRIkvEeO9vMYyyfnEdhE7f8oEz//7c6LAsLLqWes7eUIZ+ig/5qS88DEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YXkcyotc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dGlYyPy5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 61EAC13800F4;
	Mon, 29 Jul 2024 17:35:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Mon, 29 Jul 2024 17:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1722288917; x=1722375317; bh=vrqmuq+fVk
	zyrW4jZflnRltNsOKcbQe+OZHvAy+jwo4=; b=YXkcyotcaW7a2NuzwbEqViCnwQ
	n5uVNt4vQpCWXjuPlfwuOs/SILy12U1fhN9sji8YHYy1YuVRwBdJHAL6nFGwQySj
	t2fPVKbgqJPFlKbQGTto8VK3iq8NwRgHiyYl1D2Le0nZjI9OgmZD38QwCyJ1uZHT
	FL+NmroVgoPUaRUWGU9VXd/8XmOp24g50AcSTBqem2XEYrnJm0J9h6Jp5ZT0FNcz
	7nn0VmVR3f5l/ueMRbxy24YjNh1WpTwEDEnC8jcKiysRs01v700/1EBBqP7LJ+IH
	SlqFQd53hkYElE13Vq7W3HK5w3HBODNM/y3cnTfvQas4SLaidMdn1cAviadA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722288917; x=1722375317; bh=vrqmuq+fVkzyrW4jZflnRltNsOKc
	bQe+OZHvAy+jwo4=; b=dGlYyPy5giVHwQwYPeNVBFNBPaTKBZ18tgAyFnBRraTA
	alwE0Z4aUYR0Tc50ZeHc2V2fgSJK1JKLot+NcfuT7B6pX+Co6T0zXB3gqKRNVP60
	ex1q2dYZ5uP3V2n+m90RwMw8t3f7612xXXMbeoOQyu5hQ7qSrEhk8SLixW5ZKBzg
	vN/JqKqGf7Sw8MAUSK4GF+5ufKrn+o9eGKoL0siyIh2qVd6RFhyP+qRpFUSNDADK
	tcdruYUvwcDJyJQsDYFyPkXnQxHhfVzKoI/kgSuot+wYo5K8K7DUndiyFXGBtj1D
	PB2mvY4foadB1whsIRzOcDJQpNmKFxphHZiZmZJHKg==
X-ME-Sender: <xms:FAuoZkDxrLteIlQzRswtkIo5T4RsyNM9OvGqdYtDwpBqXSlxL3aY0Q>
    <xme:FAuoZmhUWHh3ApkXwFDI_2Eppkn_385kKwEl9N1E7XtT-A9ZNgk4_lWQGmYqsUHYC
    mcYI0spGhjnmLplLlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:FAuoZnm4sZD8SV1K0v-ihdfCAAY6RsZ8wjxtCjJIvJr-gT_ybwVrJg>
    <xmx:FAuoZqyt14lPmqkqoY0rWOV7wdKuNe5m6BbusXl7n5KeJonrRWq9zQ>
    <xmx:FAuoZpQ-sfWRkuTQ0mso68otieuYre3XSDVPu1MUgOO_cNM_blwvNw>
    <xmx:FAuoZlY5B2R-N8syKsteBRwgJ_6P02kqq_zTdzaI6aVldlSn-5mu7g>
    <xmx:FQuoZoEmOf3y5BHR0dhjmEe0QKvngx7YKcnKIvkuDSWWfelLUhPyZbaS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 71CD9B6008D; Mon, 29 Jul 2024 17:35:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eb1f2ec4-2bdb-4695-8e69-867ff25aa405@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wgEyzSxTs467NDOVfBSzWvUS6ztcwhiy=M3xog==KBmTw@mail.gmail.com>
References: 
 <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <CAHk-=wi-U672Eji+tz1x7JCVyEBjEGmm04umj9JqwfD5n8BMGg@mail.gmail.com>
 <CAHk-=wgEyzSxTs467NDOVfBSzWvUS6ztcwhiy=M3xog==KBmTw@mail.gmail.com>
Date: Mon, 29 Jul 2024 23:34:41 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Ingo Molnar" <mingo@kernel.org>, "Johannes Berg" <johannes@sipsolutions.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.11-rc1
Content-Type: text/plain

On Mon, Jul 29, 2024, at 21:50, Linus Torvalds wrote:
> On Mon, 29 Jul 2024 at 12:23, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> And that fix (if it fixes it - I think it will) still leaves the alpha
>> allmodconfig build and all the failed tests.
>>
>> I'll take a look.
>
> Well, the alpha allmodconfig case is apparently
>
>   ERROR: modpost: "iowrite64be" [drivers/crypto/caam/caam_jr.ko] undefined!
>
> which I suspect it just a result of commit beba3771d9e0 ("crypto:
> caam: Make CRYPTO_DEV_FSL_CAAM dependent of COMPILE_TEST").
>
> IOW, that is almost certainly simply due to better build test
> coverage, not a new bug.
>
> But I didn't look into *why* it would fail. We have a comment about
> iowrite64be saying
>
>  * These get provided from <asm-generic/iomap.h> since alpha does not
>  * select GENERIC_IOMAP.
>
> and I'm not sure why that isn't correct.
>
> I get a feeling that lib/iomap.c is missing a couple of functions, but
> didn't look into it a lot.
>
> I suspect Arnd may be the right person to ask. Arnd?

Yes, I've noticed this problem a few weeks ago with another
driver as we tried to fix the usage of iowrite64() on 32-bit
architectures. We actually have two old bugs here and still
need to make a decision about how to fix that properly:

- ioread64()/iowrite64() and their variants are defined
  differently on architectures depending on whether they use
  CONFIG_GENERIC_IOMAP (x86, um, and a few rare configs
  elsewhere) or not. On GENERIC_IOMAP architectures, there
  is no 64-bit PIO, so lib/iomap.c only provides the
  iowrite64_hi_lo()/iowrite64_lo_hi() etc wrappers that do
  a pair of 32-bit accessors for PIO but native 64-bit
  MMIO. On other 64-bit architectures, iowrite64() is the
  same as writeq() and it can operate on PCI I/O space as
  well. Drivers with big-endian registers tend to use
  iowriteXXbe() in order to the correct byteswap in the
  absence of writeX_be().

- Alpha (and I think parisc) uses the asm-generic/iomap.h
  header that is meant for GENERIC_IOMAP but then provides
  its own functions. It never had iowrite64be() and we
  didn't notice this in the absence of users. The caam driver
  includes include/linux/io-64-nonatomic-lo-hi.h, which
  then redirects iowrite64be() to iowrite64be_lo_hi()
  on x86 (since it does not define iowrite64be()) and
  on 32-bit architectures, but uses iowrite64be() from
  include/asm-generic/io.h on most other 64-bit
  architectures. On alpha it uses the incorrect
  prototype.

I suspect we can fix the alpha issue with the trivial
change below (haven't tested yet), but the way we are
inconsistent about these will likely keep biting us
unless we come up with a better way to handle them
across architectures.

      Arnd

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 2bb8cbeedf91..52212e47e917 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -534,8 +534,10 @@ extern inline void writeq(u64 b, volatile void __iomem *addr)
 
 #define ioread16be(p) swab16(ioread16(p))
 #define ioread32be(p) swab32(ioread32(p))
+#define ioread64be(p) swab64(ioread64(p))
 #define iowrite16be(v,p) iowrite16(swab16(v), (p))
 #define iowrite32be(v,p) iowrite32(swab32(v), (p))
+#define iowrite64be(v,p) iowrite64(swab64(v), (p))
 
 #define inb_p          inb
 #define inw_p          inw
@@ -634,8 +637,6 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
  */
 #define ioread64 ioread64
 #define iowrite64 iowrite64
-#define ioread64be ioread64be
-#define iowrite64be iowrite64be
 #define ioread8_rep ioread8_rep
 #define ioread16_rep ioread16_rep
 #define ioread32_rep ioread32_rep

