Return-Path: <linux-kernel+bounces-216410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD3909EF8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F5E1F2318C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8FA3B7A8;
	Sun, 16 Jun 2024 18:08:09 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D7D1847;
	Sun, 16 Jun 2024 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718561289; cv=none; b=UIzE53NRpomyDA22J3/QVaINgY1vE4sU5YSgF1Puo3Cn7qnoFPUlpL6zUHJZs82yz3rtopGgz26864AAprxWyimtwfDDEqCOJV4FtNSg7pFOPl0RWGnioZixcFcIniz3smCRyUmj84bwF+YVgq56chcwOAOctTrujw/PI1GDD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718561289; c=relaxed/simple;
	bh=zQpt/KOTN1mT5M1C2lwXEYoYFxmtE7HL1hRnOr8ZtNQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iU7pgeLNRO2fvIV5KEGO/dy2np6kGGN2/UazNjTQ0pBxgvkNTR0kV33fTA3n0UWsLrYdm58Eoh1Wh10WZOZyhZfQ59xAmKa6YcV9ZQwwD3WsIVxLGEHzKLN7vg5uY6LzgKSg5WIwJi6npLV68tZAFN5g9CQO7Oq90wTMvrx2d88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (c3e47615.dsl.pool.telekom.hu [::ffff:195.228.118.21])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000070EF5.00000000666F29FF.0023D54E; Sun, 16 Jun 2024 20:07:58 +0200
Message-ID: <2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad
 330-17IKB 81DM
From: Gergo Koteles <soyer@irl.hu>
To: Ajrat Makhmutov <rautyrauty@gmail.com>,
  alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
  sbinding@opensource.cirrus.com, luke@ljones.dev,
  shenghao-ding@ti.com, simont@opensource.cirrus.com,
  foss@athaariq.my.id, rf@opensource.cirrus.com, wzhd@ustc.edu,
  linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 16 Jun 2024 20:07:57 +0200
In-Reply-To: <20240615125457.167844-1-rauty@altlinux.org>
References: <20240615125457.167844-1-rauty@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ajrat,

On Sat, 2024-06-15 at 15:54 +0300, Ajrat Makhmutov wrote:
> Headset microphone do not work out of the box with this laptop. This
> quirk fixes it. Zihao Wang specified the wrong subsystem id in his patch.

The 17aa:3820 is the Duet 7 ITL6's PCI SSID, so I don't think it's a
mistake. It is just a PCI SSID - codec SSID collision.

Here is an ITL6 probe:
https://linux-hardware.org/?probe=3Dd3d4d3dea3

There are some similar collisions with Lenovo laptops.
Please see commit 0ac32a396e4f41e88df76ce2282423188a2d2ed0 for an
example how to handle one.

Best regards,
Gergo



