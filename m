Return-Path: <linux-kernel+bounces-572531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C07A6CB26
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E584801E2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7898230270;
	Sat, 22 Mar 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="t0q7bNKk"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D729A9;
	Sat, 22 Mar 2025 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742656992; cv=none; b=T2wbVwpQNHVMfORFgEXYwQiNMWjw5FhUWZCIhuMjnOLAb/WnxQxYjXAdKMzuKcO+hLi+JsFb55OCvuYuc9eBuQGMxHbIGnU9HiL/kmiww7sJcrRMuIOlBSFxUVY+UeJzUFtdeGwPN9yl/UIy02etBJ9e+LM7BQcrVHlFY/pO4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742656992; c=relaxed/simple;
	bh=rPuK3FBZ0Pg5TMPok6C26mXt6MVvMYdW5NMwzIfayRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpmLkS7Lfba3R7SJ3AK9umdpHkRMEX3djOi8j1mN69ZDCSPF0gNw8EG8w/VHzjW37ThlYuitp5axR7iXZwS5Yeuvc5SvW7uwhit2/wvoYZnCh/8uvZmYhYDATjJmP9VET/Jx2UgY3uq2SmD1f1EguQ59g2+S0bAKE2LhzRLRL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=t0q7bNKk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742656985;
	bh=rPuK3FBZ0Pg5TMPok6C26mXt6MVvMYdW5NMwzIfayRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t0q7bNKkstXGZU5/gOev7hhE6ZjNyck981LEGWfLVbr9UeA9ZhZ7DqKRoSoK3z0qn
	 xUelJT95rbIcaKlKQz5x9PJEZUw7p+vc3F04DWN9T9C1X1Y6Z8N+7nkKxFxre2p5Qj
	 bbHdHyTyFJq2ESMRFspJBSLZsatrXxeJJWfntpgI=
Date: Sat, 22 Mar 2025 16:23:05 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sung-Chi Li <lschyi@chromium.org>, Jean Delvare <jdelvare@suse.com>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (cros_ec) Add set and get target fan RPM
 function
Message-ID: <780ce6e8-11fc-42be-b4a7-9cffbf811d78@t-8ch.de>
References: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>
 <e4da28be-66ca-45d3-9ccf-34819460b463@t-8ch.de>
 <f50221fd-1d76-465b-ba53-62c08c6f8536@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f50221fd-1d76-465b-ba53-62c08c6f8536@roeck-us.net>

On 2025-03-22 07:12:48-0700, Guenter Roeck wrote:
> On 3/22/25 06:55, Thomas Weißschuh wrote:
> > On 2025-03-18 15:45:23+0800, Sung-Chi Li wrote:
> > > The ChromeOS embedded controller (EC) supports closed loop fan speed
> > > control, so add the fan target attribute under hwmon framework, such
> > > that kernel can expose reading and specifying the desired fan RPM for
> > > fans connected to the EC.
> > > 
> > > When probing the cros_ec hwmon module, we also check the supported
> > > command version of setting target fan RPM. This commit implements the
> > > version 0 of getting the target fan RPM, which can only read the target
> > > RPM of the first fan. This commit also implements the version 1 of
> > > setting the target fan RPM to each fan respectively.
> > > 
> > > Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> > > ---
> > > ChromeOS embedded controller (EC) supports closed-loop fan control. We
> > > anticipate to have the fan related control from the kernel side, so this
> > > series register the HWMON_F_TARGET attribute, and implement the read and
> > > write function for setting/reading the target fan RPM from the EC side.
> > 
> > Should it be possible to switch back to automatic control?
> > I can't find anything in the hwmon ABI about it.
> > And neither in the CrOS EC source.
> > 
> > Am I missing something?
> > 
> 
> Not sure I understand the context, but the fan control method is normally
> selected with pwmX_enable, which is defined as
> 
>                 Fan speed control method:
> 
>                 - 0: no fan speed control (i.e. fan at full speed)
>                 - 1: manual fan speed control enabled (using `pwmY`)
>                 - 2+: automatic fan speed control enabled

So far I associated pwmY_enable = 1 with the pwmY attribute.
Also controlling it through fanY_target does make sense though.
It could be clearer from the docs IMHO.

That also means that the patch under discussion needs to implement the
pwmY_enable attribute.

One more thing I have wondered about before:
Is pwmY always refering to the same thing as the matching fanY?


Thanks,
Thomas

