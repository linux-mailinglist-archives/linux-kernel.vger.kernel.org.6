Return-Path: <linux-kernel+bounces-407582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FB89C6F39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BFD287B87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403B200B8B;
	Wed, 13 Nov 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KUS02FOu"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DED1DF743
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501645; cv=none; b=bjzAiKwGf8I0VtBb476/u68BFZNfAlqLNBOj/917AD3hb8kSz2icsh+///AFZQdY/L5zVmYZ+9aqxBhDcVQWC0uVL98uM5LvNlTUbVS4j+g6C25+/piHsK2mewknU6SPJvseA73a7W2xebHEx1X8ozAnIA2zxFW8sxUu9gOJSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501645; c=relaxed/simple;
	bh=C7/U0kgkVdRmfltbICoTH1jF1nneaarbUzuSDywn3gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUxowiD2kjXieaXZ2Wqr0xPpz7E0lfqQS9srzozj0C0wtI53QGAneBIn2fMPaepKOULOo1KbsSlZvTqSALyr5VGXFpAEYpAplR4rtMTdhND8uUTsBNf3XGpWvP50mUZiazicBhxOeGpNJhIkclrFuZtJt6OnrA6h1/jQil/dZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KUS02FOu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a039511a7so24854566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731501641; x=1732106441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q4yAy2wMFv3QmNaNBh+HpCNSzH/IZuAzT2Ere1d8IE=;
        b=KUS02FOuf052QGi6kO4uhAg+iQUVBRvDtJsiz6v7SZdahMEkA2hqly7/T3EXHKyPtH
         27oodi/+TCYi+nI+rBzDJ6aCRTkWUITeXFX6wsBoCDhP9JWtTbO0wOk9ayyvH5CEu0hw
         MwVTpQknS71r/1WRbCwQkM/xF8bgrST+tpmhrNOUdv5BM117kg7xj7/k8Fv7LE1Wn5/9
         0oqYMZocqh6uwEhxwI9aeg1g09Eze33EPnt8s8Ids+QJZ4qARW7Z3fv377TgFX1ft+j8
         NYCDnpsM+ZSupJpn5JPTIhaxpghuE9Pj3j029eskGX0v3SqBRy9JDE3fhAyfSADNx9Hd
         wSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731501641; x=1732106441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Q4yAy2wMFv3QmNaNBh+HpCNSzH/IZuAzT2Ere1d8IE=;
        b=BTlRaT7HBqP8Em53sLch/Jh2TC4BlSooLlJ/5Cd0d+4FXTSpjZ81tZrg79HDJBgoOk
         Hvdkx5fUvhr2u2nSy1btsTAz0ycbYGM644IJNm1IokMxvjj81ggnmrBs9TgxF4uOUgnl
         DtknCc1il2M/8vykn5XVIS0ByhS/ff/JTyfpxu4fVevpt+/gv6rid4e3va7pVih3QMPN
         apKFRfGxiESQD7cdpS3lFBgxFiWoa4YK5xvkopWmMi7PL/ZQhR6EGncHx0iWq0Me6NwO
         953vVowazOuwgODB24SGvxiMb6pnvbhCsgGYHeYacVrHmGNJmeLrY9sErUeVvlYDwE7C
         zwMA==
X-Forwarded-Encrypted: i=1; AJvYcCUcTUF1F7fT99YmXOeAcbQPBdbVO/ciJLF05gESn1Wp3qNzQW0S/CzCjeYQArOMxppBmN83nZLFeOnSS4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlIuj5gW9z1y5M33b5yqxq3+zo/IfWOEW2QotukCsVF/OM3H3
	+4rczq+Vy2LxfMi34HoJrvGnCtI7IrK0IKGkZ9ZJALaeaxn0ttQcLf8H6GRYJBM=
X-Google-Smtp-Source: AGHT+IEwds+FuFoQ3DTtkRiLVPQwZ1Gfef0GGqF7IdAomHWebbd6rX+YVFq4FDwO4+GGcieYxQRANg==
X-Received: by 2002:a17:907:7da8:b0:a9a:3dc0:efec with SMTP id a640c23a62f3a-a9eeff38625mr783864266b.7.1731501641518;
        Wed, 13 Nov 2024 04:40:41 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17678sm857771766b.10.2024.11.13.04.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:40:41 -0800 (PST)
