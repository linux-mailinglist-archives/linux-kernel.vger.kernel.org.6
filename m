Return-Path: <linux-kernel+bounces-529952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB56A42CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F0C7A2B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8B3204F8B;
	Mon, 24 Feb 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NjqEf9To"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C52B9BF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426012; cv=none; b=sVa0op7V9+dCXpFmq6p4u9/LtGDRCflCmCAf2bGwudWduRmZEQjEqW8AEyHrzYRxDB3jg7xbrvHzUYpLVOHMWtPtCQZoAQBBGbVrZ/U0eH1eqzu15842Al81I2tSCGaxokm1DP4YsO0uTF+Nn6xYEXHZcMGcCDsKMnEQKTMPXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426012; c=relaxed/simple;
	bh=jjo3DCB5gJAuKxWQFmPKlMM3UGP5qto/Mwx+MnTre2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=V8hYUav/G+roQ/OVVBy8YPvn16wzibo6Q4Npjr5pFjusvoXfGJjLfrPHV1Q0majTlBywVk8A/tOIuuFNK87olTy5cnlxNXAo5UKg34K/yH5dZZEC7t3jsE8QWDnhh9uNyAOZFpMvzVl7YJULw8M+lleGSBqDohIV8SuyOBCpt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NjqEf9To; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72726a5db1aso515702a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740426009; x=1741030809; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjo3DCB5gJAuKxWQFmPKlMM3UGP5qto/Mwx+MnTre2w=;
        b=NjqEf9Totnh0QDJqlKRAI6O2/DtSWEOZDBVxtO2r40wAudxObJmpXoaCDGAEmD935z
         3HjOFSHNeAQ8MniqDObD/LNwJndWEs/JBkZV9AKYRhXxdS1C4h0SONJHyMiOeTuDQWHf
         h7NrEMyyqMwFqc2hxFHrZvJat1oNj74gWjJ70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740426009; x=1741030809;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjo3DCB5gJAuKxWQFmPKlMM3UGP5qto/Mwx+MnTre2w=;
        b=R1VFY8H8ajkkNW6o7vxGjV9XstyK0P1jDGUN/X9zUYol/8B1ySblN6CJy/a7HMmd18
         +n2J5XuRBMoSKIDfQgsAuAj7FkHsMlEAwuRymz/YBU4DQYv89ilw/hGrX8sejNVdbAE4
         b3qe61t/ZINc8WgikK0dEkXnSpVGj+HCVznAs2Qm67Ue21V9SDzJ94eatZqES0pBPT54
         s8Ay8zgEzPN9mqDZvujzNIyE6/3GGGjuQXlCHsXsTWFpjlyOY3wXy6oKMvhaC4DyafmB
         B0BDv+EJmmy34p+1AgybBe7DN70luviP1UnKp6qKCkpYrWvLEvaRZUy5BVZRNqsQmnfe
         ULrA==
X-Forwarded-Encrypted: i=1; AJvYcCXwcSVt8xvk9VGGGK/2lxsm6m3GhppcOkidvoZTc2RS0t767Jie49tySvgIfEOIi4RBd1RRETX3NQJg9Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9dZpReqxZ7Psg6lLi0CwF0RBWk2XFfOMWzKHtrX5/xYOVz0V
	Im9vZbjsQDcf52Ag1EcqZlq5AG4VJPrKw0MnsX1LYmooMrgjI8TvPG0rGsDxueP0HERNo9UfNA7
	QjL/IJOm3cAFSq5DEZ0GO/d8+pyCJ5A0zTV10
X-Gm-Gg: ASbGncsnBMh4Bk1uFxNNS1XVfWMCbZD6YY+AjvJ3eHugaO2kognbFsdUWfJkYJg4NCe
	0YQNr7vz7R6FkyovdRMsUVfV4UeMbKYvJ1cCNM6D9IKgxexnIwV8ymkuTZxtQltCUqg7up2d7p2
	SoVK6qo176+bbiHL8ZqwQS9z+zRj6e7B1qRmOT
X-Google-Smtp-Source: AGHT+IGWt4RiFKwGN9imhadTo5MXXk1b6QQFMgDJMWwSygsMoh1MZ9ZA63MJQ10dxfaIqmQAhr3shgJlB1Vp4bkXouA=
X-Received: by 2002:a05:6808:201f:b0:3f4:11a1:615a with SMTP id
 5614622812f47-3f4247a9cd8mr4214905b6e.6.1740426009055; Mon, 24 Feb 2025
 11:40:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com> <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
 <CABi2SkUfABFR+SpjBzHT9dEcsJ0OOHiyttKkQVhqrHLrtZzopA@mail.gmail.com> <gr4i4o7cy2nxah52kiyglzl4ax63zdblvwqvqbdl7vhlfdy3ko@izskzrcapjxq>
In-Reply-To: <gr4i4o7cy2nxah52kiyglzl4ax63zdblvwqvqbdl7vhlfdy3ko@izskzrcapjxq>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 11:39:58 -0800
X-Gm-Features: AWEUYZkzU0yEfaz4ODfBE0tPPx4QdLJ1gi9VHaTZHUQGnm7_jSep0PCoxlmlNIM
Message-ID: <CABi2SkXew-7bDD5c6ZDhbM3kRQPMTXrq=1cXX1rUvy1Yb+XvAQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:18=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> Also, do we need something like the above test for VM_SEALED_SYS?
>
Do you mean adding selftest for sealing vdso ? or test the
VM_SEALED_SYS macro in 32 bit vs 64 bits ?

CONFIG_MSEAL_SYSTEM_MAPPINGS is by default disabled. I'm not sure
about the common practice here.

I also don't know how to detect CONFIG_MSEAL_SYSTEM_MAPPINGS from
selftest, that is needed for the selftest.

-Jeff


> Thanks,
> Liam
>

