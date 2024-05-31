Return-Path: <linux-kernel+bounces-196818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C48D621B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8FA1C23C00
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F91136665;
	Fri, 31 May 2024 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="FzJMj/lB"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE2156256;
	Fri, 31 May 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159645; cv=none; b=d+wDDs+Fl8+c6aMuaD1jdU/DcIRXQVPo6KBmUzMpADpAnjuOwsMLF9Woe4e2aoGiEL3dJ5Mf0zcjNkCWD35H/0pac+qlPx26CbzSHhNIn4PCimxf1+V/sm5FqsGhBKeOE0H3TWwvGV8342pdXdlP9VDVzEjTfBXLOceF/8OixeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159645; c=relaxed/simple;
	bh=SBf8+jOuywRaezyxYyKLbzW9z3O7DhhdigY77jay4Wo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ho7PA9rPcHggINf2cI6KT+NGF4S5Ca64IlL9Asv5PTyoOgk19omw7m9nC8+N15j6Ipi95i0bCIq2NDl1CJ+B4X0tVoSSj6Aqbwly4RTontwfhqKdQvtHU9ZNS4qytrMb6rbquKBWTj40VuZYy7dgrrQKrWyVqk7iIrmFTFh+QGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=FzJMj/lB; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E16039C096E;
	Fri, 31 May 2024 08:47:22 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id RoyjbGfD5dWH; Fri, 31 May 2024 08:47:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5C8FF9C57BB;
	Fri, 31 May 2024 08:47:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5C8FF9C57BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717159642; bh=EgSdYLrxxil3DM2ZfEl9AZaBLurlfnS7atm+wMgVU5M=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=FzJMj/lBQgsaylMZozyQI2kIuLdeUCa2HURR7HPzGXXXZVlJTOgmNAMKseJ2KzE0e
	 j+LJ0vqdOFwvAfgJvmAh6/1qIre+43sFCrAVETVmoS971gpKsOryyb3kPVx9pr5xKI
	 5lQnazBd19NEpCjTdgkIF5rU6fAUAGcEa5ISXITdEkGEFregawm7Sto3AwQE0W4wjk
	 XMmxUw46cr1Ec/RiCHKwDDSHhIJ+YhSIInROB0kSDCCCbCfM+5/txtbKhbo1wFuM12
	 OmcgGSObwusX8pOV4FXRcKXLsb+He224rFMi976Vn2s+tQiLILQIK5h3Ia3xOO8TiG
	 7/7/A26s54wKw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 30jGWh-XiV8C; Fri, 31 May 2024 08:47:22 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2911D9C096E;
	Fri, 31 May 2024 08:47:22 -0400 (EDT)
Date: Fri, 31 May 2024 08:47:22 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	shengjiu wang <shengjiu.wang@gmail.com>, 
	Xiubo Lee <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	alsa-devel <alsa-devel@alsa-project.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <477405270.701257.1717159642136.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <aa212906-6579-4884-82b5-6d0eb8b0b7a0@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com> <20240515135411.343333-9-elinor.montmasson@savoirfairelinux.com> <20d8eb96-6346-4341-95ee-74729001c01a@sirena.org.uk> <1607626951.349332.1715936738428.JavaMail.zimbra@savoirfairelinux.com> <aa212906-6579-4884-82b5-6d0eb8b0b7a0@sirena.org.uk>
Subject: Re: [PATCHv4 8/9] ASoC: fsl-asoc-card: add DT property
 "cpu-system-clock-direction-out"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112 (Linux)/8.8.15_GA_4581)
Thread-Topic: ASoC: fsl-asoc-card: add DT property "cpu-system-clock-direction-out"
Thread-Index: fy+ROOUy4SJ9oY7KJCX4xYYvCNq6Yw==

From: "Mark Brown" <broonie@kernel.org>
Sent: Friday, 17 May, 2024 13:06:03
> On Fri, May 17, 2024 at 05:05:38AM -0400, Elinor Montmasson wrote:
> 
>> This new compatible is intended to be used when there is no codec
>> device/driver. There is technically no codec device/driver for which
>> the clock input can be set.
> 
> This is obviously not true, there clearly is a driver.
> 
>> Is it a bad idea to allow setting the cpu sysclk direction only ?
>> Should the compatible be limited to use-cases where the cpu sysclk
>> direction cannot be set by the machine driver ?
> 
> When I said "this should use the clock bindings" I meant that we should
> use the clock bindings for configuration here.

As far I as know, it's not possible to set the direction with
the clock bindings, but maybe there is and I missed something ?

