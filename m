Return-Path: <linux-kernel+bounces-402476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0119C2823
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B8E1C21AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD85C1E25F2;
	Fri,  8 Nov 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="hXYUvvOI"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF31A9B53
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109011; cv=none; b=B7kLa8R0ztG0FC3IHZ/i1E/IqI0WuvIER/otLnHLZ8owX4MQdD7E0r+Avwbexc6wg1jFfLfZTFyDnrPDlIo8mfOSe0RMbhuFZt9dTP7+qVcs9orfsVxTnCD5JzaQujvK7K/iaK/eiyjo1Y3C7q0AtKOB6NNz8PE8ZUdCMXuafTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109011; c=relaxed/simple;
	bh=3d/jIwsZ/ZicnzlNsDbS7eR5QoweLJIhaU1VXxILJs0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lIeMnDr06+KM8VhuPyvplS2JCTjOXKMBqnpc0SkELb1gO7aSYUD+l9W2dTyloQfXdj9Bgcfz5vBQgXl1rB33/namXjHx3jo7zhLoI9NDgZx2XEBpsGOTVfKAuGwQrveE8CWoUf9ZUTkcSLlosJMNgNa1/9BoRwY41MXWRpj6Usc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=hXYUvvOI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9e8522445dso452677466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1731109007; x=1731713807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d6MsMrVv0bMMfI4mJu/kmqFfOPAOIvey0wCxyuyIfCo=;
        b=hXYUvvOIfN+nsIkQSI2j3WvlDxTtopcJoKHa0ecPOKq+4Hn9It5+MuBx9d5aqncOKr
         WBwfQD6E6bIhOTX+FXPqhYB4qEamc7Cc4Y41xp7jOWFFx1vS4SJT1KDPYYvRo6uRVo2S
         T3dWD0QcJ7jt1q07pgT2ol/nm2f4BxV8YH5vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109007; x=1731713807;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6MsMrVv0bMMfI4mJu/kmqFfOPAOIvey0wCxyuyIfCo=;
        b=qXmXp2zXxKqgscPJRCMtmenXRlkXBSi1+1U3SrnPWb3QYMwHUme9/zPFefKw/Krh59
         NU1U1QofIOfSy8oMuFUMdzxp2mruzS8t+WoYWSMYX/DylFm9LxZCNKxVzMpcd0N8H4aU
         TTD6xChuNzf/8UPqFz3NvvZou2spJnd5wGGdFyY9tCk6lBBE38CmKzMrQeglvkA2lf7f
         QuDqcXlNbLdPv8rRRmB8z2Ws6WzeqLc1suldSiRFeNU23JKdAneLXaCtNsjtDz7ZsYKE
         oux04UOrtmT8Dv8pDrdC70rCGw6iSeRklkibwsV++uNYh/iJHsTZmipzWifCYGGaOo3x
         YLRg==
X-Forwarded-Encrypted: i=1; AJvYcCUPSiCTLgEp+W085YS2PavfISGTiGSmKKtpuE6rS9O0L+8955R9wGW0BCEQdhIbQz5MerqA0LXS5UgKuOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxmLjFcLHLHGCQHyDgpTDj/KDY3Z31bpyfqy9cZBmm2/nd7ycv
	UyvmLr8qerGts1avqw9eHHd9SLLmT9nDztphz/Q1lexspp8wJgv0VY4ZpVm40nAJDEtN9PWZvph
	b
X-Google-Smtp-Source: AGHT+IHNgZENGKuE8P52GzlblDf6gYHM4dUvqhU99lT3qRj/LRIIOlJ2PjZPS/VnX9LHl/EVLxCNJA==
X-Received: by 2002:a17:907:3fa5:b0:a9e:b287:2808 with SMTP id a640c23a62f3a-a9eefeafae0mr446252166b.6.1731109007640;
        Fri, 08 Nov 2024 15:36:47 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a7d3sm291015366b.70.2024.11.08.15.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 15:36:47 -0800 (PST)
Message-ID: <59718ea7-efab-4975-a4e8-89c1d114a2e5@citrix.com>
Date: Fri, 8 Nov 2024 23:36:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dave.hansen@linux.intel.com
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 x86@kernel.org
References: <20241107170630.2A92B8D3@davehans-spike.ostc.intel.com>
Subject: Re: [RFC][PATCH] x86/cpu/bugs: Consider having old Intel microcode to
 be a vulnerability
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20241107170630.2A92B8D3@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> You can't practically run old microcode and consider a system secure
> these days.  So, let's call old microcode what it is: a vulnerability.

The list becomes stale 4 times a year, so you need to identify when it's
out of date, and whatever that something is has to be strong enough to
cause distros to backport too.  Perhaps a date in the header, so you can
at least report "status vulnerable, metadata out of date".

Also, you want to identify EOL CPUs.  Just because they're on the most
recent published ucode doesn't mean they're not vulnerable.

Under some hypervisors, you get fed the revision 0x7fffffff.  Others
might tell you the truth, or it may be the truth from when you booted. 
For this, probably best to say "consult your hypervisor".

Failure to publish information, or not publishing fixes for in-support
parts should be considered a vulnerability.  (*ahem*, AMD)

Or you could just simplify the whole path to "yes".  It's true, even if
people don't know.

I really want to like this, but it's a giant can of worms, with as many
political challenges as technical.

~Andrew

P.S. I do like that you've labelled debug microcode as vulnerable.  It's
just software in a different form factor, and we know how buggy software
generally is.

