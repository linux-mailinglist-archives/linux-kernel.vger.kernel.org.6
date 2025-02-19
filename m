Return-Path: <linux-kernel+bounces-521868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E02A3C359
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200CA171CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D015CD52;
	Wed, 19 Feb 2025 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+HrCPnr"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3186195B33
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978149; cv=none; b=j/rIqb9iEdBZQQ/Ee98Lt/UIWeEU5Xz4iWRzQ/XXgB2ceg/xmtX+5eAbIkTeVJfxjGiQA1OY0RLGxolQ9Qial14W9UM+VhZvCtwlIyPLZntybzZvkEvEnMNUvokg8O++0ftJ36+mrXOQSc+OkjmCor9v0Gh+tZyg078S42OzgEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978149; c=relaxed/simple;
	bh=Iv6t7FRn2B5grw2+MtJh7t4h4IagAcD/o0AdA80NfQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7CvM/sAUFdIjXLVvfqKdC3+ZavjrF1oGQ9n5dPwVQXf4zrO3jUejGVmnH/9r/J1OGpMRgPJQynhYKsoEbcHdMLk3JFNb9M3LQuB70QB1gA48TkXLmkjpqlcbpALnDZvSqqgCmnj6IOMFb/mZDp2PyB0mPzqMrirLw4x+mX9Elo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+HrCPnr; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471f88518c8so16548781cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739978147; x=1740582947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i4BufmELc/H5oLk6Se7bfRixYeydt1UGAVr8rJzEKPM=;
        b=i+HrCPnr7hj8spFtYLMmbJN4GrwJ4dfHSMUILPd3nugBjV6Pnep62sVeUZiv4uLgPh
         T5XfHCpv0+RcshyV3tbuhiiWfnT2ld6d1s3K5xQdkNuz8mkTHXtYcR0ice9zLOF65Fw1
         ubEkNcCK8a3lh8bd8Ah5syIhn5dN4swl3Ut1rbLkYuaXN7hFqruJ4qtoWtOc/1b+FlFK
         ID9D2uAu2/J8lYsiNKaKaN4vKCZoTW0QTfXgK/LFcVaKetL5+vvGWn8YNipDnGOKGlq4
         osbUvYG3abppm0KL0QsL1qi4AbwA5jcnintQewvvdc8dhBb9guGgDedOfqhdp1+IJ3tV
         9mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978147; x=1740582947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4BufmELc/H5oLk6Se7bfRixYeydt1UGAVr8rJzEKPM=;
        b=t+NQJL3pks5XXVOJspi9u9PM8YjYxX+vsYGSNwt7J/OFZb02FuwkQnwnCG3r2q959E
         e0xhb2QwLSua0uIzFNtu72V/ejxnqUv9bu9Py6VS5KyMC5Q2WURcS2LJPZi/VoJQ30pH
         MNgnY7+ZF++l7KR73KATFXIaJH2xi06IHqIx1hdJSb+/CN3b0CVaV/H/AOI3brE4mshB
         8gzibEyt/jQyCTW2vF7BrOlK3T6GLFvYirA2SH4LUUZ7mEYKQPY3hLlDrKtoo7mXQ28W
         Kesp4ecYRPPl3alyI+JLcZFNyJOEjX+oN0tEaq91IGWOlg3qMJuFyYhKe0PL0Rm8L9ev
         kECw==
X-Forwarded-Encrypted: i=1; AJvYcCWfXlOgIHQwTNLXAiZzQ5AfymMdo3GTQo5gz3ZvTU3MeL4imYvSdUocgpPiOYUWomdYgimLWiePpzXqk44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwogiMyF8prMSY2NP/I+rgcvQaezMUpPqCiU8xW8uOewvdnZsXv
	D+2PjjIokae/k7xJl+J1ejdt5WOoktgFl/L9ZkpZqL9jLPguzB92TdTRm59cu3dV4Q/XPCUoLaY
	+ohOid5JkiIC+wH0QBOW8qVLeZkeSYQoMIcUg6Q==
X-Gm-Gg: ASbGncs7nMUG7/u9UI1BCj4jIrZHxnfUPeJ1uWrf7C4sU3dJj6T2agi8dESy8hKJOlG
	tfN3E1UIaowI16guH0qKakCTtwDh3GWAXgibB1p+RR0vWTT5w4yQZ+rXuXE1AkFtRtYuWZAGrzl
	4=
X-Google-Smtp-Source: AGHT+IFOL53hLpR9huwVKcdEp9S5ol3K22XXCd3/mcd/L2bQqRKMnRbCt0AScL5oNtTya9R/VDI/ycGal6VHuQEUFVs=
X-Received: by 2002:a05:6214:1d2c:b0:6e6:5d61:4f01 with SMTP id
 6a1803df08f44-6e6974fc658mr68832166d6.8.1739978146707; Wed, 19 Feb 2025
 07:15:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215075701.840225877@linuxfoundation.org> <CA+G9fYsBu8DOLEDQoGrdZmjwZKvz72tMmrVPnQSJLNMbefYymw@mail.gmail.com>
In-Reply-To: <CA+G9fYsBu8DOLEDQoGrdZmjwZKvz72tMmrVPnQSJLNMbefYymw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Feb 2025 20:45:34 +0530
X-Gm-Features: AWEUYZmBriKaF0g7ZN6AKPL4WUNipNS0LvWaItl7Uel4aGCuiaCeYdtgGR_kvUY
Message-ID: <CA+G9fYugvbR5jJrOUHd==_h2MXKDfVjivRnaXxvwWL_dzBXdGw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/418] 6.12.14-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 13:08, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Sat, 15 Feb 2025 at 13:29, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.12.14 release.
> > There are 418 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Mon, 17 Feb 2025 07:52:41 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.14-rc3.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Regression on qemu-arm64, qemu-armv7 and qemu-x86-64 on 6.12.14-rc3
> We will investigate this and get back to you.
>
> Test regression: arm64, arm, x86 selftests: memfd: run_fuse_test.sh
>
> * fvp-aemva, kselftest-memfd
>   - memfd_run_fuse_test_sh
> * qemu-armv7, kselftest-memfd
>   - memfd_run_fuse_test_sh
> * qemu-arm64, kselftest-memfd
>   - memfd_run_fuse_test_sh
> * qemu-x86_64, kselftest-memfd
>   - memfd_run_fuse_test_sh
>
> # Test log
> selftests: memfd: run_fuse_test.sh
> ./fuse_mnt: error while loading shared libraries: libfuse.so.2: cannot
> open shared object file: No such file or directory
> not ok 2 selftests: memfd: run_fuse_test.sh  exit=127

We are installing libfuse2 in our rootfs to fix this at our end.

- Naresh

