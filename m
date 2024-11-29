Return-Path: <linux-kernel+bounces-412042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF16C9D02DB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 11:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1E1F233B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E92139D07;
	Sun, 17 Nov 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ko13AsGw"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A33335B5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731838092; cv=pass; b=WjuQa9lKhUmmptV7nck1lUzTIy0AO81NDgIucjJj00RH7xIUmkBYW00zdAABUp8EFFfF9jzTqoGysOgZLAZGr9hokCvqWZiiFMEtPkc92V0TzVNz7kNTCiss0+ji+3Q7F0zh76zZqYvkvha5zGOsaZbOaN6NikNsUjY7NyCMZ2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731838092; c=relaxed/simple;
	bh=U48nJoqlw7F7z1lo31IwChC8sWWo86ldxKuJjoodecA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQkITh+0ac0tpSM5kuLVPkQ/sxrn5Ls+MKYwgMcZUJDB6hjHeOzxs18/HpTTFP4eOJ0FaX235eG813I8qRnk1sjeJlum6rBwiGfeb7vvMnpCvaHF0SG8MkFOWMDTX+0jgB0yOlVkTPKoeEsVMjGXemuumWe4aVfdsBGCgsoHDnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ko13AsGw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731838075; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Kc6TWjHT1dLF4G+9z9HGJklIfelOCYp6scjyRkJp0/CKJ1Nl5xzhw4GBOrecTviDvKFSaOUb4YW4UhlX2KNt0CdVVNx0RSQzppqqfGJbgrLfHKcHcr+q/h18etond6Eq1T/SoOf0f4I9mFPbFYaywOeXdVtMviWzceX5FiW6mck=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731838075; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CGOiKyvMy2cXLiPoWyw2nHQoEitR5m27MYGutHaqmeg=; 
	b=DjYRy61lTSbpHnUSUCajIilikQJhHGwFL+IPYzmYH+87NfEhbA5BoJpAVXxSE+iQaaGG4+7jYW6l551dfWSZk90Jofp9H6SsnjkNBblKXk1N0tN6L70DpQrotY2xgb82x83CzlfVZ+4Wwf8N8u5FkLLsINPFF5OEzmi5YR9BMOw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731838075;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CGOiKyvMy2cXLiPoWyw2nHQoEitR5m27MYGutHaqmeg=;
	b=ko13AsGw4FSEpfxLpCHC6qZFSzSPIVxSg1tIGzgZTl4hxF8ZAhRxh54W4ecvZE2s
	qxUlUHFp11a+npJMOzlwxSxlDqNXLIEgNXY33Spoji1ujbnIJbpAeBOEhz1AvAqfWji
	voyZNQjeAWOXmfd/Ww+KKCy5gfhu+aSA9Kbm9Bvk=
Received: by mx.zohomail.com with SMTPS id 1731838073670905.055656712743;
	Sun, 17 Nov 2024 02:07:53 -0800 (PST)
Message-ID: <092b1a94-bbe0-4d37-b0b6-3870a6a6a0a5@collabora.com>
Date: Sun, 17 Nov 2024 13:07:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/virtio: Add drm_panic support
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch
Cc: Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241113084438.3283737-1-ryasuoka@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20241113084438.3283737-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/13/24 11:44, Ryosuke Yasuoka wrote:
> From: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Virtio gpu supports the drm_panic module, which displays a message to
> the screen when a kernel panic occurs.
> 
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

I'll apply this patch tomorrow with a shortened virtio_panic_buffer
variable name if nobody will have more comments to add.

-- 
Best regards,
Dmitry


