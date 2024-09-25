Return-Path: <linux-kernel+bounces-339263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193C39861D2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4C928E156
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E865218E368;
	Wed, 25 Sep 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBY8xy98"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC65118CBF1
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275046; cv=none; b=iHFLguDtdVZDKcZs/4hGW6qP/Jht70SgVm7h8No2LigNXcK5f4uGhpsF8wgw49pP8JOp2MCEd7+meydzyQwiyNsWg3n2vMR0BkLLB5xcBj7A/HU7UILsSNhhL5dZjxcC91m6AopuZRShGfJhXg4ue/SOgJ9EhE0C6TCdkSTw7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275046; c=relaxed/simple;
	bh=8PiLboULvgPjx2PzmyGC1ZsTIdEwAt46+hFEoVXGiDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzSwP+9VtoVVTnSrg0YYfypPk+1dO/vuvIKHFFoz6e3WC0PgjjY6HPewIjtMc2aeqZTbAY0SW444RLCsPnJFDBiDHoDlRgTQrfFTsHBQ3bqKdfLS1maPOLtjsUXLdgiaWLQlbvcGd3WpkIXIJsbQQGSeDDlLmHViIJDelUlMD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBY8xy98; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e5568f1baaso3658331eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727275044; x=1727879844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PiLboULvgPjx2PzmyGC1ZsTIdEwAt46+hFEoVXGiDs=;
        b=XBY8xy98yHB2xgrRyLAqvq51L2qtE8cJZbCWVxpjrFx2/clQWaRrXKLofFcRn70All
         VbY+piKJQJnZgrd1hhKwWNw4F9FwONGXpKabBfm+lf5CSh72pxsDl5TvKGkiym9GBtCM
         9b11w3s+4MEejS11TdY4eAMANdalp8txpIRNpEcE3Y1OAIPQbo8cgMGRIow+gs0U1QoJ
         zYW4NIcUBd9CQTjsTG1rBylunPipkbLImB8/9bPOpXtQvFEcGCNoU+GMgsTsXzbExxLz
         WosnST+pVDnOoAMZg5sIgvUaTUU2xtwjNew7BdYK1Q8E8MVlwaj/u8VN4MUQcLjWjVR2
         8vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727275044; x=1727879844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PiLboULvgPjx2PzmyGC1ZsTIdEwAt46+hFEoVXGiDs=;
        b=hrTt5kuZiSCi0tVKU+cKCvSu3sTHZVFJp+gtgWpyTZF+MDi6L6daeZEBHiVGLId/Nf
         yJZ5A1lyKkcRWnqJGNaHXV4nGbN3PUy7lr5iLa+V77CM4Yh9rMdHI7USR2MurQbCV1UE
         NZCmbXtb7Vv2cIxvBd0i4mrUN5ON20bh8csvc228zt7LLiUoHZEWWq8quF5ib94UvrYV
         AGjU1ctJo8OoX3491s1jydf6Q5DljBCF/6Xsg7PHtS6w6xMgoRsHpVooRBZzU4fyNSjn
         Q7RGcJG1szRY792fgkF1KOXqM09h2MRcdQaCFYc1DQxYgVrroxXpOw6TE3467T8lwvtD
         AE1g==
X-Forwarded-Encrypted: i=1; AJvYcCWatdiwST88B6bgRYTFrq0lPcFluQIT3UbUN1nO9d6hBhtCgSjLLAc1xp9NY7nnmMJfZjznKmWTCXJ1r34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4d3GHn9hsTGSnJzT2O32vqq8bEr1V5BL63sAEP+14kqNlQEGx
	6nL9SBml7mWy1PwdWn8s4oGDqlOlZTm6lF3Qr0AHV2xy9MBVAcKRZHBOwaLVcq9OWqUzYM+dmU4
	0PjXRRbCheKBHr5M4WHoAXIpJ2Rc=
X-Google-Smtp-Source: AGHT+IF0Q3lZC6ywtVQophx5osH39ILHSdIGAQjW2h27zHlmy3uLazIw0hpP6N7UQ+p79C95Ds1z3iruleoAhsuBcX4=
X-Received: by 2002:a05:6358:6f07:b0:1ac:625f:9d4d with SMTP id
 e5c5f4694b2df-1bea865283amr220720055d.23.1727275043788; Wed, 25 Sep 2024
 07:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
 <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com> <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
 <CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
 <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com> <85a2fd61-93d3-4cd9-95a3-e9eaef87286b@linux.alibaba.com>
In-Reply-To: <85a2fd61-93d3-4cd9-95a3-e9eaef87286b@linux.alibaba.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 25 Sep 2024 07:37:12 -0700
Message-ID: <CAKEwX=NB-vf4zTTJ2KaRFGJmcfeDQpLLuiX=Rh6X+49ib8S=wA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, chrisl@kernel.org, david@redhat.com, kasong@tencent.com, 
	willy@infradead.org, viro@zeniv.linux.org.uk, baohua@kernel.org, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 6:53=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
> One benefit I can mention is that removing 'SWAP_MAP_SHMEM' can help to
> batch free shmem swap entries in __swap_entries_free(), similar to the
> commit bea67dcc5eea ("mm: attempt to batch free swap entries for
> zap_pte_range()") did, which can improve the performance of shmem mTHP
> munmap() function based on my testing.

Yeah, the problem with having an extraneous state is you have to
constantly check for it in code, and/or keep it in mind when you
develop things. I've been constantly having to check for this state
when I develop code around this area, and it gets old fast.

If we can use it to optimize something, I can understand keeping it.
But it just seems like dead code to me :)

My preference is to do this as simply as possible - add another case
(usage =3D=3D 1, nr > 1, and we need to add swap continuations) in the
check in __swap_duplicate()'s first loop, and just WARN right there.

That case CANNOT happen UNLESS we introduce a bug, or have a new use
case. When we actually have a use case, we can always introduce
handling/fallback logic for that case.

Barry, Yosry, Baolin, Ying, how do you feel about this?

