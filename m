Return-Path: <linux-kernel+bounces-239468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED5926070
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB80285624
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309A21741D8;
	Wed,  3 Jul 2024 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erEep//Q"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91AA176ADE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010112; cv=none; b=TTM/eiJT8QmLw1oVc3d65eNqRxDeFsari5KE9h3OilC30MwNkTfeTAa6SrItdiGgrJOG0l056X3S+24L8Es7vqHACLJX2rAmG/Zgbvep41/L0DAppJx29345ERLBb1XHvtNjOjFT71Vj3hdTKHK0e+5H7r2qGPF6LDp+9yMcDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010112; c=relaxed/simple;
	bh=cfGy4hd/MJDQaAlZyWKj8dMD+MgtojL710RreopYNk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaT+TNPYHP+1j3hQkwsRrV/bdwkEp02/5JZiWmrBgd/GGrPtoUlBbDCAq6nMchIAQ9Eg6FLYsCVDYePH+XTRFLRf4Hk2xo+ybHhnGmDirzi+iwfYY6ouPgUn63n2itzRSYdDVBO6G0/EeKFv9swz7SMOylVVailp5nVJDtnGWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=erEep//Q; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4ef56bdc3fcso2296042e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720010110; x=1720614910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj8SrAjLpSLjliuG99WdKny0d1AT/67yDFEWTU/8uKo=;
        b=erEep//QN5IXm7I1epEj8I1BLWCjLhgaUkdFy0OsgNUbm/sTbX25lI0309bLOna9zI
         3B0meQB7XuQJ2z+I+Bw5vLZoFTtIjkJJEcTD9e6DoPyLws4jwQUKO2Td7xa79GsxmiAi
         LJGMgNYE7e0SdOywpuKcompPZypvWwXmMPjZ9Mcp2qoh9b5uou+/DqRnHC9QtUQTOsEV
         MqGCq8G2yKf29qakj0oFMZhapUilwaDMzVl1/312RRdZvzBuZQjXKA+QSnc0XYFD/UxT
         9md6fxCuIu9ehR2wbW/IKCeHm1VF/aTjACo7frld7jpJEgT90K3pHOkvnA3r2URpp+Jt
         nPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010110; x=1720614910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pj8SrAjLpSLjliuG99WdKny0d1AT/67yDFEWTU/8uKo=;
        b=TZYDYcZnJXPoODSRkwhj5cnMUnNfqKu1mT+6+bGZ8xijYtDFEv9PwIEXfGvjd/9+Hu
         ZijVJNBaP3hmqb7gCrchRbLEp1wTJhd9IrtX4yQs/elVHucas3LOAYT1jbvskTtgQP14
         AVOWGJQyQDSJsiUteP08Z+81WNzNZoWjrD5k1XOyImGGrOzhZaIgUYagnySpB4YHffUF
         140YB+IVWkWeUu7dPV9hASs0BJ+TR+nsS4gDVsHsSP2jLB0eUzvHiAC7WkedvbmC7HYg
         snbd5CYy/6ff3sqhYXvaRomEKoOql3zAsGzCrUYIOTagQCDQSCJWlJG+WHzcp2ZrK6cp
         5saQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeVBPcXExRCXqdCbpvJVq0S+PX6RlJ8a96bw84TVVQLfLdR8j1qVqUBgy7HU6mNpy8GNrk3EuKozO10ATqRn2hdQOfrFPynT0kcL0i
X-Gm-Message-State: AOJu0YzGEsBhWVEI/ToVv8QnlUG/VeC9UAMwvfZCgWvYwRKj2LnAFepd
	NQNVkXRynVJpSmDJwavepFzPdLpySpG09qDFqOfKs8wF4x9oFnlImG6f739bmqW7KtnQmTmUC59
	nikXW4bj+VtepE6qWTn6FzT83yIbZAxKCmZYOBA==
X-Google-Smtp-Source: AGHT+IFC2Ceua1RohvvkAIKkyjcpb3zdlon3mgykMv7og6AVgIzZvwsefW9dPMvY1y6HF6Y22NRmSxg3gPVSzvwQPTc=
X-Received: by 2002:a05:6122:4287:b0:4ef:58d4:70f8 with SMTP id
 71dfb90a1353d-4f2a572cb78mr13958132e0c.13.1720010109406; Wed, 03 Jul 2024
 05:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170233.048122282@linuxfoundation.org> <CA+G9fYs=KkeYFMS01s3VZmeSYd1zJphinPFCk1G2AJ7LZ=+8=A@mail.gmail.com>
In-Reply-To: <CA+G9fYs=KkeYFMS01s3VZmeSYd1zJphinPFCk1G2AJ7LZ=+8=A@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 18:04:57 +0530
Message-ID: <CA+G9fYvcbdKN8B9t-ukO2aZCOwkjNme8+XhLcL-=wcd+XXRP6g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/163] 6.6.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Kees Cook <keescook@chromium.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 14:27, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 2 Jul 2024 at 22:48, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.6.37 release.
> > There are 163 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.37-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> The following powerpc builds failed on stable-rc 6.6.
>
> powerpc:
>  - gcc-13-defconfig
>  - clang-18-defconfig
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build log:
> ---------
> arch/powerpc/net/bpf_jit_comp.c: In function 'bpf_int_jit_compile':
> arch/powerpc/net/bpf_jit_comp.c:208:17: error: ignoring return value
> of 'bpf_jit_binary_lock_ro' declared with attribute
> 'warn_unused_result' [-Werror=unused-result]
>   208 |                 bpf_jit_binary_lock_ro(bpf_hdr);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>

Anders bisected this down to,
first bad commit: [28ae2e78321b5ac25958b3fcae0dcc80116e0c50]
  bpf: Take return from set_memory_rox() into account with
bpf_jit_binary_lock_ro()

- Naresh

