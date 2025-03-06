Return-Path: <linux-kernel+bounces-548536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0985BA54632
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490FA7A58D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A59E209681;
	Thu,  6 Mar 2025 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZczVZJqN"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E9199935
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253063; cv=none; b=Rzp3onJ45RHwWDCcEvycRvOCsHInOI+m6kzjtrmQ18p7Fs2KCp493i5ePHJlQBsMUsxE0WigtdCWC3TgSgNICfT+6mzz6+pWqCbLQpM5wq+5eEEAn+Yqxla+NjCr61Km3DBYA8wc8J/mDAANTLA055aE5OIK6q+Vl2LvSzcYjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253063; c=relaxed/simple;
	bh=j0RcAgL5YWRREhQKAZGCC/R9ud0Ut5V3hmRzvVuFIn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3EuHzogFWeIL7AvPEbVQXwXHoyrWZlmBqBtxnaJFjtKKnI5E4z+EWgX+HiGYP76a53ksbDzJVsz83f+zYUMKpAmFe7tsJoJQ6J3Ra7/ILkR6C98hThCLD7xPGf0WLKtxxuUHNsSqrZphL2wEe1viJ3a2qQUxJ8FF9NCYpkZRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZczVZJqN; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43bcfa6c57fso2231075e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741253059; x=1741857859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j0RcAgL5YWRREhQKAZGCC/R9ud0Ut5V3hmRzvVuFIn4=;
        b=ZczVZJqNuhyT9Wcx/fWZGT/dsQsca/vEx+fe0XEBfcnSyN5atPg8jGGzNQRyqG5Rww
         gK1r+G3PFNPFcYIVXVIkf+H+/YmLSwKVh6LdanrGsZ3vSZytEaZGu642XHqlL2sutmay
         UqyZE+QlUgXbFeH7L964fqi9zqA3+eFp60d9aAs44R7MNHkbgIvDg0UQ8gg4WBg5/J8d
         7QAINt+HF3lDy2XXMJw44AcroUY8nLn36S3d4soVuznJPGW1t4oxOTUSEvRzCeWtiuJW
         wRn//skyF/wgNaANU4FnQAOpVCvs5eb0Oa6NIUjQYiLR5Zjzm4gBU5U64ZTYvKZGxs0b
         Eybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253059; x=1741857859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0RcAgL5YWRREhQKAZGCC/R9ud0Ut5V3hmRzvVuFIn4=;
        b=Nxi0HOT/rDA9sPaIwRMXadyLNE3kUAjX6tkFiYUrlbh1geHv9BpNHO/TqGPd6iemd7
         g9pIZFF5WUYvd/IglLNeZS2+VKxezQGypYIb4D59Z+Fo+yUrDtvKfJsMIQA71OxX+UaM
         l4CtFAkVTYUUBJ0Aa74+54lNa5Xdy9vLJ4HX2Zejgpd2CVh9nKdT74j3Q4pUTCcyIsm3
         MN9bZ5bx3XeMKaZ32hxj1fq122L+J6b0pBaGJRMPTQTjdsf8Ty9FJvsd1S3K9tz8PpZr
         SVVb1kQx7ozVy70TWklq6MryQFdVBnqc5g+ahcPhCyaHMZWU/42d6QDddUGfIQpFiNYY
         l9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFpuukkBcI5d7KCoYr5u2CFqBs1y805FZln6nLPa0fEZvSkpTrpXl9dtdcWPaBUBIKfLDm7Ld//xZNOgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBtR+StpHduFHovLQYmGl3/0Y7MaDG9vT7Gv8/06fXroBomT5B
	RMUp8OGBHyaTKElGSM+WAWnwLXnhjoOXR1LFq/pkM705jQ3I9bbgG/gzNodb6mcu4fo1OZl+Anq
	69rBM3w==
X-Gm-Gg: ASbGncsjOpBeYL2EqbYznLIWqFDxs5pqdTwpAY9+8TLiEbwhhpAYQb1ZUjIQemq7sqv
	grBLQEgTm9Nvc58Hd0jWUxv1kP/rK+G8qBSg8c9c0ceUhrrRzgcgYjWNHV7OXQm48iXjE4T6R4M
	Ys1k7+XRaTVxsHJckjpz4gEi2vxT4kkmflXGcqZYqo6vjFc4ECjrB3S/1Ae/c5/4zCW3OVIcat3
	P6pc1AtMGngrs5cbz4wbtz7mvSm90aF+PoPZ0qF4l73RsBEw5BHxYvKN3I6dVaaHoE2bi9uxh8t
	sAmBVkpDUpE5nOcYT7ofx+xtur0bGbrTSf8tkBXO5xZzfLM=
X-Google-Smtp-Source: AGHT+IEwm2Wm4aFloBAUl06rFqikq/Xzgz5VXqXvF3hfYK5HGYNeMVztKGBzm2e6Ik1rxa3tHdAzQg==
X-Received: by 2002:a05:600c:3ba8:b0:43b:cd0a:970f with SMTP id 5b1f17b1804b1-43bd2929829mr48086105e9.3.1741253059315;
        Thu, 06 Mar 2025 01:24:19 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd435c836sm43678905e9.37.2025.03.06.01.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:24:18 -0800 (PST)
Date: Thu, 6 Mar 2025 10:24:17 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	Joel Granados <joel.granados@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Wei Liu <wei.liu@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pid: Do not set pid_max in new pid namespaces
Message-ID: <nma6nbsdpu7qu7afdkrqzvyf5fxgw5x6vuzmeyncct4ertrgva@vw7ublyhbzxp>
References: <20250305145849.55491-1-mkoutny@suse.com>
 <CAJqdLrri0q-Et5PfdwP69r7wYDi3_nY225UP5HYVABUFtE5TGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ktuupgvc2fngchzs"
Content-Disposition: inline
In-Reply-To: <CAJqdLrri0q-Et5PfdwP69r7wYDi3_nY225UP5HYVABUFtE5TGw@mail.gmail.com>


--ktuupgvc2fngchzs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] pid: Do not set pid_max in new pid namespaces
MIME-Version: 1.0

On Thu, Mar 06, 2025 at 10:11:27AM +0100, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
> This completely makes sense and I tend to agree.
> But we also need to
> ensure that the kselftest for pid_max is not broken with this change.

I built [1] and ran it with three passes. Assuming it didn't rely on the
copying.

> Let me play with this stuff a bit and I get back with "Tested-by" ;-)

I'd be happy for further validation.

Thanks,
Michal

[1] https://github.com/Werkov/linux/commit/019b884d5a005dd8a3e18f0865b276fc3d804d7e


--ktuupgvc2fngchzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8lpvgAKCRAt3Wney77B
SbSsAP9STriSECu9xxBMqtt5p67lkH0RAvIMkTeDmNDfhPGC/AD/dzKLCZyk9tEI
bhGjN+iD01tmM3t9M4rPQh0JtGQhVQc=
=N3gY
-----END PGP SIGNATURE-----

--ktuupgvc2fngchzs--

