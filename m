Return-Path: <linux-kernel+bounces-295280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E5A959947
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A802869D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997011EED2F;
	Wed, 21 Aug 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUSCZApj"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B51A2860
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233601; cv=none; b=CeN7Wx1aTisb4fNfuv47Dk9g2ZxNgKzcpg/qo6VEykP+JSxWc8qR2Kp7hV3K+gVI+pRXa/juClsW01P3+wIA5IEjGYFfMtFfiNw8mU6E85b5CJSTjGEkzs0KmiucU775Lvld3y6yW6edAvCsISYkjffgnlNZpaGZKAb7WxrB8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233601; c=relaxed/simple;
	bh=BeUoU194BZUhvcq1kg/E3j+ujWEBXrWE0L6BlKD9NrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MORlt1pA/ul2begvEtSYD1EFlRIcMtSHeqgysflvNSdWweFUA3aZnrGicmDOnPcJQCqFEefkVMZ8C8VqzTEn8FVhBD9mjSXnA4tJUqGuQpaBFdkFU+X7sZxXUpZtDA1XNERZkSJ+y7vzEmMEFdiCFr3buOqBi8Wp8fHp6Iqqogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EUSCZApj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37189d8e637so3891698f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724233598; x=1724838398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dc6gXl7afmiTMHEcwYKOq3h83oQ7HnViCn1ZWHpe8CI=;
        b=EUSCZApj/3+rHNDsg/cdL+EFl+ApZuH0a6fL737JGX1LU3BmfeXYsLALGMeqZPdm8c
         xPSmd3tqj0ERSl4Xh1hJd8GDwZes1a8zRpmHb2IfXucG0OnansrjArSD7IwXnJR39t/t
         msLwXe2NcuJrnm0LhnR6vig1GParesgYuF8FpMTIIjE4QNQ4MFPqzxDbbGUj9LSgMRzf
         RiP1n7WhAbCR6HOgcc1aEd1gngL7RGI4nKavGOHzEEl/cE00nqejtl/U+KA/bq7hT1b8
         ML4MFUJME2WQz1oSfF/K8iFILHF2FPYu1s8s/0Usgo/8XU16u4v6gQ5elO5GwToZ+RUy
         yujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724233598; x=1724838398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dc6gXl7afmiTMHEcwYKOq3h83oQ7HnViCn1ZWHpe8CI=;
        b=pKP5YlAKaM9Xn4ZNFpyPeW4vHFNsLGK0oH87qK6JeuBoktxTGTn/SliAuqFxCkRdqX
         2n21AcZiS+UD8hCskGiR028sZkBvHdh5O+LNPfpYOPXWqmfgSLrgRbWsFitsAvmTrKQu
         Bc3vrudwf+qTeuJmNpOKOVMIR9gnh+J+TyIUGm4Oc1VMiVPaFfpjwI/XVFQeDWwCPoXX
         EtXyzsHr505VI8GUpRGoOSmjPYc3rsYqjs9WTKQlu75dwM/Vzj+n2FKpZTYR9JfI6w9L
         juCAHlS2Wmlenud1COc/dMs9kxbOmKX+t6UIW0y+QXZ408agYflfow0ausSqcywAGMww
         Ks3A==
X-Gm-Message-State: AOJu0Yy87NALvReIpCi4a91Q7IIZN5qXz/VM+oqdD+Y456hN8J1BHxFD
	Ym0LsK/uebUeMBzq83DzNkx6ARizaLtGzKmT6CU6lseGaiSV9NBsFFoaQp+/GmU=
X-Google-Smtp-Source: AGHT+IF+Gf25/pZkkWXOobGnXP58MOyKd9peUCyMEC1yOv70kxFdseHl6o0ZoJalCfu73J0VdYKV0w==
X-Received: by 2002:a5d:5263:0:b0:34d:ae98:4e7 with SMTP id ffacd0b85a97d-372fd71deedmr984879f8f.41.1724233598029;
        Wed, 21 Aug 2024 02:46:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-371898aac62sm15128026f8f.101.2024.08.21.02.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:46:37 -0700 (PDT)
Message-ID: <da144002-f1bf-4463-a626-00a97615990c@linaro.org>
Date: Wed, 21 Aug 2024 11:46:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] thermal: core: Move thermal zone locking out of
 bind/unbind functions
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3837835.kQq0lBPeGt@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3837835.kQq0lBPeGt@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 17:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
> acquire the thermal zone lock, the locking rules for their callers get
> complicated.  In particular, the thermal zone lock cannot be acquired
> in any code path leading to one of these functions even though it might
> be useful to do so.
> 
> To address this, remove the thermal zone locking from both these
> functions, add lockdep assertions for the thermal zone lock to both
> of them and make their callers acquire the thermal zone lock instead.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