Date: Wed, 13 Nov 2024 13:40:38 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <20241113134038.5843ab73@mordecai.tesarici.cz>
In-Reply-To: <20241112115039.41993e4b@mordecai.tesarici.cz>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241017142752.17f2c816@mordecai.tesarici.cz>
	<aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
	<20241111131442.51738a30@mordecai.tesarici.cz>
	<046ce0ae-b4d5-4dbd-ad9d-eb8de1bba1b8@arm.com>
	<20241112104544.574dd733@mordecai.tesarici.cz>
	<5a041e51-a43b-4878-ab68-4757d3141889@arm.com>
	<20241112115039.41993e4b@mordecai.tesarici.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 11:50:39 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> On Tue, 12 Nov 2024 10:19:34 +0000
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
> > On 12/11/2024 09:45, Petr Tesarik wrote:  
> > > On Mon, 11 Nov 2024 12:25:35 +0000
> > > Ryan Roberts <ryan.roberts@arm.com> wrote:
> > >     
> > >> Hi Petr,
> > >>
> > >> On 11/11/2024 12:14, Petr Tesarik wrote:    
> > >>> Hi Ryan,
> > >>>
> > >>> On Thu, 17 Oct 2024 13:32:43 +0100
> > >>> Ryan Roberts <ryan.roberts@arm.com> wrote:    
> > >> [...]    
> > >>> Third, a few micro-benchmarks saw a significant regression.
> > >>>
> > >>> Most notably, getenv and getenvT2 tests from libMicro were 18% and 20%
> > >>> slower with variable page size. I don't know why, but I'm looking into
> > >>> it. The system() library call was also about 18% slower, but that might
> > >>> be related.      
> > >>
> > >> OK, ouch. I think there are some things we can try to optimize the
> > >> implementation further. But I'll wait for your analysis before digging myself.    
> > > 
> > > This turned out to be a false positive. The way this microbenchmark was
> > > invoked did not get enough samples, so it was mostly dependent on
> > > whether caches were hot or cold, and the timing on this specific system
> > > with the specific sequence of bencnmarks in the suite happens to favour
> > > my baseline kernel.
> > > 
> > > After increasing the batch count, I'm getting pretty much the same
> > > performance for 6.11 vanilla and patched kernels:
> > > 
> > >                         prc thr   usecs/call      samples   errors cnt/samp 
> > > getenv (baseline)         1   1      0.14975           99        0   100000 
> > > getenv (patched)          1   1      0.14981           92        0   100000     
> > 
> > Oh that's good news! Does this account for all 3 of the above tests (getenv,
> > getenvT2 and system())?  
> 
> It does for getenvT2 (a variant of the test with 2 threads), but not
> for system. Thanks for asking, I forgot about that one.
> 
> I'm getting substantial difference there (+29% on average over 100 runs):
> 
>                         prc thr   usecs/call      samples   errors cnt/samp  command
> system (baseline)         1   1   6937.18016          102        0      100     A=$$
> system (patched)          1   1   8959.48032          102        0      100     A=$$
> 
> So, yeah, this should in fact be my priority #1.

Further testing reveals the workload is bimodal, that is to say the
distribution of results has two peaks. The first peak around 3.2 ms
covers 30% runs, the second peak around 15.7 ms covers 11%. Two per
cent are faster than the fast peak, 5% are slower than slow peak, the
rest is distributed almost evenly between them.

100 samples were not sufficient to see this distribution, and it was
mere bad luck that only the patched kernel originally reported bad
results. I can now see bad results even with the unpatched kernel.

In short, I don't think there is a difference in system() performance.

I will still have a look at dup() and VMA performance, but so far it
all looks good to me. Good job! ;-)

I will also try running a more complete set of benchmarks during next
week. That's SUSE Hack Week, and I want to make a PoC for the MM
changes I proposed at LPC24, so I won't need this Ampere system for
interactive use.

Petr T

