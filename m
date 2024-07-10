Return-Path: <linux-kernel+bounces-248125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0FC92D8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1961C21579
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC9195FFA;
	Wed, 10 Jul 2024 18:53:14 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5476F31C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637593; cv=none; b=swAojI9y/kw67IzFuvq7pAR9w/w9YyX4CeCcgilL8DQk3Bx6EEmdXyce0JNWNfISYwmTno8LBKimA2/OjA+YEIl+1hy+O1ZB7jDX72+rYfRCxlvChT8CxM8lT3SCo9k2oDpFAqC1qUQsKrg0dYAVyLCgwk2s4irXoz+qpGQmcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637593; c=relaxed/simple;
	bh=e5eAjoZRs9c7vRZVBzqSKoLFVVx6KpSSIiVOTOfmE0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcBJINrpM/H9soO4hLlmWuV7NaRGhujELwBS+rdi7uGovW6q9y1+QIHCn+e9/sP5Tp1wcLdt+d41DO3GVMyNyVwfey5hnmrjNVDyISldfVwhpV7Mz8SywJu5EEbyutvBfRmmDSBaIsVsMANEI+yvpj6GnH9wJNofRkSlpmUpTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-64f4fb6ce65so655887b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720637591; x=1721242391;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5eAjoZRs9c7vRZVBzqSKoLFVVx6KpSSIiVOTOfmE0M=;
        b=SbVeG38fhOYQy1iiPb2KPlsLlDV502wDZSbFXTbzm8kGEmKLtz40DuY6YH7QhcQdAZ
         r6Hn6AkZZm0qn7BESPQkD2ceL/tRJfSzM82oCf9opeXPU76PZqsOCi59xfyHCjMu3WRW
         2/06436MTgBBg4ymJ+uJ/e8JcXDc5G/ytx9BFn0ES+DoxFwglTuW7Ph11SnCHzQn40Vj
         4JX+zK8itd8r/tvGbk0BiLGGV6Ifl5VcGqCF56EwJiQe/idkpBRfTwsoq9D8/D9ZbVf4
         i6fiTD2vJQ0+h2AS93HyU5NEAUEhN8I6T9W+qobOKSodpXQmaDmJ7v36U7o+ckaVDqGM
         PueQ==
X-Gm-Message-State: AOJu0YzavHaw/Ra9SzXSqZYWxIA9XSFvQD27FEceOMo35mxGqtCWwFzm
	U/9+TG181OZcV4PTPaZSxEjg/b8i4zq+4jfdmB0jSsPPdXFQsA1A
X-Google-Smtp-Source: AGHT+IECKsw4+A+qLn0b9EEN26o1zDZszEhPdnRnKk7nUaJYnuknBHtEkrfAi1UB/OZH45SL4POmDA==
X-Received: by 2002:a05:690c:4a0c:b0:63b:aaf1:b8c1 with SMTP id 00721157ae682-658f02f5605mr78387637b3.37.1720637590956;
        Wed, 10 Jul 2024 11:53:10 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1457912f9sm34221385a.114.2024.07.10.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:53:10 -0700 (PDT)
Date: Wed, 10 Jul 2024 13:53:08 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 1/6] sched: Move struct balance_callback definition upward
Message-ID: <20240710185308.GC317151@maniforge>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6M3LVbN3Ssy+Ejvb"
Content-Disposition: inline
In-Reply-To: <20240709212137.1199269-2-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--6M3LVbN3Ssy+Ejvb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 11:21:07AM -1000, Tejun Heo wrote:
> Move struct balance_callback definition upward so that it's visible to
> class-specific rq struct definitions. This will be used to embed a struct
> balance_callback in struct scx_rq.
>=20
> No functional changes.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>

Acked-by: David Vernet <void@manifault.com>

--6M3LVbN3Ssy+Ejvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZo7YkwAKCRBZ5LhpZcTz
ZOx4AP9haKQYl+78DJhjZw2BBXGU4T52h1PAeVk1G0ZLlJx0ZQD+Iuv1Lp9Vol1D
sEZ78fXYJkQZfFkayLegEZE66cDlLgk=
=p2QB
-----END PGP SIGNATURE-----

--6M3LVbN3Ssy+Ejvb--

