Return-Path: <linux-kernel+bounces-305452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B13962EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC09285AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5806F1A7AD2;
	Wed, 28 Aug 2024 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yl1hoI1/"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F01A4F39
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867374; cv=none; b=auirDL4aKbST8cB2nQ8Qjb2Pz+me+fl37lHFNkyGMXaGqDFZeOMgmwOtZNIbLIhDBajFu57GGbFg7EBdP2f4pTeheiql5cX0++8wK3P3nInhOLcheXHFueZRMizeMCjpopdaL5bPLm6rwxmpxKxw/LxFPoW4zy70fzA519jjxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867374; c=relaxed/simple;
	bh=aDE3/DKrfhnHsPGNKsCJRM7x+xvPEnRxpqQ1AnnBWEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Djq6XmAh2QUiNERIaKqQsLA6LYBTumbUyhOKRzYe7Qz/abAM2qZACJqAQkMiMLQ0V+y6bTAItiVm3roc1dyyQI6/Y3fsFPToF7Kdd6Z82MDAD3uNah8+SLqGAUosrA8DMo66JnleDrkGiuCqfqzIKtFRSuPybJ7VSjnEb7NKQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yl1hoI1/; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4567deb9f9dso20351cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724867372; x=1725472172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDE3/DKrfhnHsPGNKsCJRM7x+xvPEnRxpqQ1AnnBWEM=;
        b=Yl1hoI1/AKZX+2PZgX9yFpOqwy3oYnjGxeseiv5tD4RxStrr2bEhMA8xc1fI4/8ptP
         +ieCH5CLO6d1rBVhAhY5YF7FVXYulCngzSIFQW4mwNjQFoCXVa1VbitJce1ZQ56PalIl
         wfqb/csg23vsR5VxWra4TdE44B1XP8Z3bBMSL/GWCmlPx/UIb+gT9U/VNYV5QJuHGth6
         tovIzlyPBc6kANsG6nexaEtvXZRFoEBIDzd9pcTp1Pr6bCZcU1X8dESXAlVy4PpJwf5F
         4NJgkM4liEgm0A5ha5rpR0a3YG2b/jjP/irsFjBIJGCxArMWvAhZ7EBUlc6kCcLhM9tj
         zroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867372; x=1725472172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDE3/DKrfhnHsPGNKsCJRM7x+xvPEnRxpqQ1AnnBWEM=;
        b=WyZQZjcoEVGOhwC4a7rssnSr1BvSR5orM5Rcrr8Lavg63s4CDBjlX7xAFovQBiaN6o
         6Wpm9UxmXZuZaptIlpHCF9S0lJsQ/ALsFRFXAM9+maKAJE8zlPhXRu/MgZfXiWqeMgYW
         JoLUoML5KHf/XhHqH34i0Oml89xh0cKmJ7OeLdQ+e2dtuapnWsXW8gfoWx/s7nubyYWr
         CWgCVbGFhE4hfcaBX0UK/NTR7doJwI7LzsxzvV/JjelqgeVKqxSIx/fFPnT6qGNeI49Y
         9uO4X8/D/TX9p93Ift4llRsaJhQU2gPYbXQL4LMLq1Osyn9r1l3q/n+Kne9zFmawbr0x
         +TSA==
X-Forwarded-Encrypted: i=1; AJvYcCUcCAviBvZb7bkTSU8eef65tra6modWzQUgyV050lrZ9efRbRLHqUIXBAR7L0kwzW/cMuIQgMOccZWml5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpc+26FHiBWkI/bQzV7+Z0Hi7JOsXnIbL0Ie7hBJsP6FanHcV
	oM8pJ7mBEA5XEN2n0wHvv5d2kpHRjL6uvX6cqtOsfwP2iDgk0I1Q3dmVLdpQsVZImxADoxZkzx2
	deOgzk82ydRAwPJ21CHnHlk+seh1F4KAPCiwJ
X-Google-Smtp-Source: AGHT+IG4aL6108P6ITzETjngxN9DfIkjrJd7iPcDgQ+blSAFzi8AqbC0n0lCxGYQ4Dl+bUU1WJUlKUcFIvJPftTyGXg=
X-Received: by 2002:ac8:7d4c:0:b0:453:5668:444e with SMTP id
 d75a77b69052e-4567fbbbc61mr100361cf.2.1724867371883; Wed, 28 Aug 2024
 10:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-5-kinseyho@google.com>
In-Reply-To: <20240827230753.2073580-5-kinseyho@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 28 Aug 2024 10:49:20 -0700
Message-ID: <CABdmKX0kVYj6a8wntFoi1nZ0UfjKR9Y-oLfoOO_a_XhisuN-xg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 4/5] mm: restart if multiple traversals raced
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:11=E2=80=AFPM Kinsey Ho <kinseyho@google.com> wro=
te:
>
> Currently, if multiple reclaimers raced on the same position, the
> reclaimers which detect the race will still reclaim from the same memcg.
> Instead, the reclaimers which detect the race should move on to the next
> memcg in the hierarchy.
>
> So, in the case where multiple traversals race, jump back to the start
> of the mem_cgroup_iter() function to find the next memcg in the
> hierarchy to reclaim from.
>
> Signed-off-by: Kinsey Ho <kinseyho@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

