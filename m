Return-Path: <linux-kernel+bounces-295916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B9F95A2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165C028250A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABD115383E;
	Wed, 21 Aug 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CDa0JJJp"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883C14EC5C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258117; cv=none; b=c0+gD2b47637XSzuYphhDhkHDgkEYv8N3NYcNdsn2vh9Na/dmH4Ig5+Ifgfnq0vdQy4nIbSgkufGG/UeXoWnrywxh/su92n/5KVfVhBf79vIENnR0lOOaXvVeVdNk7FXZXCwzeedAezzgKXKVwCQfAB5w1zm8i3wnW1Dw84z4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258117; c=relaxed/simple;
	bh=7RRSQUF/jWGiZ0j43cyHJL9hMT+ZUZY9A7jG7PxHBzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dowwLrgPCGmjjVkszJLhxSHfBGoHNiSsXO2nT4vG2yCyDGzg1VcI+ZbMl8XZTCdcEYJbLcpotgjJ1FI9sVzSuXXuqPkJ0yGGzC3zvMHY2SZ7Ol5V8ppW2xPnVNHevpPiU4d0kcJj5NSQ8v7z0yQIy+UqHqjOmM8c1tuWXP5rhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CDa0JJJp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so6451502a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724258114; x=1724862914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVNHONdIYUDlcb4HKJkyazbBTeiFuRtXuYOCfk7pptg=;
        b=CDa0JJJpn4B3HQJaTVGXN2FaTO+4PWUnRh7KhZumdAaA3viZxm7h+v3qQhiaLEeTKf
         r07QOW+38zyev2XR6aEFyvTflerkAB9kSUyTCrdPMpZAP3ZIppZ1cNyXDOWNV23LeDJ6
         nthr6Kdo1g2kZlvE9m37rZKqFb9dcyrjDkeTUh8kXTZCOWDfJliRLNU/G8dhWdtGh+eP
         SkDxuktqp7pzs22ZWvp+tIu78zECOqmTwz5ZUCwtblSNQksZpTMlm3Kugo8+ecB0kddm
         w1cdvgF1/PNxV2oOLHRT91/ZpHEFJyYvo7thtzENHd5gNlrVJl92CStKUK8h80MpQyM1
         Z7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258114; x=1724862914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVNHONdIYUDlcb4HKJkyazbBTeiFuRtXuYOCfk7pptg=;
        b=KbblxsW2ecRgrsxdwhmayOhkfmxYFqOiX8YnPz5tYDmXpe2hYNpQu242iz23z6MFOz
         DH0dC0llx4rT46alM2Xp5fN+e7LYnAUlGqdt01O7XGWsvNHW8AVzEbzy/BRhqMA0ucCG
         ol2XQrtEvmWMA5DcM8hyaeHsVGNOH1pMmz/7q/TsVPqzz/JJ6ITn2r716f3D3zo+gS37
         Tw5IAKnWXPoZKap32xwNK5I0EZcALqnYanTbYLSgmqCojN6lA2qpbojhInmMj7MOf/5Y
         GUdils3nOOPIy9pUWTThZ4kULubcFmZvu+nZNJ01I2NtjTZlHQarcpbCG3y4FrxGHPRX
         cHjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3w7pfchp694O8EA49/6++KdzgW2k3sCRvWFkK3ae489GInveG5VQcONJyY8P3A6cBpXclm0lM5uUizQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlcYLj+1/qrS94iBmpvmiNJR3LN/e3t7AqAO5VrL4ojM4fjOF
	sKIlVBfXHFV+Mc6JXhbPO+Z599rEGkMcH5pJLDcePBKNwe/4WIloot8knSW7h8oxSLgLHIncjaY
	l
X-Google-Smtp-Source: AGHT+IHFTiJo6jdkcWP6Ht7XAiB3ovuBe/ll8VqcDXEYzKPHdyBYXewj3953s9653M4Dc3FJWJQbwQ==
X-Received: by 2002:a17:906:f597:b0:a86:8166:1b0a with SMTP id a640c23a62f3a-a8681661d71mr128857966b.56.1724258114086;
        Wed, 21 Aug 2024 09:35:14 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8687b6f7e9sm21557866b.145.2024.08.21.09.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:35:12 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:35:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] cgroup: update some statememt about delegation
Message-ID: <2zbgupbyebbzrs62ssl2z7vx5lfkuoxrqems2m5ktvf2lezcb7@jlvcvjsyzsci>
References: <20240815131408.3151804-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7zagrrzjj3gbxhcu"
Content-Disposition: inline
In-Reply-To: <20240815131408.3151804-1-chenridong@huawei.com>


--7zagrrzjj3gbxhcu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 01:14:08PM GMT, Chen Ridong <chenridong@huawei.com>=
 wrote:
> The comment in cgroup_file_write is missing some interfaces, such as
> 'cgroup.threads'. All delegatable files are listed in
> '/sys/kernel/cgroup/delegate', so update the comment in cgroup_file_write.
> Besides, add a statement that files outside the namespace shouldn't be
> visible from inside the delegated namespace.
>=20
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 10 ++++++----
>  kernel/cgroup/cgroup.c                  |  2 +-
>  2 files changed, 7 insertions(+), 5 deletions(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--7zagrrzjj3gbxhcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZsYXPQAKCRAt3Wney77B
SfaFAP4qJ6MkZEudFO2/btfJkawZ7mPoC7NkXNuqd8vye85VtAD/UqX92jnGAHjj
qL/JoGfeZWBhvVV+xNclB7Zz2GhRHwk=
=QRw3
-----END PGP SIGNATURE-----

--7zagrrzjj3gbxhcu--

