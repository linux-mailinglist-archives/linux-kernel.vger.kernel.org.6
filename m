Return-Path: <linux-kernel+bounces-431533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4389E3F4A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65238B2C7D2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE461ADFE3;
	Wed,  4 Dec 2024 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NRNvUt7H"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DB126C10
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327138; cv=none; b=ZNNQ5VuTki1vSLv4djHLbcZ2WHkobJfk/AgHW2aHyEYWMCRpp+N6ESizcZYzM8ob1nB9u7qeTgAVmz5k9CFDK1GnnrjV0tIObvLJXLM5QEu8w1tk3rh9H4g2xzCKqu0MaRr43v9Ro2VOpG/380l2QTcx+nMDYkXDRKEQe1lcEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327138; c=relaxed/simple;
	bh=zsW3P2k6T49Ey7msdJFqq/bskLvtp3R1ODCsR+DajSk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mt/3BBwO2zlMcokGfbEzWhRnXlmCR2EozzpRF4MNXIlg5J1Sskoe9w0S752UeY+NDa5MQ4UBhzO3OpF1d/64t/2JqaepPpRDt1gIPy+cw3TW3wffAIvxPxuHZwC+c86Zq5Ldjp1pGTp7x+3CO8ohjzll9IE8MP3GbRr3BNfaDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NRNvUt7H; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1733327128; x=1733586328;
	bh=zsW3P2k6T49Ey7msdJFqq/bskLvtp3R1ODCsR+DajSk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NRNvUt7HhECMIl8yQpiHpQJ56mc1E5xg0aO3r2yXYdr5NqWkSLwnoMxa98HmOpN7p
	 kKV8D2fR0w+VLay45drsoikN9vp2ESNP4OKd5kjr+afHiAymDmWsW659qAPCtbUw5/
	 Ja/uK1u8HfR39su4/jw01Pk+45uBLnmy0SrMdHqChjfoj4xc6H4QNcJIKdHS4/l/Gl
	 N3v7Q1588l2b2T+3kzhxe9mRbeFrzOG96aMCmSpr+zbws6MNFeLu7J/PhP4V/5bPv1
	 pcMb1fOO1igHx0oFyE8F+ulJFJMo0YKdW1m94SFB6tXUO5KS9K0HiRzsg7kVjszJOs
	 Tggsc08QUktQw==
Date: Wed, 04 Dec 2024 15:45:21 +0000
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: skhan@linuxfoundation.org, Piotr Zalewski <pZ010001011111@proton.me>, Daniel Stone <daniel@fooishbar.org>, Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH v7] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <9Rp0NJW2QG5qDduowVaialZWN6xTe9KJFciu7Q2LERJZQXsUgFvMGXfcFaNznIEJEBpZeOdZPuL4fxOEFduaSJLuQJ3cIvN-fx2lEzYSBKE=@proton.me>
In-Reply-To: <20241101185545.559090-3-pZ010001011111@proton.me>
References: <20241101185545.559090-3-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 6afc641a1cddc26bcfae7f62410b05a81c0b4b8c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I just noticed that after coming out of suspend gamma LUT is lost and must
be rewritten by userspace.

So I guess it will be needed to save LUT to a buffer and rewrite it after
going out of suspend during modeset?

I checked the patch isn't yet in the "official" linux-next.

Regards, Piotr Zalewski

