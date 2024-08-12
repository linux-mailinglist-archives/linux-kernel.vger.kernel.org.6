Return-Path: <linux-kernel+bounces-282883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7BD94EA06
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CC1281316
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9416DEA4;
	Mon, 12 Aug 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b="SRGElSZy"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE816DEA2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455557; cv=pass; b=WQco/7H4EiqZRpgFzL+kDfM5oI3dY1budqNzIRso18MugFG0AHmFh2fhpCaDeDmvb5v4EbpaVQ2Zez6UxjinBCquO7WBuYtSDwFKCy8lZSnML+J27nx18xhURFCBWs/6S3tivV/nOkf7G/fCDvqHWckvZnE7qOuhk5bEHSQKK1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455557; c=relaxed/simple;
	bh=MTsmowRgfgdUOSeBBoHiirYnPJ7lM+TN/J3vxH702VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8rqfXzNJ22L6XxiMWGth1bo34CWij1dt4a/yvj3JcU7u8Q7KDIMUep7CAiLpG6CBqUi1EoIANy6JnRsx4ydk5LJpLh2HV1skAb+tgW0kKv0W6iut8fs4F4g9paYAHA1cptEkGOId9ykmoKJs08FEnjI8dfhG/9bBxeWya+gM40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b=SRGElSZy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: daniels@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723455540; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gOt/WiRKxgGBluYCkdey1304INoryoEwh1fT9B6MA6c0PVet6JCfH6CdPGYR820wS54A/wTWcHuzqlJ8DTmc3U+hWgHZEfskmjELcQPZeBOebOajD5LNDedwHYK7OKei25u93QcPysozKwrXOhHEHRjBArRVNBAWnD/YUkBUBWs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723455540; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x4CcyIs2RHXORPINhp0dQOmoRY0vzYbkeA1TVr2ZBDA=; 
	b=OK7Mb6lg5ut0JmNEdMp0EIrzpS8us2A97Fqhk1eMLP2mtunLbbR68bA29ny1QzuFCLHKwAKTd4z5RQNc+A+kfscU5OKWngcDHknd4HL8Qf8ZAy7inOdb+UO/WqAZqGGYMezMts3cZV+u4HJMBXm7mQGUrif98P42T6sI158YEko=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vignesh.raman@collabora.com;
	dmarc=pass header.from=<vignesh.raman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723455540;
	s=zohomail; d=collabora.com; i=vignesh.raman@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=x4CcyIs2RHXORPINhp0dQOmoRY0vzYbkeA1TVr2ZBDA=;
	b=SRGElSZyZARqX+/zHIoTy0UY0opE9e30NjOQKKtAjhoxngYBI81jqS94kAm+v+BV
	ohdX9RDaglSX/i8mrDGsc6Vn+HMG0P3c72Vo9C8h9Qj0yyO2RYLgMvUJvIIx/gHsqwr
	hcUOcUBNLSSZjm0zXGcmkuHWq6/pVoQooDmSeuCk=
Received: by mx.zohomail.com with SMTPS id 17234555376541003.9915773763962;
	Mon, 12 Aug 2024 02:38:57 -0700 (PDT)
Message-ID: <0db8bc11-d388-4f6f-9e04-a7787e2a2e73@collabora.com>
Date: Mon, 12 Aug 2024 15:08:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/ci: uprev mesa
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.koike@collabora.com, airlied@gmail.com,
 daniel@ffwll.ch, robdclark@gmail.com, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com,
 linux-kernel@vger.kernel.org
References: <20240807082020.429434-1-vignesh.raman@collabora.com>
 <8fc33b63-40db-478c-95bc-bdfaa93d2fd4@igalia.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <8fc33b63-40db-478c-95bc-bdfaa93d2fd4@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Maíra,

On 08/08/24 17:01, Maíra Canal wrote:
> Hi Vignesh,
> 
> On 8/7/24 05:20, Vignesh Raman wrote:
>> Uprev mesa to adapt to the latest changes in mesa ci.
>> Project 'anholt/deqp-runner' was moved to 'mesa/deqp-runner'.
>> So update the link.
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> ---
>>
>> v1:
>>    - Working pipeline link,
>>      
>> https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1242911
>>
>> ---
>>   drivers/gpu/drm/ci/container.yml  |  8 ++++++++
>>   drivers/gpu/drm/ci/gitlab-ci.yml  | 22 ++++++++++++----------
>>   drivers/gpu/drm/ci/image-tags.yml |  8 ++++----
>>   drivers/gpu/drm/ci/lava-submit.sh |  1 +
>>   drivers/gpu/drm/ci/test.yml       |  4 ++--
>>   5 files changed, 27 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ci/container.yml 
>> b/drivers/gpu/drm/ci/container.yml
>> index d6edf3635b23..2a94f54ce4cf 100644
>> --- a/drivers/gpu/drm/ci/container.yml
>> +++ b/drivers/gpu/drm/ci/container.yml
>> @@ -28,6 +28,14 @@ debian/x86_64_test-vk:
>>     rules:
>>       - when: never
>> +debian/arm64_test-vk:
>> +  rules:
>> +    - when: never
>> +
>> +debian/arm64_test-gl:
>> +  rules:
>> +    - when: never
>> +
>>   fedora/x86_64_build:
>>     rules:
>>       - when: never
>> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml 
>> b/drivers/gpu/drm/ci/gitlab-ci.yml
>> index 6d2cefa7f15e..eca47d4f816f 100644
>> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
>> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
>> @@ -1,13 +1,13 @@
>>   variables:
>>     DRM_CI_PROJECT_PATH: &drm-ci-project-path mesa/mesa
>> -  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 
>> e2b9c5a9e3e4f9b532067af8022eaef8d6fc6c00
>> +  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 
>> d9849ac46623797a9f56fb9d46dc52460ac477de
>>     UPSTREAM_REPO: https://gitlab.freedesktop.org/drm/kernel.git
>>     TARGET_BRANCH: drm-next
>>     IGT_VERSION: f13702b8e4e847c56da3ef6f0969065d686049c5
>> -  DEQP_RUNNER_GIT_URL: 
>> https://gitlab.freedesktop.org/anholt/deqp-runner.git
>> +  DEQP_RUNNER_GIT_URL: 
>> https://gitlab.freedesktop.org/mesa/deqp-runner.git
>>     DEQP_RUNNER_GIT_TAG: v0.15.0
> 
> Kinda of unrelated to the patch itself, but shouldn't we update
> DEQP_RUNNER_GIT_TAG? Mesa is already using deqp-runner v0.20.0 and we
> are still on v0.15.0.

Yes, we need to update deqp-runner also to same version as mesa.
I will post a patch with this update. Thank you.

Regards,
Vignesh

