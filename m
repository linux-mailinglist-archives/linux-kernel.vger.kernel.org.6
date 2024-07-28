Return-Path: <linux-kernel+bounces-264501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BCA93E436
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 11:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2081C20DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCD182C5;
	Sun, 28 Jul 2024 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgRkMz/0"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D17470;
	Sun, 28 Jul 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722157672; cv=none; b=psQZv3PPD2KdEExShT+2Xp53y6esylKtu/y7B1RUSPwower+8AmxSjN0NIC/YEnr6oeNEpnCfMqcL6MqVmImb+csdPB55xi7g71Qto/HYILMXoIgi79kLY0IoUTNEaddxm/cPce/dptErY96ZhY5AD4uQmHA4jFOhJ7ZauecVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722157672; c=relaxed/simple;
	bh=d6MnTgenfOL+W+Mm/KqLB1W4gF85BhaRChKUTlxf/+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAI1oBuQwgkx/X4ukdBpogE3J2GqRjf36SA7hw9DgqM1/t095ng5xnP+FXg3nFg2w4CYQAWwenkM62Px5STvBebaGXAzQBHK+YUrFzk/Rf9ZY5ijIlMkmCoecdDd+3sXXEBgTEw+ZUbyKZUVFwe8ATnvpxSHFaHlbtrn3l1sK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgRkMz/0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efd530a4eso3931487e87.0;
        Sun, 28 Jul 2024 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722157669; x=1722762469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDm5lhbnjzGft1D4SRLvbZwncRsLFhBAeyQWaqbnUok=;
        b=XgRkMz/0/Zj3ROzkAvffsJgL9HaAk99j3lzT8djyuVfMRmxGxnD9YRwHSi6Mzb+3FO
         lwJD+5YN3nyMIk+2wuCpDdypB41U4qGLD79/VO/nyD9PryfeO5hZrhcAS4qneIFSsGzj
         0CPSQ3/bAsNacl8DHDcvulB89cWIRNarbgLy1ems0AZ8o57qk9ZFRAUSu/F0GHw/sX1v
         OehZRMaBEnjpDgVTEPRQiLe1TJorlIX6tX4uRvhDxq62Bih5z9Vy6Q16OAEIuwTzzMvC
         0/ZZf91RH3IQok+IL2strKI8oH3ig4xb75NW8z8224mbElE3L1LXs8d59Ae6IvAtROZb
         w/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722157669; x=1722762469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDm5lhbnjzGft1D4SRLvbZwncRsLFhBAeyQWaqbnUok=;
        b=oKV4BHODYdKpwXiFWVRbITbsNXmuwvE+v2GT6/uzeXkQ684F3ZK5d9bKwvHaj3v/Kh
         n0vFGbc2MCrFFuh+AvdLzLMM0DqFrksewITQkFQ4jz1xtES8fYAHksx53glJYYAQ9UEs
         w+xN+hzuv5Ry8w3BlYj7Oz2HK0H2cZPuekvQ7cfv+b2HU+fsdtC7CG8Gv/lRKB1MFJ4B
         k+Yb+q0VCFWFDipjGOKCdk4UugbTLayjYLMUIEobqLcuvQvUp1fS2OOgwOfTG9aHUIVm
         1t+p/aWzFWmib+Qz3lGy4RCK9tebBGXrYXhebGwBDTOYO6XppZFo2y+41YtqL01luqLH
         asaw==
X-Forwarded-Encrypted: i=1; AJvYcCWwd8ryOiMuqHRQhJndJdmCLIQgIu+UTELQ7/xg1DR8IrFKra08y/dEiuLLY7QQ25Di0jmUfBpXmYGBQ+UkIKW9Gv+CA/dDJjv2OiAnhAIJM44Q6HSe9LMVygKRN+xKYIYxJMbGcBhb
X-Gm-Message-State: AOJu0YwxWGa3mmdxowNplgaBnCVrFMg0UYV6l+zZeDjJzvvndeGirklY
	9wyoWo7l21fOsM5m3CM1cyj77EiVs2NcfLz0KclvDViS7tEa8Cz2yf7IOjffjI66jrMikV4xnNC
	7CusX8dz7V8pTR3PZqy8DETMikVBQ/YDf
