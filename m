Return-Path: <linux-kernel+bounces-344978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E198B0D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8291C2132D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FA2188A3B;
	Mon, 30 Sep 2024 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae146OFH"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99C5339F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738988; cv=none; b=PnkVsqXNAnmaN04YPciydLrSLu4J5arLIZOYsanUF1boSNBCX/PJpbwJfgsbFhc/bGX6530GJUE0lSv+JEBgbPtNHwCVCTtQF27TlN9CVaMThNv/620IoH9tvzXPXYBEgxJGXV4eAkVnCE9/Xex6zFlWvsTM4rawXEPhw1oH85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738988; c=relaxed/simple;
	bh=RVg3iqUyEVc42GO5p5mggpA2AYHoSPqXb5lX4xc8TZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7rCkx8xP4Ktr83k+U/m9j3Jr+mn4iCBV0vqRbX9G5YQ5v88XPr+ti50bfmNJOb13NjXFDDpodj8l6hNzJxT30GXefJIwY+TqXdVI3+jIA/i0O28f+DQEZwNUwzyIeO+pNrS9uRKET07Wppei4c0Fpvw4KKLI2OJchTA8URdrUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae146OFH; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c5acb785f2so26919406d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727738986; x=1728343786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVg3iqUyEVc42GO5p5mggpA2AYHoSPqXb5lX4xc8TZ0=;
        b=ae146OFHfSBBr1zzDzrRkZmK3pxXXMV9QsWpmKfIX4vsL3wVbkxK4Fjx9PgSd2FUje
         NqoC4H/3JHrNXhew3EQYnt4Wd1oDeEMsgg6CwDwQuarNH0tVH5Zw6dgYMMNVKhr9KWfl
         hcMEbWEbmdsIrqn4W1/zc0OhQlCgS8Up8xK9i4ikVYfJrmL76uxLwuepniJA7rsu3s/s
         lk+Xz/zj2zYxN4NPkL5mmWPNj8pzZd43HOv0GMl+NSLrnwc+ButnNE+10q67h0e8FQzv
         j4jA3eTuyINy9G2rrbXHa/zKtw5Cw8134m5X0yPkprXdsbxF1iMO1LFpLAV2ibWGpwa3
         KcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738986; x=1728343786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVg3iqUyEVc42GO5p5mggpA2AYHoSPqXb5lX4xc8TZ0=;
        b=hryXoVCPxlG/6ap5TpLSJrC3tlm5Kg8b9Tjucgn82ItoNAyn5ZgmAfoFi0nmJzxHqV
         Cld1755zN1W2mGuu1j8VNsLVNf85N/FxLgCpm4HtZ7c9TLL3a10x6gY8OoJEUgbLQfMx
         P4R3AKu8QNCMHQ6pLFXfcRQXlutspTN3fMOUBaD4H9GntB8PUTjb7VnuIl13ryYbygyF
         N6Afy/WtFcX/BG2qOwLcM1wJvL4itc+PB3a5BtngrVZuX+qiyIW2C6jcNHUbxWvriTOL
         YjDeQJv2fR3lEi5q/spMQFe9YHgvkPfu9DavoLd2SnuuYsoeOsUpCHWw7PzhMoBqLm5f
         KNAg==
X-Forwarded-Encrypted: i=1; AJvYcCUpvJmkpGKnApFdZmqOSboH8tfsQ9wpNd1ZldfdL6uW7aFmfHz8ErOD8YjgdGxOEmeVv6EMyyEBRjwut7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0wLZ3TmnAP6CvNpoIpES5HkQMBtRoGJOeebFB7eGIRexhk3aJ
	L79YXsaQ+6PkccYgC5qcdXIDJFjXoWcps2QvwLlPWlCyFIxBlyAJkJNwtapLOlbyQ0YkBYE2sfe
	z0f4IgEmDC1GCNvo6csVnP5qYsTA=
X-Google-Smtp-Source: AGHT+IGvWFD/0j7RApmHvPmT3hQD1pg2b4JXNfPkXBacgAnRfdPOJWcs8hnwNSl+TkmsuHU3eRYKBglUMBhmvQrk+VE=
X-Received: by 2002:a05:6214:5b83:b0:6cb:4713:9df4 with SMTP id
 6a1803df08f44-6cb47139f3cmr163529086d6.4.1727738986139; Mon, 30 Sep 2024
 16:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com> <CAKEwX=Podz0XkX4=sutZk_nRTPy_aQ3JSVUZ9GNxPbX=t7R2kg@mail.gmail.com>
 <CAJD7tkadrmzUHMXRbeScq+ekY1AJhjrSZ_mZtt4H7x1Z=Ad=UQ@mail.gmail.com>
In-Reply-To: <CAJD7tkadrmzUHMXRbeScq+ekY1AJhjrSZ_mZtt4H7x1Z=Ad=UQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 30 Sep 2024 16:29:35 -0700
Message-ID: <CAKEwX=PBaioXK2iBjzjUHVeCReqCCNG3+qyhLcb6SDixbYbaLw@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	willy@infradead.org, nanhai.zou@intel.com, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:20=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Sep 30, 2024 at 4:11=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
>
> I suggested this in a previous version, and Kanchana faced some
> complexities implementing it:
> https://lore.kernel.org/lkml/SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR=
11MB5678.namprd11.prod.outlook.com/

Sorry, I missed that conversation.

>
> Basically, if we batch get the refs after the store I think it's not
> safe, because once an entry is published to writeback it can be
> written back and freed, and a ref that we never acquired would be
> dropped.

Hmmm. I don't think writeback could touch any individual subpage just yet, =
no?

Before doing any work, zswap writeback would attempt to add the
subpage to the swap cache (via __read_swap_cache_async()). However,
all subpage will have already been added to swap cache, and point to
the (large) folio. So zswap_writeback_entry() should short circuit
here (the if (!page_allocated) case).

>
> Getting refs before the store would work, but then if the store fails
> at an arbitrary page, we need to only drop refs on the pool for pages
> that were not added to the tree, as the cleanup loop with
> zswap_entry_free() at the end of zswap_store() will drop the ref for
> those that were added to the tree.
>
> We agreed to (potentially) do the batching for refcounts as a followup.

But yeah no biggie. Not a dealbreaker for me tbh. I thought it was a
quick change (hence the fixlet suggestion), but if not then let's do
it as a follow-up.

