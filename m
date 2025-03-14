Return-Path: <linux-kernel+bounces-561672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A296AA614C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1557E19C4D84
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7A20127C;
	Fri, 14 Mar 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDLKN+cC"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FA20125F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965800; cv=none; b=G/n9jeua4j2iTWtIRjKs7pLllNEmJ0Z7lr4fRKjf50J26GgrggiTHL3qB9BePhM5nroLqNeQCljNEhFHfamDjCcwmsHQpTVbo9isgrjyqswIa0WUezybGFmiElO/hX9aKIzBLoSPWJTc20dDIsUlFKxrqHTSwvh+aZASspS4ESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965800; c=relaxed/simple;
	bh=FYhP9WxiS/unZIiZRhXESHNWjLeb4UsOrU75Xarvbxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwVpSaghZiQaiEm2bnZ+vNS0oeJAUyipbe1YtIyHAyTr0TP5iQC2wpCqiWohu4breIuv2KRHrKQf9Lyrzchltk4RfAJFJoKnNC5LTYRhmxSyUQl2rmS1IgtzuBmaYvW5HQRB95uQUywu78GXyLQ6b7G8PLxE5dxVD2t0gepy3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDLKN+cC; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so483032366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965797; x=1742570597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ7EUzDkggWA/pzQu9ZQkMN9eRwOa+n3WjsOJVcqJvU=;
        b=XDLKN+cCU3d1BGL/NiU/Z86s/9/BFlJGLenkURrwToI7RzK22rDFv5NokXYAD5EQOO
         4+5+ZWVxcMmRyaj3uP1nM0vQUs3GJlP9Ejuh2e4FhSUKM3NbjUbsp9icB9F++N1qris6
         ixSyMUR6pUZ5kqSp7+CklKgLC8MuRt72dPl0why1bBDjgD/miiLBWqGqgEzPpdnEVNQk
         2b5ftuGWHZFTCbkcTREbjqmnlxRigXwNz0xpDJ89nAaUh7QUN/LaDSSG2R8iyCy2zNQa
         fdEAtadcD33oV7iXYSU9EBZHMbrErbGgFpBVDXSCkvGJAH/GRk3ipRfJKtX0BpHsyflN
         3PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965797; x=1742570597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ7EUzDkggWA/pzQu9ZQkMN9eRwOa+n3WjsOJVcqJvU=;
        b=Cs7ibrHAvkBRd3PJlettf80RCLyGGDaJFneKWD7Cc2WNphFuTh6htv7YXIRYmLONZe
         opDP+3sWh1jdd+QmznhvyETB0Mfz8ReEtgJNNYshVUi0H5sPfPf+FCdlSlwjMZjZ1hoW
         zJ/tJRbWq+BVw+dP9Oh4C6G35IrTa9AuhPPjGRcjQEYXSxyOK1N9CNOMv3mJa4D0QgdM
         7XFI0BLW6ZP4JRwQRC9JsSuuBrHmGuxVXG80l3YdBso9ztN1XJcANyabaomxxc5oeBX3
         YSY66+uz1i4O+wBQOXO9LfjWweWasbSbvzy9O5h1nYjhVvV/caWn2lbFVJNXOCkOkjIb
         x9bg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2X1TwyHtY1JYczPnIMqkKv/UHDvpaU2iHUG889H9IVHUVUEVlz5ItwCx0tuRldwpP+Icv/bgnNqT/5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2d8PFmJ77nd6tilMytODmzSb5NGUv/+m7fv91uWIuslTVTbp
	9cMb8JrlU77vy1+ylUjAb9ANESUmdpp96rFFCxYxDTTo2XVHGnrkBJnQt9yj
X-Gm-Gg: ASbGncuSujDx4YaXGamwmxjpQtjkEp8udCRKu2HJRgfc0KBFywxsE7i9kCjjg22BK9W
	AU2HMV+HFv7UxqiVT+MtofnbxvKz4S/LxM+6IeSudx+/wdS0nJNxJAvHe3d4Xjw0r1T+PqGnUsC
	iur1lh5v+5cplOr+xF0GxEga4WU96/hiVxm9t4rcrD+7YybU2EmyL0t8avT04J9KrawbMuaJZ4N
	ncWELtmfJHu84RlebNYtO3m7KyWAJgnZ/FftoiKWVumuc/LX+pUYJlbwl5pUKf/FOz9dnSVdxzV
	D1jJBQVdzyLMgAUx+/gMccMbTQMgwbyAftn+cWmS
