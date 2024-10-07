Return-Path: <linux-kernel+bounces-354122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779EA993809
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063CC1F22605
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23741DE4CC;
	Mon,  7 Oct 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnID6JNF"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C51DE4D8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332040; cv=none; b=pr9Y1PKkrlU91/IQSm9QwnOBDIfC2kGTNAjWaHJQkGgp7txQ0KYBo17p05cdcspZjK7mAN7D0+8Z/rSRCJUeVFkziyrLZk02NDvS6Ofo/fd5r5BfefMfE7sNX3Eg5sNdrWif6pwVN/0cBJFnlF5SU85MMRam/vXTtXGrNJ6kT5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332040; c=relaxed/simple;
	bh=dYf0vNhufwXL6YYKPS8LYNCtI04PBWt28yE5E2EJ0pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayDkm85ntv4UvvesXpERo4ScZbgF96lVJ8aTH7yc7C2k/x1kAuOY2qXZ1JIb+wBDPsbF3eYNz18KzIlO6M/71tUCSbKutqL3Pnlhu/EK3GJiujEpBADhjcfwA6kQ6jS0RdgXGA+YcYNZGex/2fetS2h/VmCbuyKjqbxOORkuavk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MnID6JNF; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6db4b602e38so40081567b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728332037; x=1728936837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoXiivIPsvv87cjrNNR6k9YUkmVHQ+v2vRTV4AcmfZ4=;
        b=MnID6JNFHUlPiZFc0c0r2z16VY+0JNmVm3xUosojF3OgMYx17/buG6PGI0jEGPTdJH
         19637EUMvhi3NuibMqAU7SVwaQYYdSDGOvsukx3RID+xasLXZ7fUeFzSEfxv+Dcptwal
         GShqPF+vy/j7HivtUp0XeHhZa0Vjm5aKe1Wi7dwUCOUTqceTr0DKetT6e5yPIvQz90/5
         FvdWIxP/Rn8nXEF0tCEMRa9XpIsz6oH3BCI4erc1I0FhBdK0excPsa8XDXLkrit7J1Iu
         DO5h7tBspQoNORyeFgB/8QGB1V9AkRFc+hAyBnR8vgE56IaYJrkg1aIQRAVpgitS9r57
         Msdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332037; x=1728936837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoXiivIPsvv87cjrNNR6k9YUkmVHQ+v2vRTV4AcmfZ4=;
        b=Axp6wcuGwqvpgOe9jTXu35Fz4UTAbWhGwmFFMURXWme+IJbNHzM6a4NeKL95yvpMpI
         2SPOU6T+jD7/2dvAdC8iJAmn/I3KKy+t+W/hOoUrA68ZRpxL+8moxJJYVEHpq3TwsKpw
         vDIKNjsv4V5+ZYjDl5a5+pX0GIW1Qhqx1JaMX9HZEbbGq+qu3SBVsI/iNLtd2jo22xt3
         WuZ2XvVGJBKTakCtlgROTQjwLTLf7EuneEdQ1aT7wP+zcfEO7SLGAFVmoZEB2nQeE4uv
         nM3NTa5zhsm8J0xTwPSg56iTEf3f8NRPKg1+ABX4OpmNfHfc03f+ANIlMkXekdVng7Z8
         n3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUJdgxLHz5hciMel1KbGsuAUZgtBta6rjTl5IR2XjvDBRSKWctro2re8ezcRjUy9KI044M/vGzpeY3QsI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfyANBzARn0xyjirYHP6LuM2UBbf1AoIRWK6g0wnc4DXOj97pu
	tF8RsCKojcbo6Fm+QxqdFAErYg1nX1vFetMn+p0X2Lmzpu0yTzJe9TIzgwxGLJnmEaHafMk1ayt
	vsU0nyJCBPfEMKp1s/+b3SGV/gqjLrV1xOq2sWw==
X-Google-Smtp-Source: AGHT+IEemXp+EwkiqGhHJcXGCpvIbGD3LaTbLUsZH/iRvPEavrRlY5OGsv6kRpFh6IICBCS1cCjdPY7p2JkZOKY8R8c=
X-Received: by 2002:a05:690c:b:b0:6e2:167e:814f with SMTP id
 00721157ae682-6e2c7289b2emr91643627b3.31.1728332037260; Mon, 07 Oct 2024
 13:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005140150.4109700-1-quic_kuldsing@quicinc.com>
 <20241005140150.4109700-3-quic_kuldsing@quicinc.com> <wzrj4vhrb4h3pe5dft7vqz2tl55txdyuciuxlysuck5isi7r4z@bs2ts3popy2t>
 <2eb53ea6-848a-48bb-8c31-83a118bc5a73@quicinc.com>
In-Reply-To: <2eb53ea6-848a-48bb-8c31-83a118bc5a73@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 7 Oct 2024 22:13:46 +0200
Message-ID: <CAA8EJppEQKJ=oQh=TeFaP0z1sXDQhz=LN_TC4YygiLOe_EX6Tw@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: qcom: qcom_tzmem: Implement sanity checks
To: Kuldeep Singh <quic_kuldsing@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Oct 2024 at 21:17, Kuldeep Singh <quic_kuldsing@quicinc.com> wrot=
e:
>
>
> On 10/7/2024 1:00 AM, Dmitry Baryshkov wrote:
> > On Sat, Oct 05, 2024 at 07:31:50PM GMT, Kuldeep Singh wrote:
> >> The qcom_tzmem driver currently has multiple exposed APIs that lack
> >> validations on input parameters. This oversight can lead to unexpected
> >> crashes due to null pointer dereference when incorrect inputs are
> >> provided.
> >>
> >> To address this issue, add required sanity for all input parameters in
> >> the exposed APIs.
> >
> > Please don't be overprotective. Inserting guarding conditions is good,
> > inserting useless guarding conditions is bad, it complicates the driver
> > and makes it harder to follow. Please validate return data rather than
> > adding extra checks to the functions.
>
> Sure, I=E2=80=99ll remove the redundant checks.
> Please see below for explanations.
>
> My intention here is to handle erroneous conditions gracefully to avoid s=
ystem crashes, as crashes can be detrimental.

