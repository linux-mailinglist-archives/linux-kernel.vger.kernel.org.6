Return-Path: <linux-kernel+bounces-325229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313CC97567B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FA41C25DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667981A303D;
	Wed, 11 Sep 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CZKvIOj7"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61F1DA5E;
	Wed, 11 Sep 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067434; cv=none; b=VKkKnAfpq9ccdVbmU9ck1s0fQndYsBDa8kKBeDVmZtT4S37C7a7vOLnMlZw/vjsbwAft/OqsB/8yUrliJDYtKBUX4ze50LUi5bOsAf75oUCPMz8C57x3b2rJAgKgfU5At5QxXq4AnczOoKJuxdXVWQSrZ14BiOdoD92dwzmRG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067434; c=relaxed/simple;
	bh=jKRMmVrA0oabeJgO6HQmJU/Kq/BN+bLc7Eq02gvZhTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Avm+zsgP6tKZ9cfk9IuDSbOk0ryhtUHRACpA64Y5w818XgDxP5nSU7kSbpbAu+i+ziOvd4SkGGaJjmtGVYKTP5tyZaCXYWKWT3ge4a9eoBFc42lxWiphF8fpVp0cLq7nsHF9vU0Ra5DPLiZMF2e+y9ihY9cH0AUkx2G8zIvwu4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CZKvIOj7; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iSUmAoKbkFC1zgzAwsv+m6BjssQM8FyL0ByRqeFy6+I=; b=CZKvIOj7HFsJS0sdHhYovrfpue
	oo92pRbxJYzGUfB2zrQwfScKO4eESbCllOLYBd6xMu4DIFZ5hQjmPaN6p+FSw/zaAPn99YsB8o483
	FFW+GGCJHG8uedG1UApHD93E3r55OaLsWXNKe+gfZnhhaKFK7BPxJeuKdJmWKC3xRiaB7BaVjnNLU
	GkHusTCXSwzDr2eLMIwMJTIQmx9E3QoWTiNpXcEMm+w56j7+N7zT8aDU5fwuqOo9TbExjAygmHnIe
	HKcNAymcqlf64ASd/BMN686Z49TG/j8/r2/TlOXW5J4M/3jh1AY1p7NNvos8B8QW6E+0VzKQ4biCk
	0Xo7ZPcA==;
Received: from [195.69.0.8] (helo=[172.21.208.109])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1soOzD-00CUVu-4l; Wed, 11 Sep 2024 17:10:27 +0200
Message-ID: <121b62a7-bd2d-0ded-97a7-ac890831ca63@igalia.com>
Date: Wed, 11 Sep 2024 17:10:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2] Documentation: Improve crash_kexec_post_notifiers
 description
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, bhe@redhat.com,
 corbet@lwn.net, kernel@gpiccoli.net, linux-kernel@vger.kernel.org,
 stephen.s.brennan@oracle.com, kernel-dev@igalia.com, dyoung@redhat.com,
 vgoyal@redhat.com, linux-debuggers@vger.kernel.org
References: <20240830182219.485065-1-gpiccoli@igalia.com>
 <20240902082342.GC23170@kernel.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240902082342.GC23170@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2024 10:23, Simon Horman wrote:
> 
> Hi Guilherme,
> 
> Some subjective grammar nits.
> 
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index efc52ddc6864..351730108c58 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -913,12 +913,16 @@
>>  			the parameter has no effect.
>>  
>>  	crash_kexec_post_notifiers
>> -			Run kdump after running panic-notifiers and dumping
>> -			kmsg. This only for the users who doubt kdump always
>> -			succeeds in any situation.
>> -			Note that this also increases risks of kdump failure,
>> -			because some panic notifiers can make the crashed
>> -			kernel more unstable.
>> +			Only jump to kdump kernel after running the panic
>> +			notifiers and dumping kmsg. This option increases the
>> +			risks of a kdump failure, since some panic notifiers
>> +			can make the crashed kernel more unstable. In the
> 
> nit: In the configurations -> In configurations
> 
>> +			configurations where kdump may not be reliable,
>> +			running the panic notifiers can allow collecting more
>> +			data on dmesg, like stack traces from other CPUS or
>> +			extra data dumped by panic_print. Notice that some
> 
> nit: Notice that -> Note that
> 
>> +			code enables this option unconditionally, like
> 
> Maybe: some code enables -> some configurations enable
> 

Hey Simon, tnx for the suggestions, will change in the next version.
Cheers,


Guilherme

