Return-Path: <linux-kernel+bounces-243824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E498929B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B9DB20DF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF896AAD;
	Mon,  8 Jul 2024 03:34:55 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F065524F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720409695; cv=none; b=JX8XuW2EqqaTlL4PErKtIm011/U2nKHe/vEX4U9m7WMvI/oI9qnFAHkqJUCv9JFPefx+j54gIl3yNVg9oTY9fMIIrGXvpqUHZI8YPbifrq3CHv+x7yTpBkTV1upX0qM6rmWfRm5raAguCKgzryfhYAo9DJTmiWBkcnkLYmDScuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720409695; c=relaxed/simple;
	bh=aVvVAZHfMPs5nnHWHogmHnnS9D5OpFlhy6ITeRI5Ay8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLx2CG2cwn/MtKtXGW9fcTPrqs/K/HOduiqMC5OmRRkjhcEF43dk3cf1oTdqXlKsLJb/WpfeJpTCsNYVr3927EAmQHJXASc4coKde43fEHmrlKI7XlaLaVPznl7L/zuq4HMHsDxUFvqgNenGl11oZAoFKQUg4vfcIY091C1DSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f2da6cbe7bso1101015e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 20:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720409692; x=1721014492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyP6zWGAlhMRhhDdz/9ZBr/3OTIfug8ZLmO58gCs+bM=;
        b=IXuRzeTGSNCnn5J75P6t9AxtRUELz3BxKswNFS+0701+FFsBTZACoVBAjwK3/LBq83
         BU4HDxbnd/MJz8UGaT3YWB+YmSJYGrD/DScA5Aml+1S1BKZH91lLzhgwi0PuDhveur+i
         VPChG/pu+e0pbNmx27ojuOfEwehLBEqA57xAA/iY98ylQWmeDD1MeVSgkbZ9+Xa3e2h8
         86M0n5QxNLIbazTLLYZ2M0z2coSTNPUg2suDRM4dzbXPwGcUoBwVcrsyDKfRjhK/SUp+
         6gw2KhsEdWrw5DDtNNbJc7tCTOxlUHiAD4J505/9CT8VN+XDVJh72yEMNuUEWbemSrxl
         JHIA==
X-Forwarded-Encrypted: i=1; AJvYcCWuYVW1bzznLVQLa4MovPRUk9v2kYX9r6ls/luP+rd/Lmy76nXAYJQCicra02P42nWmr2EBYhrUlm0rVfadgRRzcjh/R9Po6VzNTBND
X-Gm-Message-State: AOJu0YxJqang/YoqjcZo5nPrczjhEEPb0+jDXQtFe+qZ7/SOPisZjazT
	RPtk5oebCBglALPuKNgnts0dxw9+PSiTLSJjIYwW3xqYztQs66aTF1YmrWL0LjWoYccQ3aZ+M5m
	y4hq7oiCGt2HIr5O8NEeDQ7EYs16qyV3c
X-Google-Smtp-Source: AGHT+IFVCgz71rfe8Ch/RP4ej++XQHhEFyHot5v92twgQ2zw3Q42TOY5Hi+F+TgpMh59WSyKAJxb8iyELXEx0uHvubM=
X-Received: by 2002:a05:6122:6607:b0:4f2:ea44:fd36 with SMTP id
 71dfb90a1353d-4f2f3ae4a3emr11137205e0c.0.1720409691986; Sun, 07 Jul 2024
 20:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708031517.856-1-justinjiang@vivo.com>
In-Reply-To: <20240708031517.856-1-justinjiang@vivo.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 8 Jul 2024 15:34:40 +1200
Message-ID: <CAGsJ_4xyHZGN=bm0Ozgk+swzkPQcgUzVPOa+3V+iNvcMGF_tww@mail.gmail.com>
Subject: Re: [PATCH v4] mm: shrink skip folio mapped by an exiting task
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com, 
	Qianfeng Rong <rongqianfeng@vivo.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:15=E2=80=AFPM Zhiguo Jiang <justinjiang@vivo.com> =
wrote:
>
> If an anon folio reclaimed by shrink_inactive_list is mapped by an
> exiting task, this anon folio will be firstly swaped-out into
> swapspace in shrink flow and then this swap folio is freed in task
> exit flow. But if this folio mapped by an exiting task can skip
> shrink and be freed directly in task exiting flow, which will save
> swap-out time and alleviate the load of the tasks exiting process.
> The file folio is also similar.
>
> And when system is low memory, it more likely to occur, because more
> backend applidatuions will be killed.
>
> This patch can alleviate the cpu load of the tasks exiting process.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.corp-partner.google.com>
> ---
>
> Change log:
> v3->v4:
> 1.Modify that the unshared folios mapped only in exiting task are skip.
> v2->v3:
> Nothing.
> v1->v2:
> 1.The VM_EXITING added in v1 patch is removed, because it will fail
> to compile in 32-bit system.
>
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
>  mm/rmap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  mode change 100644 =3D> 100755 mm/rmap.c
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 26806b49a86f..16b7ed04bcbe
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -843,6 +843,16 @@ static bool folio_referenced_one(struct folio *folio=
,
>         int referenced =3D 0;
>         unsigned long start =3D address, ptes =3D 0;
>
> +       /* Skip the unshared folios mapped only by the single
> +        * exiting process.
> +        */
> +       if ((!atomic_read(&vma->vm_mm->mm_users) ||
> +               test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
> +               !test_bit(VM_SHARED, &vma->vm_flags)) {

I don't think this is correct. folio_likely_mapped_shared() is almost "corr=
ect"
but not always.

> +               pra->referenced =3D -1;

Please explain why you set  pra->referenced =3D  -1. Please address all
comments before you send a new version.

> +               return false;
> +       }
> +
>         while (page_vma_mapped_walk(&pvmw)) {
>                 address =3D pvmw.address;
>
> --
> 2.39.0
>

Thanks
Barry

