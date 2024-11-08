Return-Path: <linux-kernel+bounces-402328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538069C2672
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BECB228D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476F01C1F15;
	Fri,  8 Nov 2024 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soawqbLQ"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23C1C1F0F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097474; cv=none; b=WPikp2X6vJdSimZPGfR5OLrqfteYkoRN4PxpwA/xK2nfk8Vsz+6RhVCRhRMg7XDFKMq+VaXFqxWva2f/aNupr4aOZpnxDwzwbrgVNTzlecB/fQqj3QSV2CykHrokNFNORFz3wlsSy5SVNDY0yNttuWxJ2KQIhkOPfETXnReNBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097474; c=relaxed/simple;
	bh=NjWcx0U69TXGpkAnm8bJv29GUAXhA0iQfJ5knHqcOQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rW5aOnkdx1hwIjUfkIPdV5dgRxQvwmSRF6U/tfRQdEAVlVJOX7WIFj5xET3sWCXRVC+ejty1EL+Mbw5H8jCPRXA7//mizMkOIQiFHEi7szuBh8qYAVWJWvoG1NVBvrVBRehcoQIPH2zyCRhkB1ZuTspQrcPLDOz/SFim8JJHc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soawqbLQ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbe9914487so15803686d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 12:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731097472; x=1731702272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjWcx0U69TXGpkAnm8bJv29GUAXhA0iQfJ5knHqcOQU=;
        b=soawqbLQqW2ksLAwSYlx2t5O1j49HAxU1aKiBAELfxK3INGU3jGl0+QMr0wd8V/bG6
         zdGrCMs5db98hYvWPMC4F4lNqRUR/fOhrH0KqBDMXtg89lScZJZP6H37+Hw92fUJhQ9+
         eVmFjQFi/dFGN7pBCahM9gbRVy4h990zGNR7fJhyyQY30jtH0kjN0HPDZgGkdffRmKAr
         4wqu9j/I+De2hJiTLGvbTu2uza6zKji2hRVvAQDLQ8elme6mhycwhLS1IRs/303NOUpO
         6EotJXuPFJejS8/5bd8Ua4Ez88YkUR3wsYG3ba2JJeZXfVlPzrmLc66FujM0IUzcT0So
         EX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731097472; x=1731702272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjWcx0U69TXGpkAnm8bJv29GUAXhA0iQfJ5knHqcOQU=;
        b=MKSchk3U3ZNMdROcHL5FLpumOpm3X6cUJ62BLDALMKI50/Y1WloFhRZz5lHVQEMlZ3
         cwYEGBF1sf1VTecha5s/rPHDm6SRdiBmF1aGKBzYjZLrH9KiPYne6/6MhaEZnMflNvsP
         XGE7/MZ3SvzPE2RuUT9AO7pRsyrahgZzo1ZhtyauhmJckj132UKVigVE7Vpu0VQJh5LO
         G1+RqXaNnKS/tonPRkqjQOlAm1cycXNHVoQWCoU17Jqk5aZD9HxjSxqAp03b6iP2TWG6
         0tnZ0gtzpcee4n7Sy53xzubp1FcagLCBdCjVq3FemYgDTo8YxdsKJtvc2ffC6kamfLLS
         kCww==
X-Forwarded-Encrypted: i=1; AJvYcCVDVt4rQnYzNj1htvH0Kkfps6xhO4fRfnSQf7Z3djNb1i/m6Vl5gTlM+nwt1IIYB9Nn2q5pGP+vIqAY8bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzagiPT5Z2w0HndbdRsTPwjSvavhWzKuvz1iDuVyrreT8/7LzCf
	lYIEWIVbhwxi4OfEVF1a/M6TX/ZVuyxCY28wAKM+/4v159sYpoZaJMoLxtrTvWS9IHm8fUjsmpX
	9magFYaiup3FDVFUjPc/2KfGP4ThRpmQnYelwnXwhcyotThsZYQ==
X-Google-Smtp-Source: AGHT+IFTCXzZqbORIu77S8vltjpbqT2jiD2zFDJVpYKUMIQpdWZiXDw65WdrevpcMDyrDtwDYFhTKELCt2B1xRFsSBo=
X-Received: by 2002:a05:6214:430a:b0:6cd:ac54:7995 with SMTP id
 6a1803df08f44-6d39e1ee6a1mr58087386d6.36.1731097471563; Fri, 08 Nov 2024
 12:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106192105.6731-1-kanchana.p.sridhar@intel.com>
 <20241106192105.6731-13-kanchana.p.sridhar@intel.com> <20241107173412.GE1172372@cmpxchg.org>
In-Reply-To: <20241107173412.GE1172372@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 8 Nov 2024 12:23:55 -0800
Message-ID: <CAJD7tkZGBcoREDCbjczdLUtDgYt1Dg06Wk=N=ZGVqRzVBmoPyg@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] mm: Add sysctl vm.compress-batching switch for
 compress batching during swapout.
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, clabbe@baylibre.com, 
	ardb@kernel.org, ebiggers@google.com, surenb@google.com, 
	kristen.c.accardi@intel.com, zanussi@kernel.org, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:34=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Wed, Nov 06, 2024 at 11:21:04AM -0800, Kanchana P Sridhar wrote:
> > The sysctl vm.compress-batching parameter is 0 by default. If the platf=
orm
> > has Intel IAA, the user can run experiments with IAA compress batching =
of
> > large folios in zswap_store() as follows:
> >
> > sysctl vm.compress-batching=3D1
> > echo deflate-iaa > /sys/module/zswap/parameters/compressor
>
> A sysctl seems uncalled for. Can't the batching code be gated on
> deflate-iaa being the compressor? It can still be generalized later if
> another compressor is shown to benefit from batching.

+1

