Return-Path: <linux-kernel+bounces-249724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7777392EF03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3781C220E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E4C16E88F;
	Thu, 11 Jul 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MB+pvCOv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD454657
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723232; cv=none; b=ScKmjb3LbWYp3ft3VMT/y2Ot1R3fc0MlTBbHvvCgcaYwEjhrViJaukDEnuu7TMDEF4BcJAm8USKl7bT42zhIpFUeHTFM6dqOL8JbAtcMKAYPAERxaOh+44UBZL0yzqN8Zk0AOe/oQY4rzyrLa79mYAoColfUsnQMsDFz5t8qxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723232; c=relaxed/simple;
	bh=NQausatRbjFHKq4sTKCfQxHMv69tIEqX+4KOm2TNc+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHMZGa1zqzGS9/NfvAFdj0NyCE9KSebYs5G9fcHxXzAXcRSHyK+JDilNTo/9lWJwcsbhhnS0MftSVeCMJvTaWPTUFes4Wy6Mj1o2TQcnWoRyDzu7sahTW0Kih2pUVGlEfNozlZeYvmof1Ir65cD0wBrqnH0lP1FR+77zbpFSQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MB+pvCOv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720723229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CBrkSaMFUktnswkqBLyZSrPH+Wt4VFEGzdZQMGnxyes=;
	b=MB+pvCOv70rXRXczm0cYQtOteDhL+O+Af7P9L98rcxIV2hR/ljz+DmwdvpQosMEWCZvE/0
	eXa2Ps6L11DxElxUeVt+941zpHDh+DZ3fAWxhagqVdAqno8HJXuE5ZVZWldbF6VcA+9f7M
	GcpBoMA3/+3cLrD4oqMaiMw8oMecDGQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Wge163hAOQGyJw1PJ9o0DA-1; Thu, 11 Jul 2024 14:40:28 -0400
X-MC-Unique: Wge163hAOQGyJw1PJ9o0DA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1faf6f0854eso8218705ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720723226; x=1721328026;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CBrkSaMFUktnswkqBLyZSrPH+Wt4VFEGzdZQMGnxyes=;
        b=AsCD+nob0SjkUTDnOSFZI81nGYENqcQRibPxPrhRlOC5irdG5kzpyKqf/cPFc81Bg+
         eXbPRCVIvIhDok16HUP4ukugRzqIQkP/YkOX7dYa2DiMz0zVElXLi5KZh5F0x49jZp4R
         akITP0EbLw1GF22eBM/Y94yl8WySLRHD/0pGrZ0vVWNOvjGswtodR3PaJVcxLFXdUszs
         daCrD+LN93qxQfFXLpXILe16RmP30HW9qg4N1TBPSh/oi822dweyK7qPyTDyVoBqvhjM
         GcQHC4R6DbGHQpMLTXaUpKpDmW+iFVtOU7JSuzdAZQgz62tgcLUfn5QSZywBelsafMG7
         aOKA==
X-Forwarded-Encrypted: i=1; AJvYcCWl3d5iE4g0UI+31GCJiF2sgrj7agB6omj9psKkKWwc6NMLe+ktQQDn/MCw87G9o1RqxinDLB1oFhKV62KEB7Pz2hEvMIq8aGoUrr91
X-Gm-Message-State: AOJu0YzBVvxD7gCSaVKPsfykVHhptzYRTj7U9AMVW5njtd/MOdZys3za
	fF/gmDECev3ipO4/7jgz1qvrxcMRofPM0wxEe76JMIxC2NxO+no9lmxyu5GfQVsWnnFQPEe3xjt
	VMxRHr5HI0R4WDZEJdfMhTlnQqLDr9CD4bREtRc8tmgETNDn8iaIhy/HNkqWJv03gDCkSgCpD
X-Received: by 2002:a17:902:ce86:b0:1fb:451a:449b with SMTP id d9443c01a7336-1fbb6efa3d2mr83793985ad.60.1720723226244;
        Thu, 11 Jul 2024 11:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERKKTkFYP5jTi1zKMn0fDAckQFwsUgwcejr8FFQVjvnG4tC0rpT/1dvgRc8O6UGtsDvQRelw==
X-Received: by 2002:a17:902:ce86:b0:1fb:451a:449b with SMTP id d9443c01a7336-1fbb6efa3d2mr83793735ad.60.1720723225904;
        Thu, 11 Jul 2024 11:40:25 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a1089dsm55103495ad.41.2024.07.11.11.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 11:40:25 -0700 (PDT)
Message-ID: <f435d056-a611-41a8-a58f-7603f6475b1d@redhat.com>
Date: Thu, 11 Jul 2024 20:40:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, virt: merge AS_UNMOVABLE and AS_INACCESSIBLE
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: vbabka@suse.cz, seanjc@google.com, michael.roth@amd.com,
 linux-mm@kvack.org
References: <20240711180305.15626-1-pbonzini@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240711180305.15626-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 20:03, Paolo Bonzini wrote:
> The flags AS_UNMOVABLE and AS_INACCESSIBLE were both added just for guest_memfd;
> AS_UNMOVABLE is already in existing versions of Linux, while AS_INACCESSIBLE was
> acked for inclusion in 6.11.
> 
> But really, they are the same thing: only guest_memfd uses them, at least for
> now, and guest_memfd pages are unmovable because they should not be
> accessed by the CPU.
> 
> So merge them into one; use the AS_INACCESSIBLE name which is more comprehensive.
> At the same time, this fixes an embarrassing bug where AS_INACCESSIBLE was used
> as a bit mask, despite it being just a bit index.
> 
> The bug was mostly benign, becaus AS_INACCESSIBLE's bit representation (1010)
> corresponded to setting AS_UNEVICTABLE (which is already set) and AS_ENOSPC
> (except no async writes can happen on the guest_memfd).  So the AS_INACCESSIBLE
> flag simply had no effect.
> 
> Fixes: 1d23040caa8b ("KVM: guest_memfd: Use AS_INACCESSIBLE when creating guest_memfd inode")
> Fixes: c72ceafbd12c ("mm: Introduce AS_INACCESSIBLE for encrypted/confidential memory")
> Cc: linux-mm@kvack.org

Yeah, if we have to bring back the separation in the future, we can 
revisit that.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


