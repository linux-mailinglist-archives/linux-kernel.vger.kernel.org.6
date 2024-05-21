Return-Path: <linux-kernel+bounces-184751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF378CAB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C86C1C219BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4FC6D1D2;
	Tue, 21 May 2024 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="El4DwKT/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206A6CDA9;
	Tue, 21 May 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285981; cv=none; b=PmT6cZxjwDd5u8aUh6LsTCXlL74wEvHbHLgW2cxBhptwMGoZQQPNMpzM41VkM8GMmEy4yWFmXKsio6q4Qhi1hJlniU9k1ZWLatWf/CHUh0HEmQjgDWmmlpxe5dq/qpuPedZvU14wRL5fQYJkKVrizrM+PzunSNI6ObU7DDQYxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285981; c=relaxed/simple;
	bh=+vjdGl/tKKsIdLFQbXKLivW1r7u2/NUdIM52A3fWY44=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L41k5Jvgrpl8/WB8/Xul0DdfWNBEntGErp0LGYXXBiERLMVrGcrTuGKqhfhE157IT0kQ0nm5kkVAwMFr6rzj1lW4KH7jUdRSAGbtnx/fv77Ubn/ZgTNnWq9fRbKLtIisQ8F5I+KIxZz7ou0TZ4TJcv4QakPEljUQdo4xVn9sXtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=El4DwKT/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716285980; x=1747821980;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=+vjdGl/tKKsIdLFQbXKLivW1r7u2/NUdIM52A3fWY44=;
  b=El4DwKT/Tv4Wkl3eFg2AL1QAbFqYUdxEPUejVszycr8eIgbi52/XIMZc
   zopcQTeY/F/xT7CEKtVr37F0M6+cHysKH9UnO951TbARoEWMW5CfoXkRb
   fU6pe6MIldN9CRrr+fZQGSWihVbAynUWyKAGrReKbk78YKQlSYBcGCfYw
   rH2xzG8HtNB4AHvvTE5NSoECDOSX9l0QFAIGOpI7SITJEwcyCxMDuCOzg
   LbEnX/Iq6GnSTmJd0vmM4nnWQ+KdwVWc89nWmaZmPG6sZgYFioFuSYpi0
   QJhPYfTttT+IRl4ooBKCbZI/kciJp6UlAXgY/6MKosyFUA0afsmpwex2f
   g==;
X-CSE-ConnectionGUID: PBC2vmqtRhKc9lL5aUOtag==
X-CSE-MsgGUID: OmNfA2CiRieXyqfKuz+x3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23067399"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="23067399"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 03:06:19 -0700
X-CSE-ConnectionGUID: 3vMrjM31QMSOrua434uyRw==
X-CSE-MsgGUID: L43b2EtyQumh1LIylzF27A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="70283266"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 03:06:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 May 2024 13:06:11 +0300 (EEST)
To: Markus Elfring <Markus.Elfring@web.de>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
    platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    Dan Carpenter <error27@gmail.com>
Subject: Re: [v2] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
In-Reply-To: <51368bcf-d2e3-42cc-a112-a1a485f29c73@web.de>
Message-ID: <a8eb3ba6-eeab-6c0c-7b57-4fde508853ed@linux.intel.com>
References: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com> <d5203ff5-8ed4-48ea-8e58-a2e6680b0542@web.de> <6d1bf351-77cc-7fe9-2d62-8bd99789e4f1@linux.intel.com> <d73fe99b-dea3-4792-aa1c-c3317f296003@web.de> <5287fc2e-91c5-442b-b66c-6eb1fe334ce4@redhat.com>
 <51368bcf-d2e3-42cc-a112-a1a485f29c73@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2126140094-1716285753=:1027"
Content-ID: <73fe5b09-d14a-6e05-f359-409948eb0554@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2126140094-1716285753=:1027
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <665ca344-ac2c-979a-bbcb-5839511e72c4@linux.intel.com>

On Tue, 21 May 2024, Markus Elfring wrote:

> >>>> =E2=80=A6
> >>>>> Fix this by reordering the kfree() post the dereference.
> =E2=80=A6
> > The original wording of the commit message really is fine as is,
> > I see no need for Harshit to send a new version and I plan to
> > merge this as is.
>=20
> Are there opportunities remaining to improve the discussed wording?
>=20
> 1. https://en.wiktionary.org/wiki/post#Etymology_1
>=20
> 2. https://en.wiktionary.org/wiki/reorder
>=20
> 3. Function call indication?
>    https://elixir.bootlin.com/linux/v6.9.1/source/mm/slub.c#L4371
>=20
> 4. Rephrasing of =E2=80=9CFix this by =E2=80=A6=E2=80=9D?
>=20
> 5. https://en.wikipedia.org/wiki/Dangling_pointer#Cause_of_dangling_point=
ers
>=20
> 6. https://wiki.sei.cmu.edu/confluence/display/c/MEM30-C.+Do+not+access+f=
reed+memory#MEM30C.Donotaccessfreedmemory-AutomatedDetection
>=20
> 7. https://en.wikipedia.org/wiki/Code_sanitizer#KernelAddressSanitizer

We'll not waste our time in wordsmithing commit messages to perfection,=20
the current one is good enough as was stated to you already.

--=20
 i.
--8323328-2126140094-1716285753=:1027--

