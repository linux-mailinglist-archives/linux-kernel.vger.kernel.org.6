Return-Path: <linux-kernel+bounces-378281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE7A9ACD87
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC9D1C24F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0631CBE8C;
	Wed, 23 Oct 2024 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYnoa+u5"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361151CB53D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694365; cv=none; b=gEdE7Nh/R49gkWXesrz2XUKVKX9A4qtAzyDGqF77/hs8PjPXNSgBtA1yH6XFdfPZDm383FCWR+AOQw5YMig0wHf2/1sgvs44S290y2x2/ExbxjpKPiZrc2xCxMTywLDp/GA4/nE+VjvQVS4GsYSRUcXxdZHH9bmEhw3f4A66nmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694365; c=relaxed/simple;
	bh=odby0jjqoFFOhNqsHsqZcbKiEYm2n7Gl+WYrvBNHbTA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AZ+1tPIoFk5mLpR2o8LmnmodiFZHh5DYe1tlHcn9RjxwPPvL2ZerXr9k4VhJBsZCfWIk3OayFlpGf0OymaOwM9Zpl63h5ieHvt+TUqoAmR1Wgz4XMZAd0oqCsSoi8umkpDdCoUk87XbtQlKh/xqDyUp35N1698xAwoS7fBuj45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lYnoa+u5; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d55d86f95so2113951e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729694363; x=1730299163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WhPKDbFTUZYFFVIAP/OH1JPHMZdUigC397OHZv1u/EA=;
        b=lYnoa+u5Lmqi5lsIbXLnM5yL6d+4Sm+jl8VQ/2a6esAdI8uIOw+cjvGUJfEkehwWY5
         2Z4qgPxJ1lGd+TKg4LLPnO6s1ycNlRgiExjJXuN1oYs/oTZ9y3huX22LqQKBHd1fRYkt
         udrS1dpnPzpvn+kqjlsRYyh+2hTH/+8KzVvOxFrP8ORAsRGG2kgBW64re++8EKNYhn2a
         bMxpxizFQ9VXKwZyVtDELYNGqKMOp5KqIAGeshmWrMt4OMc+KrriLpF4pyVd5RitLvc4
         vcleEk3o0D3Esmc654hNRlo0YE/vzqitCOa11inE6YG09v+LcywAe/uLN5H3WGIcQMyo
         aUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729694363; x=1730299163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhPKDbFTUZYFFVIAP/OH1JPHMZdUigC397OHZv1u/EA=;
        b=wwRHP2Rk0rn7yHOVJCMm3PJBHWopygaNOiw1Y7QYL/6OjjziizF/rryWaZVlFWUCvU
         ltP/GRTbqc0dQO4Psi3uW+vDNGP0b3wgqS4HrsfhJI5Aevk0hrSWTh+/9L6q0tbwCSoW
         YEztvQj+9m7VDsTSaskpwhnfWPoPhpqMXXmYjSN1CW07WpG0fe14rKxgCYGCdY4d0wEP
         Cb4Mbn7FjJbqe3CUVyo+bhaHfNFunZvl6Gen+O9Am66jKj7xW3Fu4jPn/rzgFUzyKIUE
         L2gTH5i22FvEjkRPHmEWdPXhgXirujDik5Qij34ojIIF8fuKIRA8sZuSxVpJq7kzWGqR
         hHzw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ffL84ElU8YKaeNzaiECjlSoIJwLavfZjBPsxn1UKpzR0VgiO+k11iYlJRoWJW1Q/syVivWoWBBE6FO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7iACRvyEBTMyniGP3b6tSJCyRG7/o4o+oXEBVKkPVgfVchqX
	F2+YQKBS00aQUJFAoaXEakdVyUcc5H0RFujVYiS7mQCfJ8qy6+2/GMP3/KFWCqmzHLJMfYY4jWC
	EruSqzKZC20hjEqMf+Psn6V4lpi8/LErF6FB35w==
X-Google-Smtp-Source: AGHT+IEGxTvgFJQKGjPndiT4g1UmrIbaruLgKpKg20RzOuGPbLbHepYglwQf3SmW4/COXfCydu/3Ww6v3WefxwQ10jU=
X-Received: by 2002:a05:6122:2a53:b0:50d:60fa:183e with SMTP id
 71dfb90a1353d-50fd037aecemr2859533e0c.11.1729694363103; Wed, 23 Oct 2024
 07:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 23 Oct 2024 20:09:11 +0530
Message-ID: <CA+G9fYt19NZ=8wY9aQRdYjtsPgiaywUQ2ff+TGkX-6zLBUGsNA@mail.gmail.com>
Subject: axm55xx_defconfig: ld.lld: error: undefined symbol: lockdown_reasons
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-security-module@vger.kernel.org
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Paul Moore <paul@paul-moore.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"Serge E. Hallyn" <serge@hallyn.com>, James Morris <jmorris@namei.org>, 
	Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following build regressions are noticed on arm due to following
Warnings and errors with gcc-13, clang-19 and clang-nightly with
axm55xx_defconfig.

Started happening on next-20241023.
Good:  next-20241022
Bad:   next-20241023

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
=E2=80=94-------
ld.lld: error: undefined symbol: lockdown_reasons
>>> referenced by lsm_audit.c:417 (security/lsm_audit.c:417)
>>>               security/lsm_audit.o:(audit_log_lsm_data) in archive vmli=
nux.a
>>> referenced by lsm_audit.c:417 (security/lsm_audit.c:417)
>>>               security/lsm_audit.o:(audit_log_lsm_data) in archive vmli=
nux.a

Links:
=E2=80=94---
Download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2npIko0KV1uYFA7CZM7n=
R9jHBBO/

Metadata:
=E2=80=94----
Git_describe: next-20241023
Git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it
Git_sha: ceab669fdf7b7510b4e4997b33d6f66e433a96db
Build_name: clang-19
Compiler: clang-19 and gcc-13
Config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2npIko0KV1uY=
FA7CZM7nR9jHBBO/config
Download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2npIko0KV1uYFA7CZM7n=
R9jHBBO/
arch: arm
config: axm55xx_defconfig

--
Linaro LKFT
https://lkft.linaro.org

