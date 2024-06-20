Return-Path: <linux-kernel+bounces-222258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D47790FEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BF5CB216F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A81A4F34;
	Thu, 20 Jun 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G212jt7J"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081231A4F1D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872371; cv=none; b=C2ZXcQPQOoyvpfU6dd+Ah3iJoE5/E2726yN0gPFPmM+/2o8XP8jS24bw9viwPiSEv05Hr9QgimAM3aErQBDKh+iq0JAhaeqdOTTD6IPRnFI9ueFKG2gfu5axBgj9UkWiO1K6rMqRjmtHAeU8akdv9FQsyOHkHuBALcSwipJqoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872371; c=relaxed/simple;
	bh=zYuEkiCJucpYi9fRM2FoKLYinOCDZ54ScNQjYNexUm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eu87fLgT7bD7WUWxNHO9JkB7TFZeTTAQynWmZ24uAGYFcPivRolhT3HzY61x8z9E2wIIKpXETTUm4DLxHoajjkPphBmCMo5Fw8gNxhZ4e0PG5XSuo32KQPa2rf9KJKwHFX8XXkvBofu8gkeeZWMeFH1rIZKFwVbzX+NFNSeC55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G212jt7J; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48efb6873cfso206859137.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718872369; x=1719477169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOmkUEX+QPpwIw/PNe7ONbml5f/DeYQ311Q9vb1DpME=;
        b=G212jt7JI6T34Sw7K7aIrZj2TGimRHLgCi9fX3KbKwlIPx2NT66U+xVeQNqji8rLh0
         UtrJ7w5uNVWsWN2zVe0GUT+zfoLXgfxBZbY4kCUaQrbRE00IeN3FVn9tKKP9/eE4En+L
         emgYJPLlnBbOfzhtQalH/A7FN2YloXIjopcw5dnthhFYR+M2LlF//b7nhRmj5SptuevS
         hOEDqYy3NuptpWqsSJFAQCzv0/ZhPaHGLjCKCwMe4Mjigab1dJ1+Y3x1dOWWL/Nfb/TO
         cKv/MebuxP7FdUtCy9ZrOzWa71EJkLvDxxHu2zA/uGDgkkwMZgHYK9hjAlaxrcrQJso3
         yF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872369; x=1719477169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOmkUEX+QPpwIw/PNe7ONbml5f/DeYQ311Q9vb1DpME=;
        b=LXeLsi4bXR5ak3QVHG1CA2euiJlaJr2KSysr+MT2u0jYOiff9nObgXsHiHpt/w/Tl1
         w7BBvlJKf4GcsWKNxCVqnY6CCXvQtTFdFhYZOZdDbD05ygBM60iIPJv76IFW1rxUOtHD
         lVX+l44bmI1ZekptCeYUR9BdXT6GGCU9Fi6VFl+85YJhUvSy4Xs55aeauXm9sUow9UNb
         F/FYPSKez7BQdFM8RM/d9FebrGyHB1zxSaluQSoIwWtKwZO4jyOOg/X8be07SbRGv2XQ
         07QL78Pg02EgLyq4j1glWogkrEJOlelhlZ8qzR2RUyoaZhFbUW59OCXEg4US7CVJK9L0
         2t5w==
X-Forwarded-Encrypted: i=1; AJvYcCX6foPfUJ55DI599PF76oW42XdDMg2EIu3em1f63SmxSZ6w+KGZFEueRU2+Z8bVnmCTEmN26mDrP4POPODKDDmWTJ1mhQ5TkB+kJlP3
X-Gm-Message-State: AOJu0YxI8jGTd4n4QiAYedaz/NChGFCSlBkuTY+ejv+0eCtH5K5PUTUl
	TC35zTEWfRDxYyX98Be7whxbG4vzdrBYJPkDme+Dq75vE52wk9QPfkTUZ3G6aVw/evM4qKUuZuW
	QLwUMydfeO9830bTWo3wIkk6cdrcLMtr2T9JAlOBeKifUOvpY0A==
X-Google-Smtp-Source: AGHT+IHi0WRCyy0hfXntdP9fOgJics6qo6yRFtxu5900HRgUIkalDbX6u/kMOlWrMNVOe5jOJ37CCErOZk8PCBkiM20=
X-Received: by 2002:a05:6102:26ca:b0:48d:87f9:e529 with SMTP id
 ada2fe7eead31-48f130cf92emr6024383137.29.1718872368720; Thu, 20 Jun 2024
 01:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com> <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com> <ZnOsAEV3GycCcqSX@infradead.org>
In-Reply-To: <ZnOsAEV3GycCcqSX@infradead.org>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 20 Jun 2024 09:32:11 +0100
Message-ID: <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>, maz@kernel.org, 
	kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 20, 2024 at 5:11=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Jun 19, 2024 at 08:51:35AM -0300, Jason Gunthorpe wrote:
> > If you can't agree with the guest_memfd people on how to get there
> > then maybe you need a guest_memfd2 for this slightly different special
> > stuff instead of intruding on the core mm so much. (though that would
> > be sad)
>
> Or we're just not going to support it at all.  It's not like supporting
> this weird usage model is a must-have for Linux to start with.

Sorry, but could you please clarify to me what usage model you're
referring to exactly, and why you think it's weird? It's just that we
have covered a few things in this thread, and to me it's not clear if
you're referring to protected VMs sharing memory, or being able to
(conditionally) map a VM's memory that's backed by guest_memfd(), or
if it's the Exclusive pin.

Thank you,
/fuad

