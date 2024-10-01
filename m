Return-Path: <linux-kernel+bounces-346512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8398C56D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5E728763C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C161CDA04;
	Tue,  1 Oct 2024 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u4qt7krl"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C4E1CCB45
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807499; cv=none; b=dg2BOLcDiGoLJA6/Vg/D82Vb2KASoYnVQHmiTCqXGEFDS6K2YnXuTr4cDDqiRoINid4qiv9UJyr1+XwncfaWUaTFyFJKUcZqn8odgLuDhcNZoYsMhIy5458Y527ysm3m/Fgxxr9EXynmiBF8VjWGuCRPva53j69A83u57ie13C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807499; c=relaxed/simple;
	bh=GiiQIgUNSgBZNIY1gm221iLWXTA+/0TqMZxTxfL8/GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tts9uYqkp3AS3WqSni7TCy3XDkWXPDgL+rZ+vZSIY4ZzptTZFj909JyGFzpZkLxsvUfbr7Q1ozynraY+8NT20I2RDnqdyrEMLXwYLo+ecu6wHPKzssus0kRnpWS0dSVO1OKqEvI5KVH4d5+WXcb/Z14lkI8RmCW1envrbB8LRB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u4qt7krl; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e9769dd-459a-4ff3-aebb-bb7057192733@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727807494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlcHKQwn5L21aymtnarukq/iOfnG9kcJ0DkEr1DK1Lo=;
	b=u4qt7krlAH/WlmjcZxvGLaQuYPDvn//4i6Oj/BnHRm8F9LMSa8bxOvbXzLTd15EZ7pnktz
	CoUGfmRaSPfhfXCrWvCV2avcLd2CdV7WT9RjdlEzx+UjfPGq3NmOMI1cRge27qBplGZFxd
	kkF/hsu2qHQr3beT6mNTTr1uMQ7EYVU=
Date: Tue, 1 Oct 2024 14:31:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 0/8] drm: zynqmp_dp: IRQ cleanups and debugfs support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 David Airlie <airlied@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
References: <20240809193600.3360015-1-sean.anderson@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240809193600.3360015-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/9/24 15:35, Sean Anderson wrote:
> This series cleans up the zyqnmp_dp IRQ and locking situation. Once
> that's done, it adds debugfs support. The intent is to enable compliance
> testing or to help debug signal-integrity issues.
> 
> Previously, I discussed converting the HPD work(s) to a threaded IRQ. I
> did not end up doing that for this series since the steps would be
> 
> - Add locking
> - Move link retraining to a work function
> - Harden the IRQ
> - Merge the works into a threaded IRQ (omitted)
> 
> Which with the exception of the final step is the same as leaving those
> works as-is. Conversion to a threaded IRQ can be done as a follow-up.
> 
> Changes in v6:
> - Unplug DRM device before removal
> - Fix hang upon driver removal
> - Rebase onto drm-misc/drm-misc-next
> 
> Changes in v5:
> - Rebase onto drm-misc/drm-misc-next
> 
> Changes in v4:
> - Rebase onto drm/drm-next
> 
> Changes in v3:
> - Convert to a hard IRQ
> - Use AUX IRQs instead of polling
> - Take dp->lock in zynqmp_dp_hpd_work_func
> 
> Changes in v2:
> - Split off the HPD IRQ work into another commit
> - Expand the commit message
> - Document hpd_irq_work
> - Document debugfs files
> - Add ignore_aux_errors and ignore_hpd debugfs files to replace earlier
>   implicit functionality
> - Attempt to fix unreproducable, spurious build warning
> - Drop "Optionally ignore DPCD errors" in favor of a debugfs file
>   directly affecting zynqmp_dp_aux_transfer.
> 
> Sean Anderson (8):
>   drm: zynqmp_kms: Unplug DRM device before removal
>   drm: zynqmp_dp: Add locking
>   drm: zynqmp_dp: Don't retrain the link in our IRQ
>   drm: zynqmp_dp: Convert to a hard IRQ
>   drm: zynqmp_dp: Use AUX IRQs instead of polling
>   drm: zynqmp_dp: Split off several helper functions
>   drm: zynqmp_dp: Take dp->lock in zynqmp_dp_hpd_work_func
>   drm: zynqmp_dp: Add debugfs interface for compliance testing
> 
>  Documentation/gpu/drivers.rst     |   1 +
>  Documentation/gpu/zynqmp.rst      | 149 ++++++
>  MAINTAINERS                       |   1 +
>  drivers/gpu/drm/xlnx/zynqmp_dp.c  | 846 ++++++++++++++++++++++++++++--
>  drivers/gpu/drm/xlnx/zynqmp_kms.c |   2 +-
>  5 files changed, 951 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/gpu/zynqmp.rst
> 

ping

--Sean

