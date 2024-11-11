Return-Path: <linux-kernel+bounces-404398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A499C433B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE765284387
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ABB1A3BDE;
	Mon, 11 Nov 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxrKjsVK"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990C1A08C2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345033; cv=none; b=RLync+pEGrVZ72SBFI/nixZL4bfmhMOD5tjs/Uxe8vDz8fzvTdsOK3Aik+l0k+1WqAnvMC4HpvDeUIyQt0Jc/eLfyqex3Zq/Ual1NT91eSG0hVmWdfBkd9SrDO2qCHLwuGKQbnrY9xWazIHQ7qNHy2S/bZVd2niCYsT39TOdZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345033; c=relaxed/simple;
	bh=i5NhtbwOcLViUAJdqOOQbA/lmCYxIBb46SymhlGhA68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYVb58UEEdLDlVwxTyp7svBl8Xnja9qEcR5uGpHlxHl8P31oWr2UsleAV8kUdpEnn1w73whGeXWiieVVrDhd8y1FU6Y+ynz9Er+qLXhVdxrjBZk8zdgDdX1e8G/+Z/8XqAYTRg17gUmGyqL5HWgH/Yvjb4aHo+fw7hG9PMlVSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CxrKjsVK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso20400a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731345030; x=1731949830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZbeLLseB5b8+ehFZfsw37ALHDLGBMJMLyk1xIdLiNI=;
        b=CxrKjsVKRvdKMrBMxZFyIcUT9leWVBAuLIRnuO7kvhiJfpYqIFZx+bQt/9brJWWJ1f
         LpbRl7miJSC2cjduijLPgyDgWnUHbD1xhwHiXLY+oCuVAdCAmBouTXrEpMRvjq6Rjqih
         0OjhRASydS8nA3qwaFgHQvAX0kERbWeLQfY5kmE4NcCB2cLPnQIJR3krPx+Gj3qfDGaH
         hwrV7TAusFGUUciMzUy9HNL/n+qsFHYTPHuYKMAyZtV1rB2SkmeV3+wEhyngxjUijApR
         fH1yoGxQMHo1IGd/cfgYmby0ipoMvQwsVfhIUz6w8sj/0o0ur/G0fFCsqCC0dpHnSdRY
         Q3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345030; x=1731949830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZbeLLseB5b8+ehFZfsw37ALHDLGBMJMLyk1xIdLiNI=;
        b=MmHJwhFYgT7E+K/7c5B8AIiPrEUkfLWGIQyaYjyJxhr7z83zeNtypiYp3g+7YMLS0n
         NTYwF6DGLbQwGt+SULkPvYbKS7J4vzoyLPsU4XmoZx7pz+lBMp26AnmcESI7NwWFFnLf
         duh/jq+4a3eyfYxt3H8AiYtlxrsA+4aNGMCIJN+4khuSTorI89WIYdDeyoiKSNv+oUwl
         EVq9l5noNemw5w4JWvk35+4iRHavKsVemm9QDyzR/bX9Kw4b52B5YdHsTUafa6o/v6GW
         ls/06H5pTlBKIk34YV9dF1NRH5H64BLwMLR4UAU/cgfDWDgRqXioUfk6xWTitrNhABYV
         C1EA==
X-Forwarded-Encrypted: i=1; AJvYcCWmot2Nc8LnHYeBGL1kl0ndd9aXh9AaDKwmjxVk1g+URDD05kVu/l0Ozd5x3L89rX6+jbmzjQwPDQvCtQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/o/mcPnI2Zjj3zIWTEyHj5C1U/eN2U6IR1TBYhSeiL+6g5eRo
	4iEF0nRZK0gmKUalPMM8jscURciUdaNws7y75g9KYnlIuNseb22TYT3q5uEZex6OXz5j5Brr/3z
	S9WTTOgJKwnrqgzGIu6UUjjb9gguF6MBhknec
X-Gm-Gg: ASbGncsabYOZhTI1q/l3LG/vfXPA6kQuGzPNixxIjwtzDtsR42DyEvYunR/GomcpQ17
	2c14svlwczdyqDT+030jyeI9+M7ThPrjJPb3F5fntAtwvGhkqHOiBhXyTx5WKpQ==
X-Google-Smtp-Source: AGHT+IHgerBC9h2YwDfKDijAh6osZ2kMh3HmOgZnIMcMCgU4EDXSlgxbGcjXjle/6Rd24wYQJ071PNSrdzccO67zBYI=
X-Received: by 2002:a05:6402:7c2:b0:5c8:84b5:7e78 with SMTP id
 4fb4d7f45d1cf-5cf1c83cea9mr353370a12.4.1731345030142; Mon, 11 Nov 2024
 09:10:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108211446.3304809-1-kaleshsingh@google.com> <86r07jz6uh.wl-maz@kernel.org>
In-Reply-To: <86r07jz6uh.wl-maz@kernel.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 11 Nov 2024 09:10:18 -0800
Message-ID: <CAC_TJvd=fNRx2VOcEEgjdkY53MwpR0Xa4dX1KTy=nNew7dg9Mw@mail.gmail.com>
Subject: Re: [PATCH] arm64: kvm: Make nvhe stack size configurable
To: Marc Zyngier <maz@kernel.org>
Cc: will@kernel.org, qperret@google.com, broonie@kernel.org, 
	mark.rutland@arm.com, keir@google.com, vdonnefort@google.com, 
	kernel-team@android.com, android-mm@google.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Ard Biesheuvel <ardb@kernel.org>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Wang Jinchao <wangjinchao@xfusion.com>, 
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>, =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 3:06=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> [that's an impressive Cc list...]
>
> On Fri, 08 Nov 2024 21:14:00 +0000,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > In order to make the nVHE stack size easily configurable,
> > introduce NVHE_STACK_SHIFT which must be >=3D PAGE_SHIFT.
> >
> > The default stack size remains 1 page (no functional change)
> >
> > Downstream vendor features which require a larger stack
> > can configure it by setting CONFIG_NVHE_STACK_SHIFT.
>
> We don't let make the stack size configurable for the rest of the
> kernel, do we? Why should a tiny portion be treated differently?
>
> Making this configurable means that testing is harder, and bugs harder
> to reproduce. It also seems specially designed to allow badly written
> code to run in hypervisor context. And once you allow two pages to be
> used (up to 128kB), what prevents the "downstream vendor" to push this
> to 4 or 8?
>
> If anything, I would prefer to see this (obviously out of tree) code
> isolated with its own stack instead of growing EL2's private stack. At
> least this would make the problems attributable to the guilty party.

Hi Marc,

Thanks for the comments.

I tried to be conservative with the configuration only allowing only
up to 2 pages. Your points are fair concerns, I can see how this still
may not be ideal for upstream. However, I think introducing
NVHE_STACK_SIZE as a refactor still has value, similar to how
OVERFLOW_STACK_SIZE is handled. If there are no objections, I=E2=80=99ll
resend a v2 of the patch, dropping the configuration parts and
focusing on the refactor to introduce NVHE_STACK_SIZE.

--Kalesh
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

