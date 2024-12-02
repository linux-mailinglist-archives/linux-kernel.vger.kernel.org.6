Return-Path: <linux-kernel+bounces-428058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC69E0997
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989CD16275E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AC01DE4D4;
	Mon,  2 Dec 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyRBArSf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200B1DAC9B;
	Mon,  2 Dec 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159588; cv=none; b=FskJePaPHczpzYv2end4+tBdYixQn0PJykWCYADVXrbWZVH2VfFQqpIg+eX31+c84mQYvU/jcZ52/Tz4gdcc3o+iQiOAbE59TKEIXacgh3gZ7nRYWtsymRlSS7SiklBYOA1cRGxZT2+1dp7I4+8989czZ7Etat+1aDKhrh/tj+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159588; c=relaxed/simple;
	bh=9bJBRy5It78VB1UqnTta683nxpfWqEsTvaLjR+VFMAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZbUyf7E1GFxNl+hQCXS+UjLtSMcEXwrI4mDkTLUTSzqZeL7nfCFhstqwQkbQen2AmMWJKliDCqOAZ61c+H+LB6hvuICv8YRjt7fFlAIIbtSy7UTKkdrkD1kLSb0oyHTMphalw8oLqXUZp9wMe6WsAotHJwxm9fVP/HSnw6/ehlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyRBArSf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733159587; x=1764695587;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=9bJBRy5It78VB1UqnTta683nxpfWqEsTvaLjR+VFMAY=;
  b=AyRBArSfuLVZ19up6I4wDkUxefmZqV38snFa4A6w3vtzOXzWu79hzrNk
   fpMphU1cG3J4SQ37lfayzp9NH3gCn5KOTQkdy0RuVZdcHBoVzj12ycSpP
   0wyig2LOkUBTX/zJO6rwQmYbLiKskOhuNdsmrF1SkRbnHO5Gpz0PJV2rk
   sTdD1YPxeAJ1zYYSFrJ+Gd7UwYkMQRlUB732okUdo0yUSdt4OFZehuL4+
   dQmD9FmtTBdo8iviaLbHpzjTiGu5Clg3z+4mMmJ5vnLwWgsWiZqT5yO+B
   IWYxXszXYnbeJdRerPaoAiOSOcWzND4Gg7HoonXlnCt2+AwHIizaKTGUj
   A==;
X-CSE-ConnectionGUID: uX9i0k/gRc+WU4gmABmbAA==
X-CSE-MsgGUID: aR2gDNU0SbuQW0YT6dH4Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50753056"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="50753056"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:13:06 -0800
X-CSE-ConnectionGUID: mXfVtylmRaGb7pJY3RpXzg==
X-CSE-MsgGUID: i3jT/4fuTUuZztmYOGN+pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="97942563"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.61])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:13:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jonathan Woithe <jwoithe@just42.net>, 
 Hans de Goede <hdegoede@redhat.com>, Abdul Rahim <abdul.rahim@myyahoo.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241127203710.36425-1-abdul.rahim@myyahoo.com>
References: <20241127203710.36425-1-abdul.rahim.ref@myyahoo.com>
 <20241127203710.36425-1-abdul.rahim@myyahoo.com>
Subject: Re: [PATCH] fujitsu-laptop: replace strcpy -> strscpy
Message-Id: <173315957955.13969.1185838423270476471.b4-ty@linux.intel.com>
Date: Mon, 02 Dec 2024 19:12:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 28 Nov 2024 02:07:07 +0530, Abdul Rahim wrote:

> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors.[1]
> 
> [1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> 
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] fujitsu-laptop: replace strcpy -> strscpy
      commit: 0ffafd4a3b39b341a4d7d73df34ab3b2c07a26c0

--
 i.


