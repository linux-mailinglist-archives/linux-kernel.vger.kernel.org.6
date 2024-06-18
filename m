Return-Path: <linux-kernel+bounces-219815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3714390D810
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C071C2343E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF674D8A2;
	Tue, 18 Jun 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mP/j08bN"
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0D4D5BF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726598; cv=none; b=EEX8N0IjQZBPTTceE1j6mbduetSVU2XASDVzbX9u3DRO0ThkkFJRE1Wd8nnhruF7udvgsoP/70GkffWNcnlELk0tMzQiXvVf4P9Ae7WjKIGDAWiyBjNFL7VAs7GfeYE4Ov7ngqpZ+hmKhpgeHy7HATTOcNM/NwNHrUnranSetZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726598; c=relaxed/simple;
	bh=AMvWUm4tzopW0r1CiWvxsTRKcURLnL11Z/gRFn5XZu8=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=fVL0K5NbXL2VmCyMjYykNKzSm5pVQDb7HGmpnCUU7Cq5FSD5PgytYQGNXcay+J+zh22YD5qvG5loGOPFmP3+xvTarKs0h/uHjvP46ySaqnKFls0Ht+C2jnY+xnKXliKlgwCcncgA4/uMBwF0KzoVLt9p0R7kXAMoU3hCr/m4/Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mP/j08bN; arc=none smtp.client-ip=203.205.251.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718726588; bh=AMvWUm4tzopW0r1CiWvxsTRKcURLnL11Z/gRFn5XZu8=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=mP/j08bNuxvsEcDJIj498kV0+3SrcVSjCt4TW4rp8B7XDHoB/OMB99RgfswgrAYB4
	 rNcTwrutWwVWq4G+D01bQRNOr8020UgtTz7hEaK046K/VaE+3tBzcabROkvAUERPko
	 zfvBaJWOF2zynYeUxcpLA8uOcgYtS31Wj5DTyGWo=
Received: from smtpclient.apple ([2408:8207:18a1:9700:f590:27c2:9473:13fc])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id E3A87EE8; Tue, 18 Jun 2024 23:56:58 +0800
X-QQ-mid: xmsmtpt1718726218tkou9y081
Message-ID: <tencent_B732B857317E21CB8D887CBF8228DAA78E08@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtun29cR78YyvCldGWW4ORDPE2nhUZ4dPw9OH0w+YMKLQLYiVVW0
	 WMeLMEt+kNIeANwcDvF4NVvveyzIdn7OaZW2s7MgVqvvkQxPQFJN9LgHeSb52Flb8+qENbzUsOWA
	 MYewBlAn67zPEhjUe1uF3995Jj2j6PpYVM5P9Yo+AjK5zX+jv7ZNGKPfuSq6dhavpoLGcTTQUItn
	 bRPIW/EeEPXoitwnI1js2LnYCs1TanM3cpFhLq2SpA8PJ0+ewbeoiUiSqxXOZllg82QHRxB+I27c
	 /LLTzfTa8OtelP0wi8gxz33PUskXkQ0Aln7Ge1H4Rb9ptUlRGzur5ieY60w8TjsTZrcgO2De6kN2
	 z0wv3HU2LNI0wYbJfN5jIgnWWUvyAaR0+qE3/cnyPvXGZ19EbAz/EaluKxi0WKb/zNW2feya9z+M
	 3A0FAXz3dabv0yRYdF7QF+qQqs4uijVjvJIGKX/wLZlywb4tOVkLIODbYEkSF8j0KO0dRfiGW24h
	 izrLwDmcrxwNFryezHI++YWWUyuF3YVhsgI6LZYwnUJ3m+qPBRZsJipDMkHK4rW3APHlHPFFI11H
	 m3I/5SunxLBy6BluLpQ9veSYvsgfNn8TZx1SIQA/2/4TtohTHGQRIr/6J3dAjInVTbN1v6RMHyk6
	 IAVp7IRSmBgqISIURD1wrS2Pz2hF7SJH6h5p5XsTz02tRgkksi67g4LVsAJB7/R59Zmjw6qZC9t+
	 TnN83QxId8cysy3+X/9depY6maX9meNMAoi69RMjtJQTD9ShmI/ghzBnlMHHgEwv7nmbTovLvn4V
	 dW7AsUrqhK+e3ACpMs8OHizTOxsVRcbdeRA+KCayrHg/MS+9sn6WI6raf5iIcYI4zCH0TL0a77mj
	 oFb0icoW2nRJzcVp8MBbNDp2NJispfkaD8rfFQQrEc5nYGtqO5x74mb5zOobHM/VnABHZCOF8oC1
	 RsR/lRtjrZV3GaqsVYvK5gzZsc+vi0v15qB4JRBaTP0RcrLUQtF5WvHStZQ8Do
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1] drivers/perf: apple_m1: add known PMU events
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <86bk3yjqkn.wl-maz@kernel.org>
Date: Tue, 18 Jun 2024 23:56:48 +0800
Cc: linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Janne Grunau <j@jannau.net>,
 Hector Martin <marcan@marcan.st>,
 Asahi Lina <lina@asahilina.net>,
 asahi@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <9008BD2B-258B-4607-8894-FFC1D99E3C33@cyyself.name>
References: <tencent_D6474BDCDD18AA90A0C656BE704136ED2807@qq.com>
 <86bk3yjqkn.wl-maz@kernel.org>
To: Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jun 18, 2024, at 22:03, Marc Zyngier <maz@kernel.org> wrote:
>=20
> On Tue, 18 Jun 2024 14:49:48 +0100,
> Yangyu Chen <cyy@cyyself.name> wrote:
>>=20
>> This patch adds known PMU events that can be found on /usr/share/kpep =
in
>> macOS. The m1_pmu_events and m1_pmu_event_affinity are generated from
>> the script [1], which consumes the plist file from Apple. And then =
added
>> these events to m1_pmu_perf_map and m1_pmu_event_attrs with Apple's
>> documentation [2].
>>=20
>> Link: https://github.com/cyyself/m1-pmu-gen [1]
>> Link: =
https://developer.apple.com/download/apple-silicon-cpu-optimization-guide/=
 [2]
>=20
> This needs registration, and is thus impossible to freely visit.
>=20
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>=20
> What is the licence applicable to the original source file? Does it
> explicitly allow redistribution in any form?
>=20

Oh. It's my fault. Sorry for the trouble caused.

>=20
> Other than the licensing concern, why should we bloat the kernel with
> more of this stuff when everything is moving towards a bunch of JSON
> files (tools/perf/pmu-events/arch/arm64).
>=20

Thanks for this hint. So, the thing to do might be to provide a
generator that consumes Apple files and then generates a kernel
patch for Linux perf tools to use rather than provide such details
directly in the source code as you said from [1].

Link: https://lore.kernel.org/lkml/87czn18zev.wl-maz@kernel.org/ [1]

> M.
>=20
> --=20
> Without deviation from the norm, progress is not possible.



