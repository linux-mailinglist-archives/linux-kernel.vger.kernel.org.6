Return-Path: <linux-kernel+bounces-294576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD44D958F86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39723B21AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E258D1C579E;
	Tue, 20 Aug 2024 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm0TUVRu"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C41BD023
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724188433; cv=none; b=sg4Lp3UVixhOTLRmIevAUdb/TfxuEPsd4ZfCKYFBWX20q1HdTptt3GvtiyyG3ApwB4G7fYUZEFBxJ3gvImJlqFdfqVvxFhEJfQx4Hm8pWZGdy64pGPZIF8ILhtP/epyEKI02/9yEXK2vw0k+WrHAx6kkoSboGnZhh9guAnBbYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724188433; c=relaxed/simple;
	bh=i4+1sMo/j3rHCjOJU20qLIIqTCnbIeNYA9x+rgF1IqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwpQOlZyr59VdM6c6p+3Jy68//ansEATFOTOhSPlUjPKjnNDYipIdTtQQE8WXEFDPiOxz843Lt6vsiQQHwO/78GLElXW3F2Qb+1RnRkEtbPQM78GmdWzmeinDNLI2A0XxIyN/uvN86iRjrynMUgzk8Wnqia/zrsPIjgiukrkfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm0TUVRu; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf90d52e79so20339216d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724188431; x=1724793231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4+1sMo/j3rHCjOJU20qLIIqTCnbIeNYA9x+rgF1IqI=;
        b=Fm0TUVRuPovpquyWTwkcu4Q6VWFCPpUrQW1+RioQC7kJ7V6pzmcyAf7GRwi8VCKwqF
         XalcZHqBNNyD2dh65UQtopRnoRcosYG5lr1kmgDTyW6AGZblTr3fZNnVgU5bIYmS97Td
         18F8j5q5FLc3ACRq4TDD3ui5Od2T9ksr1hA+Q6/ZNSpX91uo8OAmwo0GBBodwCE8DTJL
         JFG3tbb0lHvKMQkp2f/kC+uNW1xwixz8rBvSNS123PndpTNt5Njzy9BwMhHe3xXHtHF/
         g+0OKaYOHqIrrGvWzic0p7KUxyMxzJ+VsUKNETU7/ZEJ4hMBjfzKpVI3MY0M0k7DCHoy
         /DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724188431; x=1724793231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4+1sMo/j3rHCjOJU20qLIIqTCnbIeNYA9x+rgF1IqI=;
        b=SGs3mFzjn5E7GoW3Q0ObizrYeRLs3SsJpkY0rbPQBBTtG4Ml6HIbyWB4+LWqV2wfDv
         UrO0LmGV1/Mi+vYed6hgDfQI6Sp7GKT06fSjHdb08bgZre2d6Jb/WzFeJHoVBVjSGTX0
         3qlqUPKk65CUbVTy5cCXBpCZN8RNMBhW+PO8e0qZ92kJZosCplt8Lz0BkzrVIfWWMn2V
         KMo/Glo2nP8wjeLBK0/J11CK4zln2e2ai/v3z0g+vlR+6Gtxsf3JGMVm9UUuzg7L8EO1
         yBO47qPOhn7HHCI02BCXZfSizufDXnFnM3otGTHldIOzZzjTvqG64DaRtpMbxXxTlfuP
         icgg==
X-Forwarded-Encrypted: i=1; AJvYcCW4tCCMu2xaKmUpuuaH96gEWcllrX6uOLHVYXMoeD96v2xBolgHByTUMenB67yFbG+tq99yccldYEuReGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6vqx2kpD4fJmym+ZVi0Gl/FmNKZNohsFt2Gud2wilOyTrCHd
	K+BvJgfZC32JV8FrsaX7VCcYKB38XNv9Cf1/ZcnGQfs/yfF+rnQzsN9tX3/K3TlmzVpXDxmzHbU
	mqcqDpjJAy1tLKsOTRFmxAyvabRU=
X-Google-Smtp-Source: AGHT+IH5LhCqlcHaogryi3OZO09ag2TddBUFxoqxmseS7pQXzwm+Jyi+88iMYqUV1l9R1Y2dgvvRWwpJkm+8mjWrLIE=
X-Received: by 2002:a05:6214:4602:b0:6bf:6604:c867 with SMTP id
 6a1803df08f44-6c155d77ad4mr7442546d6.28.1724188430547; Tue, 20 Aug 2024
 14:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <87msl9i4lw.fsf@yhuang6-desk2.ccr.corp.intel.com> <SJ0PR11MB5678BFAA984BEEBBFC2FC351C98C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <87ikvxhxfm.fsf@yhuang6-desk2.ccr.corp.intel.com> <SJ0PR11MB56784DD616B595FC707E5133C98D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56784DD616B595FC707E5133C98D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 20 Aug 2024 17:13:39 -0400
Message-ID: <CAKEwX=P8o+hLsdQw_xKymgteLXsBPfDf4kGVKdgE=PNj=b0cMw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:01=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi Ying,
>
> I confirmed that in the case of usemem, all calls to [1] occur from the c=
ode path in [3].
> However, my takeaway from this is that the more reclaim that results in z=
swap_store(),
> for e.g., from mTHP folios, there is higher likelihood of overage recorde=
d per-process in
> current->memcg_nr_pages_over_high, which could potentially be causing eac=
h
> process to reclaim memory, even if it is possible that the swapout from a=
 few of
> the 70 processes could have brought the parent cgroup under the limit.

Yeah IIUC, the memory increase from zswap store happens
immediately/synchronously (swap_writepage() -> zswap_store() ->
obj_cgroup_charge_zswap()), before the memory saving kicks in. This is
a non-issue for swap - the memory saving doesn't happen right away,
but it also doesn't increase memory usage (well, as you pointed out,
obj_cgroup_charge_zswap() doesn't even happen).

And yes, this is compounded a) if you're in a high concurrency regime,
where all tasks in the same cgroup, under memory pressure, all go into
reclaim. and b) for larger folios, where we compress multiple pages
before the saving happens. I wonder how bad the effect is tho - could
you quantify the reclamation amount that happens per zswap store
somehow with tracing magic?

Also, I wonder if there is a "charge delta" mechanism, where we
directly uncharge by (page size - zswap object size), to avoid the
temporary double charging... Sort of like what folio migration is
doing now v.s what it used to do. Seems complicated - not even sure if
it's possible TBH.

>
> Please do let me know if you have any other questions. Appreciate your fe=
edback
> and comments.
>
> Thanks,
> Kanchana

