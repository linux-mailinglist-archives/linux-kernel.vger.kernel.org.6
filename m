Return-Path: <linux-kernel+bounces-260662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF30D93ACA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32506B211B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2650A63;
	Wed, 24 Jul 2024 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsC+P7Rt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB874C84
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721802539; cv=none; b=JNZMr+t/RHJ1wRZXL15Siijgbn5QEf/XBfr0ROQh/hM7K0Dt6AKu5AYR6HSezqZnJ86RGf4ZJ7+4sEsteO63VCZfxarLNtEpxpYUZ9yse+SwsTh5qtjfnillqV7jSKFku6P9/hCfeZEAiP06gmh5DwddoWLQIHDsr2n2qm2eveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721802539; c=relaxed/simple;
	bh=uASP+JMxMMmPBGgRmZCqbRjzyEGVMtEwTF4yquREtms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIe7oz8CrjJ1CRH5U1l/I4MTYz0D6PMqzOjblQ532gIsuG4pj8bd0tHDdXHDlOJMa+88fTXon96kR1fb8uFXNCX8bkK+p9GlanW7w72JID/OCbJSs/uL9BnB9E4Ee3Lc75BjM62winrgj/wbtcGcxLUFT23SJPae3wB9Zk3Wd8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZsC+P7Rt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721802536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sl5UAMpv2XYq9Umb2p36EWELOghYbI4YfvjPZK1djk0=;
	b=ZsC+P7Rte7tx2KbvqsCgBU6BimQYS3o7yZRkFF4bp0Ydj+0CdlVLaoPIsNK+ogMiSK+cm8
	NptQ5j9PtoQV/p1gI3SnBS3M6NdRJ8bbf+SXkAkoxOiQGKKhfuOBbcKKWnL7TZb+uzCp11
	KwhDxJw0nUjP3D9YwFYTdoDQG51Ejs8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-s87HLuBlNn69svAoylNOwQ-1; Wed, 24 Jul 2024 02:27:44 -0400
X-MC-Unique: s87HLuBlNn69svAoylNOwQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-426724679f0so2133245e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 23:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721802463; x=1722407263;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sl5UAMpv2XYq9Umb2p36EWELOghYbI4YfvjPZK1djk0=;
        b=Gfn0BNs2dUanA1KivfviAo+AP367ccTgqHQ2HX1TEELeGVdoJUN7Cwhdhj9A4cDyeb
         jON54RTDu1sLdLry7YSbzVjPT0LLiGQbTut2zAOezQH+X34c05iHNPodnfh47TRE2trO
         Ua2AmVxFU7i1mnwJB58TOyS0WPQPAZ3dMpdIo4h8Gduf1P2y4TXe5vmKj2jL45gUdXUi
         7WBP4bNCCyr5fwrK5P7VMpjEpSOQSLbo4j0hBSfW03d9XGcSEjeYCI0xKVebWLMVl+lp
         wRLT8P94DxiarF7U/EGoViWPPl3RbbcNXYZnivxJdK4I+gwPNbYmk/0xCkBw8UICQ5CV
         IWrA==
X-Forwarded-Encrypted: i=1; AJvYcCUpcQCPpqMfdB6e2J9NYyMg7fd3gyaqOIKEiwZmcupA13JX7bZ/GYTyKkTUHzMJHGufb5lAMkLKIHsdoA4BPQUmqLc3mlbcCIh+l5Tf
X-Gm-Message-State: AOJu0YzcbykUmQJseWCbRHWW1/CWV/3R+jHYgodLUQFfqXOGPQkSGUJ2
	96KrbhSMyzDOnj+kac3NbJD98y3PWQ7WbZ6NeGRXXD0n7jxnzBXxv/kcLf0HdTkPUdwCSdfvwKi
	bQyxYLPnEvX1C0xri72zzzBhZvL31tKEm4dKzpVzYdoBrIWsL52+XhENltGwQqA==
X-Received: by 2002:a05:600c:1d05:b0:426:698b:791f with SMTP id 5b1f17b1804b1-427f99eeec2mr5265815e9.3.1721802462980;
        Tue, 23 Jul 2024 23:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWH+SHwCbzQePi0hbRFy2JjgHeMpdBEQ5VpKKuXElaAt0q80kHWA0I0z576dq8tAvcD73Qsg==
X-Received: by 2002:a05:600c:1d05:b0:426:698b:791f with SMTP id 5b1f17b1804b1-427f99eeec2mr5265695e9.3.1721802462562;
        Tue, 23 Jul 2024 23:27:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:bb00:201f:378f:5564:caeb? (p200300cbc739bb00201f378f5564caeb.dip0.t-ipconnect.de. [2003:cb:c739:bb00:201f:378f:5564:caeb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93aabdasm14034325e9.36.2024.07.23.23.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 23:27:42 -0700 (PDT)
Message-ID: <51bef112-67b5-48bb-a855-45ad25e05ecd@redhat.com>
Date: Wed, 24 Jul 2024 08:27:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix maxnode for mbind(), set_mempolicy() and
 migrate_pages()
To: Jerome Glisse <jglisse@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>
References: <20240720173543.897972-1-jglisse@google.com>
 <0c390494-e6ba-4cde-aace-cd726f2409a1@redhat.com>
 <CAPTQFZSgNHEE0Ub17=kfF-W64bbfRc4wYijTkG==+XxfgcocOQ@mail.gmail.com>
 <6be6453a-15ce-4305-9a7c-a66e57564785@redhat.com>
 <CAPTQFZS7KTTor+CHyzwE8hVVZo04haWsyTHhN9+Hy35PVZ6O1w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAPTQFZS7KTTor+CHyzwE8hVVZo04haWsyTHhN9+Hy35PVZ6O1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> In any case, we have to document that behavior that existed since the
>> very beginning. Because it would be even *worse* if someone would
>> develop against a new kernel and would get a bunch of bug reports when
>> running on literally every old kernel out there :)
>>
>> So my best guess is that long-term it will create more issues when we
>> change the behavior ... but in any case we have to update the man pages.
> 
> No it would not, if you had the fix and did not modify applications
> that are smart about it then nothing would change. Applications that
> are smart will work the same on both patched and unpatched kernels
> while applications that have the bug will suddenly have the behaviour
> they would have expected from the documentation.

See my other mail, this seems to be the expected behavior since the very 
beginning.

So unless I am missing something important, the only thing to fix here 
is the documentation.

-- 
Cheers,

David / dhildenb