X-Google-Smtp-Source: AGHT+IFRZHaKw/M0LwPzqxvi7UcpNKMZqHHUGZAlPcs/3janJF5m6KNqjVQYLlLF7g1QT60YMvUAsw==
X-Received: by 2002:a17:907:6ea9:b0:ac2:510c:a3cc with SMTP id a640c23a62f3a-ac330129f06mr347515366b.1.1741965796739;
        Fri, 14 Mar 2025 08:23:16 -0700 (PDT)
Received: from andrea ([31.189.82.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac31484b0e5sm235067566b.76.2025.03.14.08.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:23:16 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:23:12 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Andy Chiu <andybnac@gmail.com>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, bjorn@rivosinc.com,
	puranjay12@gmail.com, alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com, greentime.hu@sifive.com,
	nick.hu@sifive.com, nylon.chen@sifive.com, tommy.wu@sifive.com,
	eric.lin@sifive.com, viccent.chen@sifive.com, zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: Re: [PATCH v3 6/7] riscv: add a data fence for CMODX in the kernel
 mode
Message-ID: <Z9RJ4D2VdtNmfpqC@andrea>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <20241127172908.17149-7-andybnac@gmail.com>
 <87ldtck8k0.fsf@all.your.base.are.belong.to.us>
 <Z9AwF5hwF0ES9Grl@andrea>
 <87ldtbwrdb.fsf@all.your.base.are.belong.to.us>
 <Z9B8vgdTq1M9r3_k@andrea>
 <CAFTtA3NawdhM3fF_xc9a0EogaejHGWSxhWGre+FpLeXH9J+q5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTtA3NawdhM3fF_xc9a0EogaejHGWSxhWGre+FpLeXH9J+q5A@mail.gmail.com>

> I found that Apple's aic irqchip uses writel_relaxed for sending IPIs.
> I am not sure if it is a practice using relaxed mmio in the driver to
> deal with IPIs. I am more convinced that driver should use the relaxed
> version if there is no data/io dependency for the driver itself. But
> it is true that a fence in the driver makes programming easier.

I emphatize with this viewpoint.

Perhaps a first counterargument/remark is that lifting those fences (e.g.,
irq-gic-v3) out of the various drivers into core/more generic code would
mean having some generic primitives to "order" the stores vs send_ipis;
however, we (kernel developers) don't have such an API today.  Perhaps
unsurprisingly, considered that (as already recalled in this thread) even
on a same architecture send_ipis can mean things/operations as different
as "do an MMIO write", "write a system register", "execute an environment
call instruction" and what more; as a consequence, such matters tend to
become quite tricky even within a given/single driver (e.g., 80e4e1f472889
("irqchip/gic-v3: Use dsb(ishst) to order writes with ICC_SGI1R_EL1
accesses"), more so at "Linux level".


> As far as OpenSBI is concerned, there is a wmb(), which translated to
> fence ow, ow, in the generic code path. Regardless, there may be more
> than one flavor of SBIs, should we also consider that?

For the sake of argument, how would you proceed to do that?

Let me put it this way.  If the answer to your question is "no, we should
not", then you have just showed that the fence w, o added by the patch is
redundant if riscv_use_sbi_for_rfence().  If the answer is "yes", then I
think the patch could use some words to describe why the newly added fence
suffices to order the explicit writes before the ecall at stake _for each_
of the relevant implementations.  IIRC, the ISA wordings for ecall (and
fences) do not appear to provide much help to that end.  Hence, to iterate,
I really don't see other ways other than digging into the implementations
and asking the developers or the experts of interest to achieve that.
After all, what I'm saying seems to align with what you've done for (some
version of) OpenSBI.

  Andrea

[1] https://lore.kernel.org/all/6432e7e97b828d887da8794c150161c4@kernel.org/T/#mc90f2a2eb423ce1ba579fc4f566ad49a16825041

