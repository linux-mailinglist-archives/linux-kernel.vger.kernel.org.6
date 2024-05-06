Return-Path: <linux-kernel+bounces-170029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A9D8BD0DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768641C21865
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8373215381B;
	Mon,  6 May 2024 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="egkMcHdm"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92313CFA5
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007444; cv=none; b=f+9hBqKEbA90PGvFSw1peow71fsonsU1TVpsATzNrGCjjqhbb9Vvegp0kJyXo5VsgZ8ncxrvuJJT7EUmfIUYd7z4W1mmv4z33m7UlvdpJjQWcy2EsUBaW5EAKBHtHQOTJVQVFZgf2rUsZxnx75p/ADb/Fu/uwCO1eJGE+umFkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007444; c=relaxed/simple;
	bh=bsMxhpAz1OKLRRZB0ij9rKv9iZ7OIXUETXCxDufQiwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgourAigmua+yoWXEtMRJWtHz/KB4fVX7TKa9+dO+nXdCtD9ci0UjKgrY3CQd/T31uC8aiy5a5BQwgZMfjcIBG6td9RVhAzVPHbCLBigCgQTe8+WjMnfIL6p9PcQudcIzUMDUFelwDUQ0QitvVAuQ+rnGoVKY4xvcuShbuOYPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=egkMcHdm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <97811bfe-a1fb-419c-a148-74e3d84aa0e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715007440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNOU17a7+9y01wIiMXK3gS5QhQyxMPKDGnxAA5DiTWg=;
	b=egkMcHdmBidVkS8JLCA1vU+/AjS9tHSraXTHXo7UrU+0zJAT3oxkNukxv1Ni4xKqK0j/zg
	qfUqyw85DMilp4AFoWiSfC8ec1d41ydAwJN2n7R9h9oD+9L20d597GBfZJJ6pS3FyGl0F3
	TSGRvYRCyv9jt0SWgqQGDw6Hlaojwok=
Date: Mon, 6 May 2024 10:57:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] drm: zynqmp_dp: Lockup in zynqmp_dp_bridge_detect when
 device is unbound
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <4d8f4c9b-2efb-4774-9a37-2f257f79b2c9@linux.dev>
 <20240504122118.GB24548@pendragon.ideasonboard.com>
 <20240506-charcoal-griffin-of-tact-174dde@houat>
 <20240506073531.GA10260@pendragon.ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240506073531.GA10260@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/6/24 03:35, Laurent Pinchart wrote:
> On Mon, May 06, 2024 at 09:29:36AM +0200, Maxime Ripard wrote:
>> Hi Laurent, Sean,
>> 
>> On Sat, May 04, 2024 at 03:21:18PM GMT, Laurent Pinchart wrote:
>> > On Fri, May 03, 2024 at 05:54:32PM -0400, Sean Anderson wrote:
>> > > I have discovered a bug in the displayport driver on drm-misc-next. To
>> > > trigger it, run
>> > > 
>> > > echo fd4a0000.display > /sys/bus/platform/drivers/zynqmp-dpsub/unbind
>> > > 
>> > > The system will become unresponsive and (after a bit) splat with a hard
>> > > LOCKUP. One core will be unresponsive at the first zynqmp_dp_read in
>> > > zynqmp_dp_bridge_detect.
>> > > 
>> > > I believe the issue is due the registers being unmapped and the block
>> > > put into reset in zynqmp_dp_remove instead of zynqmp_dpsub_release.
>> > 
>> > That is on purpose. Drivers are not allowed to access the device at all
>> > after .remove() returns.
>> 
>> It's not "on purpose" no. Drivers indeed are not allowed to access the
>> device after remove, but the kernel shouldn't crash. This is exactly
>> why we have drm_dev_enter / drm_dev_exit.
> 
> I didn't mean the crash was on purpose :-) It's the registers being
> unmapped that is, as nothing should touch those registers after
> .remove() returns.

OK, so then we need to have some kind of flag in the driver or in the drm
subsystem so we know not to access those registers.

--Sean


