Return-Path: <linux-kernel+bounces-404978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C29C4B44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148142812AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555420264A;
	Tue, 12 Nov 2024 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlZR6fta"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D15200BAF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372752; cv=none; b=ErGT0e34ACp5JRWmF58n/u5LyARd3ifhwmgJb3BxH+V5OJDgTqcuBMUA4i8rqx5Uc6LhhZrgx48DOhgvNy8fcY0bIfvNlmQp8AsgWqKRm74frHquFlS3pbZw0lkb3C/BJtFaaUwTKuhDuwpfjbiPNPYos67y/+AsMq4fqwzNoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372752; c=relaxed/simple;
	bh=Wph0OYiV3ntON+fu+PtnMe16jvUo7k3ccZUDgNqiupQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ7zJio33eGqI4GenfpLjEcp4hkOauRlSO1HEai5XjmRnozuACKnFDs7lUewO0QekBUhTYLrBANwvomrO+aIzQis31VDfEnxg9SKSOtTYy8euWxwMotNMEfWmI/AS4SpuP83Jc61FbYOUnCHzul9bNeldAVIt/IcqiZKvAHkgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rlZR6fta; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e19d8c41so7771e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731372749; x=1731977549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/3C5QTs7l3Bpik5RV8yY+zOUnmIc6f4W9i+LJl1HIQ=;
        b=rlZR6fta9dLKsDgpLXMXZObDu/181cXd1xuGs3Zud9nA529Ke+wOQ3ED6DNu9ab7H9
         J4HOt8FHCqzqkT+cbVxSo3Donmli9TV/NxV9A694llWqcaC2dzJqpOMqjC817nZWd5L3
         VRBFgxtN/Ydr25V5jnYVoY5cnLFQsi2ykcpcX6Dn5nUyJAsJMP8/g1/wLfP7pxmHtuVl
         9BR1R753iFP1p1gDjgFblShEzN7cgqxcfjV7DO4jsly4oOav5ZMEhgvo+xNTh2oafD2r
         8ywOmN11ncL0qzmw9brbzo+F3f0+nMxecdIapEBmCxe+qsYYjPrIBY8NNBBL/6noLzXA
         fKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731372749; x=1731977549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/3C5QTs7l3Bpik5RV8yY+zOUnmIc6f4W9i+LJl1HIQ=;
        b=qMVyuc6gaPAo78RRmznXLlpoHW4aKpXOBolZ+IZ996ecrk2QiMwisAz9EjClFPMgso
         NX6GrYwif1tpGDmt9JWibnI2jcs8aiKW6/dBFAD7lrBgbVg4zFFo7S391VFRvx8ct97E
         KBULsy7dQC+9sXvlmNOrkv1j0U5KMhaCPhdegw/oRs7JKFyN91kz84GqFmxgXmEimwPR
         B2ImhbgCnbd39xvU6JDesu9d6N3oFpVNgLPRVKaqaBoysUqhzLBGLVkZbuykz1Jkq3ce
         6HQL7EtGAbBuOkko7uIuJJAWOEz7uXidfvwkneRAlfZnEoTRoQtPZ5W6a4sVTG15Ch+i
         Gu0g==
X-Forwarded-Encrypted: i=1; AJvYcCX7HQ8YXU7szYI+uvF3+5RtjUSJllr7YhRdjOKj/aIVyp+9AEQ4628WkzNkHjD2M0qVGXdKRvX8XIOkU3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzddEHHp7VGyG701Q352OdWjjFpml/lOnN44kqHT4UiCRjMZwz9
	mKM1m5I2IZClrUmmaM7gldUSKMeCzb5tsERJCuAXFApHKiRo38OmKy5g3ldjxT3RBS0A3c5AvSk
	As6gL1OcP3LVyxoi790krwKVgaJhF38d443Ed
X-Gm-Gg: ASbGncuMRXMBRevf2NXm/S5TSPrMs6d5Mhs3m4qlWOjbeGYoJLAT+RdrBfGkrlAoA8R
	8iEhB67pkeWFUe/YePRG+tKkFoolWJV169IRx/R/yAV0w4qL77wInpGluvO0evg==
X-Google-Smtp-Source: AGHT+IHYsqCCOn+C3yPmQ8eRLf6BbWJJRJBSA1CffumGjbn9E9PJBhWGGAwk02oUVBhtLbBpMWoEoOGe5NySvm1wHcw=
X-Received: by 2002:ac2:4c08:0:b0:52e:8a42:f152 with SMTP id
 2adb3069b0e04-53d9b8d6dedmr23863e87.5.1731372749138; Mon, 11 Nov 2024
 16:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108211446.3304809-1-kaleshsingh@google.com>
 <86r07jz6uh.wl-maz@kernel.org> <CAC_TJvd=fNRx2VOcEEgjdkY53MwpR0Xa4dX1KTy=nNew7dg9Mw@mail.gmail.com>
 <86o72lzmi6.wl-maz@kernel.org>
In-Reply-To: <86o72lzmi6.wl-maz@kernel.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 11 Nov 2024 16:52:17 -0800
Message-ID: <CAC_TJve8tuBpoeTjwg5=PKFhFaD=M5nwxeJsHeYP1ZezMd_Wug@mail.gmail.com>
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

On Mon, Nov 11, 2024 at 9:52=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Hi Kalesh,
>
> On Mon, 11 Nov 2024 17:10:18 +0000,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > I tried to be conservative with the configuration only allowing only
> > up to 2 pages. Your points are fair concerns, I can see how this still
> > may not be ideal for upstream. However, I think introducing
> > NVHE_STACK_SIZE as a refactor still has value, similar to how
> > OVERFLOW_STACK_SIZE is handled. If there are no objections, I=E2=80=99l=
l
> > resend a v2 of the patch, dropping the configuration parts and
> > focusing on the refactor to introduce NVHE_STACK_SIZE.
>
> I'd be OK with the refactoring on its own, which is a nice enough
> cleanup.

Posted v2 at: https://lore.kernel.org/r/20241112003336.1375584-1-kaleshsing=
h@google.com/

Thanks,
Kalesh

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

