Return-Path: <linux-kernel+bounces-176249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E526C8C2C04
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B171C21507
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89F313CAB7;
	Fri, 10 May 2024 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RuutQSJm"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891513CA96
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377396; cv=none; b=SAbl6MWxeX4AjkE34AEuf+C/AqbDA36hgDeYR5NwZaYEm17Vjd29qR8i/tp++vdJAsJhicjemG5W3iwS8C3QjSylslIjrWydEC+4WnGlk18m+Czu03te7RvAdHooe4iRszHCyNBF8Vwlj9JFntcQ7cyYJioW9/y36fxt/iT/slA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377396; c=relaxed/simple;
	bh=6U9/IgpvTpmvi9/Ode6lKMYWBDmYKu38WYbaTFvT5+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzwKHEttnZ2LYre09e7DI5QCoCND5lq2j4xe9el/IapYndi+bU2YEJcGgZ73Y3LKy61fvrQpfcuXWKKdZ285I0TqtE+jZ87LA7HptJUEBlnH7OxRvxoAfFqVHIw2W+6r/94aDwXuHxD6uaTu8yI1xJbJ6lNiVyVAvEzY0T9uIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RuutQSJm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f447260f9dso2180695b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715377393; x=1715982193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=znZGy/yRb95OVSydA0Olf96JQhjDXvAUrAWe45/YUwk=;
        b=RuutQSJmWpYyKxOGPg3vNp0PQd7HrXyPo3kTJAEcfCb9tGdacF98JHMae0nawh2GWW
         jx9CdiuDpqpptvnTnnoonK/Ybss3eGhz1cLGTc1xE1MVTD6Vfz9jJb5e7WXFTgKWUwau
         0GXY2xae/HhRBO3Rip14JJ8p2JrFS7k6hzXji7lZwrialGsmPvCmWRo2MDPAfI+F13BY
         /8IwQS01Ch42X44seCzgzSGlGV9IxiCcVM3WzNE8wMZcdsArqyi/eNNhp+ae9QVn4BqL
         BrIpz5RMJtZ2t/OfZ14HApKHnoHetzL2Ehhi3sDLzqWc24f1QSYnu6/WdHrbzxMin5ui
         hOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377393; x=1715982193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znZGy/yRb95OVSydA0Olf96JQhjDXvAUrAWe45/YUwk=;
        b=YQWnEBos3mXzSPMK+vRNBOfZPBhqRAL9kATutbflz6AC4skDzSFDOl8RRhAc2EC+JY
         FNKv6oV94O+jfyQ9z1L+jmyza+zgdBmyrsFyR2oEqL7W9MmvKOOXW9u13kXXMWxcprnm
         sgnCmycDJEzBK3OiNXvO6qO5Gco/DB1qUTuvUe1i5YY59tgpmjmCqln7ox4wlk0QhvLF
         XNCT3G2VLTURdGQ/N6eVX8ZuRe+n8UQ7oZOxQchcnP80OaG8uN6iKPC59FD52BV4huOx
         FO7m5+f7i4yDmm3L8/v86eGNet2foY2YR8wJabO3+BoNvxJ4ZBLUOLFUIoniokMBo/le
         QMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBPyeJNQGRZFNYwaBKThkTXiWPD1V5wHCow5pzyz5gUFat98/4sGN6WZLftsm6IuCm6lqLcsWwrmEy9qCOgSFtwgHiy5WEYf0BIH8l
X-Gm-Message-State: AOJu0YyACDMM+atdV2iNQI8qHcRz94hWJzMnUtJM3Bh1txQQJG+meWZs
	x5zRGIoNyn2PJEelsBJLyq+D3suMP8Y9x71vkRcrruYryR6rNY+KpdEeZup03tY=
X-Google-Smtp-Source: AGHT+IEtWLoTUTyK9dq4C93jgusnhYvSA4MYBGRO8UJYdGlNtOkcUj+f4EOdfFkiYl3CVVhOT2FWPA==
X-Received: by 2002:a05:6a20:2595:b0:1af:a4f7:cba1 with SMTP id adf61e73a8af0-1afde10ae6bmr4824878637.31.1715377393467;
        Fri, 10 May 2024 14:43:13 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:629e:3f2:f321:6c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2ab5sm3386387b3a.155.2024.05.10.14.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 14:43:12 -0700 (PDT)
Date: Fri, 10 May 2024 14:43:10 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Song Liu <song@kernel.org>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_V
 Kconfig option
Message-ID: <Zj6U7sZNNh8GQPYM@ghost>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240507-compile_kernel_with_extensions-v2-2-722c21c328c6@rivosinc.com>
 <20240510-earthly-regress-7a8c8dba55db@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-earthly-regress-7a8c8dba55db@spud>

On Fri, May 10, 2024 at 09:43:33PM +0100, Conor Dooley wrote:
> Hey Charlie,
> 
> On Tue, May 07, 2024 at 06:36:28PM -0700, Charlie Jenkins wrote:
> > Current versions of the kernel add "v" to the march and then immeidately
> > filter it out such that "v" is not passed to CFLAGS.  Instead of doing
> > this filtering, code blocks in the kernel that want to use vector
> > assembly have been changed to locally enable vector (using ".option
> > arch, +v").
> 
> Other content in the series aside, since this is a change that could be
> made independently of the main series objectives, I figured it was worth
> pointing out that this is not a change without downsides: I think that
> it would drop support for vector with most versions of LLVM as
> .option arch support there is much more recent thing than it is for gcc.
> Off the top of my head I don't know exactly the versions involved, but
> it is something like LLVM-14 supports vector but only LLVM-17 and later
> supports .option arch.

Toolchain incompatibilities are always fun. It does look like .option
arch was introduced in LLVM-17. That would be a regression. We do use
option arch for every other extension, but vector was treated special
when it was introduced unfortunately so maybe we have to live with the
weird march parsing hack.

- Charlie

> 
> Thanks,
> Conor.



