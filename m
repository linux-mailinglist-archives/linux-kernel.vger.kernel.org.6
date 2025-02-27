Return-Path: <linux-kernel+bounces-535691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB4EA47614
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DC516F4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1782165F1;
	Thu, 27 Feb 2025 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cSa0GA6n"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBD1EB5C3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639171; cv=none; b=a9CZlEDgHT+lIZZ3hFsDtpSMB3ZzIdAK0kB3pr+m9K6QxVLW1k645cnkJp3LpTHaHJmh1gvNHpl33KZoj2NaQplkuXhwfiu01nF9RGJn4adLBy1DTbbQMXN/ugO1Wl3eO5Cje01TyevXJIAOhQ6RQLKrEUUjIklUkCdTW2/gU9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639171; c=relaxed/simple;
	bh=nCNzOzI0M08HDeRih4DcSzJJGnhcXPq2uXN+1l25rxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoawTkCqqoVPMhMTz2nrRPjvRQyxOviA0WLl0dlpByFkGrKwnjwjm2kEZVaG1z+IQqX6lc7Vm85gAKyua59Iiukm/vPsoD3p7owIHecUwXrpHTxWd5TbhObiSacZ5lyUS6WlWCsnbNj96kCkdMlqg1yNijpD4HBA4vLYxbdkuIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cSa0GA6n; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso750045a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740639168; x=1741243968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5gJzktVeCYVknQ0iZmn3IWaawV2VsWlJ2cRGNF8zFY=;
        b=cSa0GA6n5cfSYip+aCPvFUMZrdqOAuHS9rq5vR+9RqSeiGvKS3TN3G1Q33UeOm5T0s
         sibhIn5E5oTEN5QVj3LaD9QckGfuVKpZ446gU4wq0p8r02HrrxFIVPg+23dAN3kvJKwc
         lLAGrlfBqk09pkQT0Afe/NrViZiWfCM22U5PwDAyBJk8HaBeESJo/NPZ5pho6L2uvbzs
         O6nyd1s23kB6hn+5Kj0+Px1fltxzWg39i/BErCnZCAk/Og3J9vrPgAvhCsgP2Ebdv+K8
         9/djpTUphQMjp5ClXdXCeKBUSDjH4gTmWVfjiAmF1xooQu5DIythxIrWsHi6X5rSX6kl
         g+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740639168; x=1741243968;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5gJzktVeCYVknQ0iZmn3IWaawV2VsWlJ2cRGNF8zFY=;
        b=xH0hpIcy5/JdUXu3Y8SNI2mXrSPXaPESzE6BR+ZE73oW7yHt8t5htzW9jrvsAyudZt
         fQ4jImSMhvPWYjv8vnbC7JX0Uf6ugXw+PWTDx/+j3peo8O0iJrgzZNvqPquQkjts/jJ3
         ORQ5yxo43tIh3e60biF8wLIQ4ouz+fXA7nD9vf5CojSQsB8+Hi2FmqX6aoXRKHBbyVBG
         jctk04g+YwhtIylnpsc4F5cxI1aGhhDgcLz5h/cf0Mqmo/b5tx4KdWxosft7/jnpOow1
         JjFM4cuujLBpcCO/zhL1k+ku6WWNUL67QiRKX2P+RIJpdA/yPcWFfRZDasR8fx2iuXBr
         nXBg==
X-Forwarded-Encrypted: i=1; AJvYcCVv4KG3Hj74XnE3QQG9c/W0uB1Bi1AIS22iiFZ9+rSvhmGnG8LhiaBRSBBGavQlGqqEnwPMYPLlUKwe01Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlRezLnPD/cypau+Wu3h+it8+fKRg8nnSHgVv1s33hEwziHWKv
	LLu7H2ZEAESPQe2eXmYOLrOGOcYnfuzqbPgtiOyk/36WVXLdtxEDyXewevjwuns=
X-Gm-Gg: ASbGnctOpLWdzQGrIbmA9zGFY57wbRY8hO4WyIZgeteeutXD+VyPEO/qty3mHAFiuH/
	+e/rCpLNPSMjAH4/3ekQWaTitySiNIlKzBDlpittnvoCQA5WrxxUewc8gmPnuSWjB2tYjoyk0wt
	Z3t7S7zozjmgKtmkLoTAObDSwPjDZossN3SQ1oqrke+pc4f8hGJiBEf9zE3gyFkEVS2/Z3QpnlB
	+KX7phcBLP4WtW/FKdch52ptWPl1G+MOHeDl4eCi3RWspxl8IaPTyPYKhii78mI1NY1xsLcEx/t
	UeeaO1oQYJH9fhQ8MXUqdpvjv7SVJf8rAV33B5lqjo1WENW9LIvhcw==
X-Google-Smtp-Source: AGHT+IFs3oTL57k8VMeDm6SW8NEkHfbS1D1KPyJTNe5tteokiINydQdw4BRZMV0DHNi4YHIy1ByIaw==
X-Received: by 2002:a05:6402:40ca:b0:5e0:922e:527a with SMTP id 4fb4d7f45d1cf-5e43c17fd68mr28243300a12.0.1740639167500;
        Wed, 26 Feb 2025 22:52:47 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9961sm74476966b.10.2025.02.26.22.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 22:52:47 -0800 (PST)
Message-ID: <73f00589-7d6d-489a-ae40-fefdf674ea42@suse.com>
Date: Thu, 27 Feb 2025 08:52:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] KVM: nVMX: Decouple EPT RWX bits from EPT
 Violation protection bits
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jon Kohler <jon@nutanix.com>
References: <20250227000705.3199706-1-seanjc@google.com>
 <20250227000705.3199706-3-seanjc@google.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20250227000705.3199706-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.02.25 г. 2:07 ч., Sean Christopherson wrote:
> Define independent macros for the RWX protection bits that are enumerated
> via EXIT_QUALIFICATION for EPT Violations, and tie them to the RWX bits in
> EPT entries via compile-time asserts.  Piggybacking the EPTE defines works
> for now, but it creates holes in the EPT_VIOLATION_xxx macros and will
> cause headaches if/when KVM emulates Mode-Based Execution (MBEC), or any
> other features that introduces additional protection information.
> 
> Opportunistically rename EPT_VIOLATION_RWX_MASK to EPT_VIOLATION_PROT_MASK
> so that it doesn't become stale if/when MBEC support is added.
> 
> No functional change intended.
> 
> Cc: Jon Kohler <jon@nutanix.com>
> Cc: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

