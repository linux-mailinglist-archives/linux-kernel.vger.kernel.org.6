Return-Path: <linux-kernel+bounces-440288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124829EBB47
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320C9167955
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD1422B5AD;
	Tue, 10 Dec 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="srPcbI3i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/ahE5zD"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2822B596
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864253; cv=none; b=jyQ69PBKmR+VM/sQEwOZn4bbt6ADLMcPUnHIT1F1eNsH2r/5jgenOmBo8+TOLQzpBwFwBA7tFtCgmieNQSUZaNNcaTz4qKKM2S9TKrrlrI/FUTnH+emqrdjLHGIA6A07csJm/z+6LFAy4xcRHZQ/vxZXkIMCayEga1MApZ2S6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864253; c=relaxed/simple;
	bh=VLaos3pymAUVDjO0K8a+Iru0LPTXXpLT24MfbbFHtpY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ENLmzjKr2fiTIN/UWtMSgFGjSktAv8etKrzUynz4kU5iFa5bh3hK6cy5wYTmydNSkdmFcSqV3P2elG5rbBkDuDJrhgPyPPfDStJAXMda2BxQncelt6H1BMGvyRRbZYnY9TrWBcG1de6nzn4lVqxm3o5smYaEMOByUs/y53sbEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=srPcbI3i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/ahE5zD; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B42BD2540149;
	Tue, 10 Dec 2024 15:57:28 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 10 Dec 2024 15:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733864248;
	 x=1733950648; bh=YkbUXiya6IgXKsMjcHF9OAxUM6YuHHMRw5Mh+BASRvg=; b=
	srPcbI3iJFua2slM3vf8vCG9YeKsOiQVshIX18US99ECQqvm6/vEPo++9crEy4ky
	e7i5EZxNzenk4hvCE2J7hR/Q6hh5rQ3vAIKqhkzvvGzknhJxgHt6MMmw17gu5tql
	S5CN/sjn+idEDpka7NQ4t64rk70NNshQAOf9f42f6kRAmHTpA8UqTSIaYINwsitn
	IWhpdBNrZOmvVdg6iKhoUKKLFzDG/SpUXDlDsTY5TuZdKuyBfJ7lz3NOCdtkrobU
	QMMaRvFY29Kg/KoLT3UNAc7EoRwxry9Heck6aZf+yajlfBNXUcac0UCXkcepvW5x
	tmNy8M+lplpkIlqFd7OH9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733864248; x=
	1733950648; bh=YkbUXiya6IgXKsMjcHF9OAxUM6YuHHMRw5Mh+BASRvg=; b=j
	/ahE5zDJ7xeM8/uUa+94ZdpFszwj6qQHPPuho5qkluba8p0TSui9lBbtRWXWy7Kt
	Sw5W0xk/IyqFhWIr5n12aQg8IFVMDOxqDpOZCQct/yKqIrFX0+7VDr4I6zT1f75M
	FphUHghJoEjtX+TI59l9QfXxQBlT0wGRmIlt7RRA+GCs95QJPsboP083BIQh2LU6
	FKUuTR4wRoOQ4R1vPa0Lpy8bN1xWIlvRtzxEtQvy7Vrx0qnzcxU85lG9gn+GUL6s
	eNc0Q7H7ximzpn0RBKSo6oPqJtN1UMz4usAQixpbGTo+8zTHN3XjSyNyNQ2QFeXk
	tMuzJHNc3pD2elb0jmkVA==
X-ME-Sender: <xms:N6tYZyKDzx3eznN92twcDudzFdq-_dxmXGhZR9nTl5VsgkGHuCE2bw>
    <xme:N6tYZ6J9eciYrbjewKlBvMalXLCzOWrsaDp-V9QOlGCfKjjV7lDfs0RUx7-_dF-4k
    0skTLuEKRKNW1KOtUU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepgefgjedujedvieejgeelgfdthfduffeiteefudeg
    hfffkeejfeehtdejfeejteefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepihhrvggttggrrdhkuhhn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopegrnhguhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghr
    nhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopeht
    ohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:N6tYZytiUse0i1pXZlsCJ2liB_A4v08V4Jl57D9NdVpt3kFKsBRW9Q>
    <xmx:N6tYZ3bazfB8zMIfbgJqG15Jr7L3ZM-Xih3wGr2akRX-uMUEk-k1Sw>
    <xmx:N6tYZ5bM926HiymGOK4lbMJpXP6fRfQjQ8x2lK6vVQWJhggtwQ-iDw>
    <xmx:N6tYZzB8fxCwrsMATaqQIIxLVBD_1OccqYI16m6CV3gcqKMP-vZ9JA>
    <xmx:OKtYZ_D6rLMfkAqzsl5wUcbG0wazXkwdCDVuX6YvqX3xwy85kd21oYXa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 90EA42220073; Tue, 10 Dec 2024 15:57:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Dec 2024 21:56:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: irecca.kun@gmail.com, "Arnd Bergmann" <arnd@kernel.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andy Shevchenko" <andy@kernel.org>, "Matthew Wilcox" <willy@infradead.org>
