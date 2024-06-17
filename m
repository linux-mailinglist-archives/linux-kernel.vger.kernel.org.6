Return-Path: <linux-kernel+bounces-217307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1FE90AE13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7A0286A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB58195B13;
	Mon, 17 Jun 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Py2jT7NF"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83B195B15
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627794; cv=none; b=gijKcwWsuqr54GOenAZOdAqLK2Hjwh0BkfuiC4wnnHlgHgK3Em2TqPJjW+3VeYld0KhmEciBDXXNpMG0riadpRGBKpqXmtFSgw7d/31DFNxY4/zrcjZxwTxNnONy8fQUGxrNriuYjbdDVzwJLdzJTqrf6MpfQNtDCQaBXsM5YwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627794; c=relaxed/simple;
	bh=mpsJHm/Wh12wUHBuWrzCzWj8lPzEuZBAvN33qYTQ6h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=doNRDfvf1KSQ8D/PL+fywkxDy35/EegharZOQkGtA9yRanSOVglxs8tUzDt7ZLtQBrRbsEPprnBBICel6Ymjvk8MD7xuJ/Q7L+8Dt6OQaAtP31AR6YUhJAQNndc/q888qvNhUtcTWuqukncVdoGal9BK4OQPvrj25GaVR+76a2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Py2jT7NF; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45HCaCg7109263;
	Mon, 17 Jun 2024 07:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718627772;
	bh=4ZLuq+lk5YP2ru6FnXQA6oIOuJ+87d9cZSdpuFMVN08=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Py2jT7NFjerhXm2rJTpMtJ/vlcPk2cQpTPEFeHwsf4t2W+/8lSzVUkh628vueKGIp
	 4wLBI4/CZMXN0dsysMRWffAL9c8enFiS6cwv4cC9w2P57Z4QL+qcbpomSBlUbI9kr+
	 LIdWriqXR+UYv4dsaCG8hWSz2Ur4RN9TcZYj834g=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45HCaCLV095596
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Jun 2024 07:36:12 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 07:36:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 07:36:11 -0500
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45HCa755007174;
	Mon, 17 Jun 2024 07:36:08 -0500
Message-ID: <1d914332-9300-4dee-8d33-0a806cb22aa4@ti.com>
Date: Mon, 17 Jun 2024 18:06:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tidss: Add drm_panic support
To: Javier Martinez Canillas <javierm@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC: Jocelyn Falempe <jfalempe@redhat.com>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>, David Airlie
	<airlied@gmail.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>
References: <20240615085326.1726262-1-javierm@redhat.com>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240615085326.1726262-1-javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Javier,

I tested the patch, and it was good to see the panic screen on SK-AM62.
Thanks for adding this feature in tidss. =)

On 15/06/24 14:23, Javier Martinez Canillas wrote:
> Add support for the drm_panic module, which displays a pretty user
> friendly message on the screen when a Linux kernel panic occurs.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

> ---
> Tested on an AM625 BeaglePlay board by triggering a panic using the
> `echo c > /proc/sysrq-trigger` command.
> 
>  drivers/gpu/drm/tidss/tidss_plane.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

[...]

--
Regards
Aradhya

