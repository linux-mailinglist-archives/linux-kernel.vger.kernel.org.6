Return-Path: <linux-kernel+bounces-198584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416A78D7AAC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923172818E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 04:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB25511CA0;
	Mon,  3 Jun 2024 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBqlZYdv"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB433207
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717388022; cv=none; b=VPiiM6LW1JoFeQQCnDkpIj1M1E16ZnHmkt9VM4NUNx4WfFvY7JISSGt3PP/ewtVaf9kQCC3Ne/KqeVUWmux1apPc0t+Cl1YScxt9TSM6qTc9GR9yDydqAH2+hufCdJNY1LZVf7j/lZUEGug5LwCuM4okGGfCeiz3Eq4WdMs/LEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717388022; c=relaxed/simple;
	bh=EkHs/xlMZ9+BczHxQc7C8lPeu6noPOuM5eLKCWkHSbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyZCxYXCHqDuHlfCEEjSgjVnpuDM3SExejwCaa1/1iM39lftDlwb/LGT0+thlpzdagdyYIu2bN1rDunu+FKhlKeXZx/zjCNCgOu5iPa7f73qXo/XmOzdBWefix6za+lbXVyV9rjb4W37J+/Wti5vlJphPcocPW2hIQToFnh9/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBqlZYdv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a196134d1so4343396a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 21:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717388019; x=1717992819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt8Odb6me4R55P6VeYtTBeVHg7iXP8uegA/SSq4GxdQ=;
        b=EBqlZYdvulskiTmaPWdZ4A5BBpdtFlxN+I1JlaCOOqJjQ5TdU/eaPnLplb9ZVUqhJp
         9c70U2yx2I4myl6BZBn1fYdBmdMgRhSbEdZK4zPowWa/UV6hqCk02Mv68Jc2p2NKjCYc
         6dUWc8IW4tuhXvYyR8X20ML03GcN1D/BMxp16m8R6zV8ZUtyG+mpvpY3xFwKUJTjvPT4
         EXk+2uRB8ySNjEEJLjxHJ5YA283bZG78DsPh9iDFoI9SbTiDgVM5zDlU36JjkU7Xcb1S
         ZW7GBlBymMEwxIHtnTN7pqiimJ2g0OL9ifplygptB2PHg1CGCahaTg+/DpUl3ZVWtO2R
         7iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717388019; x=1717992819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt8Odb6me4R55P6VeYtTBeVHg7iXP8uegA/SSq4GxdQ=;
        b=dWoIfjWBq9WJ35HrADJbSWqrYoucj7bCDSnSqi1pRpESVuKoQe6byUmN9bsuNzkubx
         npZDazBNyXl/xxwkHhi4b8muIx4d9fKz/WBk3F3TMgsayXfXeDouC+VkMo3lUSTASxRs
         AGFrLczyllVGv7YMpDg2d9cMe8dy4a4UL/2aH28rCw/CPOwEIIO3ZmK5YudGb8OhzSSH
         P5rZ6EFlrITlBmAMqBLxHIuZg+2a++YcyuUzlyDctGvMmsw6CoERpHRtDMhojuiQSlwP
         3o9mNIQ/UmRSPETYbZwpZr6M7calBVq1nHcCNRxJkOxG7RJWhMVkEexxE+kL7b6gt8y9
         TPAg==
X-Forwarded-Encrypted: i=1; AJvYcCXxYdMMM04dpibWWHj3kBDVrHg8NQG2oKDF64xv7bgCdmU4Ksu2EfNX0O+MPV+a2iNeEecf/qZPlYM/v9DOn07iLGaXSZmtt03TkbgR
X-Gm-Message-State: AOJu0Yw8KDevd5GRmMjkrRipOR2oPP+7VmhTCShPVk8JydaFQ0+0Mrf4
	jzUQqXhS89rOrAlS3hwWzAFIEcrRiJ1VEQM1dUanQ4zryRczZ8G99rN2KOzoRBwi/JJCH6E2XE5
	s3Yr+0eKcaQoMdizWfKxxCIEQESc=
X-Google-Smtp-Source: AGHT+IFd6l2c9d+DpNztjTndInDEB1u7H8aOTZjOvmeCo+DlXf4m+/VOnurKSYnOlEhIQcKRBkiGOcc6WmpRZ5CRQHU=
X-Received: by 2002:a50:9ee1:0:b0:578:36a2:7073 with SMTP id
 4fb4d7f45d1cf-57a36450a36mr5597011a12.29.1717388018600; Sun, 02 Jun 2024
 21:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603033118.76457-1-ioworker0@gmail.com> <Zl06P-qdpca2V9aJ@casper.infradead.org>
In-Reply-To: <Zl06P-qdpca2V9aJ@casper.infradead.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 3 Jun 2024 12:13:25 +0800
Message-ID: <CAK1f24mj_LFEU8mP=vGhJMWLAq1JANWqtipPwMLvYh6nrp65Dg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/mlock: implement folio_mlock_step() using folio_pte_batch()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com, 
	21cnbao@gmail.com, baolin.wang@linux.alibaba.com, ziy@nvidia.com, 
	fengwei.yin@intel.com, ying.huang@intel.com, libang.li@antgroup.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

Thanks for taking time to review!

On Mon, Jun 3, 2024 at 11:36=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Jun 03, 2024 at 11:31:17AM +0800, Lance Yang wrote:
> >  {
> > -     unsigned int count, i, nr =3D folio_nr_pages(folio);
> > -     unsigned long pfn =3D folio_pfn(folio);
> > -     pte_t ptent =3D ptep_get(pte);
>
> Please don't move type declarations later in the function.  Just because
> you can doesn't mean you should.

Thanks for pointing this out, I'll adjust as you suggested.

>
> > -     if (!folio_test_large(folio))
> > +     if (likely(!folio_test_large(folio)))
> >               return 1;
>
> How likely is this now?  How likely will it be in two years time?
> Does this actually make any difference in either code generation or
> performance?

IMO, this hint could impact code generation and performance :)
But it seems that 'likely' is not necessary here. I'll remove it.

Thanks again for your time!
Lance

>

