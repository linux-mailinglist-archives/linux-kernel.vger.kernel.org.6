Return-Path: <linux-kernel+bounces-289551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29775954767
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AF428884A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816A198853;
	Fri, 16 Aug 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KMRzcUzs"
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B32A1CF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806341; cv=none; b=EbkjE5cXJIUDmc7qlM7c6WMSIopNkwcPr86u7DyjhPix6olDkSFgfUePCAcHej6UrLRC5lSKAqlo8mPWNbex76E6fF70O4BQwZtH1uSWan3fRwsAIPtaqWEzWfirK2wu7m9n4118N6/8ldqxA+MRbO8Vy7r5r5lUwP7BQc8Hry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806341; c=relaxed/simple;
	bh=sePFrW7hnIFHQ00HYePXp+xra0KmsbDbNNWXxT3sMXc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Ief17CCFx+0kYyjHo9K8eh95a4Tr8A0AFxboc4oBbeqTqlas/EKhi9q4622mgF9pnLi2NDyvh9/ZmqXX5a+DLWifbml2cw+kKFLZLerCF0uLp3Cqt23J4QGhn5h7r9tKzsAqbWoioEuPDqgdkkHYM4ZZwYi9FYAFZmZsV8tYtds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KMRzcUzs; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723806336; x=1724065536;
	bh=sePFrW7hnIFHQ00HYePXp+xra0KmsbDbNNWXxT3sMXc=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KMRzcUzsSyLMAu2PQK0Mmc/KcWATsiVPDJ1LynVSTomQLpYE1wCgu7ssJcHXMH1QR
	 fp6F+l1C9tFWxZIIIC6yWpm5WkSTRLl4leLaSPFN6CuJM/yIUUUVth3Q6bYNNITAV2
	 pm3RGtJ5IcKfZ7X4hP3tYnQcQ6fCFF5WswZQ6DbqvnuskrHWHUljf34dECRfC+9WrZ
	 1J8hDdYGdbL/v4q3XAFBuK0ZA/7GxHyaA3fMk1oCldA+kpd1y0EbUOgwiq+KJw7UK8
	 wh4vIfz8/dcJn35jbBW/FYJWZO+euW11RqKNcGCqBXq0DJwOVjODga45UoMJgV1q7r
	 xWCmuckB0s7kw==
Date: Fri, 16 Aug 2024 11:05:31 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: jwbda <jwbda@proton.me>
Subject: How to quick test/debug in linux kernel?
Message-ID: <MvEVlTCbeP8Fr6I7mi3pGDQuv7_Yc7CB2OITb8_7IOgJvxmHxXKeIv8XTzTBfazMnyWs6SlMqcM4hAd_TKiRKL9TXppOEFEzbtrZ93Y9Jqc=@proton.me>
Feedback-ID: 99911786:user:proton
X-Pm-Message-ID: 28013b7e47e911e5d4435d59a4d435baedf70210
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi guys, would you mind help me with this:
How to quick test/debug in linux kernel?

Here is my method:=20
Make some changes to the source code, add this line of code `printk(KERN_IN=
FO ">>> run in kernel!\n");`

Then compile and run

```sh
make -j12
sudo qemu-system-x86_64 -hda ./mybuild/mylinux.img -m 4096 --enable-kvm -ke=
rnel ./linux/arch/x86_64/boot/bzImage -append "root=3D/dev/sda rw console=
=3DttyS0" -nographic
```
Then check the results in the console. But I think this method is still a b=
it cumbersome. May I ask how do you quickly test/debug in linux kernel?


