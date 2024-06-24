Return-Path: <linux-kernel+bounces-228088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9248B915ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E701F21AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC461A2563;
	Mon, 24 Jun 2024 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwQS05ub"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2017BA7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719272602; cv=none; b=Q/9g1Cm7rpk93XH1ErtirEBY/ZLfWyyOMuIw6UJEbgjdCew1OGPRYBGxdkuT9PCtZwI9c6GCrpq5qkiJO2sXu/6xQzrCJlPenynZobbHiBGcIDCdS6odZSXsXi5SB15igurmXj5w4QgMIHWBNjkpn1b2L8X60mierhoKFmHnSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719272602; c=relaxed/simple;
	bh=hY2K9GopRcIQo+YJLXvn9mGgJ92g9HFvHPeUzyN20HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ro5rVFWpJeEOQzJvUb+i2gAZZfessFokb/JpZ2hhJd3+InRrQjxnkt2jnDXbu+6xFuPwR+5hD1+2Ju5c3ztcKR56pXZnGUDCw2Obs2dDiPKbVITIxwVKBUkKi++EeoHBctyX3EQCRXpxQ6ii7ULPqF/GWQeeZyOi6o6mqBXLWr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwQS05ub; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f480624d0dso41269855ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719272600; x=1719877400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY2K9GopRcIQo+YJLXvn9mGgJ92g9HFvHPeUzyN20HQ=;
        b=GwQS05ubAl7xeYO9B00dgEPlR1F4k1Dein/+dKaYEk5Xg0L1+Ex59z2PYXvCXwkd4K
         JXnUWNsvdcykT71HkvjuTJzPztV5V0GhwotIrcuAPbadItNWTQoI/7vkUChYnRTKc3XP
         Tt/yyABq9Lei5XEhQ1eaFKFXJoyc1OQ6FpFs5V8x22l+dnJc8Ok1wnI5Oi84YtASQc1Z
         UugBJbCzQLniDvwufZtbnL3OE3tQV9mY2gRUOni0SaHOPA9QJb1YgIGGSmGeG929bpMh
         P3bahOzej3dQE0N6GK+Fj3ptuU7/QyaIlp/C4ScuB5SmBtnb9HPlMbUMHmywf1uEW1vr
         uyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719272600; x=1719877400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY2K9GopRcIQo+YJLXvn9mGgJ92g9HFvHPeUzyN20HQ=;
        b=dyBAoIRs+bJRO0dPN5drC3xA9HrlPHAaNS5O64bZ+lrcHQO0wCV+hGSIERtXuOAuRC
         vP5wMgAH19t8fXgPlywzfkRsijCCS55tBbemnuVRtaikt9/hyqJfyKAVQVLofHpQrgVz
         42jinpZSTGzHpa+2Tn1JlAVgCy0LPLKonaqmCh/DN/jfK3iCjsA6Nr+5TDxn3mpimQCg
         nABzP7DmlRc6lkVMRsMm5jBEP888KEuvlw4fIYzUheHjwrM7wKwVsBe1zuJZurG+2A/A
         SeGIAS15vIZk9yEa8mIeojUbjBh1wCFkhifhyQvUmqjitxNZL2p8PlnpS074sQQsAkC7
         g3kg==
X-Forwarded-Encrypted: i=1; AJvYcCUqFPOVCewojOuavxVo8l4NsDC+A7tSOMbhg//ndX330jkl6vDDumepvm1kZPsv6gchBM26EHI3Si3DVsYdUHd5ne625U2vIS0OITlX
X-Gm-Message-State: AOJu0YwiEHi9Cjlkq2gVAIPlyo/ypZzhBWRTtf4kBMoQeoNLEPq/VElH
	OvzmmOfGZZ5FE0KjsGOpptPeLSWys9ndZodZAa3gPRFaQ1VHfJfA
X-Google-Smtp-Source: AGHT+IGSxorLizB8AR7/J3uCktEH93ZdZ4u3fCevV9GzYQT1KAzX86bCpFjKQ9gbyeEhBYh+XcIrvA==
X-Received: by 2002:a17:902:d2cc:b0:1f8:64e2:73e4 with SMTP id d9443c01a7336-1fa23ecacd5mr92527845ad.21.1719272599693;
        Mon, 24 Jun 2024 16:43:19 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c6156sm68035245ad.138.2024.06.24.16.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 16:43:19 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuanshuai@oppo.com,
	yuzhao@google.com
Subject: Re: [PATCH v2 2/3] mm: use folio_add_new_anon_rmap() if folio_test_anon(folio)==false
Date: Tue, 25 Jun 2024 11:42:53 +1200
Message-Id: <20240624234253.14513-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624162503.61996134e5e148eea93960af@linux-foundation.org>
References: <20240624162503.61996134e5e148eea93960af@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jun 25, 2024 at 11:25 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 22 Jun 2024 15:20:02 +1200 Barry Song <21cnbao@gmail.com> wrote:
>
> > > >
> > > > Since this is primarily a documentation update, I'll wait for two or
> > > > three days to see if
> > > > there are any more Linux-next reports before sending v3 combining these fixes
> > > > together(I've already fixed another doc warn reported by lkp) and seek Andrew's
> > > > assistance to drop v2 and apply v3.
> > >
> > > Feel free to send fixup patches for such small stuff (for example, as
> > > reply to this mail). Usually, no need for a new series. Andrew will
> > > squash all fixups before merging it to mm-stable.
> >
> > Hi Andrew,
> >
> > Can you please squash this change(another one suggested by David)?
>
> sure, but...
>
> > From: Barry Song <v-songbaohua@oppo.com>
> > Date: Sat, 22 Jun 2024 15:14:53 +1200
> > Subject: [PATCH] enhance doc- mm: use folio_add_new_anon_rmap() if
> >  folio_test_anon(folio)==false
>
> The only description we have here is "enhance doc"
>
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4346,6 +4346,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                * here, we have to be careful.
> >                */
> >               VM_WARN_ON_ONCE(folio_test_large(folio));
> > +             VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
>
> And these aren't documentation changes.  Please send along a small
> changelog for this patch.

Thanks for the suggestion.
Could we have this in changelog?

For new anon(!anon), there's a possibility that multiple concurrent threads
might execute "if (!anon) folio_add_new_anon_rmap()" in parallel. In such
cases, the threads should lock the folio before executing this sequence.
We use VM_WARN_ON_FOLIO() to verify if this condition holds true.

>

Thanks
Barry


