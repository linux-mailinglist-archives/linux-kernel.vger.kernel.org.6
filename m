Return-Path: <linux-kernel+bounces-250755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261F692FC50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565D11C20EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51204171653;
	Fri, 12 Jul 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="J+0v336O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8aomy2W"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6417164B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793540; cv=none; b=V/jPwjWC7NYRJi4g/2WZ1uSTHvT3/GPQcjJLy1XwD5PknUq5JKO2Fq92IFFRN9/QeKduFg54pxE8vHf7WhmIPCUTKjafRyvp3sBwQTr3WxEeJlkCKByIcz13Je8a7Xi7t4EafCVrxeIN/5nPdQcOck7shptKv0YRkd6KdjBix1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793540; c=relaxed/simple;
	bh=7/E4DSTDN9ejQgLLlqCpZk5cd4W1uwwyGei/V9j/uZo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Ogg4NySBCj51lKeo62j/jAaM3SPzafhYvadXFS1TrhIp0GybzIWFKEWqONN6TYgE25SRCSgPQwbpy9YLydVRROeb+IL8gFNAsDMCiif/NkhOd5JDFRzkLT7Ny8cZSfIYzFOCB23hIndeyx+UbDBowTsODiR/PggfwsPKfDqgHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=J+0v336O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A8aomy2W; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id AE85A1380E6B;
	Fri, 12 Jul 2024 10:12:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 12 Jul 2024 10:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720793536; x=1720879936; bh=8M5IQs00ft
	T9EZgFdd0ziurof3Jg+Ce/CYVFayzVF7A=; b=J+0v336O2oVOHhMNLAMrjCelnS
	8uGb7G2pJznlhFW3Xdd9nYq9KtE0UxJEWZw/2p048GfOOvhXIpim2/O9qqeFMq1R
	Kou08IkozJUG0NMZEJPl50Sl0Fwmm6cn3I+MwSJz0mcGxUu9Madt+kt/X1m4QBLa
	QmowucAEI+eL/WEqRwWuWm6rPqkBfFX8HgmURAM15IxEkdetmDpy7XzIb9ClA2WU
	zvzNHrjUTUihAvTAyiGDcgXwW1tf/SeLFZkSSE++EIP4Peergbto83i7OkBVU+b0
	meKXLhZtDvNlbivLPiB7fOUv73ZavxmOBRYY+tmKM7Cx+eOrs7DSyrftX/wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720793536; x=1720879936; bh=8M5IQs00ftT9EZgFdd0ziurof3Jg
	+Ce/CYVFayzVF7A=; b=A8aomy2WHJOoVlBw54QZhk7/wjPBUPKu4bfJJsjuyTD5
	5OrWjJ4I8TMuZVINmKBK7R5rcXK1EU9Em1fSKA6uCGdY4LZskCOHYthcQGxF8jQ2
	Ru7r/cPtpWXKiC/jaloYwcEUHLKPyWHWmyxnNvtm2nfzQJNEmIGnrmsuX5sCJ2xF
	O+ysXmewdC/ckDsfVOjHOrxbFS8vvDfaHE87s+RguWTODY/2jROvLicDqxhFzWnW
	qV63MNSb3Qy5kJBI5Wbpzl6lvudxJvm2XFNcc0MCPSVD5gII7MY7VFf1/uQ7QCAg
	/CgH+Ajub3pLnHBb1aROLtWzT7l3DnVvJaGdwiwyyw==
X-ME-Sender: <xms:vzmRZuwj_3k6Yfh3auZH68Gw9KdyY2fZjWIytvJ9-WCqT9S0gxvadA>
    <xme:vzmRZqRvbjkUgf5hu49KjpfUJIzRxpsVTsIB1S2IL0mdcdrAJaBidjXMhBO0jnCBw
    p-LHN6qUhcBmDPYJXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:vzmRZgU548ZC_hK-lSYaNRuSRhewnZLxwywhlOuCq-2BlyIC60hLcQ>
    <xmx:vzmRZkgxef8f1tFt38u7dekBE-CoepqTPE84JOyzEHT4-H00YwrX1A>
    <xmx:vzmRZgBwhMOqoVW-XnotMR8FrIZKo3Z-v_uL-cyX72mM9zItKhjDDg>
    <xmx:vzmRZlJM6vxZkxn2oqmNaoWvUQC-2qcgw6niRz_HXQISZ9nGC_AIUw>
    <xmx:wDmRZuAqo3oPcO88dJBjlSYZ7V0RzhiypfaXxum0qL3OLJPYBsbSqNXr>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 34F18B6008D; Fri, 12 Jul 2024 10:12:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6494316f-fcf9-4c19-9f3c-f8ad6f0810fa@app.fastmail.com>
In-Reply-To: <20240712132427.GJ27299@noisy.programming.kicks-ass.net>
References: 
 <CA+G9fYv0xfJbt=+STRDu65G-Tq_w9wEH3C0q1ucyoAa7DbWLAQ@mail.gmail.com>
 <e25a690e-6cb9-4e00-ac1d-07cda43b12de@app.fastmail.com>
 <20240712132427.GJ27299@noisy.programming.kicks-ass.net>
Date: Fri, 12 Jul 2024 16:11:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Subject: Re: next-20240712: task_work.c:(.text+0xc2): undefined reference to
 `irq_work_queue'
Content-Type: text/plain

On Fri, Jul 12, 2024, at 15:24, Peter Zijlstra wrote:
> On Fri, Jul 12, 2024 at 02:28:38PM +0200, Arnd Bergmann wrote:
>> On Fri, Jul 12, 2024, at 14:13, Naresh Kamboju wrote:
>
>> that we may have to always enable IRQ_WORK even on non-SMP
>> kernels now. In practice it is already enabled in most
>> configurations for one reason or another, the the cost is
>> likely very small.
>> 
>> Otherwise checking for CONFIG_HAVE_NMI in the new code might work.
>
> ARM seems to have HAVE_NMI while also being one of the architectures
> that is now failing.

Right, in this case we would also need

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -236,6 +236,7 @@ config HAVE_FUNCTION_ERROR_INJECTION
 
 config HAVE_NMI
        bool
+       select IRQ_WORK
 
 config HAVE_FUNCTION_DESCRIPTORS
        bool

> I'm a bit confused though, perf is already depending on irq_work (and
> perf is the user of TWA_NMI_CURRENT). So I'm not exactly sure what
> config fail is leading to all this.

Ok, this is the bit I was missing. If it's only needed for
perf, then the problem is that the caller is built in unconditionally
even when perf is disabled, otherwise it would be caught by
the existing:

config PERF_EVENTS
        bool "Kernel performance events and counters"
        select IRQ_WORK

> I suppose we can do something like the below.. it'll end up in a runtime
> fail for whoever manages to use TWA_NMI_CURRENT without also having
> irq_work enabled, but that should currently be nobody.

>  		break;
> +#ifdef CONFIG_IRQ_WORK
>  	case TWA_NMI_CURRENT:
>  		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
>  		break;
> +#endif
>  	default:

This looks more fragile than necessary. as it might fail if anything
else starts using TWA_NMI_CURRENT without selecting IRQ_WORK.
I would prefer either something that makes it still run into
a compile-time error (e.g. hiding the TWA_NMI_CURRENT inside
the same #ifdef), or just making IRQ_WORK unconditional
as I first suggested.

Configurations without IRQ_WORK are extremely rare, since
it also gets selected by CONFIG_PRINTK, which can only be
turned off for CONFIG_EXPERT=y and is almost always a good
idea even for small kernels.

      Arnd

