Return-Path: <linux-kernel+bounces-212607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBB69063E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F67C1C21984
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42794137750;
	Thu, 13 Jun 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gx17ErcU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E11369BC;
	Thu, 13 Jun 2024 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259383; cv=none; b=I8CIC/Q8tQVDvWlLIFb3Wlif3TZuJLsR+N0aaVGRbkS/rnH3zS0Pn9CBmBndOcSkzYQX9AzH4b7t9ubh7z+XAjRgAj0nWNhreDaOlspvLo/5Bi8hCeGDpBq7mALGk3G28eiyE4zgCT3uWnCZCcNzMorWr4zUc6J8yd/zi6thRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259383; c=relaxed/simple;
	bh=gGtIVYGg22wLtYzNDK/SjLScQH7VyamnEbat5FMLgyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rY+IIbpevSrb59Uu9zHpZV8I+BCqQN8MinU9mh8nAa9MfzD9dmDkoGh8SegT4waFxZyTNtAFfkT0kzHI+AfakbPgbUKnlV2A6naZhKlNqZxpE3y/tEw9MjuAfA8XaGaEqMCseT6PAr0kdVDBtWzdgjebrKQvzkuPXw/GuESSPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gx17ErcU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718259382; x=1749795382;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gGtIVYGg22wLtYzNDK/SjLScQH7VyamnEbat5FMLgyk=;
  b=gx17ErcUlw/pjo9HfhuNO/F309quZPMiTX8tZ0W0u3aAy6ymLonA6pEg
   RlTT8hbGx+u6XyAW2Ycvvrj2PzJ5EqMI24Twe+DxCpUjgiMw//lQ7kCri
   E9qUTWdPKQ4AQI/Sx3HAIsKi2K8cuVeZkq2HDNdtO9qf/D65yasUsa/W0
   P7vPx+gEzTv9pIVd/7PKoOckxeRygG7AgYOHvDoQSKNqDolfTlETbF9hh
   fRRYYHu3NwhC4hFmhkaqSlQH5eKZRwrEIQcdlGlBjg628/UK1HHjGTWy3
   NINckoxYvHmMqF3eMCst/SOtA9zvP4/WMKaN0llX5CTolKDy2iZBKx5/i
   g==;
X-CSE-ConnectionGUID: ZTZjNM+0S7OVg6oAyF/oag==
X-CSE-MsgGUID: 6/OgpurdTj6CzImb+3FmsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15022951"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15022951"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:16:22 -0700
X-CSE-ConnectionGUID: MgXS/vLmTcafwv7Jw1NbKQ==
X-CSE-MsgGUID: hY+fhsZTR1ujavD+nYkliA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="71236673"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:16:17 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danny Lin <danny@kdrag0n.dev>,
 =?utf-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>, =?utf-8?Q?Micka?=
 =?utf-8?Q?=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v2] .editorconfig: remove trim_trailing_whitespace option
In-Reply-To: <2024061137-jawless-dipped-e789@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <2024061137-jawless-dipped-e789@gregkh>
Date: Thu, 13 Jun 2024 09:16:14 +0300
Message-ID: <877cetjrkh.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 11 Jun 2024, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> Some editors (like the vim variants), when seeing "trim_whitespace"
> decide to do just that for all of the whitespace in the file you are
> saving, even if it is not on a line that you have modified.  This plays
> havoc with diffs and is NOT something that should be intended.
>
> As the "only trim whitespace on modified files" is not part of the

Do you mean s/files/lines/?

BR,
Jani.

> editorconfig standard yet, just delete these lines from the
> .editorconfig file so that we don't end up with diffs that are
> automatically rejected by maintainers for containing things they
> shouldn't.

-- 
Jani Nikula, Intel