Message-Id: <ea07afe0-c6c7-4641-9121-2dd591797852@app.fastmail.com>
In-Reply-To: <fdf8b753-f4ff-47ea-aec7-508ad72ce5b9@gmail.com>
References: <20241210144945.2325330-1-arnd@kernel.org>
 <20241210144945.2325330-6-arnd@kernel.org>
 <fdf8b753-f4ff-47ea-aec7-508ad72ce5b9@gmail.com>
Subject: Re: [PATCH v2 05/11] x86: add CONFIG_X86_64_NATIVE option
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Dec 10, 2024, at 20:05, irecca.kun@gmail.com wrote:
> Hello.
>
> On 12/10/24 14:49, Arnd Bergmann wrote:
>> As a replacement for the obsole MK8/MPSC/MCORE2 configuration options,
>> allow building a specialized kernel for the local CPU, which is useful
>> for users building their own kernels, and does not require maintaining
>> a list of possible CPU options.
>
> That potentially introduces problems. Namely compilers could apply 
> auto-vectorization, which currently breaks the kernel.
> We probably need an additional patch like this: 
> https://github.com/zen-kernel/zen-kernel/commit/95b7981ba2e5c86529de0e895c2d9e428aa3f7dc

I don't see how either  -mno-avx2 or -fno-tree-vectorize would be
needed here: avx2 is already turned off because of -mno-avx,
and -ftree-vectorize is only enabled by default at -O3 level,
which we don't use (and which doesn't add any instructions).
There may be other flags that need to be disabled though.

With the flags we currently pass to the kernel, this is the
difference in the gcc-14 -Q --help=target output between the
x86-64 baseline and the -march=emeraldrapids, which is currently
the most featureful:

--- b	2024-12-10 21:37:27.182448452 +0100
+++ a	2024-12-10 21:41:14.118310513 +0100
@@ -12,24 +12,24 @@
   -mabm                       		[disabled]
   -maccumulate-outgoing-args  		[disabled]
   -maddress-mode=             		long
-  -madx                       		[disabled]
-  -maes                       		[disabled]
+  -madx                       		[enabled]
+  -maes                       		[enabled]
   -malign-data=               		compat
   -malign-double              		[disabled]
   -malign-functions=          		0
   -malign-jumps=              		0
   -malign-loops=              		0
   -malign-stringops           		[enabled]
-  -mamx-bf16                  		[disabled]
+  -mamx-bf16                  		[enabled]
   -mamx-complex               		[disabled]
   -mamx-fp16                  		[disabled]
-  -mamx-int8                  		[disabled]
-  -mamx-tile                  		[disabled]
+  -mamx-int8                  		[enabled]
+  -mamx-tile                  		[enabled]
   -mandroid                   		[disabled]
   -mapx-features=             		none
   -mapx-inline-asm-use-gpr32  		[disabled]
   -mapxf                      		[disabled]
-  -march=                     		x86-64
+  -march=                     		emeraldrapids
   -masm=                      		att
   -mavx                       		[disabled]
   -mavx10.1                   		-mavx10.1-256
@@ -62,27 +62,27 @@
   -mavxvnniint16              		[disabled]
   -mavxvnniint8               		[disabled]
   -mbionic                    		[disabled]
-  -mbmi                       		[disabled]
-  -mbmi2                      		[disabled]
+  -mbmi                       		[enabled]
+  -mbmi2                      		[enabled]
   -mbranch-cost=<0,5>         		3
   -mcall-ms2sysv-xlogues      		[disabled]
   -mcet-switch                		[disabled]
   -mcld                       		[disabled]
-  -mcldemote                  		[disabled]
-  -mclflushopt                		[disabled]
-  -mclwb                      		[disabled]
+  -mcldemote                  		[enabled]
+  -mclflushopt                		[enabled]
+  -mclwb                      		[enabled]
   -mclzero                    		[disabled]
   -mcmodel=                   		kernel
   -mcmpccxadd                 		[disabled]
   -mcpu=                      		
   -mcrc32                     		[disabled]
-  -mcx16                      		[disabled]
+  -mcx16                      		[enabled]
   -mdaz-ftz                   		[disabled]
   -mdirect-extern-access      		[enabled]
   -mdispatch-scheduler        		[disabled]
   -mdump-tune-features        		[disabled]
-  -menqcmd                    		[disabled]
-  -mevex512                   		[disabled]
+  -menqcmd                    		[enabled]
+  -mevex512                   		[enabled]
   -mf16c                      		[disabled]
   -mfancy-math-387            		[disabled]
   -mfentry                    		[disabled]
@@ -94,17 +94,17 @@
   -mforce-indirect-call       		[disabled]
   -mfp-ret-in-387             		[disabled]
   -mfpmath=                   		387
