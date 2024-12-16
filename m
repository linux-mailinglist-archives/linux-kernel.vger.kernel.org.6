Return-Path: <linux-kernel+bounces-446809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1839F2963
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6017518861E2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA811925AD;
	Mon, 16 Dec 2024 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCkmTzGI"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE210F4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734325568; cv=none; b=WOFMncIOr5lrE9kb9w2cASBnVSFSIgetJuOuIZiGUsTzYVlnWgTp40OaQUV6APuSKtG5guY2D6kV3hR8RMOnyp2+hvSYUoCpHoNMefvPpQxaCL3sCVHsvTbFAZmi6O0j/fklqZ+wUrBtgs0Dn8MBY3caYF/q21gvPcdrYexAdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734325568; c=relaxed/simple;
	bh=wWZ0zgu8E+iN8nHcNX6Kk6KfdHJSI4HjZiBQTk19Q08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKs2SvxNofmeNEAD22jPfThoRilz7tSAatGiPheLyqUR+X15O8gu7WB9sphoxw/dxl8XlTD30T005n75d71v1GtFuqC+p/hBafVPK2/LhSngM6Cz/FB7sLOmUq4TeDpaH/bM0wcKEIjK5xZa4BiTLOPXEUvRcYmVcTTsInjbUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCkmTzGI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b15d7b7a32so389330285a.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 21:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734325566; x=1734930366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LyAlmSIue1yI2x6sqSoYtePgVLtgmXfHaAKBgrqewBQ=;
        b=eCkmTzGIiTguF76oUDTGtcOuotwIj8W611XD493hiCprHj6sV485mq4nNV+DFIleff
         kWBslb0Q9Rr6Jec7Pk8vsL5oxIH676G7neLAPpV4eSh0ykoFbGpJvTUXHNbC+aoYDvaY
         OqBDlxNDe7PKF5tK2hoPUtISrkEAlwiDvjZlxn6qp5J2ckBbeC+bFXwPw/hjKd2z0uMS
         jIBP1dJFhIs0Snzw4MvW89gKrtfjekneTId9usl1S3io+3JAKZT5PW9UMTxhw/6HSszM
         i5NJdnfpWZ1rKGmEfw3trzEEPYzcICQVEEiRPpNj9/Jl3UbHHiYlaRDeoX9ioVHppJGI
         65vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734325566; x=1734930366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyAlmSIue1yI2x6sqSoYtePgVLtgmXfHaAKBgrqewBQ=;
        b=RaDHWxTO/tUXP2nIqaMz5QTNEQJXKelsOg6kb4B4BeCSCe6W5n2X52kzorZHpcVj46
         yLqLQP+WLFAkHvb54fGkP8VlCHQ6bF/Up2FCDfU5CmN4Df7Hold1ML2Bw7sWbXbb5FrZ
         Qf2Mqdjlcj8rP1ymq7uLWU1XIA9xT4uKsrZd0RqjyfdJK2HW/DzJpNdWobnsNd/5X2ep
         frSGyVk6RX0Ku+l6jLop9ouZmLdQh2zAci5afDr8bWlPSx8V9LVDdLJkkMoY5a10XmxE
         VqrvCDCfsRauw99lsoRhhMHoXqt+FiZV0dLD+db76XxvdwAourbZMBNqaDchVFQApInb
         j5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGN+KFzBQF4fo5blyeV7pOBvQDqyxYrXVNKwxWR9TpT3TOXH5BjjzxbEtKOB+lmeIgNalasXq9UZcBHs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7fzu3Ncw6QjIsQHLeOX/rVwlZE0IVzHdZ2I9cb0YRLFSP+Cdw
	EeKc1loXy9DpP54hkdyWoPQm6GjkigYsyWdku7i08x94R95zvH8Z
X-Gm-Gg: ASbGncvTeNKEZkzS4fCq/m8SYOnb6SmWW4e8yY+CjQxQJI0Z3HiX2AV0wWBaEef9C3M
	C8wRO4bSB3A9aOqIhfWxfIdDRHhjjVHj536fypaYntMS92iaa0a6HlU92Ud2LGxgpwbUcTm3NrH
	74snegxLjbwhznqUke1ay9VQZGgS8UCmHiPRbaKQOg0wgHO5E7Zf/cO0PfpV0w+ltZGu3azx+d8
	Dkq43uG5JdTlSbpoHRrKhvhbn1Bnaur
X-Google-Smtp-Source: AGHT+IF1V1JDBT9DxBXnKsSb9FGOSWHTVrkLz4gC4NnnVANUPFlFTC911pK1N5+IlhRrLEkQEQ26SA==
X-Received: by 2002:a05:620a:46a6:b0:7b6:dd7a:9716 with SMTP id af79cd13be357-7b6fbecc698mr2294512685a.10.1734325566242;
        Sun, 15 Dec 2024 21:06:06 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048ca76asm191276585a.112.2024.12.15.21.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 21:06:05 -0800 (PST)
Date: Mon, 16 Dec 2024 13:05:48 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: guoren@kernel.org, conor@kernel.org, alexghiti@rivosinc.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com, leobras@redhat.com, 
	corbet@lwn.net, peterlin@andestech.com, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 0/2] riscv: qspinlock: errata: Add
 ERRATA_THEAD_WRITE_ONCE fixup
Message-ID: <ohjfp2mwenkmm77t3iwtd6xhuhiykcmumujknqme3yd7hyac2p@j6mi542lmbeg>
References: <20241214143039.4139398-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214143039.4139398-1-guoren@kernel.org>

On Sat, Dec 14, 2024 at 09:30:37AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The early version of T-Head C9xx cores has a store merge buffer
> delay problem. The store merge buffer could improve the store queue
> performance by merging multi-store requests, but when there are not
> continued store requests, the prior single store request would be
> waiting in the store queue for a long time. That would cause
> significant problems for communication between multi-cores. This
> problem was found on sg2042 & th1520 platforms with the qspinlock
> lock torture test.
> 
> The orignal patch is from:
> https://lore.kernel.org/linux-riscv/20231225125847.2778638-5-guoren@kernel.org/
> 
> Guo Ren (2):
>   riscv: Move vendor errata definitions into vendorid_list.h
>   riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
> 
>  arch/riscv/Kconfig.errata              | 19 +++++++++++++++
>  arch/riscv/errata/thead/errata.c       | 20 ++++++++++++++++
>  arch/riscv/include/asm/errata_list.h   | 17 -------------
>  arch/riscv/include/asm/rwonce.h        | 33 ++++++++++++++++++++++++++
>  arch/riscv/include/asm/vendorid_list.h | 18 ++++++++++++++
>  include/asm-generic/rwonce.h           |  2 ++
>  6 files changed, 92 insertions(+), 17 deletions(-)
>  create mode 100644 arch/riscv/include/asm/rwonce.h
> 
> -- 
> 2.40.1
> 

It works on SG2042.

Tested-by: Inochi Amaoto <inochiama@gmail.com>

