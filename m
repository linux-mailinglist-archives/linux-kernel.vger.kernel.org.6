Return-Path: <linux-kernel+bounces-514729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DDEA35AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9593AD976
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF0C24CEF1;
	Fri, 14 Feb 2025 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="054Em+Sa"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C7E24A051
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526880; cv=none; b=NU892Xt5MNuKkpnHu7WXvxRw+/Ts22d6r8XxztXbWujJ1+nEIyfMzmq70aqlPlImjqUHwnwVkv+pLgpDnegGIY//8FmA0OFo2zXTZm61miEZHvve0RtMIycq1sIvt6ulJjKqarHLlmHochRcusIq1UCPI+oe3CDNS4MlxpLDzv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526880; c=relaxed/simple;
	bh=ly8j8/nkY6+jvSJH4lhGrcOHHyKgUw3Mh/g2OjknIOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrEF7jmgpCuVXm587zTcAx+5rQ3MOuTXQc4S/FOmZ8nKCFltMAQabPb4B50o2jz41ZO+1twoSixvXBQKJZV5TH1LWHoVFk9mSd8yYSxONugyzk09x3ZfphSo1a3BY01Ll00LctrXtJQwnSI3neGq7Tb2eqvm9ts8OmneF5XCFj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=054Em+Sa; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4718aea0718so260471cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739526878; x=1740131678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ly8j8/nkY6+jvSJH4lhGrcOHHyKgUw3Mh/g2OjknIOQ=;
        b=054Em+SaVcC+eSxneoK1WYFqjl8ONHEhQ8DMaHKnSx55AkGTCrUCTq5OO0f+0BQk1D
         QxuOL3zcVRZr/QvNCNJIF9U0swWjKQsDWFG747zVXbq8tCCVrKssemdOdKArf/+1O3DN
         FgU8UuyIErAAWiVCcpOTl0QXXaXnHWbaBWSlhrWPOo+NPg7dkPWxm0TL+m2uBfoHeKpO
         O4ShbSg5nsveWBNSnxaUzYEhjq9yvsZIjL49CLIpi0GUahbg2gvY0affgEy74/fC+ndC
         4BZq5r6VMEreAMDv5qdgrmz4tsjC3UEdTPuSA9X/FZUIqerC8xTgD15Yps+FA57qUABI
         7Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739526878; x=1740131678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ly8j8/nkY6+jvSJH4lhGrcOHHyKgUw3Mh/g2OjknIOQ=;
        b=UaFGEVyRRq7yR7fYRhBn5r1xzLHh6MPw6sgi9SeqdHfXsYKLvaFCama5mrZrWwxJG2
         0bs56Er91MnkIVaRD55I9QmQRCtqyAopFiC0hLNeP7O6xs50SoJXHNom56K199AP3am2
         bu0zKF/CsHb2Zb0AJ40hdyQkyoegqDsIOaJlDkYIQQP3etrZ6a7N48PCZI+i75K99yTv
         vz9yhFsxSdiejjpryFJN9716WWmSxd2LwNsM7F2r3wDB0HlxydP3tS9f5Q3xefb4L8hk
         lMPtwSH4pULpkw73EbQv5CX+S3uRl9eQ54zcNFAsup68E2GNfKrE2cELUAwkOSwbGwcr
         crTw==
X-Forwarded-Encrypted: i=1; AJvYcCXmYS9VRGYwW4kYk9VqJe9vGwky9FOgza8UJjLPuv8Wr2bfBPissx1VXR9s8us70tXDx4q05gK+ikILpAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0mj4CU0LqUVv1J4VV4sCm4qBYOQjw/BjStRny3qEbuzYQkIIL
	VfL8lzQkrulPV1WE1I53HLFBwHS6ZkC8p1esbeHr+tlYX9aarKvV3RPG3NmwtAuwB0p8u72+0Hw
	9HYzLti+NGAF5jp+pB8NDqiOjmBcB+VqITJTG
X-Gm-Gg: ASbGnctJLyqGAWDkE6Mc94HNMwjjpXfzuQYjWJQb3UN6wLrPdw+26YqMBDWddtsRpb8
	/3rW6k7o2tfaod7sNB2SAEDSI+DiZ8nQPpuBPGFPHlEXBEKN6zK0C23l2NShFGvbA8uHQDhY2ki
	doUrk5KeqaeOkCUlA8E6j3BJk8Tw==
X-Google-Smtp-Source: AGHT+IGgjgAkvv66xcMInIhtIjzzSfRevKcfKs78NUrnh0ATMgg0OYB9CxDGQGlLDXspdtJUZBqivX7xZKSBznfyNrA=
X-Received: by 2002:ac8:5952:0:b0:466:8887:6751 with SMTP id
 d75a77b69052e-471cf967e8bmr1894501cf.23.1739526877615; Fri, 14 Feb 2025
 01:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213161423.449435-1-riel@surriel.com> <CA+i-1C3DRvustO9eH4PFyASD_SRoR4iv22BMfvu9BSKDK_SFLw@mail.gmail.com>
 <5d6130a40f173e341306faca897a0e42f8cd5a20.camel@surriel.com> <20250214093648.GC21726@noisy.programming.kicks-ass.net>
In-Reply-To: <20250214093648.GC21726@noisy.programming.kicks-ass.net>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 14 Feb 2025 10:54:25 +0100
X-Gm-Features: AWEUYZnK84KEsQuGPFXculEEmjqr-IgJ6rAJLNoIOZ9fjAAyKZkgxeTx-kMRnoA
Message-ID: <CA+i-1C0MgGxRF0mDsXdTf00u5CZojQfA7rBtFGQXtnMo_UNb4g@mail.gmail.com>
Subject: Re: [PATCH v11 00/12] AMD broadcast TLB invalidation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	bp@alien8.de, dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com, 
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com, 
	mhklinux@outlook.com, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 10:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 13, 2025 at 03:02:40PM -0500, Rik van Riel wrote:
>
> > Peter, do you prefer a v12, or should
> > additional small fixes and improvements
> > just be sent in follow-up patches at
> > this point?
>
> I think I'm mostly okay at this point, but DaveH was wanting to have a
> look at this thing. Dave did you get around to reading one of these
> recent versions, wdyt?

I was waiting until my nitpicks were resolved but if you merge it
before then, please add my:

Reviewed-by: Brendan Jackman <jackmanb@google.com>

