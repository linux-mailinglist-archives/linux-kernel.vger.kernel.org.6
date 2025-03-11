Return-Path: <linux-kernel+bounces-557067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CE0A5D330
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8BB3AA43A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CC8233145;
	Tue, 11 Mar 2025 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLdHzJtH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3627B3E1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736248; cv=none; b=PrmPyo30DCcBtzjZWGXhDKqxLWRMtXMTNgY6A8+DZ3xeMOu/Un/hw4FZ0eQJUWa2mwnKlXOD4WWl5AROpSjdgo2/rXrDH+Ia+l1JGw5aFBBK7v35pC9ZdF+UY2hBHye9mi2ntlPWouS0bpWKu28aA4dMPOdi94s1Vae8g8Vbtow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736248; c=relaxed/simple;
	bh=oUIvtGNceobXdNms5N+ZadkSVNrPiQD1Rnua/aRiYtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuqL8QE0jeThCNOERdt6fUo9bc3PNHM9+cZ8WsvMBzW3CbrwdxlWKojUUULRD0q8K0RVe1PbVK2i0ny9JQnZ9U5TgOdlm2q36ufuAE51L9wJuYlKw6NpHAyY88yLaaNPolqyQg6HVNKi3eHW4zNExe8/YUHUJo5900onAuPAvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLdHzJtH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741736245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LddFUV1F39D4LEAK5RrORIUzXh+aCVp+LbRrPqURis=;
	b=dLdHzJtH0HkIPHNzbIMHgNv9Kq8P+Pghb5PnNPG+vVzc2I9JQMbYLHG5is2NOkbknKircp
	sUzMzVotTj18sR0V8saRpUdbg7hTgwzEd1BEPWi88J+EoXfsTbsMHIX5i/kOIQZemKxpDA
	KD5TGredOIaTGFW8XUZX4xoyzD6R+98=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-QjnSAKrQPz-NlLiQ1yAltw-1; Tue, 11 Mar 2025 19:37:24 -0400
X-MC-Unique: QjnSAKrQPz-NlLiQ1yAltw-1
X-Mimecast-MFC-AGG-ID: QjnSAKrQPz-NlLiQ1yAltw_1741736243
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225ab228a37so1626905ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741736243; x=1742341043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LddFUV1F39D4LEAK5RrORIUzXh+aCVp+LbRrPqURis=;
        b=LPP0HGE9zcyksWQY6GkMUoKhg55fpCa7SxYL+/9H1NRD9za1pXfson8vXfvdnyC+Yi
         JdqILvgN+1otgo75S7smTlyJg0l/fgBZt5NNE+vjDvJS8bAL4w/eCwAxqbjXba/wTV26
         26gEVYaJvW+TfQSHSSYlAL9koiUSbWcwa5ql8lXK3QSk3+0U21RTLxhWJKFh8ucT6KY9
         XBK6xeUp0EgxeSHJyHZuJAwX/H9mq34uqxZ03w8dfWxQ71FgWCj0nuVWtAX6OMgJNtyn
         J5kNTmIkmT890toLZweEgIOuPGnbf3SLeTJT0nrrAvmizTenPGvohGELBhp1HMY2GjfJ
         vtsw==
X-Forwarded-Encrypted: i=1; AJvYcCUmlceLKB/cSv4rEWu5xd2hcJ17bTHbTyCDqmzxgyDagoeEqP1BiLsJfnKR2tr3TppE5aNj2rrRqObxkHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqNMm3Qme6eMJKnlZlJ4+phwPkSjbt3hHpE7MXUP8rjzOSjNC
	mHt4X5TCYzTyyIbPM9Si6Og1RlgrSkNKD1OM6Wj2ykhe90zr1vfbBwFpo1xMdCWrx7OD9lg339p
	+KMB+xGxvpay+rikyhoyiOzh6bxXw4IhpxV52KvLSPrD/g38owZL9AsRYhOXitg==
X-Gm-Gg: ASbGncvywfdcT4P88fqHndM0NArt28971IPuAhHPO2Tz72wjNzoy1SbHmYYoLgjwpJ+
	3a2EJL+7D8FYVv0AuttDiVfcEgtawvNpn1pTxUA2BtNP1UpYUCY4LLCyPsb6c8qpBCrHz+GqbCX
	YMREjdg0O8Eub56ii65ZKBYKbhm+ye8aNVPgPnFR/XLlNnUjMkr6sHzEJRVPZzT7fgZTMLO4iLQ
	C9hze59yCkCd10tPjyrkk+RF6QRM0x7Bub+nahKLek3nZD1OWfMlJTY0MuGVWEn4y8aatIjRcfS
	49tT8tkq8FOE8AADNA==
X-Received: by 2002:a17:903:228e:b0:210:fce4:11ec with SMTP id d9443c01a7336-22592e20164mr80445995ad.1.1741736243168;
        Tue, 11 Mar 2025 16:37:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwU/N4rP1e7HqjwA5wywyTr6djrF/Lx99o3+Znj6eGcReNAMn13OPf69eOuu7tnSw1lmZ89A==
X-Received: by 2002:a17:903:228e:b0:210:fce4:11ec with SMTP id d9443c01a7336-22592e20164mr80445865ad.1.1741736242834;
        Tue, 11 Mar 2025 16:37:22 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a81c4dsm103860305ad.149.2025.03.11.16.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 16:37:21 -0700 (PDT)
Message-ID: <87b46705-55bb-4f25-981c-c4bdceb365cd@redhat.com>
Date: Wed, 12 Mar 2025 09:37:16 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/sparse: Expose for_each_present_section_nr()
To: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
 dakr@kernel.org, akpm@linux-foundation.org, shan.gavin@gmail.com
References: <20250311004657.82985-1-gshan@redhat.com>
 <20250311004657.82985-2-gshan@redhat.com>
 <e36bfe8a-fbf6-46b4-9f8f-c44b7352583e@redhat.com>
 <cb351bda-06bd-44d0-907d-9baee76c0823@redhat.com>
 <Z9BWQO0U_LSqdTCP@localhost.localdomain>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <Z9BWQO0U_LSqdTCP@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 1:26 AM, Oscar Salvador wrote:
> On Tue, Mar 11, 2025 at 09:52:09PM +1000, Gavin Shan wrote:
>> Yes, but this series has been queued by Andrew Morton. Andrew, would
>> you mind to squash PATCH[3/1] to PATCH[2/3]? Or I can respin to do that
>> in v3.
> 
> Since it is in mm-unstable, maybe just resend a v3 with all acks + this
> squashed and be done with it.
> 

Thanks for suggestions. v3 has been sent with the changes.

https://lore.kernel.org/linux-mm/20250311233045.148943-1-gshan@redhat.com/T/#t

Thanks,
Gavin


