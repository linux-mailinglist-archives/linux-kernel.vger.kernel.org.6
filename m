Return-Path: <linux-kernel+bounces-558024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312AA5E096
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD213B95FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596224419B;
	Wed, 12 Mar 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+5ySMTT"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938D2505CA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793901; cv=none; b=ZP9feVnTRgpb4+kZ+gGW3bhLI7ESJ6fwrH8gtMA1vdee0DuhM9UFN1bg7hdJu7cAj65R6bp/C9Ijk1+vXT7h23WcklEnbZXiG58sxaDaPhk3Tt3P/fv10ta3C207NP4Q/ejqnej7LCfFQzVacak4mGcyBKR1EZ3UCCM0D9dk5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793901; c=relaxed/simple;
	bh=mECECZUKyT8tJ1zfg2PNBtQFa78DsD3UR2qD52joMLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4qIjLS2HXZZvv1cAAh6OVGREH9pmmYXxcqM/5N2Al+2j+z5yJVX6/EgD4fy5/ramKM7PgoAHaEUXTfP1cWQ0dxXIp2HChV/hIw1qRCCDAu+Z0Bhmf2V4LGX2a2vOvqZViAjkih8VZzHRFca3vSKCMBcZfp38iSzfJqHzX5m4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+5ySMTT; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47666573242so337011cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741793899; x=1742398699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oad3olm2GEdFBtEEysjN3502N0ME3OM6JNCjW+ME63A=;
        b=K+5ySMTTjBAxhjT9qopNvR6EZYDfWxMnt8IKrWiVBK6YWqeMh6/FU3jJA2dRgTx81U
         SmiPCtQKidIlC2wfkRLADkfrmmZ79sD+a/4ayM0kHFy1ES3trxvXhfwsI5KU3JazqsH2
         ZOQ+iL4b+3SVS6szaRL0mV3UHxt+TO5ZNCiMxcvoKuTDY+lQljrz4jpTD28CCk87VTv2
         ykW6QmpsaUBynRldirFij0VSMQEDlsZ5Tj0QYEUjEfC4E9WW5ztGUUHfcHHEOaDbyCdE
         qhKoYzZK19zaEBgJ03U2ViK5PumkXOOXPstRfkFe0lyJcjVyIrMOb5ZmIoyL4t8+Z0pW
         pyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793899; x=1742398699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oad3olm2GEdFBtEEysjN3502N0ME3OM6JNCjW+ME63A=;
        b=qvQWlgpMpiwktUEhDrTmfmQRzTqCgKUeHtMzIQnqPLviG4sHPbuznapDKJ8sxN+Bbg
         de8T0zfh18Qd6wwwnpymsPNCLEPu4ldyRRZKjeYltqz6xhpT2TEEbym4DTmF08sGgPRK
         uXl7WjMSzhmn7uOoceo3ensCO5ox2XnAsWUZwvsTGhWPpP6f/pOrCXpNrg+9vnnGp16J
         GIfWy8dB9C2vdHsNbPkRhfRZ8Je7zh/BHg/EZRI3K0HbCOF6Xl3YEs7cGpr1wfY9BBcP
         aWtmI2vTfkBSP8KoluugSRdOCZEQ6LjRxf/vBVFhypAEV+fCaQIHqWcAweekNhvUeR/J
         lVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8fmpY0VmepXwtlFLifqYdG+wnn16YjXLmr8yMYHm71MmBp+dkuicXTan5OfmXgTrV3BHLrDkQVP1d02Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeW9VSGKL/vQkavUvHx84mMmp1MpFZAiB0kG8zA8m2ySZ8r+Wu
	3F7I+1DAWYoxLHX6WZBNDD8HrqiKnC0D9GVeVgYHFthGT2HlqRrB0yRdoR6URMXhxIvqlnHo9H0
	mL5QKjKva096nqah232BpAXVq7anF3gNWeMHK
X-Gm-Gg: ASbGncvSBU7lILC4fScjrrXvEA9xviw3Fcg6e77lQxJ0mZW2D5USejXQ3wHr0sYqllS
	dFDpqKXHn3pEQen0b7MJCk0b0cFU7Ji0Jf4w09ykMqn9zD6cHdndOzgVpaGEmIatDIK0uypn8QK
	AJcuyNeTIJnD3MIVeBwH4WP8Ny4gn+HaXRqR1pU2wDoD5PlelmE2tTuigU2jkWQgSAWhk=
X-Google-Smtp-Source: AGHT+IFQd7cFv173t000O1zcn+8wgPx4dJlGWMBi427eiMql7l9Xmf0NxuFYWlaUbMq6ERIxoPYFIgYpzBuguiARoR4=
X-Received: by 2002:ac8:5a95:0:b0:472:538:b795 with SMTP id
 d75a77b69052e-476b798f0admr328451cf.22.1741793898834; Wed, 12 Mar 2025
 08:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
 <848301db8f05$a1d79430$e586bc90$@samsung.com> <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
 <Z9Gld_s3XYic8-dG@infradead.org> <CAJuCfpGa43OQHG9BmnvxROX1AneCvkuLxFwM+TdxAdR1v9kWSg@mail.gmail.com>
 <Z9GnUaUD-iaFre_i@infradead.org>
In-Reply-To: <Z9GnUaUD-iaFre_i@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 12 Mar 2025 08:38:07 -0700
X-Gm-Features: AQ5f1Jpfs-45rUWpy4AjGITfWFgctjNpl6Oq04S9EIvxgwjOZng3y_psNvrHlmM
Message-ID: <CAJuCfpEpWQV8y1RKb3hH+-kxczTUvpvCBNNzGJufsAxpkhB4_A@mail.gmail.com>
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct IO
To: Christoph Hellwig <hch@infradead.org>
Cc: Sooyong Suk <s.suk@samsung.com>, Jaewon Kim <jaewon31.kim@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	spssyr@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	dhavale@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 8:25=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Mar 12, 2025 at 08:20:36AM -0700, Suren Baghdasaryan wrote:
> > > Direct I/O pages are not unmovable.  They are temporarily pinned for
> > > the duration of the direct I/O.
> >
> > Yes but even temporarily pinned pages can cause CMA allocation
> > failure. My point is that if we know beforehand that the pages will be
> > pinned we could avoid using CMA and these failures would go away.
>
> Direct I/O (and other users of pin_user_pages) are designed to work
> on all anonymous and file backed pages, which is kinda the point.
> If you CMA user can't wait for the time of an I/O something is wrong
> with that caller and it really should not use CMA.

I might be wrong but my understanding is that we should try to
allocate from CMA when the allocation is movable (not pinned), so that
CMA can move those pages if necessary. I understand that in some cases
a movable allocation can be pinned and we don't know beforehand
whether it will be pinned or not. But in this case we know it will
happen and could avoid this situation.

Yeah, low latency usecases for CMA are problematic and I think the
only current alternative (apart from solutions involving HW change) is
to use a memory carveouts. Device vendors hate that since carved-out
memory ends up poorly utilized. I'm working on a GCMA proposal which
hopefully can address that.

>

