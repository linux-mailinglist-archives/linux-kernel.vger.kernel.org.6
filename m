Return-Path: <linux-kernel+bounces-557059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8BA5D318
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15A53B5164
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330FD236447;
	Tue, 11 Mar 2025 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPpMEUB8"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238E2356D0;
	Tue, 11 Mar 2025 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735209; cv=none; b=nzr8auslo0Dmo3cUi1J46V3oezSd+L27ennG8O+MThyN9aIVQMTdJjGnBfsxGbVWWWnhJ9LCwHMHZLC65RTE1KMGq+1KbsPqDrzn3PPA4K1BHGTpjvS38PrjQXXN6jwue6XMGaSBD5g3l1MrUhfswqAZgv9KDJl3tR/o9RKpUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735209; c=relaxed/simple;
	bh=DQcj32kR7AhCUWSp/CvHAAVFtrNaVtIkHiFyMFn4nRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJonzqFNPBZV42hlwD+6Qnpeg62M4FmTgUzOtw0pUs+Ucbx6e6Gp0uIKTaLu1lWvL3nX1cAHhltUwJg/deSElbUCG/VgMfQuKyyQh/Itxw/HPFHs2cxurQKmgnMl4wlVvzIZBAz9br5mHLhT9eoQOQbHhWkKKMZ8AR6HUrjF8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPpMEUB8; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c542ffec37so352196785a.2;
        Tue, 11 Mar 2025 16:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741735207; x=1742340007; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ltUKs2z+U/8X7yl9Lmft9ZWcQtUbw/3Yn0qxN80Kc8=;
        b=OPpMEUB8HNbCoZcCDGWleF3M4fJnB991jlxAPizSJxdMM6+XFqztKQ4Y2GPkXtHtEl
         NOdTNOFVoo3PlohANxuiH3tWHL4+lmxUzVwexY/4Hu6uxZHxjDGNqGFqGlQeIaZ9lWzJ
         0yzZADKnnB9WcPz8opWa1XisHxzUt6SD06XFfdyQ4c+FeZWkuH37LUCaDigtDOcVhudJ
         7kldgwbjTDRxQjiiizEWI9rSxlHmbxiFZmct3uQ1j6lgjBpFmO3uIDtMtozEX4iOhJWR
         NKlaMV2KiMgdM6RUinnanVaPlKhzEiO3hrCOtEYN+ZsSmWSl9rQKTko5gEsHaMqcdLGr
         vvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741735207; x=1742340007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ltUKs2z+U/8X7yl9Lmft9ZWcQtUbw/3Yn0qxN80Kc8=;
        b=VvwDpuRhnHuHAOB7/xQzXUQhqAcMJscJL3td+utJOPoeG8u+1AcufqLGH5yfQnoD6L
         msRsarp6eiUqN3ZxyFhDlqnZuEKIWAOqbXC5EuAqZwLIEgYETUymr+FnFdDsR4U5zuRd
         OngPzr3Jqi2K8MGxFzzdDxQwN/fiWOFgQrpg805WthqZHdgIt+M5LuQq09qARruew0GF
         1kCt3SWV8pjWJEHHM2b3cwz7LK3G1AkgL0kY40fYegNWPsehn76pvPdJ4i7h2t05Vd61
         kH7rK0r8muLCPnqC8RPVYREXSkrO82Vlxq1911W7m2MTvH/0ruvryKe6UHwZhcsn2b8d
         84Kg==
X-Forwarded-Encrypted: i=1; AJvYcCU9ILLAvrjFvvDLK7gt4+zG3i0VoL+I8cOKhUEWXo0o1fzJ1Khf+/IIkJditwi4IfabmY6LnW4s5RpPkkwA@vger.kernel.org, AJvYcCUtWH1nUO1wmMU6PkpKDuYlDb2Bgr4SC2Q8COFDar6skZkLc9+TYNUi712ZzoiJ64aiydKy0YgXJUV6@vger.kernel.org
X-Gm-Message-State: AOJu0YylqLKe0uPmv02l2/iQr7pkBv5zS3k9ycAM9oaph7icJjdk23jY
	HGG5nhYb61ALLTJKFDFIOB0rpUg2w+A0xL+WNbwMp+g6CWKMyeEa
