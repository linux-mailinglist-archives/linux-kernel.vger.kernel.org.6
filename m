Return-Path: <linux-kernel+bounces-556133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A86A5C151
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6657F3A5F98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93DB256C89;
	Tue, 11 Mar 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+TNxXOU"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A6253B6A;
	Tue, 11 Mar 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696453; cv=none; b=RFucZxNul1tw010bNaP6c4bw9KIhdaZ590Vy+FAbuVLfIUgpIKar1ZPpfdLZuaVTgMD0MTvN1zKgpvGTTURPcQYtOx6+kIzhyb4F97lypBetJE1Fo/wKi5xU8ok4wBU680Eq2sj+73MLjulJ0VflbTff85RpG25UeJerROFrdUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696453; c=relaxed/simple;
	bh=addBakMJtFipeP5Dm9M+uBzjJaYdDmTB6XxVM3YiFNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b29Poll4WUDMFTMg01mhRdDyN5eZU7ElC/fygNGs1umXJDRcXoao8jSZCVETJrXOjvQj5qkWwss6LUbTHXbhgaY11xjHuLyDmNDrRDXUlyneYlq1PbG7YGmrcA6Bd3Gf/VIiKOdUL8xRXJqoQXdyxJMxhm7c1WnQp2Y1et+aDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+TNxXOU; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3bf231660so558493685a.0;
        Tue, 11 Mar 2025 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741696450; x=1742301250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m1ZxqjyMUd+isnYc/2JZqNQs5zU7eDZecHhSMewZT7k=;
        b=B+TNxXOUESk9yQpQv+5qmeChu5CC8kSE1wwoCtyl7amr2MuqPf0dpirEQFUXrwvqth
         avV7uVarGsNVyKyDVhslvfhOyC6/OIdM4cFArFnn95j3GrZv0y2rPAzfmweeFafHtLBP
         B6GItnEejDvx01k4wVa95yXyEqeqdyyHPLtxC8Q5io8Wu0Pq3I77AyyXOtKhKGYZEpZp
         FhEEKaO8ZUdL6ObWBX0DGfbw1XK/JvExo2tbnesMLFUIMrdFr7O/LSZADZV+acAJXfaF
         +c4YLAV6fztuSn4SlNSwZHT7rOsr2QQY+xMeR1pEg4xyIyI5f2WSvwtP6AkcXxi5Ysyk
         XAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696450; x=1742301250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1ZxqjyMUd+isnYc/2JZqNQs5zU7eDZecHhSMewZT7k=;
        b=Pf91e8/+0zjlFzg+9IBbXFxixV3Jx+SIe1BMcwZcDmYJ35TXQ2h6Oscn0GPNKTnt7r
         6UxcGerhu2wT1NiWLmpgsgKfxgRVsQ3iSww8h6Y5RsNReDGvrctRI71Kt8dGxv5DFXMi
         EqOeiPqRtmR17Ebk5EufOMgxwb+ujN5DTlcuuQHCSOAROe61rI60AFttYe3G7FRnFwRD
         P4BdXnJ7YojtYXo0Hph43xes+ynFSymPBuxblHEB9D5d502i6ka1FEpj51hNaR7g0RTO
         Scb3OAmblvlhkAdJ0o0agD30WMyRP+N7RTP4j041D8qMwuO7vReFBxaq6c3MJ5Sc9gMA
         OfiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr2YUBsclp3xLz5JmWcoXC/iWBa1qschUBiXU9lfkopMsDQy+UWl3yt2+szyn7BX0R1GOtxI9fukLazNpA@vger.kernel.org, AJvYcCX2r1YrZSjmgooPwXlE4uAiEQjhOdpLmaa+CnSs3aO1tetDjrl/7+kYc24BWD6rklt028Mvb78DhMXs@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEywC91YAEZtQMwPbvSv8TLD4VUuYd+QnljA9W9NhQTU+jpJZ
	Wp2+zypB0p8N+uuQEtjrsdaljBBpZ2/LQAg7dhN0gaNUpGOGzCNa
X-Gm-Gg: ASbGncusn9woB92xjaaBb62RwNvsQ/Kx/6HHRn1ZxW1o1agp6NsG8yHsrk/TPHs+s46
	YQmYnYNBeJE7Dn7qRffeTsLz9w4ApI6B6OcUb3Uf1d3QzRIlAiCM9xqxlK82FKS/76Tn+FxWvCS
	trxkMBFxf8r4iOpDp3DEnYnX4Bin4quB/utgNteb5bFp/zl0KSqwqqGgBzqwhqtHjEWtG+VEJ/p
	n14hPmzvBdHaBxbq16sTbFF3xkLqNgUrmHFcMYyDp7Gkzf1HiiI3Ri5w7QTOJRphRSG9w78zsFY
	0A/Q6OHNOzKVfIH6JSCo
X-Google-Smtp-Source: AGHT+IFU2cAqaMeCXlZ0Hqy6Zv7mfjOYRy5JKPusGv2guBlnRHiq/LPliOv7yz6eaX2PsMQjmuIglQ==
X-Received: by 2002:a05:620a:26a3:b0:7c5:55f9:4bc1 with SMTP id af79cd13be357-7c555f94e42mr850962085a.42.1741696450372;
        Tue, 11 Mar 2025 05:34:10 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c56630e44dsm34135885a.86.2025.03.11.05.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:34:09 -0700 (PDT)
Date: Tue, 11 Mar 2025 20:34:02 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Evan Green <evan@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Jesse Taube <jesse@rivosinc.com>, Andy Chiu <andybnac@gmail.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
	Yu Chien Peter Lin <peterlin@andestech.com>, Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 0/3] riscv: Add bfloat16 instruction support
Message-ID: <d6t25jmcf57sqpjqwykhdf3ju6v3wwpyaiumll4x6bjfhcohl5@oikmnpusjn6u>
References: <20250213003849.147358-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213003849.147358-1-inochiama@gmail.com>

On Thu, Feb 13, 2025 at 08:38:44AM +0800, Inochi Amaoto wrote:
> Add description for the BFloat16 precision Floating-Point ISA extension,
> (Zfbfmin, Zvfbfmin, Zvfbfwma). which was ratified in commit 4dc23d62
> ("Added Chapter title to BF16") of the riscv-isa-manual.
> 
> Changed from v3:
> 1. rebase for v6.14-rc1
> 2. patch2: add validate for zfbfmin, zvfbfmin, zvfbfwma
> 3. patch2: apply Clément's tag
> 
> Changed from v2:
> 1. rebase for v6.13-rc1
> 
> Changed from v1:
> 1. patch3: add missing code in sys_hwprobe.c
> 
> Inochi Amaoto (3):
>   dt-bindings: riscv: add bfloat16 ISA extension description
>   riscv: add ISA extension parsing for bfloat16 ISA extension
>   riscv: hwprobe: export bfloat16 ISA extension
> 
>  Documentation/arch/riscv/hwprobe.rst          | 12 +++++
>  .../devicetree/bindings/riscv/extensions.yaml | 45 +++++++++++++++++++
>  arch/riscv/include/asm/hwcap.h                |  3 ++
>  arch/riscv/include/uapi/asm/hwprobe.h         |  3 ++
>  arch/riscv/kernel/cpufeature.c                | 35 +++++++++++++++
>  arch/riscv/kernel/sys_hwprobe.c               |  3 ++
>  6 files changed, 101 insertions(+)
> 
> --
> 2.48.1
> 

I wonder whether this patch could get merged? So I can
submit the SG2044 board dts without this as dependency.

Regards,
Inochi

