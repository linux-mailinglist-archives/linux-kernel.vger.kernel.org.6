Return-Path: <linux-kernel+bounces-275608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4E4948793
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A60B20B66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BB3F9F8;
	Tue,  6 Aug 2024 02:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPCJyPJ9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300B015D1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722911178; cv=none; b=cghJ/MFiDl+/rC70k9xxaIIK0lEsM+vSD8CU+UbvwtGkW+qeKRw4nEeRUuSWgCdskdhK45/kbgaqNVt03s4aCTqXP/5sdIrD3SodiUuzTIjAdfxGS5c7EMJWN6nnAILxVw9LEwA5Thra20DnaoZt/fy024XGb0D3VEQcJbV6a+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722911178; c=relaxed/simple;
	bh=k6NTygJfYjeiDGiiM5Z7PFfl8zAiOPhgCZVHXHCb3mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5s2HVq7iPHnIUZ6WYCOEUeS3ClfftVru76OS8kzsU+3VwTX9oDf5xJ/Pby+qLvinVDT87okk9bTWOchqq7I3uSVojbt2L8tP47AJxqBVYx61cHH2GBZwwfwYanlomh/2hTzDTsuhVXHioGoR/0xDxKaBzWi798zzVo01EWWXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPCJyPJ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722911176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6NTygJfYjeiDGiiM5Z7PFfl8zAiOPhgCZVHXHCb3mQ=;
	b=bPCJyPJ92rmJBAACY3OGDVTn3MjfD53x/gFN334cCRgH4rMBAWdaJTu171rZfnuVKB9PH+
	XUZTXUqrt9w3AC3Sj8uW9arIvHplyB1KleQIj+EbCQXqmAAkixOFwLANt4Go0zBVDQwUlQ
	yZaqHd1QHKXf546D9In3a2DPBW44fP4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-8jZdPVaWOluyNUgD2Hvdfw-1; Mon, 05 Aug 2024 22:26:14 -0400
X-MC-Unique: 8jZdPVaWOluyNUgD2Hvdfw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7a2787eb33dso178905a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722911173; x=1723515973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6NTygJfYjeiDGiiM5Z7PFfl8zAiOPhgCZVHXHCb3mQ=;
        b=eLkxtonCS8UbTB3Ozb2eur79cSmk3Fh6Vt7+FMhOjfdCcOleInC4XAfqfaxSbJ7VV7
         Pvkzn9G7H1WuCHfYus1q0yiirVHIodrHOuutxSZPizbtZE0L0+EnZkc91LTjkQni4wib
         iIinLTfEJxATu/w1GBjg1L4VBPzlniKwOO7hR9ilcuwr7fFlwGk9m+IjwVWy9LYFkM8q
         21eEM/dWMFEV/2gTf2rPit8n8VxvUsldgxyM6tRlg9RNJgcQDkj7KBiYG3Hl6G59vWJA
         DyEn9V8yLz5Z/1sNHZbi4GbRbkeODYhUWm0pGJbyKA79eK/lYKTnXjUoBHUQ5HxXOkhN
         a+eg==
X-Forwarded-Encrypted: i=1; AJvYcCVgI6tsoCll0k3sCxrP0KdW7ttjBN6LABhD7svHdaKC8uLAJ7qYUBrqwkttxA2GejjocTV3MFHQEZXx03ugzmqcbCz7O9uDRkuYvfVc
X-Gm-Message-State: AOJu0Yy6p7QGFURf6LGU9iyeIbZ7bEZWuGZh5hMWTKlDcTAjukvagBy2
	8C+zneKRw4Hry0YW/ISm7szwYgIgTq79uYfvoYcSdRwr/WuDMEukVV75uzR1/9eoxsO2llRDXwM
	ZDelZfaMCwmzpFW+pR0PkcJf1coeyaVPZn/iPAL1m50BdEk97wfAJBJdt28JJcTVVyI8ZhaZC0A
	e2iP1motL/7synIuKlxl8j4iHTL+4LLZYh4I2y
X-Received: by 2002:a05:6a20:72a6:b0:1c0:e612:296d with SMTP id adf61e73a8af0-1c6996a03e4mr18761548637.54.1722911173004;
        Mon, 05 Aug 2024 19:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfuGebwST7wXEt/UP+32zeyEU8M+cGevEYOCeQzf+mp8OawI/DOWjnqYlnHzgC5I4WJomU0+EyO3jX+bhI4VE=
X-Received: by 2002:a05:6a20:72a6:b0:1c0:e612:296d with SMTP id
 adf61e73a8af0-1c6996a03e4mr18761531637.54.1722911172504; Mon, 05 Aug 2024
 19:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <20240805042421-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240805042421-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Aug 2024 10:26:01 +0800
Message-ID: <CACGkMEvsagVFdqkZvoRWRC2sSSNkjSA=eFjnZU=yT_F=GvQNdg@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:26=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Aug 05, 2024 at 04:21:06PM +0800, Jason Wang wrote:
> > Barry said [1]:
> >
> > """
> > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > __GFP_NOFAIL without direct reclamation may just result in a busy
> > loop within non-sleepable contexts.
> > ""=E2=80=9C
> >
> > Unfortuantely, we do that under read lock. A possible way to fix that
> > is to move the pages allocation out of the lock into the caller, but
> > having to allocate a huge number of pages and auxiliary page array
> > seems to be problematic as well per Tetsuon [2]:
> >
> > """
> > You should implement proper error handling instead of using
> > __GFP_NOFAIL if count can become large.
> > """
> >
> > So I choose another way, which does not release kernel bounce pages
> > when user tries to register usersapce bounce pages. Then we don't need
>
> userspace
>
> > to do allocation in the path which is not expected to be fail (e.g in
> > the release). We pay this for more memory usage but further
>
> what does "we pay this for more memory usage" mean?
> Do you mean "we pay for this by using more memory"?

Yes.

> How much more?

Depends on the workload, but basically, it's just the maximum size of
bounce buffer:

Default size 64M

#define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)

Maximum 1G:

#define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)

Thanks


