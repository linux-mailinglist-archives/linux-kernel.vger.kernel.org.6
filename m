Return-Path: <linux-kernel+bounces-435113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E98B9E6FD3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A388188530D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E57F206F0F;
	Fri,  6 Dec 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="irIgA5r7"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F111E1C11
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494115; cv=none; b=XpIVOFWnLc0W6KJkTjqjDOr3rfDFD8+oS+0DUuHCMDKTz/SESXQMtvURYcOKX7sB2xKKL3AnJQb13xmL+hORfVMEH/QOXUfmjTVkVut/rgxtrqBxr8Ffpfh2zlicgWXNU2vzsH37YWsfph53R/fULXCjovkumP5k6GjmVDBbWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494115; c=relaxed/simple;
	bh=R+QoINEIs3iYd7klqkDjgE8vz29lWLrSSK4cMCLMcHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKGHwKwG326Tzw0xkTHhUzSGtj38cmQFS2LVGSbiC0euEm+t3Z62OtVA40ac5NJDRpZ0DtCMPiVPItQJw7SLFr3QgGiV93uK2pTt/pzzVONIdMMg2yUdSQKl61Bg+vBJ3bD4e8sE5MsqNm+hY9pSbXbbfNfNSqx0qQ0MdkWgcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=irIgA5r7; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D403E240004;
	Fri,  6 Dec 2024 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733494104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+QoINEIs3iYd7klqkDjgE8vz29lWLrSSK4cMCLMcHE=;
	b=irIgA5r73L7aHzXQdRqtzHBqnYOWmWJCeLQ9PfehV60L3rh1ofLKxeK0hSFzoQQKH7sExW
	OyFExifYco5dV5LRYdmw1a9ckCYjScFRAhlvjL76OmsGExMzuD/VNkv+vn18oG6KV4w83p
	5byNVPN6M1e28sIM/8wKeJgJ2W71CAIRzSdZ+rKU8F5m8UIIY8omiqztQsh9Ab/TurxwhU
	zxL5SN65WePMqgKbhM7MxNCS0vhpNx1I9HVskQoDmLZy2j4R00QariNaTwJxA2RRzXU92o
	U3k8d+xL2TZEtAPoU0J0s6b4ZltZaWYooQYH6N/6kmc3uuQmwHcIMeqgbm5aOQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Nikolaus Voss <nv@vosn.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,  Liu Ying
 <victor.liu@nxp.com>,  Luca Ceresoli <luca.ceresoli@bootlin.com>,  Fabio
 Estevam <festevam@denx.de>,  Marek Vasut <marex@denx.de>,  Andrzej Hajda
 <andrzej.hajda@intel.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
  Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
  Jernej Skrabec <jernej.skrabec@gmail.com>,  David Airlie
 <airlied@gmail.com>,  Daniel Vetter <daniel@ffwll.ch>,
  nikolaus.voss@haag-streit.com,  dri-devel@lists.freedesktop.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: bridge: fsl-ldb: fixup mode on freq mismatch
In-Reply-To: <20241203191111.47B56F7@mail.steuer-voss.de> (Nikolaus Voss's
	message of "Tue, 3 Dec 2024 20:09:52 +0100")
References: <20241203191111.47B56F7@mail.steuer-voss.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 06 Dec 2024 15:08:23 +0100
Message-ID: <87zfl8oqeg.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Nikolaus,

On 03/12/2024 at 20:09:52 +01, Nikolaus Voss <nv@vosn.de> wrote:

> LDB clock has to be a fixed multiple of the pixel clock.

Not only, IIUC it also needs to be synchronized, ie. share the same
source.

> As LDB and pixel clock are derived from different clock sources
> (at least on imx8mp),

Wait, what? I am sorry but that is not at all recommended, both should
come from video_pll1 which the de-facto versatile PLL to use, no? Am I
missing something here?

> this constraint cannot be satisfied for
> any pixel clock, which leads to flickering and incomplete
> lines on the attached display.
>
> To overcome this, check this condition in .atomic_check() and
> adapt the pixel clock accordingly.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 463db5c2ed4a ("drm: bridge: ldb: Implement simple Freescale i.MX8M=
P LDB bridge")
>

Nit: No \n here.

> Signed-off-by: Nikolaus Voss <nv@vosn.de>

Thanks,
Miqu=C3=A8l

