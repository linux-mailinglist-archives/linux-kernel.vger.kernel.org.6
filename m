Return-Path: <linux-kernel+bounces-523652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37DA3D9AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD503BDD5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD55F1F5435;
	Thu, 20 Feb 2025 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="SF0fAFAs"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D31F3B93
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053883; cv=none; b=lbBCIe7MXgeAVLjJdgZKesyi1ZpZ1U3TCdtIfr0tNbKMAdSU6PuIvmWdcInZXOvHpfwNGm2+2A7PDH0siz5L4KebCT+88cKBM1DDWjZVVgRoDADFs3VNwVDMGEbyRCIqxOvcGeT6C/Im1M0flvX0tkBoR6rIBtGTp+fFG8JXJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053883; c=relaxed/simple;
	bh=6m3pn5teB6D33EiP9PjyRNzHejwBzfVH65xximy5EQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3BFETxeyPfPldzs1jF12PK6XGuJw8PkTZdSyIOoOmpe8PBXZfTuZEym1A/Rv7PfbEFjNkUrsacAd6Hx8PVe9IMWQUzfyf5RIH0HBr4hatbnP1O4JkzM2p8+SPDLqPE7oSIYzg11jwrGXe0XQKex7DvAavIm6r2EuHXZLb0RVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=SF0fAFAs; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d193fc345aso2987735ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1740053881; x=1740658681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmI+w9rW7xuxQgzQY4zgyZiBf+VpYD43wlkF4w4/Fxk=;
        b=SF0fAFAss56S5/kldJcO5bNJILxkssyS1ga/tzhkdUQFpBVB590jWwLiJ7+E/iAuQU
         3JGWKPr81N7OzTonmnzjWbQqGsxt/mHQyDEBAG2Hr/+1aOON3SIX8PppB8LcXfoLqQwP
         vKkT8Ald8KMtl9lkMRI2B0j/83OK6smXaFF8vr8SCA9fkSXNh8DpG5uOZJ813LUTNvnc
         iC1BLBzzb+W0sa0z1wDPV2Yr7Y9ZC+9MutpF+5yUvTXEIJojFqC/QWA8ZivI0IlamuAi
         xtf428dOypj71Ev8mcTG3ZvvDS4+h3CcwX5HyQuohPeE4NQlI/Y71jx1O7K6aJ77H9RY
         EldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740053881; x=1740658681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmI+w9rW7xuxQgzQY4zgyZiBf+VpYD43wlkF4w4/Fxk=;
        b=k+cUVB/amDOGf4AlhFx76teA3k6sDLiTIvuRrvwdiJTF4O+NehmPorNcnfuGolDkNf
         m7Q99GC/KIEVdQ6HHjuVdRKBAD/2fOs+5iOaU8+pmxyAIqpJFZPeM3U+OZSa1TqZlxDr
         UxRQHppyMNh7Q2uXHkUaMUpSx0Ok0deQe/Mz3q4DFrFE5rxaWkR7Rv8RagaSrvVNFl4C
         PvkoPIvP+WFIrAZJZhxbL+zn/TsD+wjXiDYbGdmLXvDkANdpuUZsFyMMIc8CmNmESGwD
         EJ41S3yc8xPXkY1J/hIcLiimkhXwyfSZh3k/sEXzLWQ60oQOO48XxhzfPxMMQr+dZPHE
         mJrw==
X-Forwarded-Encrypted: i=1; AJvYcCV+xHpX3st3T/4xDN9KC/buPR75t2nrI3DKWSM4anesh+xeZjlkGj93mnlccCmXZ2Qp6GL9koF1DMjzWGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAfn0YIDsAJUIgBFMKpEDe5Qz8rYz6vyg/JAC1bVWnLMegHkGD
	IMMNCTZSaJgoMggn03AgIDnXw8UNJkJ/9wgWBfUE/SU3iPS3V4qARut4valbhB4u44POmWzMdsT
	DTeH1lE4MpTv1xnzZZxzSgI0t1rFuJunPnKVLXw==
X-Gm-Gg: ASbGncsfUKw+50QbKJ+ADNcIGSsblhu2jndAOHeG8usqcNKvNjH3b340n1NUUEWLdYF
	vOVN4X8ytoCLuF1g1ghExiibAI9LiWUHBA1EyO6JtWDX8YG4c5Hz99YidxJPcSPOVXAy42aSXGQ
	==
X-Google-Smtp-Source: AGHT+IHL3+9MtLF5+UaRybyEp8BV4Gc3bjSjy3kw4hdoypBWleJFfSGz7eyOLjRCOfAS7PzLJ2idDqWgGFTRfAm5dPo=
X-Received: by 2002:a05:6e02:152d:b0:3d1:9236:ca52 with SMTP id
 e9e14a558f8ab-3d2b5131279mr59896385ab.0.1740053880695; Thu, 20 Feb 2025
 04:18:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217084506.18763-7-ajones@ventanamicro.com>
In-Reply-To: <20250217084506.18763-7-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 20 Feb 2025 17:47:49 +0530
X-Gm-Features: AWEUYZmV63eOiG44RnPBMnqx1Uo6sIZHLWWs9x29seXyEVn1h53Dh8XbVUUsj0U
Message-ID: <CAAhSdy0cqoN5MehwDtQEtK7EYSTXPekwYEJWgPvAK+Y4uk=40Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] riscv: KVM: Fix a few SBI issues
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, cleger@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 2:15=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> Fix issues found with kvm-unit-tests[1], which is currently focused
> on SBI.
>
> [1] https://gitlab.com/jones-drew/kvm-unit-tests/-/commits/riscv/sbi
>
> Andrew Jones (5):
>   riscv: KVM: Fix hart suspend status check
>   riscv: KVM: Fix hart suspend_type use
>   riscv: KVM: Fix SBI IPI error generation
>   riscv: KVM: Fix SBI TIME error generation
>   riscv: KVM: Fix SBI sleep_type use

Queued these fixes for Linux-6.14-rcX.

Regards,
Anup

>
>  arch/riscv/kvm/vcpu_sbi_hsm.c     | 11 ++++++-----
>  arch/riscv/kvm/vcpu_sbi_replace.c | 15 ++++++++++++---
>  arch/riscv/kvm/vcpu_sbi_system.c  |  3 ++-
>  3 files changed, 20 insertions(+), 9 deletions(-)
>
> --
> 2.48.1
>

