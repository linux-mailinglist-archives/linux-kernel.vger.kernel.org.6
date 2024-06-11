Return-Path: <linux-kernel+bounces-210255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AFA904163
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671E82875E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D153D971;
	Tue, 11 Jun 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcPSHsYf"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9E481B7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123589; cv=none; b=KiJMf+yinAm7Rwy0kdjo+xLcRboIyrxY7eqn3+Wjd3vsZSGU0maFt7IfPkiAhZ5FtzYs9w9Yx7kxZAfUnj35+vFmXuqbHXIiu+kkG55BRqCyZc0GMYsigA1vxnwZ1tBvylhF0OiEB2oHQ+zmokKH/3LKjgIZBCJ+iPwhNDpmdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123589; c=relaxed/simple;
	bh=THmJ90m9cYRnkYlDMu4a/cd1GwGNBcBPB6kbdS5FHTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBtzaLkgM9QSJFWnB0mVNYg0VeGUIS5hTjgGEMTd7VsUlAwSc3tFbg+pSUJJsXUmiK/tn6trj/Xgj0od31w+1FOW7pmTdEwTlzWuPahYbvvcWttIGCQpJxKYkQlfqcWMpkV8HetSYm15NMWcvXEiJ8Wy+TL5AHjvdOr5DF5cwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcPSHsYf; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b97539a4a5so3176809eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718123587; x=1718728387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDlO2YjOSVSSgyeqWjNamYw1STHKmx/Pjf3CpiwkrYs=;
        b=EcPSHsYfVpXpbla2NWQ7jXNr0Qguh1qt/6RyR/p4WmaxRhww130TCb2PgrvyDB03CH
         vMap8ioetlQDrLE5Wj7NtdDCDIozRGt+Km3MWMKOXJBSuZTP+5sffUPn/A4CmeXjziMX
         I4whaVrNvwpYHChnypLL+S+0u1SDx/cY+ZkPqaSpFemLElRj3xo2WMYlEFxmcIhzoKsy
         FXGZWP8w7zTu63Ylx8uxjK31oZyI57SjxFMCZvjJTzv3KZS5NxOnv5EBpMDx2hHHyQXx
         mniJdKJ08LA3IpbMOQlv1paz4TBqBbB/LRz2kQeUHxn9SXxIGAsFwS5321m+h+eqk8R/
         AvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718123587; x=1718728387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDlO2YjOSVSSgyeqWjNamYw1STHKmx/Pjf3CpiwkrYs=;
        b=AcYEVQu0ahaGIoaRc0j6yeDMqHKl8uiG7GZ4d++DPORk5sJ9JWN7+gictY069QZEvi
         j+gc8amhJWG0dh4XhYEBsk2jBDOwET+5FgC3CzPgbxcTxp1BaKGJfqrBrdSfuNFc9SFB
         +lt7q0eEhAQEfGOyWqNFjON2rYgmTQn4dw1ZN34w86kVV8pu8HFBaSNwbVG9Dp1sFxKz
         GhYTH1oZM/klDGZFWtO3huwgx6F2hOk8HynQ8wRHzeSi6HYgPVisLC1SwgZM38vKp7q0
         5WbiPdS1KZ7y3H7ccVQ6QlMDFTfLFLg5oqAtT/rYz1qdvLUTUgRtts9FFOk2X6Bzl3N3
         zaIg==
X-Forwarded-Encrypted: i=1; AJvYcCUjjQ9w9nW0B4pubKxzxRj/Jcnhr425MQ5nCz0vkOSLSWqM30l0P55wroGE9W4EEcXqMiFcT1Wr7pgU+bPfFsqxKB0J0jm7BW6sBip2
X-Gm-Message-State: AOJu0Yxy18SxrvP5PSVAr9amoclXBwtg8u/HrCcmqMFcD2y1ehqrCQN9
	aX354PNhZAIItgUz06DeG/eGBDqAZ8aVg+VTsjMlxsjBfh1+RBWMP8ghLT8gLcJqCF4PQ4XiOeM
	L0+RieBwF8Kpx7IF+Gfpgk7SgG9E=
X-Google-Smtp-Source: AGHT+IHKy2kKJu7lLa44h5138CPHNVyiUkGxGWBZQONRY3V8yRql/hmDtBfr8vyACzy7zPU3H7G6Jwu+z+gc4DxfQEc=
X-Received: by 2002:a05:6358:71c8:b0:19f:4c4e:d3c2 with SMTP id
 e5c5f4694b2df-19f4c4ed5b2mr898974355d.15.1718123586898; Tue, 11 Jun 2024
 09:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611024516.1375191-1-yosryahmed@google.com> <20240611024516.1375191-2-yosryahmed@google.com>
In-Reply-To: <20240611024516.1375191-2-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Jun 2024 09:32:56 -0700
Message-ID: <CAKEwX=OatEx57bOFBb5KNwvDhp4gMZhpjKw356fj4xzanqMJHw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: zswap: add zswap_never_enabled()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 7:45=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Add zswap_never_enabled() to skip the xarray lookup in zswap_load() if
> zswap was never enabled on the system. It is implemented using static
> branches for efficiency, as enabling zswap should be a rare event. This
> could shave some cycles off zswap_load() when CONFIG_ZSWAP is used but
> zswap is never enabled.
>
> However, the real motivation behind this patch is two-fold:
> - Incoming large folio swapin work will need to fallback to order-0
>   folios if zswap was ever enabled, because any part of the folio could
>   be in zswap, until proper handling of large folios with zswap is
>   added.
>
> - A warning and recovery attempt will be added in a following change in
>   case the above was not done incorrectly. Zswap will fail the read if
>   the folio is large and it was ever enabled.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

This LGTM.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

