Return-Path: <linux-kernel+bounces-529488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D41A426F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887613B3193
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F251125EFBE;
	Mon, 24 Feb 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="Yugd5ZV7"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877425EFAB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411940; cv=none; b=sa8dJKi+vfCeb53qoc/HjG+vZ4ykP71ljW3WZSpmiw+22Zr4f9ZZQG21aBcsPl86yi8BeM1mIZURpXVKw4n+rI7tuJfyUt1skvBLjZkSz7qEq6MCKP4Po/b51fbIwdGeXt/E89tVTUbXHK4Kn2hhwloXUKds0GNBYvzntaKY4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411940; c=relaxed/simple;
	bh=QR8PQ2mLsQpUR1F0fq8t6LeA0WbrKQ2TFmOHo4xz3F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAcdKLmOBnPqvhnBvbOL45PonVgaByoHsZZrToV5d2sf3iG24WiSFS0iykQXWqfaoRD2TtFe+zqqxu/UptDkJs5JSxbKNCRdMdEnuSAhRzOc1lFhd63VyR6tZiSzWl1ZtE4SveYrcoFWelivIUw598Py9SN0PbGvKjsGrDRjZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=Yugd5ZV7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22100006bc8so79505695ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740411938; x=1741016738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vpFPjAJvV1xY/hqE7tYkEGP8ugx8Y4/2E/Q9/wCmV8=;
        b=Yugd5ZV79CI63ZzMcsB6uxbKKBpJC60ivCFpRse/Xso+Y0KDYMfDVDp4lAh/ZRSJTT
         YpBJgCS6qpdr1y7g9yZZwYPPhLyKFK7Vi7njJIJfdm6DQPJEliuwBKqMLKtIftTAAg7v
         rQWfMy6i+kecNIUhnWet+GYCx8a2pcngGD0lmvD5iqebmITIm9+MK5O+AnInaQuqQHIS
         t1KjUdDIPYto8hFfRHZdtoLJhHnomPwDUbFHZXKa9uHR6W7NP+TueShtMpTX8xEg2Qkw
         oK9uxHX7xKAD+2IPX46ruh1GZAtTBLtUuD8sI+KT0P/jMWnwQrVbuY+3R8wrW+RMVDMK
         cIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740411938; x=1741016738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vpFPjAJvV1xY/hqE7tYkEGP8ugx8Y4/2E/Q9/wCmV8=;
        b=g7GCtMzWshyGkj6WYgFSpeiC64E5f7WJFFXRvIEfAYq3w1hDyIE+V6hzg8FKr+qZyL
         Z+xQVR1VDFuE4OiimLAuMPxKUMOIGFRN7lEj9Z1wgHnWgbW7okIowrwXA4jX+HfuAnF4
         1DYJfKx5Um24NPM90LCHq7mo7P9jDets3gkPEkeNcKRehoWyaO+/1MCrzXTvlzGAfLvi
         xXHxpVlHTxfn73rIo4cUcyiPR0kC7NPzJusKDCTuklWppHsWztJLPD+QTNhDZjosJJTv
         8YtUwJU8bywzComPAqQHK6LuG4i6efGt6QoY8PP5Hn6ISbk21xoVtyc/GP/CWnzoYTXq
         D77A==
X-Forwarded-Encrypted: i=1; AJvYcCVIcKdbV5nEI5tQfnG9SBlif60Iw7pNeq4r0PeJl2zQAD4ykgQ+bc32drWcp8/N8OTW7HAhO6hkd74jKYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuz8s+7pvQJJWoGqYuDM/n3SZTCSXsT3eol83+WPu3TmNxZLMF
	gCL+JnHEShZBENeLz0Zt3ZxoOxlyst6KQoU/6S4sWllSX/Ibi9CL+4YBsKy7rRGp4e1QlcvSxty
	a/vV9vd0VNd1W+sXGAIi6kEHDSV4/YzQ3zQ4W4/CzkVuZVU17Qceb6G3+aYxTLv+/diQvfXBMMu
	hI3gAztpsYKoZU/YIiPHx7cRG2U4XY9K74ZBy10OPRKf4p2poXWQm+48vUCv4lNZ068CEobl+qZ
	y5ZR1baTMwzNSj76VtfCCzFD5bdme9+bB/U65rKoqVsSNT6mPW2NoGd14NYvmkkPjAEYGQKhdDc
	iYZcTz8Xn90s9OQYk8ZyewSP10uLxLJMaE5zBBJuupllqFkXGhXUqNAyQxeuaXHdtlCC98i+Ajw
	MlUpVeTuf/3b6iThlZeF5YKosAAojgoh2BA==
X-Gm-Gg: ASbGnctTNbFqwEQBOZ2LJr4zUZERJ74gYX3sPO5Wsmm1j1+okGF0q7slvgwjYJw9zbA
	RpQc9kx6wbaB/OJYHBwQ2uWIOed/Qwz3FbursYpbcY+XOHEESh93f/AV5RLb4JmYCD1g0P1UZJD
	5femvGGLpulge0+PcerbeJsg==
X-Google-Smtp-Source: AGHT+IEcQNiAKMUbPh0M58vsweOlxgosMhBo5YTURrJtkfwHfEjps5PLHRpPddIOGjzbuxIf2pQa9/eWZhn97IwVteY=
X-Received: by 2002:a17:90a:d60b:b0:2fa:e9b:33b3 with SMTP id
 98e67ed59e1d1-2fce77a646dmr21092693a91.6.1740411938036; Mon, 24 Feb 2025
 07:45:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de> <Z7yRSe-nkfMz4TS2@casper.infradead.org>
In-Reply-To: <Z7yRSe-nkfMz4TS2@casper.infradead.org>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Mon, 24 Feb 2025 12:45:21 -0300
X-Gm-Features: AWEUYZl1jANUANFo8W3Lf3P8R8iIFWcreRO9Y0ZcM5Jd0irI990vkN6P7vCMcpk
Message-ID: <CAKhLTr1s9t5xThJ10N9Wgd_M0RLTiy5gecvd1W6gok3q1m4Fiw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Feb 24, 2025 at 12:33=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Feb 24, 2025 at 03:17:44PM +0100, Christoph Hellwig wrote:
> > On Mon, Feb 24, 2025 at 05:13:28AM -0300, Raphael S. Carvalho wrote:
> > > +           if (err) {
> > > +                   /* Prevents -ENOMEM from escaping to user space w=
ith FGP_NOWAIT */
> > > +                   if ((fgp_flags & FGP_NOWAIT) && err =3D=3D -ENOME=
M)
> > > +                           err =3D -EAGAIN;
> > >                     return ERR_PTR(err);
> >
> > I don't think the comment is all that useful.  It's also overly long.
> >
> > I'd suggest this instead:
> >
> >                       /*
> >                        * When NOWAIT I/O fails to allocate folios this =
could
> >                        * be due to a nonblocking memory allocation and =
not
> >                        * because the system actually is out of memory.
> >                        * Return -EAGAIN so that there caller retries in=
 a
> >                        * blocking fashion instead of propagating -ENOME=
M
> >                        * to the application.
> >                        */
>
> I don't think it needs a comment at all, but the memory allocation
> might be for something other than folios, so your suggested comment
> is misleading.

Isn't it all in the context of allocating or adding folio? The reason
behind a comment is to prevent movements in the future that could
cause a similar regression, and also to inform the poor reader that
might be left wondering why we're converting -ENOMEM into -EAGAIN with
FGP_NOWAIT. Can it be slightly adjusted to make it more correct? Or
you really think it's better to remove it completely?

