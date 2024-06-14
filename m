Return-Path: <linux-kernel+bounces-214477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E1D908545
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE77E1F26DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A151487F4;
	Fri, 14 Jun 2024 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZFkYw9v"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E9393
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351209; cv=none; b=eluX+m2pieixuuydiu6TScO5ekLAku/qriBrmRcP6CRYYfEuykLQoSkknW3+/5xAvcPu6aDt8Z7rHFPwnlZCK3I01sgupulDO216D0wR27OGM9R7ucjewgacd8IB1vxy2/ydgbgKOpMFwelRkSyOCF1NThYvM6Pith2isHpASW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351209; c=relaxed/simple;
	bh=sINVLGrn2l3nObO3lTzserdUkLo1bsT+2+A9FNq5GHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBdhwWZLMV73vpvgOJOuzeCSGhE5HvEcdH04Q/r+Q0ZMoz2jPnHTr48Q85mHdHpUYPIAbrrGg6qgGFk0ODdz3RYDoZs1GSMwxQRy1aJ24vxoulLP7t/x2NqbTFD1fWrjGrhEH7Mo3xERx3npzhrmsQQfCoydh3UquoSNmdf1kjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZFkYw9v; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c714a1e24so1953935a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718351206; x=1718956006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sINVLGrn2l3nObO3lTzserdUkLo1bsT+2+A9FNq5GHs=;
        b=WZFkYw9vSfVm8Oly+numXbrokESxfP4MctVxZzgXUyw9/ORfPDw5BkMPLPuX1Ex+KY
         oYKZWhnxQjxVURIgNVd4ThXcv5rAwAMrsdxFkXvN8VzEsaAbIqlcQDWh93Sf9eLj88Zb
         j9JUuXU7eBEO9qg7m1bJB0fP+9Q54LvmC+VBhSj7BdbgJYFUic8SE0Tmm8dSbL2c2XnP
         GLVtqTsOFhtOrECJ84MUhQ1RuOLMHppyj8jCYgbX+OhNPqfGrnaf6VReuYb48JAE93DI
         uBVfhsQa5XsdkdIPANdHnA6tt0nakb2JQdEf+14yY7SbtDSF18QBkJnZakB5aD9IcId9
         7OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718351206; x=1718956006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sINVLGrn2l3nObO3lTzserdUkLo1bsT+2+A9FNq5GHs=;
        b=Fg+CKEDTeMh15RRMoS2WqY7WNhAYZoX7C+s6QF2HdQHZcmjpdlEeXdiXknu2ISvPWL
         VDFA/KnJeb+26KVL62KZSHfuuJJwqltqjP2y3myG5tVKSTTLs5+luxKdVaY1EmbHzJo3
         gHeVO4CpuZ2BkldPJoVFR0BgZhdBqA3oj+9n0pozNMJxnjroKlaCBbai3b9PI2wDPCXS
         3yztkr9tw0Ws68cnafJyIf28LskNx64RUYGurDz2zdn9zZO4YxdKANj66JYfjOV4i07R
         Hal/694Sc0JuYvJfTmhhEUABIb7gOuFAgSZKXWN6Oepw+bMjhDe8P0kUrfv221tuDESq
         eATA==
X-Forwarded-Encrypted: i=1; AJvYcCVjoQvTLs1gX9OzgtdKn2eiKQJ4aA21mtcGkAfOQwJCUpSSbCONqF7gVRRbajHX84OVlUWnpvJWptjTLHIxocpLbZNiJR23G2LJZbHt
X-Gm-Message-State: AOJu0YwEtgTYz/myOFwCgsdO9P0/6QXEgMqY0tHHZRQpKOHcvBUFU7yj
	/veF0M7Avqdj9WckdPlhNw85K0mefSBikIMOQAQYeNfC+ieNLgWO5MWBpox1QZ5ZoBT+y0p59bf
	02ZA8UxLs3xjPDZQ3EU1UDcJvmlE=
X-Google-Smtp-Source: AGHT+IHkgCG4131CHp0LXyXkxosqyByTHmrFjfdkkkIR+ZaUjnuDFp+AdcwdUwSsgBABzH4njOXb6DjQ1jZUjBggOFU=
X-Received: by 2002:a50:8746:0:b0:573:5c4f:27a8 with SMTP id
 4fb4d7f45d1cf-57cbd8e7144mr1297235a12.35.1718351205549; Fri, 14 Jun 2024
 00:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614015138.31461-1-ioworker0@gmail.com> <20240614015138.31461-3-ioworker0@gmail.com>
 <24765af3-2f2d-4451-9d9c-c35784ae95c6@redhat.com>
In-Reply-To: <24765af3-2f2d-4451-9d9c-c35784ae95c6@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 14 Jun 2024 15:46:34 +0800
Message-ID: <CAK1f24keXQbx8jh=Jd27mRk4Km-viyMLcQh=VqReG7LLzYCCXQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:34=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.06.24 03:51, Lance Yang wrote:
> > In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> > folios, start the pagewalk first, then call split_huge_pmd_address() to
> > split the folio.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
>
> Would have converted that VM_BUG_ON to a VM_WARN_ON_ONCE, but it's just
> moving code, so no big deal.

OK, let=E2=80=99s leave it as is for now ;)

>
> Thanks!
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks for taking time to review!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

