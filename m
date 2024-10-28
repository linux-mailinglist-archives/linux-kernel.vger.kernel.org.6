Return-Path: <linux-kernel+bounces-384485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F89B2AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61954281123
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287AD1925B3;
	Mon, 28 Oct 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5FmPI5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692418C93D;
	Mon, 28 Oct 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730105577; cv=none; b=eS9zuTcGW2zQByGriYF16sUhaXFkYSq1ljQjM0SdcxLlQplWHz9XfoI2asrwUVdYbBtTVr46cjOiGWdbTla9f366Bzq7+UX1RpM5nVH4oHKqc1W6n6MGuCuZjgbNZbI4SH2QuEigN7bIlbs1uTPtPoY6F2IGUcbzrL+nMdPUi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730105577; c=relaxed/simple;
	bh=TPuGrC3cGBDg/ZWdUDGG2KDgdWbuu2YD1zoCFRggZjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+BmRzWaxCpfxWBBJSzaBm5zW2t3rvAr9+V0rgvSEe42aySOh5XgsXtqlCub5ZRRIg8LJ3qzbNegBqya3AqDQ63QIQkVeWO0Yulr/vv2bNoTiiK+MGHherFZe23BdXvrTp99GRXjJYFaSY1Cp9Q6X/hb0BcGNGyOI3IRsg748/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5FmPI5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F6FC4CEC3;
	Mon, 28 Oct 2024 08:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730105577;
	bh=TPuGrC3cGBDg/ZWdUDGG2KDgdWbuu2YD1zoCFRggZjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5FmPI5hhfkA1J/CHVA33DRQLFYQenjUxKR+LFEE5X23R+PPf9j3D/Mm/dec9G2lF
	 fqMNb2rj6Dl24RpDK39h8MZyleUpPblXvrXD2OU/Amf8doJL2x0Rnqbc9REjptUM30
	 EezT/REO6d3+9h5pWhZC4u37Lywk67ZY8LszOkms4D4ZY4hcSREKeHiQXHmu6btZUC
	 VGhyvjtFRtQ1VUZ/jv3l4xRhOgAWjR1LVtKs31l7caaZEsuoJK9OoSW/Ygbt0XayMj
	 bUKyDs26LTlZhBbiqLjMtgxL/N1ppPbeyDnqse1H1QV7HrFrJQmB2VkEgbOD1hGa3g
	 kbYG/L9ao9PfA==
Date: Mon, 28 Oct 2024 08:52:53 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: Switch back to struct
 platform_driver::remove()
Message-ID: <Zx9Q5U57byTHwBu9@google.com>
References: <20241028082611.431723-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241028082611.431723-2-u.kleine-koenig@baylibre.com>

On Mon, Oct 28, 2024 at 09:26:11AM +0100, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/platform/chrome to use
> .remove(), with the eventual goal to drop struct
> platform_driver::remove_new(). As .remove() and .remove_new() have the
> same prototypes, conversion is done by just changing the structure
> member name in the driver initializer.
>
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: Switch back to struct platform_driver::remove()
      commit: ea45f3f46734a47bdbcfb31f41748484219d2ea6

Thanks!

