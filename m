Return-Path: <linux-kernel+bounces-315401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB896C22B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117F01F23B35
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02C91DCB1A;
	Wed,  4 Sep 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4OZSUDg"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BAD1DC19C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463470; cv=none; b=ajBnfbbIyLmYICtP54oktzthzhZkYhg39+W06kd13UvdVJD1hchjB2zmmge2ofZJZlKk7Qrc3erkydyjG1vyR1XVaD+qPz7jTeDCFze+qd7Ho/C0uCcHflwIqqvNWESCzuqprFNLspZPE4B9i+M/x55sJU+VrETNlINV5XfZMHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463470; c=relaxed/simple;
	bh=k4s71oW9moOCsdFZlopjnSjXbz5WCfMgT+KvfPUYXQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBtSuNqfhntyOEPa2OvdR1DPcZxmqzPPdlaSnX3TyZ3HJN0AdufRJoWbZxwaR4iY00o62qY6KDd80DTBNbF2EcOgtL9dwmQ15YmH1q98r0hH3vG8CLGqenFf9QLWKq2cgZYrdEEN++3ihTVD7yfb+ywgt5+/c29vXP8dxjULbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4OZSUDg; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5344ab30508so825116e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725463467; x=1726068267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4s71oW9moOCsdFZlopjnSjXbz5WCfMgT+KvfPUYXQw=;
        b=D4OZSUDgcdaSta4VBo5vqZoUZqg/exkUYU0f9HHvJQbhYG8dqVH3Mx9E9IAX9GU/ZF
         hriTFz1RidUK8g/9LVuuyYUyl4r1TueBnNh3UEjvpByZigNqZmDHk4E43KJIPBCTQu5R
         abcQ6X1gwXpnFmUGizeruhcGOBnjuRmtsGcKku96BQqTUtpfdkB8DbxzLA2hglRJpco1
         E6uOgnWbHjuTj6XOUp9f/DPKH2uBXfVbSIxAFz7o+2cofPFljx/TJ12EtgslvhUFQAap
         6r7CLemH/cyflV5VIy+/ixHqbZmPUnQR+etOx3QM2pdWFAmphtPr3f4gSSIV+V0Ugj5p
         ypJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463467; x=1726068267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4s71oW9moOCsdFZlopjnSjXbz5WCfMgT+KvfPUYXQw=;
        b=k8zRnaP7tbf1pk6dlJdBmnMUhGBVeBllUvJl2s9l7eZHZ/fexf6buGzAx9jVS3uG+J
         MG6lP4zDY991nn/VQyQROZmYN3HeFkP8xJYM9523tqUghVoxMAsdu5nU1gsiWVRd/vPk
         ELj6029cvWR/dEsaAgm3YV4eDz+GD2c1DMEaYgBOlvgyX5B2vzLz5igfu7dhqIco/SVy
         noCWEoT2kRw0tv57PlDSnkE3irwfvw2CVkxrteWBldz0LU2k0s3yktgMIGYIebfYDXeU
         jeaxup6NJNBbbL4aQgWib/l+ftkz5k+hbAfan/nuc0Zjva82V0ok76l9H/8qOwezkuAu
         ZA5A==
X-Forwarded-Encrypted: i=1; AJvYcCVZQ+ha94yXVimbrXpFf/K+skhx8f1jzTNouMj+GHuZYrEjcGGEAVtDPFdV9x9+HfYsWUqyOf6xoOhQjcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpiulv3kaQ1hpXtxCJzl+pcBBKA/w+z4EwPY0kUlJpvOdoaj2D
	T2q2Veuanl8IowaVc2HsnbM2GArwyvpR/RJJ3SdlyP8SodLZcRRDuJBVJDr15ilG/B62+R8hcKn
	WcH0pBWK33MqADe5nOQKiyCetV0b6vg==
X-Google-Smtp-Source: AGHT+IFZR3MLtznpkuUk2W+vfgapW1m/zYiHRXTV7QKkHUEzrgRx2bld4Et4sniTdM4ewEqOtObr9aJ8g993PFBLQNo=
X-Received: by 2002:a05:6512:b90:b0:533:4191:fa4a with SMTP id
 2adb3069b0e04-53567790bd5mr880356e87.15.1725463465795; Wed, 04 Sep 2024
 08:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904095205.739422-1-ubizjak@gmail.com> <CAAhV-H5WX7KXXpLkLm_4L-y5J-4fx-72uN+cvFGOZZh2NXUbHw@mail.gmail.com>
In-Reply-To: <CAAhV-H5WX7KXXpLkLm_4L-y5J-4fx-72uN+cvFGOZZh2NXUbHw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 4 Sep 2024 17:24:13 +0200
Message-ID: <CAFULd4abR8Upu5UecVes-sEc9his2yWL7pg8hwKSJ+ORSNL5Ag@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:02=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> Hi, Uros,
>
> Thank you for your patch.
>
> On Wed, Sep 4, 2024 at 5:52=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
> >
> > _percpu_read() and _percpu_write() macros call __percpu_read()
> > and __percpu_write() static inline functions that result in a single
> > assembly instruction. Percpu infrastructure expects its leaf
> > definitions to encode the size of their percpu variable, so the patch
> > merges asm clauses from the static inline function into the
> > corresponding leaf macros.
> It seems in some other places we prefer inline functions rather than
> macros, but this patch is the opposite...

Please note that these are leaf macros (functions), always used
through the upper level macro (see e.g. the definition of
raw_cpu_read() and __pcpu_size_call_return() in
include/linux/percpu-defs.h). These upper level macros do type check
on the pointer, so there is no need to do it again in the leaf macro.
The percpu address space checks on x86 depend on the presence of these
checks.

> >
> > The secondary effect of this change is to avoid explicit __percpu
> > function arguments. Currently, __percpu macro is defined in
> > include/linux/compiler_types.h, but with proposed patch [1],
> > __percpu definition will need macros from include/asm-generic/percpu.h,
> > creating forward dependency loop.
> Macros don't check types, so use macros to drop "__percpu" checking?
> Seems a little strange.

As explained above, types are checked in the upper level macro (that
uses these leaf macros) through __verify_pcpu_ptr(). These checks
currently use sparse to check __percpu tag, but x86 will soon use the
compiler infrastructure with much more powerful checks in this place.

So, there is really no need to type check percpu pointer also in leaf funct=
ions.

Best regards,
Uros.

