Return-Path: <linux-kernel+bounces-280194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9E994C6FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02AF287882
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F09E15ECEA;
	Thu,  8 Aug 2024 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b="bgh1g56Z"
Received: from cmx-mtlrgo002.bell.net (mta-mtl-005.bell.net [209.71.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265515A85E;
	Thu,  8 Aug 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.71.208.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723156206; cv=none; b=NMNuvW6qdhH0zvLdtlVXv1Xxxsk07At+4C+xwKWfYCl9qYFqUIiK/eBK5txnQFUuaMlRWvqbKt6quPGjH4DfgLnyBnOQTV/cTlOETdxwXawaTq8HKQBdAtE1bAA/PTDpClvvpd6N3H+z/oCzhhNqwLhwLdbnsWyX43sS3Fn4zH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723156206; c=relaxed/simple;
	bh=X2N84UJQ5Eyq3V3kjH2uenx0Eqy16NMBsbbtYZQ4wTs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RZbaSoDbLkeAZW/diWPEWywjnnhoGUp4cPbBc4Qygv5vKReHPCEnk5dM43NjcIfaaUPpxbIFw3SuCousMrCBh+eJEIeqnPwV3wl6ioj5dNV8HC8kgaOX20b7FpptZIr+SWZtt7b9/w/dV39gB1d0WaXv5STLD93eq2EqrPCIOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell.net; spf=pass smtp.mailfrom=bell.net; dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b=bgh1g56Z; arc=none smtp.client-ip=209.71.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1; t=1723156204; 
        bh=LgxfzUZVpycHSaGHDE/lQUlboZeRrF+ub5S85Pnl0GA=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:References:In-Reply-To:Content-Type;
        b=bgh1g56Zr8uFq2Wmcmb08i6456kFXqd0zSKuc3MqwVAE53WBIzT75cHDaGr9LMat/HdrNZKHS0JIHUdVJ67GMVO/kihO3rajB4xbiIG9wIvs5AuJGtgy18DXoepR9Vf9EC7cHrzy4YF5KjGhioO/varlJGVDk49GpsE8WPn8ldZ4A2NfM8PWmwy1GXNHjffZs89/d5oGRZshyl2q3+vm9yKXs1WjsEwLCEp6h5O40DKBxoHx1fccjHC7BX4JSCwn7YsgsyV+PP07t7gAMqvMYv1TUehVQZWsNkUlEqec1Ng7KtzuXKnCITFcHoq4lRQqjZAKChhNlAAKTWbznAVIPQ==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 6698E80E02170004
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeftddrleefgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceugffnnfdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhhnhcuffgrvhhiugcutehnghhlihhnuceouggrvhgvrdgrnhhglhhinhessggvlhhlrdhnvghtqeenucggtffrrghtthgvrhhnpedtkeeihfeivdevgeefuefgfeffiedvgeetieffuefgfefhfffgieehfeeugfehhfenucffohhmrghinhepvghnthhrhidrshgsnecukfhppeejiedrjedurdduudehrdejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedrvddrgeelngdpihhnvghtpeejiedrjedurdduudehrdejhedpmhgrihhlfhhrohhmpegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepuggrvhgvrdgrnhhglhhinhessggvlhhlrdhnvghtpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhprghrihhstgesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
	rhgtphhtthhopehlihhnuhigsehrohgvtghkqdhushdrnhgvthdprhgtphhtthhopehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.2.49] (76.71.115.75) by cmx-mtlrgo002.bell.net (authenticated as dave.anglin@bell.net)
        id 6698E80E02170004; Thu, 8 Aug 2024 18:29:47 -0400
Message-ID: <37f94771-4ebc-46d2-ad10-f145d139dd9d@bell.net>
Date: Thu, 8 Aug 2024 18:29:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
From: John David Anglin <dave.anglin@bell.net>
To: Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net> <87plqjz6aa.ffs@tglx>
 <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
 <87a5hnyox6.ffs@tglx>
 <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
 <8734nezz0g.ffs@tglx>
 <CAHk-=wiZUidi6Gm_6XFArT621H7vAzhDA63zn2pSGJHdnjRCMA@mail.gmail.com>
 <eba27c56-dc36-4410-bb6b-cbe8769b8a6d@roeck-us.net>
 <ac7284f9-ba29-4068-ab00-82ddc839afaf@bell.net>
Content-Language: en-US
Autocrypt: addr=dave.anglin@bell.net; keydata=
 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
 T70V9SSrl2hiw38vRzsl
In-Reply-To: <ac7284f9-ba29-4068-ab00-82ddc839afaf@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-08 5:50 p.m., John David Anglin wrote:
> The mode likely problem is the shladd instruction in the following macro in entry.S:
>
>         .macro          L2_ptep pmd,pte,index,va,fault
> #if CONFIG_PGTABLE_LEVELS == 3
>         extru_safe      \va,31-ASM_PMD_SHIFT,ASM_BITS_PER_PMD,\index
> #else
>         extru_safe \va,31-ASM_PGDIR_SHIFT,ASM_BITS_PER_PGD,\index
> #endif
>         dep             %r0,31,PAGE_SHIFT,\pmd  /* clear offset */
> #if CONFIG_PGTABLE_LEVELS < 3
>         copy            %r0,\pte
> #endif
>         ldw,s           \index(\pmd),\pmd
>         bb,>=,n         \pmd,_PxD_PRESENT_BIT,\fault
>         dep             %r0,31,PxD_FLAG_SHIFT,\pmd /* clear flags */
>         SHLREG          \pmd,PxD_VALUE_SHIFT,\pmd
>         extru_safe      \va,31-PAGE_SHIFT,ASM_BITS_PER_PTE,\index
>         dep             %r0,31,PAGE_SHIFT,\pmd  /* clear offset */
>         shladd          \index,BITS_PER_PTE_ENTRY,\pmd,\pmd /* pmd is now pte */
>         .endm
>
> I believe the shladd instruction should be changed to shladd,l (shift left and add logical).
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index ab23e61a6f01..1ec60406f841 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -399,7 +399,7 @@
      SHLREG        \pmd,PxD_VALUE_SHIFT,\pmd
      extru_safe    \va,31-PAGE_SHIFT,ASM_BITS_PER_PTE,\index
      dep        %r0,31,PAGE_SHIFT,\pmd  /* clear offset */
-    shladd        \index,BITS_PER_PTE_ENTRY,\pmd,\pmd /* pmd is now pte */
+    shladd,l    \index,BITS_PER_PTE_ENTRY,\pmd,\pmd /* pmd is now pte */
      .endm

      /* Look up PTE in a 3-Level scheme. */

Boots okay.  Fixing the addi instruction is harder and it would take some time to test.

Dave

-- 
John David Anglin  dave.anglin@bell.net


