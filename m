Return-Path: <linux-kernel+bounces-529440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E589A42633
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A7A17B324
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB423BCED;
	Mon, 24 Feb 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gE7TL+3W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7B19E997;
	Mon, 24 Feb 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410254; cv=none; b=Z/IhfBU51wmOfaDXTlNz+nqCjt/yip46dDDbjvTHMsTcUzJoMHuYaVYd5iBREsUh3cyRbNWhuulNNzO1eacq2Kg6g8nGsjo1tDeKc42WRoyfCOI3YYK4lpE4tAlVsB8rJsq0hdHFN5larSb/zOv7CzM9VnYO6Uo9tyfqt4A5+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410254; c=relaxed/simple;
	bh=I7YNGRoxnFVBbnqodAXMukrs4gEkMCo/ek0sM8LPlcU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gPW6xVQcqirH9HcgrHl+5ymPV2gEofpfBtPA148+gT0mIaxdA8Esa5r+N/q4u/IavKp055sEmT+JoJmM9co2A6hJyFF0n9YbQgozWGRsMpXETMgWyS9zC87eYSewMOB0JR/wKveL+q9k4oyT1ZIyMUX2c7Nl75lGEO8ZBrQCQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gE7TL+3W; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740410253; x=1771946253;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=I7YNGRoxnFVBbnqodAXMukrs4gEkMCo/ek0sM8LPlcU=;
  b=gE7TL+3WoVL2sxkur3rsS+C1RPB0KWaFOEQK2he4S+nFmvoakWIcJ4Tv
   HdlidmrNxSICVHFf6FLyDSSXdBqbqVjgJW8NjXlXXd7SHibIQ6t2Ln2fT
   DshbHbw4qUGnkezKf5hCj82RdZFjuKTwGxCukuJfHOslNRurDGo3e7JWv
   SVfPNB7I/EhtPLNseUhXAtMF8yyfYXMbSeRyTJhPMQrPow9P9ZfTp6Prn
   hyijAtFlLgx57giWZsCE5hppT9yIoIrsI0WgGSIcqYDX5sbLmdC3VaAdr
   aEmSqFBFoWb8xG7NjwbRE8F+l7uJsKIzeCIf+Z5GgkHyS9FgU4OhOPOYN
   Q==;
X-CSE-ConnectionGUID: Sr6rc/JeQQGnEHNDZ+4iNA==
X-CSE-MsgGUID: Se+ZVeXcQZOwUB8a4iZ2nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="52160666"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="52160666"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:17:32 -0800
X-CSE-ConnectionGUID: hSckPibkQ1WxnCs5CMQu7w==
X-CSE-MsgGUID: Jzf1otwiQCaHvLZW4QkWbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="121180754"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.233])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:17:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, Kurt Borja <kuurtb@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250215000302.19753-1-kuurtb@gmail.com>
References: <20250215000302.19753-1-kuurtb@gmail.com>
Subject: Re: [PATCH 0/2] platform/x86: thinkpad_acpi: Enable devres for
 subdriver .init callbacks
Message-Id: <174041024615.15708.13316417401845516527.b4-ty@linux.intel.com>
Date: Mon, 24 Feb 2025 17:17:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 14 Feb 2025 19:03:00 -0500, Kurt Borja wrote:

> It was reported by Mark [1] that if subdrivers used devres, the
> tpacpi_pdev wouldn't bind successfully to the device, thus failing to
> create the various sysfs attributes that this driver exposes.
> 
> The original problem is already fixed, however a complete solution was
> due.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: thinkpad_acpi: Move subdriver initialization to tpacpi_pdriver's probe.
      commit: 38b9ab80db31cf993a8f3ab2baf772083b62ca6f
[2/2] platform/x86: thinkpad_acpi: Move HWMON initialization to tpacpi_hwmon_pdriver's probe
      commit: 43fc63a1e8f6db7148f9cfcddda539c3437bc6c2

--
 i.


