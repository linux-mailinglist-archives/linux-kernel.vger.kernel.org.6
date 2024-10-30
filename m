Return-Path: <linux-kernel+bounces-388692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D149B6326
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BDD282AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2D1E884A;
	Wed, 30 Oct 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFRe41tY"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6811E4AE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291789; cv=none; b=cOFdlGbihk0tWi8zPPe1wjMVk6dGAjtXqmgSHO1SDzsJ7YnEvrX4Fb2aGX/kX5/NBmVbtIUbb9YD56QicQyPlA01djzDARVZqh41L5GY/GdWxHGziFTfwYttgbNlNAUiwix7HJMUduSf0YAIGVua4SFQHo0p1dcmdxHA8Qn1UUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291789; c=relaxed/simple;
	bh=1KULsa+6j+6JCRwXetM56Lo0Zn1gw65F9feRGJpZAlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAQeIDMdawseQMq8+/qL9+/5NR33mgS/gtkm5lhpUpQue9VWpAVBFTGShxTJ/5l+FZnI6iSrzXq+uWJVxjsMD9uHoNjJh+uB/vCxduN1jgNHnxeQ/3/3evHGBcDxxBmtBzKm8N5CEgcdgOnINRdXEF6PgPv2mNDrMTTU43vVa0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GFRe41tY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d3ecad390so528737f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730291784; x=1730896584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dz8ORMovlm8PCaRFyxkHztKoIVxbuXiuAHwjiXhbYNM=;
        b=GFRe41tYh0/0RJ4DTtspjGPX7JYeR2XtAqYQQURty/da+ccLsHqsTsEkFG4M6C8e06
         HBsoK0KL2Fl6s42bnC9iXFlUgezE2/S65fXHTmdJmaWzfFHNeqXZCnqYBX6nwmF8en0z
         9UkFYKz+rndqyUQEfhKpqVDo8PnWTUKmKxwwtjlOqtaO9TGIRd/xWpw90KXgfpnxceuZ
         rt1KuDE3nZB6Q4Ua7C94dJaNNHOuiB5oaO32roeUuwGrw+u5kQy0zVaBeZbUe6VP/MNs
         dAyzrkrQpPO5VBnKULe8r9qnab267CzmtIKXht0joYDIUNdXK0/+DKAK0aEHLmV1Vgb0
         32Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730291784; x=1730896584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz8ORMovlm8PCaRFyxkHztKoIVxbuXiuAHwjiXhbYNM=;
        b=TFsvPyVcPcV28tqi4gBXzsKG3jIAFM+3RgV/AJoPnAa07DtsJ0+i7qeJkpPZ3iJmIG
         HeLpAgQ8LTwpWozmbNZas3qH2dUApypMJHb8mn57dUmgUC6apgZwRdZiQXsGw63aiHvq
         R+mtyqnYFnBHDgVrtjZkFW4T7lDAUfXicXKGXIR/8EsIqt8bT2P2AXzIIRoDJAhu22qo
         F17ChNyNCJ+Lf50xIx/sJ5SSh/kF8n5Zmez3DBjTxXO3qgr/u96lMB9xFLDANw/ZCO2D
         SaR+nDRzv6KkcCRcCLHCMrO1CKIa8rurgMtU4zRwRf2SL0swsqOMJMjyROSQJzH2uL9E
         yH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0csG7f0o0HR1/rHnfBImJ1eqBrSA04IDTJ5gucN5/sdHyDVAGXXR+EXA7qSgfxKLGz5WyT6I1R9askug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jlbje9D2e5DLWhL82FrXW+NN7CWzaOgA0sSlBRz3jr6JvJ42
	AE4Ql6YgbnmNK2nrMlU8LXjmo/rVFyjiKvNTqlL7n9YTjosomxJryfcKe8bgjbI=
X-Google-Smtp-Source: AGHT+IH4FRnmdK9aLuDppBh7wG3Y7nEnBh681TyLIF03sNmMciY0XgRonlSoema7XbLW/dKKGVBRtA==
X-Received: by 2002:a05:6000:504:b0:37c:fbb7:5082 with SMTP id ffacd0b85a97d-3817d649f89mr4690368f8f.25.1730291784286;
        Wed, 30 Oct 2024 05:36:24 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b47952sm15159285f8f.48.2024.10.30.05.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 05:36:23 -0700 (PDT)
Message-ID: <8dfeb9bf-3326-4d04-8dfb-fea9dad85864@linaro.org>
Date: Wed, 30 Oct 2024 12:36:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] scsi: ufs: exynos: enable write line unique
 transactions on gs101
To: Peter Griffin <peter.griffin@linaro.org>
Cc: alim.akhtar@samsung.com, James.Bottomley@hansenpartnership.com,
 martin.petersen@oracle.com, avri.altman@wdc.com, bvanassche@acm.org,
 krzk@kernel.org, andre.draszik@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-9-peter.griffin@linaro.org>
 <436b02c6-a262-4015-92e3-454d444e877f@linaro.org>
 <CADrjBPoq2jbrMC7wBrjGxMwQ1ebTtBNRQzQ7NfE9=Gw9_4LQ6A@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CADrjBPoq2jbrMC7wBrjGxMwQ1ebTtBNRQzQ7NfE9=Gw9_4LQ6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/24 11:32 AM, Peter Griffin wrote:
>>> Previously just AXIDMA_RWDATA_BURST_LEN[3:0] field was set to 8.
>> where was this set?
> It is set to 0xf in exynos_ufs_post_link() function, see the following line
> hci_writel(ufs, 0xf, HCI_AXIDMA_RWDATA_BURST_LEN);
> 
> As all other SoCs expect the current value, I've left that assignment
> in the common function, and we update it in the  gs101_ufs_post_link()
> specific hook.
> 
oh yes, as a driver quirk.
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

