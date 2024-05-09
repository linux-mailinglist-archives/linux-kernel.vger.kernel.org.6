Return-Path: <linux-kernel+bounces-174757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA9F8C148F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6241C219A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD87770F0;
	Thu,  9 May 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kr3JPGOi"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A7770F3
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278472; cv=none; b=Ln0cuhctPbMOtEjKZE7KoEPJUb4bhPXxZgF23yYW2MZUsZg6PyaDdpjQxfr6lN9Tuna0JniKoOr4hOJScAthqlzspt4wQ0xyii+4AgFqsPZskBPe0U7CeiM6MoQnajeoKmfdUm8HDjx8Rs3ZGe6V9ShskFJlf03MzZ0Zwg1cifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278472; c=relaxed/simple;
	bh=YkVHyBMrNVy/mhlt5buLaXZgmPiU5YnVS2XKhBxY72k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVxur4umSzh8duvHRQ0Vw6leepuTUBlw6k8DlIfVhhsPzcpOVOdJ3+qDkDicq/svCyhVmry+qIgp19Pd4IAyD7UyqRFo8x1CzDWzQldfiWV+Kt0xVFRNx+nj8jLcJNFZSykQnIv/7YQFyavU32Fz+NyShVjEoEjXAyZCMqls7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kr3JPGOi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b2119da94so8209095e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715278469; x=1715883269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkVHyBMrNVy/mhlt5buLaXZgmPiU5YnVS2XKhBxY72k=;
        b=kr3JPGOiZtreb+q5PZSImrMaWUe9socviXLAWzEA1JL0qf8mZMfluXMSLdUz6NsHs8
         DeZ818hm86s64cXjh1aW12CEa6pOwV27coRnI9YPMMn5Qf9fKAGq0QmNvTPs9VtLGxbE
         TNsI21bXF0jo3sTJHgxk3jAIxiJ5rKcMTHc79p1ThwkmKg+DLNcCfrG9/yxapFOjLNH0
         aKOMRAAGCMsY11CgU9sNEiOme3ZQhusElXd6+HRFCK2CvZofn5JSJ8s7cEKbtRyUKD4i
         V6Gg4SfuJFjZa3AUIbEWgIMk6cftkodznRGPLAK/NvGlu9VjM9kE6F5tG/v1NTiZ2rua
         82gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715278469; x=1715883269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkVHyBMrNVy/mhlt5buLaXZgmPiU5YnVS2XKhBxY72k=;
        b=SkozeV+yEiO0VMQY4pxG3Y2LyyMnvO/rNyxaLceRzj6RABgF/X8Qu9UqEO86a78aRd
         mIunTBuQBHH0oDVLoyhzrqmo/exPQfFTE/b0aHASX9ewqdcY8soU4vwOhxhXsy8PwRWm
         f43GQgSB9gHa1WuLpoWS0pWSFMp0Aopf1bmD3WDcz8EtmDQyRyT2HspXCvFDz3UQXCBT
         LCTZsEx3TdtiHgITChsMiD18LE833h3LZDtQwmdma5xLz4o5L7oUy01Iy1BJw5HomO/Z
         4TWmrlrL/Rcc876sinlgM/ydp2J0pL7uAtReSnX+tbXq2xesEey8+dS/mRPrYn6eqs0n
         Y8pA==
X-Forwarded-Encrypted: i=1; AJvYcCXKiMbOXjkuWx37KHcpz+65xX9NBFvJ59BR4mRmJawoIr/tfcIKZKe8JxPl1OdCUgC+pJr9yD5VJez/qP/OycbmlshADz1q2YMrXqKB
X-Gm-Message-State: AOJu0YyE0GIo/1mwrc1uW93+9nLJSgdxgOlVWtTJsPUNUpd6OVyVx3hs
	0F+Z0vUp5u0cjaheTkI8Xrdj+qO5YYCHWJi7/s46Ng0tvejHgP7FTUMsCuZXWjlHDjVIkHnHFyV
	4nhKTdPG0BqklTW9HHCKf6dXjnha2jZzeLDOHkI/idDjOrIk6OA==
X-Google-Smtp-Source: AGHT+IFEBzEdjhOEiKmfPO2uLKnUu7B6VTjtb2JD+mFLsKtCP1/91pTQm4Kr4v+etrsn+JFIt5PnkJ+q3Hjl87Bdr9Y=
X-Received: by 2002:adf:e80b:0:b0:34c:77bc:6c51 with SMTP id
 ffacd0b85a97d-3504a61c6a0mr249933f8f.1.1715278469112; Thu, 09 May 2024
 11:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509100148.22384-1-osalvador@suse.de> <ZjzO4xH97Lu2UgEu@x1n>
In-Reply-To: <ZjzO4xH97Lu2UgEu@x1n>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Thu, 9 May 2024 11:13:50 -0700
Message-ID: <CAJHvVcjP6PS-m4dTTTF2MhDiaZ_U9WPfWO=JZZwGpHaA8o=qtA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Minor fixups for hugetlb fault path
To: Peter Xu <peterx@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Muchun Song <muchun.song@linux.dev>, Liu Shixin <liushixin2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 6:26=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, May 09, 2024 at 12:01:46PM +0200, Oscar Salvador wrote:
> > Hi,
> >
> > this series contains a couple of fixups for hugetlb_fault and hugetlb_w=
p
> > respectively, where a VM_FAULT_SET_HINDEX call was missing.
> >
> > I did not bother with a Fixes tag because the missing piece here is tha=
t
> > we will not report to userspace the right extension of the faulty area
> > by adjusting struct kernel_siginfo.si_addr_lsb, but I do not consider t=
hat
> > to be a big issue because I assume that userspace already knows the siz=
e
> > of the mapping anyway.
>
> Acked-by: Peter Xu <peterx@redhat.com>

Looks correct to me as well. Thanks!

Acked-by: Axel Rasmussen <axelrasmussen@google.com>

>
> --
> Peter Xu
>

