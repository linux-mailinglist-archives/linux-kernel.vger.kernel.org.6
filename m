Return-Path: <linux-kernel+bounces-371622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E6B9A3D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31CF1F21D13
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5F51D7E3D;
	Fri, 18 Oct 2024 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8oFTDuZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8C2F46
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251867; cv=none; b=UjO2Pd9+aTZJl+yKr01nFwDh+z2DsHKEVeNNPKHPPo6q6v8IdFZLpkdeY2BErcF3/tGVjLO/DJUU0LdcSZ46ypnDzV8e0revDAeBEHODJsIE0+Btjm5MWg75C1oF3/oPpCSuPC8UBPsjSjNgNTLDFjg53Xm7Qa/6d/kyRLfB06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251867; c=relaxed/simple;
	bh=YPmbLkjhoSCx7Ka93jvwOwfbPUE1z48V2d4w/a9xZyg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnkmYVXMwjqvXZIFwdX9/xUXJwAn/WPKeQSkNTm8KG7bf6XCjYCp/71wYp3bUzDLG8PLIYpwVNpVWlWNTn9TTmC+PuPkaPYb1mcUOUCOIH8m1pJWATLJH/yRMaInS9Rt5JrVQnSm6jdFnaQrVowtPgMt3vy8u2PGs680jKX+Cjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8oFTDuZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729251864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlu6bqFSROl2zXVvkaXLKd26K3gvldoDh8YudQBsgb0=;
	b=P8oFTDuZQCs2PDS7Ln/zr4NFriiJA3YV1+VXOjpdLsYPQiqjxqJSu7yv/qEd1j4luoeNWE
	cawG5I0Oyyo3SjHHdFmu9zUUzmttLg5zmDQ69ZWa8H0Br2Ysmqp65Re8zh4lTjvxPD4RIq
	rSkOSqBfkrGMVGomHIGcZPuKhgYgAnU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-oQARMjkeNQOEiNPj6PdM2A-1; Fri, 18 Oct 2024 07:44:23 -0400
X-MC-Unique: oQARMjkeNQOEiNPj6PdM2A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso15634635e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729251862; x=1729856662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlu6bqFSROl2zXVvkaXLKd26K3gvldoDh8YudQBsgb0=;
        b=szJWcD3CEF/6lxHHJyYoqCUQ3ZHM0I7EO9VTXIhMkk1vigTkAO9QAQGic/RH8V785n
         pm4C4/batMXKk2x5QPXfe3AYD6PrnWjU65GZYiRrmHk1RibGJTrHt2sJoeCg/3rjl9oU
         wtkGEXfq/Guf6j9sTX/JLxTGh2Rd/Le5ep5OopHmcjCdBdyP/y5kqCxJ+ZEegz5pDoNt
         Lzt3Y2kGGJf0TtO4Ot7vseKOWHnuAlha/hRGrLEYSsZU4Vqgkp/oKrNyo5TUzm3mY1Sq
         2KKd5lIhWxUGzerqXXxScUDfVkvXWjmm1WkQ3k6csZbvvI+jrrQbS7uBPUXYGImNRPG3
         2mXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW48uoXWvplOO803nj8vHFEVAIvETJ2mI7mfLWyV/HmfoSxxxlBhNXs44P0NBjB/mgOe1p7vA2JEV1y07Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIqR4vhy+c+VomlteHUPHF+IbEW9dDLa16VtsX8FPji0N0cFH
	ViAeoDBB484CmmzNnVhnJADXiHQzGGlJB1ezNHx+mOJpoMs4X5Cw9THqFio6PzwjuOjsmD/QfPn
	LVxdodGfv0cY4uGsqbvpW/N5DesN+jHbiaoz0aA7nTvrMfvGIDi2pwV2d2p4K6Q==
X-Received: by 2002:a05:600c:1d27:b0:431:4e25:fe26 with SMTP id 5b1f17b1804b1-4316169742fmr13710915e9.27.1729251861893;
        Fri, 18 Oct 2024 04:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiEer9ZpdYNq8qEEDZmN8/HtafItHRlxeS8dPJ/aHfakFzmlopU8rrHb/idJHOFD5P4NATjQ==
X-Received: by 2002:a05:600c:1d27:b0:431:4e25:fe26 with SMTP id 5b1f17b1804b1-4316169742fmr13710725e9.27.1729251861475;
        Fri, 18 Oct 2024 04:44:21 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf056418sm1727731f8f.34.2024.10.18.04.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 04:44:21 -0700 (PDT)
Message-ID: <ab51f981844c700d4e66b366c8d2abde7c5947bf.camel@redhat.com>
Subject: Re: [PATCH v2 04/13] media: dvb_frontend: don't play tricks with
 underflow values
From: Philipp Stanner <pstanner@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Kevin Hao <haokexin@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Kees Cook
	 <keescook@chromium.org>
Date: Fri, 18 Oct 2024 13:44:20 +0200
In-Reply-To: <8d6193ed8d53ce94d595cb431627bbc7783c0e4c.1729230718.git.mchehab+huawei@kernel.org>
References: <cover.1729230718.git.mchehab+huawei@kernel.org>
	 <8d6193ed8d53ce94d595cb431627bbc7783c0e4c.1729230718.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-18 at 07:53 +0200, Mauro Carvalho Chehab wrote:
> fepriv->auto_sub_step is unsigned. Setting it to -1 is just a
> trick to avoid calling continue, as reported by Coverity.
>=20
> It relies to have this code just afterwards:
>=20
> 	if (!ready) fepriv->auto_sub_step++;
>=20
> Simplify the code by simply setting it to zero and use
> continue to return to the while loop.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Oh wow, back to the big-bang-commit ^^'

So is this a bug or not? It seems to me that the uint underflows to
UINT_MAX, and then wrapps around to 0 again through the ++..

I take the liberty of ++CCing Kees, since I heard him talk a lot about
overflowing on Plumbers.

If it's not a bug, I would not use "Fixes". If it is a bug, it should
be backported to stable, agreed?

Plus, is there a report-link somewhere by Coverty that could be linked
with "Closes: "?

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Anyways, this in my eyes does what it's intended to do:

Reviewed-by: Philipp Stanner <pstanner@redhat.com>

> ---
> =C2=A0drivers/media/dvb-core/dvb_frontend.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/dvb-core/dvb_frontend.c
> b/drivers/media/dvb-core/dvb_frontend.c
> index d48f48fda87c..c9283100332a 100644
> --- a/drivers/media/dvb-core/dvb_frontend.c
> +++ b/drivers/media/dvb-core/dvb_frontend.c
> @@ -443,8 +443,8 @@ static int dvb_frontend_swzigzag_autotune(struct
> dvb_frontend *fe, int check_wra
> =C2=A0
> =C2=A0		default:
> =C2=A0			fepriv->auto_step++;
> -			fepriv->auto_sub_step =3D -1; /* it'll be
> incremented to 0 in a moment */
> -			break;
> +			fepriv->auto_sub_step =3D 0;
> +			continue;
> =C2=A0		}
> =C2=A0
> =C2=A0		if (!ready) fepriv->auto_sub_step++;


