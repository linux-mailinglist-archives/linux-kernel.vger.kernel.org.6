Return-Path: <linux-kernel+bounces-301749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A2395F506
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD2B22220
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920B192D76;
	Mon, 26 Aug 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhdNq2w8"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC231925AC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686077; cv=none; b=YUQFGwpCbOzFGjrR+JyqgLAD3FM1R++f1UM4QlHOYBH1NPJpW5gH+AytmDs+ftvu3J5gIjseRn9tYa9SH9U8p9XHGSCDyEcjYbvKI+O31/33EYMWhDJGZUY6ngyX5PyvHXebw3uOsvMbDAEHaVS7sGaLgo4IS8ENV9cURngHLOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686077; c=relaxed/simple;
	bh=PlDtwrmO67SXZSYso96R6JNkvkJPe+Hy8yQ+q3sdLRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgcsS5wUC+w+WiL9pGMMEYUKuWITJOewTUCTeFnJlx6ssyKLU51Xcxap8gIa9VEWZTsWPj8Q+UEm5f6hL8Zlz13ZrqfvMKqc/BzObdU1YE8iLn/P9YqA5yr/VYHph0BhFjHLcw20qtR81l3OYhQmvskZGZ/iOquEk3MUjCSc0sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhdNq2w8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20353e5de9cso375985ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724686075; x=1725290875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlDtwrmO67SXZSYso96R6JNkvkJPe+Hy8yQ+q3sdLRs=;
        b=PhdNq2w8IFES8DNGV+4vvZlqRUFVbuCC4krQwtSDc6rW/7qQRI83ccH3pIJ6I3greK
         kkeJ/j3y8V93z9UyPEmEEK8Bqh84sjwQ/STw9K3shhIixer+tvLDLodmRKZ99V33lV9R
         kXasYLV2hXtUPIpQX7P4sG8I4yr4dSDx+6VCtjpPjzaQigOV3G7xC+vybXrUYv4mRHho
         2wWSWFU0CzU2w8kQAn0PIh4qt/k8244R/Gi79BLynoc3LakzHa9ICo3XGWOCRiXcf3ww
         boF+Hg+i0cnC0abB0niqYO+36k64745V4h8Z+CakNSXvSgs9z3Ydg/Ju0FAkVZTF6z9R
         6daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686075; x=1725290875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlDtwrmO67SXZSYso96R6JNkvkJPe+Hy8yQ+q3sdLRs=;
        b=NTyrYEiwh6DLcJh01mCLPrNAFm3dcU3AwuI/t4dYk6YaiaQ6K2mxmjBh6eDISI4Qqg
         8R1AAndDdGWHipLgTYRrRznDeTsqhWXXq237F/h0c/QOFOU3mqd8GaPkeeI+0O/S7l3j
         urs/rWyMqgzr4GBiihrV6KyXvQ+bfqogS1oklzDl9odc849vrF1dKbNisb0OyqQnMHdh
         5WateIvEKnbPrtZLo9Y7OabyLbsi9fZCMSen9Jq3ytNryqx6xb1DnlcdY2LN5/66IumM
         rV0IDczVwsN53tyvqCE02O+7+VX03Z+Pu2DhoAPCE5dCXwIxr8o4UJjiz+sLGDHOJNh7
         hxbw==
X-Forwarded-Encrypted: i=1; AJvYcCVhyUpckOszoP/gOyna/dIS7Pv9Yk/ghyqFQ7rA6azkVoNF6+XGHiBkdzWXY/wZ7SZvXNo6elq6j7fmiE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rQA4zvpU/357jYqsDxjbQ6NebGxVmHKBKXaNozjP/uw3eTy3
	NNe1MdXAWHVIC2xLUp/1KMMAkV1Yu/5p1vFDtsI8e7qL9oGvLWdocrGCJEXUWG792RNqYhnPtnQ
	Zhi75uJy+UD272NGG+IxZerOV5sxDrBIVKeKE9F0jPwC/TtHvhLYt
X-Google-Smtp-Source: AGHT+IGN5DBP24a/7mKtrKEqJPn+N+T83aqJq5dqW7XBD+MjYknWEHtMVhWrRiyu7FJVUAAEzvhWCOIEtivgIaOV1DY=
X-Received: by 2002:a17:902:d4c8:b0:202:51e0:92cf with SMTP id
 d9443c01a7336-203b6c24ec6mr4628665ad.1.1724686074817; Mon, 26 Aug 2024
 08:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813213651.1057362-1-ak@linux.intel.com> <Zstiry-K_v51oDC4@tassilo>
 <ZsyR4eQr8X-q2X28@x1>
In-Reply-To: <ZsyR4eQr8X-q2X28@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Aug 2024 08:27:43 -0700
Message-ID: <CAP-5=fWKiN8jJ2rehG+0fw_REyYZxC3562KLBG1g9jHCyXMRvQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] Create source symlink in perf object dir
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 7:32=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sun, Aug 25, 2024 at 09:58:23AM -0700, Andi Kleen wrote:
> > Arnaldo,
>
> > can you please apply the patchkit? This fixes a regression.
>
> First one was applied, was letting the others to be out there for a
> while, I thought there were concerns about it, but I see Namhyung's Ack,
> so applied.

Can we not apply this? See comments on the thread. Basically we're
committing to supporting hard coded metrics, aggregation and unusual
period patterns in a way specifically for this feature and as attested
by its brokenness nobody cares. The test ensures the feature can't go
away. The feature should go away.

Thanks,
Ian

