Return-Path: <linux-kernel+bounces-197147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6CA8D66CC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFAD1C245B4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318E3161B4D;
	Fri, 31 May 2024 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CIkuXHSc"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58A158869
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172860; cv=none; b=LwpTVyEIJkBObW3naW7iMMg6RjkpfAAY/qANjyI+2RWjyfZML2vM9BwExmQ+1KJUfR+YrK/xpnfM8ndR7M8GnJlve+4CKZs4Smk5QXFHq5iBTLtQ82Ybo87SDmXJVVGq3D77+N0NIUtFf/X4mbPG2e15ukmFQDjvbymPWCrBZ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172860; c=relaxed/simple;
	bh=9swJqY8JBW10RvsDN1Qkqc9h0G1Fop/MrT44Eibb3rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTCLnPmmggpWufQo8ovdXAz6bv0bOdeuBxJyHuLynbpfDhGCq9WWVI/cwB81hf2EV0Ut3LxHMtYHPs8rIyQ2uxNeLRbiK45NXnj8cKSNR4JKkUMVEwO3GT/iFuR2daSc3FMiu8KEyzhnzE58IFJ4gM5khKLAe8zfAmbpEO/RBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CIkuXHSc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: laurent.pinchart@ideasonboard.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717172856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uv7gNDMkqzsIKclSBJRKfUZk9Zpd2hU6CV4axNOS95g=;
	b=CIkuXHSc9+HMumm/A8nQ+bocPbkN6VYJXUPFdVWMc9tbE9VZ5BVWWL0jNq0yKiiswM/tNR
	nEx+XZ787WUW2UNw3Y1c9AAHMCp+tkkAdSw7aBARksgtH9hthAP0VMGmLA0RNhNyX6mQ6n
	QmruA3hcyrE1KhRACb+UoZT7Fi/e5B4=
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: airlied@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: tomi.valkeinen@ideasonboard.com
X-Envelope-To: michal.simek@amd.com
Message-ID: <5ef45215-e1c3-4f65-bbb6-26ab690d2f1a@linux.dev>
Date: Fri, 31 May 2024 12:27:31 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 00/10] drm: zynqmp_dp: IRQ cleanups and debugfs support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>
References: <20240503192922.2172314-1-sean.anderson@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240503192922.2172314-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/3/24 15:29, Sean Anderson wrote:
> This series cleans up the zyqnmp_dp IRQ and locking situation. Once
> that's done, it adds debugfs support. The intent is to enable compliance
> testing or to help debug signal-integrity issues.
> 
> Last time I discussed converting the HPD work(s) to a threaded IRQ. I
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
> Changes in v5:
> - Fix AUX bus not getting unregistered
> - Rebase onto drm-misc/drm-misc-next
> 
> Changes in v4:
> - Rebase onto drm/drm-next
> 
> Changes in v3:
> - Don't delay work
> - Convert to a hard IRQ
> - Use AUX IRQs instead of polling
> - Take dp->lock in zynqmp_dp_hpd_work_func
> 
> Changes in v2:
> - Rearrange zynqmp_dp for better padding
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
> Sean Anderson (10):
>   drm: zynqmp_kms: Fix AUX bus not getting unregistered
>   drm: zynqmp_dp: Rearrange zynqmp_dp for better padding
>   drm: zynqmp_dp: Don't delay work
>   drm: zynqmp_dp: Add locking
>   drm: zynqmp_dp: Don't retrain the link in our IRQ
>   drm: zynqmp_dp: Convert to a hard IRQ
>   drm: zynqmp_dp: Use AUX IRQs instead of polling
>   drm: zynqmp_dp: Split off several helper functions
>   drm: zynqmp_dp: Take dp->lock in zynqmp_dp_hpd_work_func
>   drm: zynqmp_dp: Add debugfs interface for compliance testing
> 
>  Documentation/gpu/drivers.rst     |   1 +
>  Documentation/gpu/zynqmp.rst      | 149 +++++
>  MAINTAINERS                       |   1 +
>  drivers/gpu/drm/xlnx/zynqmp_dp.c  | 883 +++++++++++++++++++++++++++---
>  drivers/gpu/drm/xlnx/zynqmp_kms.c |  12 +-
>  5 files changed, 977 insertions(+), 69 deletions(-)
>  create mode 100644 Documentation/gpu/zynqmp.rst
> 

ping

--Sean

