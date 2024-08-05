Return-Path: <linux-kernel+bounces-275134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AF29480F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FCEAB23DEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB18161309;
	Mon,  5 Aug 2024 17:57:39 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873D15FD12
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880659; cv=none; b=Myt+ANrfpqvNZdPbFBvmPWFTjIJjdIh2A6O+LWC98jO8LRDPnIfUyBmZWBp7DHgO6KpLSg2FkJicsnNFBSTBgJwN1lFN2jOfiToV+KraqhdzmrjN+TOxVydBLmkz/RqIMHU7amCwU2SloUq2xkm/cG4tt8gJxz4gkkZlWXLHrmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880659; c=relaxed/simple;
	bh=jx8U9314XivC6hGV66g1QfXgCI96wqeH5Svwx52zkMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY2DTNkVWBLwPCE1qysA6uxRg8KqC2oUpha2VRdnw46A7L/DsRsY7VmaMMaunB+mq+JzaWnjnDOP1AjuIfCKs9V0X3z9gNTHP8FhfBMOCrd915m34aJaoC/+BRIzbGuhJ6qZYegj8vePhsL0dGssutzhWeOza0dzRKbwTGCKJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-45007373217so49190361cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722880656; x=1723485456;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jx8U9314XivC6hGV66g1QfXgCI96wqeH5Svwx52zkMI=;
        b=rS7Jj+bGZEAAZnoD3mT6ePalMCWg7Cd4Aw1ACU2x5FdXXlYB6DVjeXZHc2asqBDAOl
         G8pjoUk1c52fCgGS4LOOSQ7bTTqPeBTz9mHKtdfvdoo/ZIHo+xua8LfkoXLYOgJ43qhB
         lbEWatneEBvtfjlngNfZUdFrW38B+shS8CgGyQI6owlpRhXkEy3ApMu2H1J/ch1Pq/hv
         NNBbL8mFrFjybFLUIm4MTaGziHU17cIioaxn0JFIzAaRab8tWMotrA9ZUWs26icNuxb1
         FcrDW1gMPMYyEZBUXS2NS+jj9H0h4hQxzHEbUc662dcaUDwrJHTsCq+2m4qmTjVcaEEb
         VjvA==
X-Forwarded-Encrypted: i=1; AJvYcCUxlpnr8Rvbe4y1k//HTl54thULwDFpopREBy3y950El4KaguhQQan+bojs/ckzg8oYjBEqj+AeTO+vX/IDlanx2E+t7AETWYppFXbx
X-Gm-Message-State: AOJu0YyFpqwOv8RdcGgNILkH3AANoIV1aOmRG8Wba5v5ypKcnaKU8O6b
	IXCJxYLL2VrE1sh490BcnkorAjHN9MZ6wsfEXouzFYxC1fgrvIj2
X-Google-Smtp-Source: AGHT+IGBcBhAZbJF759LtBRWvajKtunWWI53M2KX4sqYjytt7tlLDpbymbOfapUqceRKZGonrSt1uw==
X-Received: by 2002:a05:622a:19a5:b0:446:6824:166a with SMTP id d75a77b69052e-451893b79e6mr222914651cf.10.1722880656509;
        Mon, 05 Aug 2024 10:57:36 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6f1595sm31125481cf.50.2024.08.05.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:57:36 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:57:33 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com
Subject: Re: [PATCH 2/6] sched_ext: Add scx_enabled() test to @start_class
 promotion in put_prev_task_balance()
Message-ID: <20240805175733.GD42857@maniforge>
References: <20240804024047.100355-1-tj@kernel.org>
 <20240804024047.100355-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6r3oC7kV1xTrPh19"
Content-Disposition: inline
In-Reply-To: <20240804024047.100355-3-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--6r3oC7kV1xTrPh19
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2024 at 04:40:09PM -1000, Tejun Heo wrote:
> SCX needs its balance() invoked even when waking up from a lower priority
> sched class (idle) and put_prev_task_balance() thus has the logic to prom=
ote
> @start_class if it's lower than ext_sched_class. This is only needed when
> SCX is enabled. Add scx_enabled() test to avoid unnecessary overhead when
> SCX is disabled.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Acked-by: David Vernet <void@manifault.com>

--6r3oC7kV1xTrPh19
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrESjQAKCRBZ5LhpZcTz
ZJSlAP9optKO6sUh0jLkmSE7sCt3WW7DrG4ZZ052pu7LBROsQQEA1V5+slQiIz5r
Yn+gkb1SYCAu3QVaMbDxYcUq8OH9/Aw=
=npGb
-----END PGP SIGNATURE-----

--6r3oC7kV1xTrPh19--

