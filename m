Return-Path: <linux-kernel+bounces-342294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA319988D2F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E46B22042
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 00:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0481BC40;
	Sat, 28 Sep 2024 00:39:01 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3351B28A
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727483940; cv=none; b=TFLqPq+pA6XAb26jEOFWvi/lzf49Yqu5LaSxWbIFvQftWKMZt7rmRt/nhIElGG0TOg9pllHhz1rfAymqC8t2OarSXFlenup/s3hvMS1gdtV7W08o0Lv9FPbXHZGZ45b6X4Kc21+rkc1Y5r46JmGP783iDXvVI5Wf++Weom9ab4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727483940; c=relaxed/simple;
	bh=EDa95wa5EFL/nQzIn9y3kj//Kkc4VxyCalaP1JQhq1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdtRlzzCbsxmNzDLHx8bfYPaVxFf0Bgy4XyybbcUrUMAvBkq363tnmB8sqoaBs3lCVssZf1sktaxasDN+ZgNOXRAYuzE2kr82NvSygL4F2KaTs1lE8vd977dPZyDQC1oLzfDIZWFTiyw6bcimY+ooIvuA+4WQKuWj/nQsKUGjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a33a6c3102so7675405ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 17:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727483938; x=1728088738;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDa95wa5EFL/nQzIn9y3kj//Kkc4VxyCalaP1JQhq1A=;
        b=Qqo6TzN1yxQt89/UCcpwOoVgL9ZbyUerB0OxsiViRpboQNGrsgILX27yUptROL8wty
         z7e1MvX1CbI4AJMmVSfTHH5eseT6fE7mLJ/5vqtzosefZQ7croEctUh93tiN2QZluuyb
         5MAkzy/pkd/R5c7Eg9VUCRVXOM8AzTaZvF3ZGOHLddkQ6qpqquxwTmn+GJsbj+xyJpjk
         +0nfRCjVpz+2OXtfH3VeF31IOBWK6ghsbNPjG4ArphL+udlkJsXDvP6NLpgNAsnQahAA
         wP+nXXF3JJd4j4CoCwdNngtao2dqtMxYSPt5wjM57jZG5epps9yTOKdBtgZh1oILl/2Y
         6K2g==
X-Forwarded-Encrypted: i=1; AJvYcCVcLp4owdV5RVD+0oirJZOTBCtplkkDabO7KQqiuzWYxEs8V4oh8TjM0tzZf1b94pxaZi4kvwYim1StUnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HpZOucNjgsiD/YAXXlkFRt/0tEOLjQpoPdgd0JzcdinXruuz
	5R7+h+QoeuwaoYqDH8tC2bQsBpx2033BMtjtlXiJ9kDQUktxbWi3
X-Google-Smtp-Source: AGHT+IFL8l7XinRMn7PU8c+9+SmLyMrkmbapAnYLsn/QmZrXlFWGuHi2+RwNhZFzwagb265PaSzqVw==
X-Received: by 2002:a05:6e02:1546:b0:3a0:9f36:6bf1 with SMTP id e9e14a558f8ab-3a27689e49bmr65604485ab.9.1727483938521;
        Fri, 27 Sep 2024 17:38:58 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888f9e23sm793051173.173.2024.09.27.17.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 17:38:58 -0700 (PDT)
Date: Fri, 27 Sep 2024 19:38:55 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 2/3] sched/core: Add ENQUEUE_RQ_SELECTED to indicate
 whether ->select_task_rq() was called
Message-ID: <20240928003855.GB2717@maniforge>
References: <20240927234838.152112-1-tj@kernel.org>
 <20240927234838.152112-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adcYUaZCOcZW1qi9"
Content-Disposition: inline
In-Reply-To: <20240927234838.152112-3-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--adcYUaZCOcZW1qi9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 01:46:12PM -1000, Tejun Heo wrote:
> During ttwu, ->select_task_rq() can be skipped if only one CPU is allowed=
 or
> migration is disabled. sched_ext schedulers may perform operations such as
> direct dispatch from ->select_task_rq() path and it is useful for them to
> know whether ->select_task_rq() was skipped in the ->enqueue_task() path.
>=20
> Currently, sched_ext schedulers are using ENQUEUE_WAKEUP for this purpose
> and end up assuming incorrectly that ->select_task_rq() was called for ta=
sks
> that are bound to a single CPU or migration disabled.
>=20
> Make select_task_rq() indicate whether ->select_task_rq() was called by
> setting WF_RQ_SELECTED in *wake_flags and make ttwu_do_activate() map that
> to ENQUEUE_RQ_SELECTED for ->enqueue_task().
>=20
> This will be used by sched_ext to fix ->select_task_rq() skip detection.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--adcYUaZCOcZW1qi9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZvdQHwAKCRBZ5LhpZcTz
ZOYXAQDl8BXDR4jehG7ufJskbnyhXlnKc0obsYwDmuJzq3TCzQEAmFiGi1naPIH/
fjkll0bkClM7azFv/4VS53Y7OWQyqwI=
=X8iV
-----END PGP SIGNATURE-----

--adcYUaZCOcZW1qi9--

