Return-Path: <linux-kernel+bounces-383817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891D19B2084
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED0E281DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4BD18132A;
	Sun, 27 Oct 2024 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KVAL0ILp"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1317D354;
	Sun, 27 Oct 2024 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061820; cv=none; b=K29XfdJlGTlpd+Q7yG6ScjjZOGyRxprkCbg5NEeNiPY2BeArBJswvEt76BrwKkq9sdVkSEu8QaZXpFe6yZJV1UpXvaFRtQuHtu6pS8GUG3Xvo85Y9BubNc5SQXTWgW2hD9eYpvvHUflVTdK28qphBnKO7+rF9/MnrOq7mVMPSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061820; c=relaxed/simple;
	bh=rp/6cAX8qa+xCZdZgTWi88Vtnh8/7YSPavnh4VoQsqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxRL8Xe0Rh3wbNFwZMce9i1xXf/mI4SAl6oRImfeRNDLMaAaP09N2ugj1zQh+Sd7ymxMEVs3eOMGE2qTiBM/17nSDI7Q8CH4KWKbH4zVvXvlX9aEnNlSbsVJhzfF4Jo1Go7RUHtDcY+5XaFJw1AAmDuwD1lhMABtrOX2WgetYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KVAL0ILp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1T8ILKm4ovamc8emWS1f1es99V1XULDZVRfssxb0X7s=; b=KVAL0ILpywa5Lo2ngSEr1c3Swm
	DDpKcW8zyC70vjJ9/IhyRe9C+5ZDWik1SQrbU1WtGwl/atuqIgj5PYCHAUslmNQ4Znm/JmHYUrDaX
	P/vq2n/ofMGyollaUkkuHe/Ur5VKw9q3M7QUX8FXbYCXSTM8ydjN4mBKuSXo+7gggGv55YTNpuu8n
	G1T1KtmnyqTyYofhsFJ2tLh5k8I+0Awt3f1LiqQnzUzxL/uoqKg3BvWH5htOfMfGRo3QEzbTJP/gz
	ornnrreC2W7RvNiM27PJ02HbGeImEDRORIOX3XRXVUImFLFEvWur7HImNV/FvZ4Z8z8xfsyS9cjDX
	8/k5UzYw==;
Received: from [189.79.117.125] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t5A6j-00FpyE-3s; Sun, 27 Oct 2024 21:43:29 +0100
Message-ID: <a07bc9f1-e3c6-04b4-b9b0-63d33373ee31@igalia.com>
Date: Sun, 27 Oct 2024 17:43:22 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3] Documentation: Improve crash_kexec_post_notifiers
 description
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>,
 "dyoung@redhat.com" <dyoung@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-debuggers@vger.kernel.org" <linux-debuggers@vger.kernel.org>,
 "stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
References: <20241025162042.905104-1-gpiccoli@igalia.com>
 <SN6PR02MB41577D176FD038A3D630296DD4492@SN6PR02MB4157.namprd02.prod.outlook.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <SN6PR02MB41577D176FD038A3D630296DD4492@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2024 15:16, Michael Kelley wrote:
> [...]
>>  	crash_kexec_post_notifiers
>> -			Run kdump after running panic-notifiers and dumping
>> -			kmsg. This only for the users who doubt kdump always
>> -			succeeds in any situation.
>> -			Note that this also increases risks of kdump failure,
>> -			because some panic notifiers can make the crashed
>> -			kernel more unstable.
>> +			Only jump to kdump kernel after running the panic
>> +			notifiers and dumping kmsg. This option increases
>> +			the risks of a kdump failure, since some panic
>> +			notifiers can make the crashed kernel more unstable.
>> +			In configurations where kdump may not be reliable,
>> +			running the panic notifiers could allow collecting
>> +			more data on dmesg, like stack traces from other CPUS
>> +			or extra data dumped by panic_print. Note that some
>> +			configurations enable this option unconditionally,
>> +			like Hyper-V, PowerPC (fadump) and AMD SEV.
> 
> This last line should be more specific and use "AMD SEV-SNP" instead of
> just "AMD SEV". Commit 8ef979584ea8 that you mentioned above is
> specific to SEV-SNP.
> 
> There have been three versions of SEV functionality in AMD processors:
> * SEV:  the original guest VM encryption
> * SEV-ES:  SEV enhanced to cover register state as well
> * SEV-SNP:  SEV-ES plus Secure Nested Paging, which provides
> functionality to address the Confidential Computing VM threat model
> described in the Linux CoCo VM documentation. SEV-SNP processors are
> AMD's product that is widely deployed for CoCo VMs in large public clouds.
> 
> Just using "SEV" is somewhat ambiguous because it's not clear whether
> it refers to the family of three SEV levels, or just the original guest VM
> encryption. Since this case is clearly SEV-SNP only, being specific removes
> the ambiguity.
> 
> Michael

Thanks a lot Michael, for the clarification. I've just sent a V4
updating that.
Cheers,


Guilherme

