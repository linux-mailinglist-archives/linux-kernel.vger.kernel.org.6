Return-Path: <linux-kernel+bounces-417711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA999D583A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2FD1F20FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC913D509;
	Fri, 22 Nov 2024 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePWiMv1s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FCC230988
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241847; cv=none; b=rcnKkNkr2WGM+Tx9LQFiN+Fj4OfLf9+98eu0GGORLHZzatWLHYNnzv/2Vz8G+2XwqEXfUaAzAzLP8TbRwZjmiq2REq0tQBb+BvIL+pJs/xBkK7fLh90co2NA9YHeS74JSly+Ifh2GjSSLWfgHpzCLfmczfftmZYwLncwurYNJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241847; c=relaxed/simple;
	bh=ddC3zSEmscyO0nqLLSx+KJlKaxs1qJUrPHKpcJZ65AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DE8RlzW4B3yDOmrCV+phhtBvpFMi7pLUOcPBx1y8kUSbjff/MmK3nbzhX6u1qok0jTcpA33/YDRM33taJkl/LBnz0TKExlaBxJmi+wRLVJNb7vjrv3xe7MwXzuIw2f8YhGO89fmuylJPwg5jNq5ti8FqIFtx9PuOi/A96sF38TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePWiMv1s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732241845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0rwZntxeuzz614rWcmK6DkyUn4Us9C9cxRvDMcMi3g=;
	b=ePWiMv1s4vFU57DeqKRxUO56gIjsO+h9er5oZJuy2E3qfKUNtpCVa9nu2+X82M8iSEnB0b
	Lo9IrTb+A4WVsh8T+PR+KuZg0AsvbOwKNuxNy+XkBUKUPAXmTZBRlu/R2V8lzNVBhi5hfW
	fCI++U0m7sj+41oBpNl9nCKxjJ1KIiw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-QG1G8UaZNzG1ZbYsJx-Nhg-1; Thu, 21 Nov 2024 21:17:23 -0500
X-MC-Unique: QG1G8UaZNzG1ZbYsJx-Nhg-1
X-Mimecast-MFC-AGG-ID: QG1G8UaZNzG1ZbYsJx-Nhg
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53da23476bdso1051074e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241842; x=1732846642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0rwZntxeuzz614rWcmK6DkyUn4Us9C9cxRvDMcMi3g=;
        b=NOnFyzCxoqikLbW2WpOc0qo1O1ZEXQulH0ujXgfTPtusVUPV4dfY5dGPckKdGF/3V/
         LFAeOBaae6eCskV1HTCEQk4QAE4CgwYR/ToGAz2KydZ2rQiA8+0Y9kMgVbRscBE1+gR1
         3ZnEfv+MIwNhEWQh/QW5osX2/UqjgNJEFptPyuKkLEKwDGjkhVeynl7rNiZrfEeGMJiU
         LYzLuuuLOnwqs9QSgYsLdcqom3ox3yQzqpt22N+P9+mrn68wf/O5lWZhjh5VIHUbtWYA
         +D7rMN2SsiD3jZdUxloZoweGaXCyqkknOYtc0RGicKw43NQX3GRjmd6D2qQF8fln/TAl
         DryA==
X-Forwarded-Encrypted: i=1; AJvYcCUtq5T/ZaePZxDnPZcy5JtqB+LrP8yVKrnKR29mLFEAUUvLlXODh5ExpJScY3kn40GrCew2FuKh334ohXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBMGiq7kcJdEyT/pMblRAdaLyPQfzmiIs6RedikmoSv1ZwbBA
	eKpFC9tawD33VSgc6ND5D5WXLmDeH8LP7zr4eCPPfFiXK1OTLVcgHl0KVVcvYQsskhB7d4tVwwG
	7kmqMHzE9Xd2J2bwV7WqexCenSeQLFiZ+A0/0YWmDJ3NIUgqvoAV+uPWoN9+BkLQ8eSP0FFi5qw
	IrjBgf4mhEUFLmqzi2+4oiVxJdxYAD7mYdAV+5
X-Gm-Gg: ASbGncvH9uAsc4lDbWE7Eu0XIN5WKPWrTSli/IHuW4POMKvm3O3ZQR+7HuFZFdSYEG8
	5wUZhhtlaJxJfhHWjEcA4CAR/8hECaoVM
X-Received: by 2002:a19:9113:0:b0:53d:d3bc:cc51 with SMTP id 2adb3069b0e04-53dd3bcccacmr311780e87.22.1732241842108;
        Thu, 21 Nov 2024 18:17:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3Q50NDgLKcxJmMeMeWWAsHe42EEfyEry/LoPGuklqIv6QJ8+gzd3lEsiWkeRlj17YVWtfXgTGCmTebqQ7cp8=
X-Received: by 2002:a19:9113:0:b0:53d:d3bc:cc51 with SMTP id
 2adb3069b0e04-53dd3bcccacmr311770e87.22.1732241841784; Thu, 21 Nov 2024
 18:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118114157.355749-1-yukuai1@huaweicloud.com> <20241118114157.355749-4-yukuai1@huaweicloud.com>
In-Reply-To: <20241118114157.355749-4-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Fri, 22 Nov 2024 10:17:09 +0800
Message-ID: <CALTww2_VzpF79ZEvKvAKf7itpuveNM2caqtGzeO+7_YivMe0Gg@mail.gmail.com>
Subject: Re: [PATCH md-6.13 3/5] md: add a new callback pers->bitmap_sector()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 7:44=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> This callback will be used in raid5 to convert io ranges from array to
> bitmap.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 4ba93af36126..de6dadb9a40b 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -746,6 +746,9 @@ struct md_personality
>         void *(*takeover) (struct mddev *mddev);
>         /* Changes the consistency policy of an active array. */
>         int (*change_consistency_policy)(struct mddev *mddev, const char =
*buf);
> +       /* convert io ranges from array to bitmap */
> +       void (*bitmap_sector)(struct mddev *mddev, sector_t *offset,
> +                             unsigned long *sectors);
>  };
>
>  struct md_sysfs_entry {
> --
> 2.39.2
>

Reviewed-by: Xiao Ni <xni@redhat.com>


