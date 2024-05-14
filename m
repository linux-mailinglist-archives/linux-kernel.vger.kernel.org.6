Return-Path: <linux-kernel+bounces-179168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD28C5C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF12282C73
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B418132E;
	Tue, 14 May 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrNiCqFB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBE1E491;
	Tue, 14 May 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715720808; cv=none; b=sPhSLEZRZNs2e3lfpsr92wutvHL8xk+D5XMz6hpIy9gTskJcjuj9GjEYgVDuJbOiijNoil+mHic4yWvEdg41Jrnr45Qe/KiMmPDxraPECYQzxBUp5liQIcuwvjBPphtFXoOqYUVnQhKlP2KAJlEc7tQVZ2mBgR9eS/2y6gTchD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715720808; c=relaxed/simple;
	bh=sPhK8aVkxoU81JS8wSirx6dMhgT2OHlqpRC68+bElVc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=dLQ1LnUxA6VQcczVrPgcj3Y5qOx1jFeKh+d+cnDhvM7alSdedKcK7AyvvmyFJkj0UlGsXYiA+f4kHp3hJSUuqOgjHK12ueyrOAzUHK97JORpKU3YTIuXf+XbdprD1Wb8hOK0tNle6kgeFIMFpFfWVYxxE8zv88J8RtVo6vVZ9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrNiCqFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DC2C32782;
	Tue, 14 May 2024 21:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715720808;
	bh=sPhK8aVkxoU81JS8wSirx6dMhgT2OHlqpRC68+bElVc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=LrNiCqFBhFZqZxRcljQ3h/3X5ONMnb8DcVLAroaRKcZZFP38r8QCM9NbblAzrBeMD
	 f/kL5XdlG7pfMnDUOgAS//8IgiWkJjTiV+YquKnnl4ZI/oT3Y/fzpvVX1dQ1BbxHS8
	 W7qdth6tL5j9OxpegidrGOpsEqa9rjCFktVisOIk1tmnrWWFrZqANy3OOsFMx+RaNt
	 3ohJtQ0Hn3FYg/M/Y5DixjLbqKhlQ32vmCUKzOpWOvdrOgfLbSVqi95Zn7XIOrvHyW
	 umHCccq7+y/irGlWjQeEcK1Iku9+YTESgRjiWO2kY8HArO5MIwPc5f9R5o8/Q0NCP4
	 50TvQUfV4sCSQ==
Message-ID: <4dcf39c7c2f30acc38fd245883f62dd2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240513235234.1474619-4-florian.fainelli@broadcom.com>
References: <20240513235234.1474619-1-florian.fainelli@broadcom.com> <20240513235234.1474619-4-florian.fainelli@broadcom.com>
Subject: Re: [PATCH 3/3] clk: bcm: Make CLK_RASPBERRYPI default to RASPBERRYPI_FIRMWARE
From: Stephen Boyd <sboyd@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, Jassi Brar <jassisinghbrar@gmail.com>, Bjorn Andersson <quic_bjorande@quicinc.com>, Maximilian Luz <luzmaximilian@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, Michael S. Tsirkin <mst@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>, Conor Dooley <conor.dooley@microchip.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
To: Florian Fainelli <florian.fainelli@broadcom.com>, linux-arm-kernel@lists.infradead.org
Date: Tue, 14 May 2024 14:06:45 -0700
User-Agent: alot/0.10

Quoting Florian Fainelli (2024-05-13 16:52:34)
> The clock driver is essential in providing clocks for UARTs and other
> peripherals, make it enabled by default.
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

