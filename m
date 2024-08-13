Return-Path: <linux-kernel+bounces-285419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DC2950D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4B82843C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD131A0B1F;
	Tue, 13 Aug 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb7Qs0aO"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117443155
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577871; cv=none; b=o3rmlXxcPX8/s4b4b4YiZVjPq13U5v5IzUGzs8ju8l7681mKGVRvN8ivEmXvZuddqaFEIIxvqsiukX91vAkkfkDXn6C/pd4TxT/t8bVqAmDpj6o9ppSARfbMZNHgwaO0fLlSgSxEvfXMO+p+lf8xoGjYC23MkChSwZwxvfsS18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577871; c=relaxed/simple;
	bh=8nbTxG6ul06gdddM2ThE6ol60wyu8mt4eeOF2miuNOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7gGjxqXEBaQ+xBJHtMyq2jNzsNSJnBODzX4dn7ccmsPWNskxQTJcxfa05VGNf8+4IW37pSznL2aQAiLJofkRmagwn72GaOS1lwDea3CRmf6/EnBkWfaP+l5XHadtctNctoxeOi4+yElkwHSQ4x52PHXSq7s+QrMsDaeYyEEjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bb7Qs0aO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-699ac6dbf24so56472877b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723577869; x=1724182669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nbTxG6ul06gdddM2ThE6ol60wyu8mt4eeOF2miuNOQ=;
        b=Bb7Qs0aOrVgDj3ljMVp3FXYJlOoWSZk4eB3iIKbNnlvBqvYYrxB/s1RNgq7fJxaCWC
         cZavch1lfl2KwgbhK65Hy9JajGsTqU3RQ7bI686GzZb+95W6Dq3/br+fCos4Saaq1nac
         ntjlU1ddN+DrYhIG/Rrizn0JyXSO17Rko8qBZd7YstK1tiCTaE60biEqzzivtt2I8D3g
         xMmoX+KJ2NSk1gmpMVe99LnIUeXK95MldW2f6jofrYVG+ezss0/PwjN1gzsNc5Ocd56l
         AHoUEiTiempy2lFgkKTJTHtnFFDVM6ZAsyhZXnH1y9dtvh7NT9JBcW1cnbaK0CCaWdMR
         2NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723577869; x=1724182669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nbTxG6ul06gdddM2ThE6ol60wyu8mt4eeOF2miuNOQ=;
        b=BnIi1TW/70A2okqCdBX0YdnjF4eCKFJwN9Vz1NheM7wq01cDvYKyTQeNQNuRJgUr8/
         PfFK0sATq8wDvpJpFMYiQEkHEHVgjMUGGw54cl7kOq58wlxsua0gb9qIU4n5XzOgU3MC
         eGPbN3tsc+CAMJqA3eBk74xhqHEAGMnXm10HnrNxrbtU18Ds2sSX4FIczCHPdYo2YBVS
         leoXMXFSwFuHwl1D/ONCxMxP410ArGQg2dVkNNkTDr1CRbkOTniyLHfXTWts107FKUTu
         OhYQCjXwhqMCflcr9j2haVCwBamUnEAaFB9+H7upJmxkFXH1cW1aBhoizQmz0Gtm+c0m
         iSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJh1En638V738pYJHdXHPzNsfdSCn1GLS7FZXUxBO8hkv9OPysnIzzD0p6fFWjug8sC7HtTTYgGny/adI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBCwsvEsdWjBBFLZUjLXXAPixLHRswUNcV/8UFsCEHzawWGR/
	riT8/YP2EPrJ+Y/JArSCUQ2299XmEje2k+AwnSd0GgOrkJI6/Kwl2zGYopu4Ls7uTBLaa3jbO/z
	AcAfeNAK52eD1FTalxuydtyDtDUL55yT/FpLE
X-Google-Smtp-Source: AGHT+IGXWf6bK0UPQNxfbUkUm4mLIEiaCdojIpQ/f9obpg9wxGZqXQr8EA1JYIoCvM0/YAI5Rbuf7XqfsSCF6zRaZ78=
X-Received: by 2002:a05:690c:3088:b0:664:8646:4cf8 with SMTP id
 00721157ae682-6ac9af0d395mr5485127b3.33.1723577868965; Tue, 13 Aug 2024
 12:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813150758.855881-1-surenb@google.com> <20240813150758.855881-2-surenb@google.com>
 <20240813114029.4bc61d6fe731a533eb88ba64@linux-foundation.org>
In-Reply-To: <20240813114029.4bc61d6fe731a533eb88ba64@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Aug 2024 12:37:35 -0700
Message-ID: <CAJuCfpHX_QYBUrbWPLx3c5_Dh1+VdH_GcYs1v=Q7yriLHyvvqg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] alloc_tag: mark pages reserved during CMA
 activation as not tagged
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, david@redhat.com, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:40=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 13 Aug 2024 08:07:57 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages =
as empty")
>
> I copied this into [1/2] so everything lands nicely.

Yeah, technically this does not "fix" that patch but since it's needed
for the next patch I think that's fine.

