Return-Path: <linux-kernel+bounces-252937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B563931A22
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD2B1C21634
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A057274070;
	Mon, 15 Jul 2024 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEwxHEHZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CD12AAFD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067297; cv=none; b=usjBQO3ZgTrgyRnqoacmqR/ljAL6E69v3TrzRL6nuIuB5uuU2/MVnzR9evBqr/UPwMYR+SPKSmX0gZinKmOhMvu5DIBumrDH5dWXwkmrOg5EZYfPkGSDVi3D3PiHQMSMJ4ZBoYHoUGQB3DYOZ3FoKQ6v5sKldhRmBISe5+TLdAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067297; c=relaxed/simple;
	bh=pkG7Cs9FXIoXw0oST5k8OaEYVti3bYwd5melFbuPCFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaxDPHQTJOVQqfnSvjMd/s7Tx/t74RRRHJUT/jIkmWTgvEz4dxwG8/0vqkvUj381/Na0pdpFhRGg46O8m6ZsCA6ExLLg9q4xfh/3q8aMQvnbrAVUqOVWR2w5C1Aul3NAPb27dNBYdafdyF8sFXgkOLIMNL+UC0tAG0ND6ghJ/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEwxHEHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811C5C4AF0A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721067297;
	bh=pkG7Cs9FXIoXw0oST5k8OaEYVti3bYwd5melFbuPCFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sEwxHEHZno6EWtsRypvMBn9TitxsBAigzrfFrFmmIjEadcW4OBnqJMlzFCkY8g/L6
	 n5glmxExyaYc9P4zJ43Zj2c+RruuAvOvA34tNG7TVwioZDuucWlQiiff5+eUBi4FgT
	 CmY1k6PIqYIcbtH3X8yGQxCm3prdKg///4GEGPyXmLVR6jf3eSMjrp93lokyhLRdjT
	 kkQCco0qP1/H+FkA30beIkVA4uelF5rSgFgsbTh47UEsWNNnlJVRRMX5nPLCI1q5og
	 xgIBieb751oPpjx+aMvf79DKmWLzx820HyQs7nGWu9pgp32GWr3q9v6BYPOjj0YlFJ
	 5E9GzNcakiN4Q==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-65f9708c50dso20506217b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:14:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXX9l3/TT+djx8puei7qf7ytnNkIj5+7TPPcxlAKwo/nOvSHfQ8ZMRr8gb+lbat71vOsXwUtlgPgfaDfqUr4Fnx+dxPHTrdOibuUfvk
X-Gm-Message-State: AOJu0YwDcbzN79luFIFhDv47+pW71j34Sqfs88FV8r1JFHeYGwraOq2F
	8dNaX1nELHtPQMIHG56wN+YZ78zx00uCjxZK0Gw3yPOes48niYfN+lEgMMmny3cqvbaDxuUEweR
	2jf2BVv/qB9SWDGwGfJys78WXES3e4VBRsc40pA==
X-Google-Smtp-Source: AGHT+IHN6aB8kpFHIkwT0wmPtPe+KZzaSCHN5poijt1JLe0tZYufOAZaDskX/p7CIDQSZEPTg9FznNilUurHC4QVIN8=
X-Received: by 2002:a81:c248:0:b0:644:2639:8645 with SMTP id
 00721157ae682-6635497ab0fmr3301967b3.26.1721067296826; Mon, 15 Jul 2024
 11:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
 <ae6b4885-0590-4585-a1fd-39b64df2f902@arm.com> <CACePvbX99r8BNZTkax=KGBx-XYP6WLxZKez3qsi+FfreC2TwGg@mail.gmail.com>
 <96965a23-49ea-41f5-a4b0-9b5296dafe00@arm.com>
In-Reply-To: <96965a23-49ea-41f5-a4b0-9b5296dafe00@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 15 Jul 2024 11:14:45 -0700
X-Gmail-Original-Message-ID: <CACePvbVufm1=hwZx=is7XxrpVvJnYES4QPWvrsRZM-Ci7kDPNQ@mail.gmail.com>
Message-ID: <CACePvbVufm1=hwZx=is7XxrpVvJnYES4QPWvrsRZM-Ci7kDPNQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] mm: swap: mTHP swap allocator base on swap cluster order
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 7:10=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 11/07/2024 15:08, Chris Li wrote:
> > On Thu, Jul 11, 2024 at 3:02=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >>> Kernel compile under tmpfs with cgroup memory.max =3D 2G.
> >>> 12 core 24 hyperthreading, 32 jobs.
> >>>
> >>> HDD swap 3 runs average, 20G swap file:
> >>>
> >>> Without:
> >>> user  4186.290
> >>> system        421.743
> >>> real  597.317
> >>>
> >>> With:
> >>> user  4113.897
> >>> system        413.123
> >>> real  659.543
> >>
> >> If I've understood this correctly, this test is taking~10% longer in w=
all time?
> >
> > Most likely due to the high variance in measurement and fewer
> > measuring samples 3 vs 10. Most of that wall time is waiting for IO.
> > It is likely just noise.
>
> OK, that certainly makes sense, as long as you're sure its noise. The oth=
er
> (unlikely) possibility is that somehow the HDD placement descisions are
> changing, which increases waiting due to increased seek times.

I sure did not change the HDD placement, if the HDD allocation is
different from the previous code, that should be a bug.
I mostly remove the cluster code path in HDD swap entry allocation.

I did the HDD run mostly to make sure the HDD can still take some
stress test on the swapping without crashing.

Chris

