Return-Path: <linux-kernel+bounces-349350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 419F198F4A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A01A1C216CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D661A7072;
	Thu,  3 Oct 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZUKIjTR"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7FC4437A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974555; cv=none; b=IdoZ7RqeaolJvRY63wCVKu93zLP/nVuDOIOOmeEeiR6Dq+eKLAvl98AwQgC8FLKou/VB3T4pYLMdMAadVb15n70N3c/EBzRJh2nurGNiAAFFzkmXg9L/dlHw2n2KaA47lLxx4uQLtrxe6CjVzhqmusf+9UVJfyYORkMRPpFrFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974555; c=relaxed/simple;
	bh=okQL4TDUYW8zgpiY2XyrTExzNNu04WiAnb8ACpuRWaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpgeV9EJd9whnekBBbJhHVPHwJCU4v9Oq3vCGt1kF+VhnlDRwgAk0JLgDApc4IUQ5PstpXLGovGG57TRNMz8vdwq/IO0pqZ3YcCpvezgQcLc3pWTQ3cOv37M1mlqZh0NP0U9pCmm6b1g1WJKDp9mAFUNiDfFsveasLFkvhL5HVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZUKIjTR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c718bb04a3so1520654a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974552; x=1728579352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J2m3xY6PlLGSTN5fPr42DCOph4HTOgUFznouod/TFqU=;
        b=MZUKIjTR67vT/20Wrsm/EeF6GI2tpSafV+BHrCHwnsnjQusbhL50Z7gFq17M26uXYm
         1MmqP0+nwXYO8JlF9TCQ7ZQBazJibuRZwE6JwoUbA87N1pPpl3c1YHvN0WBIWCQMmVuD
         5igPAj/77b6+L53kdzQvjWi9J1/Xd2HQNrfQryPT6mrTssRwcixUsdeafRkUCEsdwTh7
         h46ixL4sWIgzDubbuCWjRWXa3taT/tsUJIi7+1ZzsdDqN6KNqKqUPWplHrSLtWjSDREA
         oxSba80rIZ1t+LDWqHT29EQAAZWFUA55Ly++kGqDuJtYFXarjeldPcaIUpz5AvcGJsYj
         PtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974552; x=1728579352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2m3xY6PlLGSTN5fPr42DCOph4HTOgUFznouod/TFqU=;
        b=wOD2FfQKf3Fq7wq4CMUMrbF3ConwxGQCdGkiKzSEQSspcC6nBRyDkdO12atfqnlylm
         FpES7ey6vsKx6b53mh8iFB4kcsSJqSOzlzE+8ml9vH+W1cS1debKfjUnJir4f1YaHVy+
         1ukr7CkOZLYIQsTNSw6aGtz9uPdqIMvWUMUmAXHP0ikxVNwSV35Xlfyi+q5qMEribkIv
         jdQ3O5rDNWqJNRlWP+2N4H9YL8IM/3ePkQIf+lqLmN7u9NO9b7/x7wP+No1iOjqy5j+U
         7e7b/GbdNFNAgAhAURoQQd0WVGHeEyFhxL4oTuq8aJSUylwqe3ts152ft2gYCaBlP0Rc
         d7zA==
X-Forwarded-Encrypted: i=1; AJvYcCUITbdjYOT7yDOIhxuiwQByVYGNv6xIYLmcEPH1r5HSYI+d49llGTBtVDdz7SPgNPIZQfXK8K0sLthEfb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEEGlU7hVxpsJhwSAoWH3FUdgO36kpkxPnnoJx4Z37CKmJ1JO9
	ACiWXyYteeLMra/pioIzIzPWTku1iopNeASLQKBt+Mry6X2aQmbZAAGgbvjAp27jYBpqpg9qhdW
	dh0qU94EWW80Y99xtO70QDx2K+hk=
X-Google-Smtp-Source: AGHT+IHbsiQzJ06SyZgAAiQbJMkT/n0LTtOuxJ046aHIEGJik+fIDuB4Df8JkyRU5FSXhJMEXviPOZKpTEvRrszeeKk=
X-Received: by 2002:a05:6402:524e:b0:5c8:9722:f9d1 with SMTP id
 4fb4d7f45d1cf-5c8b18ded1amr6832191a12.5.1727974551484; Thu, 03 Oct 2024
 09:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001175358.12970-1-quic_pintu@quicinc.com> <20241002031850.GJ11458@google.com>
In-Reply-To: <20241002031850.GJ11458@google.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Thu, 3 Oct 2024 22:25:38 +0530
Message-ID: <CAOuPNLiJHRL+7B9FkmK_x3gcjwrAfNaRR6mrYy-AwT_M5yaiww@mail.gmail.com>
Subject: Re: [PATCH 3/3] zsmalloc: replace kmap_atomic with kmap_local_page
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, minchan@kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, joe@perches.com, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi Sergey,

On Wed, 2 Oct 2024 at 08:48, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/10/01 23:23), Pintu Kumar wrote:
> > The use of kmap_atomic/kunmap_atomic is deprecated.
> > Replace it will kmap_local_page/kunmap_local all over the place.
> > Also fix SPDX missing license header.
> >
> > WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> >
> > WARNING: Deprecated use of 'kmap_atomic', prefer 'kmap_local_page' instead
> > +               vaddr = kmap_atomic(page);
> >
>
> Can you also update the comments (that mention kmap/kunmap atomic)?
>
Oh yes, sorry I missed it in the patch.
Thanks for pointing this out.
I will also check Matthew's comment below and fix it together.

Thanks

