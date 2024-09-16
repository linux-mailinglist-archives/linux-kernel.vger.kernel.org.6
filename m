Return-Path: <linux-kernel+bounces-330426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCD4979E73
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3BF1F22B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A5114A62E;
	Mon, 16 Sep 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0LoAxo0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73961132122
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478863; cv=none; b=lymS843vXZsmoruS0R5R90OpqCWwp72MrQeP/pfsC87jOntzjeTkCtEFHDYyLYwCEKTZBY50t/B/bImiAZtnKX7yEE4+TVayWSAaPXOqkpdh3GWB6kfqshMeyVuVgYdaBqq8Nw7iGZLB+RJ5ucBDL5LcSmdXcSyf23m1D+9+hGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478863; c=relaxed/simple;
	bh=pUAMi86rwTq+wVgJgsM5jMxxeBpOkJO3emrkyOgd2JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK/dzF9tfUpFSAhy3qrqD13zJLFuwN2NBfmPb8q+qrhzhtGilThNn8a207e4MZdeiFqPInRiCmQxCeTOisElgZ+aBgh3RVlm3P/LB5Px1wS2IrHxOEWVYIyXSThcnezYyUEb7C/0+bgxk7Sf0bAgW9WIjQjVYPhAJRjUdhWwBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0LoAxo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04422C4CEC4;
	Mon, 16 Sep 2024 09:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726478862;
	bh=pUAMi86rwTq+wVgJgsM5jMxxeBpOkJO3emrkyOgd2JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0LoAxo0hDsXYtBeVuVt0ft4mZW3HZUYeDl0Q/kED3+MwrED5vAuFGnVpfVemwzM3
	 it+g1Hb+0fpACtumqFcyD/RKJSZMR6uYb5c48nuhJbX0x6JV/C6VsS7KL0sfqpieI+
	 bmE5p4okg2YXdu0WfJktgHa0Dl6pA8JEYhNNxORslZibW5/7KRyDEs55+yQBWjp8f8
	 v+topeF22rxS9vzC5mw+XyOFbivWr8UawD+jIwykyylbSBE882XbA/pWMSHAXc1nzi
	 sPCu3LukN9D5uiohLJRHSSm71FWJbu/HKYxMQpScYdtFjmxK6was6MCNK/o7L3YIeb
	 AXG6+VEs0IccQ==
Date: Mon, 16 Sep 2024 11:27:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Yuesong Li <liyuesong@vivo.com>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, 
	joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com, daniel@ffwll.ch, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drm/i915/dp: Remove double assignment in
 intel_dp_compute_as_sdp()
Message-ID: <thvv6gywqkygj2tcmbnmpwp7opy3nswphc7n3nxdj7r3roshsf@tm4ntfmv7dun>
References: <20240823023612.3027849-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823023612.3027849-1-liyuesong@vivo.com>

Hi Yuesong,

On Fri, Aug 23, 2024 at 10:36:12AM GMT, Yuesong Li wrote:
> cocci report a double assignment warning. 'as_sdp->duration_incr_ms'
> was assigned twice in intel_dp_compute_as_sdp().
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>

reviewed and merged to drm-intel-next.

Thanks,
Andi

