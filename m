Return-Path: <linux-kernel+bounces-434445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327719E66EB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D44282956
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BD0198A0F;
	Fri,  6 Dec 2024 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1naA9C2"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6E196C6C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463275; cv=none; b=baQ465TsqqSB1pJstYZ45ermU20mP0ylWBJ8cda5yKDvTCD/8iP7KVrMYMBggN6KgMX4iK8qURVWqCxa/Ke5ZuyGUPkZwU8jdb6jsecDakMrVoewsW7fcC/DlaZ7Dl327uMvujUTJ3bhokaONKYKo1Es0KyDGpiKScIKphdbwGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463275; c=relaxed/simple;
	bh=16KGT4gLtqp9hrwwvR1/YXm4X39dxUtnEO49CGuLwJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FONl/bqoj/nGocAL2ZQ5DPyoZtK3IrtgD5OpHbUoxVYpMRigDfqpBDIYxYU2+/eSAMGjQbfS/k2IbRgiP58XyTF16EX7qZBhPp6X4c4A8R2ZEnYiG70pRu1PhG8lr9ruC3DxNJYC+/jSvbW7PxMU0KtTgFppeG15cDOaX91wQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1naA9C2; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85c436db302so195608241.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 21:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733463272; x=1734068072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16KGT4gLtqp9hrwwvR1/YXm4X39dxUtnEO49CGuLwJc=;
        b=S1naA9C2WAgRm169SwhmTtuata8ctBLQftn5LMI6/GjkdtUp2TLVcAHBBoeaCh/VMQ
         6eddvNXVWbIOBVhnczLdC0pSOXywXSSnotYu6jQ2ijI92Pxwqvl2ReI1OpsyOXo9JH7t
         qQcQzZo7t7UGRIb+azQWZCN3i/88vptYsbpMJDtoShl9Qha+PtwDo8FiY54TySH/aZla
         RUPRDrlSJYeddlLjyllr00HnAV/HsXzxN6M2fehbVqMR3OBYECe2vL3E069g/oPR5bkJ
         M2LCz66sgipGSkd5B7GDVoRBmbV3JW91uOBV0Quc3Da9FRpWSdA7+YvMp1krgHVbuY2/
         Y4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733463272; x=1734068072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16KGT4gLtqp9hrwwvR1/YXm4X39dxUtnEO49CGuLwJc=;
        b=QdOdXT99W5V7eHnLvyFj5d2tOtWVnVPTAoUG4OZBPd4XqM/OB7t8+8/cfwbscNV/Vn
         2OBlmzLnLOJHPz8R0fo1pckoyDmHYWWtAfvzF6srlTla4Jwr3ndFeXdz+PEII022cLg0
         KjSK5sgOMVSTdcSsc939HENC23hzmVSxNKKyIcs32HYkfeLnsJ6mBuvOv5+HBEKx3e4f
         oAcDHFz4v6rFhYX8Dw3t3P5FpefQ98f4tVXXfhqBEkPhhUpXvS8ra9Y6f2RKqtSPc6Vn
         W+3fOxTjxTEuZFsHwYTiZllSo/o2LseJvYaTrA9PERF/2sfodUge4dSkBhD3TNpfyQ89
         n00g==
X-Forwarded-Encrypted: i=1; AJvYcCXljsJtFU6iwVnTxEBruoeGqiPFEvw0Lu2/TgLRqvRfJkiwwekPeFRAFFaeqeNfSwngLI9Y+SZE9bZdn+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyknYNYaz6qNRZWzWYFCqZcfE8Rdv7JX2CNGwZZOHhP8V4Zy+Ky
	U33D4xQPJA4HORwiDMhOp3NA1336+K1zqW6CZCzpMsiKF7GfyB8gi9lZSzSwqzPt5HprAJoy4iZ
	Bmo/mprpA+fkFkdPmnoPWyHMlcNYIGZMKzoiX
X-Gm-Gg: ASbGnctvLgX977GvNarUhH7AIi//gSHjWzH0yBzXBPXuWHhIcC83fsoFiIx+1tU7YAf
	T+0jV2DGvk4o+PTk6hWYAjxLwnZHrf8LPcD4D2ld4sl7MORsrVblrX3p4DczhuiQ7
X-Google-Smtp-Source: AGHT+IEvLPcxcG6dZYsc3RKvBr2mvmoMEUY4/wcnwdmAjPDkJVyQm0dyThNYTYOoPk5dcYLaVciUxeWQ2PRBVfQ8Qbo=
X-Received: by 2002:a05:6102:5493:b0:4af:586c:6197 with SMTP id
 ada2fe7eead31-4afb9345c75mr7082003137.0.1733463272304; Thu, 05 Dec 2024
 21:34:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206013512.2883617-1-chenridong@huaweicloud.com> <20241206013512.2883617-4-chenridong@huaweicloud.com>
In-Reply-To: <20241206013512.2883617-4-chenridong@huaweicloud.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 5 Dec 2024 22:33:55 -0700
Message-ID: <CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKUBS4hn+kuQ@mail.gmail.com>
Subject: Re: [next -v1 3/5] memcg: simplify the mem_cgroup_update_lru_size function
To: Chen Ridong <chenridong@huaweicloud.com>, Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:45=E2=80=AFPM Chen Ridong <chenridong@huaweicloud.=
com> wrote:
>
> From: Chen Ridong <chenridong@huawei.com>
>
> In the `mem_cgroup_update_lru_size` function, the `lru_size` should be
> updated by adding `nr_pages` regardless of whether `nr_pages` is greater
> than 0 or less than 0. To simplify this function, add a check for
> `nr_pages` =3D=3D 0. When `nr_pages` is not equal to 0, perform the same
> actions.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

NAK.

The commit that added that clearly explains why it was done that way.

