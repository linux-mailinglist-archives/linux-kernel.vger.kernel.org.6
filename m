Return-Path: <linux-kernel+bounces-423785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B739DAC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81ECF165DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53DD201025;
	Wed, 27 Nov 2024 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KcRZjcnK"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E35201019
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729083; cv=none; b=FcEMH3yUpK3bGXFpAuBGymc2lJ1gohPteBBWTswyA7j5QUGmq+7GHarPcighmugBU9MJXe26UOM0EjX0NYL9lh2z/d81KHjA5x/bxco9jfcwwdnLnzk7hWFvuNT+Zt0xy9ruNDP/UEuGNVpZ7w1vtkYKftg24OQcHXu777I6luI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729083; c=relaxed/simple;
	bh=cArXVGgSb43D25ZN5wQGzXUB9KuELuujUrOe5iM6jSY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vs00l1EyVMPR/6/7GYclbl1+ymzv8QnZKw7dtfCOIZIg9vhfhQwEYM4rEtEMsZ6vjku1aSTt6FU/JCcsYTPyOj1hp/WhW3YxfwscnGujxy4tTUu3CE7CGQl0DzGirNle0lXwllwz6HT/GWzvmKArQaVHrnJQq3qB90EsX1aBbsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KcRZjcnK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-432d86a3085so64209615e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732729079; x=1733333879; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cArXVGgSb43D25ZN5wQGzXUB9KuELuujUrOe5iM6jSY=;
        b=KcRZjcnKxB8/H1cssGKCeb2qMyziix7hewCIaMEECaqQE1hHG95zKFtkaEaHolbS0Y
         Tok6kgVgs3lo5dSYzUpXUPm0IEzCDqL12z1di+L8g5Of9i3ZdJ+Ihvp97BvjVzsjZw2O
         x3bKSDOnqucUTeHgDvzsaaTEfjLuh8wiVTWnenFkf6rWUDxZxeZUE7LeX89uPrfdZOSF
         bb1p8PbO+bngNiIDpVXHkhd0Gh544Xj7dibntH4t1XfXuZFVYAa2BC+OqRO/c1UWFxxi
         cNivGqEnwJkI3usW8tOVm2igjnnH0lrN0ZjwDtI5Wrbkr8LI7MymVN1dUt75aN2MyB4f
         ziNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732729079; x=1733333879;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cArXVGgSb43D25ZN5wQGzXUB9KuELuujUrOe5iM6jSY=;
        b=vmgYxvvYFAEnuenb6g7Xxf7j7zmsHrUtGgKxiq/OU9bnXGrjeDKvFSl4bIIVE73uUo
         EuFLRuJhlrpYrpdYMUqlHBV0UKihk+cTG+cdjcKizorhUHfOfyNrTmbbA9rkuZAegeiG
         M27tzNZBzVfAbjlAzd8IWJTqGg5Jfodg7mipdsOfbjGDPWV9Utu4nrwf/9miTuQ5ys/a
         11Nrx3opFbnsMjeuK5Khby+x1V2iV+UBLMvbveD+QQhYqm23/q9gu+I11obT6Llta5ag
         kt0/fdP6XfMNfT1MOzVx/xiO8uNMwAPa14HKvtEItwcQW8N2w5lnSQa3XmsLeBDMwbt6
         xSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU41QxCEXTagnTSz5XxxoWDTEkwF/k8usmXlLAZ1dmA3yPF6iO1MGMwiGKhn0pZOtdAdCGA39dlQ7/6DS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk3wjGqGQrgfLbRsBk88M03rQgUKW2e7Y1YnHCiy8bnIYdo0rN
	dCuuWrlZtCEYSoCq5fHNdtjxk8Gr358PxPVcbi4M6qpbOp0S5MaKMHU+i7Y4KE6fQ2NqM8bif2g
	z
X-Gm-Gg: ASbGncu0Ezn2VXoAeihi/cqX9EKxPQXzXX0AhpYmx9zIM9arzCsXZtnGpDJFI7Wbnc5
	9S4uYHi75WCFbYNRJ/5M3/BN4BTPdF/fVcv45etetLRnSG91x7ijPHWfBYmQVWCCfLFFLmcC1vk
	XASo5dSRNcJ7R1bJjjIoNQXp3ZRCnXay0Pu0abCfLeLRgBHPnMJN3mbu8Vqg37VNhUBSKTd1TmU
	yCyEHGZvdE2pQH4W3rR5wXUnR4rqLESliZoKB706M4o/BFxHJo1
X-Google-Smtp-Source: AGHT+IFG8TZTVZztNakQLyKUejpKBPBM7KkC42i5M1aMPoK2U38XeX9JcaFxwNg3JgwvNor2F2VD8w==
X-Received: by 2002:a05:600c:1d8d:b0:426:6edf:6597 with SMTP id 5b1f17b1804b1-434a9dd02a5mr33427445e9.19.1732729079560;
        Wed, 27 Nov 2024 09:37:59 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fd04ec7sm16927253f8f.110.2024.11.27.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 09:37:59 -0800 (PST)
Date: Wed, 27 Nov 2024 18:37:57 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-53054: cgroup/bpf: use a dedicated workqueue for cgroup
 bpf destruction
Message-ID: <gl75dywfjz5qrxsc6k47445n5a3abwyeq4gssntt4ftl7ev5jj@zz2jshiohpsr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lonma34uzgamw4yc"
Content-Disposition: inline


--lonma34uzgamw4yc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Sun, Sep 16, 2001 at 10:00:00PM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This issue can be reproduced by the following pressuse test:
> 1. A large number of cpuset cgroups are deleted.
> 2. Set cpu on and off repeatly.
> 3. Set watchdog_thresh repeatly.

The lockup is triggered in this very specific stress testing scenario.
CPU offlining (write holding of cpu_hotplug_lock) is necessary to cause
_this_ lockup. Both 2 and 3 are privileged operations (in a tight loop
to hit the window).

I don't think this qualifies as vulnerability.

Michal

--lonma34uzgamw4yc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ0dY4wAKCRAt3Wney77B
SS31AQDjoiBZhuyyTPyL8OPE4p491wGJKKiolctyfzcAB7wZYwEAid9yLNgsoi/u
zj+pkFyl2tuTC4WF6ufh5NgTII+zSQU=
=/iJn
-----END PGP SIGNATURE-----

--lonma34uzgamw4yc--

