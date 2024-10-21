Return-Path: <linux-kernel+bounces-375243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755FE9A939A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A621F22C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFF31E3766;
	Mon, 21 Oct 2024 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZXzIeEVs"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B31E260C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551634; cv=none; b=i3WIXzpp1DQVgpXd20/EWEjybsrb8WqQJy7ZQ2zREJeHRoMzY/CUY7GT2lUqxaPhU0AwlfRbssEXg3pRr9rkJ2lth64F3kuQ4Ms0AzwcrjbWPGZJBW/cfaaBeCEiRsMEOZ//aLmRPEbw2bTsdsr/eUlnf8s/TUv8s+kQBVPTawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551634; c=relaxed/simple;
	bh=3LeeyEafeXaGnkqTR7YkYuS9ctyqOUkRKIdPORL0JMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT6YVYPuZ8K5KmVl3lko8YhTlu6/90RSvUSEV7QPNuLrhkTpHLVSsRePg2D2YTXQpIx/x/jweaqf4DobWFG+Bk9yNswN619aAvSn1rZUp666e3w1MQdBY0xr+BBEHmhan+9w+xCAWJIictdv9s07f3GNaqwzXDSjzQro0UyHRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZXzIeEVs; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso389408766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729551631; x=1730156431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rZmK1iIL6psL/Ic0R5BQSUU9uDtSN6VQwETroA+PQ+k=;
        b=ZXzIeEVs7nuFyzbWRbw5rYnS/QjSGMtdp7hzc6L6HYQvJTEuW6u7psHhwVbV1MTREX
         Os9bEYhzdTl/62TCTh3QO+wey6iD9J5+BlhRLsRVnUPwqUuLKjSZYY2jYNwDrCY2hzza
         OXhXOa8yuHWcmy5iHf4QaTK4kVs21qyZTDkZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729551631; x=1730156431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZmK1iIL6psL/Ic0R5BQSUU9uDtSN6VQwETroA+PQ+k=;
        b=PoSidwFTtqQnERTBL4V5XkbGt6tlWOZ9cs1or3Gb7drqxaX93yguMuFg3EY6qfLe1g
         q9Onx1P+riGWPxVYfe87EtqGmsjxKPhmFCggoNDQK6S5XQVO2hIZ4eu5ETOyoH0APfrF
         XbPGFfEhiYdlbQQy19nCu9rNLqv0YicaWpT22jXth3t6xha70guU6utfSd2MGIEyb2+a
         fuvcAqfYdEpVMx+BeGPdopS/W9w7dgHnX959u/TouyQMwg+o90uIfQ7pZGoNAhwNKA5x
         EkKP/RRdwh/WRJu+DN1mBADIddM+248EP7JtxD0Q0iVlgOzuTfAZb2H85Bwwd7WCDzT4
         i/xw==
X-Forwarded-Encrypted: i=1; AJvYcCUX0D2MgagUjQBb2x6guP5NvCuLWXxQztfm30bcm3JyemauyjHkraxESWcY1FldX1pydGDos5hJMjszMPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfl9Xb735DuR2D5GF5RWh3Q3YKEX+Z0aiFMzYhdZK0AVtsn5Rx
	bHXcmUq7wD3cWjj5eMxlso2SY6n74POLnJINdn5mVISwWtpqbpaY1hRmXYQz4gA5HoiG+n/jmZL
	zXar58A==
X-Google-Smtp-Source: AGHT+IHUg+cXD3RyVhDe22vdqqgg8tg26ku7CKBoPrGkqZCNclg61kiFX6oMMmk9lSoSsMd+vzo1qw==
X-Received: by 2002:a17:907:7213:b0:a99:e82a:87ee with SMTP id a640c23a62f3a-a9aad3dd302mr47933366b.57.1729551631030;
        Mon, 21 Oct 2024 16:00:31 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91598f29sm262368166b.190.2024.10.21.16.00.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 16:00:30 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso6111900a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:00:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWr4qisjGeuF6GfZ2WHcjtElLCwcEVXICYM7vWvVFc9g+Z9ft5ydrMdppZn3LzilR9eH6JXbC8b6tZqL8=@vger.kernel.org
X-Received: by 2002:a17:907:97c3:b0:a9a:4e77:92f with SMTP id
 a640c23a62f3a-a9aad3d659bmr42656766b.56.1729551629565; Mon, 21 Oct 2024
 16:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807094725.2193423-1-pedro.falcato@gmail.com>
 <20241018172804.GA2151929@nvidia.com> <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
 <1cb07628-269c-4d6c-9936-f3a2b233165f@leemhuis.info> <b6852c2d-3371-47a4-bfeb-049f4048e88a@suse.cz>
 <ZxL3FsmjGrTT_EV9@codewreck.org> <d937fd92-249e-4660-a59a-ee85b6ec4691@suse.cz>
 <ZxafcO8KWMlXaeWE@telecaster.dhcp.thefacebook.com> <CAHk-=wjpxeTifM1LFPQFR5_RjD2uvDAHbZ-ATCqox+RuFwkbDQ@mail.gmail.com>
 <Zxa0K-4mhSI91S-w@telecaster.dhcp.thefacebook.com>
In-Reply-To: <Zxa0K-4mhSI91S-w@telecaster.dhcp.thefacebook.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Oct 2024 16:00:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBSEzzC2CTtTgnJ-ou+1ye7CVw45ogeH_eFR_fDF=Z8A@mail.gmail.com>
Message-ID: <CAHk-=wiBSEzzC2CTtTgnJ-ou+1ye7CVw45ogeH_eFR_fDF=Z8A@mail.gmail.com>
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same name
To: Omar Sandoval <osandov@osandov.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Pedro Falcato <pedro.falcato@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 13:06, Omar Sandoval <osandov@osandov.com> wrote:
>
> Yup, that works here.
>
> Tested-by: Omar Sandoval <osandov@fb.com>

Ok, I changed the '%d' to a '%u' (because go big or go home), and applied it.

Hopefully I didn't screw anything up in the process.

              Linus

