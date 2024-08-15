Return-Path: <linux-kernel+bounces-288001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AF8952F84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138171F23928
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2EE19FA7A;
	Thu, 15 Aug 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZA0WLywT"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11419DF9D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728785; cv=none; b=cYpUKitHCpD5iYYiLCoYDAiAvuvPMSuSkd35InjAt6d8n6XbLnYDK+5VLf/O04zH3mPjmyb3EiCCCQZBPiWEm9b8qhp6CpLftHMy7hwNGPnHaNsPyLTejMyGpWcU+Dxz3KcdICGADkjlGEm6mmVkv2RbnzVeY3jAMoiCOSdijK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728785; c=relaxed/simple;
	bh=PT4vceLLPwKMmVzXSpUqCl3F3S35lCtNHl+KnScZaMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcmUsCeFut/WWhSk9KyBiIreuTFNi53VLpV3/CZHiSQiYU2YqwSggFtTePHbq+GJwob2fzX4844792rfCdMdSEOYGaIP6u4k5ma7r2GGBkyEiDHI6seZVgGCRXeh7tlMa/mAhOx7nyaxgnwGc5AlPqUjcXYJGEqU2h2vFBl5ALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZA0WLywT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so1508810a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723728782; x=1724333582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEJof4v7tyrTnLF9qIrWadPJ+XLa5Cnw4PG3b+6OD58=;
        b=ZA0WLywTkdhgB/J1LBcK51epOcemU6Qftnf66unTTRjjTTpoXlI8AiWtQnIbZcnfT3
         Baqq0WMWRzGtjczJZfLeXqnmgGIcNmQEIgrV7vgTVhuNOoM6MtT9YYDUc/36QvfUPM/g
         CXp8/Ljpnq/IPUAgOQHXicDwMibqXoJbS3CLPpA+bABuvCwQ2N+G3SXUkdZVGB9BJuqv
         JG9SlbiH2sU4BoD/oXuKFGgj7jhqSlGK0OpP3bzohLeZULulNQ5bbCBaxvJctOSEUPPi
         85GLVP/5znzFZQMlcrnKvqHM96Fm4HJS01QicIM7c8b6u85ErYlMs3Vt39wLGLkD6zGh
         rH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723728782; x=1724333582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEJof4v7tyrTnLF9qIrWadPJ+XLa5Cnw4PG3b+6OD58=;
        b=VBXKJL+eY9IhhbWSiw+4kvgVC3K5LaO/foe3mx+uwNDDgItOgfvXwdXdDSrASlgsc1
         nuhhJuyGiRCndarf5yvauMMuxKDo/XSEGJJd7D8Vha1X/dTSk8VHpkBIG1X9741LnoIk
         KO9touyyBV4T92uPy/SDsGXn1E3V+pfCFwIAyXm6XCkfTap2HJYTohgAg87pGhhyjCE7
         QHUEzeRsaoGfT9VRknERvBJCXx8IcGwM9us3JV+Id3IsQ8ChESRlU/vYJqPEQYI/lDgl
         nQUaiUTc4A7nfhb6WDZfKiNhyfXAGHfsQquuk/K0i6ByH/0zpHOolmdiAbvv9AqhQLcd
         NsLQ==
X-Gm-Message-State: AOJu0YyokXqJEu/P7QUNQte6mH92+WNYwoMhWEHZdZqif5k5A8IkXHfh
	GXUyVQgRSiJ6GHPr0IyBmsxUChnKxHVqr/ZMWsoeK2151dBsVfsTqxKOzHHgZT8=
X-Google-Smtp-Source: AGHT+IG2nJRmRHwZEFc8/yc2nSEl5vEmOpqUIA6AVXiRxilGqcN0/zTenfvGbCOA3idJ/dfOlZqvHg==
X-Received: by 2002:a05:6402:f05:b0:5be:bc6b:86a with SMTP id 4fb4d7f45d1cf-5bebc6b0938mr1983205a12.19.1723728781736;
        Thu, 15 Aug 2024 06:33:01 -0700 (PDT)
Received: from ?IPV6:2003:e5:8741:4a00:60e5:7bee:fc48:e85c? (p200300e587414a0060e57beefc48e85c.dip0.t-ipconnect.de. [2003:e5:8741:4a00:60e5:7bee:fc48:e85c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde3eedsm893417a12.22.2024.08.15.06.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 06:33:01 -0700 (PDT)
Message-ID: <bac2c7f2-a92b-401b-a8e5-2f22cb11a7a7@suse.com>
Date: Thu, 15 Aug 2024 15:33:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] xen, pvh: fix unbootable VMs by inlining memset() in
 xen_prepare_pvh()
To: Alexey Dobriyan <adobriyan@gmail.com>, boris.ostrovsky@oracle.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com
References: <20240802154253.482658-1-adobriyan@gmail.com>
 <20240802154253.482658-3-adobriyan@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240802154253.482658-3-adobriyan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.08.24 17:42, Alexey Dobriyan wrote:
> If this memset() is not inlined than PVH early boot code can call
> into KASAN-instrumented memset() which results in unbootable VMs.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Acked-by: Juergen Gross <jgross@suse.com>


Juergen


