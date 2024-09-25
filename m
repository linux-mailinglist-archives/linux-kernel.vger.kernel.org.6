Return-Path: <linux-kernel+bounces-339243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814C49861A0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4854928AFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBA817BB7;
	Wed, 25 Sep 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi1Lzrkl"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DB1AAC4
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274553; cv=none; b=Ly/L2M8vbpX1Al1u4Q+mPyIXCzc/O76pAw2VHpFqVweLmQ/eYMjDi0Eu0wM6VVg8Hp3rJXB3xBQttG5KzMvz+dNkT/NDFn8RO9QcvUVOoVFNx/Sn6qaIHL/XSlweULZGo0gvAhSFsgIujSi8wpBR6fomQD1wuO4rfDtCipl8/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274553; c=relaxed/simple;
	bh=xUQYJ75vXn1lLVXVNdsC5J0RATkg/QsIAKyS6ZPN07o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjoDG1764t/hKQIvoLUkdpyfYd2N0Q24T9EWzz+GJu2Jm7A/6nw305C0ZmGGHi8YgiRErCqh8RRGBWYWh6IM7aslMqSit4Y9oOYPTb2RsRr8O7lxm1O3iVelBxqZgbOg0YJkXSUej1Fy9OawtlfBq38BnhxjIK42E9QJfUBsBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi1Lzrkl; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c351809a80so48396696d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727274551; x=1727879351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUQYJ75vXn1lLVXVNdsC5J0RATkg/QsIAKyS6ZPN07o=;
        b=gi1Lzrklp/k5UTWvup8FF7CFwkEz3jMHHsA7GW3PfNqvDWcLJACXH97ei/KfDDwLHq
         5XpfV+HO8wuV1iRZRI/RMxPlkRiHPT5u3OruQFEUQ4kQzfZSexshm1twzdHFaB7aW/dX
         6rKjA/mPLNUcNoyKquc1eV0B74IbuDkpAXZV7nFeBQ5GM3bKuwLmiNpWSvXkEsGDmLEJ
         Oj9cWdYNhKqFbEGJ9PexEhrAllwX/7yjV7PtnpN/E2Ku4JGaMgpE00gWL1DoePySyUhE
         UbO9mXgCjK4l1AsmyqYGVbeegQSLOyFrAszfzBLkivCrbV6hCXUb5qQh8BP3WNkwch/p
         yUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274551; x=1727879351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUQYJ75vXn1lLVXVNdsC5J0RATkg/QsIAKyS6ZPN07o=;
        b=aVp9clktOJfuPJg6IIvDxSqIfjUa0HR3B37326k1oAoRPKIrtwihTtRg7O4gKpBafI
         sqqXW9eB0GnUrt7ZvkQgkWg336zepEc1Q1yHO0fHTTtRD35raoI1QpcOsou4V0mALOgF
         lB0Wn1jWCQcSClOUdEfCmPuqSurQd/KLsD4UEavnZR7JKSFTZt7qhlpL4d3AeqTBwnex
         ATLLr/ozUZsSztgQpSXcXV22JSlogI6WQrRoL3yMqx4e6y4dP43lfs+jtSD9/E5gTzih
         RdUGk8dL73ahEFrfnLU9Mf8gUYV3whcajnhSzfEYrdRy4cQkCG2Ou4HMKNJlTb7opHUm
         Kd4g==
X-Forwarded-Encrypted: i=1; AJvYcCWAj275tc5e1KqaTXNP8b1xSYgPdSHVUp4EvCRjFj6HXX6k/RtPTKBOSj+UgYplUdIvASeap5KwZqsI17A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy63mqQS7o6Jdd9dUYmqD9aAVSFOUIMLDc9oQ4udGv0a957AbHF
	czm75iN5moH+67qsixq5By/mxsAi2o6KM2ZhKtf2lxplPcEzGHataIY1R+JSrWtQCnWTBf/M1Ap
	dTFpDMk9RFgd+d1AoRCGeE6pCzPY=
X-Google-Smtp-Source: AGHT+IHGx8Ulcf5JyspZf37Tqz9M7joMNTp8Z/DRQsZdQXRmnrjqEhkPVUefdfbJH9Fk4VUq4OM5xcOR2p8/786qqb0=
X-Received: by 2002:a05:6214:3213:b0:6c1:6d4e:535c with SMTP id
 6a1803df08f44-6cb1dd0a7afmr41846946d6.4.1727274550719; Wed, 25 Sep 2024
 07:29:10 -0700 (PDT)
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
 <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
 <87o74cryhu.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yckKO29b-BtTHazJEcf58R4JaUkTYZbhNDByLecqJGGQ@mail.gmail.com>
 <CAKEwX=NuRuu9qXA9mRMqb6Okcwa86mEkp2Ac8sQjwb0ACdS7YQ@mail.gmail.com>
In-Reply-To: <CAKEwX=NuRuu9qXA9mRMqb6Okcwa86mEkp2Ac8sQjwb0ACdS7YQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 25 Sep 2024 07:28:59 -0700
Message-ID: <CAKEwX=OtpnH+i4FtZ66HPoe7zRRtEBuMbHQ9+LW4k5yLK+yHNw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Barry Song <baohua@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, hughd@google.com, shakeel.butt@linux.dev, 
	ryan.roberts@arm.com, chrisl@kernel.org, david@redhat.com, kasong@tencent.com, 
	willy@infradead.org, viro@zeniv.linux.org.uk, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 7:21=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Wed, Sep 25, 2024 at 12:33=E2=80=AFAM Barry Song <baohua@kernel.org> w=
rote:
> How does this look? My concern is that there is not really a use for
> the fallback logic. Basically dead code.
>
> I can keep it in if you guys have a use for it soon, but otherwise I
> lean towards just adding a WARN etc. there, or return -ENOMEM, and
> WARN at shmem's callsite (because it cannot get -ENOMEM).

Oh and another point - I plan to rewrite this swap entity lifetime
logic in the new abstraction layer. The swap continuation part will go
away with it - I don't quite like the way we're currently doing
things. So this added complexity might be unnecessary.

