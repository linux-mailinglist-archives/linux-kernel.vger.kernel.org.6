Return-Path: <linux-kernel+bounces-319250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4D596F9B4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E101C21DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42FD1D3656;
	Fri,  6 Sep 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rqknm6Ii"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD531C7B68
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642170; cv=none; b=DTP64mof4ng3obaA1e/g3baW84e9xFjkh9g05smmn41pk//pRel5+WQXN+l17kLVogFJjZ1GFmz4C/MJ16tlMN8yuEDxUtPAap4Xl514D7JyTcwlztKFw7XGSYq7wKqkRtn0oC2bZTKjudGeaqFzrDkHOFyihdc3tGuDowQCtyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642170; c=relaxed/simple;
	bh=oDQyeDN6x6feLLNz7Tj41MDNPFozAKm4j/9+bq0ncWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFxpLGGAnJcwiSSS8srjB4aUViVOkevrgBOYhB87LHFum0TVMOlThUzJmheAgCHNjHaomcfdDh40KV0gYvb8u6U6DJw1Lemb+sBafEtluzdMarOoAvA05n30AR+iIROu/6rZlt1biBca4SDx21K2vdDJEqQky8OCDLeGP1Iqez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rqknm6Ii; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53653682246so2640930e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725642167; x=1726246967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uENxaxnclvVCvmgJuvNtWvKyAhvfJ3nihqRMstXCeYQ=;
        b=Rqknm6IilczL4hYDE9qGxZR3kBsOyI88g7+ws/POEUQoS/oJ66J8frugru5pzb4ZVA
         CDiEWgdOOal/c3cdomJpQqgkWua5B49+vSuCWILAYG5k3j1uDCyplOt0RcxHt4ArXg/d
         oa60g29kEy19xIg2jEXQdfSuIO5SHNPlzV0pKO5kyLlZfNplU3Fsowk/PXl7RJcqvObS
         gs7OPhtGlzcbKCGEFNNtj1lfBWvw0CuWu7xkOPwq6005Yf/qbHPNUrPvYaNKFu2EvJbH
         NGPqXzZYAlsqnER1ohns51MCKQHU6jcesPXyMqF8Vd2AoRFFV2HizQTl+4U6ttOhlpSv
         TviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725642167; x=1726246967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uENxaxnclvVCvmgJuvNtWvKyAhvfJ3nihqRMstXCeYQ=;
        b=l/mVYkv+hRiIjVCq3AtYlJgDDMABQOCgZd/NZjrDMEJ0B/K62OZBGjHUZVn6+0gEbH
         I1izFs+v1YWdox67eg/eFIr7w5jRgGAB1NnQ0bFLgsvnDIntF3zCR/5a3Zht5K+lnpN5
         URybwH2xZlgL21eiCJF9X55DmC/tDTVNbWBFeGIlip8t4cxc5mnVKy7k4ffdbXi4NPFT
         oShMPvVQsR0NRYl9a471oz+o3FwX6D4jXlXnEMg9DGl3xLu8I84WU6kaaOyvILLlBISR
         TjFLnkGN5fpCiQgCXEZyOZ6zH57txpJyOfx8Bk5crDrBpxGDyD0auqX6dO/fuuKKT+kp
         SzYw==
X-Forwarded-Encrypted: i=1; AJvYcCWxtkyPnEmNZiXOnp6wZpW2LcOIvYWg6NX1/29+88F1hkdUpm70dRJIywUr2VhnyXtjSwjzhiwLZgyWbKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLs3IynOYQK1rRXk5pTp/iibjbwW0s95RGqFvIoYLcZter07I
	66f+RJf55xKPg52g3G4LbkK8kVIiMWq4G6ycQPezz6o/m+5OnO3+CRAnJOBlJPV2Jnydf4MrWf0
	NtpLmF5R6LnruABHcy20fe+MkKC2dvB1FZxk=
X-Google-Smtp-Source: AGHT+IEAjcIdVXG3LCuQQZgGEb9EphDS1hzeYUxXI3+fucHgGXGRFRBNw8wO7Kgl1htxg0PyMIDK1SvqZhqgmyPkFkI=
X-Received: by 2002:a05:6512:12c1:b0:52c:de29:9ff with SMTP id
 2adb3069b0e04-536587a3673mr2186688e87.2.1725642165755; Fri, 06 Sep 2024
 10:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906025259.3822-1-zhangjiao2@cmss.chinamobile.com> <49d07daa-622f-4c04-9d00-221f8abfb4f3@linuxfoundation.org>
In-Reply-To: <49d07daa-622f-4c04-9d00-221f8abfb4f3@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Fri, 6 Sep 2024 10:02:32 -0700
Message-ID: <CANDhNCqZitCt2ffrbEKKJtuVJPNAw8y_BdoZ3iu_5BhH1j2b+g@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/timers: Remove unused NSEC_PER_SEC macro
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, anna-maria@linutronix.de, 
	frederic@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:29=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
> On 9/5/24 20:52, zhangjiao2 wrote:
> > diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/=
testing/selftests/timers/skew_consistency.c
> > index c8e6bffe4e0a..83450145fe65 100644
> > --- a/tools/testing/selftests/timers/skew_consistency.c
> > +++ b/tools/testing/selftests/timers/skew_consistency.c
> > @@ -36,8 +36,6 @@
> >   #include <sys/wait.h>
> >   #include "../kselftest.h"
> >
> > -#define NSEC_PER_SEC 1000000000LL
> > -
> >   int main(int argc, char **argv)
> >   {
> >       struct timex tx;
>
> This looks good to me.
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>
> John, I can pick this up with if you are okay with this change.

No objection from me, if you're ok with the commit.
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

