Return-Path: <linux-kernel+bounces-313970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4FA96ACFF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E22D1C20EAE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8CA1D7992;
	Tue,  3 Sep 2024 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="PT8+wQmW"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A621D6DBE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725407015; cv=none; b=hrKvw+ZbcZ6yBLiSJ8r4HHDemStosRPBifEP/gW+zyv+Wd+ZxDwCALctSjkmCXXDg3o3yecU+KgzXCMi8JW0gj2cNsfExy714fIa7ByEYSHQjV/5vctAqEI5lnXwO5IWiAe0wifBeo5L4MzE0i03Q5nnBb0pGMLDNTocm6YEvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725407015; c=relaxed/simple;
	bh=dRWeIz+ubJrojnqheq1wHauzuvHp2VInC5LvS5KJ2X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+0UiQa5GC/81Qi6asWADL+yu6JDHgne6q/Yi25Zvs+gbu7dLIceCvpJYESiBYRLhm7eFuYqIsCPHdara/zZQQ79a1GWl/dednizjtDg3FurkPdnBIEA+l4Sv7TOjgBim4JhH/KDF+1hiW9MAwMZnBwUkek2eTuKi78/Y7oblDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=PT8+wQmW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6bada443ffeso1503817b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1725407012; x=1726011812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlCnxIZL2Il1OI5y0fydGu2G23DBSVnD0BItXQgCoF0=;
        b=PT8+wQmWS6MLQDBhaDKPBexl0TYL/Vp+WmJou8jm05d8Da5MkPa1vpatT3N0DSyUnT
         ZU61ZMcBLhIAENUmi+Uow2opRfG+xX7ynrsvrBpneCl07GvloTrOBzkqq4UHe2JIhO/q
         jLzpl9fVdfyry+RACyuyt9D3JPHL1QegtbnNa3w87Xe5vsU2R02zhUsG82PWb78iWCxw
         llFJW+XxV77O4N/ycoSJe4zxD8L4B+BDpAqdyTljD/mFVJy9vCd/6fINN9cAzNaGBWgn
         hpFiEa8/TMU0Jbi5hUSDECi8/bfs0Md4XjEGBxaNOsuNio3ziJltKgqSWMHxYWWGXm09
         zKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725407012; x=1726011812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlCnxIZL2Il1OI5y0fydGu2G23DBSVnD0BItXQgCoF0=;
        b=KCb42BF6kFLn1tLLv4LRVjZdTBdJDalW86eckvKAOHazhMQRN4kPJJIz6iNGs7mcSM
         AuHezi+kZCJdrQCHXzDXHqv6Q1N59omp9F+kvgGCeryRy7ZFY5nl+DWxH9oXP9j1i/AI
         ml5bAJjAx/ZyeUw8pP7AIk5CBloB1EQQSDptnlY4ShYdmM8vcgEZ7vj873k1GAu6x9/J
         FK8q6giox7+PFctVN+hNAIAKiUv0aEqfUhJ4742CLj7xKlU68Ar8sMmr0nv3XPYcZ77Q
         PFYeegpdJoxpY3uinVAYU+SNiCQNevLqdqTXAbyDdQSMYzkF5hi6JMbEQYI3wvE5t6Jr
         3zFg==
X-Forwarded-Encrypted: i=1; AJvYcCWRIIUzL+l+ThRUiMrgunclCBAEa2qfepO41JJo/p+S1AyOyyPSm9aEqUshZpCdhAKep9XUnEPMySioSjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoP88voh/ZppH9o2Rj1wUND16K/oVutXeSlfwSXu0a3giuU4Fu
	3dfLdMQqGQxmq8BOPNAzLFZKBY93bSKVqEC6Bu2L7kFwwgaOnTHVWgzcQEnSjK/djJEwty/IsnC
	Zt9PeiQRQKkS9Z5fTp9lEisI2iTmgFJwS1OzLug==
X-Google-Smtp-Source: AGHT+IFrQMIAF4flYNUpK76WrQSCNNRsT5DiFAql0jr+5EnBkw560S9E7XVDmYuoVKDvvbmn5wWUKdeul1GdgNXPNN4=
X-Received: by 2002:a05:690c:2891:b0:64a:445c:6 with SMTP id
 00721157ae682-6db25fcd975mr1453357b3.17.1725407012635; Tue, 03 Sep 2024
 16:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <62F5EEA0B866E9E0+20240903130606.292935-1-zig@iorw.io>
In-Reply-To: <62F5EEA0B866E9E0+20240903130606.292935-1-zig@iorw.io>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 3 Sep 2024 19:43:21 -0400
Message-ID: <CALNs47s8Qzbckjf_f_-Cr2rVmAf4sbo1MaSBFagdhZS4KcpQNQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: arch/um: Rust modules support for UML
To: Zigit Zo <zig@iorw.io>
Cc: ojeda@kernel.org, bjorn3_gh@protonmail.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	tglx@linutronix.de, mingo@redhat.com, nathan@kernel.org, 
	ndesaulniers@google.com, gary@garyguo.net, rust-for-linux@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:10=E2=80=AFAM Zigit Zo <zig@iorw.io> wrote:
>
> The series make Rust modules running under x86_64 UML, as a supplement
> for the previous work:
> - https://lore.kernel.org/rust-for-linux/20221217044436.4138642-1-davidgo=
w@google.com/
>
> The previous work by David (many thanks!) has made the Rust UML compiles,
> and for the builtin modules, it works as expected. But for loadable
> modules, the UML will complain
>
>   'Unknown rela relocation: 9'
>
> when we try to 'insmod rust_print.ko'. That's because the modules are
> compiled against '-Crelocation-model=3Dpie', makes the LLVM treat the
> modules as PIE executables, but they are just static modules.
>
> Besides, the Rust's code model for x86_64 UML is still 'kernel', leading
> some relocations "overflowed", we keep it the same as 'KBUILD_CFLAGS'
> set in UML ('large' here) to address it.
>
> Now we can test our Rust modules in UML.
>
> Regards,
> -- Zigit
>
> Zigit Zo (2):
>   rust: arch/um: use 'static' relocation model for uml modules
>   rust: arch/um: use 'large' code model for uml

Hi Zigit,

Thanks for sending this. It looks like the patches may have gotten
split from the cover letter because the In-Reply-To header isn't exact
for whatever reason (the two patches reply to
<20240903130606.292935-1-zig@iorw.io>, but the original has ID
<62F5EEA0B866E9E0+20240903130606.292935-1-zig@iorw.io>).

No worries for this initial rev, but just double check this if there
is a v2 :) archive links of the individual patches for reference:

[1/2]: https://lore.kernel.org/lkml/FD7D773099A0C7EC+20240903130606.292935-=
2-zig@iorw.io/
[2/2]: https://lore.kernel.org/lkml/54FC087D02C52990+20240903130606.292935-=
3-zig@iorw.io/

- Trevor

