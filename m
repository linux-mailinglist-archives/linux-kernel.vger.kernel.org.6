Return-Path: <linux-kernel+bounces-187922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5888CDAC1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54958285D48
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450384D07;
	Thu, 23 May 2024 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NKfYcF2Q"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F183CDC
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491832; cv=none; b=bwChV4B3HgTfmXYZZOCZAK9dbBZDshq99wsbfcjS/ghGVtTIhl5L+aZDb7XrfY03H8f6xdu3rHhPunXLaqAVjH/00pid4wTSZijr9WbKzqn/03d1hfr0m0qaV5kBk/3WAgqKC1DKyALe9vnuDtlHgvAUJ9YumZX6xxUwt9ay7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491832; c=relaxed/simple;
	bh=XHGnzUbAu/lgtI7aJJ/7Q88s6FreZQE3Eor2XeaNWGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJpBsbW3NsLpxeqJCFL+innxkkEP+4Zqrs107wvIS0y/NAkgLZ0+SzmFR0/v+5HnKY/HTgmbIlrGLfWQ6KNrTyOB4ysI8lJyQpbGZZbFOGOmTBCraRMCB5Qed/gAh0yA4fNepGcTBt2mBVXIfYcEBDjk34NjIb8nya4HyydZcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NKfYcF2Q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f693fb0ad4so3112441b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1716491829; x=1717096629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHGnzUbAu/lgtI7aJJ/7Q88s6FreZQE3Eor2XeaNWGQ=;
        b=NKfYcF2QymbfEMgdfzIMJ/eOYu5EXDWmWkCu7rRrIoIhFxG+Zrow+loBYerUX2dWb9
         Sq4bI1tPlEtpvz6Xjgcs5c9TklJmbFI5p44RJzFm7AlB7aPdM7i27IE0lLs8oGpUhLfC
         dM9dxBdsLGPQkzE3/Qo+nQlSC80ThntMlR1fU9KNRPz5KgIO32ViDPwwnOO1qduttzKB
         psRkR5P+iRp80aee3FDUIjiN6wKy8hHykXLaymQa5UuIi8S+EeULXk3wnLJ4z/z10L3r
         jzPFA15W7x2Me8nfVYpii9pUvP3FOKrMkdVg7cZsMuPCD2qUyP87Qp0HJf14rDEoxbye
         m/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491829; x=1717096629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHGnzUbAu/lgtI7aJJ/7Q88s6FreZQE3Eor2XeaNWGQ=;
        b=E2+ZxNMQlSwquIbCOdTmppjqdwPgql0eIMhXt93yAoXm3d4i0a+VTiQdRF+YiZuFmi
         1tY2T+TmahJ8Q3kkk6whhgaqODch4nvGv41Tt1kXVentOnwRsj3mqaXJmf6fhgFPNA+n
         Jtp11dxZEndfuW9kcne7kTPpvP1/kq22/5R+YXsLf2TWE77IqgrlchdWOdiOpPrLuzuR
         Mz6pYUBdEfJPx6aUd63Ymr3iXtKPRj19QLCZSEkG/N/4IGANZ1XVlkQUbbscYyqETrH3
         g6n5qP9IhIxr+4proaCVD8FwZXe2vI+5fSbD+Smns9Y5BSBHeSLxIz/3DyTMYggmehnM
         nVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG8ixbQdr6wPojkoNdb7xA+uCIJlE5vZcRk/vlvzjYrawDer7ebX/7HxPYXmlcz+jt1V4aAS8qALQJmTk/V7qoqXVd2DXs2KmaSe1l
X-Gm-Message-State: AOJu0YyIykTlxdhNUZ6OfA76sgJ9G4+nwYXkXHTE8y9kf5ZgVIb0Q7p8
	85IDVcpI65Z6/FjS3GNVIi87VJfNY/32/KKcjopvD6uPyQWtL1UF2LUZ0irX92yIqPYH7Yrq6ef
	v+yeIzQ2nARD0FM/k2I18KDEq8FEg+enw+RmJ4g==
X-Google-Smtp-Source: AGHT+IGqZmCccDYDP41dqxMcdyQX91RuVAfV5QMY8fV/5WDcPW4VLauQTYRVutnuQ7xeHpjgAi5vfKFxBN65XkeCoGQ=
X-Received: by 2002:a05:6a00:28cd:b0:6f6:7c17:704f with SMTP id
 d2e1a72fcca58-6f8f2c626e6mr187429b3a.5.1716491829330; Thu, 23 May 2024
 12:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523183531.2535436-1-yzhong@purestorage.com> <20240523115624.d068dfb43afc067ed9307cfe@linux-foundation.org>
In-Reply-To: <20240523115624.d068dfb43afc067ed9307cfe@linux-foundation.org>
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Thu, 23 May 2024 12:16:57 -0700
Message-ID: <CA+AMecHUo-sPy5wDszWgX5BWPAqMwrXqCWO1jGE5uMRq2U=BVw@mail.gmail.com>
Subject: Re: [PATCH] mm: /proc/pid/smaps_rollup: avoid skipping vma after
 getting mmap_lock again
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Mohamed Khalfella <mkhalfella@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 11:56=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> Please describe the userspace-visible runtime effects of this bug.
> This aids others in deciding which kernel version(s) need the patch.
>
Otherwise, with some VMAs skipped, userspace observed memory consumption
from /proc/pid/smaps_rollup will be smaller than the sum of the
corresponding fields from /proc/pid/smaps.

Please let me know if separate v2 is needed. Thanks

