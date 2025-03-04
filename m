Return-Path: <linux-kernel+bounces-543748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1EA4D951
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB907AAEB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FF31FDE00;
	Tue,  4 Mar 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/b1bQ1x"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91E21FCFFE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081981; cv=none; b=VEf8m/i849aRVc36RoSUxt5+QmywCRmUwGZWoqxWVqx0TEsNqzdkucFpMTDJ1ngRbNRryU4+CxAmuI+99cb6Mg8HV8EgxwyHIiWdvf9auX7DzLxl0292zcC6I7+grkpIvzQlwCWmlALReEVwYWIyQ/0hntXlVLeJO5HfEGtrKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081981; c=relaxed/simple;
	bh=N65vm+yMitUOa6PorrGP5MJXpUvZnShqu3EHzk6Rsb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHoBDYNRbFRODO+QvP1TAJ3Kg/9TNLWvF5HruSl7eAneponPu8LxkcC81SiRKE2i3cCw97mJXty6l2GfG607TEnaevthaa+JT2j+9S+iC8giNn+LyCS17lhNI4el8X76nQRWbTwCLDMPmLZfmdhVj9UWt/Kf8iMVCEWiSQgs6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/b1bQ1x; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30baa27b209so24880811fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741081978; x=1741686778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2tMt7aQEDnlpZ8I4PlW495ifYNs/8gPe/72x13C7qw=;
        b=Q/b1bQ1xFug3x14Mrp1jvKp1R8Cv0fYAH9PxMpny8icIU0I5gYMMG57COlcSuOUyku
         08PiKdeLr6euhcFE0mPLjO7JFWrQi/gHGSvtp1pUgZ4fIBC+Kfo6JSp06wCV9mravYQe
         RxDR9ZhjZUz/2eztN1SO4NppsqAk8hHpeeMreEE2xSBG2Q3UQChrDvfCfpTcV/MnbqTw
         1o9z7Lzj7Yspai/tFP0h5aF8ICNhPTzqjC2Z1dr98iFmZD1GCaToliQnWN3014a5BrtN
         hm/R1aKJ4L4zQ4+7tGY4G5jLUNwA0Fy1xpHm4SWagTcEqLtSZBbp9q0IRrJF4czULx80
         8iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081978; x=1741686778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2tMt7aQEDnlpZ8I4PlW495ifYNs/8gPe/72x13C7qw=;
        b=I3x1R8sJLm6oAkiNe2arfnTFSsUf2OwTsSK62jSOlO0U05Cj6WYpOYhskULEtv6n2T
         kRptO0J2rTwsdlBeRMgxJFyc+pW10692LtCrE5jtfc9uzjpC2GKte5dnryf9RajpoPdq
         GwiyCyQQb04FCuwEgc+tGqAS6E8LzY1wnz3JboUdby8xmGLbL1XtRUFqD6oCDonshvAx
         WZKXOhHIN6Vcj09xq66iaRmgWSSoliQiW1SnjjEPS06XxJCqO6K/XSvhl+7t24w11o/L
         M+78BSyWhFOfv0oqL9w3pm0JNvEDSjaHdHccXdodbH2KH6+bKhRBLphOb8Gu78K5z8xf
         a50Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+JN4WTF1qBGASqxbbWQ7kRIV1IlGb6xlqs27TRW6gIE9JikskYhU1KmbTNMJx3lmIYVmmcHalNsQ5CtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HqI8vzueAK3udcroSt0FWD7pMavYA3N7PPUBoJPqmnkPrFQT
	qsqv4X/y06MEi6j+hozAmaBvzz2yVntHvgXun8++yEpCPKwylqvhkTKXe4Hr1izHfDCBPLhUv+S
	MdilPm0ZFPTqrBNDMQEJAMcRd9Nw=
X-Gm-Gg: ASbGncvIPtEMCjE04olQF9DxIOAStMbZe938w1IdAwd5irTbtzap2ASOtx5ICDo4ybl
	PVPFHPeLmKIHPIf12dQloAUM7L6f3C094J5Dzb7KH7DrCX5UDk0TCcHCqjgNsktJv8P6TRJnlEH
	TtfX24WMxvBAqt9u4YYNdp9iPDcA==
X-Google-Smtp-Source: AGHT+IHWEblPcZ92dm6+jZZeDsi/0kW7AOHY1C+BHh3e47BIoTD2jA51jocNKtzMomxBhsUNBXpUT1SoFV4cEkrX2Ik=
X-Received: by 2002:a05:651c:4107:b0:30a:45af:c18a with SMTP id
 38308e7fff4ca-30b9345fe52mr40905581fa.36.1741081977431; Tue, 04 Mar 2025
 01:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303165246.2175811-1-brgerst@gmail.com> <Z8YTYWs-DeDHal1Q@gmail.com>
 <CAMzpN2iB4Gv0Fq1pNtk7bpa2z6eYwQGYXT0=p=_wWDBE9Uxa7w@mail.gmail.com>
 <Z8a-NVJs-pm5W-mG@gmail.com> <CAMzpN2gpHRtOtRuCJF_TKOFbEJ2xkksndCH+MfntfDuZHC0O1w@mail.gmail.com>
 <Z8bMSr8JrDZtqwK8@gmail.com>
In-Reply-To: <Z8bMSr8JrDZtqwK8@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 4 Mar 2025 10:52:52 +0100
X-Gm-Features: AQ5f1JqqL6hg-ZtuYKzv4yx3kUTSZ74nIUcIe0DXP6LQq2A46JkQfI85SXbJl2w
Message-ID: <CAFULd4YFm-2Sc6NOzyWt4-TPDkwY-=5h-Gb99M+tFf-Mczk0Ng@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add a percpu subsection for cache hot data
To: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:48=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > On Tue, Mar 4, 2025 at 3:47=E2=80=AFAM Ingo Molnar <mingo@kernel.org> w=
rote:
> > >
> > >
> > > * Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > > >
> > > > > -       PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> > > > > +       PERCPU_SECTION(L1_CACHE_BYTES)
> > > > >         ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <=3D 64, "=
percpu cache hot section too large")
> > > > >
> > > > >         RUNTIME_CONST_VARIABLES
> > > > >
> > > >
> > > > That is probably the right call.  The initial percpu section is jus=
t
> > > > used by the boot cpu early and as a template for the dynamically
> > > > allocated percpu memory, which should account for the proper
> > > > alignment for NUMA.
> > >
> > > Okay.
> > >
> > > Randconfig testing found another corner case with the attached config=
:
> > >
> > >     KSYMS   .tmp_vmlinux0.kallsyms.S
> > >     AS      .tmp_vmlinux0.kallsyms.o
> > >     LD      .tmp_vmlinux1
> > >   ld: percpu cache hot section too large
> > >   make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> > >
> > > (I haven't figured out the root cause yet.)
> >
> > CONFIG_MPENTIUM4 sets X86_L1_CACHE_SHIFT to 7 (128 bytes).
>
> Hm, to resolve this I'd go for the easy out of explicitly using '64' as
> the size limit - like we did it in the C space.

Why not simply:

ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <=3D L1_CACHE_BYTES, "...")

?

Uros.

