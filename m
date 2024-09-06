Return-Path: <linux-kernel+bounces-319186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2194A96F913
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3390A1C21A47
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B41D31B9;
	Fri,  6 Sep 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b="VhmT7MYN"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315861D1732
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639267; cv=pass; b=TU469R8KbhlAz9OUiGYrz16MAqGBheldSLLO9UJfAqYrbJzHdpVGt68zmnQHRjd+jNfPDik82jFsCo67n4j+OKg6JD7b2v5SrZd0S0zabjust0VphByjew0R9EOqbn9idagkxIG0vyM6qh3sPBf8d7K2SYah8WqKoO+t7tJ6kOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639267; c=relaxed/simple;
	bh=8+6svQXnO3tcX/KAM02RtXUZjeTMRU9brCDTjBWda4A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=j8fILSjb/w7qLj+gqEn/0RROksF7qi81fC9vS2Uz1Yis9cIPVj3Vhn2YWkE/3lTwaJF8NQcIkgVZZX4q92BUmYewmu9cigCGOrCk8859yXppqX9TR3yCQo47qNVkOtn/nnDIdgp9XqzVH6NVjMDGVGxXLrlERjy9v0QIb4xFuDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b=VhmT7MYN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725639258; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JQAglgStHwyBgxGBzIiAML1PHfwsbRhab1F9+JjKIqs6k7Ish1U7ou/ERcCTaUOCx4Ck8oqb4c1eadqiTOW130czoY9UpprWnWOOPU91I/UCRHpf8VgGxAGC0Zmk2vGbZwpvbkGNUPrIbjkTMfcqYLLKbB4U87/7QRMjih6tjNI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725639258; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8+6svQXnO3tcX/KAM02RtXUZjeTMRU9brCDTjBWda4A=; 
	b=EQbyjdf7kz8NdDK/ogy0r4q7iibRxXhtErozUDo16Cw4XZjH/SozQxqFyywSV6e9oCwHL0INU4XquoZLCmKjWtPM+FNWTWqugehd3q69hHhr15BvrL3AkB2Lw9Eo4F4LU/9drFavFllDfsNSDvwNHm24ziAZ9dByHO+z6u9z0PI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=helen.koike@collabora.com;
	dmarc=pass header.from=<helen.koike@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725639258;
	s=zohomail; d=collabora.com; i=helen.koike@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8+6svQXnO3tcX/KAM02RtXUZjeTMRU9brCDTjBWda4A=;
	b=VhmT7MYN3gQ4BcHmrcZ0HdL8S0hlb2iWXRk4+pXXzN8njrmCeBM8YuNN9H4vgRRF
	+VYa22gO1QRx+MRv2X7IfS2mk2QHFYe6upY3E/a4OJ+EXc7QyeriqMTVs9DFj0WoI0F
	4+ImrW1VzA2Lpw4AibevUAdWawpJ2wcgALsrZGVw=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1725639255810957.1130957053573; Fri, 6 Sep 2024 09:14:15 -0700 (PDT)
Date: Fri, 06 Sep 2024 13:14:15 -0300
From: Helen Mae Koike Fornazier <helen.koike@collabora.com>
To: "kernelci" <kernelci@lists.linux.dev>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Message-ID: <191c81d66b1.12123afbb102574.8672827374237136458@collabora.com>
In-Reply-To: 
Subject: Bring your tree to the new KernelCI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hello everyone,

KernelCI[1]=C2=A0is entering an exciting new phase, and we=E2=80=99re invit=
ing kernel maintainers to register their trees with us.

We now support over=C2=A0220=C2=A0build configurations, run=C2=A0boot tests=
 on=C2=A045 different hardware platforms (totaling over 300 machines in all=
 labs),=C2=A07=C2=A0CI systems contributing tests results=C2=A0and have=C2=
=A0test suites=C2=A0like kselftest, kunit and LTP already=C2=A0enabled, ens=
uring comprehensive coverage for your kernel trees across diverse platforms=
.

At the upcoming Linux Plumbers Conference[2], we=E2=80=99ll be unveiling ou=
r new=C2=A0Web=C2=A0Dashboard, which allows you to easily track your test r=
esults.=C2=A0Also, our team is ready to support you with=C2=A0custom Grafan=
a dashboards=C2=A0tailored to your needs and=C2=A0optional email notificati=
ons. We can also enable your preferred test suites.

We=E2=80=99re committed to delivering real value and working closely with m=
aintainers, developers, hardware vendors and product makers=C2=A0to provide=
 specific solutions. We understand that each subsystem and maintainer has u=
nique needs, and we=E2=80=99re adapting our approach accordingly. We can bu=
ild=C2=A0custom views=C2=A0and configure=C2=A0personalized notifications=C2=
=A0to help you focus on the results that matter most,=C2=A0minimizing unnec=
essary noise.

We encourage all maintainers to register their trees and take advantage of =
these new features. To get started,=C2=A0submit your request=C2=A0via our G=
itHub project[3]=C2=A0or contact us directly at=C2=A0kernelci@lists.linux.d=
ev .

During the Linux Plumbers Conference, we=E2=80=99ll have a hallway booth=E2=
=80=94please stop by to discuss your needs and share your feedback.=C2=A0Ke=
rnelCI is committed=C2=A0to deliver solutions that matter to you.

Learn more about KernelCI in our documentation[4]

[1]=C2=A0https://kernelci.org
[2]=C2=A0https://lpc.events/event/18/contributions/1739/
[3]=C2=A0https://github.com/kernelci/kernelci-core/issues/new?assignees=3D&=
labels=3D&projects=3D&template=3Dnew-kernel-branch.md&title=3DAdd+branch+BR=
ANCH+from+TREE
[4]=C2=A0https://docs.kernelci.org


Regards,
Helen Koike

