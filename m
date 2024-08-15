Return-Path: <linux-kernel+bounces-287995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699B3952F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E041F277E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0DE198E78;
	Thu, 15 Aug 2024 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gvbpwq3K"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3919DFA6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728756; cv=none; b=dSr+zgltOWGHA15wnAzdi+Ewt5Q8CKqgTnJNLkUcxxsZ2pQIxhsfUMF7WgUM7sPWeIDRDOhl9rRH4rzgz8Znl5fhtkitiD/5dnfrt+Kp1HQBSwf2W+I5NQO8dcB2Dmcim+KxVVSDJddWu3+/va0j4UggAF3U0n+VTFKVtLYTyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728756; c=relaxed/simple;
	bh=+hcZ/NB/zrvlloIKjM3Y/VgaSg1YW6GN57pBgQtJD+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJunJLVFgtVU9XYQSpMMlAkFX5n0i/ZNaIM08PXiD5g6dyl9i2g/Cp9+5z6s174W/stEe7sawP1wfe776/HiGxjFBDq8i1UHV595tZLzFjFhADdHFpFhXKFTc6oKQMaOLNateM7IVasV88PHOr/YQHC5nbg43ZPlMLE0T2TyXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gvbpwq3K; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aac70e30dso111527466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723728753; x=1724333553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8zXAuqY3CZjwnnH2CQ1ELNWwnsIYLtO8vuSWwbGnpM8=;
        b=gvbpwq3KBfopUFBARJkXd7iWJPS9vyZjwZfBd/5txIlqoJDFPHYJM3Y6bIWr+Gn3sY
         LXo++N9QGiiA/t6e4BeWx1lCWOn4l5oXeqF5bkcct4sELF/ycgPcwTXZ3uJRiUP0cCAM
         0ddHudThO/Tqsetn182sEhN96lM6Xd0qXCnbwVNnOl8tiGvSz6weKGbxAmiH0EW8v6WD
         seI+i4VNxWmiQ3cmxx63XdONS9niaKKr1cuSbcX8VL0hZea9DLyOLT76X7kSPHtUz6hB
         MbAbjCm6cF9L7uGtUDrnPCC4A70I0L5kfXVc4axN4ZbWXZN4RydvnQ9ShBv4lDyA5HgN
         fsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723728753; x=1724333553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zXAuqY3CZjwnnH2CQ1ELNWwnsIYLtO8vuSWwbGnpM8=;
        b=lJ07wpvXR5OaDJZSkEQWtcVDrZme2TpR66nDbNhurKgrnh9nSaGUNTryjVrjL9tDBe
         UC/MoGyFivMZ8Zpzfvb5wlF+LwZfZqibAdQiYz/JVp9ISPeTy5fZBPwUeBm5Ga3dhpI9
         r5fG1E1g6hRTD6ehmID+qAdWHAbp49mxLW/Q8O7MSFYIO9kzYO0UFo5DZbCSRqOBlhVL
         EgJNeROREaTKjwZ3ro0hzDcZ2hL5L86NqmeNetuGaAvTyXnRzcMJZ0C4VOF03+BIP774
         83iysPHeJYxG21dQ+vYaNsc9pdpqNScoN/ZXChwXQpbqnGzHqPks2wT6GempnAu5NIzX
         GS/A==
X-Gm-Message-State: AOJu0YwrJGHzUwX708YE15E1G7D9/KHo3KJjC/Se6rZXUhdr/GxyZgAS
	/QtIN8mrD5XpTMPLXQI7llyH6NhmoUnnfkEKlf1aqYT+aR8hElEZmJy+KE6fNuM=
X-Google-Smtp-Source: AGHT+IGucy+SPZEcoRQb67/gDR2h50bksAKMcx86hThfEkkg8FTO21B7NGgUWX3TRrnhsivjalNdoQ==
X-Received: by 2002:a17:907:2d94:b0:a72:aeff:dfed with SMTP id a640c23a62f3a-a836702c436mr461354766b.53.1723728752835;
        Thu, 15 Aug 2024 06:32:32 -0700 (PDT)
Received: from ?IPV6:2003:e5:8741:4a00:60e5:7bee:fc48:e85c? (p200300e587414a0060e57beefc48e85c.dip0.t-ipconnect.de. [2003:e5:8741:4a00:60e5:7bee:fc48:e85c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6c1dsm102907666b.5.2024.08.15.06.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 06:32:32 -0700 (PDT)
Message-ID: <c2536a0c-4632-48e9-badb-0e0e682abf8f@suse.com>
Date: Thu, 15 Aug 2024 15:32:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] x86/cpu: fix unbootable VMs by inlining memcmp() in
 hypervisor_cpuid_base()
To: Alexey Dobriyan <adobriyan@gmail.com>, boris.ostrovsky@oracle.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com
References: <20240802154253.482658-1-adobriyan@gmail.com>
 <20240802154253.482658-2-adobriyan@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240802154253.482658-2-adobriyan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.08.24 17:42, Alexey Dobriyan wrote:
> If this memcmp() is not inlined then PVH early boot code can call
> into KASAN-instrumented memcmp() which results in unbootable VMs:
> 
> 	pvh_start_xen
> 	xen_prepare_pvh
> 	xen_cpuid_base
> 	hypervisor_cpuid_base
> 	memcmp
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Acked-by: Juergen Gross <jgross@suse.com>


Juergen


