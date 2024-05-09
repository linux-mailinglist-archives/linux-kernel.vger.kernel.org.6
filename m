Return-Path: <linux-kernel+bounces-174459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3388C0F15
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B6C282106
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B487314B95A;
	Thu,  9 May 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/hTGNJv"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019414A90
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715255986; cv=none; b=rCKuIM4f0xrRxc2JaaPiedrc4FF52TToSUMxMokQgJ0xOEeNLXNw9s1t/KRuXqoHc+UKk055GFdRESaBu9Hc71UJQx/qzNNWs8w24bO6ReK7sCNRMfJ1MBquZJbeV0r4rCoH98yGeW8iL04XQ6BjfPl2quZQ40NeK/4dG5Nm5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715255986; c=relaxed/simple;
	bh=lYeXs/p71Ooa+HWncjH7t4POBonoP1OKJDDYzGkDBlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImUXXU48Q+oxTHfinkSlEPAzIIdZcuHrYoUxbN60Th03pIvgL6DZb35Wx3Ld63x6I62GUla45M+7eKSwCZO1nkzxbBWY8qcV6m5s6Kd2VSxR3r88Geyfy+ZRg/uTOvtf1WSJI7D95gNqcpkV4PCOfVI7Bfd9dHa5p8JS56OssT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/hTGNJv; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6a0e69caf90so1077756d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715255983; x=1715860783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYeXs/p71Ooa+HWncjH7t4POBonoP1OKJDDYzGkDBlo=;
        b=Y/hTGNJvEwtPJqGhIsTR0gX6SU6atngU9TSj+SeeNMcGNRLGZyQ4u/syaCrA3FVL8S
         /ZAJ7YsiKWEU1yoQBpNQ6T4ay04FcJEXFcybzfcTsMm2hCJPfhVx0FB2wQbjOXzguxnx
         aoV+OULAlFaQ4PV/4yJQqzpAmAIF1JLdY4IKMusMa1ot0bQ6zULsxAtgsE80NwPvlkJ/
         rTD8J2KnkkYQSvYS63TRypa4gT0I0rn49pyR8iC9cbbZWtpZ6Zia7gRyjmk/kEZVfcV1
         DLNwO7D/5y5Y7dslj//TFtiZUd2UiVULSpKTp3nVbsKXoasTlOsn4i5Lslwb7n7G2ZZh
         2MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715255983; x=1715860783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYeXs/p71Ooa+HWncjH7t4POBonoP1OKJDDYzGkDBlo=;
        b=VlCZ/k56q3164xUlf7IkB+QDefDC8sBQMuKlyBYHsCL3YWNtrzinCYH6h4qEeiEiiW
         NpOj8SLC2Qo7Mt5NHFO8W260TZegyMNhSY1rDs1cVSn/al2ABvMalJU3pa56bVuQoipN
         KycZRBdsnpLcGUe9cHA/yvUQuFUKz8O0+QIaC+TRTZ7Sfk2qndyOCBBL52mumySS/iQn
         Z3mxE1GEsZY9TTioC9z8jC+c8Jlz22eOkvJjgrf+PtRaipAZwgG1bDUGIs1yBV6+Z3+a
         2s9JXltQBWYPOJaet7PlMYrnBHoWcDq8dQdSqaf63BKc+uJOhKqbW0+SCyoS76J35jL4
         ELyQ==
X-Gm-Message-State: AOJu0YxBgvw5XRlA7TtxuUZlJ+9gIR/9EtBiLEhIyYP49HWrweRVkX77
	811J7nv1lWPJKnGD/TCw+qJyJBkoQQfuj4266mEPKJ3ecHW9bHs6wtUoivVoAoYbhbq/eAqa8Vs
	ARTNskDtwBWHjVe0Rt8TrwwPuOoGut/t0PpFHPLt2
X-Google-Smtp-Source: AGHT+IES/nnSEmMxi/+v1o8+8MwujeaTbAGsycbSSBUrukrvLxCCkxgHNlojWIOUwNe1CEXUus8ZuUUuprvy1G39u9A=
X-Received: by 2002:a05:6214:3005:b0:6a0:e713:2121 with SMTP id
 6a1803df08f44-6a151384c17mr62184766d6.0.1715255983399; Thu, 09 May 2024
 04:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com>
 <CABXGCsOC2Ji7y5Qfsa33QXQ37T3vzdNPsivGoMHcVnCGFi5vKg@mail.gmail.com> <0672f0b7-36f5-4322-80e6-2da0f24c101b@redhat.com>
In-Reply-To: <0672f0b7-36f5-4322-80e6-2da0f24c101b@redhat.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 9 May 2024 16:59:30 +0500
Message-ID: <CABXGCsN7LBynNk_XzaFm2eVkryVQ26BSzFkrxC2Zb5GEwTvc1g@mail.gmail.com>
Subject: Re: 6.9/BUG: Bad page state in process kswapd0 pfn:d6e840
To: David Hildenbrand <david@redhat.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:45=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> "page dumped because: non-NULL mapping"
>
> Is the relevant bit. We are freeing a page, but page->mapping is not
> NULL. IIUC, it might happen under memory pressure when reclaiming memory.
>
> It's weird that only you are seeing that, if it would be something
> "obvious" I would expect multiple reports :/
>

Maybe because the problem is really difficult to reproduce (rare
combination of the kernel build option and workload). I even thought
that the problem was fixed because it did not reproduce itself for a
week.

But yesterday when it happened again with the kworker process, I
stopped doubting that it was fixed.

Now I am concerned with the question of how to be as useful as
possible when reproducing bug again?

--=20
Best Regards,
Mike Gavrilov.

