Return-Path: <linux-kernel+bounces-394828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591DF9BB490
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FD81F2241A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3541B4F15;
	Mon,  4 Nov 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="CRaAeQ4K"
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D991B21BB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722852; cv=none; b=YxIMujvENRtP1A6T0F7X0bHby4z+67FD8Cj5ceX29pk6payjkdeZJBR40ZO9fDD6zvTh7VLvEeWRY/eSnAPh7Ep2lTdgbIISSnOeQ1Xi6BVpeyPAW29yPTZveixqlIAUShgSRBkHWUbJLwz78VJ9NP3otfNua14zb7N5TI9UrDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722852; c=relaxed/simple;
	bh=s9gQN2SpE6AzjNfjKKCELsz24974cBjufKf7Ow0Xbl4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=ql3LQf95z43DeePeHAyQFglzF/qBFeCGWEbu0AMkFKvYFE13RA0xjfd0r9CFsqdLoZdjmA35Aa5QzvhAFOIbP1VlKftNuHrwBt3FuYzye5cqQ+ukXoGIH/PB4AKc8Xe3R5cKfnM3R6q1oyazjKJN2+sf9EY7IoC/ilIruIWTtls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=CRaAeQ4K; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id C51BF6006BA4;
	Mon,  4 Nov 2024 12:11:54 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id oDOtJgU_cQon; Mon,  4 Nov 2024 12:11:52 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 245656006BAB;
	Mon,  4 Nov 2024 12:11:52 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1730722312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9gQN2SpE6AzjNfjKKCELsz24974cBjufKf7Ow0Xbl4=;
	b=CRaAeQ4KZzRUY8BeMjb1SuPhI7NGFOkleUW9HfEXTtEUqwl9TftuW8ESmPhugnWK9mocym
	3YhxL/I+kzEe8qPZgsyEwKL9AiwMJRL+y3l3rsAb33AW5PBU/oyTP6rvRHydC4MwqBpfFr
	pyszNkZa1URg/cGgbVAFskYTwlR+jMA=
Received: from localhost (unknown [165.225.92.235])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id A029036012B;
	Mon,  4 Nov 2024 12:11:50 +0000 (WET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Nov 2024 12:11:44 +0000
Message-Id: <D5DDUQJOZ4HW.1XDOASECJR714@tecnico.ulisboa.pt>
Subject: Re: [REGRESSION] GM20B pmu timeout
From: "Diogo Ivo" <diogo.ivo@tecnico.ulisboa.pt>
To: "Linux regressions mailing list" <regressions@lists.linux.dev>,
 <kherbst@redhat.com>, <lyude@redhat.com>, <dakr@redhat.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <bskeggs@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241010133253.30311-1-diogo.ivo@tecnico.ulisboa.pt>
 <041511ee-4556-422a-8604-30b5e0dfd21c@leemhuis.info>
In-Reply-To: <041511ee-4556-422a-8604-30b5e0dfd21c@leemhuis.info>

Hello,

On Tue Oct 15, 2024 at 7:13 PM WEST, Linux regression tracking (Thorsten Le=
emhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
>
> On 10.10.24 15:32, Diogo Ivo wrote:
> >=20
> > Somewhere between 6.11-rc4 and 6.11-rc5 the following error message is =
displayed
> > when trying to initialize a nvc0_screen on the Tegra X1's GM20B:
> >=20
> > [ 34.431210] nouveau 57000000.gpu: pmu:hpq: timeout waiting for queue r=
eady
> > [ 34.438145] nouveau 57000000.gpu: gr: init failed, -110
> > nvc0_screen_create:1075 - Error allocating PGRAPH context for M2MF: -11=
0
> > failed to create GPU screen
>
> Thx for the report. Hmmm. No reply so far. :-/
>
> Diogo, maybe report this here as well:
> https://gitlab.freedesktop.org/drm/nouveau/-/issues/
>
> Afterwards drop a link to the ticket here. Reporting nouveau issues via
> email should work, but maybe you have more luck there.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

Gentle ping on this topic.

Thanks,
Diogo