-  -mfsgsbase                  		[disabled]
+  -mfsgsbase                  		[enabled]
   -mfunction-return=          		keep
   -mfused-madd                		-ffp-contract=fast
   -mfxsr                      		[enabled]
   -mgather                    		-mtune-ctrl=use_gather
   -mgeneral-regs-only         		[disabled]
-  -mgfni                      		[disabled]
+  -mgfni                      		[enabled]
   -mglibc                     		[enabled]
   -mhard-float                		[disabled]
   -mharden-sls=               		none
-  -mhle                       		[disabled]
+  -mhle                       		[enabled]
   -mhreset                    		[disabled]
   -miamcu                     		[disabled]
   -mieee-fp                   		[enabled]
@@ -123,15 +123,15 @@
   -mlong-double-64            		[disabled]
   -mlong-double-80            		[enabled]
   -mlwp                       		[disabled]
-  -mlzcnt                     		[disabled]
+  -mlzcnt                     		[enabled]
   -mmanual-endbr              		[disabled]
   -mmemcpy-strategy=          		
   -mmemset-strategy=          		
   -mmitigate-rop              		[disabled]
   -mmmx                       		[disabled]
-  -mmovbe                     		[disabled]
-  -mmovdir64b                 		[disabled]
-  -mmovdiri                   		[disabled]
+  -mmovbe                     		[enabled]
+  -mmovdir64b                 		[enabled]
+  -mmovdiri                   		[enabled]
   -mmove-max=                 		128
   -mmpx                       		[disabled]
   -mms-bitfields              		[disabled]
@@ -152,23 +152,23 @@
   -mpc32                      		[disabled]
   -mpc64                      		[disabled]
   -mpc80                      		[disabled]
-  -mpclmul                    		[disabled]
+  -mpclmul                    		[enabled]
   -mpcommit                   		[disabled]
-  -mpconfig                   		[disabled]
-  -mpku                       		[disabled]
-  -mpopcnt                    		[disabled]
+  -mpconfig                   		[enabled]
+  -mpku                       		[enabled]
+  -mpopcnt                    		[enabled]
   -mprefer-avx128             		-mprefer-vector-width=128
   -mprefer-vector-width=      		none
   -mpreferred-stack-boundary= 		3
   -mprefetchi                 		[disabled]
   -mprefetchwt1               		[disabled]
-  -mprfchw                    		[disabled]
-  -mptwrite                   		[disabled]
+  -mprfchw                    		[enabled]
+  -mptwrite                   		[enabled]
   -mpush-args                 		[enabled]
   -mraoint                    		[disabled]
-  -mrdpid                     		[disabled]
-  -mrdrnd                     		[disabled]
-  -mrdseed                    		[disabled]
+  -mrdpid                     		[enabled]
+  -mrdrnd                     		[enabled]
+  -mrdseed                    		[enabled]
   -mrecip                     		[disabled]
   -mrecip=                    		
   -mrecord-mcount             		[disabled]
@@ -178,11 +178,11 @@
   -mrelax-cmpxchg-loop        		[disabled]
   -mrtd                       		[disabled]
   -mrtm                       		[disabled]
-  -msahf                      		[disabled]
+  -msahf                      		[enabled]
   -mscatter                   		-mtune-ctrl=use_scatter
-  -mserialize                 		[disabled]
-  -msgx                       		[disabled]
-  -msha                       		[disabled]
+  -mserialize                 		[enabled]
+  -msgx                       		[enabled]
+  -msha                       		[enabled]
   -msha512                    		[disabled]
   -mshstk                     		[disabled]
   -mskip-rax-setup            		[enabled]
@@ -212,11 +212,11 @@
   -mtbm                       		[disabled]
   -mtls-dialect=              		gnu
   -mtls-direct-seg-refs       		[enabled]
-  -mtsxldtrk                  		[disabled]
+  -mtsxldtrk                  		[enabled]
   -mtune-ctrl=                		
   -mtune=                     		generic
   -muclibc                    		[disabled]
-  -muintr                     		[disabled]
+  -muintr                     		[enabled]
   -munroll-only-small-loops   		[enabled]
   -musermsr                   		[disabled]
   -mvaes                      		[disabled]
@@ -224,15 +224,15 @@
   -mvect8-ret-in-mem          		[disabled]
   -mvpclmulqdq                		[disabled]
   -mvzeroupper                		[enabled]
-  -mwaitpkg                   		[disabled]
-  -mwbnoinvd                  		[disabled]
+  -mwaitpkg                   		[enabled]
+  -mwbnoinvd                  		[enabled]
   -mwidekl                    		[disabled]
   -mx32                       		[disabled]
   -mxop                       		[disabled]
-  -mxsave                     		[disabled]
-  -mxsavec                    		[disabled]
-  -mxsaveopt                  		[disabled]
-  -mxsaves                    		[disabled]
+  -mxsave                     		[enabled]
+  -mxsavec                    		[enabled]
+  -mxsaveopt                  		[enabled]
+  -mxsaves                    		[enabled]
 
I don't know what most of them do, but the ones I looked
up seem to be mainly integer operations.

     Arnd

