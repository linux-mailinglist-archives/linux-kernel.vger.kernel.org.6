Return-Path: <linux-kernel+bounces-309411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F5966A19
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768591C216F3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD951BE250;
	Fri, 30 Aug 2024 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="ZpthUZPi"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95B1D1300;
	Fri, 30 Aug 2024 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725047531; cv=pass; b=bbQfUoKrAf4SuMhVyrokB8H8rTIicMU+2qQMWaD9QkWdrPnriVqBADQkrfEm4UvJ0gcABpqiIr5zVSwlKuCa6042EzyH+/A+Ijya9tHITQj/XPxexteRN5xZ7Bh4fmyDRV+wOQHJhaAD7/n+Idu/dLUMvToIZhCc0utb8xfSWGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725047531; c=relaxed/simple;
	bh=THEmys7qFAFk/emjfEmiQRoAoxxNPlyBk8CDDd/lAiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAy9mnDPP2DuPkF94tPiG0xELcitzSjE7SjIL0n3HIWXruPiWK+3S+zuvaHCP1rsW9Dd1+8LCjL4cHWGth5Cfw13m29ubxKZdN0165W9bV+zh3VPjNSc0wHNS4PW6KxFHrDxWfTKAPB+G09h/6rVQ/IVGibXFn3BTAvCd4Iia2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=ZpthUZPi; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725047493; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fc5aKmQK2uAwBJfJnqtE5Q2Q+z+4uHVsRQC8QZAAQz3D7oe1q8ycADHvnuMlh5CbwAWHN8weyVTIJKI+NWtrlaSqfjnLkj9LxtNgOhTNDFbkIbxxaPfPNo7TNZCwc6/Iy5xjzAVVr6cL8Ymzqgv4vb2vW8YHbHQgw2CnASKJxXw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725047493; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lZgsVPL1zIUPPX6fL1AfRoli7CWC0FdmvjcrwEFwrMY=; 
	b=mPHFEHi72p36IknxA1gJVYdmIxG/VW/7t5atcKhAg1G+fPoB9chjlQW5EJB+X/Oyi+JTxa15w9cVgTRrKPRUn48QeqgkdDrtt5Dgr47iJcACScqdR/of0oaIc2OwEdNz9MnZf8I6Dk3VhedE/Cww6jV54jTm7sLBhWopSex4QOQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725047493;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lZgsVPL1zIUPPX6fL1AfRoli7CWC0FdmvjcrwEFwrMY=;
	b=ZpthUZPiBqmUHh7dkw1o9oxEFl1s1Tja+TkbYWkSHJJ4f1/tN6ZkTU7HKM76EuZr
	chDfno7rrtP3f4eYS1z9mO2nnSwsRPrBsLEnt2hOegOPVEO8OHaoSBzeuc0crX/iRmZ
	Lsyd3k/vlhb7qcn15ye3SsW3dJ//FrklIAWSrip0=
Received: by mx.zohomail.com with SMTPS id 17250474912431006.0237532313579;
	Fri, 30 Aug 2024 12:51:31 -0700 (PDT)
Message-ID: <440c8b2b-035b-4983-b078-78252a17725d@collabora.com>
Date: Fri, 30 Aug 2024 22:51:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5? 0/6] Tweaked basic Synopsys DW HDMI QP TX driver for
 Rockchip RK3588
To: Shimrra Shai <shimrrashai@gmail.com>
Cc: Laurent.pinchart@ideasonboard.com, aarnoud@me.com, airlied@gmail.com,
 algea.cao@rock-chips.com, andrzej.hajda@intel.com, andy.yan@rock-chips.com,
 conor+dt@kernel.org, daniel@ffwll.ch, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, heiko@sntech.de, hjc@rock-chips.com,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, krzk+dt@kernel.org,
 ldearquer@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 maarten.lankhorst@linux.intel.com, markyao0591@gmail.com,
 mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, s.hauer@pengutronix.de, tzimmermann@suse.de
References: <68e78629-5a2c-433b-8c83-50ffced04268@collabora.com>
 <20240830175440.2596-1-shimrrashai@gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20240830175440.2596-1-shimrrashai@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Shimrra,

On 8/30/24 8:54 PM, Shimrra Shai wrote:
> Cristian Ciocaltea wrote:
>> Please stop doing this!
>>
>> I appreciate your intention to help, but this is not the proper way of
>> doing it.  This is a work-in-progress series and you should have asked
>> before taking over.  Please do not interfere with other people's work
>> without having a preliminary agreement with the author(s).
>>
>> Additionally, before submitting any other patches, you should get
>> familiar with the process - see [1] for a starting point.
>>
> 
> Hi Cristian,
> 
> Sorry, I did not know what the rules/norms/customs were around this
> kind of thing here as I figured it was an open contribution space. I
> did not know that I should have asked for agreement with you
> beforehand. So go ahead and ignore this patch series if it goes
> against the rules/customs. Even more if these points have already been
> addressed, as redundant work is obviously not helpful.

This is an open community and, obviously, anyone is free to contribute
without asking for permission.  However, taking over an ongoing work is
nothing but a source of confusion.  You may do this for work that is known
to be abandoned, e.g. the author(s) explicitly mentioned that in one of
their last posts, or when there is no sign of activity for long enough
time (usually months, for sure not days or weeks).  In the latter case, I
find it reasonable to still ask for a confirmation that the submitter has
no intention to continue or, at least, discuss the possibilities to join
forces and help moving further.

> That said, if there is some way to help along this project "the right
> way", I would like to for sure! Just tell me what you'd _really_ need
> help/assistance with to get this moved ahead and I'll see if I can
> give it.

Getting more testing on the series, reporting back the findings and/or
providing fixes, would be much appreciated, for sure!  The goal is to land
the basic functionality first, hence any new features should be submitted
afterwards.

Regards,
Cristian


