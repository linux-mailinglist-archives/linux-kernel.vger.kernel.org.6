Return-Path: <linux-kernel+bounces-574348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233EAA6E446
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50F73B50F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A611DB548;
	Mon, 24 Mar 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xAny8cAd"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E8158520
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847812; cv=none; b=akH8Cbyoz11Turq1aIseAnrjuQEdnU6+WVZykeNHd+a5U/wD/xscOY5MpWkPGq9Jd6fOkZg7hJtg4s8pHxvIzj6coqNUMUEIBdl0WuS1N92i5ckJyILrKnaOKvaDO6pnyKz53LtWRSmVIIyaFIeaK8Edloiat3KG0jq8goojFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847812; c=relaxed/simple;
	bh=FTVvZcbXSCRG4isEJ37AdJ6AjKt0CLK/juUcRo4yxHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taWp9MVeazMgtMrGRozU2YPsvvxu7msfYGx+pk7mOik/sKfvywrQaMp1f7PVC8FVI5p7eR8yXWetAmjJtaEQho5S1IhU60BfKKoTvYnSrZ25DQ9VgKOvNsv9y/ixCvPGqgh3xXQQnQED8qoIEIIjOlrU1sO4J0Gc6wP6R1fPZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xAny8cAd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240aad70f2so65065ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742847810; x=1743452610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw8MdqEuI16bDGqrLJKWmzL8QotMRkbFBhxUcalD3S8=;
        b=xAny8cAdpyLGz8FUPbg/Xkc/2JdpFcMT4Iq1fwc4Rd1LKW+B2L1v2PFOastIO88mTA
         Q25moB+M3tju0iEvtxi4ze4UgtOB6ObFFZPkZcWYtUyJxnLrddEIK0uKscct6O8/UpmP
         cSBQKak6iYnMrjUDCUc44BrjHWbtLWDGde41VBzVDKQhXnJjc/nRcwCD2TWhwhmMz/J2
         16ZTDmg/tP4B5WrOLYrLMXJtX8Zf6zO1wbPkogvP5t9HWYFCKVT4s5gIgQXDdE0cU3MN
         bntkFdna4O5rUC+nDCNYbDQ9a6Rje469GEYSdOykbrb/gNra7vDkf4MCq7a/U3bx2nFE
         5NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742847810; x=1743452610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw8MdqEuI16bDGqrLJKWmzL8QotMRkbFBhxUcalD3S8=;
        b=ePwGGl8lzJ62T32VSRWp7FleRYjrK7OKx5DNqPfvXJm4cOxE+gpC+j/PUApjBROPWG
         HnQmV8Qg9P6ZHcbtvEurwNSv6c4+ywHpwM1osJRhta+w66Q3B3inACtb95tK4/5x6T92
         /FMjn7bErlOI2MU5g8mj0pKULd2spvPh+AZimeW5Rr7pIyIT8K60csUQJqwM47VIFHjt
         RdhCGRMR5POHE8s2KauLYwF6NBArLnkMpFOi7KZKKpKcB7tbTz161S6r50Q11Betb0Bc
         zGdV/je2xycjXLyR8dhPQI3D/oVuGGnPlJXFOIko4LJ74CJydb9ZNuUyPrcDj2Gf9MRQ
         SNxw==
X-Forwarded-Encrypted: i=1; AJvYcCWFWCQokzSrqMTN5oHaG/m3TI72y2oKGBUEPHdN2FpUo6k9H1cZMFpKpXvHevexu89jCLYOdY8edgYHqh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ916vHKoSTvpbh37TY/wUG7voo/QmFClwPcW9wOmldHfQCOgq
	4iU8Jo9oS2Vq5DtprIhiKT8GSJ0A944GCZ1U853BYz6vk8Afp0AjFh8vHNOg1IQ4DnWFHkMDLXs
	o9dlij75PXHWo6C/d9a1lOs+RiHnrHV/exYvt
X-Gm-Gg: ASbGnctzSd1Zn369w7cxpcB/r2D6UdzCEBYxMd59/uoX0MDb866up2pnrAD45mnfnI2
	n6GIOrVgrn/Z7yCcDCVKlt1fgy3NiiH8AteEnPeGWzSOLAkn6mr7JdcGT91k6OxL6iq+9ld88u1
	Ydu6yTIO6mnU0/bCadFmoyhN/V02Zmlae7TmMlhqnpjRDAfSn04mDrgwG5
X-Google-Smtp-Source: AGHT+IFLZV57rHCQSpiZkuDB2IWC15ckkgVSb8eGoGJ0utu9e+eN/tXjQwdtpGXfCiQi+TJYjIfu/4mIRu5qEpxoc74=
X-Received: by 2002:a17:902:eccc:b0:223:3b76:4e25 with SMTP id
 d9443c01a7336-22799f781fbmr4578925ad.17.1742847809328; Mon, 24 Mar 2025
 13:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309084118.3080950-1-almasrymina@google.com> <87a59txn3v.fsf@toke.dk>
In-Reply-To: <87a59txn3v.fsf@toke.dk>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 24 Mar 2025 13:23:16 -0700
X-Gm-Features: AQ5f1JrIxy1e_i27ZockKLHmrfEKrX2c10NDCEOTcJajcc6hpoW3WD2cL4qKx3I
Message-ID: <CAHS8izM30jZ+bKkpeKQLKk3BGj8nBFLpUFgS2qM7x8EPMV7KOQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v1] page_pool: import Jesper's page_pool benchmark
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 2:15=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > From: Jesper Dangaard Brouer <hawk@kernel.org>
> >
> > We frequently consult with Jesper's out-of-tree page_pool benchmark to
> > evaluate page_pool changes.
> >
> > Consider importing the benchmark into the upstream linux kernel tree so
> > that (a) we're all running the same version, (b) pave the way for share=
d
> > improvements, and (c) maybe one day integrate it with nipa, if possible=
.
> >
> > I imported the bench_page_pool_simple from commit 35b1716d0c30 ("Add
> > page_bench06_walk_all"), from this repository:
> > https://github.com/netoptimizer/prototype-kernel.git
> >
> > I imported the benchmark, largely as-is. I only fixed build or
> > checkpatch issues.
> >
> > Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > RFC discussion points:
> > - Desirable to import it?
>
> I think so, yeah.
>
> > - Can the benchmark be imported as-is for an initial version? Or needs
> >   lots of modifications?
>
> One thing that I was discussing with Jesper the other day is that the
> current version allocates the page_pool itself in softirq context, which
> leads to some "may sleep" warning. I think we should fix that before
> upstreaming.
>

I don't think I saw that warning for whatever reason. Do you by any
chance have a fix that I can squash? Or do you think it is very
critical to fix this before upstreaming? I.e. not follow up with a
fix?


--=20
Thanks,
Mina

