Return-Path: <linux-kernel+bounces-249762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AA292EF80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5771F2242A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE56A16EB71;
	Thu, 11 Jul 2024 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BoOLF4h7"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140EE1EA85
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725481; cv=none; b=FYuT/0aHtFCQtqVZ8LIhpjSMnDtsFuoBlkcXdudU8AxUjQvY2cV7Z89oeRHIZ/00aHiP4p8pg9L3YLQ4GE+HqROofucScVfQ9WqlGyVRVtSe2NXMxzFGtlFxsL8kwP1+OfQBtVsubW4C6LLOvo6KD5rRiQ+CE7aV+Ib+LBTU1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725481; c=relaxed/simple;
	bh=jml2mH5xPX6WLHw6QUqvLqc4gm8iBoTV1e8ILzGXDOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUXpRouup+ZL6+oFJzeycikEvd9VaPRFVAdWajunNQbCS5w0Oq8VUsEcxYxayMFf512/I/N6F3UPzIvKUY1f9PvWrO4HRQ6HqjDmL83nUTTMFeu2MOOKb0LAr6riq7bQ4pAYpLCpNwGuQUJAtRedTIQwR+6oj4vdaDGNPA1NLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BoOLF4h7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6c4so1597903a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720725477; x=1721330277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PfkbCy6IC8MM2ShGGRIr/7yv5osfVo7ephGJ4Ll7hD8=;
        b=BoOLF4h7a1CA1ZQlIJ/utw0WumbjysCP5ypilF2dNt44cFDBVId3z3B8Yj1Gf77nsw
         trYt/6lul/xq3SX2UPgDvOHOeDBrPL5HaFIOK68J0NsuE2w8gPjetcHgMttlsLge1SgD
         IGmNpnuKLhmlwEoy3dT7gQ/oqGvia8FnLG7f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720725477; x=1721330277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfkbCy6IC8MM2ShGGRIr/7yv5osfVo7ephGJ4Ll7hD8=;
        b=CcsSRQy5z2snj7nB59fkCBMImfeCycqEdQsQzH2YYiFZTCP/hFby0NwyTtpi8AozGD
         yJMNZGLqZChhmdc9Y0B4dWiaVGThzhhONAd7/mhgB4GDPKDucH0hhphk4pdPxvCYSbfy
         ibLzDxUdQXOcvu+QqGXircVvnhuPJOvKZxY9v6qZ4THXKImgxUl1mypAvFxU/NkrH4m3
         vNygDbZgRsAZQJVsitFGku+D6Rn9dBt6s3DPurpgwKbRmYxL3rd9WdmcT0SWtEMCVcmz
         t0WsV82Ny4B/zSO05ckPhpIertchLXIwUxjnU07zOUc2onnzFv4XVyu/y7gmGqJA8hc5
         r9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVrhxNScR3RvxdHL87vpnuXr4mkg+Sh++A5+5DDkRjpYh11XJKET9MJUpwUfE/f9HPeItfX4m0xlJAalpme6RM9qdTFDDnwLD0tyBSG
X-Gm-Message-State: AOJu0YzGWEGl6dBGQMsuNZEGObbNuetJ9I2vYzSznkGtqV9SNFcMZuF6
	6nnwNvBxv7SNXuYhIYZcKQ6t8iseetN0X1VQLMVK84HcYDqj2+Jc3ueF36dimeeQVzzM68HplTZ
	0B7W6qg==
X-Google-Smtp-Source: AGHT+IE51e6QABd+aJ3dukWnG9w1iHibcSygGE8TeGF/rjDI7U59byB4E3IGp3sgCIcSZpywlbeKZQ==
X-Received: by 2002:a17:906:514:b0:a77:a58f:7f6a with SMTP id a640c23a62f3a-a780b6fe37amr544556466b.38.1720725477484;
        Thu, 11 Jul 2024 12:17:57 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a854352sm280586666b.148.2024.07.11.12.17.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 12:17:57 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-595856e2332so1601209a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:17:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFmbo83Xyaxkww9HbCe/ARVP5hvBe45W28La2LOkYNKXIw6LpeKZl07eiNSunVtu7jY/zBRGjLnK7fgqaHIZ2DhwIe3mbQzCHfokBM
X-Received: by 2002:a05:6402:2707:b0:57d:10c:6c40 with SMTP id
 4fb4d7f45d1cf-594ba98e3c7mr6937905a12.7.1720725476855; Thu, 11 Jul 2024
 12:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709130513.98102-1-Jason@zx2c4.com> <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com> <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com> <Zo9gXAlF-82_EYX1@zx2c4.com> <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com> <CAHk-=whGE_w46zVk=7S0zOcWv4Dp3EYtuJtzU92ab3pSnnmpHw@mail.gmail.com>
 <37da7835-0d76-463e-b074-455e405b138b@redhat.com>
In-Reply-To: <37da7835-0d76-463e-b074-455e405b138b@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jul 2024 12:17:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVc6cpSCJwAqrhPvwBbcQEOL2TEnCELfadhA=n1GN4Ww@mail.gmail.com>
Message-ID: <CAHk-=wjVc6cpSCJwAqrhPvwBbcQEOL2TEnCELfadhA=n1GN4Ww@mail.gmail.com>
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: David Hildenbrand <david@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 12:08, David Hildenbrand <david@redhat.com> wrote:
>
> We also have these folio_mark_dirty() calls, for example in
> unpin_user_pages_dirty_lock(). Hm ... so preventing the folio from
> getting dirtied is likely shaky.

I do wonder if we should just disallow page pinning for these pages
entirely. When the page can get replaced by zeroes at any time,
pinning it doesn't make much sense.

Except we do have that whole "fast" case that intentionally doesn't
take locks and doesn't have a vma. Darn.

             Linus

