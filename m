Return-Path: <linux-kernel+bounces-248128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A39192D8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08586281A29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6CF196434;
	Wed, 10 Jul 2024 18:54:44 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F7774416
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637684; cv=none; b=UOWURWLUsz63blmvYVR3Zv6lyRtVdcdlcW3RScpJd/oZxFHBKz/May8rTzIWlFi7pBi4GXLBMWw04mpoGULkjTPHAle6IejNkfyVnhUf7xvaKnHZrmpr7jgXGpggv1q3dMkhMKcc78Hd0D/wXjYFioo+pdfWKUPIJLDIvodgHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637684; c=relaxed/simple;
	bh=NbYzgKbREWnxvRhYNf+TFCsSLSawmABdT8bGM1pLqy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFCEDcYE9pkOz5V0jdsRs6lX0CW+eAbw8nBbxwbJcLD9s/TCHfh0HmoVGb937eVmsfjPBsdX4dEwDwvzD6ITqaVVbWo0U1x2KhOpJi1K2qybL+F5ohUAD1KG25Ene0xqWK9bGjYrgL/epx6IbwnQ/QgkqyjkIdZ4B8mn9EsHNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79f02fe11aeso7820285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720637682; x=1721242482;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbYzgKbREWnxvRhYNf+TFCsSLSawmABdT8bGM1pLqy4=;
        b=QxEmZ6Ihzz1ifX3edkhRxp+xNiztvtxSmyIDkY+cOkdlsccXnKTvFmUHy6zNL0HA0Y
         avY19xwmx1uhaHdSIUnNRxuyQ+VQfgYQDqQmjerdTIXiLaqGp0gNz26HI+jl3QQ86JBq
         ZviZxgT9USly6RopO/LnGz2Qlvv/wT/cLxrips0o84DPN3TLUlKM+dx9v3go6fOiLCME
         hVPJx8Taq4ZAJY9vJadHNl1XCpWoGhh0WJcw2O6WTTxqySS3CTN42iZ0INV5Q+PhaD2c
         o3O2DkvxXMuzLKB82sZBBrtDh5rf4e1G7BviJRwwBa91wlsW0TtBuAD0Xq+o8fCtbfWO
         jeJQ==
X-Gm-Message-State: AOJu0YzDisE6PHna5zeTEsQTeIicnrErvZ0lETB/8ojfr5x4I99r04Kb
	T7N2xgHtUeEmML3gY5UNDDHDuYwooMmqv+I8PPnTKw9w6T+zE933
X-Google-Smtp-Source: AGHT+IFmF8OUTGi39VXeBwceJniqNZx4jcjngz2AwKHZEOTUARiHi2BkeegvF5jP5vgLPk4r9M9duQ==
X-Received: by 2002:ae9:c010:0:b0:79d:57e4:8802 with SMTP id af79cd13be357-79f19a6f773mr659152185a.26.1720637681778;
        Wed, 10 Jul 2024 11:54:41 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19029157sm218646585a.71.2024.07.10.11.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:54:41 -0700 (PDT)
Date: Wed, 10 Jul 2024 13:54:39 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 4/6] sched_ext: s/SCX_RQ_BALANCING/SCX_RQ_IN_BALANCE/ and
 add SCX_RQ_IN_WAKEUP
Message-ID: <20240710185439.GE317151@maniforge>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nvrP1VayC8eMIj8j"
Content-Disposition: inline
In-Reply-To: <20240709212137.1199269-5-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--nvrP1VayC8eMIj8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 11:21:10AM -1000, Tejun Heo wrote:
> SCX_RQ_BALANCING is used to mark that the rq is currently in balance().
> Rename it to SCX_RQ_IN_BALANCE and add SCX_RQ_IN_WAKEUP which marks wheth=
er
> the rq is currently enqueueing for a wakeup. This will be used to impleme=
nt
> direct dispatching to local DSQ of another CPU.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>

Acked-by: David Vernet <void@manifault.com>

--nvrP1VayC8eMIj8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZo7Y7wAKCRBZ5LhpZcTz
ZO44AP9yVFpq8LZv6IkqT/rEdY1CJALnGkI9mJFcD7wbx5jWAwD7BpO3Q+DKqcih
X05ii0s2k04z3gg3OXAcTRL76u8wbgU=
=Evjm
-----END PGP SIGNATURE-----

--nvrP1VayC8eMIj8j--

