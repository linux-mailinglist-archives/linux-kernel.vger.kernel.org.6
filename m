Return-Path: <linux-kernel+bounces-539572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3855A4A5EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03ACE3B02A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF381D88AC;
	Fri, 28 Feb 2025 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+AY5eLR"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345DE23F39A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781872; cv=none; b=C5+zoyAsY3DnzX6ucXW66TaQcRPUtnLxfEqRsurUoedgYFCAsMElBqXI++7xdQ9k5PNWVbFRHUKpPMqglzg2OjwkBE49XiA7A7x0K48c4eCZfR9pCZBVuSSzK1vRmbPLkDZh16SCqYToHDwygUeqctxSNwLis9WC7ctpWWYzYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781872; c=relaxed/simple;
	bh=4LOPtkkRxQ/96b+ValDEXdgDB6o8UX/EDFFRgOMBMVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7Hv3dayjV8Qiq0QbZLtAmF9PS6DtcRsvmFv2YNNz5NCTtsOkxDfJdZHiQq1wRupnura7DgnVZkMVdZgLCa0WA52kp0lDRgAdKBABiPXm6GTxwK/O7WJgoyFzpONK26PpJHXInUOi2BYYRCfwlwDCIK93e4zKSOhIOctrK5U5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+AY5eLR; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5494bc8a526so1811492e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740781869; x=1741386669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGx2ytRm7DUjV7hYYKMdSIo7INk/6F0hVRvX/gxT4jQ=;
        b=R+AY5eLRJL5m5tUBAG2or2aLSk3WP8E9hD0lv8ptNXb2eb9IGXBe9ZENXdZ59HT7eR
         P2ABFRxyMwXjxN90xf9NDE8HEtpqRGhuQKnYRL5UHNktnbeyABMC0RHeneP2DW9XoNdq
         PMnHdxX8pgbtLo6dFfVCOme8cHr2tE/h4ZnENbL0d+FBV4dNkPyuAHs39YXF0xmPs2U1
         uc+ZjLzLoVP/KECgEGDizQVuX/vPZb0Qi0GikIYoAGbqrv1HFkR1o3WnnPxw6Q1fVriG
         qBOVIwEapOJBOB3fl2lbIh9qrGfm25PtsK8rbY/vTRBP72ITD40CGqvazJkPDlJDuZFw
         8lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781869; x=1741386669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGx2ytRm7DUjV7hYYKMdSIo7INk/6F0hVRvX/gxT4jQ=;
        b=MShwh/vv43TlfJXGWOsK9rOp2uaCYg6x6Q01/nGFFFy9AfLMNnhF7aEzZC/wuubTZa
         xBAYI5x2tScJEhQcKcB914cD1RgLoChNZo9LMtvYZsDgHvRO4kyIdeKCsdz5YJLgFWPe
         zbeB2KB/2gRkVcAf8/Wz/jizX4ZsYHnEfDw//BmD4HstWPbJXI+npzENjBQgRWtBlAPI
         e0GTwq0S0gNc46t/kN4tHheT0dTbAgMTWZuS+J8ausKxkIfe+uzD0xahu2f47+ZWKt6l
         ZgeKLu3CdZcyCP89o89UuwpKz8EojQdcAl/eVL9AHCAVOOrwPlQeeYEtVeU0fwcpbujr
         12uw==
X-Forwarded-Encrypted: i=1; AJvYcCWTWpTK8WRICfLWh9deLYEuD1Aa5sfQmyAsKWXUPpohSvJLVQPnfsTQoW96HFy88N0N8q4JL+7/0pAaD8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwH+SWRc2guJfgD/rzBIZubhiAPFm+sgYjfXxY3SXyU3SGy8+
	wSFR2WjgkSci80v10bdv4lVwhIDUyEooW9248OHBBldbvKi5n0Kf2BodX10TG8FZqq8Ip++v/xu
	Og1ljh0oH9bNHgxhwDszBRnFW3/Q=
X-Gm-Gg: ASbGncvXuROy+qL/lApODXGiVStinfcbWmIeGSkpcqh2l/qN/OL5QxnEycWbY+r31qi
	W82UNYnnY5D5BrTebw+BPJK9kloT2+fgpvNTyAs2qPE+GwfbR9kYyezuywJPAcao/piY+1XZihT
	fuxwnVQeA=
X-Google-Smtp-Source: AGHT+IGNNfsciEkYjELFx8y9yM79NeoCyQ/krRiryBA0MOH47ry6xl35fa2d3aSzfnuq/g+h90Eyr8E9/mWWWixu9AA=
X-Received: by 2002:a05:6512:b97:b0:545:2d4d:36d1 with SMTP id
 2adb3069b0e04-5494c127a1amr2011965e87.20.1740781868856; Fri, 28 Feb 2025
 14:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
In-Reply-To: <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 28 Feb 2025 23:31:08 +0100
X-Gm-Features: AQ5f1Jpsth-OnsyRUO_rx_Bd_FAw9y4cpF3mNC4b-OKZbO6KfqZwsOm3HQ8QG5c
Message-ID: <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:48=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/28/25 04:35, Uros Bizjak wrote:
> > The code size of the resulting x86_64 defconfig object file increases
> > for 33.264 kbytes, representing 1.2% code size increase:
> >
> >    text    data     bss     dec     hex filename
> > 27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
> > 27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o
>
> So, first of all, thank you for including some objective measurement of
> the impact if your patches. It's much appreciated.
>
> But I think the patches need to come with a solid theory of why they're
> good. The minimum bar for that, I think, is *some* kind of actual
> real-world performance test. I'm not picky. Just *something* that spends
> a lot of time in the kernel and ideally where a profile points at some
> of the code you're poking here.
>
> I'm seriously not picky: will-it-scale, lmbench, dbench, kernel
> compiles. *ANYTHING*. *ANY* hardware. Run it on your laptop.
>
> But performance patches need to come with performance *numbers*.

I don't consider this patch a performance patch, it is more a patch
that fixes a correctness issue. The compiler estimates the number of
instructions in the asm template wrong, so the patch instructs the
compiler that everything in the template in fact results in a single
instruction, no matter the pseudos there. The correct estimation then
allows the compiler to do its job better (e.g. better scheduling,
better inlining decisions, etc...).

The metric of code size is excellent for -Os compile, but not so good
for -O2 compile, and measured results mirror that.. In the -O2 case,
we actually requested from the compiler to prioritize the performance,
not code size, so the code size measurements are only of limited
relevance. The purpose of these measurements are to show that the
effect of the patch is limited to the expected 1% of code size
difference.

I don't expect some noticeable performance changes from the
non-algorithmic patch like this. TBH, I would be surprised if they
were outside the measurement noise. Nevertheless, I'll try to provide
some performance numbers.

Thanks,
Uros.

