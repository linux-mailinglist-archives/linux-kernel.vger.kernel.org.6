Return-Path: <linux-kernel+bounces-241412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F113927B2D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CEB283D4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E39A1B29C0;
	Thu,  4 Jul 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ux68MPp6"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CAB1AE859
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720110896; cv=none; b=eh0AzIY5HywzCUuNqYdtDcZBiZyk1YQyaKsOwaY/kRhrayQmcigNTDyCBh47UbPfkR0/g+lbSSVCyIaTZues/effqEQU/vQcb318IfQSlj6aWv+vgYN9BOHpBL8XiM0/3CyweFGymB7dVZr9y59LUUzp9kwi2bx2VYaNvbBa82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720110896; c=relaxed/simple;
	bh=9v65Sv3yo11Kw53F/T4eQd+faLb6N3scflAh/xOOfRI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rv5CaZQhGZtAA4P4/F7sBf3ht4JaGx9KPNMc+Vm93eYK0447vZ2fo/TiWsOCfXQlO8CtnK/noTyw97dm6Dwk2XgIS13O9kzSUi7o2c+opvRie8rBX72BCVpDWfqKxfKjJ1wyQi5vIL1Z5TSfFNkp3KHyFvtvTHsymPjXvlyAnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ux68MPp6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VsVGu7SaO/39voxPm+AHRwDd0yVTAjmoCN49SoXRhfA=; b=Ux68MPp6ndC6eIi6JoA4rlHnds
	fO1cOdiz8D7Vz/aSGORepKmpGuuDi1sHMd8QNAkGfrj1KtgTyFqXz3I5FmCXVaxeZlZtjmGcuMG9V
	n3vgfcqSJjLDr8eFz/vJRi8g0dHaKgMPzxAHQMm8aGsLcalDrqHXHk6DdeHPYc02YBhKHDp1A3EHi
	KjEojp7O55JD01/fg3kMFp560wmO3dhn0wAZiXfEPL3b4sXRT4BBWe/fhcPNJauO/37TpnG86CSfD
	AUBkqZLJgNM9cpNHMObJBBI1I06oY9iS/cSVweir3170dgPUdgObierpkpLhfrja9PblRJvaq8FUh
	5mNhMzaQ==;
Received: from [191.19.134.16] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sPPPy-00BAK7-4c; Thu, 04 Jul 2024 18:34:46 +0200
Message-ID: <f59f5b44-0fa7-4229-b060-3a6ffbc2b6c2@igalia.com>
Date: Thu, 4 Jul 2024 13:34:39 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Graphics & DRM MC at LPC 2024
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
To: dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Daniel Stone <daniel@fooishbar.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Robert Foss <rfoss@redhat.com>,
 Maxime Ripard <mripard@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
References: <92bacfe3-efac-4615-9d30-a6215f6bba29@igalia.com>
Content-Language: en-US
In-Reply-To: <92bacfe3-efac-4615-9d30-a6215f6bba29@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 13/05/2024 13:46, André Almeida escreveu:
> The Graphics and DRM Microconference was accepted for Linux Plumbers 
> 2024! Please, submit your proposal in the following page:
> 
>      https://lpc.events/event/18/abstracts/
> 
> Remember to select "Graphics & DRM MC" in the Track field. The deadline 
> for submissions is Sunday 30th June. The accepted proposals will be 
> listed here:
> 

The deadline was extended till July 15th :)

>      https://lpc.events/event/18/contributions/1664/
> 
> LPC 2024 will happen in Vienna, Austria, on September 18-20:
> 
>      https://lpc.events/event/18/
> 
> Thanks!