Please fix the callers first, rather than adding band-aids.

>
> >>
> >> Signed-off-by: Kuldeep Singh <quic_kuldsing@quicinc.com>
> >> ---
> >>  drivers/firmware/qcom/qcom_tzmem.c | 17 ++++++++++++++++-
> >>  1 file changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qco=
m/qcom_tzmem.c
> >> index 92b365178235..2f2e1f2fa9fc 100644
> >> --- a/drivers/firmware/qcom/qcom_tzmem.c
> >> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> >> @@ -203,6 +203,9 @@ qcom_tzmem_pool_new(const struct qcom_tzmem_pool_c=
onfig *config)
> >>
> >>      might_sleep();
> >>
> >> +    if (!config || !config->policy)
> >
> > config can not be NULL
> > Ack for config->policy check.
>
> Considering a scenario where user doesn't fill config struct details and =
call devm_qcom_tzmem_pool_new.
> config will be null in that case.

Likewise other driver (not the user!) can pass NULL to other
functions, crashing the kernel. This is not a way to go.

>
> >
> >> +            return ERR_PTR(-EINVAL);
> >> +
> >>      switch (config->policy) {
> >>      case QCOM_TZMEM_POLICY_STATIC:
> >>              if (!config->initial_size)
> >> @@ -316,6 +319,9 @@ devm_qcom_tzmem_pool_new(struct device *dev,
> >>      struct qcom_tzmem_pool *pool;
> >>      int ret;
> >>
> >> +    if (!dev || !config)
> >> +            return ERR_PTR(-EINVAL);
> >
> > dev can not be NULL
> > config can not be NULL
>
> dev may not be always __scm->dev.
> For ex: qcom_qseecom_uefisecapp.c pass it's own dev.
> If new calling driver pass dev as null, will lead to NPD.

Just don't. I don't see other devm_ functions checking the dev param,
because generally we believe in the sanity of driver authors.

>
> >
> >> +
> >>      pool =3D qcom_tzmem_pool_new(config);
> >>      if (IS_ERR(pool))
> >>              return pool;
> >> @@ -366,7 +372,7 @@ void *qcom_tzmem_alloc(struct qcom_tzmem_pool *poo=
l, size_t size, gfp_t gfp)
> >>      unsigned long vaddr;
> >>      int ret;
> >>
> >> -    if (!size)
> >> +    if (!pool || !size)
> >
> > Is it really possible to pass NULL as pool? Which code path leads to
> > this event?
>
> qcom_tzmem_alloc/free need to be used once pool is already created with d=
evm_qcom_tzmem_pool_new API.
> If pool isn't created, then calling qcom_tzmem_alloc/free will be erroneu=
s.

If your driver doesn't check pool_new() result, then it's broken.

>
> >
> >>              return NULL;
> >>
> >>      size =3D PAGE_ALIGN(size);
> >> @@ -412,6 +418,9 @@ void qcom_tzmem_free(void *vaddr)
> >>  {
> >>      struct qcom_tzmem_chunk *chunk;
> >>
> >> +    if (!vaddr)
> >> +            return;
> >
> > Ack, simplifies error handling and matches existing kfree-like function=
s.
> >
> >> +
> >>      scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock)
> >>              chunk =3D radix_tree_delete_item(&qcom_tzmem_chunks,
> >>                                             (unsigned long)vaddr, NULL=
);
> >> @@ -446,6 +455,9 @@ phys_addr_t qcom_tzmem_to_phys(void *vaddr)
> >>      void __rcu **slot;
> >>      phys_addr_t ret;
> >>
> >> +    if (!vaddr)
> >
> > Is it possible?
>
> Yes, A scenario where qcom_tzmem_alloc fails resulting vaddr as 0 followe=
d by no null check.
> Now, immediately passing vaddr to qcom_tzmem_to_phys will again cause NPD=
.

Likewise. If you driver doesn't check qcom_tzmem_alloc(), it's broken
and must be fixed. Null pointer exception will help fix the driver.
Adding such band-aids will hide the issue.

>
> >
> >> +            return 0;
> >> +
> >>      guard(spinlock_irqsave)(&qcom_tzmem_chunks_lock);
> >>
> >>      radix_tree_for_each_slot(slot, &qcom_tzmem_chunks, &iter, 0) {
> >> @@ -466,6 +478,9 @@ EXPORT_SYMBOL_GPL(qcom_tzmem_to_phys);
> >>
> >>  int qcom_tzmem_enable(struct device *dev)
> >>  {
> >> +    if (!dev)
> >> +            return -EINVAL;
> >
> > Definitely not possible.
>
> Ack, by this time __scm->dev will be initialised in qcom_scm driver and c=
annot be null.
> If some other caller even try and qcom_tzmem_dev is already set hence, re=
turn -EBUSY.
> Will drop the check.


--=20
With best wishes
Dmitry

