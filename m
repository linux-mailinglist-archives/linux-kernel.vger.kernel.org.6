Return-Path: <linux-kernel+bounces-364142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36BC99CBA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8441F22A88
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4A1AAE16;
	Mon, 14 Oct 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OSAx8+m6"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5541A76A3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913039; cv=none; b=Fl0d8tV66tmBDw4A6LSUe5YKTwmqjV1Sxn0zLCxLwPP7xgGRckZYpcVvG3TaLl1aoqlORmjSpNT6KrdHNJUiyjfAQiPA2jXVmRccHiQJHBRch46YCH2hE217C8RSrrTBtZlcZgjMbQhoiNN5XPQemk8iR/1F/3QIBsph7a302NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913039; c=relaxed/simple;
	bh=Gs8yQqJiEPrpcaAZVy5Me9kxtOxLIeh+5JzVS1n4afg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LesdKyOPrU5c7cOV+wld7vURUUeTB1Bg+Qv/+/HIsu/CWYACh6RKmXhYudUt+8sPp5uwqa38eIYK72K0J23kGBXpbk5lDqAHgpfwA6qlMWTUCbAgvtL7rMwl8bk4A3/t8pyqV9zCW9ifvEznmLdz9BUW4qhBhJb5v4M7t1HZ5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OSAx8+m6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539d9fffea1so2985761e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728913035; x=1729517835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOn+At6E0BNzEl4WQ5SD3/qKTI8tXp+PBn7/nxLGbuA=;
        b=OSAx8+m61ZMc6VGLvcpOndNUXXSdWnOKH7a45I6lqb+hxqxPFbb2vpx0OuX8nZ2U+Z
         8KlgLOOiyHxbt8MZmHPN806wMwMmoPD//UH/F6piuvk7uzy1lqOJS2GdYKjDyLNRoYLu
         K5HxkThQEQ+UqjnNEGPh/IllVQgKy2fVdDaddAf09sROe8V0Q8Dr79wqRR6iTKEOX4TP
         euFSTQZgmTokkuqUwjn8O3uvxjQqXg309qWR2aMdQWHBbEHKu1hFCRAMQqDWn/JFlZmY
         uFNF46REwL6cEjlRYPwlQjw+F+16StwPFcFQnZdjBSkO4OhFG/0V6vMFG942jjubj7IX
         WLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728913035; x=1729517835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOn+At6E0BNzEl4WQ5SD3/qKTI8tXp+PBn7/nxLGbuA=;
        b=lus4UTvnsB9I1h3zJ0oE8UtyTPIudQfYzYq/sOOHailPVcU0gZkTt81EesnOJ+hhBK
         Fq7V9FEbTRhkU/0lqDeCHrng2E68woYESFwBSK2V+UYch4NZoW1BZN1PxDAfBvhFx/bq
         Bte9sTddpIRUSt02aUPY2UlSk1FtHXTA/nfstyfHFm3hU4w/WXVQXgoHBGHrKSTJF9kA
         V5luKrFtYSA8ekM4xCS3YElpriTcVufsrCMemu6nzY+COHZ+ML0cU1N3n+bh4sgSYump
         52DXXlEcwqOm70OnlLODn15LUk9YylHCKJG7zKzwbnNAX7FmIKRZyd3kO45V17C3s/RJ
         5Rrw==
X-Forwarded-Encrypted: i=1; AJvYcCXsXEeBk2/9PmjMDpMGO5KEzc69MJP1GlaqDkmWLGqNlOofrdb4vuPShFhncEa4Lw4baTeEzRgYbvCBzOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSyUVUPA7iphTH4ZFAOcQXdxhtABzwYRYqE3FGYgeAUdFK+/db
	z6iX7Zyikf/AEGSWwxShaVMuJ0PQp822DXyQR7TpTu1emSKeJG5pSkRa7cBbGVo=
X-Google-Smtp-Source: AGHT+IH86U7CDo7HSsXH39ATDKaR2Ec3/LHDSIR2tYXCbN7J5SkSn0+U9/jLZE05OhdsZhPGGApsvA==
X-Received: by 2002:a05:6512:1322:b0:539:8ad5:5093 with SMTP id 2adb3069b0e04-539da4f8aacmr4766947e87.35.1728913035424;
        Mon, 14 Oct 2024 06:37:15 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7929sm121587275e9.4.2024.10.14.06.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:37:15 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:37:13 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wangweiyang2@huawei.com
Subject: Re: [PATCH] cgroup: Fix potential overflow issue when checking
 max_depth
Message-ID: <hbkgbz3cmnd5e5qftzlmulc2so6jhvn6k7klpuqkod5hi3l6sp@53xgyxqgwhg2>
References: <20241012072246.158766-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zuyrdh3jv2s4v2gq"
Content-Disposition: inline
In-Reply-To: <20241012072246.158766-1-xiujianfeng@huaweicloud.com>


--zuyrdh3jv2s4v2gq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Sat, Oct 12, 2024 at 07:22:46AM GMT, Xiu Jianfeng <xiujianfeng@huaweiclo=
ud.com> wrote:
> It's worth mentioning that this issue is unlikely to occur in reality,
> as it's impossible to have a depth of INT_MAX hierarchy, but should be
> be avoided logically.

Strictly speaking the overflow would be undefined behavior (Out of curiousi=
ty --
have you figured this out with a checker tool or code reading?)
Logically (neglecting UB), max_depth=3DINT_MAX would behave like intended
(no limit).

> Fixes: 1a926e0bbab8 ("cgroup: implement hierarchy limits")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/cgroup/cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--zuyrdh3jv2s4v2gq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZw0ehwAKCRAt3Wney77B
SZ55AP4r4/UR9XA22f9r4OEC208fBm629qmMWSYAzVkjrue4qgEAoNy7iVQHBmKg
mUxEPIAvVO7bL4Mv0eQaolnVxB/x6wA=
=2oAc
-----END PGP SIGNATURE-----

--zuyrdh3jv2s4v2gq--

