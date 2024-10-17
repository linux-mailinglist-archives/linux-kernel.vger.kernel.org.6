Return-Path: <linux-kernel+bounces-370377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FAB9A2BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8BD286177
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B81DFE23;
	Thu, 17 Oct 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpfPEkOZ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE41DF99A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188460; cv=none; b=Mn9dyvGEfcQeBoWuoomWCLJT9tkw+Fact2D/cJIWvJw8WTYLpUCWsaEVSw26r7DMY/zs6LDgYcIFBL3SjZxMsPwzvZzRS7uShjqGLxFiPdBAqmIR+pCv+bOfGdpE91VY2IoRECpmkPqOQ2baROuN5yXOzzNdo+9fKdeKV6KxwH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188460; c=relaxed/simple;
	bh=9Y1kNcUptJVpxP5Vvc8RMsrJ7XBQGN2+RcG4aNctCI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhYbNiTwlMKP1YhtPDNXNje6diE8/0LVUA8Nbygj3o3ePNCO6zKAe0lEGq89c+3bLmc8KGCnL2oyiKsTUEgO5+D8N4HEkIzZ9D5GylACK4AOq7YJfC1YFXv5815j1RpIzdJw07gz5QyXXnYoA2SndO2rEZTOkSHfqg6NNcobgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpfPEkOZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e66ba398so3104e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729188453; x=1729793253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/AeYE5tUwlRFPS18JlXELiWLlelV6AZqqqhTAUHLiw=;
        b=FpfPEkOZYrzUYBmWqHlWyZFUye9RdHU40HDgRkdQnEDbD9rYBVKAH0NUgyYp/WaJd2
         EGmysL3QZr16m/jhaRT1ELTNIbe34jPKf3kq8A+IZ5gcAx6A5XAFjSvng1M6Bthf6l+D
         Op8JMqFx0n1VQdzGX09ePJMpk1RzxlMuce+pBj1CoWNlUg8JiDA+cKHwUfParbdp1AGB
         Y+kWH1MHhvz/ervvOA4azHwg1OVTzMrbCVr+YQG2TsNBKrBKlHijtKbk36NUlD2grdgZ
         vuDWVY85XndELjkQpuaOiCPpetxWk6yZuRuHFlM1h0b0vaWNbyH6PvreKer3ZRv/ekv5
         WM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188453; x=1729793253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/AeYE5tUwlRFPS18JlXELiWLlelV6AZqqqhTAUHLiw=;
        b=JzoNj7b0SPBFi3cJefmZZTz+AYrmjLpUhBdd9U0DPltcZuTWpLGKW0rhOYqzpkC0Ta
         M53oITAF0V4NiUscfQpNKhY9pQb/CC+xIDo3H55yxA6bB4sHWa3QquZtZxg5qZfGoa2b
         1ZE6jw0U/PkvR6q9LDSCSIH1U8HuAlv1ii9oWgQFbrON07wos1v653/F6gJPm/14cTuG
         cFPK1FwxCPUR9REr9vwbB0yoX8b7Ed7ByksJyQuXgJRpf1MbUHjtLFksB+/t2m3sKX41
         zVK3Cd8cVxGfGp+6brEWE6NCeVrF4W/2yALmXcOD5BhvqKoLVt2MLA/nr7HK4P/pdaIN
         UYkg==
X-Forwarded-Encrypted: i=1; AJvYcCXFe5srVsD0Sa39+CP0ERd6cTTTFkUJE7vXux4CWkMMVJFVX2e5t5uOzi9MtZ7s//qVNsd49w/r1nbMVko=@vger.kernel.org
X-Gm-Message-State: AOJu0YytqB1WZFmJasOeoPgLXYDHZLzjZyEr6PWpFLwDyidg428eS/p2
	FB32YxsIYuG6OYvPKKo+6xOExQ0ANoHrVGjUWUWpBTqzW0Bgd03fAoc4eKS26/TBOIj9ucSooEp
	XSW0gvr8wnxUPLHFtlNlmH2maSHkKTr0oShwj
X-Google-Smtp-Source: AGHT+IFJF3MOvQxmk700Ff5143ZixS+E6Lj6H0zZBG81tkCepaNoLsGPC7etwa0YVohmOPEH7ZSLTVkx1hmqfi9iEdY=
X-Received: by 2002:a05:6512:1307:b0:539:e436:f1d1 with SMTP id
 2adb3069b0e04-53a14e6caf0mr12729e87.1.1729188453051; Thu, 17 Oct 2024
 11:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729157502.git.zhengqi.arch@bytedance.com> <cd03a570f23e67016d23c3aa27f5931715570416.1729157502.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cd03a570f23e67016d23c3aa27f5931715570416.1729157502.git.zhengqi.arch@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 17 Oct 2024 20:06:57 +0200
Message-ID: <CAG48ez28bTO2KChkzktf5XJGDsC81mMhKaeny4vmoOMJ38wJ4A@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] mm: make zap_pte_range() handle full within-PMD range
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de, 
	muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org, 
	zokeefe@google.com, rientjes@google.com, peterx@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:48=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.c=
om> wrote:
> In preparation for reclaiming empty PTE pages, this commit first makes
> zap_pte_range() to handle the full within-PMD range, so that we can more
> easily detect and free PTE pages in this function in subsequent commits.

I think your patch causes some unintended difference in behavior:

> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/memory.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index caa6ed0a7fe5b..fd57c0f49fce2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1602,6 +1602,7 @@ static unsigned long zap_pte_range(struct mmu_gathe=
r *tlb,
>         swp_entry_t entry;
>         int nr;
>
> +retry:

This "retry" label is below the line "bool force_flush =3D false,
force_break =3D false;", so I think after force_break is set once and
you go through the retry path, every subsequent present PTE will again
bail out and retry. I think that doesn't lead to anything bad, but it
seems unintended.

