Return-Path: <linux-kernel+bounces-181221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001A48C7925
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A56283A70
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBE514D6E0;
	Thu, 16 May 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9jJV8Y1"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1C14D452
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872621; cv=none; b=nkqMooZPTKR+q2ZqD1qDALstTqi2M14/ZMWTHkBWgIYhT8lG94X9lYjgqk6/Zde/Yz4caPGEbs2+r1MwHTynXdcl4RjZ7wHzl7YCdDBWtWiq7/NWL1WJ/ERi9GAxzR1KKbXyqdFRwibTShS57+oh8mHkwv30mH5eye1+912K11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872621; c=relaxed/simple;
	bh=ZXs22x8gjkyO5FvWfIYFnYooRXNq/Z5RnIzauYycA2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHjGvHV4sx/LtuYV066NCaJy+Cxhu5xHxOPjMq+vkbb5ybV5xc4I1MDUvld/u01NMkPhb8oFFWrt38WnGhGXYVx4dbuXsnEVxepf2m1OcxepiBWCZkDF1vYPycjdjSZ1oBMWtFj8608q3PkL9fvNnf0tzD2XtjjKgK5Blszi8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9jJV8Y1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so10421a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715872618; x=1716477418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4aYJn/xV/PKWXs5PNzajPV5h6iws4xgG9CE/ZAuxU8=;
        b=O9jJV8Y1NfSroH7pVBI1a0MwoviYauaTDffLSrwHr2ANL2cwvNsI96mZEZwTI9pAds
         gCiIFDAwYiSSz5n2BPRulynH+x9aB+dmA0l7Aus8N3mCNcaEmDeJ3MGVXzRyWKjnQ1/S
         j6sbtkwDE0FGG6Gf98vXQpR3lkExREtyhz+oNSEeewpK/vx0tlJqXKjqeKuPXxt/dFPL
         aA4WFw7MphbIdnuGKeOcPnITQdPmN8ogDcpVB/mtYBU5nnYfi2kMMsduzLGjN4Ab/wJT
         giZYJCUD2uoyWBYbd6iuSFMFFtn6w5V8tfTh+lV1f8OwmgQ+yie8V19JMnOSuhgCvjy7
         yMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872618; x=1716477418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4aYJn/xV/PKWXs5PNzajPV5h6iws4xgG9CE/ZAuxU8=;
        b=kQIEDC+rDuyh0SdVghGPH1bMueOWptmTeO3PQ1D+y+D+9QW7CU/b0fFCLkN/MXDlaH
         eS1lJoDusxsoyGSY47xkaN/LlGw96CCBnmxLbCI75KeQwzUBMTO/2FvO4kk9V2lXg81G
         onKB/aal/5CjtqFt7Rb1R/OoRVE3e0QqIelhom+ludd6/6i+PsL5mAheB2S5CfONRTR/
         0oDUJFMbYW6oCeCyJWnI/l6WnNFaxGAytvo1z2H2jRgdlq1jV296fmADBFV4oK598wFH
         AseTCg+0X5SFob1O7Og00o2f6CtcbijSJJGWbNAUzRj/MXh20zUtcOPUYrsTfVKVLdU1
         sd6w==
X-Forwarded-Encrypted: i=1; AJvYcCVHusYEmozEjo9LFuqX7l+UBL3QdIWVk9NvJQl1PUnw+lztpNu0BxYEMrAI5xG/sqUnn1ItesRqpXPdmzTIjkcDHHvUN3jJq7EwbWiW
X-Gm-Message-State: AOJu0YzLTf1B5abO9nvI0f1BP16rPPEb4hwH1oDh3A6xzxotD8rPL4hM
	qex+P93pCQaD6LLLleneCxsi5rl6i0iDoAEXoYNOioKaMV72s9CLE+EF8WfNZ54NxnVf58JCxht
	2jReZrMrbKO2V860w+KLRFBybf0hySF/vGElewj+n6+Btu1WGZw==
X-Google-Smtp-Source: AGHT+IHMNTC40XpTvgL1XTSP35Cv+n/Rhk6HldIuh2H5A/OEKFOgYm6M15rG805D9tnLx4WQjYkOJaxE+AAac13kuWk=
X-Received: by 2002:a50:c90b:0:b0:572:a33d:437f with SMTP id
 4fb4d7f45d1cf-5743a0a4739mr1000638a12.2.1715872617792; Thu, 16 May 2024
 08:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210416180427.1545645-1-dlatypov@google.com> <b7155efb-e99c-f385-3bf3-3ffcdefd1260@ti.com>
In-Reply-To: <b7155efb-e99c-f385-3bf3-3ffcdefd1260@ti.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Thu, 16 May 2024 08:16:44 -0700
Message-ID: <CAGS_qxoSgEGThm3RfSc2jXrCUFwSs6HnfNcsg+EMMvWYWRbKWw@mail.gmail.com>
Subject: Re: [PATCH v6] lib: add basic KUnit test for lib/math
To: Devarsh Thakkar <devarsht@ti.com>
Cc: andriy.shevchenko@linux.intel.com, brendanhiggins@google.com, 
	davidgow@google.com, linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 3:19=E2=80=AFAM Devarsh Thakkar <devarsht@ti.com> w=
rote:
>
> Hi Daniel, Andy,
>
> On 16/04/21 23:34, Daniel Latypov wrote:
> > Add basic test coverage for files that don't require any config options=
:
> > * part of math.h (what seem to be the most commonly used macros)
> > * gcd.c
> > * lcm.c
> > * int_sqrt.c
> > * reciprocal_div.c
> > (Ignored int_pow.c since it's a simple textbook algorithm.)
> >
> > These tests aren't particularly interesting, but they
> > * provide short and simple examples of parameterized tests
> > * provide a place to add tests for any new files in this dir
> > * are written so adding new test cases to cover edge cases should be ea=
sy
> >   * looking at code coverage, we hit all the branches in the .c files
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > Reviewed-by: David Gow <davidgow@google.com>
>
> Just checking if something else was pending on this patch-set for this no=
t
> getting merged?
>
> I needed this patch-set for adding tests for new macros I am adding in ma=
th.h
> as suggested in this thread [1], so wanted to pull this in my series and =
add
> changes on top of that for new macros.
>
> Kindly let me know your thoughts on this.

This patch just fell through the cracks for me.
I had (wrongly) inferred that Andy might have had some lingering
reservations about this patch (that it was too contrived, might not be
useful to have tests for stuff like abs(), etc.).

Feel free to pull this into your series.

Looking over the code itself, I think this still looks valid and
stylistically correct with regard to KUnit.
I haven't gone and validated that it still compiles and runs just yet, thou=
gh.
But if you do run into any problems, let me know and I can help send
you a fixed version.

Thanks for picking this up,
Daniel

