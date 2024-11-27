Return-Path: <linux-kernel+bounces-423621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A3D9DAA8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99AADB21C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717BE200111;
	Wed, 27 Nov 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyFymVck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1C1FF7C0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720516; cv=none; b=Ht9ZgzrJBIhtIqadolB5cwCW4ayLJ+T9RzS3XypQMCoy69CYnX3fdnf/dsf44khbKXzUGRnftkUU818sqlxR8YF7FijpfYXhFNH8he2SaKZnNjCkeizFCnP66JfyNaq9z+uklLKPMq81A1XTANyEG1MkkaYRaGjnKHUCf6G/sWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720516; c=relaxed/simple;
	bh=q9teGyA29XahoUm0JRRZs5zNxg1eAovRNfq7t2IlIsI=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=EVt8EozED/S0sFWH7hvoA5R4Cfj9/wW7Fr/mkkbVIcT+HIareLYxElsqp+WtVooR9Kzgw1dyJanB/0AltoxsXxSrPiGmVpbTrZChcYlBiswLfXPpViQl74B78DcvTacZhLTBzA/1THqZut8FH2jo2mx7/v4CTyP7uureg9SBUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyFymVck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19294C4CED2;
	Wed, 27 Nov 2024 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732720516;
	bh=q9teGyA29XahoUm0JRRZs5zNxg1eAovRNfq7t2IlIsI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=CyFymVckMiGKq7AzmYYum8+XYvhvxb+zOKwW9Et6ocHkvTDb6n2EOI2zCojcuHCgd
	 V6ZDoLFzIYvmsjiIIgA2xWa9v5u8y8rQ6CZrbWsFFSx7YIe8AmjkYrj/r7h7ULBz5P
	 kVmR3Wx9dSr2asgHlbKkzZUHF6R7QCMX3Lw2aMDUCbN4DSvwBW13nv8RkO43XSWOKf
	 5WKJlZihdU21UDzvQsdoLUho19+HOFFiQArUpEZKIn0p3pHf6sitM7kaRdZcPHmJak
	 BrCloGt3FANlxOUaa/qJ/kNXQre5iCP/NjJtZiZqvYcyB9x59yeekwKWN210tukuX8
	 RcC/J2m4n/TwQ==
Message-ID: <8eee23ccb8763dda6a6731aee1813e1f@kernel.org>
Date: Wed, 27 Nov 2024 15:15:13 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v2 2/4] drm/vkms: Switch to dynamic allocation for
 encoder
In-Reply-To: <20241122-b4-vkms-allocated-v2-2-ff7bddbf0bfb@bootlin.com>
References: <20241122-b4-vkms-allocated-v2-2-ff7bddbf0bfb@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, "David
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

On Fri, 22 Nov 2024 17:35:10 +0100, Louis Chauvet wrote:
> A specific allocation for the encoder is not strictly necessary  at this
> point, but in order to implement dynamic configuration of VKMS (configFS),
> it will be easier to have one allocation per encoder.
>=20
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

