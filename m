Return-Path: <linux-kernel+bounces-377758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EEA9AC650
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83F71F21E10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD415B547;
	Wed, 23 Oct 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hs5xtLZQ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9B199E8D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675558; cv=none; b=d9pfpfU7pe6LDmx0VWISd9oc2uLcT4eQB5XklgPaoyoN21+/xXXkmthifoxcPEAdulA0J0dtmAPrQS9py8NO6sPjfcC1VZCVpgbA35ZS3cnt3l/CyTHezq/eWmm8PguKIbiCjmSzV7nvQPv7S2X6hVynrSVh4O8o+PA/PgprLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675558; c=relaxed/simple;
	bh=5aBva71oJY4WP2gL+8hvcwG0M75spH9bjubh8VmG3c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ch6xir4GP3wCK6nzhKr1IfLI6YA3SNw8h8ID8UJWZBQ6ZMxC+Ywqmz33TUBn+u72SRKvjW3ZKfgyoba/4svbVnOBE6VGguNdHcE0B1m6c46NZBCum/rcC5sbkZM4wNsYRC52RLhvHew5dAowqcAaW/v8b2RuvICQYF79vvVrcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Hs5xtLZQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so8343784a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1729675555; x=1730280355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aBva71oJY4WP2gL+8hvcwG0M75spH9bjubh8VmG3c4=;
        b=Hs5xtLZQQhGDExGThscHhkyPDl7Q8tsahmUM9Z4ipkiwpuT1VF/Ym9beaM2D/4+0JD
         1PDmRzTpVedJliEn1EbGcljLiJWobLN4vzDtyDoOYFXTnGPtleYr6Yla1FMRFFijCDDN
         Oxm2VI98/WJoOUJiRV2lsSp0QvzdTuG4vHKunc5X0jNI/gwYBjowitaUY5lWvq3mCWwd
         P+ew+EsJ5jCDBfWqXtABR2ZnBwJmyJmhkGIxBOr8dD49ahIpa3dBAhPZ/uMS6ebsMDQH
         LGVMvO5ogVTPwNHjriDx7scJOTaHnM4wR2BnDc5tkHA3T28EA6dXleXgFGIcr4W7QfFv
         eO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675555; x=1730280355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aBva71oJY4WP2gL+8hvcwG0M75spH9bjubh8VmG3c4=;
        b=hQ1LSx3MpB/0glQ6Wzb/UnEn8j0iaI4e1zZWM+I2RUhkZsHrfnvBkm5qAOYb9diRdu
         MI7YZNT+w22aouYW/umH9ry2QSUYWjt2IgzJvVpRpqWUddqsiuWhm2BSmoZG/7hUMWyE
         2+hy6/egQsiYwmUcsyzPHiQH2lnLUXJJCrOOWSYImAEHhuUxE06kIVq65JcwUVA/wgJz
         /XR1/zKchJIhGfrWnwt4jDNe2KHlphcMbylsnSivthIeCxDB7Pyn8DQiEpZUhDYkBS8h
         YS3PwdEptp0C/H//9Tx2j7RYlwQROXEpsndyCpSB5uEZJezUWHQJ+NBTlg1faAywJxxp
         5O2w==
X-Forwarded-Encrypted: i=1; AJvYcCUX99XZb4HP9UQG2sjPX6Z41FM+KlHe/6U7zX/ASPu6ahk3vHqbtzReiHabbMw1hvNwoioaOUdybonyb0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw30X3o4jUI0JvgBcmuOS0fxaoYbwV/+dgE4mD8Qn/doQkrq4ld
	oK7qKqyEB3fRZbKu3nlz4toc2nboxPP2WHHFyFXWm/4ief9uVbWVitBP6eTWv96Kp0isZNtBD23
	taz37Li9XM1QQlJqGnNuTbIHDjiRvjwx8CUZNxw==
X-Google-Smtp-Source: AGHT+IEpffBs9Fl27XgLD9bGDxRxP6NYVE4mf17lV6l+PcB9+2lyHK8Tl1N5ohZwG3uhDUsekG0wliB5I3PyiWpjlKg=
X-Received: by 2002:a17:907:720f:b0:a9a:3da9:6a02 with SMTP id
 a640c23a62f3a-a9abf96f0dfmr184213266b.60.1729675555052; Wed, 23 Oct 2024
 02:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020051315.356103-1-yuzhao@google.com> <ZxYNLb0CiZyw31_q@tiehlicka>
 <CAOUHufZ1fBvj0DgxtuLvwMAu-qx=jFAqM5RaooXzuYqCCTK1QA@mail.gmail.com>
 <ZxaOo59ZwXoCduhG@tiehlicka> <82e6d623-bbf3-4dd8-af32-fdfc120fc759@suse.cz>
 <CAOUHufanF3VaLzq6o_V+-+iPvB4Oj-xHwD+Rm-gmKS02h8Dw=g@mail.gmail.com> <97ccf48e-f30c-4abd-b8ff-2b5310a8b60f@suse.cz>
In-Reply-To: <97ccf48e-f30c-4abd-b8ff-2b5310a8b60f@suse.cz>
From: Matt Fleming <mfleming@cloudflare.com>
Date: Wed, 23 Oct 2024 10:25:43 +0100
Message-ID: <CAGis_TUHyH8mM4q+pWJH+LfYchQkjL6Pap4sNfLA=HRqg50KAQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate
 free highatomic
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Yu Zhao <yuzhao@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>, 
	Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> I thought the alloc demand is only blocked on the pessimistic watermark
> calculation. Usable free pages exist, but the allocation is not allowed t=
o
> use them.

I'm confused -- I thought the problem was the inverse of your
statement: the allocation is attempted because
__zone_watermark_unusable_free() claims the highatomic pages are free
but they're not?

