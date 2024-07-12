Return-Path: <linux-kernel+bounces-250699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E8892FB67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7F01C22421
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2765216F90C;
	Fri, 12 Jul 2024 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETlsqYew"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5616EBF7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790893; cv=none; b=dJBY9Br1R4yL2bdq4MCSGMQ9yzeUwTET8dvyWGL2z66HXYs1MxB/9BSrg4SNo+0v8rE4P/lHI98Zw11cQrwFffdS59oZ3T4Tp/z6+Z36VsUqVc1Fpig7fkqDFagx9lFMjnCCu0IO0XQDUVfxL8LJ3H6EsJyr9uADoQvGWq/n0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790893; c=relaxed/simple;
	bh=WUQilzNwh4A4aLbw+yOyxTW32DE/qLJpriZ50o851Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FY6GNWKTG8GvM34iAmkfMF1oc7UjhIdPYbsowLEEs2nqrde6GF+Nkhx0SY3xXWyEICiSMr61vBZ+FOOF9merjgTDwp7NTko8UMTLnzNhrbPh/udE8Q/dcam7acbG0/hkx1xj1CSwd3TPSWdkRHT5TSf5djwSR02X97T20wDLYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ETlsqYew; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-643efaf0786so19161957b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720790891; x=1721395691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUQilzNwh4A4aLbw+yOyxTW32DE/qLJpriZ50o851Bo=;
        b=ETlsqYewDT0Dz+PLY6QRHqi77ekPUUwUe5maRQKu667C6dbKk81nG/Vl2uL3DmeHDj
         MwWccy1sUfAPishY47r2o639/NqkKAHqJVyTvR4Bj/DbGD79zLzEjPrzi56hjcOjGyOW
         xcnbueOOCgU5GD5e9Ox4cdauIDymlB5AkDYpp4O6x5mBmg/d/k+9k0pS2Gl3TvXM2pqS
         89iDgLmkx8e5rrDlPR5P5sh4Qv/nMRhVGihrJP60mCyVx6tvKUpDdQoOJdwfalvrWIbc
         zzl2Y51WKz4gc61HJ7nto4bWEyxhLxuumR/3t+i4pd3XpiGs363g/vhG9hPdXOxpCSA9
         f+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720790891; x=1721395691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUQilzNwh4A4aLbw+yOyxTW32DE/qLJpriZ50o851Bo=;
        b=p33GxxFfoj33nrmvuQAbFb779kTo/5dVU7yq1YpoK0YMWVCFpDywaDu+70q0eIU+tK
         x402c5ZRdcBhs0I6zywFHeGO71NH1NwnpNhX8YysErsFnDUYpL/tFN+76mA1k5jZLu89
         1N9fXtuhGAAT8S2J/sUJlniFsgJSA4CFX/4gysKn5NZ459UoGfgCNYkLZyUZ6lkFiXkY
         SCDIYl9QlyzMEMInGqRyHdJQHBBVnki1/kDj8qWJPETR3SRxEbYmDHjUQMeWJATZW+8J
         xRVdpF8BKiDpQ3BXaIwfCrw4c8G5yZn9c1LKWh+pZWY8vNLZaBxux8hBi9TE/prnoWqP
         8foA==
X-Forwarded-Encrypted: i=1; AJvYcCWG72K7KqJYWhpnIwmwRMlucPbShM2T4bGM0jooqHnYgs8msZksT9r1zYUTExd0gEUj7gkFXB+dm4DK1BH/ATcJ3LG62uXdySvs6/Xq
X-Gm-Message-State: AOJu0YzgZNCmf3rwTXxAIYp6WTurm4FAvgueyV6N8ZjUoMUrgOm6/YYJ
	Nivs4YG94TZnOHSWDBXJM1Eo2flIXAhL3Ft1nk2N2rzPpncSgv7BKhrU9KPZ9eGKeP74K7REpgZ
	4sV22QX2YrtBuJE1NQejUPL2sQpDeVnsy5F+m
X-Google-Smtp-Source: AGHT+IHo0V5831tVet8vGHuyZEch41iiarXWj1YQidETIxQd5vnugFPaYbYDgBrN9b1NIM+W/OH1BJazfP6kg3mW5yw=
X-Received: by 2002:a0d:e381:0:b0:61b:3364:d193 with SMTP id
 00721157ae682-658f07d6b0emr126003057b3.40.1720790890539; Fri, 12 Jul 2024
 06:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711204626.1669138-1-surenb@google.com> <ZpCwPCAsN17ADt-R@infradead.org>
In-Reply-To: <ZpCwPCAsN17ADt-R@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Jul 2024 06:27:57 -0700
Message-ID: <CAJuCfpHX9SzPBTxQg2NjKPjbeD60HAotdK6DqnFmn3crvnGdvQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: Export memory allocation profiling symbols
 used by modules
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 9:25=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Jul 11, 2024 at 01:46:26PM -0700, Suren Baghdasaryan wrote:
> > +EXPORT_SYMBOL(page_ext_get);
>
> > +EXPORT_SYMBOL(page_ext_put);
>
> These really have no business being exported, especially non-GPL.
> Please rework whatever interfaces need them to be be moved out of line.

Ok, I can do that. Thanks for the feedback!

>

