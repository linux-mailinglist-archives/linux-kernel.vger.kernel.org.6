Return-Path: <linux-kernel+bounces-210333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2E590426C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFE11C24DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812054CDF9;
	Tue, 11 Jun 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaF4ZQK5"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A7D4C634
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126981; cv=none; b=h02HbZxHzU+ossot4uGvlr7axVhvIueFtnWGhB2DyXa8QRLGnMIDQO6AUWpQlberD4V17qf2FIeAfaAnC9O52mQumtddaRqt2LJdAj4uPf+0xoa40YTj7T4ND8H97azZ+tnkFA7u7pNLW2A9Dr4rkDltX6OLSUD9/DJioxHr0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126981; c=relaxed/simple;
	bh=yp8LNB0GKkmC9XyBsr9Fvc4xrn1FcALdJ82VET9mehc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUOo0eUfVCZCzzjXAX5L13sTEz0s4ENPMEROeMHbusJGQtwDECjy+6XAcSXx8io6ck9vd8VJ9t6p7WBnPuEDXUQhgn3dmw5r/IfF3vYUJ49r9WO+kSCTz5OyN6XDu9iz3zhmtH08qk7PqsqxodT4ISDCld0euBBGznKZMY743Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaF4ZQK5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c525257feso4366918e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718126978; x=1718731778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp8LNB0GKkmC9XyBsr9Fvc4xrn1FcALdJ82VET9mehc=;
        b=UaF4ZQK5uzvo61KcZcvhfZGFcILV1mzGc+kEzBfRj2ykk8OEwhvgD3HvJhzBnAVPAJ
         z9Ka7zWeywzlktMXD/4DxWAWZqyE4qa2c9eEq4qVmSJH6tFVUREuWH9kTX+TT5kUahjo
         obBUe2ktSS52QUYHhbP+nX/Di8NsAci4jgrxmzMWD3BhRjkOBZRE0l7VeDwIPVzaLos2
         +l5sjCgbis08YBScXoujWpiB3yQn6vPHKe3HUH/3wx9ZdklY06fpiLFfpq9tcLcVW/0L
         JkEcSEwYcaFxYArvReleVE37Qb9BSHQ4IwKbYyZCGYf9eLqkYn1FO9zCOQ7+kELkRjiO
         ds7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126978; x=1718731778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp8LNB0GKkmC9XyBsr9Fvc4xrn1FcALdJ82VET9mehc=;
        b=GthINqVt+k/sRS4Ah07PQnKBzuxc/bP/UOkwXUuqzYN46pW/qNyhET0XWzDV8du12/
         qThDuSjNyl6SakY6cHGVf0Ol983wOr6Q7pWBGKwgnNCoWip6lROaaonbBwVahNcCbcAP
         5sXgyFft4CVSiSHRPPO8KRLt5wx3Jwd2klNiTrccyEDKxyWXABvpqCyHSHXMvZh8NruZ
         Nlek6ZmQIAtaMe3WcAAKByP6MEo/Ienou/9osz6aIsqBoTOdTyZbe1JLPx0YibRqQVX9
         vi1/57XW3aQZYFIImdlWAw6zPknXjuDzm0Vwuhh2HfAZ3eqkqRxgqyu2kRURLDDtgfFt
         p06A==
X-Forwarded-Encrypted: i=1; AJvYcCU8fsJguUqrmb4FGwO+SQJN6mVe/GgRTVZiDGb+JO8ElpIdhLkWGdHpsQ8cPRhQYpZtu+wHP15vrtRkOHnJDso3GGM/fhG6ZUhmTia/
X-Gm-Message-State: AOJu0YwAGQx4cVnkUYsY51AhxaQDamkOjcAJerdjvsPXj4vEVXY6csKq
	U3ymO9x1U89ygz1d8Jr8kZ3YImlrRCbLEebk8G3UZXbhPWBB7ko+OTR5Qrloai/24Fo3UUCuFXo
	LhbVZGMckYxviIGkT5zyWC8SfpM6TH8DouRtf
X-Google-Smtp-Source: AGHT+IHL1hLDhEaq3Esy5ZXWYpAWtACT5oztAwPrX67iPYV+FLA+aPsYxkzmVK/KOCK9+1FjZWc3fJTdN63zzKzI6XI=
X-Received: by 2002:ac2:4989:0:b0:52c:7fc9:954e with SMTP id
 2adb3069b0e04-52c7fc9976fmr5385958e87.41.1718126977999; Tue, 11 Jun 2024
 10:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610143037.812955-1-usamaarif642@gmail.com> <ohcrgrlmcl7ym6dlfy524g3ht63pask2qjeqy5m242xrvxojt2@36gqaboyzmn2>
In-Reply-To: <ohcrgrlmcl7ym6dlfy524g3ht63pask2qjeqy5m242xrvxojt2@36gqaboyzmn2>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 11 Jun 2024 10:28:59 -0700
Message-ID: <CAJD7tkYxtfxwmVXxiDUacaPenDLU9v_MZo7vEqquA_1fVdB2wA@mail.gmail.com>
Subject: Re: [PATCH] mm: Do not start/end writeback for pages stored in zswap
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, willy@infradead.org, 
	hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:16=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Mon, Jun 10, 2024 at 03:30:37PM GMT, Usama Arif wrote:
> > start/end writeback combination incorrectly increments NR_WRITTEN
> > counter, eventhough the pages aren't written to disk. Pages successfull=
y
> > stored in zswap should just unlock folio and return from writepage.
> >
> > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>
> If Andrew has not picked this up, send a v2 with more detailed commit
> message, particularly why it is safe apply this change. You can use the
> explanation given by Yosry in response to my email. Also add text
> answering the other questions raised by Yosry.
>
> If Andrew has already picked it up, just request him to update the
> commit message.

Yes please, thanks Shakeel. I wanted to ask for this but got derailed :)

With the updated commit log feel free to add:
Acked-by: Yosry Ahmed <yosryahmed@google.com>

>
> You can add:
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>

