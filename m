Return-Path: <linux-kernel+bounces-536007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98610A47A69
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C453B371F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8CC22A4C9;
	Thu, 27 Feb 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lKA/IUr/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409B22A4CD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652524; cv=none; b=qNjZdtNkD+V/y0By4y6OhXW0173PXZM+jlDmxgSex5bV8OahNmwdSYmAN6YQ3K4u+DeiPS+zGGDocKPY6ISERtM3oPZQe5NkhrlZpVxcrWVNa8JFa57XO9KMEWSyokzsOtNVOuoXVVbswIgAy1WVhgM0it/+Tz6xuyNSz8uDHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652524; c=relaxed/simple;
	bh=iKpo/ANNRvS7PqVOBTD5Z1674Bqo1hkwWWaLg3oYq/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKM5mtaCW+v1pzo1ANS8pDMx4DnPyp4cwcn63CDEt9lAZcKdLSFWDXYYC9bJLKSUc0LvW73+0nnpjZs4GTsrbBiyPULfUTAU8C2gGXcFXIsUM02T7wfoDuZsLKLeN5VktzWmAKv7etgG/bZcNf2XoVMKowOt+TxMJ6o3SjWW7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lKA/IUr/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22333cad7ecso1712055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740652522; x=1741257322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/7qJ206YPz+4moTXTgU2pFLpIcu1g5hcyPL7GWlHTY=;
        b=lKA/IUr/ygDezzdU4Onmlp/pMdI3ui9Riz/vh8hfrtCwCgGci3iPo5bV/GXplSAd/0
         FPkc624S7RelUFbVjxFkTlPqq3KwttgW3sxL+vKsFP7r7B5x4AEnVTndnMnoMGdmyh1I
         mECNIUPzdTZ5kZPj2FM7bEwVQYvGnErj3qmAmW2/K3RLIepf0jQh0uk9G3IkUW+F9kTI
         AMfjVKQPWXeAKVNYQGwvszKXpbcDomPEw8QE5sts55a3UvQTBKpJRF5GKGfIrjYZXtA8
         Xr82c7HWUC8ehW+teJ9cAC492778mEmxlKmSdjOkR+cX6FS/YMKDlGRJMGKexqbP2Mic
         H1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652522; x=1741257322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/7qJ206YPz+4moTXTgU2pFLpIcu1g5hcyPL7GWlHTY=;
        b=C1hgMuw9EksA4NY02g3QAu5FJ55uUgqppbUEl77jAsBoYQmeYzgVI76uGLkgvxzRG4
         eeTqaLPuorrl3mnL1PdBIfuvvi6BSeNBu7vAICIai8noniw23M0n1UifPhTDKUQrlRKc
         XcqexTix9vi5x+2ajiX9OCS1oGf5eyMg4Bh3k0hWVyFjZCIN6Qhb28yL15ucSL16sjJs
         HizsmhfLIh8yf8PgyobaTPKx0zdGxEzOxVLZFESQppBbzYEFOusqIvFtRcXHGyT36yEc
         Gw693bRnlqiGyTIFT8dRBg23rh1m2UiDSzO3wTvBMim8kwjBO8RZblHD0HKoynebSFOh
         XuYA==
X-Forwarded-Encrypted: i=1; AJvYcCWO5yZ8Mo3ebI6jY0+7QPjIvFVcU07Rmy+F0BiwIIpILECNOmGFgtLhPCFRMRLi7DL95ws+VBlOsLNOruc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1yP273SzKtULQ41SYyCDfYcgrAA2K6Os4NwvJd1hWag3ihcX
	SvJvNojtXbujitkQO82LHNdeZ6KtdsQd13hYjMPWGlLh+uTKdfVk/ldbNwHmrvk=
X-Gm-Gg: ASbGncs39VKUYWUCR+x4d/iKw3TbUqEimA49iJpyY9DcFiJCFT5jVi4LZMY7ocVyIPS
	fWFmAuxo3aVLsDUG1rsXuujDwxu5Fla06yE2ok011q1cxMwfQyTUfKtcIoZILGzi71vO5lrg+rE
	b5xxmV30o0dlOzOsVaSrKyXQvVOXcNNbup4j4MYOQ9DuJcT6iE+00kmcjxVriOg3hETYomzp0y/
	JyYH2i4qz+wgWlhzkF9JzAnSzK+efoAqE52TF7nusD3FxzOEu14INxDaKvtlP14E3hA5bKxsV3n
	Opg+iESwLJnXCzpcmHgrf/5u5n8bnPShblcWPNYTTpnRSvn8dg==
X-Google-Smtp-Source: AGHT+IG2eF/KWw0btmV3OvJSgHHBcrv4Gz4eHM/FMCZ95Yqt3G9ljdaRFO2LLQCu685+laUbmi9fYA==
X-Received: by 2002:a17:902:e84e:b0:223:49ce:67a2 with SMTP id d9443c01a7336-22349ce69e4mr17507655ad.9.1740652521119;
        Thu, 27 Feb 2025 02:35:21 -0800 (PST)
Received: from [10.254.225.63] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fae29sm11171955ad.95.2025.02.27.02.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:35:20 -0800 (PST)
Message-ID: <9ca0b984-7b6b-47b2-8784-1e708599170f@bytedance.com>
Date: Thu, 27 Feb 2025 18:35:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix and extend cpu.stat
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Yury Norov <yury.norov@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Bitao Hu <yaoma@linux.alibaba.com>, Chen Ridong <chenridong@huawei.com>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250209061322.15260-1-wuyun.abel@bytedance.com>
 <puq53yk7guef3itr4d2uq5ka2m6cdbdflzzdumuvs2giyefwns@2e5ynejmu5ht>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <puq53yk7guef3itr4d2uq5ka2m6cdbdflzzdumuvs2giyefwns@2e5ynejmu5ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/25 11:41 PM, Michal Koutný wrote:
> On Sun, Feb 09, 2025 at 02:13:10PM +0800, Abel Wu <wuyun.abel@bytedance.com> wrote:
>> v4:
>>   - Fixed a Kconfig dependency issue. (0day robot)
>> v3:
>>   - Dropped the cleanup patch. (Tejun)
>>   - Modified 2nd patch's commit log.
> 
> But the modification isn't the usage examples that Johannes asked about?
> 
> Also as I'm unsure about some plain PSI values (posted to v2). Maybe
> it'd be good if you could accompany the Σrun_delay with some examples
> showing what different values tell about workload.

Hi Michal, sorry for replying so late!

I am going to drop this patch for now, and will restart once found any
solid case. Thanks for your (& Tejun's & Johannes's) sightful and helpful
comments!

Best Regards,
	Abel


