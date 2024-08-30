Return-Path: <linux-kernel+bounces-309124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AAB966677
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCDB281778
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7E4199FB7;
	Fri, 30 Aug 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FsFPIiQ9"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301204D8AE
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033968; cv=none; b=ao/MnJiPKAQTKqX/euKV+6w7F6osNp8il3vZBGZh6CYBLcFsLHtFyq6iUPlivUMuBSOmzZc8ssbh1UNzW9+lmV0zfE3Cqw90OIiql+Z6rB/fQ5DgvgY0PFYBXlAIkdYVoH0aXIhZWH973gTG4IVX5iW4tYdxeMVqfaABBbcrsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033968; c=relaxed/simple;
	bh=MbCkbm5ZmFVv2vebmshq0PtmKsDB/QM/xw0exezg9xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/NVjAwnlZH09L2apT6xu35CI02/pcjq65zCq8ODQJGrHuTmGPS3ErlivBnsT2q4+fzWO/KstvSjM+hxy2Cs5NVBMMjF3EOMdvMFLmgV1CCbL6cF90dd4u4TKff4S+ebrxKUA6iI8YbtAETCNiCBWubZEy92Wfxsr+NTH5mzExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FsFPIiQ9; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70f59e5419eso94640a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725033966; x=1725638766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QFnBrHUOHBIu1g328bGqUADv8FhXAP6VMkOjyVwhEw=;
        b=FsFPIiQ94Fu01IuTjHAqh2RxyWrpttt2/gODvBghCKQIUMX8cIyPSK8qYOzU7wh9Gz
         SFMcaen7mZ2epLd+ojq4x6KUuQWPRwas8iniFKZbwFScfoeEFWd820xgKIskA0+yb8ke
         1r/uq8cO7EooVbh5gxyoc6rZpx9dPlkKNhhCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033966; x=1725638766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QFnBrHUOHBIu1g328bGqUADv8FhXAP6VMkOjyVwhEw=;
        b=aiOx5xwFimVT6OtVHny5LbsK57IHOXJHAyqSlVyNDnYRGu1K9nnSDXuQse0aqjbwQK
         v8qvkJxU5EuCGvf2RHwk3wMkwMFn285uXoorkNQiHufPUV/uqWO1m8fYbAyHd58l/BO3
         SShanqnq3CCP4uCcNdPZYN/QwnyZmYfx++12qcqCqWuq+joJgJXATcjj2Ay1HXzm0rZm
         di5c7ZrLs91bigb8UVI+lTuvRfW8fJH6FBnLxyZt41MkS1/6y9s6ztvMJaPhiT2kCOAw
         x5GgcwiAoA5+1TQS/w22nE7dLki9xWDNYuKorxHe/77mcHYjDg1wN68swQnze6+T7Fod
         inog==
X-Forwarded-Encrypted: i=1; AJvYcCWKRsQilUTYIrnGAT0UTRZSK5H6Wr84dgmuLR/3zblj91X8d3NxRtG1xboE62SI+CQkIz1rwB/SaxgEQFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgewRMvleVb0I/QR3YeG3iuBvi3oNx6xX5S8YcKahLtstnuNLs
	BFujdJn9nb0pkEF4StxKX5GPYrS6wFNyRp+WSVFfLcD5ly5omd156yAcIeZqPHa4SPuzIKVE3Bw
	ecd+c5KuBFMoiEA+xo65euwijnQESeWFztfij
X-Google-Smtp-Source: AGHT+IFLHlMJJ5EBpVwqu1rWmjCPR3DZ5QkbAb7tP5TcOYOi7XVDZanOxHa7tKmN0cLHKkx7iXFjyBjweMsnL1z/4zo=
X-Received: by 2002:a05:6870:d192:b0:25e:44b9:b2ee with SMTP id
 586e51a60fabf-277b0b536b8mr1436022fac.2.1725033965860; Fri, 30 Aug 2024
 09:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 30 Aug 2024 09:05:53 -0700
Message-ID: <CABi2SkVjphqbh5M_ybWRbDYWG08C9eL3x5fmy01AQfp+svM0Tg@mail.gmail.com>
Subject: Re: [PATCH v8 00/21] Avoid MAP_FIXED gap exposure
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liam

On Thu, Aug 29, 2024 at 9:01=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> Changes since v7:
>
> This is all the patches I've sent for v7 fixups plus the return code for
> mseal().  The incorrect return code was introduced in an earlier patch
> and then modified (still incorrectly) later, so this version will
> hopefully bisect cleanly.
>
> - Fixed return type of vms_gather_munmap_vmas() to -ENOMEM or -EPERM
> - Passed through error returned from vms_gather_munmap_vmas() in
>   mmap_region() - Thanks Jeff

I would think it is cleaner to fix the original commit directly
instead of as part of a large patch series, no ?  If not possible,
maybe mm-unstable should apply my fix first then you can refactor
based on that ?

-Jeff

