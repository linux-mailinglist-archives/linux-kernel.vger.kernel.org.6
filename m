Return-Path: <linux-kernel+bounces-263044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098D493D045
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC162830B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA0C17838B;
	Fri, 26 Jul 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eeis9VVW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6DD17836D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985350; cv=none; b=sO0xWI0v+qmhurRP1efWtfOVWunnTcO8mobx+ZRpfw5FLSQW/WIzZDSdqx8uzuPrA8ok9x7qXx1Zz0tQM+qB46dRVo9lpRcnzA3FU582aqNnFHBZX4Ptn4LYL72jaoboqfO7nCvfz/xuf7eNHsEO2VdeowA0D7+uJ9PG2DhAGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985350; c=relaxed/simple;
	bh=RTeg7a5/NBnZzeXWaxhUT9VJlh63EkpCYf65DHwKFvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cp4ephoCGK37gCzsyqDkmiSp561FDvBz8dMP6qVxcW84jxawCIcofgnerVpDTUJHARV3Eh15uMsFuWPHgfEPVUx8BTCizWGQmWPGch135o79KaDDQim6efszRRo2XdBV+9W+7Bz2ctaDdRiWBJm8El+HGxHbY3gEFwQ/npzEh+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eeis9VVW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721985347;
	bh=RTeg7a5/NBnZzeXWaxhUT9VJlh63EkpCYf65DHwKFvM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eeis9VVWUc/vDnNE7fv53g8nbt6B5Ka0RNjZ+/KjfWlGd2LpMSnWoBe9HjNUp9CoB
	 N5nEByoGgV0A3u7Pta7M33OkXANIA/6bwZ7R1O5jDcFUHBdvIhDpJAmfmhGyMeBXSL
	 Ly+HNtfzSEvKS59rs17LnYmwDkscWSR9rkGAhBKmb28YpWKhBbfHVW/QK9D5lb47sR
	 fAsdZM3NeNoFxm3mmp7KDcXvM3Ii9iT+/4hv54gUkDzvnleX1haSe+uwdFG7yubvwB
	 mJz1jsmWiqvDW/IS0dajDDeivsY1FnKFDx356uMUskCVhovZv1yf0mnnyOEpYUk3Gb
	 4YEoIGwftfXMA==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8605C37804D4;
	Fri, 26 Jul 2024 09:15:44 +0000 (UTC)
Message-ID: <2cbaf9a5-faf5-4019-9ae9-709fa1647a40@collabora.com>
Date: Fri, 26 Jul 2024 14:45:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] drm/ci: mediatek: add tests for mediatek display
 driver
Content-Language: en-US
To: Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 deborah.brouwer@collabora.com, robdclark@gmail.com,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240724101015.523535-1-vignesh.raman@collabora.com>
 <20240724101015.523535-3-vignesh.raman@collabora.com>
 <CAPj87rMfs+_EMyJT1PoLTXmrosDiqQy_N4VYSA+M3R5q4sit5Q@mail.gmail.com>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <CAPj87rMfs+_EMyJT1PoLTXmrosDiqQy_N4VYSA+M3R5q4sit5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 26/07/24 12:54, Daniel Stone wrote:
> Hi Vignesh,
> 
> On Wed, 24 Jul 2024 at 11:11, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>> +dumb_buffer@create-clear,Fail
>> +dumb_buffer@create-valid-dumb,Fail
>> +dumb_buffer@invalid-bpp,Fail
>> +dumb_buffer@map-invalid-size,Fail
>> +dumb_buffer@map-uaf,Fail
>> +dumb_buffer@map-valid,Fail
>> +fbdev@eof,Fail
>> +fbdev@read,Fail
>> +fbdev@unaligned-read,Fail
> 
> Please skip dumb_buffer and fbdev tests for all GPU-only drivers,
> because those are testing display functionality.

Will skip these tests for gpu-only drivers. Thanks.

Regards,
Vignesh

