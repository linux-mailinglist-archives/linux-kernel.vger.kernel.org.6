Return-Path: <linux-kernel+bounces-389374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9ED9B6C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8B51F224D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F0D1CF294;
	Wed, 30 Oct 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZcAJRjr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1481CEACA;
	Wed, 30 Oct 2024 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313284; cv=none; b=bsKr7n9J/hu5WjjEKDXeovopM+wOGSZEIa1VcD62u+vII9ykUyZREO/oYgf1puZtoXR8ntJBGfzwfagUNBOu3m1jbBeed7dhF95R9xNE1N87FYqU199VHWJwuarCNdTlT4+zMxDrYSh5Snl1N8vS9/voRa0bf2/6vIeU7D/hXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313284; c=relaxed/simple;
	bh=gEmncs+VulLLr+/iySrfu6jFGqWcZObw6hvAsv8MWeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvMZxb3mSVXmGXs/w14tRpKD3rLZz5Ea7ilMoh6UEMNd/Px7nHrubecbsaXBZAmnGzbj2W4U1LIWXc05OzGhHPVbQ0Qd6RkCeui8Tl5HxfOW8MpU+QMd66RO03Zv2WZHsAm5ZJDIe+slj492bD1EqCe+RzM5jY4yHljmfhXW1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZcAJRjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C43C4CED2;
	Wed, 30 Oct 2024 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730313283;
	bh=gEmncs+VulLLr+/iySrfu6jFGqWcZObw6hvAsv8MWeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZcAJRjrYxr4WD/K1xZbIcccNMkZrgbZhx2ELJ0rA1lFkAvroiY2YcjKlAoA8Aeb2
	 s5w27RJ9cdAUsVVS3XK5SQREbKT5ho06zJiaw1fFv8+hDvC0qTLruoxkR4OVaIoVLX
	 c8LGedIzpzuHbuJ/UJ6lv1ovkGp6/Kfo56zOR8Bv0sBtwkFeqHEk25z6Z8tVvdZZ+G
	 koRtIU7uGEunys0AS4w0z3/AIyEVpqQwWlplaAsNzDqCZsean/ztmzAjFMkTXoOEIq
	 nu95FBCrRl0BjQIMe6PGDAFSVUSFTYrgNp/ca4GVsHf616mg5g0N9OBks2Gn4UgXAA
	 wpxRno05QLkFg==
Received: by pali.im (Postfix)
	id 888B29D2; Wed, 30 Oct 2024 19:34:36 +0100 (CET)
Date: Wed, 30 Oct 2024 19:34:36 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [PATCH 2/2] dell-wmi-base: Handle Win-key Lock/Unlock events
Message-ID: <20241030183436.3w5po6kcg6jmqigb@pali>
References: <20241030181244.3272-2-kuurtb@gmail.com>
 <20241030181532.3594-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030181532.3594-2-kuurtb@gmail.com>
User-Agent: NeoMutt/20180716

On Wednesday 30 October 2024 15:15:33 Kurt Borja wrote:
> Some Alienware devices have a key that locks/unlocks the Win-key. This

Please specify (in comment / commit message) which devices. It would
help other developers in future to track for which device is this event
needed.

> key triggers a WMI event that should be ignored, as it's handled
> internally by the firmware.

Can be this handling in FW ignored? So OS can use this key for any other
functionality?

Anyway, what is that Win-key and its lock?

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/dell-wmi-base.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> index 502783a7a..37fc0371a 100644
> --- a/drivers/platform/x86/dell/dell-wmi-base.c
> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> @@ -80,6 +80,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
>  static const struct key_entry dell_wmi_keymap_type_0000[] = {
>  	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
>  
> +	/* Win-key Lock */
> +	{ KE_IGNORE, 0xe000, {KEY_RESERVED} },

nit: code style: spaces around KEY_RESERVED.

Is not there some better constant for this KEY_*?

> +
> +	/* Win-key Unlock */
> +	{ KE_IGNORE, 0xe001, {KEY_RESERVED} },
> +
>  	/* Key code is followed by brightness level */
>  	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
>  	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },
> -- 
> 2.47.0
> 

