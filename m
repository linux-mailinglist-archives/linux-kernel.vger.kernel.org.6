Return-Path: <linux-kernel+bounces-225656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C8913357
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B2B1C21155
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF8B152789;
	Sat, 22 Jun 2024 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCEt83Cl"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61CB14D2B3
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719055455; cv=none; b=JOYCBiU+qAR+WpKARB0sMkG8X/ly65fRJYnRZMf+Wh6ehEyVm4gCFROkWOPnifpW3DnyHDeOdohJhr7b+V4UGytGknWCKZHXJoAels98jDLRFjmOmZwknx8d1tB/JPtXwPIGtVSKzyJX7VznM60r4bTyaviHEpK+G/jCYQkeCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719055455; c=relaxed/simple;
	bh=XczZR1S8ZzwxLPnjy3oktjL68CvtruQEAnv/yw/vx1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+Zra0KYtCw//PA184CsrgUNcS1qbfLrvjL46yCdcnPCOu6jxQ9zyGsih2qr7XTcr3GjAiwk7PGQTfcOGjCxDdbfUCihb8+zrfoIUJtpGKVnJdWfjddwee2q44oqlrc8r/rgoEWXveXtBRzjZ56ak2iK0WyeYBhhG7faFT+zQGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCEt83Cl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f0e153eddso350986266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 04:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719055452; x=1719660252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83J6bYCjzPDrL4GISkhSjjehJb5GWsoBmA7ZxJY3FUc=;
        b=CCEt83Clu5pG5BOgPOldSb53EqTObcNNusnLip4rQjyKiUtThNi5zDCCV2WwVS7Ez8
         V/3gDZJvcXgvUkEL1Baii4S+EMDGxxdmiWhFPe7Aybq9Tu6Citd3bVwa2MZgcRHXlJnm
         Plbg7v4py/Dgl2igDnNGssrBMq0maIWhELi1rbT4pvXwoDxZ6Nrq85MuMkDUjKlhiPB/
         V24wsRaEZao0McLWiTC2/Z9CWtl1wJC6hRTHGp3aFsIFdGNrxbsZXrs2zOy/jRW7pCCi
         7Tl4n+F58vGBz4RfYyuDvqqd1AYOvfARX7jNLtrc1jmAsum3W61dv0pLKc9aRAidjPRV
         BkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719055452; x=1719660252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83J6bYCjzPDrL4GISkhSjjehJb5GWsoBmA7ZxJY3FUc=;
        b=ZB9epBZB/gzlEyIcQor0z7q3VjlnH1U3If+nUXbbifaYBavnj+XXjifMO9zqPpOvVl
         aP30pS/J3mawu2WWwMnYGQ8KsJaLDkFsiX1eWeAXBO+IULBRCRjNFm+z3vnK5Ko83SaQ
         vnYnyaFZW3UH8FMGK1iIEnsAtFAyfagiMjB5jjx7vjuj1E5Dy4ZDPwjAnpuLrRS8kHoJ
         Y4ilSZVXVCWK/UmXV+giw1+6YDhSt3aMzz+GsQqTzmxb5R9IdDpkvorZWaSVhs5ryR2H
         xbkT9W1ltT9Unef2oJULhdrf2r+xittCJfKvZxyKtkXUdyoSCdzQtyL7e4axPIX27HT8
         /OSw==
X-Forwarded-Encrypted: i=1; AJvYcCVCj/JIyyPNz9wDdN+dcmXYjKLJaLduRkLt5PpRjrme2/WnvQxhOciD+7iVpSVSFLcZu6hzLE3VZFQcwyCVmgT1bmTdHCfJnxyInQYW
X-Gm-Message-State: AOJu0YzYfObR09gazA1+JeVKuJwLZuVo5mhJomGo5QR9m+t7gTYX1uIz
	tRCVTlU8LKTYUsrjFPUjeJYFbT7n338Ka3hy5PboPDLGhdbT9CK0C2nG811s6joWB6wiix8UX72
	505YAnLTRvcE6regtVL8fT2LekyeOMRFMF7M=
X-Google-Smtp-Source: AGHT+IE/sh7/DstBLL1Mzt0UJOMiXW/wEaf/vpKw+eRSACu0bNwFz/0qtVahwNV3rhK2Rs6oypIxybf80gb8Kv/TpQQ=
X-Received: by 2002:a17:907:118a:b0:a6f:7d7e:ab0e with SMTP id
 a640c23a62f3a-a715f94a6a8mr46634166b.27.1719055451338; Sat, 22 Jun 2024
 04:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620020625.3851354-1-chenhuacai@loongson.cn>
 <87msnem3i1.ffs@tglx> <CAAhV-H5TNnf+EMEtKmXk+Q9KXSZpW+9vd-7qqXDifsKfny+v=g@mail.gmail.com>
 <87pls9z3g0.ffs@tglx>
In-Reply-To: <87pls9z3g0.ffs@tglx>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sat, 22 Jun 2024 19:23:59 +0800
Message-ID: <CAAhV-H7noyrYJzyVML8y1gHPiB6qZzXy7j5L_AqjxwLZW2J06A@mail.gmail.com>
Subject: Re: [PATCH V2] irqchip/loongson-eiointc: Use early_cpu_to_node()
 instead of cpu_to_node()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Sat, Jun 22, 2024 at 6:17=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Huacai!
>
> On Sat, Jun 22 2024 at 10:49, Huacai Chen wrote:
> > On Sat, Jun 22, 2024 at 4:42=E2=80=AFAM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >>
> >> On Thu, Jun 20 2024 at 10:06, Huacai Chen wrote:
> >> > When we use "nr_cpus=3Dn" to hard limit the CPU number, cpu_to_node(=
) is
> >> > not usable because it can only applied on "possible" CPUs. On the ot=
her
> >> > hand, early_cpu_to_node() can be always used instead.
> > cpu_to_node() depends on per-cpu area, and per-cpu area is only usable
> > for "possible" CPUs.
>
> When nr_cpus=3Dn is on the command line then what needs to access
> something for CPUs which are not possible to come ever online?
>
> That does not make sense because it's exactly the same situation when
> you compile a kernel with NR_CPU=3D8 and boot it on a system with 16
> CPUs. Then early_cpu_to_node() does not give you anything either.
>
> So what's the technical problem you are trying to solve?
Frankly, there are some drawbacks on our hardware. On a dual-bridge
machine, there are two eiointc instances. Even if nr_cpus limits the
"possible" CPUs, we still hope the eiointc driver can initialize
correctly, otherwise the machine cannot boot.

Huacai

>
> Thanks,
>
>         tglx

