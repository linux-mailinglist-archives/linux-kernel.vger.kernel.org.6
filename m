Return-Path: <linux-kernel+bounces-414568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ECB9D2A16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0A92829FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7731BCA0A;
	Tue, 19 Nov 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WH+GvrE2"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACBC1BDCF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031258; cv=none; b=mEVnvPCdLBOrpGQzJangI2KxP1H9alzSFgtaVXTdrER5K/s/YSVlhkIKYwkJaM0yTHPqNImWtmOYXuGvRmj8PTpaXqAfSmhhty625UY7V/yUY8YfNbUE6+mCJHabqD6JpE4tTzxJobHvMGzTF+eRhDBd1Lnh/40YvBDd5hSNFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031258; c=relaxed/simple;
	bh=i0rjD0JCBg2/0zk+DR3DU326HYcGm8Z8xgFiWJSGXFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q65uioRAcwIolPTK6/Mfw1snjBVlSLAowC29S8cBgrVKKBQKc/8HuimerU2pkqeHF7iRh9Eyo53y9+vk2RcBq82C9uMQub4xvktNunlnvo9XTWRQZGL3mGhPKeJOpYTC5p6ltxlwu8U7YHVfo9VfWY7evrUKYG0NLTHA/qAhMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WH+GvrE2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so11803a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732031255; x=1732636055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0rjD0JCBg2/0zk+DR3DU326HYcGm8Z8xgFiWJSGXFI=;
        b=WH+GvrE25gSo2Qs06+JuC8ujBwBNiAhwXZPOaXEFwnOYZWEMNHSEtkOzUfqVUsXNYi
         XglGlUbSuMcTnbRKDuJ6MQ31VJlllk1IElTfw0HY2o45zMGtOXEGVIIEo4jUVuJeYKAE
         qCUArOrhaQlQZhqw+WWLBaWEVn5BK3CO976Gm0rKgbpqxXW6ypGPhg44YyjgRWg9Pn1b
         B5VxrOvGYsfA+B5Y94L9OqGZtcSBvKp0Wrq1qdusS3SAzLWksWWHxvpvVjOvIqpjipqc
         oOmojGw5Agfe6YOvx6GXfPYMXyz9uLNa4w6bXmkOPQ0RxHZQpWYiBRpjCTr4XLKj0qEo
         /4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732031255; x=1732636055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0rjD0JCBg2/0zk+DR3DU326HYcGm8Z8xgFiWJSGXFI=;
        b=CHbrQxSQXW+G0HXyRLnw/9KUjppPhkCE6bIjBMeQZVqmpa5/5TbDPdlzqvWEzmrj+I
         cubmw3N+HCOhxYW3GRm1zIk3HjBDvYWFXjZDfSbE1qD/0jYxGS2hcqN7fV2Pn6N/TvlN
         KJ4KsempJULe8NqBbFcePaCqgIVVnObCjIqM05CFeRIQkRMWKG2kzGs3ijAHmHnHvs1z
         pd7Fs8vdnWvD2v5GGSHcS7CN3s0cB95lK4wxn8G+p9dojqbYlYpPg2ywE9rY2UOASAzV
         mVezLKvtEB1h/dJSlsBs096DekVlcj0koaNSL4J4e/BWuA/tywocDwsZlSBCEw8knMzp
         JeJA==
X-Forwarded-Encrypted: i=1; AJvYcCXmo3LF0Y/NuqtEEODwT4unAE0waFyh0zEykUEyWGo3iPDXmmJCJ/BJYJzZM2WYHOSHbjrS1SYIK9BiK0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xKzNLo9cTFiYB/Dg8EfBAHjDHeRWOfj91d4CNZ6Ylq2vVxOs
	6LmxYdUooSv5yE3E9FN1LiwC06TjURaBUqqGAfC8GyuAQEOS0NzKQueXizbLR45jK+gYreki3j3
	uQXi56SKPYKNOIgFwpx/ipJhrONYJKes5vicw
X-Gm-Gg: ASbGncuPxWSGvsOlSG9TcMeHj6reCnlPtq8WDYhUN42ox5i4iMcxJTFIoKrUV/mNQDZ
	mlZF64Cy9ZAmnMtnU6uIIJnYUiC5Oux0RtmqWOKdIBHbqoVIIK0ZBpuvAYIE=
X-Google-Smtp-Source: AGHT+IGkrk6XN0M17z4ufCr814Yn19SrMz2YIkhsZxhE4LIRO4vCs0Ui1plfIkV9z9o9Ahnh3t2phcBd7iF7Lrh5L30=
X-Received: by 2002:aa7:c387:0:b0:5cf:c23c:2bee with SMTP id
 4fb4d7f45d1cf-5cfdeb76bebmr83040a12.0.1732031254810; Tue, 19 Nov 2024
 07:47:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119090740.65768-1-zhengqi.arch@bytedance.com>
In-Reply-To: <20241119090740.65768-1-zhengqi.arch@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 Nov 2024 16:46:58 +0100
Message-ID: <CAG48ez3bKSbDMmz7gpBm9x86PDuvpKPOGaTg0C33qtmetM44Tg@mail.gmail.com>
Subject: Re: [PATCH] mm: pgtable: make ptep_clear() non-atomic
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: pasha.tatashin@soleen.com, tongtiangen@huawei.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, ryan.roberts@arm.com, 
	peterx@redhat.com, jgg@ziepe.ca, muchun.song@linux.dev, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 10:10=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.c=
om> wrote:
> In the generic ptep_get_and_clear() implementation, it is just a simple
> combination of ptep_get() and pte_clear(). But for some architectures
> (such as x86 and arm64, etc), the hardware will modify the A/D bits of th=
e
> page table entry, so the ptep_get_and_clear() needs to be overwritten
> and implemented as an atomic operation to avoid contention, which has a
> performance cost.
>
> The commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
> check") adds the ptep_clear() on the x86, and makes it call
> ptep_get_and_clear() when CONFIG_PAGE_TABLE_CHECK is enabled. The page
> table check feature does not actually care about the A/D bits, so only
> ptep_get() + pte_clear() should be called. But considering that the page
> table check is a debug option, this should not have much of an impact.
>
> But then the commit de8c8e52836d ("mm: page_table_check: add hooks to
> public helpers") changed ptep_clear() to unconditionally call
> ptep_get_and_clear(), so that the CONFIG_PAGE_TABLE_CHECK check can be
> put into the page table check stubs (in include/linux/page_table_check.h)=
.
> This also cause performance loss to the kernel without
> CONFIG_PAGE_TABLE_CHECK enabled, which doesn't make sense.
>
> Currently ptep_clear() is only used in debug code and in khugepaged
> collapse paths, which are fairly expensive. So the cost of an extra atomi=
c
> RMW operation does not matter. But this may be used for other paths in th=
e
> future. After all, for the present pte entry, we need to call ptep_clear(=
)
> instead of pte_clear() to ensure that PAGE_TABLE_CHECK works properly.
>
> So to be more precise, just calling ptep_get() and pte_clear() in the
> ptep_clear().
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Yeah, as you mentioned on the other thread, this seems like a
reasonable cleanup.

Reviewed-by: Jann Horn <jannh@google.com>

