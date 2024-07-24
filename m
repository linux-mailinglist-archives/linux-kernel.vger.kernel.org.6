Return-Path: <linux-kernel+bounces-261580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7731A93B95B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93EAB247FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4B313D893;
	Wed, 24 Jul 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="gklBA+qv"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB62143888
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861851; cv=none; b=gtbWQV7Qz9coHxjQB0G2LmSb9faiu/Gj+ivaIv8X66WVIGmktPGHyHNOO6jaVcYyRbJ3iRhmDerbb5bqvubsxSc5d/Wgg3yKhUhYy+86tmM+2pVfKx80+swk85ojx93sDYeAegtikT+MstcQvnSbMqpcu6u8wAPINiZMmSdysrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861851; c=relaxed/simple;
	bh=r37fknXAxIqgftjIethNpJqs6Zy1SFy4yZXhkvUkQWo=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=K+30ldtwWcIZS8qVn2ole0Q5ZLy7jIaSyM6oXqR8yPagw6TknwW8PCJ6HswJY+/2nxVfa+HdaireFHK9xcAwFL5V2lNOCAfQeTjy+gpQ5YOYVNkgcA8dW3EF13yMXuBRvutjRZARBAGYkrjJ3jWgY1y2wD+iMFidZ+ASGzEC5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=gklBA+qv; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7a211a272c2so233480a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1721861849; x=1722466649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rr1h/r+N+ufJ9+U33AteJIVm6hb/RZis0D0b6S7S1NM=;
        b=gklBA+qvACBuzUYXkt+v/nKAPetAy/bAQkChLfkTWCbJWQMvsIMKRp3rZonm9xoQgW
         rXScbBt5xenVrYuUFy9AWxIdKx/aItQZtlMXiGiyIhYlRCTrr0VlQFpVBANv2Oe8dcjl
         KYQt1cqXL0QPvO+DUz+OtTk0Q1Qt67O1dlKRiDDBi3Pz8KWvGXWMuSsQAcbqSkYEJfIp
         9s0hSygGF1SSQPk183WznKir7RYvHiK4xN2N0K8YOUbt7lRtVnpG3/UQa6fZqzb2K7H1
         FfzVrjMkwDKkobuRbVyNzTOPSZvZ6C6vyU5I3h7vZOBjNA/8atoQkK2/T/FniAdI8mTl
         rsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721861849; x=1722466649;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr1h/r+N+ufJ9+U33AteJIVm6hb/RZis0D0b6S7S1NM=;
        b=ULSfYadlmEYbMkOdZeT9+2m5wuwq4/USpWNVbCT2dSmLoIqIqo03WM8quKX9d+afzo
         dmsS8jj+dQrhYg8Cz8i3NeXmD8e0a+LjLtSxJczQvRDnRgacSAVryRGFF90Zkbhpnqos
         FBk5kV4YQo6z1soZbaZj6DWh3Y56SB2FjTPIlzG/wCLmiyGuyBjyZiJGP9HsVYBLSC+A
         Z6DxiWS7TzWtXgsdY/HOuYejdedg2p3iwyuUbIlbdb+EjAfVdmpbyzU0347ZcTkEfkzi
         nMOaFHbFvJWkvkOoMISxt4xXNFXUop+Wh127bCz5xokagHGb1WSiN26MWM2sbouVU0OI
         9AjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlm8I0C6VdOSU4+tuRSLncgjIEzWdG4y6EHgHw4QWTal+HxnON728we8rL7cGAnHPJXMXuuPeU+SbGazqLLqytS2AK6Qh87/TwNnZr
X-Gm-Message-State: AOJu0Yz6RJcVIGrPdw1NmrDFNsduhN406Q6fSkDeZowsrnG3GunQshig
	bDe9fbbDtIwFHSH/YZcZjOqcu31pKrUFxMtIlYFL25rLHW7PXh6+BM2aWQBUfbo=
X-Google-Smtp-Source: AGHT+IHO8d+O1Lem7hkeVGDAoLyDNU4rTjPilFRpWZGu3CWZTfO0Uw/Inp8SpFUBcx7HiWwSk3eKJQ==
X-Received: by 2002:a17:90a:4e0e:b0:2c9:6abd:ca64 with SMTP id 98e67ed59e1d1-2cf21547c29mr1799160a91.9.1721861848765;
        Wed, 24 Jul 2024 15:57:28 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73885b2sm2263541a91.9.2024.07.24.15.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:57:28 -0700 (PDT)
Date: Wed, 24 Jul 2024 15:57:28 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Jul 2024 15:57:26 PDT (-0700)
Subject:     Re: [PATCH 0/4] riscv: uaccess: optimizations
In-Reply-To: <20240625040500.1788-1-jszhang@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: jszhang@kernel.org
Message-ID: <mhng-de264348-59f7-46b4-9f6c-cecee67f2eda@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 21:04:56 PDT (-0700), jszhang@kernel.org wrote:
> This series tries to optimize riscv uaccess in the following way:
>
> patch1 implement the user_access_begin and families, I.E the unsafe
> accessors. when a function like strncpy_from_user() is called,
> the userspace access protection is disabled and enabled for every
> word read. After patch1, the protection is disabled at the beginning
> of the copy and enabled at the end.
>
> patch2 is a simple clean up
>
> patch3 uses 'asm goto' for put_user()
> patch4 uses 'asm goto output' for get_user()
>
> Both patch3 and patch4 are based on the fact -- 'asm goto' and
> 'asm goto output'generates noticeably better code since we don't need
> to test the error etc, the exception just jumps to the error handling
> directly.
>
>
> Jisheng Zhang (4):
>   riscv: implement user_access_begin and families
>   riscv: uaccess: use input constraints for ptr of __put_user
>   riscv: uaccess: use 'asm goto' for put_user()
>   riscv: uaccess: use 'asm goto output' for get_user
>
>  arch/riscv/include/asm/uaccess.h | 201 +++++++++++++++++++++++--------
>  1 file changed, 149 insertions(+), 52 deletions(-)

This genreally looks good to me, but there's some failures reported by 
the LKP tester and I don't think they're spurious.

