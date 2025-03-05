Return-Path: <linux-kernel+bounces-547328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE8A505EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D583A149F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86AB19E806;
	Wed,  5 Mar 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AYQaspob"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD7D151992
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194272; cv=none; b=QSnjFLpnVYxB8yP+LEnNP6jb3hfJCEs8n1vMlP0lW5QI6K0hIRSUIW4wfUp++pEY188p8guObMxNeU+eSpj/mU5GE4R1jAz8j+P/vWFM00528tismWMuAv2uECnW7CFzV9QwAWU7JlplXTvGokOnEBTn5buW/xKfyk3fEgFm4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194272; c=relaxed/simple;
	bh=5kHn73F9ooUedujzkLSBcxrE4SVUuBll3iK/r3WIPYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7QSGBk9hFDiompa+pr6oPNTItX0aS271UDoxfB6l4VkQznLf3CSGITb5tc9r0sLSf3Aknt9xFQhtefNXZ9S5dKx63iAj2zs879IKzVTMA4ZDmcOpdA7tU04TWG4xcoNyHRjWRJz/T9U4Hpv/70fmThJRsapLrU3PgNPYYKZrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AYQaspob; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaecf50578eso1348173466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741194268; x=1741799068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kv40UN7CTmHsOioabQRDHDmDGt8SWK8BQaYTRtTR1Aw=;
        b=AYQaspoboi50ZvEtAH3lRH0q/ceq5SuJgLIDd4aAq7C00pwt9QF8UhxMW+r7pYKpvl
         vhC7DkC0qKBA3VDW5xe5bNyKclWJUq7SnnAJvaYNtK0F5SL4KeJxzKnfN6aq9YYmQd1v
         UgxCeNXGpMcgDhxYATropyD3Qx4bsNOwMpkJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741194268; x=1741799068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kv40UN7CTmHsOioabQRDHDmDGt8SWK8BQaYTRtTR1Aw=;
        b=vrjJ1lUILsBmzzE8KPCMUgTAyFks88oeSy0mSyXI6ig/RYTlFiemUwFRB8JhNKKw0d
         nZcw/zk4MlpT1QU2bf3FFYr/rba91wZbXHTQAyhf91kNmE4W/5+En0nEPOCIDqWqq47O
         Rjrp66bGfBKZU5niC0a0j1sSFcEfGioliX+uulz+NIopY0Atnfhi7Rp5le2cfaZisiAo
         NpT9D8wCTylPWlKPTphctjCQq+e5/q9FVsIm93ls7OjPJBwiHI48/1xgQqosSxpj32L/
         Dm7ujVn4IEiOubP1sH2Uv5tqcCQSamqGEGd2b2ra8NEQ4FVo42X63tkK0sUxtLeEOm9O
         aliQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjh0CTk9fAfVjuqkRFHvktM0WM+oAGNzEhr4nYWAQngz1HgvTfW7qU1P3eNEbD3UGIUvLTCqK7wNNnCaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAS/f3DKuC/rprck28HH5nrQNX/Fr6ODg6uTGID9NDzVqXDLEy
	SewISkYzwsgpsW6AgDxstgXRQbb4+Sg88048Z5atXvny71nocAkaQsXdubDuJDT6blvmxr3eEJX
	aw75YQg==
X-Gm-Gg: ASbGncuTltl63k9tfcxBRk29NVzIbQNd2b8Q2KUQeRBKhFNVHYJFgH0Y1sObGTrOspQ
	8TEUL5cHTjvZHLo9ZAkyOknZfuZz1jjIFnDxpuhTtnuk0ImqgPwPnoG0uyZj+z7hxwDn0hPTjz1
	c10GapbQjpmZ0qSHq1TG9AnDQxz5uAcfPRGz8aoLo1mMU3YIXNxvVO6kPgFIXQ+qm7ZsICJFabC
	CQ6AasMAvamNpg/imnf+foW53Z3pQWyJ0U/bGstEvqPNktR2VFFERusHckZfCzWSq/Ryx3mAN6p
	DQdJ3nbA6Tr7cNaI2mObImCELgdK9ZSkeo8x/f1/2Muw4WBwrwHlGwK1AuNlKXMsIbMoADmR5Q3
	6I4yQqgTBBl6jJJcNUQ==
X-Google-Smtp-Source: AGHT+IEcXO+eMYxmNYnaYXAG/AQKHRZIIFkmNh5MZwhwVJiK/PnVjbOPDJWYxY2P8moAyz1yZRvpsg==
X-Received: by 2002:a17:906:f587:b0:ac1:e1e1:1f37 with SMTP id a640c23a62f3a-ac20da4dd5cmr409247966b.10.1741194267637;
        Wed, 05 Mar 2025 09:04:27 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e917b70asm375108566b.151.2025.03.05.09.04.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 09:04:26 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7430e27b2so1129088866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:04:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhFoLB+5MsPgqY8qWOaaeEPivANV4qnP/HjOY/FXed6GRnQf8YPu8OjrrsSt7dNIoFqpGbpyE2hR7fjp8=@vger.kernel.org
X-Received: by 2002:a17:907:d8e:b0:ac1:f003:be08 with SMTP id
 a640c23a62f3a-ac20da4e45bmr357515766b.12.1741194265100; Wed, 05 Mar 2025
 09:04:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com> <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local> <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
In-Reply-To: <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 5 Mar 2025 07:04:08 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
X-Gm-Features: AQ5f1JpkQB5ShJPy0vuOavXhzF6M9md3GlU_-2Z0AWpteRo47ZA3BSSBHkk-2vk
Message-ID: <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 22:54, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Even to my surprise, the patch has some noticeable effects on the
> performance, please see the attachment in [1] for LMBench data or [2]
> for some excerpts from the data. So, I think the patch has potential
> to improve the performance.

I suspect some of the performance difference - which looks
unexpectedly large - is due to having run them on a CPU with the
horrendous indirect return costs, and then inlining can make a huge
difference.
kvm
Regardless, I absolutely think that using asm_inline here is the right
thing for the locked instructions.

That said, I do want to bring up another issue: maybe it's time to
just retire the LOCK_PREFIX thing entirely?

It harkens back to Ye Olde Days when UP was the norm, and we didn't
want to pay the cost of lock prefixes when the kernel was built for
SMP but was run on an UP machine.

And honestly, none of that makes sense any more. You can't buy a UP
machine any more, and the only UP case would be some silly minimal
virtual environment, and if people really care about that minimal
case, they should just compile the kernel without SMP support.
Becxause UP has gone from being the default to being irrelevant. At
least for x86-64.

So I think we should just get rid of LOCK_PREFIX_HERE and the
smp_locks section entirely.

Which would probably obviate the need for your patch, since then the
compiler wouldn't see it as some big instruction. But your patch isn't
wrong, so this is absolutely not a NAK, more of a "we should go
further".

Hmm?

                  Linus

