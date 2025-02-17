Return-Path: <linux-kernel+bounces-517692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53598A38465
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E2C18981D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7021CA04;
	Mon, 17 Feb 2025 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/0oSzGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20D21C16D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798093; cv=none; b=Cx/eIYE+t5wF1vyjVwJf2BCQXnbx0AZbqxELcGC+m0x6ZPuHkhL58Qhu8KbYA10iETPdfvh4IEhMDWAYjYa9/to+BU7fgwmE+fjLJK3fWDsugt1n1mIzRAsDqhDSPArmosAo1eKiIukQfr8Zdzn3XUOqeaW/b0JVy3W6oxQQjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798093; c=relaxed/simple;
	bh=13SPp22CZVN6xo7eWbjLFTp4tb5+gOXnGjqBpfPpjO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o+yNbY5shyHhTQH8YOlyouJTNUuFbkLMMB7YORYkG1GH6ItEkYyDG/CgGExyac5a5CHx2YnxOadRZ/Bt9b9HgF58lgp26JxyyqdTxH3Jspl+rdgiXHNiogEzMxvWJm7Q+356qg/JFwddRsEsShNLood9bDG2C+1OPYeQA/H9TWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/0oSzGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A3FC4CED1;
	Mon, 17 Feb 2025 13:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739798093;
	bh=13SPp22CZVN6xo7eWbjLFTp4tb5+gOXnGjqBpfPpjO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U/0oSzGgoTnI9k06MhPJaHbBvs2FoX445vtnucfIyVQbPLR/+GhQis54mxIHZ/rOx
	 YWeY/JHgHAxM2ByitJ5DML0s04ByPBxMVo5M7Dr+rgrYJOXBHeoTP6aIMg0GZe3Rud
	 wYhNYQ2jAGAjfRxcOrJryrFUNfBHVw+neugbJV5sJpNlxLHVonm143OABc+JcbJFOa
	 +SEQDUnmoSyo7oDoqU3xN9s9e5sCeZt7fteyeKjHoX+NuSa6Iw4bnixQayBGdMLXVL
	 SpPcauyMFgJ9sbPLtLMmlmMcK+98RImLjxSdL8RNfjBD7dFTToIF9Xm0aVEKlZhpXg
	 dkJfaPwQBe+kw==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Vitalii Mordan <mordan@ispras.ru>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sui Jingfeng <sui.jingfeng@linux.dev>, 
 Aleksandr Mishin <amishin@t-argos.ru>, Al Viro <viro@zeniv.linux.org.uk>, 
 Tomi Valkeinen <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>, 
 Quentin Schulz <quentin.schulz@free-electrons.com>, 
 Swapnil Jakhade <sjakhade@cadence.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Fedor Pchelkin <pchelkin@ispras.ru>, 
 Alexey Khoroshilov <khoroshilov@ispras.ru>, 
 Vadim Mutilin <mutilin@ispras.ru>, lvc-project@linuxtesting.org
In-Reply-To: <20250214154632.1907425-1-mordan@ispras.ru>
References: <20250214154632.1907425-1-mordan@ispras.ru>
Subject: Re: [PATCH v3] gpu: cdns-mhdp8546: fix call balance of mhdp->clk
 handling routines
Message-Id: <173979808601.704013.18168573749410463976.b4-ty@kernel.org>
Date: Mon, 17 Feb 2025 14:14:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 14 Feb 2025 18:46:32 +0300, Vitalii Mordan wrote:
> If the clock mhdp->clk was not enabled in cdns_mhdp_probe(), it should not
> be disabled in any path.
> 
> The return value of clk_prepare_enable() is not checked. If mhdp->clk was
> not enabled, it may be disabled in the error path of cdns_mhdp_probe()
> (e.g., if cdns_mhdp_load_firmware() fails) or in cdns_mhdp_remove() after
> a successful cdns_mhdp_probe() call.
> 
> [...]

Applied, thanks!

[1/1] gpu: cdns-mhdp8546: fix call balance of mhdp->clk handling routines
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f65727be3fa5



Rob



