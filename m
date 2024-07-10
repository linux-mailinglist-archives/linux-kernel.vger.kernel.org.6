Return-Path: <linux-kernel+bounces-247797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7996492D4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D022817FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2395919409A;
	Wed, 10 Jul 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buBiwgwM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0D18FA14;
	Wed, 10 Jul 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623955; cv=none; b=N4Ik8tUJFcg+vZ806f4eZuWkQOPc1ikpMkDnUasvueVF8ow9y01IB/+q9GveEUr7R7qkgdSbGcudfaJMiASkTiLAbk0RiLPV95q4iT4Ri+CoSCnMQ7IVI7LVonCmPJkvj/mLTDACKXmapeJRQ8DLsZgCk6EbkdA/qyUsI4KuyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623955; c=relaxed/simple;
	bh=FDOqf3NZsuH6K85ttda3DFcxqrcrd0sCoBz7WWYK+7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aL/JfbFL2YzKby9SrFMzJCBllP1nNcQJBtntwwyRV/mM42Osc7n+wgvkDBpRbibBbgNxrdeDPORxgt1qnoDrEeSCvMjW4yVjkvPetZ2LDJmcNa1mXllFPVlOYSZKe+BOupoDZpdzJ54KzvejAOjotcvtC+s4ixrCxrWNLg6sQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buBiwgwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3056EC4AF09;
	Wed, 10 Jul 2024 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720623955;
	bh=FDOqf3NZsuH6K85ttda3DFcxqrcrd0sCoBz7WWYK+7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=buBiwgwMpETkR87hwbkaQomyp8rP8g99MAYSG+UkgSuVODkJzxu1xuQIz97qcF9g6
	 wybZBhigsHK8Pv+mNlQ3QjTLMBcKICPTrAqKZIinDLt3CdXN5VtERxYKndgzwce+vZ
	 y3UeGgyr0W4z7pj0mDvU958nFkUwQZbNt/Nc+FOkSK5GbvpcYReX0DJAnaVoVjc+eG
	 6/ik+1FF5K/v2SOVtSwklNZcEed66p5M6Q2UMJb18ZffYmCcLKAFQPYmx7ta346V6t
	 aTyggwErqjG+k7RoNypUSRcZCAVnRRykvR95OknnWVrIBgLXjZBV3b0vb4R5Hkxcjj
	 eVfshG3om/eMg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e9944764fso7283020e87.3;
        Wed, 10 Jul 2024 08:05:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCUqiAA8vnmq+rIQjKMDO4COaOAOGmHHDRB6VNfjMM2L8jSGZdwfWpSxGGwtP868n4XUI/W83IZRw4Rp/bZuK6wDcm/YATp4QegHVamtIC9oNgrUmMrya3ChzKmRWjpnN6QwbrMPqzgA==
X-Gm-Message-State: AOJu0YybJHUgYPDaTL+/5MXCLTnDvBTiNoAdqiDGeKqGQBSTHDXLhoa/
	vJ2NLqIpCLZFEuh3s4I+epsQKlmfTgrxCkBln4fcjxjdTcvQbGW97RbMHrf+Pq9LBCzXhXKydYW
	ymIwaaLjw6OtzML1E4OGKbNB/mg==
X-Google-Smtp-Source: AGHT+IEIUkk/BsP8wkKMGirN8S3ezlwotGr6d0Lu6412aAG8/TajyZAFmIdYfqJvaNgLw8m5fcuAyLE1Puf5rWJHW+o=
X-Received: by 2002:a05:6512:200b:b0:52e:9ab9:da14 with SMTP id
 2adb3069b0e04-52eb999a268mr2794941e87.31.1720623953481; Wed, 10 Jul 2024
 08:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeaa9b78-5853-473e-b985-b10241e88e0d@xenosoft.de>
 <8FDD860C-4DA4-46EF-BAD6-8F68837DA993@xenosoft.de> <c8010a06-9d8d-466a-9a83-ee25950f1885@xenosoft.de>
In-Reply-To: <c8010a06-9d8d-466a-9a83-ee25950f1885@xenosoft.de>
From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Jul 2024 09:05:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJE+YZY3h+MZ0wzT2SZ5dLq_zR1iteNcdLUOoVPwKkxRw@mail.gmail.com>
Message-ID: <CAL_JsqJE+YZY3h+MZ0wzT2SZ5dLq_zR1iteNcdLUOoVPwKkxRw@mail.gmail.com>
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives
 after the of/irq updates 2024-05-29
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Marc Zyngier <maz@kernel.org>, apatel@ventanamicro.com, 
	DTML <devicetree@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>, 
	Matthew Leaman <matthew@a-eon.biz>, Darren Stevens <darren@stevens-zone.net>, 
	Christian Zigotzky <info@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 9:53=E2=80=AFPM Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:
>
> Hi All,
>
> The RC7 of kernel 6.10 boots without any problems [1] if we use the
> second irq patch [2]. Is it possible to add this patch to the mainline
> kernel?

Yes, sent it to Linus yesterday.

Rob

