Return-Path: <linux-kernel+bounces-389746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C56A9B70AB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216AB2829B9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643FB2139C9;
	Wed, 30 Oct 2024 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/b+Wjqt"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6719CC24
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332017; cv=none; b=aRL8KxoEAEH3gFOJGezdhd1DyI8v8paV9k2QKqZrgMOyURtjU3KOGEQb/dQ/XiWnDSOEHzIHFnhalQ5VLqBWNA/QXzue3rswSrai9y2kQH4H2MZ1BOTsCdhW+sDYjFTs2+Qm2wPJ7ZhRBpPINH79agyG/AO1ICpPn6Zot+HuaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332017; c=relaxed/simple;
	bh=JxxsNU53UcNAVBL4Y6O1o6y3dqfrBgqtcELYCBO4G/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8nqMhKRWZVaNIapXbaZIDJYKMQAQ0AiB6i1V042yB2Yf3VfkBN+AmV2SfRuscAJrvPe9Wpmzrht8F9A5w+9bzQoj4sHp+nhgl4wePLqoaQ0EkUyIyMEufwwZl+yqfSvds2G1qg0kGPeYjFNvau4C9Im/LuD7sqi588QSdibKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/b+Wjqt; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ea50585bf2so3777247b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 16:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730332015; x=1730936815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxxsNU53UcNAVBL4Y6O1o6y3dqfrBgqtcELYCBO4G/0=;
        b=h/b+WjqtXy4fvD+JYN8TMobFnpUcwAhHDevsfUEu+JGjPEnjaFfnYwsvOKrJXZpSR5
         ZaQf3YZ1bDSRewuK3ZUf/JQFwrHqWTZ4mMEAiefmu0hmsFU581byQLa5J5OW9fCza4gj
         AfE+4OqTiX26u9aCnei0pukgmVBQPX00g1kNzUubfA57peUeOK9tbRXlxD2jIpuSxusz
         BKiB//Dl7j3JySvGPWmJ4+IRFKcBAkNvEZML415DhZzUce3xMDMPdasK5I+/exxTMwRS
         L49PtnRyBN3S3GyavSUDWwDAb7bPYF1G5g7wyYxBwH4X15srkElxjRG9bQc5j6bdimi5
         2sWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730332015; x=1730936815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxxsNU53UcNAVBL4Y6O1o6y3dqfrBgqtcELYCBO4G/0=;
        b=kbFHZgfYfiLS99TYh3B4fFiSD443vqtFW4GWrGmq5UAsMKmLnO1/bY0X/Rxi+ZV6Is
         42hpvLXffSnErVtz5sHLCVIhabjwqdlzcrOTL25CzzzJW4E9WcF8mVrwKpZG3XR7Ho5F
         CjVab4HyEpFJAYzbvnGZvSZTutgtz+sIJF93cnNwgB047220vQlj0OA3XK4B5SE7iIpv
         N15Dc6dg9D0qxcEibupgLbhr+tmXNUfZTFUeAe7w8URu1JSMhDEonjgZ16pAwSZLsx4o
         8CqufTksSS5aR+SGoIa70NBmqQJBkTUidjF0KljuiERuDOjNCIDlLbFLs7t1taz8IhP1
         FsAw==
X-Forwarded-Encrypted: i=1; AJvYcCUEBTLcxB+EuRAn1aK6s63zvHwxwYh7jgdMq27hpNawTP6llFUJ5BgSP9d2R0RP6nEExpdqpESEh3yYv2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgH7a+Tjs73wYQlODt2NzCyjXmqwIYfSjZEkONObxI7YrLokP+
	NNEWdiMuuiv6mK40v5edvvqCzbNWvLJxTdjzuAQuU6SnQfU6os9lTfY+UU4I52/2vPyWBS7SQqV
	czJDGvx4LrcGrkKOiqUmYYhOPCjYpoA==
X-Google-Smtp-Source: AGHT+IEnGDWrZk3WbRmXAp5gThOCpZsfSHeNDCXJ4iLQky8yZhGaeXt5H1Pq//zxUA4gieE8WAaNzb/UHL4BswD2pW0=
X-Received: by 2002:a05:690c:250c:b0:6dd:d85a:15e3 with SMTP id
 00721157ae682-6e9d8b88b17mr142411147b3.37.1730332014912; Wed, 30 Oct 2024
 16:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com> <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com> <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
 <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com> <CAJD7tkZpO1nEvdh7qPWt4Pg=FU1KZfEd3vA9ucEpqdc-7kF0Jg@mail.gmail.com>
 <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com> <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
 <882008b6-13e0-41d8-91fa-f26c585120d8@gmail.com> <CAGsJ_4yBkry-rw75AciT8OiYWrw+=D0okcxiyXzzNrz=QJxiBA@mail.gmail.com>
 <cba36cb0-66c7-45c1-97c3-a96ea48a6cf0@gmail.com> <CAGsJ_4wXO2Hjs0HZBGsGegBAeE8YxJbCF6ZXQQ6ZnVxgR82AuQ@mail.gmail.com>
 <228c428d-d116-4be1-9d0d-0591667b7ccb@gmail.com> <CAGsJ_4zLNA-1+3j4snNLiujT3NLcmKEVFA4+eD1Sk1bOkqAGYw@mail.gmail.com>
 <03d4c776-4b2e-4f3d-94f0-9b716bfd74d2@gmail.com> <CAGsJ_4zRZFpJ0rWQ3XzspfSXN6xXN4eftCdL3xHPTqqYLUhQcA@mail.gmail.com>
 <CAJD7tkYPB=2c23LMi1+=qrPO+rcr5zJB4+2TPrcjAZHhsm=Vsw@mail.gmail.com>
 <CAGsJ_4yxoBVEY-Zpp3YNbiCCwbKO+v3-9R984uGVRHAtMSLDLQ@mail.gmail.com>
 <CAJD7tkYmBgp5WK9pD=ap=WuqWiiHvEhG0N0J_TiYdGRNaxwLVA@mail.gmail.com>
 <CAGsJ_4yvWjkYNXu7+FkovEA3RGHu31g1DRAYtNdoQYKhnWcYwQ@mail.gmail.com>
 <CAKEwX=Mxh+G=6Yq_gSuSoB3XjpGepYEGPg-eYh1RU_690tGedA@mail.gmail.com> <CAJD7tkZWVUsQ0iq_kbpszJGtwXj9g=6A3EzxcB52NKBcja1MXQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZWVUsQ0iq_kbpszJGtwXj9g=6A3EzxcB52NKBcja1MXQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 30 Oct 2024 16:46:43 -0700
Message-ID: <CAKEwX=MHdrDGC1b1ehCmJzcjOKoy-KN4=sfY-7Agf9iDbXcoXg@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 10:55=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> > FWIW, the swap abstraction layer Yosry proposed last year (and I'm
> > working on right now) will allow you to store these zeromapped swap
> > entries without requiring any swap slots allocated on the swapfile.
> > It's basically the same thing as swap/zswap decoupling.
>
> I don't know if I said this before, but thank you for keeping this
> alive. Much appreciated :)
>

Of course, it's my pleasure :) I'll be sure to cc you when I send the
prototype out as an RFC - your input is much appreciated, as always :)

