Return-Path: <linux-kernel+bounces-255577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2C93426E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070DE2813F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3EA1822CD;
	Wed, 17 Jul 2024 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qrov9p//";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mwbckVT9"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B47F111A8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242350; cv=none; b=jcbcWRRVPdLON2+j1FjxzksiiPugZP/Q6cDiGkz5xk209otqFKaOPAqCBU2nmrPNEaR+RO+SHyGT+VF9JbwkSQljDYDiSaBNI41WQqAzmE2H2IP+xnisPK8Hzbfmi+IEhbaCbCfdpv6mo/FXHli9pFsu7qKOHUql+kFxmbB29MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242350; c=relaxed/simple;
	bh=yoGHeAcgqHxETZNxDFxsC1za6xoJaiCB6J+Q6W3ElCE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ldbas4APu+UYpPWzCrFmIdIcgHffdOsS8k1yn6SGuzgH6X9RJ2biobLCOrVQg0/EaIW+xru90zEtf81K0+s+/rrmlqcFvSPX2XB5iHqBcVvk2tmtm7lhWZQPGugbQrj3dZrQKsfxf2fCyr+14zwWTsX2Q4lWw+4Cg2T/ZNxXDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qrov9p//; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mwbckVT9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 38A4511400E8;
	Wed, 17 Jul 2024 14:52:28 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Wed, 17 Jul 2024 14:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721242348; x=1721328748; bh=KC/EepEiuz
	j2zfSF7rzmc2XJOjPkGvEpbIV2C8iRTTw=; b=qrov9p//SPfyuNIDLToRhyP2Cb
	4p75eJ0cDSdl9uPJAjxC1kOQC9DX5wf48SxVEP/I5ZIhlIAudUMqt2pxoJIFJDLl
	JUYwiFQ8USnoBjOtSr0fZN6i/GYzY+/MU13F6W87qs5bePAJPy2rS+GlaAA3llU/
	MzJnsN4snIbAQ6NtFxftOj2UCY+AEid1eN2qICmtQIHx/gsT6YRTPGNxYJvaxR0I
	4wC0R7YP7kubFw0XYJM4cnLSLmrtxFABY9byVnUeRbhD79IEQtfKd1zzAoItQnpn
	ApC+FuaRlMP75Lf8SCNQZClIFL0mUo2J6oQw+sAarFqHg0nuULsUS8jUofPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721242348; x=1721328748; bh=KC/EepEiuzj2zfSF7rzmc2XJOjPk
	GvEpbIV2C8iRTTw=; b=mwbckVT9/c/Fi1LyYRPrQcjETwRGe5qJini1YJHvVyMc
	8QLgYt/gAz4kbSg4nlzrY9+0gqXCdEvLVZgZBC9LFrIxAGXq5n3PJg92Ft6BL+Rz
	j2f3Vri+z1q0FKw6R95HiR789kcuX/pPUgzfiZLJhz8Nbi7erZNlLhdsi1y4VJxx
	pij7HWHyIDgTI+Nws6Iu5hN6BTq7zESy5kwreV3MdionpOUXGp0YDTWX/cvz+aun
	WM5XNWWTlunrF4paM7Be8fTGGKfheBVmiA5lq/Qa285cgtpXmLHH64yzdUUDc4vP
	65K9nIPaDlr+Ki9gyv9nfQBccAdVOVosmYhwb7XwxQ==
X-ME-Sender: <xms:6xKYZgqoPCryvjkV2_c7lwRIurtYfO4zngqZz0It9yxLzmHLBDF7MQ>
    <xme:6xKYZmqk-ldHyXjg_oGqtX9HMz-yU5Vb28UYLj70GbBV7QdjiOeEXYRyb5AgNABTa
    GEzgLl-2LdDQAlcb_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeejgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6xKYZlOVhxo990VNXEycWIlhrfWBsrqTKm5pmiIZth5CzBFnWKx3HA>
    <xmx:6xKYZn6SSgP3QvGdg3QK6gvp3cN1D0ssg7FXCYuV6UrzDFVyMk0bCQ>
    <xmx:6xKYZv5XyfIFpjM2eJ73cem0rvd9d4OUkIkDFWP9msb9fKfAJZh0Ew>
    <xmx:6xKYZnhH1ydg6uCRHCMIDgBeCf7KHhG_RBDM5JtMN-VmEv0BHbtsUw>
    <xmx:7BKYZi10ceeaen3tlNvmPT83Mkd6GiEfEY7dTTsrBGWOdiiKavjpdG3y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1641B19C0062; Wed, 17 Jul 2024 14:52:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <865236b7-fd09-43cd-94fe-c07da6a903c5@app.fastmail.com>
In-Reply-To: <20240717163739.181236-1-vattunuru@marvell.com>
References: <20240717163739.181236-1-vattunuru@marvell.com>
Date: Wed, 17 Jul 2024 20:52:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vamsi Attunuru" <vattunuru@marvell.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Nathan Chancellor" <nathan@kernel.org>,
 "Jeff Johnson" <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] misc: Kconfig: exclude mrvl-cn10k-dpi compilation for 32-bit
 systems
Content-Type: text/plain

On Wed, Jul 17, 2024, at 18:37, Vamsi Attunuru wrote:
> Upon adding CONFIG_ARCH_THUNDER & CONFIG_COMPILE_TEST dependency,
> compilation errors arise on 32-bit ARM with writeq() & readq() calls
> which are used for accessing 64-bit values.
>
> Since DPI hardware only works with 64-bit register accesses, using
> CONFIG_64BIT dependency to skip compilation on 32-bit systems.
>
> Fixes: a5e43e2d202d ("misc: Kconfig: add a new dependency for 
> MARVELL_CN10K_DPI")
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

