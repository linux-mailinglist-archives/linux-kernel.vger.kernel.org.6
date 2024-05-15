Return-Path: <linux-kernel+bounces-180339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810E98C6D23
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0981F283FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2A15B0E4;
	Wed, 15 May 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Az+1uV24"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D24206F;
	Wed, 15 May 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715804355; cv=none; b=OcgwWwDWUKrd1hjEQ1ERKIznH74fHhIWYQKwwW8fCAx32X/ttuUyZgiMj9fIKkYqkIh9j4dFqXoKCinkVazdF2Ig1CY5tuhzRBaINNpyHagsKkHXL3RmZug387+uyUgwIkKAkPXhptN/omHkPf4OtW0WzI0ntWcpQ4DsPeQvoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715804355; c=relaxed/simple;
	bh=9goRToJ5OiITq+QXW6KIsVlsdZ7LiiRiNSA8UJa/MAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5rAZSvuB/L6AdwoVRGaYFhm4RnUguWZ2EyTa495hzvFg/hk5YbwskMs3rU4k04+iNTKl9GqTO7H6YzwPUz49TDnUK2P6/AMPtDO/fG2wCSspacTDUwe6suEX/f7ykJVhIq3C+hszcAy0ooMfPT2cB8QwaZiN8iuGKKchuMHRtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Az+1uV24; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5877940E01F6;
	Wed, 15 May 2024 20:19:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Zw2uAITgrclB; Wed, 15 May 2024 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715804346; bh=I+TM5XxPjG4Qj70u6A2s8F0ZAG2e+3pm2+5E6j0Lpho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Az+1uV24MRhctKN9lhn5WrN0m6bLZJW5T1B5QK7KdnCkfR8tiY0xvI9TI3J+7QMA2
	 Jc7aZ7V7U5MYr8ZSqAVux5K8Gwyru9TGzP80Estj5jxpPr82TnMdJlJohr5wjMcW14
	 NNGJM59tyMkXpgMyHI2JL5vCleOogoChGPxNx+14IVz2JI5L5FwCTKxLDVC9T8pPic
	 DTh+3HvaDA6N5J5X2UYtv7JCmvPce0lBy+aBjUcdck8TbyW8jpLsbJRMwQiua6jWMq
	 6D9QJalBAQNftXhOXdt+d3tWXSzMxE4e6LFHzD9Y3XwTmQS5Aent2y9vLnifF/MQWf
	 Z3L5OrHhoJtODBs7P9Q+UrBA4f4LADIOlXN6VnB8Y0GqFPnznDp4yZN07b2CR9gNK7
	 cfjtqhCOYBbJEfTJt3PLQJCehLdHKI6T3W+25Td/Mi6QWwt2lBbz3y4YJrv4VEcmY+
	 AhMaTvuSlCLocYJMCRSk6XeFJWioa81qeUuZrTQ0eztjVMYoMV4CX53dt7U0PjySDC
	 EXEq0t8oh4oNPOzt4xXusfuOn9lF8ILJQeWUHiNvO/XvNgwKAsVelSBopUMx20Rxqg
	 JfTuMNeGc8g/iZr5sDQGXgXALNOxkFMdRBlpYdyYPtkW2LfId/nM8T1YT5ICdhuaTp
	 AIvm4Gkabd1B7ukayuBdD2NQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB1C540E016A;
	Wed, 15 May 2024 20:18:37 +0000 (UTC)
Date: Wed, 15 May 2024 22:18:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Liu Shixin <liushixin2@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/1] arch/fault: don't print logs for pte marker
 poison errors
Message-ID: <20240515201831.GDZkUYlybfejSh79ix@fat_crate.local>
References: <20240510182926.763131-1-axelrasmussen@google.com>
 <20240510182926.763131-2-axelrasmussen@google.com>
 <20240515104142.GBZkSRZsa3cxJ3DKVy@fat_crate.local>
 <ZkSUaVx3uCIPkpkJ@localhost.localdomain>
 <CAJHvVchGGJkEX=qroW=+N-RJDMDGuxM4xoGe7iOtRu9YcfxEEw@mail.gmail.com>
 <20240515183222.GCZkT_tvEffgYtah4T@fat_crate.local>
 <CAJHvVcj+YBpLbjLy+M+b8K7fj0XvFSZLpsuY-RbCCn9ouV1WjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcj+YBpLbjLy+M+b8K7fj0XvFSZLpsuY-RbCCn9ouV1WjQ@mail.gmail.com>

On Wed, May 15, 2024 at 12:19:16PM -0700, Axel Rasmussen wrote:
> An unprivileged process can allocate a VMA, use the userfaultfd API to
> install one of these PTE markers, and then register a no-op SIGBUS
> handler. Now it can access that address in a tight loop,

Maybe the userfaultfd should not allow this, I dunno. You made me look
at this thing and to me it all sounds weird. One thread does page fault
handling for the other and that helps with live migration somehow. OMG,
whaaat?

Maybe I don't understand it and probably never will...

But, for example, membarrier used do to a stupid thing of allowing one
thread to hammer another with an IPI storm. Bad bad idea. So it got
fixed.

All I'm saying is, if unprivileged processes can do crap, they should be
prevented from doing crap. Like ratelimiting the pagefaults or whatnot.

One of the recovery action strategies from memory poison is, well, you
kill the process. If you can detect the hammering process which
installed that page marker, you kill it. Problem solved.

But again, this userfaultfd thing sounds really weird so I could very
well be way wrong.

> Even in a non-contrived / non-malicious case, use of this API could
> have similar effects. If nothing else, the log message can be
> confusing to administrators: they state that an MCE occurred, whereas
> with the simulated poison API, this is not the case; it isn't a "real"
> MCE / hardware error.

Yeah, I read that part in

Documentation/admin-guide/mm/userfaultfd.rst

Simulated poison huh? Another WTF.

> In the KVM use case, the host can't just allocate a new page, because
> it doesn't know what the guest might have had stored there. Best we

Ok, let's think of real hw poison.

When doing the recovery, you don't care what's stored there because as
far as the hardware is concerned, if you consume that poison the *whole*
machine might go down.

So you lose the page. Plain and simple. And the guest can go visit the
bureau of complaints and grievances.

Still better than killing the guest or even the whole host with other
guests running on it.

> can do is propagate the poison into the guest, and let the guest OS
> deal with it as it sees fit, and mark the page poisoned on the host.

You mark the page as poison on the host and you yank it from under the
guest. That physical frame is gone and the faster all the actors
involved understand that, the better.

> I don't disagree the guest *shouldn't* reaccess it in this case. :)
> But if it did, it should get another poison event just as you say.

Yes, it shouldn't. Look at memory_failure(). This will kill whole
processes if it has to, depending on what the page is used for.

> And, live migration between physical hosts should be transparent to
> the guest. So if the guest gets a poison, and then we live migrate it,

So if I were to design this, I'd do it this way:

0. guest gets hw poison injected

1. it runs memory_failure() and it kills the processes using the page.

2. page is marked poisoned on the host so no other guest gets it.

That's it. No second accesses whatsoever. At least this is how it works
on baremetal.

This hw poisoning emulation is just silly and unnecessary.

But again, I probably am missing some aspects. It all just sounded
really weird to me that's why I thought I should ask what's behind all
that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

