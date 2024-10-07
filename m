Return-Path: <linux-kernel+bounces-353843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB74C99338F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FF11C229E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E01DC07F;
	Mon,  7 Oct 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ieegq+Xp"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C131DC068
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319018; cv=none; b=GhK/XMmXxLgAWlb4JXIL14wdUxK79/09yHQXOgTpOYlHoB84lgQCjW6yiECRyL5V4UNhJf/gW1jVYcybSIVuNK4sJni6xcWOMXAW1rptXmMUUic3A720iVBnKYB8QwVzL7hN9VGlm6GOftpKrOms4bUByAiYUmLZXZx4NtJBtfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319018; c=relaxed/simple;
	bh=pfTZwskcRDO6J/EbWenc5MF6EkG6LlfKiG02QhaJm0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGI2ZCjdi+TEoBHRHQcBnCii4A7eQWf+XLOAdUh8aN2jO5UWz7fHfjVxfAa3Bj/BhWgqnbmYBUlOnJJaS78H/9RQz4iT9ksmdO3YO5zQui1+wuUqge+KFvZ2+5CJtRpbOP42fsSRh8HmwsPDioWAHZnZC7n3phOiF6KvluNuPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ieegq+Xp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb1dd2886so1575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728319015; x=1728923815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfTZwskcRDO6J/EbWenc5MF6EkG6LlfKiG02QhaJm0M=;
        b=ieegq+XpMZNkcSAOo38Xj3vMyFIxnJPrxghOJABc+Yzxz8SwoIRVk+zXH9lWisb9jq
         +KbI1VvmnXMjQs2XMtGU1YyyXpm+cIowPcl0WUfoEMz1xW1fQRhbLIeGiLjIzAZ/tgQH
         o6Btv9cTxiMVUVb3M9endEA749ndxaqYNkquPGVaczPYw2V2svWj3yW2Q7nuIKM+6kV2
         LBlmLesjFLTL2aY18B/+ydugG+znzn7n9h8DZs5uBNK94/AJiizLOV7M9jHS68p+NtjJ
         6upL5KGgSDu3a0h2ztwU1OPQyDZKyIXUxarGty0NV10/5petLTfEYLRMDfBJbohH0HUe
         kivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319015; x=1728923815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfTZwskcRDO6J/EbWenc5MF6EkG6LlfKiG02QhaJm0M=;
        b=pK67+ewE6RcK/WwFV9AYAy24A7CYc+FShRLZlCBB5n3y1pCQgh6S3x7P01/UIuF9mU
         ysvDJ4JSx/jEJycwukCA/jD4iIyaal9Xlithjugp1db/BoWdHO3ldRkdwUMmDuNCcPZ1
         lK2zwqNe41YqIw5w+ZpWR5XBseeloGeXIEznNSI2L+pMrRJrt0I4jQmxCNq5h9JbL2Ar
         w/Jn2OhALc6XupWlT4H9qYqv3nd1TMUyBZJ9/Dzy2YuMMekU1ZDenJcD1sqkL7k5yXCe
         rAmugY45SaJFmnrEBiJ9RCjonrJ2spFJgRv33sJyPgg2fEa+RepQvqYeVFuWWQgfrXKo
         ERdg==
X-Forwarded-Encrypted: i=1; AJvYcCU1oRp3IxT5zCMHnKRTsX6UegfsayTEE6Wqovsq9Ws2JvTXeS/Jm5EIgJLs3htqvo8UQQvj9+hH8+JcDKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfpEuLwp0VVl0cee5/+UmWY4+Xf5EjlL4TZktpzHI97A9EYdco
	uvoc3ihlpJRFLJ6HDLyWV7VmRSMtvISyqu69nAFdZqWuYClrlUqacp9MscW9sL8u8lscUHVH0vi
	JK+1Xu0ugRLv+aSdto+F+x1giUuQcWMAhj0Bb
X-Google-Smtp-Source: AGHT+IH34cxrwgzamDDHn8fVay3ejEi2/D2Db94dqzGJ9HPOBNHO5mDXamAvocyHnv6A3u/XE3ClTvdIor2h2iZ9fS4=
X-Received: by 2002:a05:600c:34ce:b0:42b:a8fc:3937 with SMTP id
 5b1f17b1804b1-42f8ac7614cmr4992935e9.4.1728319014948; Mon, 07 Oct 2024
 09:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com>
 <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
 <CAE2F3rARZ_qq7MYnAT7nNKcNsL3DzaTH+ehPTNrwaaP20d9Cag@mail.gmail.com> <faf12f39-0048-4e47-b600-e686cf82afe1@os.amperecomputing.com>
In-Reply-To: <faf12f39-0048-4e47-b600-e686cf82afe1@os.amperecomputing.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 7 Oct 2024 09:36:41 -0700
Message-ID: <CAE2F3rBBx_bMgVi5R1G7d-B+c3UdXiUB4sEL6KnsNc4gWJHroQ@mail.gmail.com>
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Yang Shi <yang@os.amperecomputing.com>
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, james.morse@arm.com, will@kernel.org, 
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 6:53=E2=80=AFPM Yang Shi <yang@os.amperecomputing.co=
m> wrote:
> >>> On a related note, in arm_smmu_init_strtab_2lvl() we're capping the
> >>> number of l1 entries at STRTAB_MAX_L1_ENTRIES for 2 level stream
> >>> tables. I'm thinking it would make sense to limit the size of linear
> >>> stream tables for the same reasons.
> >> Yes, this also works. But I don't know what value should be used. Jaso=
n
> >> actually suggested (size > SIZE_512M) in v2 review, but I thought the
> >> value is a magic number. Why 512M? Just because it is too large for
> >> allocation. So I picked up SIZE_MAX, just because it is the largest si=
ze
> >> supported by size_t type.
> > I think it should be capped to STRTAB_MAX_L1_ENTRIES
>
> I'm not expert on SMMU. Does the linear stream table have the same cap
> as 2-level stream table? Is this defined by the hardware spec? If it is
> not, why should we pick this value?

No. I don't think it's defined by the architecture specification. I
don't have a strong opinion on the particular value for the size limit
of linear Stream tables. However, I do believe that we should pick a
size limit. Today, the driver limits the number of Level-1 Stream
Table Descriptors in a 2-level Stream table. For consistency, we
should limit the size of linear Stream tables, too.

