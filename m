Return-Path: <linux-kernel+bounces-203330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4278FD991
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190A81C223FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E00A15F336;
	Wed,  5 Jun 2024 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QR+g3/nb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4A3B1AB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717625031; cv=none; b=m7fo2jskg7/rEVzOZ/oQmZGJiHFFvzY8A6o6KbIaELPVrTZiTUS5PriQ5E3w0h5cfFp2pDE7N9rbm4invc7XkgUsgcSJdzO5SUS+iSs71+j397hbb1O5T7b28TqJV/iuZr5wZ8kyv4XbN0i6F3vQdkkweFEacBwhFfNHoy4xgFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717625031; c=relaxed/simple;
	bh=vXVTJl+1mt0p0C7KaOtF/dBnnpCDVme0dzPTFHZo2AY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQf0am8E59uyAJZHngnBF8joxDOm6R2DomDAlPCyB6TJT+3ifxoOIUhKtjvqTnIEy9F+bQ79rn0LMWbxdpahDEBp23dyMV9st7LkhIP8aCq3R1m6X1gc3i7nJF31jYOGaLqNCYsXwPnrl0WDIgxiDd/xTDcThMCkeEcYIdRXgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QR+g3/nb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717625030; x=1749161030;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=vXVTJl+1mt0p0C7KaOtF/dBnnpCDVme0dzPTFHZo2AY=;
  b=QR+g3/nbeGYCV6R8rLQL4nVNIT5R8pG5A2RGy5BycOLPEbgtoMxBeYG5
   roJZYzmMzhOekKU67+t6pk48Qo6mJ2p2uAjMkrPLDmG2urRZNVCRDMpTj
   od66D9jK0tI7+qatI2ku1AiUcwMVTIJFA1K5BHEGTfV0IHd5DMi15cCbx
   lNS4JKEYbrvWJGCxtWzvaErXhACAooqswThqHwkuC/N197+FvC8/bX6D5
   C2VYgdMb5u6KPrRriFG70jXVeKfwTnSdvurex+Wc+V3cIEJxR5kD5yjVd
   Gm+Tmqh61DMzs/u6qUASVwSxMVJq3JyL3Jj27rEjLQMC0jlf5vdnk4hFN
   A==;
X-CSE-ConnectionGUID: iytunz8eRe2rsvuX7pKnVQ==
X-CSE-MsgGUID: fbvAK0MwS0W8XoZ+Hr3jFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24918447"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="24918447"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 15:03:49 -0700
X-CSE-ConnectionGUID: +Dih5inJQR21GUZkoKeF3w==
X-CSE-MsgGUID: xnCGZDhpRoavJ0PbnJwegQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="75210673"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 15:03:49 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Sasha Neftin
 <sasha.neftin@intel.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 vinschen@redhat.com, hkelam@marvell.com, naamax.meir@linux.intel.com,
 anthony.l.nguyen@intel.com, "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
 "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] 6.10; regression; bisected - commit
 86167183a17e cause info msg "trying to register non-static key"
In-Reply-To: <CABXGCsPAdzVnSpT65NkMTi=jS1c0-bz=2XjnZWUkOxhrnkpgEQ@mail.gmail.com>
References: <CABXGCsOkiGxAfA9tPKjYX7wqjBZQxqK2PzTcW-RgLfgo8G74EQ@mail.gmail.com>
 <87zfso6tfk.fsf@intel.com>
 <8fb634f8-7330-4cf4-a8ce-485af9c0a61a@intel.com>
 <CABXGCsPAdzVnSpT65NkMTi=jS1c0-bz=2XjnZWUkOxhrnkpgEQ@mail.gmail.com>
Date: Wed, 05 Jun 2024 15:03:47 -0700
Message-ID: <87le3jujwc.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> writes:

> On Tue, May 21, 2024 at 10:34=E2=80=AFAM Sasha Neftin <sasha.neftin@intel=
.com> wrote:
>>
>> Any thought? Revert?
>>
>
> Sorry for the noise. Is there any solution?

Sasha has provided the revert[1], so it's on its way to be fixed.

[1] https://lore.kernel.org/intel-wired-lan/20240529051307.3094901-1-sasha.=
neftin@intel.com/

>
> --=20
> Best Regards,
> Mike Gavrilov.

Cheers,
--=20
Vinicius

