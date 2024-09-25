Return-Path: <linux-kernel+bounces-339442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD67F986523
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787191F26016
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB974F899;
	Wed, 25 Sep 2024 16:45:31 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7BF8825
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282730; cv=none; b=oKkYV39t09NhbRUA8j1z+uzV5k66F4cKv7M8AAJn6ZnqUBTj9DZeTwae71V8GibmeZooRmdKx7syZjFArq2in1xH4HrpuoJU+TOGb+hPz/3vi1I2Xrw5WY3W8DnJiXeaHrISwMHo14i5A3NrqpCPlesMQ4ITxD5jygGUbwrjojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282730; c=relaxed/simple;
	bh=R0zGtJJBLYyOfsHE94n2GPWMthMX668uIk5fr+gNgbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO8vGW7pflhUxYf0lQlqLC49NC4tjfBOz9bDXl1m+thQl1IUZ7UEshXv4jSI8CmxynsLp71C3EFWvxm330IcVeA9GX7OLa1QUVpymcnLvoVQT60f0RnGiIU0ZUa7lhiDboAAGPf98sGdrjrG61aVc74q64ku18G9ZdkeuzNle7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82aa6be8457so4029339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282728; x=1727887528;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0zGtJJBLYyOfsHE94n2GPWMthMX668uIk5fr+gNgbs=;
        b=UbUnzK9pbE5nKLDyXsE5bdRetc/mMp0n9w0K2LdjwefGLvTy8/BXBCRs431B7sbIDG
         xuLUrt41hL53uPCJWLObFsB/baqtws/+Rn9wLiwuZl+UZTioees8evUP/iiStoAC0xfI
         J//w24z4fGp71HH00xMLpgA7ojjncGfFTfW+eSpfcg/zh3ZAWW+giLxFj+7vS+6ocXc0
         GlsYDgBgNqTr+KIBCK6hmWMwoBxSK3Emmr7dmIPbaPMG2e0uF/b7B67Aek50gMAqCe7B
         TSndu2Cf2dH1Z0+v3YRxZMo1q/3KzAOx0e2p2zXej2HN1gLqBZahYDo0uPF6P+fvm20s
         lt+w==
X-Forwarded-Encrypted: i=1; AJvYcCXR2pZ8Ci4l5PntrFqf8I1BV1o3jOMtePkgKvugX455IKbQIvGYRTNSROuexYzOVMwvAJDhTGhGfl+aqcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kDuhiFPkVJ3UJUNeTndIW0CBb8i9ooYVW2cDpwk2ojOMnaAG
	w1CB1H6FiAZQq+VmrErUQOEbZV/qeURUsBMhbpifc/urAl0SyIYd
X-Google-Smtp-Source: AGHT+IFFJyEp2rqyGyieTcS61Rf3cEfT904Q5/Y4OB02ndg2nqUIGWSuzxb+ps3NZd9w/aTdbz8Bkw==
X-Received: by 2002:a05:6e02:1e08:b0:39d:3c87:1435 with SMTP id e9e14a558f8ab-3a27684f5b0mr2174055ab.1.1727282728135;
        Wed, 25 Sep 2024 09:45:28 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d612994ce3sm602938173.70.2024.09.25.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:45:27 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:45:25 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 1/5] scx_flatcg: Use a user DSQ for fallback instead of
 SCX_DSQ_GLOBAL
Message-ID: <20240925164525.GB26346@maniforge>
References: <20240925000622.1972325-1-tj@kernel.org>
 <20240925000622.1972325-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HagR0pJ29h10r2zu"
Content-Disposition: inline
In-Reply-To: <20240925000622.1972325-2-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--HagR0pJ29h10r2zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 02:06:03PM -1000, Tejun Heo wrote:
> scx_flatcg was using SCX_DSQ_GLOBAL for fallback handling. However, it is
> assuming that SCX_DSQ_GLOBAL isn't automatically consumed, which was true=
 a
> while ago but is no longer the case. Also, there are further changes plan=
ned
> for SCX_DSQ_GLOBAL which will disallow explicit consumption from it. Swit=
ch
> to a user DSQ for fallback.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--HagR0pJ29h10r2zu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZvQ+JQAKCRBZ5LhpZcTz
ZNvxAPsGOSQlsl71mmsV6F0P0OYO/GQMYdI3tZlwBMBh/wGNaQD+NnRtPIe9KuM3
cVeDSnyOyrsIIWF+WMgmUvQWr9ujLAA=
=kfSh
-----END PGP SIGNATURE-----

--HagR0pJ29h10r2zu--

