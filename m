Return-Path: <linux-kernel+bounces-275271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59873948296
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3671C212CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29B16B396;
	Mon,  5 Aug 2024 19:49:19 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F914A85
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887358; cv=none; b=Ydm0tFLtCO7FzJUqVLXL5x0JhMF+Wit5PoXoL8T7qNpagvKp3f6sjHXyYpLlktvqUS5mFPlaJbDT6aPJsTXvE1DhghNSDBo4D4Wui815YGzkQDpHhgHb1qj8VrDYWyJ137JjRJpnVJ8ZWzuRRIagd2tlecBDG6MUiMgcJOPu5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887358; c=relaxed/simple;
	bh=9sbHfwez76OtmHmKKcE/IlUbFqDV/61rI2oiM2Z7IQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv4yi7lMTXkg3GBEGI0EJJhmR17htZGWen4LNce4STqUOf6xN01w1D75feJV74Hu8w47Au5wgi10b2LMPXDMWq/fKW8Tr1UutZ4nvurZNCla7+VV/kH0JJMhHYwjHotTNyX6r6zXC515Cos4ZL/80w1SZ/ECFiwMqzcz6P49PFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1e31bc1efso669342585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887356; x=1723492156;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sbHfwez76OtmHmKKcE/IlUbFqDV/61rI2oiM2Z7IQQ=;
        b=DWRIsFZGl0XSte6bgFB9VA5aPSzKn3cxAjYqzE6win1iZiNgAooJy18R/103O8g4dl
         z5EbMa7XrkhKAAHmuLpq2NrFVFOV57ZDWqegAY6ULcdLpNa+R1g+cauC3ms+BYQQSl2l
         d9sRz7Y2/cMlmrKTlg2aI/pN6h7Envgb21FQxdqXRhM6i59CouAxRlSbL4WKs4lY9HTe
         +Gp3FWj0RzByVpYDupFBzTv1s3z1ixm02evtkVdXs5vgTSHyz1IzzrQoBeVzLd66nWNr
         KI8HtjvGbRv1W0qZid3dTHWYTIGuyQcDvyn2HgvJsuCQU6FM1LLH0UpZuRjPagjydHhV
         37xw==
X-Forwarded-Encrypted: i=1; AJvYcCWBrq1TFxvDcBVas70lxiHHU5H1bZvhpqPHSYO73CfAI67XJ0tEVBb1FTI2V91tA9l+u6wc817sMVD2ECD60wuqUUqG4VKa5PHx7AqB
X-Gm-Message-State: AOJu0YzSo4iCZM+n+U39LL/HBaKq34Ntm2vktRV/xC7QyOlSlXozwgxq
	cpSNsNTToBoWTswA9aNNgkKDzty8i7UJmSjTaHfEOlFPP5QAO/q4
X-Google-Smtp-Source: AGHT+IGImfLp+I6qENgP/wJYHc9SrDBcgI1IJs5+EFSAt0C1iEsuLIC5g7TOIp+VXbFQMvXgwDIQ+w==
X-Received: by 2002:a05:620a:46aa:b0:79d:5f82:a404 with SMTP id af79cd13be357-7a34f009579mr1689879085a.64.1722887356041;
        Mon, 05 Aug 2024 12:49:16 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f79814bsm373606085a.133.2024.08.05.12.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 12:49:15 -0700 (PDT)
Date: Mon, 5 Aug 2024 14:49:13 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com
Subject: Re: [PATCH 4/6] sched_ext: Simplify UP support by enabling
 sched_class->balance() in UP
Message-ID: <20240805194913.GF42857@maniforge>
References: <20240804024047.100355-1-tj@kernel.org>
 <20240804024047.100355-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/8/NfG8AxmAejjeN"
Content-Disposition: inline
In-Reply-To: <20240804024047.100355-5-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--/8/NfG8AxmAejjeN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2024 at 04:40:11PM -1000, Tejun Heo wrote:
> On SMP, SCX performs dispatch from sched_class->balance(). As balance() w=
as
> not available in UP, it instead called the internal balance function from
> put_prev_task_scx() and pick_next_task_scx() to emulate the effect, which=
 is
> rather nasty.
>=20
> Enabling sched_class->balance() on UP shouldn't cause any meaningful
> overhead. Enable balance() on UP and drop the ugly workaround.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Acked-by: David Vernet <void@manifault.com>

--/8/NfG8AxmAejjeN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrEsuQAKCRBZ5LhpZcTz
ZPYqAP9SKkxOsYW0bn3tL0T9Nxs4NWADbpqnllYM7sCsoJw8BQD/RKzHMYrbZH+/
PoQDSQ+kMW0fheXzwRJke+UBL8qP7Qo=
=SSPM
-----END PGP SIGNATURE-----

--/8/NfG8AxmAejjeN--

