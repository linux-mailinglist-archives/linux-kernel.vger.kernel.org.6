Return-Path: <linux-kernel+bounces-255055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41023933B13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B981C219EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B217E8FE;
	Wed, 17 Jul 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="HY4PEGoc"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18EB3B182
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721211587; cv=none; b=pmgsrY9f/Z9iRug8onGvo3Se291slnpMxh16c6U5fIqCNStCKD4lU12NHY5R08X0+/EjWV7dm8L6El92rHg+Odyl0rUFh4gy9B9gEbAYZbkoI06k+iDMuTsONK/ELL+U79yIrOVdst0Jf5Vxl1OJNkrufTozYzXPvUYlvtPtyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721211587; c=relaxed/simple;
	bh=dmPrErveI9QrEh/ALH738QNw0Bhaor1QfQBU+noYS6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXiPHIQpjUKoZKvvzLj8eUFo9Drt1a7uneqIQE7uiWv3CA6prbcpJk0z+QlEvs0pg4n25boEQIC8Y79GzF01XDdgMuyX9KHWD7oiS5VC0aVAmZ3lr7EYYPaHT8pJF/ckqhnzNYK1paaO4DiHPhYHUKt2L9JAX5MoCE8Qask1zdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=HY4PEGoc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ed741fe46so3927432e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1721211582; x=1721816382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmPrErveI9QrEh/ALH738QNw0Bhaor1QfQBU+noYS6o=;
        b=HY4PEGocempt1P+ryYqkk1AM94AKzkbBNlvkmAgPPxSq/ij3kfJi7J3Av0koHdXFhN
         w7uWUY6P2bEVeF0C83d6uAbHwfzjtT8N5wZI9RffbRinSidZnyMU5g5kvYXRNDeJ0MUX
         BHr3axV37gQ+cGC5uBiIhHTgMprM3GUXbg+jYyQCaK/49YWI2M6m0QFy0mat/yrqk9js
         AZZBjvShvCOcL+oBImJW+he3oXWZbkQ/i6+1m0izB6RPQJ7TFbWLhAL9ajTyV1MrT/9h
         jFGVkEZKsr0CD4t6e/tNwHwSO0JQ7Ckv4vy4+ep+JBzOTeCHyVVDEDElaZtLG1AYij0t
         r1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721211582; x=1721816382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmPrErveI9QrEh/ALH738QNw0Bhaor1QfQBU+noYS6o=;
        b=J/z28rN6AwBYe+U7byFYd6kepuwcQ/NgKVCWgyVx4kBd4vPfPQ/iRDwedJmEA8vtxx
         BLbJweozbeIYkjJIB6qEuPrkmPTsijPj5dvxYaVmRM6dsWTC/cI7kmA6Urzz1Tv02UIg
         I5h6LAkgXYmDtGjHSvc59Q3Kl5IG4VqqQDX2A/XID7vQJBZdLcmwsRxPZKR64jT4xwaV
         hc+E6cJaJ5MOaTQlvU8kJVvb4ontirSd1F8g/z0hZWFoo3Mfu/Pj+bumMizr8zJBrqfc
         0i8xgNoXnTKCZd9exem6Ahw4huxrOlJ8ER+eptkdUl/DBntrcgmWzuJj3IINO1dSGjV+
         kkxw==
X-Forwarded-Encrypted: i=1; AJvYcCVCA+G0SnnQICk+tJcfcmI9EOR5K5K3/qSP05DwAvXx+EeOmRcje8vL90JctD7YQo1t/ImFevTkTKyvxk2LUqiMb7jk6X9UvVS0kLkn
X-Gm-Message-State: AOJu0YwwUwc7FW6rqg1BfY7GgiaSk92NJ+a6aPLcAhqlvjGp5LyFm5jx
	XAxpwALC2N2D5fppuOBdTXH2eFxG2FNhRK6VrjfcBBfQ77d4wMSwPRqD0tpJZjY=
X-Google-Smtp-Source: AGHT+IEag26CiKDtnt6JUIWKttV5gz23VEY2V5rBdKxFWabZZE7cd1oBzs2oKhgA0HlG8qxYhwdSaA==
X-Received: by 2002:ac2:4e10:0:b0:52c:d834:4f2d with SMTP id 2adb3069b0e04-52ee53bbf6amr986059e87.18.1721211581711;
        Wed, 17 Jul 2024 03:19:41 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e81f0dsm164072005e9.12.2024.07.17.03.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:19:41 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: David Gstir <david@sigma-star.at>, sigma star Kernel Team <upstream+dcp@sigma-star.at>, James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Richard Weinberger <richard@nod.at>, upstream@sigma-star.at
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH 1/2] KEYS: trusted: fix DCP blob payload length assignment
Date: Wed, 17 Jul 2024 12:19:39 +0200
Message-ID: <2351895.22IY78Rhhi@somecomputer>
In-Reply-To: <D2RQC1H7N1JI.1W4JT8FI0R8L4@kernel.org>
References: <20240703125353.46115-1-david@sigma-star.at> <D2RQC1H7N1JI.1W4JT8FI0R8L4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Mittwoch, 17. Juli 2024, 12:07:58 CEST schrieb Jarkko Sakkinen:
> On Wed Jul 3, 2024 at 3:53 PM EEST, David Gstir wrote:
> > The DCP trusted key type uses the wrong helper function to store
> > the blob's payload length which can lead to the wrong byte order
> > being used in case this would ever run on big endian architectures.
> >
> > Fix by using correct helper function.
> >
> > Signed-off-by: David Gstir <david@sigma-star.at>
> > Suggested-by: Richard Weinberger <richard@nod.at>
>=20
> You cannot suggest a change that you author yourself.

Well, I suggested the change, not David.
So, I think you're implying that David's s-o-b cannot be before
the Suggested-by tag but after?
=20
Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



