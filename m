Return-Path: <linux-kernel+bounces-303720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CBF961440
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20CBB22360
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4837C1CF283;
	Tue, 27 Aug 2024 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PqWJKRPP"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E11CE705
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776844; cv=none; b=es8HYbN7iub1WSUYo3mPk2zyah7L/ajXmeo6FTI8fKdh+utdSf6HGSZIlBOPDA28V8IKDZjiQOWhtBC9/+ZgWbMxEXQ4KlO6ANFQZ4OP2OwJFnmHiVZmy6gPhtYaQr0PbRCB0vaaKMd3yvePM82LmJ4c7kz8hsd+w5zLmmzMA3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776844; c=relaxed/simple;
	bh=mqj+nUaexZpLx78MbIFDbgbr3Re7pm0UFpvwCKrsD0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISku1Y6MboY+xcvbZ3fxEuHujQtUDEOFVpcCDvyCWrV+HmudQeLrYcJ6kNbR7R461GqBAtguV4ZKcQsi/e1grDvPa4XFJlHBUZbdOXEFaDFCfpsnKkAaA++iupjcVOg9yT9z+SITQFlUSZZP+DHi7OV7qqIWn44QO+q1KmGF4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PqWJKRPP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7141b04e7a3so4705759b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724776842; x=1725381642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rne+zpysSkg2L5/AJ4St1hJj9zp6Pm7sVmKolecYhts=;
        b=PqWJKRPPwFLQnAy4nagGnJmHASViITGtTluO0vV3r6Y+6OjyqMxUECblHindenUk3V
         QmXGIvAvysH1KGPOravaJZIq6Cmf3tx5sf2+JXsVrBxpfvqpyOp4Z3iOtyo+GPLTDZ4V
         wtj4L6VbtygNztlsPDMFwQUcE5b1geMyRCzs57ILk8rvMMf14ejdnQfjcNCPnU403Mv8
         3nlWTHrFr1BNqU0h1fAnsGXELJxSrZNR1eTyHoTsZDQbnNfPNDplWaTM1xjDy4HhocCc
         ZXMAeEWRpJoDVXlvzD8rsCJPF0lGHWoK1yCX+TOE6XjvVAkLbw0/MTqClUqkejqgWHwR
         6CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724776842; x=1725381642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rne+zpysSkg2L5/AJ4St1hJj9zp6Pm7sVmKolecYhts=;
        b=J5oPmp/3xlRi5zIEIX7r0RTy33gGE2bEtoCBEZV5sW40VKJgSEF8UyEWcWwWh3s3ha
         N5GwxZBwmKx4WOxImURC28D8r8V/77ofZ3fleUZ9rKp7hFXRCK/KMQ+pBU7PJJWKFqGt
         zoXT5QaClI5u9xnAdxVTj+Ulkm5WM9duZvZqmTZhd5hcspX+mg2Y++GNugnUEljlfsyE
         Rij4i+qKkf2WnctaKydnFra9Na0zBY63N/bkYgxr4/PyuFN5KRCGsQ6tbgChHEI5oTTM
         jl6sQPxEbb3uoof+r4brOAuk6Cb664m4Zb9YV/lsKMW/FSSKmClM/gidkV/rMOqzUSGn
         y2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXWQ+DNlmRkLOwKYV1GwIs1kNk3JVulW/PRMs34q8VlDLcLIY4H2PR1jrXewyJMn8rEhi6MhAaqM+TggtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKcEQGsTvqtmSaWbxY3bOMLOJGRpwCCOtp3kftXb5zH4Wdqhpr
	0cdupIGQ/w6l3BzPJJS0VCIjxRKbvo+vpcr2ZqRrSJZVz54bOXSoXJhpdLUJQWQ=
X-Google-Smtp-Source: AGHT+IG4PEytdJ7OVt7Zz6RxwZUGrSYdw900Upp1JNyJAzmPqshX0Vt1KaedOXWDN98/VzACJx3dKQ==
X-Received: by 2002:a05:6a20:d510:b0:1c8:d4d4:4131 with SMTP id adf61e73a8af0-1cc89ee5940mr15116375637.40.1724776841470;
        Tue, 27 Aug 2024 09:40:41 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343060e1sm9090279b3a.149.2024.08.27.09.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:40:40 -0700 (PDT)
Date: Tue, 27 Aug 2024 09:40:38 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: cyy@cyyself.name, linux-riscv@lists.infradead.org, corbet@lwn.net,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	shuah@kernel.org, rsworktech@outlook.com, alexghiti@rivosinc.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/3] RISC-V: mm: do not treat hint addr on mmap as the
 upper bound to search
Message-ID: <Zs4BhmB4xOF4LOH9@ghost>
References: <tencent_108260B43689E30AAE5D0C7C085AA31ADF06@qq.com>
 <mhng-a7dcdfb5-0232-4ffb-8a20-13e564904da1@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-a7dcdfb5-0232-4ffb-8a20-13e564904da1@palmer-ri-x1c9a>

