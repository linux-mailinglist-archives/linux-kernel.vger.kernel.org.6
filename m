Return-Path: <linux-kernel+bounces-337683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9476D984D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49D21C229AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A4814659C;
	Tue, 24 Sep 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8igH0Ap"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0187768FD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216175; cv=none; b=bkH85kTLVn0dPYis2FKO5YDk/lFlMnNNzH7iUTQSDWhKjDlPhCGvYNEac+hP5Dm2gdFS3o33sDECy9T0/+2ONhGv9BALnVTeqrRX++VDVGxKO+JxFc6NzXimPM3qouM+EVxw9U6lSlrJ48ouTXKpG/NrKa5T6EbxvEHlc+L7Vw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216175; c=relaxed/simple;
	bh=txeFjNw/6Qh5cqoMHgv3o9+mu42DVvB/pzMKlMLnc0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+NdFDhLy3YoeKTBQYvhk2s99NYafTr/QKSS5EZQ/9fW6rlG4PaDaNy/IE/QG9tD3bP+zNlavcMtZy+VIwuVm9cMTl+UFlJViN4bekUclH8unxex2UNzX1X2eglpT0FSFLu0UwQhjVyL86IvvlG8kJ2yF0TC7wD8eb6Igc6uopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8igH0Ap; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c3567a143eso48364566d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727216172; x=1727820972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txeFjNw/6Qh5cqoMHgv3o9+mu42DVvB/pzMKlMLnc0M=;
        b=Q8igH0ApPdW+02PnIOq5QlLxPj9Bmfq7IIGg0ZDNZnbPpf5Jp3sqA9GKKj+icYA9ZG
         Bo7xcWabQsmUlHL2NfJZE/rGjFOeIJ3E36iytfBeLNlR85B94gNuUIYLYrUSRSu0E39D
         apHYfOJB+qjYE4ySIBwjo3DO2mB2zYOrEAR5y9dHuE25s8FVwBKEwIJQb73oDjd3ZElp
         rMZ7T7wrc+X6aYYzWtK2JLzuxCwz16kWD44JtBp6DaLgxXaCaEeNfAahKLAbdBbLU0aO
         U0A60UgHln44UG76iO/YPPc8MGezE5Boe2HI6BdxJEqpsUClTAqS6UzunO2sI2IROwt0
         6Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727216172; x=1727820972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txeFjNw/6Qh5cqoMHgv3o9+mu42DVvB/pzMKlMLnc0M=;
        b=mwJuZ0BCWfJOqOMSopOhc12EP4yrDXgGa2JrlbN+KSs154iSkRWo8JH3VWTNEB8i92
         GYo9YLTsVsYiIDxeIyFHLOyWIYIrayJ9ahZP6y4IvhJT56CAs3atvrLS4j1O3oDbhEfI
         XCuz/x60jBIr/yxXay8WgKfej7lNS7+DstcGm5IzuG9vWzlFyn3xhfzIfzDzzq5CYfMl
         jKlPtpH4PfIpxQRRsmOroafJYGXmc7yw+FQNknjvSHzld6lzxraresvxwpxrm6nLNDlI
         tRDh1Y/FGUmNPKtn+xqo7tNszbzuf4JO1Z/vd2kgYcRcWKMidJWXpU4bIdKMSII9WVfM
         CgGw==
X-Forwarded-Encrypted: i=1; AJvYcCW/+1dkrkrQY29Wq6bzetwF7/F38oqMSeJaxT1EEt1vUAdyoPZzGj97tZveTPjXpBjPCRIh8qorU2Fq7N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtMTnFbsAdsxZe0Wjfieuy6vOnKj/KZrRzE9pyFF222wmE/5B
	f4Z88JQzRMO6kCgMGBhZRWK45mt8k69ulvTwPbDrCsSsYxlXi1COhFfDW8d0c2YNjIT/XQrI3iB
	tjplIYIHCzHJGEhNJ8AZo/ItBmo8=
X-Google-Smtp-Source: AGHT+IH4vxzFds+3F9h/A+qskezZSIuAqbvb41wRwBntXHr9rWqwFYWLvTsi4p7Ia30Sg2LeGBQLV9SCFXfHMtDVptY=
X-Received: by 2002:a05:6214:534a:b0:6c3:5a86:6a29 with SMTP id
 6a1803df08f44-6cb1dd6b2a6mr10609246d6.21.1727216172278; Tue, 24 Sep 2024
 15:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAKEwX=Nw_ax0RRSaD9n3h1vqbu+5PEuur3RqXrMrYyvOPuzB3Q@mail.gmail.com>
 <SJ0PR11MB56785712C0EF98B7BE558720C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=MgpP_w6JFC5ahVN-erCWK2NDGSbxNdLxKg9P4yd01Unw@mail.gmail.com> <CAJD7tkasC4n+mE=q+L9cjf4342eSkOQPeeV1wzBKxTp39wnZJA@mail.gmail.com>
In-Reply-To: <CAJD7tkasC4n+mE=q+L9cjf4342eSkOQPeeV1wzBKxTp39wnZJA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 15:16:00 -0700
Message-ID: <CAKEwX=PV4uwP7jyxYtThPGe8SFSchBXZGwxqvCr4YTWgYjtqYw@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Yosry Ahmed <yosryahmed@google.com>
Cc: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 2:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
>
> Why can't we just handle it the same way as we handle zswap
> disablement? If it is disabled, we invalidate any old entries for the
> offsets and return false to swapout to disk.

I think that was the suggestion.

>
> Taking a step back, why do we need the runtime knob and config option?
> Are there cases where we think zswapout of mTHPs will perform badly,
> or is it just due to lack of confidence in the feature?

Fair point. I think the reason why I suggested this knob was because
we observe so much regressions in earlier benchmarks, and especially
on the software compressor column.

But now that we've reworked the benchmark + use zstd for software
compressor, I think we can get rid of this knob/config option, and
simplify things.

