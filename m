Return-Path: <linux-kernel+bounces-386128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80019B3F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB121F22D02
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2812A47F53;
	Tue, 29 Oct 2024 01:03:41 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF741A84;
	Tue, 29 Oct 2024 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163820; cv=none; b=HZ/ztmPFeTqQp9451OTI+Krc/jH290btEDs5L1ES7VzmV/7MgD2EgGnvYwPG9hwiQt0Q/mdNq6NTdmvvMrqI29Xp8rOZisbRB9CylHzDbLRARC6R6hFalotqlt6TaDUUza09RNyy+yObWsLJCg5tiGi+aPRqeIdJWRV6llVBdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163820; c=relaxed/simple;
	bh=d3ltsdCA4t4CDIointrwlCkoJBWBK4yXTqEPTNkZcJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cADzcDhHzCmAxxg5qeaZbCI9w0N5hcqpu0B75T9XnT3P4zDtijST5ABcoYCZM7E515+uC+SYSxnBj0+BsTBWxeoj9g9ZHEXSV3avC7tJkXQ5ixnC6Fk8AnQnSqTUBDfbnqHX8/P1ratluIfqZ389C9Qu1LcYjImSaMsnfdD1tLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d34db4edeso2443704e0c.0;
        Mon, 28 Oct 2024 18:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730163817; x=1730768617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bhcbV3qJpMoe7dq0DyYnJZ1QcBEHyF7RQEz/W7RTy8=;
        b=Irgl95iBTNZcf2RUvDMty7wCDSMo0JE3n8LkR+Wnb6/HSMAFJDKuBrqDJYDineePAg
         JeIdEVvEXBu+Nqoki++UBV9mUnX7AlWQktxP/VvxQGy4M+vgMsEFGPJmqhh9bEfNj5T8
         EpCRFfnHbXZVHU+WyEY67gHwLxtCgPtq9BI1AdJX0IVTRkjQwcHoPAE2hOFocaQMyIaJ
         +K+kxTWV1zc26BuhjDkZCauJN2nPjsqHlwvdb4911zDeZD8Cb47acWqRFr4k8lVUZxGq
         +zEGNHHiWhR74hxHKN8so9jGa5NBpaMyJp5daGhqzxJXELvS9i3D01YxzlnKDtFSUG7r
         XOfA==
X-Forwarded-Encrypted: i=1; AJvYcCWx5O00qVkxz6Z+Kd5RyFsuorbUjndBXH558GbKhqlUtImEQqjnTUxeZ211Pj2SajlhfvsCjVIa7fQ=@vger.kernel.org, AJvYcCXf8saLR2Ug+tYVl+f5+DhvIBYUBMnorBUFroOEe+MQ9Nk+xAzx6IEeV/Gj6QoLlSX5b6RUo10JPkKXGHta@vger.kernel.org
X-Gm-Message-State: AOJu0YzbubBLXm30l+GEQ1Bck+JWqPg0T7miJvPo51LeFSHVGm6TkLd+
	QA/rWCoW94+OBQkycqIMbK7g7cMfn1hcQMrAmUACf6NaFv+snNYQtIpK9JRIEo9PV6HS3njLBFa
	ntk6rguKrEKl7eH1mEeoGvEgGXM8=
X-Google-Smtp-Source: AGHT+IEKvEDLN/HP590zYcpR2/L3gFcXo+/EAU1H261w8qZA/nyr6ixLCyNEuCarN3qJVgtVuB25ovSFTcw7aXLA04U=
X-Received: by 2002:ac5:c748:0:b0:50d:5754:c903 with SMTP id
 71dfb90a1353d-51050600e32mr255939e0c.4.1730163817549; Mon, 28 Oct 2024
 18:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029002324.1062723-1-mcanal@igalia.com> <20241029002324.1062723-2-mcanal@igalia.com>
In-Reply-To: <20241029002324.1062723-2-mcanal@igalia.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 29 Oct 2024 09:03:25 +0800
Message-ID: <CAGsJ_4xEpk1dQFBWfkqGqiSV+Z5Qzyp1Rju1zEhErDRgBWeXtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: fix docs for the kernel parameter ``thp_anon=``
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 8:24=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> If we add ``thp_anon=3D32,64K:always`` to the kernel command line, we
> will see the following error:
>
> [    0.000000] huge_memory: thp_anon=3D32,64K:always: error parsing strin=
g, ignoring setting
>
> This happens because the correct format isn't ``thp_anon=3D<size>,<size>[=
KMG]:<state>```,
> as [KMG] must follow each number to especify its unit. So, the correct
> format is ``thp_anon=3D<size>[KMG],<size>[KMG]:<state>```.
>
> Therefore, adjust the documentation to reflect the correct format of the
> parameter ``thp_anon=3D``.
>
> Fixes: dd4d30d1cdbe ("mm: override mTHP "enabled" defaults at kernel cmdl=
ine")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Acked-by: Barry Song <baohua@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>

Can we separate this and apply it to v6.12-rc? If Andrew doesn't require a =
new
version for the separation, can we extract it from this series and
apply it to mm?

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  Documentation/admin-guide/mm/transhuge.rst      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 1518343bbe22..1666576acc0e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6688,7 +6688,7 @@
>                         0: no polling (default)
>
>         thp_anon=3D       [KNL]
> -                       Format: <size>,<size>[KMG]:<state>;<size>-<size>[=
KMG]:<state>
> +                       Format: <size>[KMG],<size>[KMG]:<state>;<size>[KM=
G]-<size>[KMG]:<state>
>                         state is one of "always", "madvise", "never" or "=
inherit".
>                         Control the default behavior of the system with r=
espect
>                         to anonymous transparent hugepages.
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 203ba7aaf5fc..745055c3dc09 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -303,7 +303,7 @@ control by passing the parameter ``transparent_hugepa=
ge=3Dalways`` or
>  kernel command line.
>
>  Alternatively, each supported anonymous THP size can be controlled by
> -passing ``thp_anon=3D<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<stat=
e>``,
> +passing ``thp_anon=3D<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size>[=
KMG]:<state>``,
>  where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE and
>  supported anonymous THP)  and ``<state>`` is one of ``always``, ``madvis=
e``,
>  ``never`` or ``inherit``.
> --
> 2.46.2
>

Thanks
Barry

