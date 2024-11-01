Return-Path: <linux-kernel+bounces-392555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0005F9B957F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AB5B2106B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA01C7603;
	Fri,  1 Nov 2024 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sUvVjXLq"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28D1DA53;
	Fri,  1 Nov 2024 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478874; cv=none; b=JS4Iv+hj/AYjTj61lLjoaMam+pMLAo8vucu0+NSJYmfgEpc7e/zktdevJC9r+eAxBa+3udhC/uCnYOveeJ8aDpM8HhDXIixI55/mufrzPngjfod3B4aefzbjc3qS9aCLFxFGX/TqKSFcgqDJ+6uH3bAo5t2v9hDXSG+yJ+ACzP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478874; c=relaxed/simple;
	bh=X2Sam5HutoJ7iiicXyA8uroAlk8826bkiyUbW3FOC68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/3vASsPFoV34ZPz6wj6yi3bzWsZcUTAYgX3/x8etyoi8x+qz5m7aoNNNbn4Rkat+ku/I58BRq9/MF/O8oNiOTLQE8iavuGExjwr+KhR5yE61T0Mot4VeMpldooNfQAmKcyVlIWb2TlO10Ojrfshk/1IU6k/gV9xa9WfIQeza9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sUvVjXLq; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R5Y/nh7AnHvmk8pCiKMUqljr9HbLzI4ZraaZx298UZs=; b=sUvVjXLqT3rneRt6vfdGSKeCrW
	b2upRg0vLM/mCOkJAyjOUpzEKNSewCcp+EuZak2Q4o46l57tuTjyS6lqqwZA5tlqiFTdbKX8+LyLi
	kx9yby1obuoPpIFf38Fms6iU9uJB8Zy6uwOnRkwEmASnixo4GzhE9KIPe8Yevp+fAX/XNPlMAyAwx
	TRGu4FTESrLdLrFtCk5LIZhAQzczTTxgSDllsMZFAy1MtTN+m1eaIxLnTURo6eYIFtmlPwcvf/dKY
	lS0Hf3E791FyESuflHJtui38qWXc3CqXfl5nKgZY5K7F6iVuttx1Wwn2PxhGcg6Ek+LJ0T/f61PVY
	Qm9Uf/Mg==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6ubJ-000UmQ-9W; Fri, 01 Nov 2024 17:34:17 +0100
Message-ID: <8abab19a-bab0-4449-b1b2-bf9a57024943@igalia.com>
Date: Fri, 1 Nov 2024 13:34:09 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: add more kernel parameters to control mTHP
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>,
 Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241030130308.1066299-1-mcanal@igalia.com>
 <20241030155059.9e27019842ef7c009b728b27@linux-foundation.org>
 <f2a213eb-e69b-4572-b837-0c384bbb5960@igalia.com>
 <20241031181242.96312cd4eff58ba2369342c8@linux-foundation.org>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20241031181242.96312cd4eff58ba2369342c8@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrew,

On 31/10/24 22:12, Andrew Morton wrote:
> On Thu, 31 Oct 2024 08:04:58 -0300 Maíra Canal <mcanal@igalia.com> wrote:
> 
>>> There isn't a lot of info here - please explain this timing issue in
>>> more detail.
>>>
>>> Because the question which leaps to mind is: shouldn't the
>>> "applications that use shmem" be changed to "configure mTHP through
>>> sysfs" *before* "using shmem"?  Seems pretty basic.
>>
>> Sorry about that, I'll try to improve the commit messages and add more
>> details.
>>
>> As mentioned in the example I gave ("DRM GEM objects"), my main use is
>> GEM objects backed by shmem. I'd like to use Huge Pages on the GPU and I
>> can only do that if I have contiguous memory to back my objects.
>>
>> I can't think how I can change sysfs from a DRM driver.
> 
> So your term "applications" actually refers to in-kernel drivers?

Yes, I'll make it clearer in v4. Sorry for the vague commit message.

Best Regards,
- Maíra

