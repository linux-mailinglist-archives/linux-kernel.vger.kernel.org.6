Return-Path: <linux-kernel+bounces-180152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857E98C6AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDF11C2130C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35423182D2;
	Wed, 15 May 2024 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jav1Vgna"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7F1392
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791137; cv=none; b=QirwY+zl+4FLRXhTgmANuvseBwDWInHAUXMOgTkGkWV30WZ2X38nNom6Hq9Q1dhqRRAnZzp7UGRRCVHKbYoqRIphHVxMA9qIbdeFPaxRNMmenazK4DaXWAl1oQ597zs19oPTmniHMCoMjkp2H4jwPJ7z2oqPyH+oyrtHYcQEWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791137; c=relaxed/simple;
	bh=KPI9VgZ2mmd0dX0hVK8w9UXjBrAqVcPAvxeB5ge/uTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igcRH+htmgmnqnusEjSEqZHyraAblmAsTBVK8cePTgz7Usm//+3+C+wzwv5Nu8unWIOtnGMGPBf1OPH9wXBzOKCHxE5Ktx2gE9rn6prKK1wwmoh47gWfEeF1sIj3ydUBsNUwt9oZ1Xh2wVo7fa3S02kk3FdWLcaOVtqlIi9P7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jav1Vgna; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f0537e39b3so42079725ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715791135; x=1716395935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0dgdHCrIMriPbVZP/nU1ryCwZdRHPOElBl89QeX8QAc=;
        b=Jav1Vgna5yvdpP4Zcc6UsrHJ5OIQ2q4uC+69G52m9lPt4UZeNEcfS5LFcC6j8SGgQn
         9bTSSuwNrnS4psCaEqpCf9fTCOjOUNJB0Aol9IkTHoxbExTOiQZGbEZ3QhQzoovNUWJk
         kxZ32cfxLjNc8FdKAwk+2NhjdJO5MzOA/QdWacE80luXQMEwK+kpmj3Gi2FF/dUP2tJg
         ey43wUKHp2aEgn/DJjVSFE0a7Y3gx8zKLpKwZxMVLszXaUz6jCh05jrkV/zbUU6DV5ct
         SrOnQCrSjFQgXZkkPe22bwDWjZMUWA+DhUT/4hL8pdyUJ9Oj05bL1pHRqve9R/AQp+vB
         FYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715791135; x=1716395935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dgdHCrIMriPbVZP/nU1ryCwZdRHPOElBl89QeX8QAc=;
        b=HCMbeu7Q42rkrFQcK5nruKHgUWs23wMk+iZhG5+pc84NpfI1ln0j4uyMXWPyo2wN/v
         A7dJggLAlJcaCdTpqPh2bsA6R3Y6REEeojlaPLmlfnrd+rkkb4rBpWQjJz3ILAV2QsTh
         L7SF5W4nS6ez5JMXnYESc0s7OCTBNhE7TwjxrCBH18c35IxO+BN81ur7xQejbB53XHSB
         qZvzAq2PErsHs4SOOAWIZKgA5XQmXjF/XKicsqgVWRIhGQ0H50O7XAwfZ40N/AKJYu8n
         LQWggaKGFFhRQVrRd2HUnzZbini4Qh18/mPBM7A16nVPk23Ypjnz5lAOSmnmqrJads80
         IWsg==
X-Forwarded-Encrypted: i=1; AJvYcCXPYZ8aUwOBAX+LUEpHUITu+imEwWQC/Pa7ooc+uGXaoUQC24rrvurv4VAYZAvUs7zH1yl8qDQev1VfhDxFnL/KsSBZ8uYDvSeO+qk8
X-Gm-Message-State: AOJu0YyN3t3Sq4qqWPjdQkj/prBQD1Lgafz1IEd3fGvUbvEezDS4DubQ
	tZMQZBlZctICsxcemqNAXAzcNdF5ROk/nvi3Op21sGZwuEzFdsM0xSXzgnEf4w==
X-Google-Smtp-Source: AGHT+IH1RABBzSMouk4zqpSJf7xnHoKLuohGH/drZuiqbnsmiYEtZvAOUFI8wYHw0Ptc3i/xfmAxbw==
X-Received: by 2002:a17:902:dacf:b0:1ec:c9e0:c749 with SMTP id d9443c01a7336-1ef440505a0mr195053005ad.48.1715791135242;
        Wed, 15 May 2024 09:38:55 -0700 (PDT)
Received: from google.com (57.92.83.34.bc.googleusercontent.com. [34.83.92.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f09742d272sm5444925ad.168.2024.05.15.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 09:38:54 -0700 (PDT)
Date: Wed, 15 May 2024 16:38:51 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Tim Murray <timmurray@google.com>, John Stultz <jstultz@google.com>,
	Steven Moreland <smoreland@google.com>,
	Nick Chen <chenjia3@oppo.com>
Subject: Re: [PATCH v2] binder: use bitmap for faster descriptor lookup
Message-ID: <ZkTlG-ZNHRYXnHLQ@google.com>
References: <20240514160926.1309778-1-cmllamas@google.com>
 <CAH5fLgjzVHSAQBF5-C1BthK1jspAGRr1z4SQXdQepkeVL9Eq2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjzVHSAQBF5-C1BthK1jspAGRr1z4SQXdQepkeVL9Eq2A@mail.gmail.com>

On Wed, May 15, 2024 at 05:29:29PM +0200, Alice Ryhl wrote:
> On Tue, May 14, 2024 at 6:09 PM Carlos Llamas <cmllamas@google.com> wrote:
> > +static inline int
> > +dbitmap_get_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
> > +{
> > +       unsigned long n;
> > +
> > +       n = find_first_zero_bit(dmap->map, dmap->nbits);
> > +       if (unlikely(n == dmap->nbits))
> > +               return -ENOSPC;
> > +
> > +       *bit = n;
> > +       set_bit(n, dmap->map);
> > +
> > +       return 0;
> > +}
> 
> Could we rename this method to something that makes it more clear that
> it's not just a getter, but that it actually also sets the bit?
> 
> Alice

Sure, what were you thinking? I had picked "get" and not just "find" to
indicate this behavior. However, I'll take any better ideas. The option
of dbitmap_find_and_set_first_zero_bit() seemed too long for me.

--
Carlos Llamas

