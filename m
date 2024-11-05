Return-Path: <linux-kernel+bounces-395817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABC19BC375
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0BF1B21AB6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C556742;
	Tue,  5 Nov 2024 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i+u88lgg"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3E487BF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775451; cv=none; b=rn8hgaSn4SxrxWDgMAY9Gm3edkIxdFi8Gxqwi4h+OBySGl4y87gXQy4ybKx3fM042SPLam2m/4dmGatWkRxgllzzV+ucpfB2jtPLtCx8Lils4k25KfReSNe/HRxxfnBxwEVREpIhTqhgalfBM01QUclmVdlXvDGwJZz7ne3Aa3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775451; c=relaxed/simple;
	bh=sS3CMf4Kq9jd/bpACivyVDfVteTLNEOFDKp07YdmOz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezqHpySwsiCy7mLKncpLZga86ekE8dRj0YBzQLA31f88MpVqj/4suGIfuTrUfzXibhOYnpxgu61uS9yiULLfx1L8qDPJyDelwAT8+/6n6Fp/5ilLBxSNqgCLexuFYA/ogt3w8iQyDahjGiiw1GMZRDYdON6rUuR9G+x4ggo+POk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i+u88lgg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43159c9f617so39128385e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 18:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730775448; x=1731380248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS3CMf4Kq9jd/bpACivyVDfVteTLNEOFDKp07YdmOz4=;
        b=i+u88lggyD0FUx0Aw5YdC6FlMWIwKmjTz0CQAxZC09na69k+FV6jfYDGctcR7pnDOQ
         ugnh5cidsyOLNlca5iy4TGzmf9Xi1ffqLnpmvXcchggBNiEGWJnUquv3LxyfigdxIpHN
         t7nx4MEgqDNzKbS4h+d8e1PqAF6yULFgUKdda3AJgWTP3lN8HNsp7BIr9tGveYHXpYaV
         tBSPqfXcqtY+pmovM9RtUBW/FmEzGg0wtJB8DJYPpy7o6F8cX1b0NiK8/GQ3L9jGoBXI
         81hICY1uJk2yzz6h4QVyexrXGeP48lSEtxLzkP62geCb8VD/2o/5jE/gAEbxf/9t3YYp
         M7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775448; x=1731380248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sS3CMf4Kq9jd/bpACivyVDfVteTLNEOFDKp07YdmOz4=;
        b=GepmZD7NFg1vkr1N70wR6Eha7Z7CBK65p41FOUwHGI/HZUGVIgArQKs8jNTUmbB/EE
         ovfBP9mU7UNm+EiU/7eCcuf6zErXVqRUI/FBzoCfqUVe61uipRGt4OGUWzO8NU2kvM7o
         VeYb3OtHFivBGFQCcIfFHJU4coj/tzuu4LDQu9GSmqiJcigjHJnqFugMkwtfVv4YHQhz
         FzC03cDFLJRDmx7Ybfsfk9zSPRBbl3PtZ/Ml5IYiH2oenP+6eyQVtjhOPMlmPg11msb6
         1bgWLnD0oXXtvx25Kz3uUX3B8lHxhcuvT9JfUukU5L1SpMP+2r+fY8BT0XNDD6036JgN
         DfCw==
X-Forwarded-Encrypted: i=1; AJvYcCWoP81wi3noIxNhCu0QGPU7YrucvLt4l4rYJr0mBbEleq4+RUgLNi9x5ZsjvaBI4po766tFx9diufr8ppE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZwFYWR5d2oGBTJlFvFSvOpuiDOUQ4Ukt7OYAqHNiK9ri5pNl
	ZMc4zv9yaPhVa5HzpRR9jNeO8WJaRfFNJfUF2VacG/plAdbTdLFiZF6FfqIoHuqeM4oZ7Kenjxu
	gjxrEPCMTV2NFobZ1gOZoDUHVKa2Eb9vFyxxDv5Nr3kFjUnkgL4Y=
X-Google-Smtp-Source: AGHT+IEUgmRA9k4E2NWll724MZRF5057DH3TEbo3DZCREWtQaiV9UgzAwBetdTmsALt49U8N8vIwu8RkJxjhSFYYVzg=
X-Received: by 2002:a05:600c:4691:b0:431:4e25:fe42 with SMTP id
 5b1f17b1804b1-4319ad24a5cmr303575495e9.32.1730775448507; Mon, 04 Nov 2024
 18:57:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101095409.56794-1-songmuchun@bytedance.com> <ZykOfDWLjEB5Sc8G@slm.duckdns.org>
In-Reply-To: <ZykOfDWLjEB5Sc8G@slm.duckdns.org>
From: Muchun Song <songmuchun@bytedance.com>
Date: Tue, 5 Nov 2024 10:56:52 +0800
Message-ID: <CAMZfGtU3sN5y7DmYz=e5DtUk5ApvUsA9qJh1k__zpMYagZ0JbQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] MAINTAINERS: remove Zefan Li
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, longman@redhat.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zefan Li <lizf.kern@gmail.com>, Zefan Li <lizefan.x@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 2:12=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Nov 01, 2024 at 05:54:09PM +0800, Muchun Song wrote:
> > From: Zefan Li <lizf.kern@gmail.com>
> >
> > Not active for a long time, so remove myself from MAINTAINERS.
> >
> > Cc: Zefan Li <lizefan.x@bytedance.com>
> > Signed-off-by: Zefan Li <lizf.kern@gmail.com>
>
> As Zefan hasn't been active for a while, removing makes sense. However, t=
he
> S-O-B chain above doesn't work - if the original patch is from Zefan and
> Muchun is forwarding it, it should also have Muchun's S-O-B at the end. C=
an
> Zefan send the patch himself?

Hi Tejun,

Thanks for your reminder. I'll help Zefan resend this with my own SOB becau=
se
of inconvenience of him.

Thanks,
Muchun.

>
> Thanks.
>
> --
> tejun

