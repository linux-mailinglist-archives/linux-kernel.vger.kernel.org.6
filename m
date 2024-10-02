Return-Path: <linux-kernel+bounces-347672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79698DA34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD25C282505
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661D1D173F;
	Wed,  2 Oct 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aCtbCeV/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007A1D0BA2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878463; cv=none; b=o2oB1w+tZkIfonqXHmwKnnRLnkW1vAWajgg6ceabWJdSE2sAAuLvL5N3KfVzk/z9tqzLoEmRWVGUgHVQOTOMoAWmZwtnCz73Pg+JpEm8P9KzV5MdFwPtulB82HsS66p+wWgYYxygm5GrJFcb8lU+Z/SZjwuvloDSNicFscKsoGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878463; c=relaxed/simple;
	bh=mhacHKOz64/1dXBv6XtaJtCJAEcD5EBZxuoBGkNWLo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGcyUntdmrkT7Zn0H5Fcv37aoLI4XADpdrMcSecafn58BUVoFOjF0NlbVwam6c4hNxtZEL236hfEdGvC9xSmCJQfp5w9lTuEBpWUh4nx0xhSZZroq6B5wLwx9rq7yeqDt7lAI7zgiLeBj++IKAKUG1yMaLdDJslCmXKwbp13zRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aCtbCeV/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso8103807a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727878459; x=1728483259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mhacHKOz64/1dXBv6XtaJtCJAEcD5EBZxuoBGkNWLo4=;
        b=aCtbCeV/vBajeSG1udbPm7GzRVT70VT+AMBpAprkqtQq3S9RmvQsn9rEQFy8EJZX0G
         V/BKpK3gFO/WB3BD5EHPAzetToVHlpnuj2vTv/HEB9KsqdACjuwCio+0pmtOzhppGupi
         GcKL/uv1v07RpqpCuZvTUNzQufaZnQkmOE6adHUsXLRPm8fJ7hkvagC8ssQLc+tX2oC9
         CD89Mxz2oNUa9y4LOtBALrON5zf42QONXc6d+BTg6WIyKoRR3tLC2K2V46S3QWhNIpZK
         vtIAjelVCb9mrhC6s4otW8ZGYHZk6AA9P0Xi1RLekg3THYnyWzbtNHEZM68tv/wcgI48
         +6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878459; x=1728483259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhacHKOz64/1dXBv6XtaJtCJAEcD5EBZxuoBGkNWLo4=;
        b=TIZ1Li0y6rIYkCqteqZwYxEBA2vfFUfif+2phtOToaL/Xy3APtbsaMW8NNY+ti126A
         pCht5Jz9GLbeH8igpHhfRl6No7u5sRZ9xKuXrcaCi55rAejTheco3lMQCQFjJvUO+k8z
         oE1DjzSs9gsnDUzsR0GrPDx4HH6/qu2RzbJmS8UzqKdEph+pOz8mg2FAWqWZNUjnqi+b
         HFL60qKTLz9FvMBBbclspLGKzuzNq3JUdK03OVM/ZHlMo+V4twEwIawwpAXfv1WmyI//
         8JqhV5VwfYfZVzkg9CD1vW7jxGDTG5ogA1iE6dTNnmFiZ+HhDIqvy9leZ+H+TyN5383G
         nZHA==
X-Forwarded-Encrypted: i=1; AJvYcCW7mXNTcDUNi37aCTcL1Yh70Njmx+bvZJ6gy/wLc8bCc7KLDQZ01vhiuxlWouxa9MKkIjxjhnvB+UXEonU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/YQPd92fYIA1n7zmIy3BHCCaCk+0z4nhycjH1XZ37zxQzlCuB
	oJmvJwQxlse4d6WKrlrcUNq02h9TOnwqfsSXRoqSnCFbh8BV/yfEdk75Ts1Vohc=
X-Google-Smtp-Source: AGHT+IEdrR7G7h6uB1xrGz3swJlK1C8Cejtc7bzmuqoNbPHSUZXPlJ5K14JEop3Q5PDbxwOaFgp3pQ==
X-Received: by 2002:a05:6402:5108:b0:5c7:2122:6ad with SMTP id 4fb4d7f45d1cf-5c8b1923812mr2405335a12.14.1727878458861;
        Wed, 02 Oct 2024 07:14:18 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88240a38asm7765846a12.22.2024.10.02.07.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:14:18 -0700 (PDT)
Date: Wed, 2 Oct 2024 16:14:17 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org, 
	Tom Chung <chiahsuan.chung@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: CVE-2024-46808: drm/amd/display: Add missing NULL pointer check
 within dpcd_extend_address_range
Message-ID: <miszqpmc73g7otccgv2hifv6uuckmq6vuxz6sxczfzkyvd5vhz@qu5ts3iwvzmw>
References: <2024092709-CVE-2024-46808-8886@gregkh>
 <khg5rxxfvmdfjze2tpdamrnhsry7jd4eptxfdkht5nnpjacpy3@rhlk7omy3ulc>
 <2024093053-womanly-groom-a59b@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iym432dtvepo7bhf"
Content-Disposition: inline
In-Reply-To: <2024093053-womanly-groom-a59b@gregkh>


--iym432dtvepo7bhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 09:09:18PM GMT, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> It's a good fix for those without that option enabled :)

Users with panic_on_warn=3D0 will see a warning but there'll be a NULL
pointer floating around. (That's not good for kernel code.) There is no
code flow change here. It's not a vulnerability fix.=20

There are other fixes that I've seen recently that at least change the
code flow:

- CVE-2024-46805: drm/amdgpu: fix the waring dereferencing hive
- CVE-2024-46811: kernel: drm/amd/display: Fix index may exceed array range=
 within fpu_update_bw_bounding_box=20
- CVE-2024-46812: kernel: drm/amd/display: Skip inactive planes within Mode=
SupportAndSystemConfiguration

(These are not vulnerability fixes for panic_on_warn=3D1 though.)

So these CVE numbers point out potential vulnerabilities but the
associated patches don't fix them (generally).

> Agreed, it could be fixed better.

Let me Cc also Alex (last S-O-B on them) to be aware of that.

I think I can't do more at the moment.

Regards,
Michal

--iym432dtvepo7bhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZv1VNgAKCRAt3Wney77B
SZwNAP0fbzm2hIt90TZOVbgsT7KayP6/OHGdIshV7kzMpfeoggEA5+Oq+wibBHqW
/aSe6Que7102qmjf4EKbz446tFQnoQA=
=Gmvm
-----END PGP SIGNATURE-----

--iym432dtvepo7bhf--

