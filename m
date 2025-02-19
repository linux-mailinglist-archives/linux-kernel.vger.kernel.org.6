Return-Path: <linux-kernel+bounces-520959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA633A3B1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480EE188A0FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B11B6CFF;
	Wed, 19 Feb 2025 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmXZreSO"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6581B6D0F;
	Wed, 19 Feb 2025 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946928; cv=none; b=ukAOCdupSIKzZD0XVGGo3VUj2SXr7eYUFJEhUcWxXTj5PX832cW27est+niRjTWvEfZ2WfieBIqXbQtIuJzz8HmVKJ+eb5eOMHcTLaE2xU4O9dLIJpGY6hpHOyLxg5d/PMp5jb3BPTZxqjTRfhbdMyJ5+PPTY73Vh8BS9SQY9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946928; c=relaxed/simple;
	bh=7cszKDQt9XMv02a+ZwGltOu4Yj63M69diOpbFNtrAPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWHVWLK0I+pXTEMAhvImDWIWlGWEV47zYMKg0RXDCpbmCahMtt0vSHBAr8dbyBBm2RMKnwEhazvKSgwYwQnfsgQshh+Zgpk6PK/Gfh7q+wmtq3MiqSu1/YBSLYlVbxeENcDb3U1l9XU8GdLk1jiE6cftpflzgDDFgAYjTYhFox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmXZreSO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbda4349e9so29980266b.0;
        Tue, 18 Feb 2025 22:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739946925; x=1740551725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=57W5SvEFGc40K4otu3jc8MLgWskx5YF0tVueFcEL808=;
        b=nmXZreSOyqWM/mzIx2IGS36RTa+1eumLWLZuPAy6a0uxdrIxbvjax6/2tQ4CQLjZjR
         66I2ATtpQjqdFjRznNz0ilyrG6csSQdvpiYQftnIBTPx1B7I5omNezui3ikkcEbhbSZC
         ZYxNp7uFa5sPdCQK8M5lJY7HDKzuOJHpdQDO86QrWKIOh7rgbfjCT99daHgYmID+WTgF
         HOHpyqUvOQ6JAy+RR1Em31MrzXYPJ5vSRdXQauGa7oQ/6IY3JLeZihDBdrrhw1072cuw
         j4yXCCopqa3Vj9aAO94D1ji6SGzDPVUz0D/9HGwv5epUWXa9WULh+OZjg+0OogQbJRtm
         e0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739946925; x=1740551725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57W5SvEFGc40K4otu3jc8MLgWskx5YF0tVueFcEL808=;
        b=LCsveiANG56rQEuMPJLTOYltp7FMDw1B+ryUVXTLFcDpEzmyyCcS3TAKrCc3NiujRv
         P/oLlF/AJmxsiZjnrRbYSwC2CvRrhXbY2eiNfRlaqDVk6pe5YgwpmkBROw+6AIVwlxjT
         LelmLfC/1RI9MgIAyzOnBf+DlKor8TBEYOHvQdt/NXssPz9plSLffuaEij2/acCnXw1K
         oHb+Y8+6vmRdKsvsfGwMD7hSK0k3VKFHOI7me7aayfzrctnq+S6wSkupy57fa/dB8kHO
         ligXcnocLxjgzWOBSnfgi5VtSbjzFiEh8eCajZQz+P5WKBCc5gHdcQxpozVYGr4Lj9C9
         FvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9KggovmWhWOz9UjGq/WMEVLR/6HYVVsznkf0R0TUOq9B2CPuEHP2sPqGIXo4Aj+tEbc6NDXaeQgeJEayr+VI=@vger.kernel.org, AJvYcCXx6LluWhjJ2HFoMYnrzApsOa8xU2IaSpBdVqU6A9cewPdluPBWHj9sNnZSiR1QPeijHB+sfrZUvOWlugU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAyhoijKgaNqoV243/9Xr6ZZSZRXrPGRLiR3e2HDuoC5UgRO3
	D0hwBfM+PLcRd1YNFqH5MHX09C/UxfenTvZuHO/Tj79OCRk1qj/wLbsWP6Y4ie6kCxN3GZL25Zh
	FH92DoV6emsSY6pk8N7zvaMWcXvgOmg==
X-Gm-Gg: ASbGncsptYGXzl00SAfFsGMyPscWTeP0ktaobYiOoxJVCmxQIpWRYKYMyGku98gRj6Z
	aundOfbjKDhVelgNXHsAWsbS69L5r9/EAY6BAcgbozbZ5snSs078CthRKvM8k/XzPQSKfgCE=
X-Google-Smtp-Source: AGHT+IHM8K/ufJhZwysVLMejsQ7FWat25JMEeR9lhuWlXykaokUltSn4JDH67VDt6SmdhK2xCiK9VCOQHkX9jfG6si8=
X-Received: by 2002:a17:906:370c:b0:abb:519e:d395 with SMTP id
 a640c23a62f3a-abb70a959d9mr1374646266b.20.1739946925026; Tue, 18 Feb 2025
 22:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7SwcnUzjZYfuJ4-@infradead.org> <36783d51be7576fcdbf8facc3c94193d78240816.camel@kernel.org>
 <4cbd3baf81ca3ff5e8c967b16fc13673d84139e8.camel@kernel.org>
 <e63089e15c6f4d19e77d2920d576e0134d8b7aa7.camel@kernel.org>
 <Z7T5_WGX_VXBby9k@boqun-archlinux> <615ce44fa528ad7be28ba518e14a970f04481078.camel@kernel.org>
In-Reply-To: <615ce44fa528ad7be28ba518e14a970f04481078.camel@kernel.org>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 19 Feb 2025 16:35:13 +1000
X-Gm-Features: AWEUYZk1tP58mZwBWrZ_OnI_ofVylDGmguJN0E4-Lra6JB37GljlIo3vIoHrYPs
Message-ID: <CAPM=9txBg1m=qp9=nHJXS1h2XB8TSL1tj6CF=Z802u=YX7hBDg@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 16:20, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, 2025-02-18 at 13:22 -0800, Boqun Feng wrote:
> > FWIW, usually Rust code has doc tests allowing you to run it with
> > kunit,
> > see:
> >
> >       https://docs.kernel.org/rust/testing.html
>
> I know this document and this was what I used to compile DMA patches.
> Then I ended up into "no test, no go" state :-)
>
> I put this is way. If that is enough, or perhaps combined with
> submitting-patches.rst, why this email thread exists?

There is users for the DMA stuff (now there should be some more
tests), the problem is posting the users involves all the precursor
patches for a bunch of other subsystems,

There's no nice way to get this all bootstrapped, two methods are:

a) posting complete series crossing subsystems, people get pissed off
and won't review because it's too much
b) posting series for review that don't have a full user in the
series, people get pissed off because of lack of users.

We are mostly moving forward with (b) initially, this gets rust folks
to give reviews and point out any badly thought out rust code, and
give others some ideas for what the code looks like and that it exists
so others don't reinvent the wheel.

Maybe we can add more rust tests to that particular patch series? but
this is the wrong thread to discuss it, so maybe ask on that thread
rather on this generic thread.

Dave.

