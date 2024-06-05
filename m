Return-Path: <linux-kernel+bounces-203303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA4F8FD926
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C20B25C5E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D820D160780;
	Wed,  5 Jun 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3gmCfXiw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QpnqhJPM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBC527701;
	Wed,  5 Jun 2024 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623272; cv=none; b=GC/rIMWsPYHRtAFKibKbMPHpk03pgCGCEkxN6Dlv+Eeq42wvhEpvLE0B06ricKZiJNO54UyXYcj5cPDLnei4lpPu0Yqr10oNKH8YTjNWV7Sg2YafhVW5RLDpm4MaltBhN/h2ED2WqwrQ6Qlfx3i70QOyRoEvN/cVZNvwpsrOy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623272; c=relaxed/simple;
	bh=yMHImIVxCBBypSOWcx/4rSkwq70FtC2bn0ZTwP0QdSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j0Cp1Lrq+L4XqZ9o0tQKGaBNFCzMCqjfVsfTd0ZcSxUp+q+AWJFJ0gzUTd4Chl1r7bSLoWtxxYPkti1Gs0UYop2fkI41kxCLQyyOgmHfMM1unnWuIdPsOV/AjiGmrwZueGwv4R/2Qy/EUw0piIkgoO39HwtoaS2hkb6G/z1CmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3gmCfXiw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QpnqhJPM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717623269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mHQySYXE8JTB9LD5KNpQxKuCokAcjIhTMOdjiUoSfDc=;
	b=3gmCfXiw4ZNuFxRMRAeMxEd5uCCCvG9PLznx5Cfj0FF0zLT3A3ugkj8hwA8fTkyLNo3Sth
	wQzyPLtIBcVYHdT3GwO/Z1TEHWN8UWcpzvbOOnU/zMNSMtBpz3TZka9IdJTqRwHfwnHYbA
	eD4tc/Lw6A8FSBAKdsRCDWlH6c9CLegIK2XmPUWo8R+64onXEIZX8pnhO7I7c7x92c8dk/
	BO+jSNNhIvkGL5yT5HgEe6PH0vRX54QWRO90Nidt/MJCHHpIZFcglr8Ev1HOeqftefHlQR
	St5qB+Xsnto5UMe9LizV1GNAHK/XBaRcJhus8sgi1zRfKVUy5X5GtaUK2DnsZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717623269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mHQySYXE8JTB9LD5KNpQxKuCokAcjIhTMOdjiUoSfDc=;
	b=QpnqhJPMLhhiS5ZnUufoEddkZhrdbGk9/fmparRsBpvV1R2t54M8quz2P12pZT/cn0Sqgz
	wWDL88mNA9TS9QBA==
To: lakshmi.sowjanya.d@intel.com, giometti@enneenne.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com, pandith.n@intel.com,
 subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com,
 lakshmi.sowjanya.d@intel.com
Subject: Re: [PATCH v9 1/3] pps: generators: Add PPS Generator TIO Driver
In-Reply-To: <20240605153554.11584-2-lakshmi.sowjanya.d@intel.com>
References: <20240605153554.11584-1-lakshmi.sowjanya.d@intel.com>
 <20240605153554.11584-2-lakshmi.sowjanya.d@intel.com>
Date: Wed, 05 Jun 2024 23:34:28 +0200
Message-ID: <871q5b3wgr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 05 2024 at 21:05, lakshmi.sowjanya.d@intel.com wrote:
> +static ssize_t enable_store(struct device *dev, struct device_attribute *attr, const char *buf,
> +			    size_t count)
> +{
> +	struct pps_tio *tio = dev_get_drvdata(dev);
> +	bool enable;
> +	int err;
> +
> +	if (!timekeeping_clocksource_has_base(CSID_X86_ART)) {
> +		dev_err(dev, "PPS cannot be used as clock is not related to ART");

                dev_err_once() if at all

> +		return -EPERM;

Why -EPERM? This has nothing to do with permissions.

ENODEV or ENOTSUPPORTED perhaps.

> +static ssize_t enable_show(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	struct pps_tio *tio = dev_get_drvdata(dev);
> +	u32 ctrl;
> +
> +	ctrl = pps_tio_read(tio, TIOCTL);
> +	ctrl &= TIOCTL_EN;

Why reading the hardware instead of simply using tio->enabled?

> +
> +	return sysfs_emit(buf, "%u\n", ctrl);
> +}

Thanks,

        tglx

