Return-Path: <linux-kernel+bounces-275515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A89486B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF876B226D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F23D7A;
	Tue,  6 Aug 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNiMvEYU"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F78F62
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722905283; cv=none; b=oHsCrKefIr3L3PaW+GcA9DF1YqAzjElCBBGUfUrrsxvFHZ77r2GYfqeDMXvEtmJVOs3narJ106Vz+X0wxXG28JPwLLha1g2gnxSRy0RAwpa/EbYyN5ihn4uuBCqoaZT4uCuOG1y7vE4PCYW6nLvUHeuh8BKqijED24qq/1tG04Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722905283; c=relaxed/simple;
	bh=NElBUjmjdHxlJXOmpJ+5QiZWqm3d/m6yztfw22+kQdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D98BYtVMe9s9fVnX8kP+nGtcWJkrkAbJn7+DqlpLs9+tWp5pIrlGXrzwXDHf9nv2LRnrqeBaqKl1K2W8UN0lfk49vfXSBs4SeHI/fXHix8GRzKiDw1139g5aaTIJt/aa6Kl8hk7VPgHv7m+ACTtNEOytHEVreJjphlcF9qBN2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNiMvEYU; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5de0e47b9so124537eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722905281; x=1723510081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NElBUjmjdHxlJXOmpJ+5QiZWqm3d/m6yztfw22+kQdk=;
        b=GNiMvEYUEUghTfPeoP4aUDGM+9Xhon6o0CFfo+pV2DHtSAhOE0cHCCTM8SR6q5Rt5K
         Gv0Pvb+PXXkSZ//L18tNJEfUHVCy4POZHz5LILzTwkBAFqBzQnjPaE/yrgPRM0k1YjTj
         DakorAv/FCHpPv6KfF969msqPDYi2TqhgJBLDf64lJaUbNWKw0aNqkJB2CrqJVWfdmY0
         gXY+6dDjcC23hCMe5q+j4NmGpFP+qxqgrZdblXKpf6wBdWIj0C7ppEr0b3HpOKKqWE5K
         eIXA+F3VwO08JZ3H4zURGhjxESAqaj4BgbDiSvRdLGkX3IdYrBS4qGUT3poV7iYZBTyc
         lRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722905281; x=1723510081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NElBUjmjdHxlJXOmpJ+5QiZWqm3d/m6yztfw22+kQdk=;
        b=Uw93HI3/9VAC9TLURi+8LmeLq+1G9VrwIBvhZ2cEAy+Ub/tdsVFous4MNkAq5CGQYF
         W8CBYSCqjr9ViRmX5Fg/llP38MispicLT+fdzY31fulfJulgxby7bc60Opc6bkOZVkb2
         e5JB41np33Q95klX6zPCUS0KzmCjj+QB5Fu3ChhW2i8jq5Cshx9XSqj2dAItGbUdw9Be
         VieB5FZjKiLAd+6BJPk5gmnHCh5q8aYUwrCRZFjX93vIcP7WgTb3wYSReflcEjnXRpPP
         IDTBAWFvz8b8/bkMM/7IPS2jJpfEHY0vgYCIHPymUEEEUAXVXDiiphQ6SxP91sjklWHh
         s0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsiw2g1EPcqRmXIxZWmEboikJ/J6fkRlVFtktbmMj1R7Men8S+8wcpKARjOrTi29DlaQSSdqYGdM0iMvENVFiOyHh1ntAzMIZfW0WZ
X-Gm-Message-State: AOJu0Yx0j0IDFbd1mqMt7KC3BK6iN+N9iUAklfkDWXL0r5+iyEKIq3Yk
	B9DLuAajCsDss/OhA6j32feoFF0oIV9pjI11fXSKUSptiXIWktalrn/pw6yf4jHYDSiFBYhyov7
	bnDUkL24jKvr7D1l/GxjaJv9i4Qo=
X-Google-Smtp-Source: AGHT+IGLcoPoFjeqQVCiC/DKINg1eWXrm7VoH3mpnSv9g6kbFxatzk8SEvm3Mbxhywf5L0I0UaA19OOnYUbRz4UBlt4=
X-Received: by 2002:a05:6358:5f01:b0:1aa:d4a3:3d58 with SMTP id
 e5c5f4694b2df-1af3babe1f2mr1606601755d.29.1722905280798; Mon, 05 Aug 2024
 17:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805232243.2896283-1-nphamcs@gmail.com> <20240805232243.2896283-3-nphamcs@gmail.com>
 <CAJD7tkaWyGWOArSEEUOLS4EQwdVycNrbvfHK-2rkixBQ8-h+3w@mail.gmail.com>
In-Reply-To: <CAJD7tkaWyGWOArSEEUOLS4EQwdVycNrbvfHK-2rkixBQ8-h+3w@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 5 Aug 2024 17:47:47 -0700
Message-ID: <CAKEwX=NYMC9e3NPGn2DEfYFKh2cDt+rmScLdqBNmo+CvfBtFyg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] zswap: track swapins from disk more accurately
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com, chengming.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:15=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> > algorithm even though it will not be neeeded by users - however, this i=
s
>
> needed*
>
[...]
> >
> > Combinng the two changes, we reduce the real time by 10.32%, kernel CPU
>
> Combining*
>

My bad - English is hard :) Thanks for picking these out, Yosry!

Andrew, would you mind fixing these two typos for me?

>
> Can we fit this on a single line?

Just sent a fixlet to squeeze it into a single line :)

>
> Anyway, LGTM:
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks for the review and feedback on the patch series, Yosry!

