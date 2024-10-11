Return-Path: <linux-kernel+bounces-361313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D2099A6A0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653801F24247
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7AB85656;
	Fri, 11 Oct 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaOIgJgz"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A7405FB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657712; cv=none; b=XAzM6GHh2lrVrbaj1TGmaf0baq6FuvIpfaUBJLnX6OYGvWTpEGp4xC3RYqTjbcDmuom23NQChPvERI+Gz3W+jf+GDqU2ptOxpB7N4oBX0iJ4kjPWrMdWt+VKEN+UwBwheoxyzgojRRKWV22hAclUaJ/XMxc9/JEsRg8fhdHERQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657712; c=relaxed/simple;
	bh=Rbf0ubGLuyJGPt0sCqkEpU7AcS3S3iZYkApXjN/ksFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTnbjvZ4Cao5n9lMMCuyy0SR+5hdBPXXQpPmCy4syyCrAzoZsCcgfh1r3jet9QxGrqKnC81AyTGPqIr54IZEVqCtYgsFs7WGjlSNvTOakMz0zO+LGFPuWfGcOclYV48g4BU0AqeEtYP3bDJ39GrKc5ekRGW3skwbGA0ZcR9l2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaOIgJgz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c94861ee25so556969a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728657709; x=1729262509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp8vUrCXToxwD7SSj/r6S4k+PSj7M3peewBwqhlyyBs=;
        b=LaOIgJgzAhI5c+8V7uyzakvYbh9AcPgIGFhxXD64lNL+FvaWVytt4ohsLkIlj7NNFz
         Ph6EZjj4cuR8m0ehHN7Ri+s0ESyo762NmO3MAQoAGNvQacN9TMP63tIVTpCSztv0/TYo
         HzrQ9yPBgmtRDxL/jeYfxqH3hcm4xpBpLOWV4FhLQzYpDt5XckKcnQk+v15nScx2c6AB
         tjcCDkpdJxCJZYFBDJIkI7xzGuIyUtGvgrTKbswr4XSqsgGGdBMpPI9hqlh6Mjhu9LJB
         KU/JneAvkIswCDQTdOluHKdvZ6k12d8YhshEpJZLOQsLUb7ULxajlcBFmWwgPrZKJ3zx
         cwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728657709; x=1729262509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yp8vUrCXToxwD7SSj/r6S4k+PSj7M3peewBwqhlyyBs=;
        b=dpEyPwCm4fRtZP7eif0C2sv5FCfxX9/b/nlhiW+gtPKQtxOaT1QqZYU2Iqr7Vikqf9
         q6A/CTGrKWQJq6SMb1dLfFWhwwIG5NxzP/rHTQO73tC9VfQQwPhehS1/v0pUsH6F6rPn
         KDyRZl31IpU8xX+JmVQVDV3ulDVYD6NBV3M8N6IHK71fUnTcNczwwerHQFQnDhDwyG70
         Q/T4vJkThfqd/sA0xpBFutGnhoI3Zg0GERJGiWhjyODfp+H0vu4QZAsZA5Pqn1ucSXfL
         fKRt/rn7AUSJIzX5VUif7D44TOB+UxCGpwEbpryH9aLi33urFIt9q3SWN9+EYCEye4mn
         JFJg==
X-Forwarded-Encrypted: i=1; AJvYcCV0uuSP4sFrLqG/BsV2fGBq2nH93gwnl32X9Zw2p9xZgWvojAC2mHvZ8HgTvC4e8vPY391JWr4Dmp2kWLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIz8jm+01LHFi9iwNeQBWVsviANIPwq4L6oGdo+EKxBQ8AIuzG
	P/v1ml9kBJpq75EX+FGj89iHw+asgUmk4E0hvBa4iJQsZwuJ6i+Xpm7homUU8yxBwt8ghMkzKN/
	lgi7T/Vn8A6Rffxc5P4qtvGEhvkI=
X-Google-Smtp-Source: AGHT+IEL+lzIoRn2C8CX2DEfQMcSNou7qEMI1qNEP2IU8c0FFZsDVEQIMMdeJmqWo6eCdiKH9GaZ0oKqzrkyXZHIB4c=
X-Received: by 2002:a05:6402:354f:b0:5c8:9f44:a0b2 with SMTP id
 4fb4d7f45d1cf-5c948c8834dmr3313318a12.5.1728657708906; Fri, 11 Oct 2024
 07:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010175143.27262-1-quic_pintu@quicinc.com> <20241011020037.GB1279924@google.com>
In-Reply-To: <20241011020037.GB1279924@google.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Fri, 11 Oct 2024 20:11:36 +0530
Message-ID: <CAOuPNLjUx1gXLWeoNCaxsJVEwwVO8-zikErEnDm1e4pMyFFBVA@mail.gmail.com>
Subject: Re: [PATCH] mm/zsmalloc: Use memcpy_from/to_page whereever possible
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, minchan@kernel.org, akpm@linux-foundation.org, 
	willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	joe@perches.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 07:30, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/10/10 23:21), Pintu Kumar wrote:
> [..]
> > @@ -1511,10 +1501,10 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
> >               d_size -= size;
> >
> >               /*
> > -              * Calling kunmap_atomic(d_addr) is necessary. kunmap_atomic()
> > -              * calls must occurs in reverse order of calls to kmap_atomic().
> > -              * So, to call kunmap_atomic(s_addr) we should first call
> > -              * kunmap_atomic(d_addr). For more details see
> > +              * Calling kunmap_local(d_addr) is necessary. kunmap_local()
> > +              * calls must occurs in reverse order of calls to kmap_local_page().
> > +              * So, to call kunmap_local(s_addr) we should first call
> > +              * kunmap_local(d_addr). For more details see
> >                * Documentation/mm/highmem.rst.
> >                */
>
> I'd prefer this entire comment to be dropped.
Oh I thought the below code for k[un]map_local[_page] stills exists,
so the comments are still valid.
Ok I will remove it in the next patchset.
Looks like there are a few more code improvements possible.

Thank you,
Pintu

