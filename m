Return-Path: <linux-kernel+bounces-221888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F890FA1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32F3283B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2FC386;
	Thu, 20 Jun 2024 00:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="VHPq+2sn"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB817545
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841760; cv=none; b=u1WGFZdh3G6PZthhcvxKRMgf5V5NcLl57Git5vFQc75VcVxM7SRwNFZZhvKB/HsqI392VOXCzsmL9qOXWnLNo3TDKqa2ukkG94GH26JBYqzuG8Pls9Ffpo2bZRVXENDXkYTdxpT45Q0Q+3HiNc9eVZsiwoKSQXeT7Jw8/AOSYB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841760; c=relaxed/simple;
	bh=XmEnzCfhw4+kf66WwT7z0PCQSHQsh8LMjnuOH1bhp4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLcVeSyZhMEsGrHhQVbrUs0HQKX/GlY+jrMW611ZN2NFQt61UBs7jZEVWsZlaP5QNcE1mZRMCgdLqpM7VJ6o1rJ2XEstXyU/E6gs2q+3LM6RAaW/CjpOT5/X8UI1sU278sudirzEEwNnfA/NdnxI+96lZnguy7Szc30JyPgl8mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=VHPq+2sn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c70878c54aso60068a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1718841758; x=1719446558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmEnzCfhw4+kf66WwT7z0PCQSHQsh8LMjnuOH1bhp4M=;
        b=VHPq+2snq61YHSStEzI12eMXrezsvSZlv/OXG1NSmLL02IVJ7CH+nx0yGwujhDjHve
         6/CthFJAaK7bIz79vSt8fBLAp3Vhay/E6zZuH2RKt51lcyDgs6jUQ5zdMMB9746jz5Jn
         83V+xdTFiD/O8udgMFxPT7qWvmu5wq6vikA89bb/uAu+qsL4siVgRUjKK0Q7E9Q8CkLn
         xZy9nGY4X6O7F0l7WYsOf20yEnRmQ+hayCqFNKJRGEYgSc/B7H5XKNtpgjMyh3SCd/oA
         TR0toz5ryuzg7G3kAwNagQ61YpdsjUeYkzf0b1n21viUK7BPWrNA0qyvfsEsBIZlLTQl
         /RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718841758; x=1719446558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmEnzCfhw4+kf66WwT7z0PCQSHQsh8LMjnuOH1bhp4M=;
        b=JsW+Y0/p7Q+F81YTYHqI6uXwT7ZgWlMlbX0Adzm6UOU3scld4AqnZbqOSmXwcpTbtK
         HvoQvzBeXs/Ph7RELREjUT5RAVOEI4X4U5Km7SWywP9Tzkp790wx2ylrTDHpEU7AFqT3
         Anqp7W1bm59UrwGCW4Af0TSTKg0GgmV8UyG2NlfMgDbZfODn+treJ4boGlVi/rnPTw7u
         kArSkDkRwRh1lPaEjjp7FACsdhcqzvmB7c/nxpcnLybpGOZjn93xSrB1lqMoSTU4UfMn
         PwsoZYx+Zm5UcewhPTG6J1l1YrjalQLtOehs5HvyIjt0GMkyjTcYZnPWZGYMt99P8ShB
         MWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN4XbVZdfGhBGYdyIiwZ+lbUJELQR33NbJYmJ8twmJIIJ9kpIjsov/iluR6dVTk3ukH/pNiARymxhEz26SMO1cRNrKMz8V81Ip+O8w
X-Gm-Message-State: AOJu0YyK5CcCPspdBxQJY3QLaoUgHEhsyF+fbi0zG7d39EL69mHZyQEG
	7QbNIBfbSZoz0576AGnfOI0c8J9imVY7n02x8vi/5j8DxFM/m1AMqfpe4rtt/revbVau7foBc3f
	Nq2KTgfULWO6yf24rKsv+fN0QhkJviUuPD/tU
X-Google-Smtp-Source: AGHT+IHYX3vliRVrsmoB0EDQ2BRZZRzZMQiuiJHi/weJF3V9+Z+ue117XEcEjBHBAW1NYoYcEBNysniOEZmXy/iJPXA=
X-Received: by 2002:a17:90a:fa01:b0:2c4:d63b:cdf with SMTP id
 98e67ed59e1d1-2c7b5c83afcmr3848050a91.1.1718841757779; Wed, 19 Jun 2024
 17:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616170553.2832-1-jszhang@kernel.org> <20240616170553.2832-4-jszhang@kernel.org>
 <ZnMPhcaTKFRbbE1i@debug.ba.rivosinc.com>
In-Reply-To: <ZnMPhcaTKFRbbE1i@debug.ba.rivosinc.com>
From: Cyril Bur <cyrilbur@tenstorrent.com>
Date: Thu, 20 Jun 2024 10:02:27 +1000
Message-ID: <CANtDSipXbYSuz6NakbXw-8k0_ZN5hdT7VWMushXvQ5VB0Am_Ng@mail.gmail.com>
Subject: Re: [PATCH 3/6] riscv: convert bottom half of exception handling to C
To: Deepak Gupta <debug@rivosinc.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, Clement Leger <cleger@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 3:04=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> On Mon, Jun 17, 2024 at 01:05:50AM +0800, Jisheng Zhang wrote:
> >For readability, maintainability and future scalability, convert the
> >bottom half of the exception handling to C.
> >
> >Mostly the assembly code is converted to C in a relatively
> >straightforward manner.
> >
> >However, there are two modifications I need to mention:
> >
> >1. the CSR_CAUSE reg reading and saving is moved to the C code
> >because we need the cause to dispatch the exception handling,
> >if we keep the cause reading and saving, we either pass it to
> >do_traps() via. 2nd param or get it from pt_regs which an extra
> >memory load is needed, I don't like any of the two solutions becase
> >the exception handling sits in hot code path, every instruction
> >matters.
>
> CC: Clement.
>
> I think its better to save away cause in pt_regs prior to calling
> `do_traps`. Once control is transferred to C code in `do_traps`,
> another trap can happen. It's a problem anyways today without CPU support=
.
>
> Although with Ssdbltrp [1] extension and it kernel support [2] for it,
> I expect asm code would clear up `SDT` bit in mstatus. Whenever `Ssdbltrp=
` lands,
> I think `do_traps` should expect nesting of traps and thus cause should b=
e saved
> away before it gets control so that safely traps can be nested.
>

Is a possible solution to do both options Jisheng suggested? Save the
cause before
calling do_traps but also pass it via second param?

> [1] - https://github.com/riscv/riscv-double-trap/releases/download/v1.0-r=
c1/riscv-double-trap.pdf
> [2] - https://lore.kernel.org/all/20240418133916.1442471-1-cleger@rivosin=
c.com/
>
> >
> >2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
> >alternative mechanism any more after the asm->c convertion. Just
> >replace the excp_vect_table two entries.
> >
> >Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

