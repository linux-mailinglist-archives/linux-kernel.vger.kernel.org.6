Return-Path: <linux-kernel+bounces-311922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC43968F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D79283E5F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72CA18755C;
	Mon,  2 Sep 2024 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="fECWOFVL"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722E1A4E8A;
	Mon,  2 Sep 2024 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725315345; cv=pass; b=IdMLgJJ33ybkCXUFPwLdhDq7QPIDDn444e0slG8bN1GAsgjj4bDy9Vy9rzma+VimRitbjzlTzkuTqT81RQahduq1NuKGicaDlgTKhYd8CcqAZUGfsC1IWECORh9uPmKo3uCxw7ZGcSB7ZernYKmeEkE0WRgm9sGXoVQQJ/tFRJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725315345; c=relaxed/simple;
	bh=wpbQVBN3cfxfxQr/CA+w2EkvAHuAKzC4YOiVKYS1I2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0pFNNk0GF4EiJu+WoYRxt1Lp1T+wqzEQtYUuuFTkNgGXRFHaj6E3Y9uVb6r7JHSoR7Hvahr82I2PhSgquvO4JY24xFYo2q7AEvjfLv3ZVi5eQurxJ5AgI3lxq+bVanzmu+OJZvt76UPs4HGD9Zd1ASLReh9OU7jc+jLsV0Lw1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=fECWOFVL; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725315292; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SQpuusukbpN6JVHx9Vp3GmqH3RMB9VT4zhStc/T0Kjuf6/jpeY8F3w/YP4rjHG9NBe2Xk3AxtYQzLx7ctSBrvWS3lMoZvZFZjkgBZeOWv/Ok2eVfWI7gU3awl/jaWcWjbjKUzTgtKfRpE6kxA4n5CqQIgyX5rCCjMoxVpCGTvTA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725315292; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QDNIvKtrO8pIYCbZxhaqDHVt24NXNrWagRGRYHJHozM=; 
	b=BwlnaS+p845Tv3Ms99pwrryj6c//3S95iWRU+qHu31RkWOb1TOOLYXul4jBsVCecT4EugEOJUQkDkt4b9FRNbvvxcx2Mf3IdlzeVHbADl4eVxC4W8RI/E1zWTo3fTfV39J3iB9f6xEcNyZbUAvumPhP0fn/6pcR5E7j70lfGyfo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725315292;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QDNIvKtrO8pIYCbZxhaqDHVt24NXNrWagRGRYHJHozM=;
	b=fECWOFVLFmmzV1WR2D/aPVwqiIbnjZi+FsoTTLknC2nX6xgeTVWzxj+2g0Mg0qJO
	kAFC0WfOX+FroleSd1Fa0P/pi4LJ0wW2vlAn+Yg6yl52BJfW2LGAqOPVyigvW5REgLv
	g1TEx9waorek+ZWIuX7hpi/l0505b5e4suDsIQPQ=
Received: by mx.zohomail.com with SMTPS id 1725315290251290.71260809194837;
	Mon, 2 Sep 2024 15:14:50 -0700 (PDT)
Message-ID: <eb9f2d20-9b51-45e1-bf32-504267747f06@collabora.com>
Date: Tue, 3 Sep 2024 01:14:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
To: Shimrra Shai <shimrrashai@gmail.com>
Cc: Laurent.pinchart@ideasonboard.com, aarnoud@me.com, airlied@gmail.com,
 andrzej.hajda@intel.com, andy.yan@rock-chips.com, conor+dt@kernel.org,
 daniel@ffwll.ch, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, heiko@sntech.de, hjc@rock-chips.com,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, kernel@collabora.com,
 krzk+dt@kernel.org, krzk@kernel.org, ldearquer@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 markyao0591@gmail.com, mripard@kernel.org, neil.armstrong@linaro.org,
 rfoss@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
 tzimmermann@suse.de
References: <5ea24ad3-7faa-4a59-ba10-d43b32b3b40e@collabora.com>
 <20240902010948.3654-1-shimrrashai@gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20240902010948.3654-1-shimrrashai@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/2/24 4:09 AM, Shimrra Shai wrote:
> Cristian Ciocaltea wrote:
>> On 8/31/24 9:13 AM, Krzysztof Kozlowski wrote:
>>>
>>> Please define all clocks.
>>
>> The other clocks are defined in the common binding, should we reiterate
>> them?
> 
> I would suggest yes, they should be reduplicated, if only to maintain
> consistency with all the other docs. A grep through the bridge docs
> shows that there are virtually none which use a "{}" placeholder like
> this. 

Are you sure about that?  This is precisely the approach followed by the
upstream DW HDMI TX controller binding [1].  Moreover, I've already pointed this
out in [2].

> While it seems kind of like one might worry about "don't
> repeat yourself" syndrome, keep in mind this is not code, but human-
> used documentation. Having all the information available at a glance
> would seem to be the most convenient to the end (developer) user, so
> they aren't having to toggle between two separate files. 

I think that's pretty subjective to be stated as a general rule, e.g. I don't
have any problem toggling between multiple files as I regularly keep over 50
files opened in my IDE.  Personally, I'd always go for the slightly less 
readable approach if I can avoid duplicating content.

I'd suggest to follow the whole thread [2], as this topic has been already
discussed.

> Of course
> there may be some questions regarding docs becoming out of sync, but
> *ideally* we don't want to break backward compatibility with device
> trees (esp. given how I am imagining firmware integration to work on
> these platforms, as the RK3588 is at at least low-end desktop-grade
> performance and UEFI packages have already been built for it), though
> of course that doesn't mean adding new options is off the table.
> 
> (FWIW, this is what I did in my now-withdrawn-at-your-request
> re-submission; I reduplicated the bindings as it seemed that's what
> others here were pushing for and thus that felt like the quickest way
> to get this important driver approved.)

This is not really a blocker for the series.  Please remember to be patient
while involved (one way or another) in the upstreaming process, as maintainers
need time to review *all* the patches.  This might be very important for you,
but there are, usually, tons of other way more important things the maintainers
need to handle in parallel.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml#n46
[2] https://lore.kernel.org/lkml/ec84bc0b-c4c2-4735-9f34-52bc3a852aaf@collabora.com/


