Return-Path: <linux-kernel+bounces-421028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E159D85D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5C4289FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577F1A7060;
	Mon, 25 Nov 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcL3GYuj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C021106
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539839; cv=none; b=ZBPfPDy1Z7Xp3S6BBjkiJ4VzP3ZxcKMB53lPONvmcXFahkDy7Bgk1R1LDfKgbxwE6A2l1I0yiDPbz7JMZk5rr57SY/sM/UdiZ7rNqYhjoRlNqZQlvib2hQSzFdFjcW+gNC/RU5S5EIGFr1rTlKXCI2ToyLQCtiSCLJulOrqBafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539839; c=relaxed/simple;
	bh=wISbb0QpnxgwSzAh2HAtCG7qz3Bipu7e+h0lEbAx+yI=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=Fp5sk9EyYHZ9DsGyzKEk02J/Vdli4ob2X9/O3ki7y06pgYaj3HB6iQafY9on9Yr7e1Y+6RIfP2JX7jLXGZbluyF38zk7hTk86uvD/bZk1cbsflJa5VFSshPinU2pFaGOdFJYZ2XwGfq9+LiESQMfRciTCm02g/DcobKEWnbEuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcL3GYuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF19C4CECE;
	Mon, 25 Nov 2024 13:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732539838;
	bh=wISbb0QpnxgwSzAh2HAtCG7qz3Bipu7e+h0lEbAx+yI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=bcL3GYujtllA/mhHdAKmqKokVONHbGNx8Z1r1ZxGBFRulp/zivKwJ44vj+pyi5ILI
	 BFihSzwfY8p97SST6ca0nTSYkABHnyJG/jcK/BK0Zvs7UuUcJOwoNZihTtD1hcW62v
	 hNfv6GCauhdfgX8vNr8xDRliI1kh2kF5rx+BECBYqlJDuIj6PJlKaQH7tpz6S1/rIc
	 xSNoLCeHpKI/2AjBytpHqjo7OtdL8z0hQFExFKuXN7G8LOw8wGWXiPCPBa7/vcZCGQ
	 wN9FjGwuOw35z/oHYmINTCkLh0QyNI8KHLGrVTZ0ZpNecIE6fDx8MTFFthqOQliuEB
	 hsYVZgO4espgw==
Message-ID: <768ed48e495e965d4964a3950a06b727@kernel.org>
Date: Mon, 25 Nov 2024 13:03:56 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v5 1/5] drm/vkms: Switch to managed for connector
In-Reply-To: <20241122-google-vkms-managed-v5-1-1ab60403e960@bootlin.com>
References: <20241122-google-vkms-managed-v5-1-1ab60403e960@bootlin.com>
Cc: arthurgrillo@riseup.net, dri-devel@lists.freedesktop.org, jeremie.dautheribes@bootlin.com, linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com, nicolejadeyee@google.com, seanpaul@google.com, thomas.petazzoni@bootlin.com, "David
 Airlie" <airlied@gmail.com>, "Haneen Mohammed" <hamohammed.sa@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, "Melissa Wen" <melissa.srw@gmail.com>, "Rodrigo
 Siqueira" <rodrigosiqueiramelo@gmail.com>, "Simona Vetter" <simona.vetter@ffwll.ch>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 22 Nov 2024 17:27:56 +0100, Louis Chauvet wrote:
> The current VKMS driver uses non-managed function to create connectors. It
> is not an issue yet, but in order to support multiple devices easily,
> convert this code to use drm and device managed helpers.
>=20
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

