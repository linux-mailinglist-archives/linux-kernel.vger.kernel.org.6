Return-Path: <linux-kernel+bounces-419025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 919729D68AA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC88161266
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D65189BA0;
	Sat, 23 Nov 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mdPpTT2K"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6C165F04
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732358747; cv=none; b=hJ0gcZRCojl4HlM1pUm8+jYVXMJTFnC+IH2rQbBPG0w+kaSECwJflNdAD8iuFTZ/p2g8rcA9N7ixqI8SHN3EibMC+dfA7rR/7YMySRnjXinFk1i9hi9QFWD1yh5P7XnBJdewW8jXUeUa2PvWUxKIES0lqxHLwtIW9ssmTPaP1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732358747; c=relaxed/simple;
	bh=6aYdiCI79UAXlQ4Q5feHcWKcAp8LcgfO+BRF/bN8ehU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z5CL2SLsmbEQ7h797rDW9B++u2ekGM9C5hAVexe+VXq4na6eXRNBHN6FoiLIcu8LDM/+Jmi9j7gY2ihf9hziqB0sIl/Mm6YaPDDcDa9PQzeswWekSLlQGjy2/O1T1fhmW/QyJ19Ql/qfBv+oso8Qab5LS/Y8euLkZ8xrbRuBMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mdPpTT2K; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AC7B240007;
	Sat, 23 Nov 2024 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732358743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aYdiCI79UAXlQ4Q5feHcWKcAp8LcgfO+BRF/bN8ehU=;
	b=mdPpTT2KzWRZfjlzeQyozkoNx0HEC6qC4lWHgfPoyGNTQIJiboFPBFTVrp4GIRjS7znwQV
	5xgxPIxA5z3p5XKXDuyKe0y3rB9dqHJ/2GdABrM+iGTB5CGi08jxf8Gg3UFAnznDXi4ncy
	h6SSabj8IPt2zCMacDrXtz2Nzc1hwzQzg9DdGgDTvd9IjtzFdeKn9lgNCEGCvIoJm4cWgV
	ZrEsc7+Fu6LVxnyTbq8osqC7U8cpXSdsHzIX9Zzs6YkU/82Fs82VxGANEDLDkfdBLlfJr5
	dE313YgdjLCQ8SrB1XgaGETaVdtI56kUqsZ48oOC+9molfvnaWLvnIJqHeS6bA==
Date: Sat, 23 Nov 2024 10:45:42 +0000
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: dri-devel@lists.freedesktop.org, Ian Forbes <ian.forbes@broadcom.com>
CC: =?ISO-8859-1?Q?Ma=EDra_Canal?= <mairacanal@riseup.net>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, seanpaul@google.com, nicolejadeyee@google.com,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_v2_17/18=5D_drm/vkms=3A_?=
 =?US-ASCII?Q?Introduce_config_for_connector_EDID?=
In-Reply-To: <CAO6MGtiYbPZvL=2ycHb50ATaikUg+mR8xRcxGLyme7FcCTkDpg@mail.gmail.com>
References: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com> <20241122-google-remove-crtc-index-from-parameter-v2-17-81540742535a@bootlin.com> <CAO6MGtiYbPZvL=2ycHb50ATaikUg+mR8xRcxGLyme7FcCTkDpg@mail.gmail.com>
Message-ID: <277AB18F-2DCF-46C0-92EE-7519196CDF60@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: louis.chauvet@bootlin.com



Le 22 novembre 2024 21:28:00 UTC, Ian Forbes <ian=2Eforbes@broadcom=2Ecom>=
 a =C3=A9crit=C2=A0:
>I didn't see a `drm_connector_attach_edid_property` call in this
>series=2E Did you forget this? Virtual connectors don't have this
>property by default=2E

Hello Ian,

You are right; I did not call this function=2E As mainly tested with the D=
P connector type, I never had any issue=2E I need to check if calling `drm_=
edid_connector_update` fails if the EDID property does not exist=2E

Thanks,
Louis Chauvet

>Ian,