On Tue, Aug 27, 2024 at 09:33:11AM -0700, Palmer Dabbelt wrote:
> On Tue, 27 Aug 2024 01:05:15 PDT (-0700), cyy@cyyself.name wrote:
> > Previous patch series[1][2] changes a mmap behavior that treats the hint
> > address as the upper bound of the mmap address range. The motivation of the
> > previous patch series is that some user space software may assume 48-bit
> > address space and use higher bits to encode some information, which may
> > collide with large virtual address space mmap may return. However, to make
> > sv48 by default, we don't need to change the meaning of the hint address on
> > mmap as the upper bound of the mmap address range. This behavior breaks
> > some user space software like Chromium that gets ENOMEM error when the hint
> > address + size is not big enough, as specified in [3].
> > 
> > Other ISAs with larger than 48-bit virtual address space like x86, arm64,
> > and powerpc do not have this special mmap behavior on hint address. They
> > all just make 48-bit / 47-bit virtual address space by default, and if a
> > user space software wants to large virtual address space, it only need to
> > specify a hint address larger than 48-bit / 47-bit.
> > 
> > Thus, this patch series change mmap to use sv48 by default but does not
> > treat the hint address as the upper bound of the mmap address range. After
> > this patch, the behavior of mmap will align with existing behavior on other
> > ISAs with larger than 48-bit virtual address space like x86, arm64, and
> > powerpc. The user space software will no longer need to rewrite their code
> > to fit with this special mmap behavior only on RISC-V.
> 
> So it actually looks like we just screwed up the original version of this:
> the reason we went with the more complicated address splits were than we
> actually started with a defacto 39-bit page table uABI (ie 38-bit user VAs),
> and moving to even 48-bit page tables (ie, 47-bit user VAs) broke users
> (here's an ASAN bug, for example:
> https://github.com/google/android-riscv64/issues/64).
> 
> Unless I'm missing something, though, the code doesn't actually do that.  I
> remember having that discussion at some point, but I must have forgotten to
> make sure it worked.  As far as I can tell we've just moved to the 48-bit
> VAs by default, which breaks the whole point of doing the compatibilty
> stuff.  Probably a good sign I need to pay more attention to this stuff.
> 
> So I'm not really sure what to do here: we can just copy the arm64 behavior
> at tell the other users that's just how things work, but then we're just
> pushing around breakages.  At a certain point all we can really do with this
> hint stuff is push around problems, though, and at least if we copy arm64
> then most of those problems get reported as bugs for us.

Relying on the hint address in any capacity will push around breakages
is my perspective as well. I messed this up from the start. I believe
the only way to have consistent behavior is to mark mmap relying on the
hint address as a bug, and only rely on the hint address if a flag
defines the behavior.

There is an awkward window of releases that will have this "buggy"
behavior. However, since the mmap changes introduced a variety of
userspace bugs it seems acceptable to revert to the previous behavior
and to create a consistent path forward.

- Charlie

> 
> > Note: Charlie also created another series [4] to completely remove the
> > arch_get_mmap_end and arch_get_mmap_base behavior based on the hint address
> > and size. However, this will cause programs like Go and Java, which need to
> > store information in the higher bits of the pointer, to fail on Sv57
> > machines.
> > 
> > Changes in v3:
> > - Rebase to newest master
> > - Changes some information in cover letter after patchset [2]
> > - Use patch [5] to patch selftests
> > - Link to v2: https://lore.kernel.org/linux-riscv/tencent_B2D0435BC011135736262764B511994F4805@qq.com/
> > 
> > Changes in v2:
> > - correct arch_get_mmap_end and arch_get_mmap_base
> > - Add description in documentation about mmap behavior on kernel v6.6-6.7.
> > - Improve commit message and cover letter
> > - Rebase to newest riscv/for-next branch
> > - Link to v1: https://lore.kernel.org/linux-riscv/tencent_F3B3B5AB1C9D704763CA423E1A41F8BE0509@qq.com/
> > 
> > [1] https://lore.kernel.org/linux-riscv/20230809232218.849726-1-charlie@rivosinc.com/
> > [2] https://lore.kernel.org/linux-riscv/20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com/
> > [3] https://lore.kernel.org/linux-riscv/MEYP282MB2312A08FF95D44014AB78411C68D2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM/
> > [4] https://lore.kernel.org/linux-riscv/20240826-riscv_mmap-v1-0-cd8962afe47f@rivosinc.com/
> > [5] https://lore.kernel.org/linux-riscv/20240826-riscv_mmap-v1-2-cd8962afe47f@rivosinc.com/
> > 
> > Charlie Jenkins (1):
> >   riscv: selftests: Remove mmap hint address checks
> > 
> > Yangyu Chen (2):
> >   RISC-V: mm: not use hint addr as upper bound
> >   Documentation: riscv: correct sv57 kernel behavior
> > 
> >  Documentation/arch/riscv/vm-layout.rst        | 43 ++++++++----
> >  arch/riscv/include/asm/processor.h            | 20 ++----
> >  .../selftests/riscv/mm/mmap_bottomup.c        |  2 -
> >  .../testing/selftests/riscv/mm/mmap_default.c |  2 -
> >  tools/testing/selftests/riscv/mm/mmap_test.h  | 67 -------------------
> >  5 files changed, 36 insertions(+), 98 deletions(-)

