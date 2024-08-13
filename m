Return-Path: <linux-kernel+bounces-284309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D120F94FFB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD63D1C22EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A511617E44F;
	Tue, 13 Aug 2024 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJ7VwT8A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254A1386C0;
	Tue, 13 Aug 2024 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537303; cv=none; b=MAzj4tBD9vRXgZBq5NqLZfCXYFEcm2MTD1yleu+S2gi63f1ChCH0fuIw8fT2gJW2fy0ILeFmI/ftAfHZpVj/gRiLmx5a8qKJ5XyGaK7jW8JPbZHyUFWqgZ/w0MD82e7W2bAwKo6cU+HQr1jkuUQYtugwZgtIM64M1u9pInFqXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537303; c=relaxed/simple;
	bh=oOSr3gXJPIC/xWEGzNra84snyeEZDPrEg0kosMOpjWY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s0nzRDT7JcUfY3oHPml79+uVItHSgpyy1E0MPeV77TADsGMmSbtb5JBzBY3KozeVaGLgzT1QamTJQ1pNlGTUNPD85QXAn5hC4eQ9XwFssliVn4RTyZ/8y42vVQHN43WwelHnm1NvHIKkFLK9ME6S70ICl5BTgtvm/QmPtGSdGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJ7VwT8A; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723537301; x=1755073301;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=oOSr3gXJPIC/xWEGzNra84snyeEZDPrEg0kosMOpjWY=;
  b=nJ7VwT8A85mlNUg8pLhat1Jhp23BxKm/45AuXfok+ilGYnZDUwLWLbQB
   N6ZNXTqymvg4g1CKB/OFroY76yYC7UvvXEGcz2MLtHyL7kD2hibEDdoDQ
   7tHfB2gwmGvM581p4x8XjH83OzbSLDn+++rfi6L6jaOdk4rD1LaIDuD05
   b8S0guhxrKWHz4uwZGYwZ+6pYwXN0qSTP2ZTkow2llirIZfqJTyHhnOxM
   x7TruUrGmjC++o3vC2U4W0Ri76PFZS8Pke0WXi41ZdVCAJsBVFlpSw4AP
   zsQAwbGV+RjmA4j7loaeFpeEdUgun3z7l3Bq+osWb2zuiv6Demg68nNbu
   w==;
X-CSE-ConnectionGUID: tIbLIRzCRSyg4Z3yJESiBQ==
X-CSE-MsgGUID: LEUEKu5SS2muYE+4y1vhQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21853077"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21853077"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:21:39 -0700
X-CSE-ConnectionGUID: 3sMQ2O8XRbqu9KYPtJuTPw==
X-CSE-MsgGUID: do4PxVbLQOCE95G7MUmt6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58541968"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:21:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Maximilian Luz <luzmaximilian@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240811124645.246016-1-luzmaximilian@gmail.com>
References: <20240811124645.246016-1-luzmaximilian@gmail.com>
Subject: Re: [PATCH] platform/surface: aggregator: Fix warning when
 controller is destroyed in probe
Message-Id: <172353729019.2056.10875402139846681143.b4-ty@linux.intel.com>
Date: Tue, 13 Aug 2024 11:21:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 11 Aug 2024 14:46:44 +0200, Maximilian Luz wrote:

> There is a small window in ssam_serial_hub_probe() where the controller
> is initialized but has not been started yet. Specifically, between
> ssam_controller_init() and ssam_controller_start(). Any failure in this
> window, for example caused by a failure of serdev_device_open(),
> currently results in an incorrect warning being emitted.
> 
> In particular, any failure in this window results in the controller
> being destroyed via ssam_controller_destroy(). This function checks the
> state of the controller and, in an attempt to validate that the
> controller has been cleanly shut down before we try and deallocate any
> resources, emits a warning if that state is not SSAM_CONTROLLER_STOPPED.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/surface: aggregator: Fix warning when controller is destroyed in probe
      commit: bc923d594db21bee0ead128eb4bb78f7e77467a4

--
 i.


