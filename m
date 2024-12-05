Return-Path: <linux-kernel+bounces-432682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1949E4EB4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3A21881CED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606321D461B;
	Thu,  5 Dec 2024 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Z9Jjj9cy"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60271D1724;
	Thu,  5 Dec 2024 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384008; cv=pass; b=XUD2pEdpOfQgafDbFx/BtAfjTEmKjqszrnnGfzCGjjBbEwu3hnvOerCeSyuQa8TYCZDOMha3JduxT6aYyc7vt4yHyLSxHNCHh/A1bTRsF47g/5OR7X+4z0CU27djgsYxRaXel9FqfGZBt4LMJYskewXbrNHVuuYZu5WoDxooWg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384008; c=relaxed/simple;
	bh=DG6UE/gC1ebVtzQSV2zD0p576fRbTBXtDaEaPdZpuuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tmO4YlQ3EcqAfTqvd8HUwM6p5pwU3RacX7XGvIhHBKs7dpoiQv9HfEzeAWvE8rpN/JNoZaEZ0e5GHL9SpjMWbFA6nAcP8scEemRffJ2oK1GwQ+5JTG58SgzVWoGjpy/+sp+lVSlDZirqklG1D6qC2wVQX6RV4LdLywgGrpPZyZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Z9Jjj9cy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733383990; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WCxow8QQy/43Cu9PqFBCwWkHQ+UTPCTYpehfiXbHbNBwU6t56VJapipvCcZl3jE5vENlm76Hg4u2pP5gowmQdm6IL8KrWrAe30nDpj7cvFQTRaxEdGmpZxw7//U8P02IW7BQbniidIfWg8wgAL+WWzctGx56dmgoMUbUL7bt6F0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733383990; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h/pDqEVxTbTjkrM/rQ97OwV3RB8PyztZXJIn2FQGkVc=; 
	b=E7K9/WULCpcoHsgh0nPwQ6WfqyFfKkzGodD0E6SbgQzuzf7hNhfHlXvMofgMjDv1L/xvbMLyPi6hlpclDZ893clE3U3gNbXntzgU15X9zpz66OLFrJp5rELnt/ssq0Mb88Ubb9Fh7aJXi0qcNTAY8a6CUhLjbAwdTr7TLIqV4aI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733383990;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=h/pDqEVxTbTjkrM/rQ97OwV3RB8PyztZXJIn2FQGkVc=;
	b=Z9Jjj9cypuMjGM2BUc7Sr3zKbTecvn1OFuOuIx9CiwMsAjo45huH7ija4oLBevhI
	Hfh0ppHHegxIwoMUehZ6o3bFBNX4gw9cx0Z4yi7xZj/mg+FWHvj2g0Ov8+C3Y9tN2Ob
	IkkApSBm47DMwJBbgz5kfhQ7q083bwqpt9tsGoMI=
Received: by mx.zohomail.com with SMTPS id 1733383987370489.0252559578878;
	Wed, 4 Dec 2024 23:33:07 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/2] sound: usb: enable DSD output for ddHiFi TC44C
In-Reply-To: <87r06mvc1t.wl-tiwai@suse.de>
References: <20241204151954.658897-1-adrian.ratiu@collabora.com>
 <87r06mvc1t.wl-tiwai@suse.de>
Date: Thu, 05 Dec 2024 09:32:59 +0200
Message-ID: <87v7vyh9ec.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Thu, 05 Dec 2024, Takashi Iwai <tiwai@suse.de> wrote:
> The table is sorted in the ID number order.  Could you put it at 
> the right position? 
 
Yes and I will also clear the format bit as you suggested
for the other patch.

Will wait a few days in case others have more feedback
then I will send a v2.

Many thanks,
Adrian

