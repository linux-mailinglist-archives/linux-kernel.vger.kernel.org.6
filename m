Return-Path: <linux-kernel+bounces-514722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6831EA35ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3791884872
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34C25A650;
	Fri, 14 Feb 2025 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3T1Kfd2"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58425A632
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526521; cv=none; b=PYhwOqaZ5FB2ENTemBU9m1PGAXqIriThiw2PE2jTPlfknc2Gt8nXS4GwGJ+WGfT2KXzDUIIQSCXjEDZWjsbOPgfCOgI6IGF/vU9oJ78rBx4xDM/tmUW1PMP9gakc5whCfiaNbcQTePlcNtQ/nFnb1xIafrx3fRnO4x9nhD3Qma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526521; c=relaxed/simple;
	bh=U/XK9lxux++1rCX/XaU4m5VtyKNJ/y7QLLupUamyVUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dYDKxk2oMBGSQDhneg7VPoMiszavB0WQt9XtqwSpBiqG7dm5nABA18oj/8eOWXju2nTdQr2nIXgKEvyG3saUUlUg5QcoEd1YVqateaRTF8mBiwmZ9/k2lJ2fy5LpdccWNZFfGj/A6aH8XvMe0B35C/3p4enGGleVmIN4lOAK+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3T1Kfd2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso311999666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739526518; x=1740131318; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mkPFoVMQL/mYhcTcaki3q36SMLzV+i7Fu65c+D3vc5A=;
        b=a3T1Kfd2Lvupf5jb+DYxLKz8w8xDNiIOLsoGqSqhsgVRo3SotZK1RmZ9OgJBYAOCAu
         ctVGwwV/d7rK9MpSX8JU8VFvZN6zO9QhBZBwG1vshz+yxIV05ojyTVV1jmkAtWvLzObl
         3+Jqnvvl1peqESMiE1k0k6cS1nlwC2ufykweIhpG3wMMiDX7SatrSLBl7qXATC73jn1C
         bLaDqqGVeUImBysnRBSZ5DoiTzLZLNgcJOvxStjbS4vvPMcBeG1wqiV8TRky4yspTSuZ
         ZYO9HWDdPzFcoH3MYtOtau65vHYRtqsgfgwpcb0DE0G+QLD0ik/t9upDppowKUPIjypC
         LUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739526518; x=1740131318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkPFoVMQL/mYhcTcaki3q36SMLzV+i7Fu65c+D3vc5A=;
        b=XzSjqAxw7yesYnqmRlZ3MlXBqkWEeCJ/zKCpxLv2CAwISQaAs6JMbpTbqNMu0JgCh3
         Ts4nk/U8ZCwrSzPaQxi/o96vELOJu4a+Hs7LysDeOzo/Jvv0Y3TvJIL+DBCIX9eFxaX/
         fVqn4tISzy/MFemLrXeUzzWgtBYIGOAEJ2feeQdEBnGNh0rKOVl946m53Px8liyOFBkQ
         sEdIv6GQwOex2vI1Wzi5HCmNh5AVThcnDQvpER6L/SotksXbNprkqJo4SATsPsB/39ID
         7SCOH57MtxYKTEH1/zfjHjd7YIW50b8XrtatYEel8NWFGxCjbUudXcGpZCu7AlVM6WqX
         yO9Q==
X-Gm-Message-State: AOJu0YwZ4M2nEkndRXTr4ihaJXE9Bi4jwcie8OPeDWA0Oe7g6xCaDKmU
	b5H+laiiMCqI5JovPtCqmlbhhFMWUPWkbj8mVdwuK371G2tIi31c
X-Gm-Gg: ASbGncuZ2fWSHL51WIPU/UWUbeZZVfIFk4SHDkVKq1Ssp+ieGqnnvJac6SIRrGRyRSN
	hlwKj9zYRCew+fRGMa9WrzeqMjx/4CsSbAMfv+DOVMFru/rdKhREKkVpU7JdQX6I/wh0xidpSZA
	zVqJaltFw4qvFwsd7vHlKOjIdKM5H7iUDFKm+NPzPfhYZ1DdWZN7AlHJ2PSowitXXQj1tdbgoun
	rk6epuZHNr5liTzYk/8fvOQLtGpFdVx/d/pvd2BA+ZkJpsAe2U1h6V5mYWuDxkizu8oOKyMM1Xp
	ff8zdqD/Fug4VD0WXp9r2BtjgaZnBria
X-Google-Smtp-Source: AGHT+IF/WMNFRvHaiGuGegW339Yn2o6KPOe0XOjLxo/ZqTX+q5ydw7HmVZEF28gC92P39HsPRvsXVA==
X-Received: by 2002:a17:907:2cc5:b0:ab6:f4e7:52f9 with SMTP id a640c23a62f3a-ab7f33d1874mr1151153666b.25.1739526518067;
        Fri, 14 Feb 2025 01:48:38 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339db66sm309917866b.148.2025.02.14.01.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 01:48:37 -0800 (PST)
Message-ID: <c07e2096cedc993e8a23ccde44e7f47adbeff99b.camel@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update info for SOPHGO DEVICETREES and
 DRIVERS
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, Yixun Lan
	 <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Date: Fri, 14 Feb 2025 10:48:36 +0100
In-Reply-To: <20250212022831.244143-1-inochiama@gmail.com>
References: <20250212022831.244143-1-inochiama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 10:28 +0800, Inochi Amaoto wrote:
> Add mail list and wiki info for SOPHGO entry. Also change Inochi's
> email as the old one can not be accessed.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0MAINTAINERS | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..6b79681877d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22097,7 +22097,9 @@ F:	include/linux/sony-laptop.h
> =C2=A0
> =C2=A0SOPHGO DEVICETREES and DRIVERS
> =C2=A0M:	Chen Wang <unicorn_wang@outlook.com>
> -M:	Inochi Amaoto <inochiama@outlook.com>
> +M:	Inochi Amaoto <inochiama@gmail.com>
> +L:	sophgo@lists.linux.dev
> +W:	https://github.com/sophgo/linux/wiki
> =C2=A0T:	git https://github.com/sophgo/linux.git
> =C2=A0S:	Maintained
> =C2=A0N:	sophgo

--=20
Alexander Sverdlin.