X-Google-Smtp-Source: AGHT+IFUFEXAT6VQtZK2YWhqLLnJTj3uhW2S5lYnAazdZqW1IxvkQdT0jBMJSPdvzDZ+Yz1Z1Cxkzyfi4Tuu3S0LmhU=
X-Received: by 2002:a05:6512:3ba9:b0:52c:859c:91dd with SMTP id
 2adb3069b0e04-5309b270551mr3176940e87.5.1722157669031; Sun, 28 Jul 2024
 02:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726120930.3231333-1-leitao@debian.org>
In-Reply-To: <20240726120930.3231333-1-leitao@debian.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 28 Jul 2024 18:07:37 +0900
Message-ID: <CAC5umyhXdjJ-jw+WxZzQd+cc76f5UGC_akz6at13BSPD7shk0Q@mail.gmail.com>
Subject: Re: [PATCH] docs: fault-injection: document cache-filter feature for failslab
To: Breno Leitao <leitao@debian.org>, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc: Jonathan Corbet <corbet@lwn.net>, kuba@kernel.org, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8826=E6=97=A5(=E9=87=91) 21:09 Breno Leitao <leitao@de=
bian.org>:
>
> The failslab fault injection mechanism has an undocumented capability
> that provides significant utility in testing and debugging. This feature,
> introduced in commit 4c13dd3b48fcb ("failslab: add ability to filter slab
> caches"), allows for targeted error injection into specific slab caches.
>
> However, it was inadvertently left undocumented at the time of its
> implementation.
>
> Add documentation for the cache-filter feature in the failslab mode
> description. Also, providing a practical example demonstrating how to
> use cache-filter to inject failures specifically when allocating socket
> buffers (skbs).
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  .../fault-injection/fault-injection.rst       | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/fault-injection/fault-injection.rst b/Document=
ation/fault-injection/fault-injection.rst
> index 70380a2a01b4..07c24710bd21 100644
> --- a/Documentation/fault-injection/fault-injection.rst
> +++ b/Documentation/fault-injection/fault-injection.rst
> @@ -141,6 +141,14 @@ configuration of fault-injection capabilities.
>         default is 'Y', setting it to 'N' will also inject failures into
>         highmem/user allocations (__GFP_HIGHMEM allocations).
>
> +- /sys/kernel/debug/failslab/cache-filter
> +       Format: { 'Y' | 'N' }
> +
> +        default is 'N', setting it to 'Y' will only inject failures when
> +        objects are requests from certain caches.
> +
> +        Select the cache by writing '1' to /sys/kernel/slab/<cache>/fail=
slab:
> +
>  - /sys/kernel/debug/failslab/ignore-gfp-wait:
>  - /sys/kernel/debug/fail_page_alloc/ignore-gfp-wait:
>
> @@ -459,6 +467,18 @@ Application Examples
>      losetup -d $DEVICE
>      rm testfile.img
>
> +------------------------------------------------------------------------=
------
> +
> +- Inject only skbuff allocation failures ::
> +
> +    # mark skbuff_head_cache as faulty
> +    echo 1 > /sys/kernel/slab/skbuff_head_cache/failslab
> +    # Turn on cache filter (off by default)
> +    echo 1 > /sys/kernel/debug/failslab/cache-filter
> +    # Turn on fault injection
> +    echo 1 > /sys/kernel/debug/failslab/times
> +    echo 1 > /sys/kernel/debug/failslab/probability
> +
>
>  Tool to run command with failslab or fail_page_alloc
>  ----------------------------------------------------

Looks good.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

