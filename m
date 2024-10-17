Return-Path: <linux-kernel+bounces-370321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D279A2B16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327A4B23D77
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9431DF97A;
	Thu, 17 Oct 2024 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAbyNTbC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4111DC07D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186611; cv=none; b=OEeLYqWoYryuHNm9xOfs6Bme0k9kVzXUycbjPqt1wBw62SRnKVhN/nv/HUe42jOpl3Hx9FdXOEMwE5wX2qP4N7KWcyNKpG5Oo34tbTsjDOuNJ7aZFyI1bQaxR5NDD2nOCwPWiQgIiN0H1uWsfFN2+a/hyxt7N/aBAHwFKkdz098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186611; c=relaxed/simple;
	bh=Notmywk/KYWvrCyZzCizPenltlf6TbAw9iJe+vFK8nU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GZBFmAVQ5odCqasgRhb3YmGtvr5/l7KalkvrctYHx/8nVGBINs2fiM4Ar+Cd9hVmVtQb6KQHHkaV7d7zBSMwBEyW96RU8BNFR3Ch8ekUHtAA3/qZZYoimzjwt2bYUra6RfrR7b1bMpfdO5J107s/EPOCqy0AiV3Zr3i/zzO5ZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAbyNTbC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729186608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+Cyv9kli0HZR9u7xxjpR63I6TKjlk9cCX5jppYYpfw=;
	b=MAbyNTbCfPf3ukPJCeLSA2CBV4ytLUVJl4Ye3vHPQWtpMXWyVvQR66qfxa6A/0lc90LaR0
	rIW+bQWmSH+jp+onBwCDlaDIaqnFxxp2vVrScyJcTyjf73TKpCBZ9XYTnHrmh9/TSQ45uX
	LxTmveEp5+QdKsVjBwFoZywA03EJZqM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-l8ZyyBw_O26982zjzDzi1Q-1; Thu, 17 Oct 2024 13:36:44 -0400
X-MC-Unique: l8ZyyBw_O26982zjzDzi1Q-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-709436cfb9dso983412a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729186603; x=1729791403;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+Cyv9kli0HZR9u7xxjpR63I6TKjlk9cCX5jppYYpfw=;
        b=igY7xoKU8NqHmuXLX+txGWjJWuNJrgYJ2LwdzrGX69BurH9buZg8X/y51vh3xKkDvs
         jUhlwufNEntgnGuPfvXQzy2AeCcMP5wvVKEa1acdpHWKXlVexXQ0lSE1C2VKy9DoY4KR
         NLfVcd2qy6f4sQ36L/JcYDTRB+R7KpfHc4vhfrexDnTryWMolfCybJxt9COhZQGGTnUB
         a/h92LJvuC53N37lFjW/WCzarBmT8xaDx9Nmw5c1oScQuhPWO2TRi/IY3JrJK/OZhyi7
         7MhcdBhgAjSQr1iNrFxrFAGulPfZ1DpT6tZv14TsjyzUXavW7zOerCMF6FLPeNOnvotX
         Q0sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNqZFLV9Kf9NEl+twDMiwfI9+DHHZDW+vKW5K+ghiEsHncDspq/Imb4dhTDzc7mmJ27/kT5H1j6cH3ujo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpCuSmgtEWaS+Kv0aobaWCi7pYOquei3mYSnGQj1H+hvdtTT4
	9UhK6eFHzSzv8N0gf0AqfBcBwiGipG1rsqKW9xqjw91NyfHSFo6nNd4OIo2bb6ruD8McAeC0T3g
	UmfQgYUaCabEacaaMTExGKh43CHj5+l5pDFvudK94lhHfT8K3iRanFOkyMtIEfQ==
X-Received: by 2002:a05:6830:730d:b0:710:f5bf:c4df with SMTP id 46e09a7af769-717d64b365cmr15298867a34.30.1729186603271;
        Thu, 17 Oct 2024 10:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+KTo2JmByonndrDKcaBKL+hi6z5upfE4x/QBxLrngHndngfco8bUfn8TdS9nLvCauPmK+0A==
X-Received: by 2002:a05:6830:730d:b0:710:f5bf:c4df with SMTP id 46e09a7af769-717d64b365cmr15298849a34.30.1729186602993;
        Thu, 17 Oct 2024 10:36:42 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2ed6e50asm18982056d6.44.2024.10.17.10.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 10:36:42 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a094f899-018c-4eb7-9bee-46f102a33b8e@redhat.com>
Date: Thu, 17 Oct 2024 13:36:41 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
To: Christoph Hellwig <hch@infradead.org>, Waiman Long <llong@redhat.com>
Cc: lizhe.67@bytedance.com, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, boqun.feng@gmail.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
 <20241016043600.35139-2-lizhe.67@bytedance.com>
 <7f7b277a-7019-4bf4-b100-0505c6ce9737@redhat.com>
 <ZxEn0mIcQbu4OHaG@infradead.org>
Content-Language: en-US
In-Reply-To: <ZxEn0mIcQbu4OHaG@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 11:05 AM, Christoph Hellwig wrote:
> On Wed, Oct 16, 2024 at 10:23:14AM -0400, Waiman Long wrote:
>> Another alternative that I have been thinking about is a down_read() variant
>> with intention to upgrade later. This will ensure that only one active
>> reader is allowed to upgrade later. With this, upgrade_read() will always
>> succeed, maybe with some sleeping, as long as the correct down_read() is
>> used.
> At least for the XFS use case where direct I/O takes a share lock
> that needs to be replaced with an exclusive one for certain kinds of
> I/O would be useless.  But then again we've survived without this
> operation for a long time, despite the initial port bringing one over
> from IRIX.

That means XFS only needs to upgrade to a write lock in certain cases 
only, not all of them. Right? In that case, read_try_upgrade() that 
attempts to upgrade to a write lock will be useful.

Cheers,
Longman


