Return-Path: <linux-kernel+bounces-321977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB9697224B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33497B23412
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9605189B84;
	Mon,  9 Sep 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KjRqqasi"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F061189531
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908600; cv=none; b=bB+alUs0UTIg/REbai52W4xr4Prh91UJGY32JWw4CUmoozWARWZMUS2PJ1+Nj5yOLd1Tlq4Kh+BZHW1Qz274pXojEQkDENKvX1/WxVe3iAnE67/MNqM6lIhRNj4IMsXssQYXlA2AcltqDVKS4NPNWWpiRlmyGBd8f8umVD4IDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908600; c=relaxed/simple;
	bh=PGzBn89u7J8fnt3Y443sAUXXMQDx0nR/A2rC8nPk9Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXlVptuKIe9I+bp0TDsbm/T8yHeC0/ymRMgnaEpq3PhU9mzDHaEv9LOz/dol3HCJOVQVsoHu6UEzN6ORnfVOASEhkZkD6itYumVPdq+l4nM4+jawlXWi1Evm+24zUrLbomUcnNo7A0awcF2lo9489gZCK0K7WBsj/PWWssuccXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KjRqqasi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374bfc395a5so2774541f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725908597; x=1726513397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGzBn89u7J8fnt3Y443sAUXXMQDx0nR/A2rC8nPk9Sw=;
        b=KjRqqasiAZMa/wOQu6mORUQqJtYoS28qFZYNdDUEawk3xynAVDAh+5MC6z8XpeItQ8
         2f9Hl3T4u95GpXRMf6QnyicFrBCP+ov/lXOAMx/rcm/7+5Nw11Qm6eIPe2iHql134NVw
         v1HTBurTIoCkC+l9IxBvUdRpAu1RE9nJvqGum8c9tx7CZJkxBjI3X4+igiX/TzngOv+c
         asbnqi7OGEVz3ce+vzOAUEn5xXFf6Lg7m4DXbU8qZk5uWwGnDK8RHZkSICIb/murFpmv
         LTlTV8w0HZLBkKZSlVG58IKxrf5vBOA31XUlMuEoPiDvNY/0svBB/JnFTjzGKGZEOkkh
         dAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725908597; x=1726513397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGzBn89u7J8fnt3Y443sAUXXMQDx0nR/A2rC8nPk9Sw=;
        b=j5KC2LauFcJTxVIbcQpt05ytZjTVSb4sS705AHOe5kLAs4GaoziNDy170XlZ6vkjQf
         Rj5oEUYb3COcxBcxna16KimmW0DeQLBJXrl80ckLeMzcx9R3SrnOMX+IbXsHgOrOGzly
         76bq1j3kaSfa1rUCw8N6QF9XMBeW8enCyRDcrqP4zx7JPvM0zzl5y+dXQ+JvKWVCoTM2
         /RYSfWPjO4OHqTgCd9KpwotRz6vY8r9BT/9VPhUHDTop2IB0ZgBYsVMbrz190TeIRdlP
         /a9BL5RrMg6EVAVMDd4FPu0dEOZKpv4kU+tS0ii1Duava2yH7vV0ZrC4/U3yDEtjDLJe
         IVMg==
X-Forwarded-Encrypted: i=1; AJvYcCUD1q5milYT9SwN/w2OQCqRtFWknmG2X7FKyWY0gydp0Cbnh8DzGX1+dZG/+baPSMQ99n9ujR228NxogXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuvznvaJWLluq+V++MUGMfb67QHEBj+fZexyMFdVXLhaUyUh15
	7MhH1ZZw4R3iSi58PvoC4Cd/kxwisaVtjSKewAOwCaLH0u07qER0vIHXYOFLOI8=
X-Google-Smtp-Source: AGHT+IFgDuNms106IsvN4bAkuQCSTPRrsurnBAbeIx3Io5N8P59fF8F4Fy8vtiPNhfwOEGgrANDPBQ==
X-Received: by 2002:adf:ee8d:0:b0:36b:5d86:d885 with SMTP id ffacd0b85a97d-378a8a83a66mr306475f8f.24.1725908596752;
        Mon, 09 Sep 2024 12:03:16 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca0600651sm118226135e9.32.2024.09.09.12.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 12:03:16 -0700 (PDT)
Date: Mon, 9 Sep 2024 21:03:14 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, adityakali@google.com, sergeh@kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, chenridong@huaweicloud.com
Subject: Re: [PATCH v1 -next 3/3] cgroup/freezer: Add freeze selftest
Message-ID: <woqtbusaxdxgolhjylrvsdnmlspwg4tlzgynhse3mgqva2cepv@yzminbmkfyvm>
References: <20240905134130.1176443-1-chenridong@huawei.com>
 <20240905134130.1176443-4-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jciukgq53d57kpvt"
Content-Disposition: inline
In-Reply-To: <20240905134130.1176443-4-chenridong@huawei.com>


--jciukgq53d57kpvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 01:41:30PM GMT, Chen Ridong <chenridong@huawei.com> wrote:
> Add selftest to test cgroup.freeze and check cgroup.events state.

There is already tools/testing/selftests/cgroup/test_freezer.c
Would you consider adding this as a new test for hierarchies there?
So that all freezer tests can be run at once and maintained in same style?

(There are already some creation/removal/event helpers so it shouldn't
be more difficult than the bash code.)

Thanks,
Michal


--jciukgq53d57kpvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZt9GcAAKCRAt3Wney77B
SRHUAP4jSQ6yAGBfCoHmzxy60HCPZ1MNP8j2Q+NUb+tmRlH4KQEA3OHraHpihHSL
1GCz1Ct+VE0X5O9berdlWBEtGuRMcwQ=
=jy/Y
-----END PGP SIGNATURE-----

--jciukgq53d57kpvt--

