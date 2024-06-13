Return-Path: <linux-kernel+bounces-213147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364E2906D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6DB287259
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2662D145B25;
	Thu, 13 Jun 2024 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpoQb+W8"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728A14386B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279522; cv=none; b=cKS1ox/fmccQsqacuw3w40PQDxLuP8Fbroq5uBqNuLKAVp4IOgGOmReG7Tlt79oxMyN8muHE3CiDfIxxcJy5jx+r7Gw1j6pSgdHW/Mh6Ye23FPJ6Ue3ZMMXxTii8hpQ0GyysphPHlkDS0MDGO920mNyLU3Vc1fGmlult52Jft9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279522; c=relaxed/simple;
	bh=LEMNOlqSbWvihp9TAFV3gKhrUTokJXgkBSjze5msUo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIVGtwnQO+sP5v20WKNCbQOFXNlCuu2DQXr+GCxNm748cwREjY9YFN/aUvokBKGUmyQcPxeACamMSWwaJ9YUyBNYrtZBz9Yhg/pAG7CY7FjEQ3K/FXiuNpSL8Sfmb1Km1/D6soQx8NFnIuWLFkwBoqn1zgOMjZlh0DG6SlNL66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XpoQb+W8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42108856c33so12710775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718279519; x=1718884319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nk/PNuEosluR5OxyGRPxKqFcoUp4l1g0JxXBqb0kHWI=;
        b=XpoQb+W8h2Un24UzsJaLoUqKPbqeuW6FbN2uoMLsxdZ04Sa4j3wcz0QbCusdvSuwA+
         E3E+q12rugwhBYJolYYi8oABfNwFlINwKytZaSz4HevKFZWIPlMxEX+xjf8BuJWCHTqV
         lIENPk0osf9P157xPp4M2UoUDXNWBeMyx/MdgW1RsrBCOyS1IISIJQnLd/slGxC4dRFR
         M+W4zjpC0tQX9z8aV+YrJA9Jlx5Oc2x9VNuKY7IjxKBCwm3Bl8WQkSEPTyHBepIb74yZ
         UQNQoqzEJOg9n8lBMskefvZMtmlUzhHN3Q/UFTT27mUGbF1XfOXOBKeSJ263evf52UG9
         Oi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279519; x=1718884319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk/PNuEosluR5OxyGRPxKqFcoUp4l1g0JxXBqb0kHWI=;
        b=sIUv2bZTmH1JK0fWl2JCfrKO0nYJWLvYJuM4GMzaPDCyLwsz9BwLo5sEHYQb4WNx8I
         +ImmqHrvKGp9+ntMpDElVGbr5/9p7UikfPHmUALef630I93t4WcFmkwI7Os+JNgLPA2e
         aizzHZNSNQkW03DaE3ZnT2g5JbQ7MujO4vAu+9zglr8GVrVEWo9J0Lcnzi8VstiNMEgL
         FwLkOZc17RK+RTQWgQq9wCqJwgKjik3ci83hzDpwcZAbQLH8jvQd/JdadLDFmp/1zyuF
         dmtiQWv/GzfGF4xlyyGxZb5cof2PezegR1qfRh8y8eq/htDoH8lZtX06/GCp6jHwm/LU
         w4tg==
X-Forwarded-Encrypted: i=1; AJvYcCW8W3WLevVcaz3JiZGnZpOMVRBd7x4xA5Zvh+iG2yqUrB2QL089klxUbdfE9kMcu5KMPReQjvnicuJXsY1QQ4MSTnsZbLMuI2rWkVfS
X-Gm-Message-State: AOJu0Yxd1v9u5cbwoKcyVZWVwP7Exyu0+Kejis+5eu1Fz2KVvroK6lNX
	9Dm6socUdt4L6mT6gd3eNjfYlrfGBMH/f/dHBFwU3sOISIzcwCqChy94S33HlZw=
X-Google-Smtp-Source: AGHT+IEeX74rcc7ImXLhXmjYzbMCKYnwAOrNGqHMzUNaFMP5IwqUmhu/BZcLL2lJ48EiFXwsY9KFbw==
X-Received: by 2002:a05:600c:310a:b0:421:81b1:7f45 with SMTP id 5b1f17b1804b1-422b6fc5a34mr21225265e9.12.1718279519186;
        Thu, 13 Jun 2024 04:51:59 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:51ae:6dd8:7a33:3fb4? ([2a05:6e02:1041:c10:51ae:6dd8:7a33:3fb4])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-422870e96f9sm59813375e9.26.2024.06.13.04.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 04:51:58 -0700 (PDT)
Message-ID: <ecf55d97-363d-4731-bcfa-81cb4e58f2c7@linaro.org>
Date: Thu, 13 Jun 2024 13:51:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] driver core: Add timeout for device shutdown
To: Greg KH <gregkh@linuxfoundation.org>,
 Soumya Khasnis <soumya.khasnis@sony.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org, festevam@denx.de,
 lee@kernel.org, benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
 ldmldm05@gmail.com, srinavasa.nagaraju@sony.com,
 Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
 keita.aihara@sony.com, masaya.takahashi@sony.com
References: <20240613083226.GA8191@sony.com>
 <2024061326-moonlit-protozoan-61f8@gregkh>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2024061326-moonlit-protozoan-61f8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/06/2024 10:43, Greg KH wrote:
> On Thu, Jun 13, 2024 at 08:32:26AM +0000, Soumya Khasnis wrote:
>> The device shutdown callbacks invoked during shutdown/reboot
>> are prone to errors depending on the device state or mishandling
>> by one or more driver. In order to prevent a device hang in such
>> scenarios, we bail out after a timeout while dumping a meaningful
>> call trace of the shutdown callback to kernel logs, which blocks
>> the shutdown or reboot process.
> 
> Again, this is not a "device shutdown" timeout, it is a "the whole
> system has not shutdown this fast" timeout.
> 
> And in looking at my system, it doesn't shutdown in 10 seconds as it is
> madly flushing a ton of stuff out to the disks, and they are slow
> beasts.  So your 10 second default would cause me data loss on my
> workstation, not good!

Thanks for pointing this out. It is exactly what I was worried about ...

[ ... ]

> Isn't this just a bug in your drivers?  Why not fix them?  Or if you
> really have to have 10 seconds to shut down, use a watchdog timer that
> you trigger from userspace and stop petting once you want to shut down.
> Then, if it expires it will reset the machine, all of your policy
> decisions would have been done in userspace, no need to get the kernel
> involved at all.

+1


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


