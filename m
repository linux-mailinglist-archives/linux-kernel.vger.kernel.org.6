Return-Path: <linux-kernel+bounces-342711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA9B989200
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 01:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB7F1C21C10
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 23:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F155186E2C;
	Sat, 28 Sep 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJPHM1N8"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6718654
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727566004; cv=none; b=hPAElsP8MuPPmgkzBGAAdpHJ2J6YJwI+HoTGwbsaDzfHVftfVE9PqLLOfw9X95DyJzeKNGYKmiy971Yxfv/f5ZAEvzkN5xlzjAVdjeP9KJ33OGpfo/HUe5jpHocby+5Zx8oALD8BriS0eNuBffM+0YVRO7ErXKmpm5kdzhylD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727566004; c=relaxed/simple;
	bh=NWBwFAR5Ik+IG8bbMy7WMmwPVqCgbJTOb7GVlUolyvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMnTB8MzuX3GX7yUnCeyBLxGZGg0wp7XiPOlD9jNAe7qbwlUK5jtsRrRm8ecF4CA1dnfKaTmJOljBYg3ig0LNzPr+LddIz61JO3H8rP0HYf9d6LrjgE+5Q29TAJ2lgDLdOmmFnzVsgZUu6u3lmwdolpW7OWaLY7iqpu9xiKexh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJPHM1N8; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cb54eef205so5178336d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 16:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727566001; x=1728170801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWBwFAR5Ik+IG8bbMy7WMmwPVqCgbJTOb7GVlUolyvI=;
        b=AJPHM1N8V/Y0L8OpMAM1oA5OlBYJuuAhrzVKV2bmbeAmu5beHG5oqw8TaqEKzYQg4s
         e4P2MghEOk0ES6W3tMWhOLD3+/H9K37f/S2DLW7wkMB9/OVhFCIKajef2vHGki1PxWZm
         ielYdZHCJE51hbnEZ5Z4vRe2uEPXTTg6+mUq0ie9fSjEQWNPZaa+P4sjwCpsXq4m7/Rk
         WMJLzgk3k4fx/HGqeEh5hCjmxzfew8hqJ8z5qunTWwLCDfvtxi4RsW8+Vj+xUhjFp0Z1
         QzRh68EiDtGVHujl4eYcyhUuI7qdKFF2ipJSUj4fzbE0CkRuNFjdr41sbkVQKX4y7tlN
         AmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727566001; x=1728170801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWBwFAR5Ik+IG8bbMy7WMmwPVqCgbJTOb7GVlUolyvI=;
        b=U3mGxIuEpBa4gZ+Sv3Rq4BDHKNDTr0LDUG1Dw4RCUUh6CnA0sfx6o6poK5CUD+vrWj
         +eoq/rTQmgOO3jWEYQRIa+rB59LO2g71rXuHUO5bsQ4kHUVJYdSr3itqnItnW2Tunn/P
         0VwjgYfv57iGVBylAuKrTlaLIBsJJnkucQxIla8IC6YRjmpsWBdARKHEJvAR7i3ztJAr
         Aek1ix54KB6iAl5Vyy5qODNIo2iYHfsRCQzihELrAc7MzimXbdm3xo0iqDbw4ryBy82n
         gwXL2jWG0rQBsd0G5wsakAETUykSQ67qIe5oyjPz4ptfAC3OqXACpDGoK0Bb30Tpb+0i
         Lk1Q==
X-Gm-Message-State: AOJu0YzoF8FIsSuWDdRDKd8sdVqW516NU9XXX/+mH5CWea93joyw3PDl
	y718wOI/xlu/Irte5mBAMfV2eAnFJjtPuVOQfU+3pXDfEAw4+4Zky7ZtsA5EtoKvSAhYQlQBZAR
	FDNZyfv8mprXKqBMyqjtMtJRXi2s=
X-Google-Smtp-Source: AGHT+IHYUgCIc63IqxiuuY2XZ5p0a6uGfaFwjwZFIA/gs9PifTlgRHT6xQafXPDfTM5sfn0U3gtjyjfeVyOiqMM8r9I=
X-Received: by 2002:a05:6214:458d:b0:6c7:c63f:b414 with SMTP id
 6a1803df08f44-6cb3b6407b6mr135464656d6.33.1727566001312; Sat, 28 Sep 2024
 16:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com> <20240928021620.8369-4-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240928021620.8369-4-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 28 Sep 2024 16:26:30 -0700
Message-ID: <CAKEwX=Nyvrub+wL7Tn9pSJms=d3_U-8SVmcm0N5DJWfW-DBUeg@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] mm: zswap: Rename zswap_pool_get() to zswap_pool_tryget().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 7:16=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Modify the name of the existing zswap_pool_get() to zswap_pool_tryget()
> to be representative of the call it makes to percpu_ref_tryget().
> A subsequent patch will introduce a new zswap_pool_get() that calls
> percpu_ref_get().
>
> The intent behind this change is for higher level zswap API such as
> zswap_store() to call zswap_pool_tryget() to check upfront if the pool's
> refcount is "0" (which means it could be getting destroyed) and to handle
> this as an error condition. zswap_store() would proceed only if
> zswap_pool_tryget() returns success, and any additional pool refcounts th=
at
> need to be obtained for compressing sub-pages in a large folio could simp=
ly
> call zswap_pool_get().
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

