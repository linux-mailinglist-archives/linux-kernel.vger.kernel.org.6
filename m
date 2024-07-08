Return-Path: <linux-kernel+bounces-244718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C67F92A869
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6A31C21277
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57AB1494C9;
	Mon,  8 Jul 2024 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxMjx8y8"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C01482F5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461012; cv=none; b=JtBBVwg7MldKpzQiYO9hLjoZsKKXIMjzDh66Fx5GwbXSa3YS1b+rFBcpptHIfVEG6d9Vz7y8x0ZjzzQe8G51vL99ogj3zkzG6/Kd5Qd6nJ4xQAENA0htpziK/wEA5MdPo+V2CDAqe0Q7qsWbm7dO+g6cM4RcZXyjchQ+VsSyWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461012; c=relaxed/simple;
	bh=Cgeu270hOmX3S5GZTXTxjnZltMxA5nAub89Ban01DjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoxLrpjpZww+0QikNfYhTECxPxFKF1InHNpW36oLhThfoQdVpEh4hVEfVk1JY7FEAgJ5wyOADLaKZGN3pMg4u7Gh6UW0pECEAnG51qrgV1LEmbbQrrVpEMmZiWH7cWGGnb7BWNxmrAwMjUgUAOzpkOZrwUYpVngIqB9GTqXh1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxMjx8y8; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df481bf6680so4080161276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720461009; x=1721065809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nESyMzGZXBtAqIeO/AYycg3VVtY82ta3I2iF0FVP4cE=;
        b=kxMjx8y8+f//+s7hEupd9DKh37DXdEahAVb2tjOhRg3I+KR8cBC+wrlTsZAnearr09
         poj2fR+HiezIpXAOvx/+j4SXmv+jxd0LUv5DwTlvGskBUXBE8x75i0fSPlD85ZY0TpUf
         ljmRpZu75n+UXw9PVSFuH4+fI/ctN49/YzKmtyLM7aLkkeiPp92sAzp5BEO3nZ2O7Zov
         Anr+kyAuj3iiTQB4BwPToWM9CnelVdJ+vWj3uZclatMRnAU5+NEzocQ5+gY6rptYn5U4
         5SfYoxdr3MyxJSy59iWeIaFI31lEwYk7Hdi9y6LrbijHXCaf9kewubcp5GHXvOL186U2
         exzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461009; x=1721065809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nESyMzGZXBtAqIeO/AYycg3VVtY82ta3I2iF0FVP4cE=;
        b=aeLwtckJH9LuR7w3uumJ82CoXvOJuNOvqaEjzeTvarEvFyFIBOCx+oy1rR9WYAQkA7
         CZcXc9yrnSWxAVbS/jysU9LAAr/Z42rlLXeQiAo7pVZYUQA4JkWU0ym7uxmg8h9pJTH8
         qPxoZs/oUGTtYYWkO/Vc+iqxP6oBwRfXai6HJYRxlbyxYd6Cq3x67sWCZ/wFryk0ysEQ
         v/p7Ay9UKJ8nlsDaIq8HzIWEWd8Km0jtCL9bt51LJor8peK3MX5g0ljXIBe+WPaqWOsK
         a66T34lalNkSo16s27QTJOwKGtwqBm+H+uMaSIYf6ZdgDwlmw7pleuzQBWaQVrVHoZQO
         iaBA==
X-Forwarded-Encrypted: i=1; AJvYcCWpmrtZdLh8JeOy6s9c1dXx7naSSGF4oJJer99qGftYXBH0HFppd+pW4XIa/Ml43qDm8EkRzJ+MrqNsxL/cyIGgEdu7Zfn2mZ1ggIwv
X-Gm-Message-State: AOJu0YxxhRV7RgLhLv7KCIDz8Kyo2NgBtWjL0ZzRl15sAjNi7pAKJbj5
	nTz0WuGl6IEdGvSJtNfhTntjUK64Z2LyH9Ma+yz2WTRidvuQ54hZwLVpi1HhzLdjjK6vpFHFrqs
	z/D8gs7VnyOdLIbdT/ruVJ9S6NH9c+KwohvfQ
X-Google-Smtp-Source: AGHT+IHcxq/i9rzCxsEN5hnVo4LPbu8O3jBlhcP+IANI38Pst6MQnmRwrHXpKPTOw9a59dfbicjTNMHGzlIpXAxgcP4=
X-Received: by 2002:a05:6902:1361:b0:e03:4e08:c93c with SMTP id
 3f1490d57ef6-e041b03995dmr571404276.13.1720461009288; Mon, 08 Jul 2024
 10:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708134654.1725-1-yuzenghui@huawei.com>
In-Reply-To: <20240708134654.1725-1-yuzenghui@huawei.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 8 Jul 2024 10:49:57 -0700
Message-ID: <CABdmKX1CXWuw0-gRukZeSoF=SZFi3eRPELe=EU_-q3OVKQHZzw@mail.gmail.com>
Subject: Re: [PATCH] kselftests: dmabuf-heaps: Ensure the driver name is null-terminated
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
	shuah@kernel.org, wanghaibin.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 6:47=E2=80=AFAM Zenghui Yu <yuzenghui@huawei.com> wr=
ote:
>
> Even if a vgem device is configured in, we will skip the import_vgem_fd()
> test almost every time.
>
>   TAP version 13
>   1..11
>   # Testing heap: system
>   # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   # Testing allocation and importing:
>   ok 1 # SKIP Could not open vgem -1
>
> The problem is that we use the DRM_IOCTL_VERSION ioctl to query the drive=
r
> version information but leave the name field a non-null-terminated string=
.
> Terminate it properly to actually test against the vgem device.

Hm yeah. Looks like drm_copy_field resets version.name to the actual
size of the name in the case of truncation, so maybe worth checking
that too in case there is a name like "vgemfoo" that gets converted to
"vgem\0" by this?

>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index 5f541522364f..2fcc74998fa9 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -32,6 +32,8 @@ static int check_vgem(int fd)
>         if (ret)
>                 return 0;
>
> +       name[4] =3D '\0';
> +
>         return !strcmp(name, "vgem");
>  }
>
> --
> 2.33.0
>

