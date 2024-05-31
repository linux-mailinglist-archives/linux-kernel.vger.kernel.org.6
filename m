Return-Path: <linux-kernel+bounces-197107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 407768D6647
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FE11C22801
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2082157E82;
	Fri, 31 May 2024 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAxhsaTk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBD225DA;
	Fri, 31 May 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171579; cv=none; b=Lf5T+VYVFLzJI/2by1+hy2ci+WKhZQMCMiz/VWgX9Qstg7ufF10SPdPS20MYB3q2u7oQEGunXNcCMVsoHssWl+WMbA8afGqEWttK7lRw9CKssamdTNIbaeYVS+pMBZLi+lOcyPYgDZW7lTuTCJuVMZF2Od1msDD7HYhL5gZLjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171579; c=relaxed/simple;
	bh=LQCvrP06+ub0WmZb5H0EUGQ/V5k2fp3n8C159L6sKk0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hnsx9J1LQTyyN3zgASX8i1843HvEVnts9733/3sM5OQ8a/oBJu36ABNyw5ECNjFUffgdTmiNqvfxQAEFCU/ZE37w46pw2nMKzJoT0/m/NOVU7pYQysQM6DmBOiRrslSIx1rtpLGJ+WGewW0ehIZtU4gNwmpOVrGP4SP4q1G9QrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAxhsaTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED515C116B1;
	Fri, 31 May 2024 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717171578;
	bh=LQCvrP06+ub0WmZb5H0EUGQ/V5k2fp3n8C159L6sKk0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WAxhsaTkS9yWeXMhPapwzNNnByCB1HUy4EmmTmQRdlifk9fQWPYQAF05Ny1ahOdx9
	 4Sq7deBPc78KVmzQpNpO8TlfltYrLo9yN4dFlRfa8MFWcMHa72ck/vVpQL0lAw199b
	 G8ZV7hEyCPsiz89pFXJBq196R+CguB2UGMDfn7xqDW53ggaXTj8g2mbppsyiRTA0yX
	 GDZZvsSLV0FhWYjtJ0Kqt3eLF2GxOCsm1yHAWpsLApB7CI9jElOLamzo5KjSNTVsxP
	 BQfcPMXUqll9Uthd8RgA1OZQWNVHmLBnqywPBkxV8dGPQtVzrVYdhGGzlkVuu4fvMO
	 uAeBvmibunfVA==
From: Lee Jones <lee@kernel.org>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Moritz Fischer <mdf@kernel.org>, Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>
In-Reply-To: <20240529-cros_ec-hwmon-v4-3-5cdf0c5db50a@weissschuh.net>
References: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
 <20240529-cros_ec-hwmon-v4-3-5cdf0c5db50a@weissschuh.net>
Subject: Re: (subset) [PATCH v4 3/3] mfd: cros_ec: Register hardware
 monitoring subdevice
Message-Id: <171717157570.1179352.10771084624581761418.b4-ty@kernel.org>
Date: Fri, 31 May 2024 17:06:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 29 May 2024 08:27:13 +0200, Thomas Weißschuh wrote:
> Add ChromeOS EC-based hardware monitoring as EC subdevice.
> 
> 

Applied, thanks!

[3/3] mfd: cros_ec: Register hardware monitoring subdevice
      commit: 27e669820cda845d6d4c505809711ef6b4cff9a1

--
Lee Jones [李琼斯]


