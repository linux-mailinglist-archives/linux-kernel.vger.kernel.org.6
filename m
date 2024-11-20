Return-Path: <linux-kernel+bounces-415390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 158179D3562
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88FCB24794
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16726171650;
	Wed, 20 Nov 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyf4p+jL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A81B7F4;
	Wed, 20 Nov 2024 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091280; cv=none; b=CK26Wo1ATvLVrpHbGJHykfsRMZv6yafyZrx2o0g3d5KBa4aljZZl8PcN27vy3ecOTR1DHQkL61Ljepo0tTnyyKzlWGq/LNuStxJiisFl3wrq/lwUMGj1FFeH/nXZrLJrfx6TQ+6mOIU5yc5FQxNTJ2rEJUW8al5bvhdM8aYDPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091280; c=relaxed/simple;
	bh=SnrNpt481bFjFOWYHOj8+5+1Y/gn4MZcw71jG86uXjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwmORJzmFedhUmLFqCSTA+dacCmxRlQ9ziFwjeCMj6ZU/DIUK+dZgISOrD++ASkLJK/9xH+BIyEHr9LsdsssKZ6m8TIGIwcuaPZozqomp3+mGaE+vv/zpthNT3zwBeyIQfwhfkdxPycK0zpnzISw4221rL8Uq7f6gQXRk0qxqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyf4p+jL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBE5C4CECD;
	Wed, 20 Nov 2024 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091280;
	bh=SnrNpt481bFjFOWYHOj8+5+1Y/gn4MZcw71jG86uXjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyf4p+jLqWNpvWPhWsWUyWiof86UtkM/be6WhrO+1+y5UMS67WXaDKys1sJA6+HBM
	 Sc+z7k88o1jfLp4f5vtKYeMmcQK4oKh+0tPhkEI+MsqxjEjaAImZdPM3+FMQm9y+L8
	 vPtNW+AZ5gNudF8x+iF176dMQaAnnmqfS98tBXGiUW7fCs2g9fannURoEHNBC/K5MT
	 496Oazw3dBaYyxuvWY/Cus/hp/LYFVM5TlHQVjJaM8DnQxTMofj9TuLMq+ccauGtZc
	 UubDdP3qE/EYhdQKxaxxr12R0wM8sIM3Zx599eXzqQ9pHYBCq6m/9mCXc+6N7u3dQk
	 EYNV+7pspIVXw==
Date: Wed, 20 Nov 2024 09:27:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matt Coster <matt.coster@imgtec.com>
Cc: Frank Binns <frank.binns@imgtec.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH v2 04/21] dt-bindings: gpu: img: Allow dma-coherent
Message-ID: <dvqeqopwztjk2odgtdzsncklj36aaii3wsmzsf4b2qlsv55ru5@wplvvf6oqmvz>
References: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
 <20241118-sets-bxs-4-64-patch-v1-v2-4-3fd45d9fb0cf@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118-sets-bxs-4-64-patch-v1-v2-4-3fd45d9fb0cf@imgtec.com>

On Mon, Nov 18, 2024 at 01:01:56PM +0000, Matt Coster wrote:
> This attribute will be required for the BXS-4-64 MC1 and will be enabled in
> the DTS for the TI k3-j721s2 in a subsequent patch; add it now so
> dtbs_check doesn't complain later.

That's not a reason. You add it because device is DMA coherent, not for
some imaginary future checker errors.

Best regards,
Krzysztof


