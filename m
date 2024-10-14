Return-Path: <linux-kernel+bounces-364858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D2C99DA43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A1C1F21F84
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117741D9A56;
	Mon, 14 Oct 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4PT6lZko"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1F1C302E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949278; cv=none; b=uXZxw6DQ7spiGIDiqnJz2dS+ozu8bJ7+y6//UxBdydrHRuX/jWRMuj3OSc2RX5vT8IMuV4WsaDX6knO75CRIgODWkP72PbVaktUlo3Bj4NpkXusW2dyiDH+/5Ccc7TaGuF8fODXHlkNsQp/kGhdIjChC3m6npeJcX4P3VS0VA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949278; c=relaxed/simple;
	bh=BLIL+DRfn+NqhqYYX1lGL6oarjfPy/e33m8y/wOqsGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPXHf0neyb/s3J1gDZkmc4JdJffLYZb7MZfVICF/Fjl7MthQQCkIdMhIdybe5YO/SEShSh33rs+nOEfm5oaP+CoGZj3HfufLx+sqwUO7SIWRM0xIMkKX261vAn/VleAtjqtVXaslEqL6W7MP9Fvf1aTBjJC6uQLGXO6yhjmsRmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4PT6lZko; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4a46edda7d1so947759137.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728949276; x=1729554076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erEATKGTzditx30ngxcsL1xA66xPLUL5QzUbOKwyzRc=;
        b=4PT6lZkorOd8hiyDCUs83VzV3S5b7XBO9s5H5PHtO7POf7axsywVLkCOQLdNT8k1hI
         sQcSevkHDTbCOCrJBn6sqtoMYrdZ60N3bRyUWU/4NzpMtvczlns2/2fJwU3DFi90ysqZ
         3fGQnpbnbNMS7lZB/qNtZiPVnr37WMemCP7feKeqD/Wsw/IAd+B28lkbJ/0qpFCP2Jc9
         edhFNtIWLzOW6l/m3/l0xwP5rEWCFu1eMFxjoLTxmCU/01wWNPpiNzut52NTi+NAbxDB
         6XSnvu3JfnhB8UbjsBPnoHbU+z+1BOOhJ+Nx9qvzcEs3uEjl4OHnbYd7sEnl8Nr+frt8
         AWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728949276; x=1729554076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erEATKGTzditx30ngxcsL1xA66xPLUL5QzUbOKwyzRc=;
        b=Lwef6QgAeA5t5QcTJolFOTy4sINxwKvL0+1ImmAaBJ7yqOY/zq6SDSgdgMTdCOf2kh
         FXG3fMSf2N097w+9wCQjQLIzyb+Rf2hrcTIQonLG+CssoICDADo3sBFx7OJKCTwZYNMq
         s8/VUeHIPq2lgmQjdQGJAXoE5bVZSaXM6VVVNvJdW7MP5T1sQS3kyvvwUrcVlzVGOKbs
         fjBev7v4czGULBP9gy6PyKmU3quzw+Rz9L98OX70oO/xAMH3v+UGb5bOrdnMX7nIcqe3
         d/Padr1xxtxCVPSg59/uGp6SKqMbZmtucVmV4Tuar1W1Q8ZVz6oy4sDZG/Tkx5bpy87e
         Hl3A==
X-Forwarded-Encrypted: i=1; AJvYcCUbpUWNwO9GvNaWOa1Xh2NgFhCHwpt5T4S9t11owbEyQ7N9d8O4z3C+dT6u9gdy7LUTo4cXzl7kdfTX+n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADvpqmtkkJpwuo4IQylOXEiB4RFEDZ5B3FjrUAmViXAmdQBW5
	MWAA2deC2UxmhmFGuzxnd6uyO+e/UuMAmN9lnM/58WHgeVAUsLjpb+uBOHimTi0utDiU2WU26h7
	NmYWQct3kG+OzcuUqTlV9tQctQuzXQMOHhXd5
X-Google-Smtp-Source: AGHT+IELhCgaynS2p5jCPKBt9DwSqWQGFp6VZtRDsoydaZOboxj7g8bI6VTkVAmCJB8RPjES11D4UGwAuYkbqMFWR+s=
X-Received: by 2002:a05:6102:3583:b0:4a4:8b67:4f73 with SMTP id
 ada2fe7eead31-4a48b675218mr4072774137.7.1728949275818; Mon, 14 Oct 2024
 16:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014221211.832591-1-weixugc@google.com> <20241014162541.a3049d0824a2f9b22221c17a@linux-foundation.org>
In-Reply-To: <20241014162541.a3049d0824a2f9b22221c17a@linux-foundation.org>
From: Wei Xu <weixugc@google.com>
Date: Mon, 14 Oct 2024 16:41:03 -0700
Message-ID: <CAAPL-u9Sp_uKLsvjbaKuKnVoMUFPfE=kKf2k6PNOgA8QmdgnHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/mglru: only clear kswapd_failures if reclaimable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>, Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:25=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 14 Oct 2024 22:12:11 +0000 Wei Xu <weixugc@google.com> wrote:
>
> > lru_gen_shrink_node() unconditionally clears kswapd_failures, which
> > can prevent kswapd from sleeping and cause 100% kswapd cpu usage even
> > when kswapd repeatedly fails to make progress in reclaim.
> >
> > Only clear kswap_failures in lru_gen_shrink_node() if reclaim makes
> > some progress, similar to shrink_node().
>
> That sounds bad.  What triggers this?  Can you suggest why it has just
> bee discovered, after 1.5 years?  And should the fix be backported into
> -stable kernels?
>

I happened to run into this problem in one of my tests recently. It
requires a combination of several conditions: The allocator needs to
allocate a right amount of pages such that it can wake up kswapd
without itself being OOM killed; there is no memory for kswapd to
reclaim (My test disables swap and cleans page cache first); no other
process frees enough memory at the same time.

I think the fix is a good candidate for stable kernels.

