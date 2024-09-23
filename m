Return-Path: <linux-kernel+bounces-335672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A5A97E8EC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841A81F21DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25319194AE7;
	Mon, 23 Sep 2024 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EziHmyyZ"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A631946C7
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084486; cv=none; b=NWMptXatZmC+tsqycc8QcokRhFdUeEzFx4k37Zqv9dquXwScjUxnrcg7MWq6NtdBxiZcKN2507IGxckR7Z4Kg0i+uU7FlS0UIsBDGYCSOHDtDu93tweJ6txmsRjTB8+9lFLOn5t4RVd1rlnoEGDDV0Ynrq4ZexNCf8bCin+WNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084486; c=relaxed/simple;
	bh=BrAPmjItXRv7X5ThPou8prkegS0mJXmWRnJB7lWJDVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCJGveR4LwpeBWRpA6VMcVlkvU4PmhRGb7njsuRWaOP4HyW6CGe57cjvZLXsV76BnURywqtUs7/oLUY1FlE6FAX4dXuayn2AGFNbU1SJAtkuXjQ8lX8lT/APXsTsDJdLZzZUb4gabBxqHf+Hx7bkV/9EbQ/fC4vZqVYC8eMHzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EziHmyyZ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1dc358d6aeso2965701276.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727084484; x=1727689284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F91xt0V7YuKpig7zsWEYy6f7MzxzaBrNwG9NU/F/mWI=;
        b=EziHmyyZjx5ucBeJCtns/LgTNQJTBt8b8tdBiu0WYjnMpPMY07VTXaB7nCV/zEf79i
         z3xa9JZWviJYRyYfq3TN+2hSQ/aBOYSItXwsZc/5Icf7cyYG6G2yngxPlGq83aPqZ6Ur
         psX9zB6OtoaD4pn+Sb9058EUEY1TzY6kEM9feT/Sq+yWc/tDD1FeG6jnXtJXeKQ+nRLW
         Cg8euwqvjEjL6/2BMHLSvjhQQCB4V+mg5mwMJRfjXMbX6ukWY6nZFDlQ42sf9Kt6N3lk
         ul5mQRRnHQEWwgHQmxfIfluyvij5J5s8/6aiQY+foGJ8JRfHKaBkAKK0y1f+cRrLc/AY
         19/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727084484; x=1727689284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F91xt0V7YuKpig7zsWEYy6f7MzxzaBrNwG9NU/F/mWI=;
        b=IKvMjTgcJcLAfPXpyTPr0VfYMFoS9vUyxO1f/xP0HlK6bKRlhjnZPYBoU+NSEUe/bj
         fUml1Ne3qlZG4MfoaTXj5chAxCtWvyAAArm2eMY5dslI10V7sWazymEIotWLCpoj7oNE
         t1uf2JHjIaaMtd0y/8FvtIebNK/O2FmLUHiov88Pimi942HkRvzU8PoT2Wio5b/H0uFA
         dfaGeAC0Ga/N7q0mb6D0jqv8PCtuBP4fcnINWI1s4AJ+S6E0yBOl+ZOaHyPI1NpYtISq
         glB47UK6hBcmTcjRzJZzaukgnfdln6VM/IBoe2t2iFsrx7MFbyRtjdhRUiPTJjJ3AGPt
         wogg==
X-Forwarded-Encrypted: i=1; AJvYcCXCEmm4djYcL2AonWfPeJ7KECxyceP0B9IF9h//tk2OaXDNlhnAeWFP3F7Lw2md9dxcsFAzKUfgekoxt/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPeE5SxmvWnUorjRW6DrQ88i232RjmsQUS/bUEXq+/tj5QNeg
	fuFdqAdleQYs9j3vjL15ox0OLi+GLVRxN3ibOG8RNDV1gc1znJ26WlTdnQt8AC73RiKFWNaNvty
	JfH2zOnwIpLSAnmxS83OfmZZaV4s=
X-Google-Smtp-Source: AGHT+IFPbftLMsCem8+UtgNObpHXwT/6AY6KYSkVrEr1xmU8L2UE/AJxRqVhih56VJeyeUL3mWA2xo2bUWbpqLvxQSU=
X-Received: by 2002:a05:6902:1b90:b0:e22:4edc:25bf with SMTP id
 3f1490d57ef6-e2250cc001cmr8069977276.47.1727084484048; Mon, 23 Sep 2024
 02:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922164702.49615-1-kdipendra88@gmail.com>
In-Reply-To: <20240922164702.49615-1-kdipendra88@gmail.com>
From: Ming-Hung Tsai <mingnus@gmail.com>
Date: Mon, 23 Sep 2024 17:40:48 +0800
Message-ID: <CAAYit8TfBD40aRchLiOWsvqwpAR0x6nW9zObza4vLVzg93N+eA@mail.gmail.com>
Subject: Re: [PATCH] Return error code for failure input for sscanf in parse_cblock_range()
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:47=E2=80=AFAM Dipendra Khadka <kdipendra88@gmail=
.com> wrote:
>
> Smatch reported following:
> '''
> drivers/md/dm-cache-target.c:3204 parse_cblock_range() warn: sscanf doesn=
't return error codes
> drivers/md/dm-cache-target.c:3217 parse_cblock_range() warn: sscanf doesn=
't return error codes
> '''
>
> Since, the only negative value that is returned by sscanf is -1.
> Returning -ENVAL when sscanf returns -1.
>
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
>  drivers/md/dm-cache-target.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
> index 17f0fab1e254..c35d65e310d6 100644
> --- a/drivers/md/dm-cache-target.c
> +++ b/drivers/md/dm-cache-target.c
> @@ -3200,8 +3200,8 @@ static int parse_cblock_range(struct cache *cache, =
const char *str,
>          * Try and parse form (ii) first.
>          */
>         r =3D sscanf(str, "%llu-%llu%c", &b, &e, &dummy);
> -       if (r < 0)
> -               return r;
> +       if (r =3D=3D -1)
> +               return -EINVAL;
>
>         if (r =3D=3D 2) {
>                 result->begin =3D to_cblock(b);
> @@ -3213,8 +3213,8 @@ static int parse_cblock_range(struct cache *cache, =
const char *str,
>          * That didn't work, try form (i).
>          */
>         r =3D sscanf(str, "%llu%c", &b, &dummy);
> -       if (r < 0)
> -               return r;
> +       if (r =3D=3D -1)
> +               return -EINVAL;
>
>         if (r =3D=3D 1) {
>                 result->begin =3D to_cblock(b);


Could you please clarify how to reproduce unexpected results? From
what I observe, the kernel's sscanf doesn't return -1 on an empty
input. Even if a negative value other than -EINVAL is returned, it is
handled by the callers.

Hank

> --
> 2.43.0
>
>

