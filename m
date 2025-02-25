Return-Path: <linux-kernel+bounces-532637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E38A45029
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A4B3B4C01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1472213E74;
	Tue, 25 Feb 2025 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NoC98Hp0"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2BE2139A2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522424; cv=none; b=X4cROlbu94G+t9nGpPR5kB+uwFdiZ1ZVgsXaUOZsIi3JDb8drr3/1T3DQO279kVayN4y1nIfW5BxwrVSaZ8TN7fYbFYrAI5Y3cWob0DuoCG4ObmD3e3HNXXwfQtZ4Xlzzke47Bu3mxqlo+Wzk/lyIia3OnzYEyUAEmWWTZ0NQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522424; c=relaxed/simple;
	bh=ueH8v3kAhGtMl1UaJ8GyVYQK+IqP2YvKKitd4jbFMlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rpzj9xlOmmYXEPxqpKAwVBkuqgCVJztpz6czLI0DL9tjNCZeIXoOgdeGBifgEDKUa8q2jwlwk/dxHHS9EIcbeGgkxH42BasTMWT2Sh5A9NKb4k5OFxxl45CxvE2R3to+3UoPeCuRxLlKWaWbVYuPFmMy2OKv0nwG7lw0NaLZUNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NoC98Hp0; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5fd062e9f91so245802eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740522421; x=1741127221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xqOSCFzGcNZ5N5goLofc5rFgMD/6qlIIoCbD7zYyOg=;
        b=NoC98Hp0XC1o0kee0R/XAklgGEYt22idj9mbWZ6Le8MhXrrFypJjoxRjRYFzp44sLw
         yJAWN9Ey1tEj45czHZyRASunLPqSmilj2bpbslERVUTelC6Z52QJPqFDZxS1oM6UnE2w
         skxnqcWzQnPATTI/tbZDT/c2ezDwYaHGKCNHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522421; x=1741127221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xqOSCFzGcNZ5N5goLofc5rFgMD/6qlIIoCbD7zYyOg=;
        b=xSmCZX+nurWFIAMtK0xyIT7naoDkOcGn74VUxepfRIO44ncwg5Ww3EiSGqBIJe5rP8
         RLMPC14wh64yZl4z6DhAsA4E8YhuvtFUzXMF8kXB0+7HCSFe95C5QRrtK6B+35gqKigp
         j2uiY1kbJj4rvafkS2iILKgkD8A7W2OMER1yOD911FepQ921V4PsrY74pm1m/n+3YOqU
         JWvsC5YQfeEoxGNQPrRgJHRrw16HGj+ulmHGE/4zh07OSVY00bS888HFP4k0JH45dWOs
         jQkCYUdsUr1y3JsUxCQgQwXg71/ufgY8CARWFFeGI+b4RSKeY172c9J8Yx/tRgiZmz56
         oV1g==
X-Forwarded-Encrypted: i=1; AJvYcCVWyV2BKv21yb55I+eUUybmiDi7jJu+mUFyEIC5aZ6AhT+JTAVc37/jFtV47+bkPLekLe/HLi7Fzl6hfPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5wFMlS3Hp4KjqysqJS+xybpGjq8r3UUkKwU4ntFe2OrJwObF
	aapNiqIonfDaAcmZIT+EDtGTTtfWAkSSv29Byy8aruVglDjlwmzKNCTaWX8W2P0s2IxXfsSxP3w
	19HNhcmgTOhs3lRG9MRUQsKAfwi7feri7ZdgO
X-Gm-Gg: ASbGncumYTDXBGjoJ/2o+EU9z7G0An3FHaCDUZb8aCHZ1j1jUuaeLGpRHAfsViM72XB
	UAFF/l1O+XSg7xfQ6Lq/GuSyxbQaXqnOHo2KP6gRFT6A1RsmjQ+N9P2C3e3sC2WuI3NHjFPduVM
	ffm/TU1/c+KG+tAd8/W00NE/AhT86XresbQeI=
X-Google-Smtp-Source: AGHT+IGrIRM05nqTpSS/aN8tN5ECXM3Wnwq1SCF4hVG6Zt8KUBaf9vuM/b8YblkxFeS8P+eF3vSb9Z8wwra7W+6rXys=
X-Received: by 2002:a05:6820:1e02:b0:5fc:e36d:ffb6 with SMTP id
 006d021491bc7-5fd19395e2amr4484916eaf.0.1740522421670; Tue, 25 Feb 2025
 14:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-5-jeffxu@google.com>
 <899d39af-08d2-4cd9-9698-9741d37186b8@lucifer.local>
In-Reply-To: <899d39af-08d2-4cd9-9698-9741d37186b8@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 14:26:50 -0800
X-Gm-Features: AQ5f1JpEnTIek47kMMdYY3wMb_Ou1MsxH8iLDFczn7mUq9qPucRsYU6MSTAQhEE
Message-ID: <CABi2SkX0oGnqM4BDfRt0+7Pcf31td8np3=dVg1ixcaDNoUyHkQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] mseal, system mappings: enable arm64
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
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

On Mon, Feb 24, 2025 at 10:20=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Feb 24, 2025 at 10:52:43PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
> > the vdso, vvar, and compat-mode vectors and sigpage mappings.
> >
> > Production release testing passes on Android and Chrome OS.
>
> This is pretty limited (yes yes I know android is massive etc. but we mus=
t
> account for all the weird and wonderful arm64 devices out there in contex=
t of
> upstream :)
>
> Have you looking through all arm64-code relating to vdso, vvar, compat-mo=
de
> vectors, sigpage mapping and ensured nothing kernel-side relies upon relo=
cation?
> Some arches actually seem to want to do this. Pretty sure PPC does... so =
a bit
> nervous of that.
>
Can you please point out where PPC munmap/mremap the vdso ?

Previously, when you mentioned that, I thought you meant user space in
PPC, I didn't realize that you meant that kernel code in PPC.  I
tried, but didn't find anything, hence asking.

Thanks.
-Jeff

