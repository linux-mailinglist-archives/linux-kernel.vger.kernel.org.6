Return-Path: <linux-kernel+bounces-348070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533BC98E225
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1250E2851E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE851DB940;
	Wed,  2 Oct 2024 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfekv5lH"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7A1DB928
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892929; cv=none; b=fakGw6B7aEUsKqRlaLVMq7EY7jYc0szKPjW3qGgvnvHABeMiZ4r9Cr2kuptKtYL2R0ZsxNEq86UctxMrIYbFoP6UKJOpju2znhRCMMu4Je4btKsT8wnO6SO53lE6D2FzPULtXHLcBm0MPKlwbq92ikgi1GrsnQPyaDy6QtL0+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892929; c=relaxed/simple;
	bh=E6hc5ehmGnJHi6WTCaTLY3GV8rjrbjxzjFkDct9BFUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8fi8J9L8xSN26tGd0lLiuXaEulWJF0DuupSLtw/bxPF8XNPVVkYPq4F7UZc0sDZhvThzNX2FPfcg4GAY0Jpb5g+a2+A6Sgcm+w4aYXCB8NekH3bkR0YLn35jMBFNo6oVvBsELu2dl8fCIlOB7kr+zpOX4rI/4ZYPH2YK2HWShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfekv5lH; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45cac3368f0so282361cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727892927; x=1728497727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0fyARs/4Kq4tRLYk98LzCB/bx2clpzerKhb/tultS4=;
        b=nfekv5lH9fdjsvpLiOauFLseFNFruz/FO/LfDTLqc/8sd7a4poZgjogYT+cSSdjvkn
         YXP1i5RAT+XtyctuiEfMUQe2Inpnfav7ofeq3LlC1Ji7OaY6XrRatv0k2C+KXWuM5N5N
         79HqXrs8BTnwj+2wL16AZgVKh2MGXYQCrBLJcicMGLfD1a3bVyFkStlM0QIVjScwbhLU
         0NJJKHjnxpbLIfP5ctiSurQyWSFDcCu6fSXyuhoq013rtp/Y4VWfxKwQRp2kYgdj/OiI
         OtYTGSSAqntr+Tk6qqedq/1Dg6uG9Y31fBGpQ8ej5s5kJ9c0vJuTVxfjfMru7VMC2PsS
         1OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892927; x=1728497727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0fyARs/4Kq4tRLYk98LzCB/bx2clpzerKhb/tultS4=;
        b=YY8CoYw93Hl7DiUA8UDaG6HUfTC2zc2BBb7I+WDSoeAb6AzD0zBkCkXBib2cSszjtp
         y4tb4TkJ/rbK9H3Pm+nhvKYOXGa2sih9lyqxeyxayOwy3oQgVhVETEtROpKBj4u3Yz5m
         E+9AKF2EhrpC6XLWm6GxR+kMKFWW0Pd7J0nGL81ysvt5t15q39cubizh+NRTuldhpCGf
         HorBF0/NsiCvrKkl0FgJZkks31Q6pFgN5o+Shb1wBYZ7R9NnZp/KBhf+Dh60hbyC5i6/
         zrbkdO64F5sZxqAkAkxdgcGeMNuJVgG+/ZsJqoZg7WDhiXJCCjePAAdncK3HZ2BGvWNI
         0rEw==
X-Gm-Message-State: AOJu0Yw897M+aNCEz3v8rK634WvnOW/p5xoTkytdN3/iJoDaLNre9AuY
	/SCnCzcjOpOx/6KqZJp63vV++KwYdBHe6gHWnIio7+bjBIkhqpxtgi68Yq4F8dmlesUeE20/mbt
	5bGYVxhOXYMGUJ1e4oW0LvvHLyYY=
X-Google-Smtp-Source: AGHT+IFSX+G1CPSRU6CfM5KimHuX/c/E8fWB7jVm7GcCkakHWyYzWlcCWDBrGbsmuwMtIh8Oj3bfxMXIvLPmO62wJqw=
X-Received: by 2002:a05:6214:2f13:b0:6c7:c283:7ce with SMTP id
 6a1803df08f44-6cb819b2cf5mr60800656d6.3.1727892926522; Wed, 02 Oct 2024
 11:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002173208.213631-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241002173208.213631-1-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 2 Oct 2024 11:15:15 -0700
Message-ID: <CAKEwX=PksK6rHbCW_Sx=5fa+=qgUYu8JTWrAy-XGq3phuReVqg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: zswap: Delete comments for "value" member of
 'struct zswap_entry'.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:32=E2=80=AFAM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Made a minor edit in the comments for 'struct zswap_entry' to delete
> the description of the 'value' member that was deleted in commit
> 20a5532ffa53d6ecf41ded920a7b0ff9c65a7dcf ("mm: remove code to handle
> same filled pages").

Is it worth adding a Fixes tag for this? FWIW, it's really just a
documentation correction, not an actual bug fix. But it's a "fix"
nevertheless...

>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/zswap.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 09aaf70f95c6..c3e257904b36 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -190,7 +190,6 @@ static struct shrinker *zswap_shrinker;
>   *              section for context.
>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
> - * value - value of the same-value filled pages which have same content
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
>   */

Thanks Kanchana!
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

