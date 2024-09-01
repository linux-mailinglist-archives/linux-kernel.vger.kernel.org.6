Return-Path: <linux-kernel+bounces-310052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5A2967427
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8881A282D37
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 01:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3073225D9;
	Sun,  1 Sep 2024 01:42:27 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF564A01
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725154947; cv=none; b=qJ77Jz7WFkSbvvgoCZos8o3V8IDsF8oUFbZsIlT6XvB+mJfIUGNcqOLoXIXyky8KRvFRTsx5LoH3zmDB9MaUO6jMq1AbefuiZRtbGvuSZcOf2N/lKW+/BzRLHJR7Q8oBXPiyC+kHdwfmOuOVOeOW2xtCovZ1TBk0dPMWhfBkW7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725154947; c=relaxed/simple;
	bh=RZ45ILZdu96pIDJIuWrNUi9JD+I9Z2hcrCA16yeNQYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlyIj7HSXDcpK6l9AiU3Pr3afdW9F1L1QhFxxqTeuq3Ne5C/0eWwe9Kct1uq9/Un6XF6wXAbb73PZvZD2WwC5kw83pNRw++erTa6tcGEtcDKUMrpg0paLFKMi+VQeGtAJhDz8sUovGVzg+ma5mK/4qP7dIBb9Ft5uIsMoARtjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c331543ef0so17481706d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 18:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725154945; x=1725759745;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ45ILZdu96pIDJIuWrNUi9JD+I9Z2hcrCA16yeNQYs=;
        b=p4AoJSjDqRf3PaJ/oqEs9Emd1nOh79c5T3qy33DRJLp56dNhJmxo01KfaqMlLaHoE/
         5LQDJnjtc8orEROBOFAmGzHTFBueiGChcga/NDKLHli3SqPUfiDOzlS5x2bW0Xrf7Ykd
         0ieQkS46XUttNYFuDB61qkHEnF+vOrJ2liEIGdCq4o75iWJZO5Ymd5GTnbf84fSRYl1H
         tYDf4yNo7+otcmhCmlhtHwpR8HQpjlZo4diL2pyOLMaFWTIginXJDCl4FrJ+3CTagDMY
         nh7UsFbTPz1TAcFE8GNcssY4XDs5S8IcEl0hWgZMEHuaUyOKMvMH+qyXJX0ipa1qPaBr
         Wzmw==
X-Forwarded-Encrypted: i=1; AJvYcCUcRLLuuPjyp73nanWybHcWc1duSyKDGO+tFMTT0dSy+0WD8oZNSX7JAijZ3ysmvoJMPsYIdUE0Lz3ohjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcoIYoBOZdLtf2AQX6Wp2P8YT/V6M7A1Z3AOrjXuguRdZJm1W
	ztqfFDbg2/EcB5zSrNUsE4MEUctJoJHQTiQKV/HKT3DMl3YWVL2g
X-Google-Smtp-Source: AGHT+IE1EFpur2BbSZlGAOlKbOvNOGgV4AAadJE7GEkD8J1Fh/Jahq7yw5AmNm1LqGsiLY4+6R+YYg==
X-Received: by 2002:a05:6214:5991:b0:6c3:62c9:aa62 with SMTP id 6a1803df08f44-6c362c9aafcmr4801356d6.28.1725154944795;
        Sat, 31 Aug 2024 18:42:24 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c01644sm29298636d6.54.2024.08.31.18.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 18:42:24 -0700 (PDT)
Date: Sat, 31 Aug 2024 20:42:22 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] sched_ext: Move sanity check and dsq_mod_nr() into
 task_unlink_from_dsq()
Message-ID: <20240901014222.GH70166@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-8-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PCol9SYQX0lMRQH0"
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-8-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--PCol9SYQX0lMRQH0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 01:03:51AM -1000, Tejun Heo wrote:
> All task_unlink_from_dsq() users are doing dsq_mod_nr(dsq, -1). Move it i=
nto
> task_unlink_from_dsq(). Also move sanity check into it.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--PCol9SYQX0lMRQH0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtPGfgAKCRBZ5LhpZcTz
ZP9DAQDjK8zHxKZXVHLrDzuONa7GrQYbmi+giM+Yhi1pb/53dAEA/IyoM07WvcMo
xibehORZPxhcaBtIDj2reAtpv3YKFAo=
=eu5W
-----END PGP SIGNATURE-----

--PCol9SYQX0lMRQH0--

