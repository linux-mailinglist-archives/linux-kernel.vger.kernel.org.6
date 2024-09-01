Return-Path: <linux-kernel+bounces-310053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37232967428
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 314FCB21ABB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 01:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD80225D9;
	Sun,  1 Sep 2024 01:43:42 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047664A01
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725155022; cv=none; b=SRAvmnR2+pFU0bhFtSlWlYdkorEMGoiDKDEQM51HfxNwRlVTIr+hvEphZOA3gsDC6xVkCmZwq6csbjCFbtJcqe2VjkKI8RmzdqlQl/oUNyNa/DHF1y2Xt8GJzaUujOZHEu+HEImpuXKj0qJGOGNangi07qsM9X0H/njlzpMN9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725155022; c=relaxed/simple;
	bh=cT984C4DlXQAvWgsRh5KDuRgGuSUDjdcH7q1NB5NK+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCt9ZYDQ+bxh5fSgZkn1x5ExcdyXsGMcIqLpmkNODPjOR2pa+XcmrmaPWflR3PbZHkWxmOW6RR1wNYcK1sw5ZR9Gqv9gyv6LcsTJQ+g9kHgiNqNShU7ssWCiSQlQNPMMjy5vFtqq6qyC33Vk69p8UnnQiZBhZwCwXDlPg7XAICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4568acc1ca8so12918321cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 18:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725155020; x=1725759820;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT984C4DlXQAvWgsRh5KDuRgGuSUDjdcH7q1NB5NK+s=;
        b=fz8vUa4oGAvManDIyhOMkFEVrXOW9qnBgq6nzDtVhVwYyN6LqtrWa2q0E/9aRGM6y0
         4p94EWI57TRAoWEZ8VcLmSRsQ2+lfzGnItvumpu5foTI67zG8Ixk9SZbXVTLzb8CXvFi
         9edWN4qaUFZ/UV7kGFZLm+33DYjX1yZkhHrtIb7H2fuqFtPmpPuYucVoNEXbvGfxKcHg
         BoFwAlQqaiYkuQecGteqLziNIIiiz9yQEwIBxIaH+v6GzVaXfbK2cHoRBWcIqLUSV64A
         U1xrWH4YmzpXptCsslfswVw/DrYeu92ue4+95J9XONDKDbOCszoWjlE0u63LtmUgLOJa
         UClw==
X-Forwarded-Encrypted: i=1; AJvYcCWIi1cM0Y6HntinakoT/D4dYFEyvzV4/uVYDhB3roK91O39xDgttD3oCxT65hzqc2kbSprbSp8Ojsc+4jA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUi/JOlYKKSbkJnteeDfnmGZbFlItUr3T56KwFDn64u/qrh1d
	F5nqR11H0kxDo/ltinZkteG3q4Z3Tcl0zXWeVTdw+hUIWxqh3ThmHrEUtb40
X-Google-Smtp-Source: AGHT+IG0j6XQTi5UQRXpmfHocqFx3YcYnxYvbnU/kvpd/h16NjO8omVnH0MI2l4hvHt2Ls8DND46Bg==
X-Received: by 2002:a05:622a:4acf:b0:453:74cd:3c93 with SMTP id d75a77b69052e-456f166a284mr68727131cf.9.1725155019508;
        Sat, 31 Aug 2024 18:43:39 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c9b9e7sm27992581cf.29.2024.08.31.18.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 18:43:38 -0700 (PDT)
Date: Sat, 31 Aug 2024 20:43:36 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] sched_ext: Move consume_local_task() upward
Message-ID: <20240901014336.GI70166@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-9-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y6+VRy0/AAYBVeoR"
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-9-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--y6+VRy0/AAYBVeoR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 01:03:52AM -1000, Tejun Heo wrote:
> So that the local case comes first and two CONFIG_SMP blocks can be merge=
d.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--y6+VRy0/AAYBVeoR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtPGyAAKCRBZ5LhpZcTz
ZJyZAP9cZMBdiTB5c2X1YZ/unWiFgp7Uy16RRcQ94Nfjtg+cQAD+OnROX9zG8TFy
OjMdPR6LhBnzS2BdO+OT2ItS9iS65wg=
=ZJc6
-----END PGP SIGNATURE-----

--y6+VRy0/AAYBVeoR--

