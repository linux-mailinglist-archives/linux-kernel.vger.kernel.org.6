Return-Path: <linux-kernel+bounces-339548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0FB9866BF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50E01C21576
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7A613C67C;
	Wed, 25 Sep 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="n/aoaeQI"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F451D5AD8
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727292016; cv=none; b=RA/R1k+XthocPbspXs0soTz76d3fe1v1ytFN9PpmLsx01mFxzgh28YsmS9psg9+rzYH1RBgR+vyTfQjMwWCa75LRv+9ke8Zo3/IaA33ZLMO2+vM9IDLeIxSspHxycGEQcgAEH5O/WQRt+V+4fqspI6KJZuhvRRgbQTVFEhpLfXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727292016; c=relaxed/simple;
	bh=mMpXovrfFmHk9hOruK7bI4X3d2BOgX5PjYg+ImBW8aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWnCAYH9w1M/8OAbNkyC0IJHd5n2thImfqCFMZLcbe5TMb9Y68qWDTLoTGgveqD0G+5rXlK4AtAJPbLl+QPZbhl2qO1c2t3G/2zxIr1pOBy1VsnpvDWkJWv9arNaKuvuawyP7xkwXT2dGGMF2wfSUi3zptK0XP4HuTXjYOkV+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=n/aoaeQI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7ac83a98e5eso23138885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727292012; x=1727896812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHqvjA9JzcIDCVpMVQmDmm2El9iw7THV4P5WFIx3v7M=;
        b=n/aoaeQIDEqMDoLHuKFZ/mJ/v1VhQt1wzamXZUp0QC+eDB5/Kw5awlW6aWjghKR5Bu
         lzl4wGs4Kiog6yV2mqeuaDTZJrXo44ZP9/IKrgr6y8jMBWhuuUUKZgBlzmSWGY8X9RZx
         WJ44Nlqp1fAsdAxA6jhuUDYCvtTRYOhM62vjgmalVBujGtg6+uywtk8totBUrsDr8oK3
         ipbPhXHxWNLWACiN8rcCKcJUwDFNh/2wnCTQE5SLCjshQ38l4HVMs4tevU4lhQa0czRZ
         y48f6DrG1dwcbbyW1wVQ+absd34GtpoHxB9WTrqVLMoc+2X3wzJRePjc/R7WKjkIGjhI
         EKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727292012; x=1727896812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHqvjA9JzcIDCVpMVQmDmm2El9iw7THV4P5WFIx3v7M=;
        b=v38dHgZlATegZ8LmzBHZnJhSPuOSJ0uuyDe02PVe93TFprNTXYrBntWkLg1a9o7Zwi
         GOgKu1VQldizq/XIi9/VMvtIfZKsWgdm+dLSm1o9u24oW8GjjG8bgEBSPJ34mlvALZMW
         F7pZ20s36LROd2cp4X9XPY+MIir3+sFpy66EJwUmb+jSX5sJwiQziGhewepLZjEo3guP
         ECMk4XMn1kaFtJNQ9s3VHMurjrx/OsdbWnLzamaWELA0KNgYWdjW5OCKQ0nHg6lfNWlg
         rXJoYdcuQaH3eN8+Mwz+cAjlbfah5SCrryIQNkBoUmatnlT18IglPVC/q3BsWYdK8TSu
         LVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6uLx/wBaoUFhPd2okuAva7SYwpQ0BVqMytqR938EWYOXEVsj92O9UzG4btEwS0gvdeqOSLpCtuunyGPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAvrL5TwAmcjZZLPNW57tRxHsmKARR4DDW1vdQSRRubmVVqMw0
	n17uJ4jCVUaMNCZ7gcRUg8smokwcHib4BnfVQi9hjTrSs6nuIlwjDXlPnbX4PHs=
X-Google-Smtp-Source: AGHT+IFuFTFZNFW4SZzFiLQpC5a5fLK+Z3m7ODWpO20Rxiaotgm4WEnT0OB4ZJ3f9UX8BpeUR+UFEw==
X-Received: by 2002:a05:620a:4404:b0:7ac:dd88:cc80 with SMTP id af79cd13be357-7ae2c60d90emr118872085a.8.1727292012526;
        Wed, 25 Sep 2024 12:20:12 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5305a5sm200369385a.1.2024.09.25.12.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 12:20:12 -0700 (PDT)
Date: Wed, 25 Sep 2024 15:20:06 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Message-ID: <20240925192006.GB876370@cmpxchg.org>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org>
 <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>

On Wed, Sep 25, 2024 at 11:30:34AM -0700, Yosry Ahmed wrote:
> Johannes wrote:
> > If this ever becomes an issue, we can handle it in a fastpath-slowpath
> > scheme: check the limit up front for fast-path failure if we're
> > already maxed out, just like now; then make obj_cgroup_charge_zswap()
> > atomically charge against zswap.max and unwind the store if we raced.
> >
> > For now, I would just keep the simple version we currently have: check
> > once in zswap_store() and then just go ahead for the whole folio.
> 
> I am not totally against this but I feel like this is too optimistic.
> I think we can keep it simple-ish by maintaining an ewma for the
> compression ratio, we already have primitives for this (see
> DECLARE_EWMA).
> 
> Then in zswap_store(), we can use the ewma to estimate the compressed
> size and use it to do the memcg and global limit checks once, like we
> do today. Instead of just checking if we are below the limits, we
> check if we have enough headroom for the estimated compressed size.
> Then we call zswap_store_page() to do the per-page stuff, then do
> batched charging and stats updates.

I'm not sure what you gain from making a non-atomic check precise. You
can get a hundred threads determining down precisely that *their*
store will fit exactly into the last 800kB before the limit.

> If you think that's an overkill we can keep doing the limit checks as
> we do today,

I just don't see how it would make a practical difference.

What would make a difference is atomic transactional charging of the
compressed size, and unwinding on failure - with the upfront check to
avoid pointlessly compressing (outside of race conditions).

And I'm not against doing that in general, I am just against doing it
per default.

It's a lot of complexity, and like I said, the practical usecase for
limiting zswap memory to begin with is quite unclear to me. Zswap is
not a limited resource. It's just memory. And you already had the
memory for the uncompressed copy. So it's a bit strange to me to say
"you have compressed your memory enough, so now you get sent to disk
(or we declare OOM)". What would be a reason to limit it?

It sort of makes sense as a binary switch, but I don't get the usecase
for a granular limit. (And I blame my own cowardice for making the
cgroup knob a limit, to keep options open, instead of a switch.)

All that to say, this would be better in a follow-up patch. We allow
overshooting now, it's not clear how overshooting by a larger amount
makes a categorical difference.

> but I would still like to see batching of all the limit checks,
> charging, and stats updates. It makes little sense otherwise.

Definitely. One check, one charge, one stat update per folio.