X-Gm-Gg: ASbGncteIa9rskQ7lO9eI28CyZU/TM32STD885IMP8aiD8pKW+536sql7Z+lGEwAiLM
	VQ27G4OY6EDekFtmn7SpQtIH7T56D5B3FqFMJhKJwvNEYHawaIX2GS6f/vp9Fn8umlWKnQPYkMm
	VhACUCX887sMHQfvCJXCJdxwF8PPP50YZbrUMEy44t3K77o/DcQPY80TQ9WNqlf/vBgS9H99+ra
	LhtM8CHRoqJigmvuSXrUkrA3d3QYYHT1WIEAr7mSHj//I4oPxGndZh0b4vTyxsoPNJjpcrFKLBh
	OkCUN+WbBOgJv2MojTgVizMjJJTNyd8=
X-Google-Smtp-Source: AGHT+IH7UN0PdGtcChDtRvCDEtQ0UBi/lcVWEMqGsKQk9Vlcs4MLHBtcnIhzM5G75NTX4ZQt5BCqVA==
X-Received: by 2002:a05:620a:439a:b0:7c5:4673:a224 with SMTP id af79cd13be357-7c55e9692a5mr843742285a.50.1741735206802;
        Tue, 11 Mar 2025 16:20:06 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c55d56bc42sm232107485a.7.2025.03.11.16.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 16:20:05 -0700 (PDT)
Date: Wed, 12 Mar 2025 07:19:58 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>, Inochi Amaoto <inochiama@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Evan Green <evan@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Jesse Taube <jesse@rivosinc.com>, Andy Chiu <andybnac@gmail.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
	Yu Chien Peter Lin <peterlin@andestech.com>, Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 0/3] riscv: Add bfloat16 instruction support
Message-ID: <j7b4c7hxq25nn4aerqs5zjc3aabiifbizxde5vycxp4zvlc2sw@5d7j6ka4o7jx>
References: <20250213003849.147358-1-inochiama@gmail.com>
 <d6t25jmcf57sqpjqwykhdf3ju6v3wwpyaiumll4x6bjfhcohl5@oikmnpusjn6u>
 <e72db46d-53b2-47f6-814f-9653d783e745@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e72db46d-53b2-47f6-814f-9653d783e745@ghiti.fr>

On Tue, Mar 11, 2025 at 02:20:21PM +0100, Alexandre Ghiti wrote:
> Hi Inochi,
> 
> On 11/03/2025 13:34, Inochi Amaoto wrote:
> > On Thu, Feb 13, 2025 at 08:38:44AM +0800, Inochi Amaoto wrote:
> > > Add description for the BFloat16 precision Floating-Point ISA extension,
> > > (Zfbfmin, Zvfbfmin, Zvfbfwma). which was ratified in commit 4dc23d62
> > > ("Added Chapter title to BF16") of the riscv-isa-manual.
> > > 
> > > Changed from v3:
> > > 1. rebase for v6.14-rc1
> > > 2. patch2: add validate for zfbfmin, zvfbfmin, zvfbfwma
> > > 3. patch2: apply Clément's tag
> > > 
> > > Changed from v2:
> > > 1. rebase for v6.13-rc1
> > > 
> > > Changed from v1:
> > > 1. patch3: add missing code in sys_hwprobe.c
> > > 
> > > Inochi Amaoto (3):
> > >    dt-bindings: riscv: add bfloat16 ISA extension description
> > >    riscv: add ISA extension parsing for bfloat16 ISA extension
> > >    riscv: hwprobe: export bfloat16 ISA extension
> > > 
> > >   Documentation/arch/riscv/hwprobe.rst          | 12 +++++
> > >   .../devicetree/bindings/riscv/extensions.yaml | 45 +++++++++++++++++++
> > >   arch/riscv/include/asm/hwcap.h                |  3 ++
> > >   arch/riscv/include/uapi/asm/hwprobe.h         |  3 ++
> > >   arch/riscv/kernel/cpufeature.c                | 35 +++++++++++++++
> > >   arch/riscv/kernel/sys_hwprobe.c               |  3 ++
> > >   6 files changed, 101 insertions(+)
> > > 
> > > --
> > > 2.48.1
> > > 
> > I wonder whether this patch could get merged? So I can
> > submit the SG2044 board dts without this as dependency.
> 
> 
> It is on my list for for-next so it *should* be merged in 6.15.
> 
> Thanks,
> 
> Alex
> 

Thanks, I will wait for it.

Regards,
Inochi

