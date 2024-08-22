Return-Path: <linux-kernel+bounces-297250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C895B4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFFB2881C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444071C9441;
	Thu, 22 Aug 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU0IkuLa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD826AF6;
	Thu, 22 Aug 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329585; cv=none; b=mfl8ZkTOwDn0fwgPVpuSuoLYPVg5RthzavknT9pD5vahfSW46UWn8UzzPlgQpv1YLf+QPOFe/Sw6mtekQcRD4HnuCMN6Bx/yfRdsz9CsO/3GT1phI0gyTDYbMvFhITpYIoHe29AmVgXc694ukRaafRbH0vP2lFN0AxI4vNQ2ZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329585; c=relaxed/simple;
	bh=xKewytoaNbxzrYC5ydNIknW0CHpuyLOsrNB7vES9oHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Worib0Dw/vuLOSOls/KYkaLcchEgy8FTqkiEmzP7FdewtHuMBbgvFkcaWlhWER8DbDegBlehFlX6+jaR8GvCnPU7cIzzuavhpXX/AmbFk0R8nLrHjtfprWnX/lcfShLhJ2RRQyQxUy73Le9WiXFg8r8fZNhT1mKuLMAs4l2ZluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU0IkuLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088D4C32782;
	Thu, 22 Aug 2024 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724329585;
	bh=xKewytoaNbxzrYC5ydNIknW0CHpuyLOsrNB7vES9oHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TU0IkuLalCUGx0ARPmIOrCr7Go72JDLJgRqhSCS0kBII899b5g0aBBjRxY1VOjTxo
	 AV5IT01IAhM7NN0znyDhDkvCz2uk63qVT00dcAZ01p+LcgQTgBcBBmwBaKa91pQxnp
	 TLgh+tA2vLIwGumjJWkouux1k30VovzZnZYLZDvrboyLpM0aDcBfc6Wj3aVWINF8lk
	 oyUqBml+gn361V5wZuhb3+0pRjbdoQEwmuB/ORQKa/pdTMR1hUloAsRZ52OQu2MJsd
	 bJAh0OgXaC4rWgY86rM8Inr2CN4xL651Xb354DFPNqsESjr42SFcvIi0lbNVcQpqq7
	 heh8w1o7u/3Kw==
Date: Thu, 22 Aug 2024 20:26:21 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] platform/chrome: chromeos_laptop: Use kmemdup_array
 instead of kmemdup for multiple allocation
Message-ID: <Zscubf28qLgzsUuz@tzungbi-laptop>
References: <20240821112629.596298-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821112629.596298-1-yujiaoliang@vivo.com>

On Wed, Aug 21, 2024 at 07:26:29PM +0800, Yu Jiaoliang wrote:
> v2:
> -Use sizeof(*i2c_peripherals) instead of sizeof(*src->i2c_peripherals)
> -Format code

Please move the changelogs after "---" next time so that they won't be part of
commit message.

> Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

I didn't see the tag was provided in the mailing list.

