Return-Path: <linux-kernel+bounces-246689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC592C537
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB91FB21B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CF818003E;
	Tue,  9 Jul 2024 21:18:53 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2F7CF18
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559933; cv=none; b=BMB/uZzbrYcj76pzrqYlXbSyYqMVLqdQ3LyJRQRR7LNVIrOIPiuBl7TdE43S/uefnH35Ey3/Qit3yD1F0pGnqrN5wcXnUvRsE2QNRnV1Py77ozR7J5CowH/avu/qq/n8u5OsQps2Z741mfH55erNGHQs9eMJgUGvyGsLneMHnak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559933; c=relaxed/simple;
	bh=ZZQ2t5DQgT14ZiipL0BidJ5RP+hH/wvSIWmeU1O6zQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wpf5TqU+029jLdEJ8P/OF6etLYQiVoIy3e+taKMJucPUSNXuMTNopht2cmZ3tPu2llQ0eFhVccOz7XJcv5McSD9whJnUdu3CmSz7vLNp6yjjLt5SNnqzFt+vT9Gd7RuPaDDVl16iLA2tugWpk38AvC9zsqOj0OV3sQ5yR4utFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b5def3916bso28829256d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559930; x=1721164730;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZQ2t5DQgT14ZiipL0BidJ5RP+hH/wvSIWmeU1O6zQU=;
        b=xRREuYgIHUwvK29k3Egbmf4mD0xLnNlmi7Deh/zk5X16Y/zqdvCPsufjxoqJP4ceIB
         lhLsALJXg/vI0JwHzFjIZS2MlqNqOG4DZHalyx0BYzCeL4SDJJhu3nHq+RpTLG+jW1Uf
         OyPM+KalIIGWZHlsstMfYeOQ6S0ZbMoPyJ46fSZ7RqaRSMQB9H9GuK/LMzgGHqqxVMDh
         l5MNJ6fl8I74bu2UZG0aA36LVsxniG31lxfKks3khid0P57maTmXBx68pfecASegGVVF
         6Aiik6PlaL65uigeB6KfPvjeY3CBNL7673g2aJ2CKMcWRkgVfm0mIH1W8W5ftZJ9sP83
         GdGA==
X-Gm-Message-State: AOJu0YzMHEl3atjf1k9PmXVrQ5B6o6ClAMY5yM3izQAePIVacLW2DpoM
	F/P0LTio9qq0RdVv/0mNsm2BzmZA4gvlUNLkBKzyxB2jRKL7TNjw
X-Google-Smtp-Source: AGHT+IGddZKw5lCFB9IYbDiZBUqk3uAAfzvnQs7VW9WuBAkkHws19rUUauqqT7dEBTB4tTPEvVepaA==
X-Received: by 2002:a05:6214:acf:b0:6b5:db70:b980 with SMTP id 6a1803df08f44-6b61bc83bfcmr49758076d6.4.1720559930151;
        Tue, 09 Jul 2024 14:18:50 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9f71e9sm12025986d6.53.2024.07.09.14.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:18:49 -0700 (PDT)
Date: Tue, 9 Jul 2024 16:18:47 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com
Subject: Re: [PATCH 1/2] sched_ext: Reimplement scx_bpf_reenqueue_local()
Message-ID: <20240709211847.GA248762@maniforge>
References: <20240709211001.1198145-1-tj@kernel.org>
 <20240709211001.1198145-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QmzZGXlHNGkY4E87"
Content-Disposition: inline
In-Reply-To: <20240709211001.1198145-2-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--QmzZGXlHNGkY4E87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 11:09:42AM -1000, Tejun Heo wrote:
> scx_bpf_reenqueue_local() is used to re-enqueue tasks on the local DSQ fr=
om
> ops.cpu_release(). Because the BPF scheduler may dispatch tasks to the sa=
me
> local DSQ, to avoid processing the same tasks repeatedly, it first takes =
the
> number of queued tasks and processes the task at the head of the queue th=
at
> number of times.
>=20
> This is incorrect as a task can be dispatched to the same local DSQ with
> SCX_ENQ_HEAD. Such a task will be processed repeatedly until the count is
> exhausted and the succeeding tasks won't be processed at all.
>=20
> Fix it by first moving all candidate tasks to a private list and then
> processing that list. While at it, remove the WARNs. They're rather
> superflous as later steps will check them anyway.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 245254f7081d ("sched_ext: Implement sched_ext_ops.cpu_acquire/rele=
ase()")
> Cc: David Vernet <void@manifault.com>

Acked-by: David Vernet <void@manifault.com>

--QmzZGXlHNGkY4E87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZo2pNwAKCRBZ5LhpZcTz
ZA0eAQC9sQe9OMMXSCst6JIdkSa6/9oDCt4ReyTQZxn3mJ43ggD/bibtxvQ7q5cU
f4nfvw5QzpOnv72mpMpQ7LTRoDWK+Qg=
=xeFh
-----END PGP SIGNATURE-----

--QmzZGXlHNGkY4E87--

