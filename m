Return-Path: <linux-kernel+bounces-576935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B0A71639
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F51A3A67AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F8F1D6187;
	Wed, 26 Mar 2025 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="XetSEJwK"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9F615199A;
	Wed, 26 Mar 2025 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990877; cv=none; b=EW2iXIEZFT3z3w/xI2GXI+brLHAGGITwzpwcft6nnXlHFNa+7rIepT0qrjRS/BxB8FxvLrvplRuvnawPGEanR/4vtew8qxfLB+pe7rUjbhtkM9nBpMW+aMiPiBR1mpZ6FPta/B1L+LB2pv+MM/WFbgMYJStrN2sSiIhH3t1fEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990877; c=relaxed/simple;
	bh=8OSbZVtM5j6MneNBkaV9XQVyUAKvhcJWgDEHKK/CzWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=dXfaA6iOqSgfV1NVtlwusS7oQ7yTU+wKZTNi6JNHX7sWeaQyDftKeTpqDpcDyR7FSvnllt2bYwWfiPPsTr7g8SvbGlGIj6A+tt6QotuTgSBiSt0H7XXNr5FGlUhJEdc6tsmhI1+eI+BLSeO8oCxjMVPPAxOwIP60jKz1IjgAwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=XetSEJwK; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Message-ID: <c7f5f4cc-c187-4402-91dd-4d0096e396fa@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1742990863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMK8XL/Cuy6xkH2qwigglqltgSMZZWnJn2HXl2OdYVE=;
	b=XetSEJwKCnE9H0OfeGMp1axvzvmrQLYWnmO7GX1AjCn3I1boB3CMSdxFLjFh4RMUeWg7b9
	F3IMIOaVSVrHCSGkLqCfJwzqDt5p/+xgDB5DVLzBZpL+WLZ6Ot22u/f4rPaaq0g7E+nKZX
	s+E8rnJoR9r5R3XuDpLCjq4s8gzRLTs=
Date: Wed, 26 Mar 2025 15:07:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] asus-laptop: Fix an uninitialized variable
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20250325095739.20310-1-arefev@swemel.ru>
 <88f06d15-0f98-2f24-7e68-eefb6434f108@linux.intel.com>
Content-Language: en-US
Cc: Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
From: Arefev <arefev@swemel.ru>
In-Reply-To: <88f06d15-0f98-2f24-7e68-eefb6434f108@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.03.2025 14:18, Ilpo Järvinen пишет:
> On Tue, 25 Mar 2025, Denis Arefev wrote:
>
>> The value returned by the acpi_evaluate_integer() function is not
>> checked, but the result is not always successful, so an uninitialized
>> 'val' variable may be used in calculations.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: b23910c2194e ("asus-laptop: Pegatron Lucid accelerometer")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Denis Arefev <arefev@swemel.ru>
>> ---
>>   drivers/platform/x86/asus-laptop.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
>> index d460dd194f19..b74b7d0eb6c2 100644
>> --- a/drivers/platform/x86/asus-laptop.c
>> +++ b/drivers/platform/x86/asus-laptop.c
>> @@ -427,7 +427,7 @@ static int asus_pega_lucid_set(struct asus_laptop *asus, int unit, bool enable)
>>   static int pega_acc_axis(struct asus_laptop *asus, int curr, char *method)
>>   {
>>   	int i, delta;
>> -	unsigned long long val;
>> +	unsigned long long val = PEGA_ACC_CLAMP;
>>   	for (i = 0; i < PEGA_ACC_RETRIES; i++) {
>>   		acpi_evaluate_integer(asus->handle, method, NULL, &val);
> Shouldn't you handle the error from acpi_evaluate_integer() properly
> instead?
>
Apparently, the developer realized that the output is very noisy and
therefore created an algorithm that will surely return a good result.

I did not check the return value, because if acpi_evaluate_integer()
cannot read the values of accelerometers, 'val' will remain
uninitialized and will be used in further calculations.

