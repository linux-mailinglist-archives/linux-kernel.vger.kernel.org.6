Return-Path: <linux-kernel+bounces-330143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52346979A42
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F234C1F21C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D2F20B28;
	Mon, 16 Sep 2024 04:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FGgNkFY6"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D971B7F4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726459908; cv=none; b=nrQWnq15vFSdakvhWR15Kc4cgCFwMZFgkwx6IlZKhFcDcFaTC/H9hXP2dOxQbppcTltlFToZ3NBm2BWMJrNKEWSZyRIi0xWkZnurXset098rzCUhynkXELXEH4nPCq5rbV5gjPv+kXbLTQb8iz84wjt4sCGmnsmDtj0x9wAxaI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726459908; c=relaxed/simple;
	bh=rEzHBfkIgARZXBg+FaOBgTkxXmN8tjgDr6YvtGgsa/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qE0QWdeS1IOJSfb8wzH54WLSVghEvoyHJ0XPWBu1BhJk9Bf5mEcPZOwwzYf7ONX+FpcXWoW2fghsu97k1PCGn041cc38V07Nx6UZ22epOUIdGWgOQFB/xpHWouu55jaCqvvDhoqDRwCQCJ/zGpG3yvoWnh12oH9s+eUNDJDbegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FGgNkFY6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c42384c517so2900717a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726459904; x=1727064704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2H9PzIEom/WoKCt0glTh+xZzRbo7UeyPTwBpxSe3q2g=;
        b=FGgNkFY67W4k/cUMItWC5rX9OuvuUvsAfr/Sbhg1kGwwfs7tC3TvbgfCszho/2T8xh
         Z+C9hXUksi2w8YtfSRlw4spbsWlz45IpByxPzOtQK2CG++I5TkUj231XvYC+Zi7coALf
         qL/tDX+Iz/1rcsTe+PHCnaNd7EO5hbglSDmwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726459904; x=1727064704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2H9PzIEom/WoKCt0glTh+xZzRbo7UeyPTwBpxSe3q2g=;
        b=PX9ESr+hqH3QI5zp6eD3hPLCWaD+2SfxwEDCZYni3EgQYYUSutYrjal/fY1vPoAoRc
         zmKXkUfpnbpm8/gehaOHa2Irk8MnWBJn4xcw3d5jDGaomT0dwWIkQcKJ04sM7fIJeUgJ
         h7K5vu8qhZftHybyN50p9/chKa0xW+2zBQX+QCt9SwdipY5degbkqshlIw+29h3mVA3v
         tVkWwj9Y62qxqmGVXDZTrkGE39DoWdL0dAioVoPfhemU3828S/UsQyzw2+oJMeUpzsWY
         gXeeqTXxX3anVhGktDytik8ClEONlxkSFpOcLhUr/+OHAYPRretyfM07EIpELwVtUao+
         1j4A==
X-Forwarded-Encrypted: i=1; AJvYcCVPP/TeIv1TvylPXgPLhnl81XphiOlDihcwMGR3QqHgHxMZ4C7TGftwW/UrVa2bnvdYUwQqKuuyumhK/pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8GbCGrHf14Wen8wRFBhbH1nd22k1mh3Yq5xIpwe059hjNxep
	tbDT8ixSR+rfMexkXXSEFF9LgNagf9awiK0khmgCtHBbzzRC2E1PQC//kkNDWOba7GC25EBc+GY
	OGYGAbA==
X-Google-Smtp-Source: AGHT+IGnXh4WM3aFRCp1cJ+QuhWoTs1PzSEfj/JanFkZD5FLu/YzKoKQ9CTdn+lZZvJZbkY3Sa1bRA==
X-Received: by 2002:a17:907:e69f:b0:a8d:7210:e295 with SMTP id a640c23a62f3a-a902941f174mr1307696666b.10.1726459903969;
        Sun, 15 Sep 2024 21:11:43 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061330d48sm257865666b.207.2024.09.15.21.11.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 21:11:43 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c42384c517so2900689a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 21:11:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMk0sSgPHNYEOFTVBiiK+YrFkBWaWrvgVFBimacB0CZLXQGTG6C/S5bNYXS+51/Hu5Ce138RF40ADwC84=@vger.kernel.org
X-Received: by 2002:a50:aad8:0:b0:5c2:6d58:4e1f with SMTP id
 4fb4d7f45d1cf-5c413e57af1mr10106270a12.33.1726459902835; Sun, 15 Sep 2024
 21:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915172730.2697972-1-kuba@kernel.org>
In-Reply-To: <20240915172730.2697972-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Sep 2024 06:11:25 +0200
X-Gmail-Original-Message-ID: <CAHk-=whHoTURtgOC6ceHeFVhW40T5MKJRJMHvyMJXA0ko3S4rw@mail.gmail.com>
Message-ID: <CAHk-=whHoTURtgOC6ceHeFVhW40T5MKJRJMHvyMJXA0ko3S4rw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.12
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Sept 2024 at 19:27, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Unideal, not sure if you'll be willing to pull without that fix but
> since we caught this recently I figured we'll defer to you during
> the MW instead of trying to fix it cross-tree.

I think just dealing with it during the merge window is fine, since it
doesn't seem to be a mis-compilation issue as much as a "doesn't build
due to incorrect asm constraints".

So it's not going to cause any _subtle_ issues, and the build fix is
known and pending and won't affect most people.

              Linus

