Return-Path: <linux-kernel+bounces-271329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D4D944CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EB62865BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25621A3BD1;
	Thu,  1 Aug 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iYQgd5ap"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA91A2C02
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518023; cv=none; b=RJjNdKYZ4YizH4JtaDecM1AxNqgM4VGDWVuUHFf0UpAHW+cWEROZOL1D+pVw72v3YBOSfAQHqxM1nT5ZHQR0GmszKZnwYqG+4QQTnz6JqIs/qCEG7Jsv+dhPNCa08fvcYYrmEXG4tZAOxFPfHNxY0CULIOtRATGaXCg+sFe4YFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518023; c=relaxed/simple;
	bh=i17q3MxC8UZOjzJ5q1XrZvM2lY0NUUgdr+d+AnRPFS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZp8r3LTenadH29d4k2rdwYMtRK4F8MittEYKe8rVFOXp7pOOeY5ql4TIzyKaskGx/H5tjSqGqQvwtI2LxX5ChgYUcIsijc3M8HoytgjWUVrK8XUqdLpCGZWivT/9bmw4kcpjp4H67HErlMEfT1j+W7PoVHIggoh7z4uWqROTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iYQgd5ap; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0eed407a-bcbd-4edf-83b7-7c6fd992c1ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722518018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGnjhX09ot7hozQmwvy5QM/ATkTqYGsUMmYuOjud9vo=;
	b=iYQgd5apQj1jfrt5LAz0bz/RkYfVdHnQ8dFbnlcFSZ8nW/6jNrAXCnhswv5bnUhMmPRa2c
	azcrkQnIS3FQ0BSxT52D+vs7G1VYSTIhHgz2HByvwzBMgbso38sz32mprWL77JTGtDrVL7
	61XQHRPiUvKuGEXWp3EbcUqbq8mhP9E=
Date: Thu, 1 Aug 2024 21:13:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] sysctl: simplify the min/max boundary check
To: Joel Granados <j.granados@samsung.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org
References: <CGME20240715150300eucas1p2c7b7124555f53da23db4e47636c3300d@eucas1p2.samsung.com>
 <20240715150223.54707-1-wen.yang@linux.dev>
 <20240731071904.xiydz3icjslwaxzl@joelS2.panther.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20240731071904.xiydz3icjslwaxzl@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/7/31 15:19, Joel Granados wrote:
> On Mon, Jul 15, 2024 at 11:02:23PM +0800, Wen Yang wrote:
>> The do_proc_dointvec_minmax_conv_param structure provides the minimum and
>> maximum values for doing range checking for the proc_dointvec_minmax()
>> handler, while the do_proc_douintvec_minmax_conv_param structure also
>> provides the minimum and maximum values for doing range checking for the
>> proc_douintvec_minmax()/proc_dou8vec_minmax() handlers.
>>
>> To avoid duplicate code, a new do_proc_minmax_conv_param structure has been
>> introduced to replace both do_proc_dointvec_minmax_conv_param and
>> do_proc_douintvec_minmax_conv_param mentioned above.
>>
>> This also prepares for the removal of sysctl_vals and sysctl_long_vals.
>>
>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Joel Granados <j.granados@samsung.com>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   kernel/sysctl.c | 107 ++++++++++++++++++++++++++----------------------
> This does not cleanly apply to current 6.11-rc1. Please send a v3 that
> applies to current release. Thx

Thanks. I will do the change and send v3 soon.

--
Best wishes,
Wen



