Return-Path: <linux-kernel+bounces-212810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A899066AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E991C2254D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB813D60D;
	Thu, 13 Jun 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Hp1x7AWx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67313D623
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267179; cv=none; b=Z/YYWbtDAoiHlpDcoZyzIb4m4VL275QtV8u83XTV5huVSVcUad0Z+4obBopx1kPLPrccNAMnZRKYZSRrlBHVDsPr1MK+L/0ST1h1F1wRxqQnUvZpXPt0nWa50anDmMxJz4mkTrkBxCdA+BFU1yZhjNrJN40s0jmENoQbcT0gGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267179; c=relaxed/simple;
	bh=+jqe4V/X8c/P2i/iDVHFbcM7D2Q34xqr9KdThWtNit4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lywFaV6ejG1F3NwLRsA4nSKgVwhznLAKB7oDZzHxNvsTICnQN9tovUgWWCnhrLcVmDZQnKKXZedaiqKvb0qpTjJuOpC590N8pfKofvb8V1gHNH+Uk3YG11yq9u3qAUCmZv20NhYfq9mr3eE4U4x5c8d43W02S7TnCHxdNDTsf5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Hp1x7AWx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718267175;
	bh=+jqe4V/X8c/P2i/iDVHFbcM7D2Q34xqr9KdThWtNit4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hp1x7AWx8Xqk3h9GV80PFt26aewD/3Xjz2sBgREE/eZIUzraVC0PSKLjUvMudo/5Q
	 GiL5WY4usC3oN+IiqFubIQwPa2xAnfwG6L169pXeBBQJCJqCTYZNsRpxTpABtG4q9K
	 2JQhLNsnthhb/GauuqbUH6aMYxWLLul85fR+txYPmIZk0onsggm2x9JHr68PLJl7KR
	 Pq6CTR8Spff5Sys7vS+CCaEqe/IxLVbWBnAYKrhCXhVyV5r7IMvU/26F8HWv45EQVR
	 2GXODbo2BERocWylVHZYITRjiNXFxhHNTTiPhxT9fhyQ6AsJlDepmUGzJEl2jyY1x+
	 KEFbOgMvTfN8w==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6CB843782172;
	Thu, 13 Jun 2024 08:26:12 +0000 (UTC)
Message-ID: <bd430442-6074-44b1-ba62-d3fa9e7bf28e@collabora.com>
Date: Thu, 13 Jun 2024 13:56:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/ci: add tests on vkms
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com, daniel@ffwll.ch,
 rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com, mairacanal@riseup.net,
 hamohammed.sa@gmail.com, robdclark@gmail.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 daniels@collabora.com, helen.koike@collabora.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 linux-kernel@vger.kernel.org
References: <20240611091037.558969-1-vignesh.raman@collabora.com>
 <20240613-bipedal-eccentric-locust-91632b@houat>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <20240613-bipedal-eccentric-locust-91632b@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxime,

On 13/06/24 13:07, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Jun 11, 2024 at 02:40:37PM GMT, Vignesh Raman wrote:
>> diff --git a/drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt b/drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
>> new file mode 100644
>> index 000000000000..56484a30aff5
>> --- /dev/null
>> +++ b/drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
>> @@ -0,0 +1,15 @@
>> +# Board Name: vkms
>> +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
>> +# Failure Rate: 50
>> +# IGT Version: 1.28-g0df7b9b97
>> +# Linux Version: 6.9.0-rc7
>> +kms_cursor_legacy@long-nonblocking-modeset-vs-cursor-atomic
>> +kms_flip@basic-flip-vs-wf_vblank
>> +kms_flip@flip-vs-expired-vblank-interruptible
>> +kms_flip@flip-vs-wf_vblank-interruptible
>> +kms_flip@plain-flip-fb-recreate-interruptible
>> +kms_flip@plain-flip-ts-check
>> +kms_flip@plain-flip-ts-check-interruptible
>> +kms_flip@flip-vs-absolute-wf_vblank
>> +kms_flip@flip-vs-absolute-wf_vblank-interruptible
>> +kms_flip@flip-vs-blocking-wf-vblank
> 
> We should have the header for every line here

All the flakes in these tests were observed with version 
6.9.0-rc7/1.28-g0df7b9b97. So can we group them together?

If we update this file for different IGT/kernel version, we can add a 
separate header for each test.

Regards,
Vignesh

