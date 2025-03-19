Return-Path: <linux-kernel+bounces-567506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103D9A68729
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F524202D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D9B1DE8B9;
	Wed, 19 Mar 2025 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsoqfH73"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50AE30100
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373950; cv=none; b=o5KIke6odJsMCRhYhS2AwuEWTKaeMQi+wTjIBvYe0A0igWusBxUe2iqvAD1An6Gs0EGUbn4/bucPy/S88Lk7uAgC+DH5rC2JeYFFeFfgavysI2We6x8l3U4i7VOsmfT4JjOMRZwHLZwH29886hYPAUVVNbfINdVv0q1GxStKssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373950; c=relaxed/simple;
	bh=UDJF4yFEETNbWHpTVeaJlLUhMBnrA6tmX8ZHSUJtHDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGgc+1vt+XGnmo0uebaU+dgs8BYH9beRWCGs9EhZYIsWBaRNr2xRGAckKDtdJMA03rU17uC8ZWQIe9fGUByk/OkTgeB+75YFtKGiAef+/tk9tksGxafPuFDK70I8StrBQ1uI678M5qFHME2zwuJYFvEjSvb5hc//IxI43egBlyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SsoqfH73; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso360460566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742373947; x=1742978747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L0O2rCb+DaX8HqdxNasaujBYaNNGtxnFrgvPE/yXr2Y=;
        b=SsoqfH73rMY+bCC+o7cR+2mNH85VB9kUNb3MeyZyWnfos05MGnexBfiMQtjUY6ObRO
         jMlHD9yQ6nuLbHeRZLMOaduMyBraejJhoM27zDAzNy/rJXFj6AxiPvQX2dgbeq4b209r
         dE7K4sTYyGm+iZbIKr0mnYFJvwGvCjx7aRkzz398YWPfc7invNYLcbTu/kPyFU7ugQVt
         0rKvm7X+ibVKLUZM6zGpsSLkzHZNfbXfSU8ADIzzosZ76lg0tbkUOtIxthYr7tloH5WK
         /RFJ+7GHIvDLsCD1YVqeB9U3ym4Ypfwayi1IJsblUEdJMYP3o6SEhsT+FSQ4E8WbmAmG
         GuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373947; x=1742978747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0O2rCb+DaX8HqdxNasaujBYaNNGtxnFrgvPE/yXr2Y=;
        b=edZdP6i2jKi1C4tY4EnBb+4/KYiGPSrtUGnv65lwtHL+OiI+S9yGies6Vz+VBMMp5n
         4/4jIcnty4dEvUUJMB/aujKMU8A34+6eOeVFSKbXhj3bbTrlzWKJsrlFobyF11Cbcvlo
         C4BoQ8W3z7O5es0L6o+OURMF06r2El+Q0dEg+rv1XpVPloYwhyNIHqH4XGt9CWpzqvXN
         KXO6sXyRU2NVdc9zfY8Frly/v5UlnUbrR6hgquTg2svL3u9E93bQnpWTHiylBjO6XfZU
         W3JzlWNrn5jw2ljDIV0MghRMKTbOBD6AXNplNxnUZ29AnGo0oQeWJKs37JAZelA0K7jc
         PJhw==
X-Forwarded-Encrypted: i=1; AJvYcCWwhpYNX2Fa/FmSB7K0BBgX+DYdaOoTu3ME2gGUL5sjGlSubXieSlignZiOGgyDSclvVKtZ7x5SnmcLGxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZU9CtRXx215/SsUVeGjDV3eVFGqJKQK2+BM4Pg32MlhG8xBGw
	zVQLp29GiUMsXSP1U9Tt/MmAJaV1LDX8FgUJBfCX1RQOtLdgvMCzd6yrrg+9C4+CRaa07MCTXDM
	hM1Wjlk9cwvx/H9nOCm0v76CDxdQi7s++PpxnJHqzv1F/z66U2/A=
X-Gm-Gg: ASbGncuA6zyC5p0FeDVk6u52cXuQlT+wXbF7rKlfUFd26ianzsNkiGHHj5eYtJvbI9z
	ksvzMBe8wPbz3w2A1TQBElkkzedn2Faeza0wcZ7lvJfNJw1Nbd4Rtls4XzlU3gUg7zM7PacvBXr
	SCB3jAA6YIuv1QnPMEvtEaiMiR
X-Google-Smtp-Source: AGHT+IHym655Hwbl747AoxWCCaJZH6fGzraYc8ADhISmR96/XJP6zLar/jDpGtTVqZo7yzRSzcsGolv45EpDxpG/A98=
X-Received: by 2002:a17:907:2ce3:b0:ac3:b12c:b1f2 with SMTP id
 a640c23a62f3a-ac3b7f58e9amr168611966b.35.1742373946973; Wed, 19 Mar 2025
 01:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318022358.195154-1-wujianyong@hygon.cn>
In-Reply-To: <20250318022358.195154-1-wujianyong@hygon.cn>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 19 Mar 2025 09:45:35 +0100
X-Gm-Features: AQ5f1JqZ4IfQDptWZ_YlMKn5RnHZTZp30vr2pI9fB4frru7jic4yggpmFf4YBEA
Message-ID: <CAKfTPtA+41UxOi6C2fcgZ1mjaL19rBYi5Kidc6TSYLhNt3u1mw@mail.gmail.com>
Subject: Re: [PATCH] SCHED: scatter nohz idle balance target cpus
To: Jianyong Wu <wujianyong@hygon.cn>
Cc: mingo@redhat.com, peterz@infradead.org, jianyong.wu@outlook.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 03:27, Jianyong Wu <wujianyong@hygon.cn> wrote:
>
> Currently, cpu selection logic for nohz idle balance lacks history info
> that leads to cpu0 is always chosen if it's in nohz cpu mask. It's not
> fair fot the tasks reside in numa node0. It's worse in the machine with
> large cpu number, nohz idle balance may be very heavy.

Could you provide more details about why it's not fair for tasks that
reside on numa node 0 ? cpu0 is idle so ilb doesn't steal time to
other tasks.

Do you have figures or use cases to highlight this unfairness ?

>
> To address this issue, adding a member to "nohz" to indicate who is
> chosen last time and choose next for this round of nohz idle balance.
>
> Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
> ---
>  kernel/sched/fair.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c798d2795243..ba6930c79e25 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7197,6 +7197,7 @@ static struct {
>         atomic_t nr_cpus;
>         int has_blocked;                /* Idle CPUS has blocked load */
>         int needs_update;               /* Newly idle CPUs need their next_balance collated */
> +       int last_cpu;                   /* Last cpu chosen to do nohz idle balance */
>         unsigned long next_balance;     /* in jiffy units */
>         unsigned long next_blocked;     /* Next update of blocked load in jiffies */
>  } nohz ____cacheline_aligned;
> @@ -12266,13 +12267,15 @@ static inline int find_new_ilb(void)
>
>         hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
>
> -       for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
> +       for_each_cpu_wrap(ilb_cpu, nohz.idle_cpus_mask, nohz.last_cpu + 1) {
>
> -               if (ilb_cpu == smp_processor_id())
> +               if (ilb_cpu == smp_processor_id() || !cpumask_test_cpu(ilb_cpu, hk_mask))
>                         continue;
>
> -               if (idle_cpu(ilb_cpu))
> +               if (idle_cpu(ilb_cpu)) {
> +                       nohz.last_cpu = ilb_cpu;
>                         return ilb_cpu;
> +               }
>         }
>
>         return -1;
> --
> 2.43.0
>

