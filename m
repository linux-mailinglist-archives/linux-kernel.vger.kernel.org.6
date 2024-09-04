Return-Path: <linux-kernel+bounces-315127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8D96BE4E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413CA286ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6DA1DAC4D;
	Wed,  4 Sep 2024 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DtgkYAA3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4081EBFEF;
	Wed,  4 Sep 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456087; cv=none; b=QtiKPASGc//kpvjMYyeb9uJ3Q4Aa9cz76LgFQm+GzQFnCMTDPtwNDS9ZzDTHPKTS5kfQoiKCMGiLLQ+YB+wsTVmuJ2VG6d1Entz2shM91bd5S6gHJxa9PcTNB5F0hQiB4ho9KaBcIsysa8ORcDXxHsq1kqTeY0ZJja9r14Y/QsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456087; c=relaxed/simple;
	bh=oEeQNltNgjxKhow6HcJUXN0SYC1LORzvBksc0cWLbyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqOiZV7OemlPsMhYIy4XQaeAGYJZTroCUVJEWbJIE/VoSe/rH3boUGMnvP0xgHgV4c0G1tmbJqziYoIK02RlyBH5DRz7WyTOnOHn0nbVOO09xM5wiPwCTapIxD3ZzyUyyMuzOBotftfDROzZcpAM8WzNIF4yaAyJ0w7obn2S6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DtgkYAA3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7482740E0198;
	Wed,  4 Sep 2024 13:21:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SiFbzFeFtBJU; Wed,  4 Sep 2024 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725456077; bh=WRZcIeYa6jCDNU/B+Vyy4I0mAe3Ini8FS1LRPSG2p/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtgkYAA350xmnkzA4ypnuXPtsCNOQcme/hSsAcrZZD9yK6Nnv65RN0A7gxFXIf1Ej
	 ZyKZnxaGY5EUHg0hqWnImzVt5ISWtdgYlyUZMwDjprLU1IfApaSJZKvir6RlW7GIP7
	 KL4Al1lO/3fEcI7JkYj+rhsPX70S3eZ4VTB3zKRix6qeXBuWt9uFPdY8zVju/heCDV
	 rS5G+Gw/kcO4vKUjivtf2SDFh/+qDSiOErk71JkrvGelXJZz2lNw9xhol/6oCY+uQQ
	 e42L0eRv7e0ta7US7nNo4/U4mGXqqw7ln0wvAtUh8X/Hbkv3i+NxW4kVaHj/H5//Kc
	 EhSQJCTCUFMizzEcWsB1QHKKFJK5+nLTT624ZqZ18P9bRcYa5MSUOicIKGaESxg7ir
	 jS2wm1edgQ/ES51noKu8sRpe+mjirgQ96SV+C5ZGHjTs0Zax3vl00dARwvdegJndGm
	 lNiMIXMl1Dme3gTX8iHsBRO0DtpIutAn14MZTlX0KkI9yiEzvlDr/w0o1xnjROkSaj
	 vGQ1uhu2c9DSHOtYklkRxcWap5qgThZLOXS1P1eQpRtpeJHgu2EySD55RhypQFUQpH
	 39Ijy5+OJTtKqrPWldlG7pyJE21OsdGyIq4QpVzWqRgtR6nuIwwfnCE5vd4Pby9Yl+
	 QrUlT72oOMwCmH8BHW4KNn6w=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 664BB40E0185;
	Wed,  4 Sep 2024 13:21:09 +0000 (UTC)
Date: Wed, 4 Sep 2024 15:21:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Gross <mgross@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-geode@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/geode: switch GPIO buttons and LEDs to
 software properties
Message-ID: <20240904132104.GDZthewNjCZ4iLgEoD@fat_crate.local>
References: <ZsV6MNS_tUPPSffJ@google.com>
 <a2366dcc-908e-41e9-875e-529610682dc1@redhat.com>
 <595fe328-b226-4db5-a424-bf07ad1890b4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <595fe328-b226-4db5-a424-bf07ad1890b4@redhat.com>

On Wed, Sep 04, 2024 at 03:02:17PM +0200, Hans de Goede wrote:
> Or I can merge it through platform-drivers-x86.git/for-next
> with an ack from one of the x86 maintainers.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

