Return-Path: <linux-kernel+bounces-535846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0E1A47806
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64225162D18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E0225408;
	Thu, 27 Feb 2025 08:40:24 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8B113A3F2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645624; cv=none; b=SekpOSMUe+/CgPch7lbQ6One3M6q+K1oPVExOHPzaY91dV1MhrTw4SThmT1ImHFXTKYSXMUQ1TvChGjfzppzZOk6gGdZZCirpWUwWGbTBqwfOoyId03a6H3Tjxv2vWrKTOJJJ1pd5NCIdVa6zy8TUBTov6k4rEgEUb3BLOjAJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645624; c=relaxed/simple;
	bh=nColKHUfd6CQxn7HFMEckKSt5OqnMibdX45ZXSik6y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQTT9E4nBS7DOiexfP/mCx6NzVmRSYGKE/NncC89x+riW86F6knO3liXwN5VQj6piE9Ny8JRxcz2druaoB0GhJLofCughalWGVjxX++30RElgGPkmwgbJ4Dbb83ZlUY2V9kYcxjWsADBUFhEwQelbnpOaZZsuDEfKMW19sioCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so369025f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645621; x=1741250421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBiMrYaCwEpTtq0SMRID4c5oa7BMuzwnJ2AuGWplzGo=;
        b=UojRwKkVWRL8IT+8Nat5bylt9UzPNxTJxSLdYf3Ll5avOZq2LQf3jrKU6u3eKoG1xT
         Lk2o4pSJrDtr8ced/FzuYikKl0tEWjpil+IM6SLXdH/gm6ub2+6flSx6fTbhDbU2Pn0P
         kLZ6SBR19k/JtFS+WyBlhK4BfNSHDRGiSjbF8RVPhRjHeShCeyrqSKO7mYXtRDK+u3lW
         tjtX3m3sXCRpFHWoiI3HOe64hF4eFUQKqdGi6wr8vABy/TT3ErbfTP7ro7jnShHEFOGN
         MMI1oAWFDhkmM8jUKgDLyq02VcfA0sNB2YEGTRIEwUd04HY1PcoAXsk1QkWVmPn9jsCG
         dEIA==
X-Forwarded-Encrypted: i=1; AJvYcCVFATC/6IGnA6ZHgJl1z8AGnPP/C83ks0nJXbKyE+//FE49CV1XOzsvaOH87MnW9X1jMjudquInjm01pBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/T0vc8UNO+w+HvD57pkxDrR13oC8blS47YW1YKCHtipUA7idP
	Bbez4leWvcgInQ+fRGrQkM18NZtFiyVklrAlT3d61RAaUhWhmYSdG/TYzf+n
X-Gm-Gg: ASbGncvkzvHo+64X4S4G8ikuyxYRupIDnDVK1XTIinE0wHLchOWp7wEC0NVSqZpDl5Z
	KqPBj8DwiiplQyDA2dEGf+Gd+qMuSnyhHnyXA2ECZyTFBt+6PqZ7niCy5+TUnx0L1OzuC+2P/CI
	aYxpWa4q6vQes0ecKsSBiCbo3L1IOiKiMfepw/UZdVnJGy1hiud0eplswd+pErqeBmZBjOwgw+j
	g0FjWAsHepSwH6LB75FufDsXAXJolfgAQ/EU6lsVKcmpifGeuTGTMxkOHOGHa90rf5BFp2kUxj2
	iCkruLnFkfofGBrvdTJiOW+gCBlSbJu57KBDDf6w702IliK3yBc5VrmEdt4dCf0ZXqXA
X-Google-Smtp-Source: AGHT+IHCj1YDxnzG0WRO886qNsWeimMlVbhzY+geKE49V6NA2GvjXeyoTTXBC6i2t7dhRbH5sHTj+A==
X-Received: by 2002:a05:6000:2a5:b0:38c:617c:ee2f with SMTP id ffacd0b85a97d-390d4f3ba5cmr4706618f8f.13.1740645620811;
        Thu, 27 Feb 2025 00:40:20 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5393e5sm46589845e9.20.2025.02.27.00.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 00:40:20 -0800 (PST)
Message-ID: <cfd791d0-f394-49bb-86a7-9f13614c4c24@grimberg.me>
Date: Thu, 27 Feb 2025 10:40:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
To: Hannes Reinecke <hare@suse.de>, Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250226062841.60688-1-ebiggers@kernel.org>
 <03dad20d-1293-47d1-a55d-8430fcefc0bb@suse.de>
 <20250226190122.GA3949421@google.com>
 <7ccc3a88-b92c-45b8-bbfd-af98ab439be7@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7ccc3a88-b92c-45b8-bbfd-af98ab439be7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27/02/2025 9:26, Hannes Reinecke wrote:
> On 2/26/25 20:01, Eric Biggers wrote:
>> On Wed, Feb 26, 2025 at 10:37:55AM +0100, Hannes Reinecke wrote:
>>> ... and it also eliminates a sporadic crash which we've seen
>>> where 'snd_hash' wasn't initialized when sending PDUs.
>>> Thanks for doing this!
>>
>> I'm not sure how that could have happened, since the ahash was 
>> allocated when
>> 'if (queue->hdr_digest || queue->data_digest)' which seemed to match the
>> conditions for when it was used.  But yeah, it's certainly nice to 
>> not have the
>> pointless allocation to worry about.
>>
>>> (Note to self: check the nvme-tls code for crc32c usage ...)
>>
>> I have patches for nvme-tls almost ready too.  Just been taking my 
>> time since
>> I've been updating all other users of "crc32" and "crc32c" in the 
>> kernel too.
>> And I need to decide what to do about skb_copy_and_hash_datagram_iter().
>>
> If it were me I would _love_ to switch the nvme-tcp recv patch over to 
> recvmsg and kill the ->read_sock() implementation.
> ->read_sock uses a completely different codepath in tls_sw, and nvme is
> the only user of that. So there's a fair chance that we might miss any
> improvements or fixes.
>
> Plus we currently have no good way of handling TLS records from 
> ->read_sock(), which is something we might want to do in the future.
>
> So if we had an equivalent for skb_copy_and_hash_iter() for recvmsg()
> I could revisit my original patchset and work on getting ->read_sock()
> replaced.

Indeed, we want to calculate rolling crc32c as we copy the data vs. 
doing this afterwards...

