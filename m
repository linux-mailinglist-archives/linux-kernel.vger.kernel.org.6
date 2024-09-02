Return-Path: <linux-kernel+bounces-311372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B1C968847
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790AF1F2323D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027BA20FA8B;
	Mon,  2 Sep 2024 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvwItzQk"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DF19C56C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282106; cv=none; b=RyEjMd6DyR/6RlT4+SYB6GLbY+RK1PYOUFNwYRFhZ4SrDatkceqGiJy4hIn8+hQOUQcVPFgiFxkBOxDV5JA7c3NkOx5QTElTYmIPrwxSZiOmC2s5Bx/Mj7FEoxkBU73YQI7NdpA4lwdnrwmv8pewWpYXsXR1H1IIc6iLBSEQXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282106; c=relaxed/simple;
	bh=OqcJZ/1GMKCCiNdCksBYuf+yCIrGEq2SbmEzRSEKkyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poanBC5/KrbApzD/hfzM1hHKc7Ufb0E/plmgaNRFNREDeRqv1E+fvJVrNt1YU/kuJRhzDG9euAiSkSw23XsJs+ILur0nq1P+TQZCMM1xMkqqmFY6hXOv1OrrOIJgx+wIs4mFlnyENhBL15ua+MEWjTaS8y5ya9WXXCBPUP+mZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvwItzQk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8679f534c3so435697866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725282103; x=1725886903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqcJZ/1GMKCCiNdCksBYuf+yCIrGEq2SbmEzRSEKkyk=;
        b=ZvwItzQkAwNedFcs630M+hLkw/tmm/lisIdJNLZDIo4ioaq6NGjbE8qAGHx8oRdjRX
         hOHRN4BDvrfUNdMneVeSCgsjtIqTm1xdMwLzHSWqOxE0LWjKjH5/XSdpRAyxVa6g71Th
         Ho2s40tUMpQrRrWR2fah77keuK+G9oYT0cEtYQ1FbkZhywbzz9zDEpUUaVuagODf1dkE
         rkuZaeS2E7ApquwVR9D0OHk75WvdZzargYA/1MMIMMLjforRf5KMDjAbjrtfnHqJjqIg
         2CphjEHDsm2ml08w8Oeb5AYrdp5Gea7gJOZXsuyqkRFQPvLU2KKbGAQek7iRI2pbfz+/
         iPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282103; x=1725886903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqcJZ/1GMKCCiNdCksBYuf+yCIrGEq2SbmEzRSEKkyk=;
        b=ueH8pHPo9Nwdh8liifelGR5HyVQFf9q7OFl03KaCcvzQk2HP0lg02rGEu8l6NXK4FJ
         lcx0DnWO4jC72N2qGxCmnm56WaSuxhcyEEN40Tm6IOQzbKVmOddjpc198l61RxbSaHAr
         00V8QFDD3Y5A642nbmBzArZ6U1NVV/3fJXehS/qJmMbslBh/iZD5tT5qrSyA4Hi2mwYE
         nXuuYcplcSbXhWYNiNnbq/YvR7PXnbPhOgdx8PHaeIlgdmls83HWVeSbk9hqbUzn9qs0
         2drBNJHDK0ZuxO0BDwdZ+LYb4jf9GvbvvbHThEVtCpK0t1aEwl1BLl02PDHselx0Gqtg
         XemA==
X-Forwarded-Encrypted: i=1; AJvYcCVttf8u4sCNS418rxMR9mad7pLmcekbThO1XlAFia93dWc6iRvnNOJ99tfOj0lN52Dl0c1NRx+N8ESZ0zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPZKGZeD/VlzO/PwAZ2U5zz0YCLf2+39YEO0/JHDwn0CE5yFm
	h69BoDoVFlGUulJfpvwgNE2slLScUwAcdyCmCvtBuAqx5sEd+eseb991R4ZjXDrtLHEmKNlJMd9
	wghxBJBujiBQh4thG0lkLIQ0lFUsXszMT3UoO
X-Google-Smtp-Source: AGHT+IEqxuDt5F9iLAPqh29duXxwhGXKRe2nes7X9QlYEzjiULot5Kc8klsLZ2ZBF8NXVRMhqG5+6UVEa6rSFv8Zqvo=
X-Received: by 2002:a17:907:701:b0:a80:7193:bd88 with SMTP id
 a640c23a62f3a-a89d879cf05mr456688866b.36.1725282101820; Mon, 02 Sep 2024
 06:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831113223.9627-1-jdamato@fastly.com>
In-Reply-To: <20240831113223.9627-1-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Sep 2024 15:01:28 +0200
Message-ID: <CANn89iK+09DW95LTFwN1tA=_hV7xvA0mY4O4d-LwVbmNkO0y3w@mail.gmail.com>
Subject: Re: [PATCH net] net: napi: Make napi_defer_irqs u32
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, stable@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Breno Leitao <leitao@debian.org>, 
	Johannes Berg <johannes.berg@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 1:32=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> napi_defer_irqs was added to net_device and napi_defer_irqs_count was
> added to napi_struct, both as type int.
>
> This value never goes below zero. Change the type for both from int to
> u32, and add an overflow check to sysfs to limit the value to S32_MAX.
>
> Before this patch:
>
> $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irq=
s'
> $ cat /sys/class/net/eth4/napi_defer_hard_irqs
> -2147483647
>
> After this patch:
>
> $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irq=
s'
> bash: line 0: echo: write error: Numerical result out of range
>
> Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> Cc: stable@kernel.org
> Cc: Eric Dumazet <edumazet@google.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

I do not think this deserves a change to stable trees.

Signed or unsigned, what is the issue ?

Do you really need one extra bit ?

/sys/class/net/XXXXX/tx_queue_len has a similar behavior.

