Return-Path: <linux-kernel+bounces-567722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD836A68993
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127403A37BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BED253B45;
	Wed, 19 Mar 2025 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLIjvtj+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE92D252917
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380047; cv=none; b=ARduAgmpb1b6ZvvyU8yhSYuq2CJiFeyyjjUSNLPLhCRMdvXc2IYkCjEyfzhwm+5LQfSziHyMJNypJX0OtjuMyWVwgl30h2knRdIsmBU1Yen9knJD/M4S1W0OGiWPgqkH/LaTSt2B4NxbdKewJ3rZrukfOPdYwhL1p6Vr+b/5e/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380047; c=relaxed/simple;
	bh=bqyrkozSND5Nwqi67cu4PXT4r+KPyK5nBABctNN/y7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEDbLbImtVlseiIGlcD3BOvOuAxprHcQUwfWM8YRrUhB2SB9SrM2rlBBz2o3BxBnZ8n86JOB4iMv7gVex1xanqn+SBskEeIQ0yZapSxNLYOuMGywzWaoVzJoPlU3z98Z1xz3V9GPHASni7iJsXzCevmw0Hn/LukF+bhqIEh/Pq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLIjvtj+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742380044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w6I2VFnsXYw7egElqHpLyRTYmIDRLSZRt374tXWnPyM=;
	b=iLIjvtj+ulN53XoWtggUPkivBbbN0rfcBvFIIvpbweckBRSoObjftdyHjHHwhxwPZl0myJ
	fIkFBqoMovT92Jctt0gokMAFxPqbZfVNYvjyrcJ+hynrSpHW5ggq6cBst5J+XbxVSORc14
	LBXW4Aqo/a0QkoqDNhqH8SL8sGztXFQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-gcyA4hpwMomOqKrHfVDCVw-1; Wed, 19 Mar 2025 06:27:23 -0400
X-MC-Unique: gcyA4hpwMomOqKrHfVDCVw-1
X-Mimecast-MFC-AGG-ID: gcyA4hpwMomOqKrHfVDCVw_1742380042
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912d9848a7so287724f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380042; x=1742984842;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w6I2VFnsXYw7egElqHpLyRTYmIDRLSZRt374tXWnPyM=;
        b=GfIH22co/5UVwK/sCDXsG+pu+i2g+b5iHQQFYjnJF5aDOoyvWKMtyz8MY6kR6nqHi6
         HRkYCHU2XeVLT/duzG6x/9R6gozMdFhAtHfrCdKP3P81B1IhTSoXdHCkVenhf3Wdo1Ur
         ZMKxdQos/zw5rBhpoWSd4GiFSaovLSPUctNDiBRTA2bGm/60VKTnbkfl68hm0JvEud/I
         ctX3DMmw0t6029Z5UqCwXHF4QZxeqFAp6CKx43aBFJOU6UqW0ucnMckGtwenSCbSG5Jp
         7DkCatBL64GsNR018m11JbbaeraqceAQ2XgXswKfqIONESEHqdPpg66bgxzSOwIBDMcK
         CBCA==
X-Gm-Message-State: AOJu0YySZhdvesj6Dft5kgBn5sQSB2X74Jn0n5wU5cseatffa/+Kojce
	1tW44fIDuKSdbNOCOWQrhm4iX7Enu7l/7UOVurpDCAeNfDiS3dwjE9qzTDxp1xM2c08XdB4/U/c
	AEIlI+X4jsuJA4Drf9xpfYY+Xd9dkQOTsMtOiPjm/ARmSi6VDeK86V9QzAM411Q==
X-Gm-Gg: ASbGncuC6rRwtBAQ5KxNE+J000LmVrFAUED0SGC+kxKOKBgRLroH6Q7qPIDLwGwm99N
	elFDPp1Ei3EBVmRBt2OPFTUYyyp/jMHBC1x+H4P9xcIzdnXXwDrzE8STXMe2J067Bgqis1AjPqS
	Oi6mZy9h58w3zTiMA39RSKHn8dyAzSQ/+8OnlgiowrvS41qxUQ4K0HUvsjCqizYjgNApJcvWxCP
	uZuS3qVCBLBAW7+M4uAiVPCnsVeDlrUpgVLfLxrmMTjV+o5zbpq38k9r//kJ0s3dLoUxi83xIFG
	wId8YxkzqX3QZ+N64fgRZ4hN4mru2hCZQekT+MArgwfBHbIonOpyjRBdy5lfe9wQFTT1Sx5WfIB
	bip3RgeKqIHbvMDznU1A9BwJqo5Pz0bKSIlb1SSQtIMI=
X-Received: by 2002:a05:6000:1a86:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-39973c1ac04mr1897823f8f.15.1742380041891;
        Wed, 19 Mar 2025 03:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF697jtjfPAqJaOx+sNTtFGA/kggYGBBC7AVzh2/zkXFnYPMeF6m6RVE9iL68KjM25NVBwsEA==
X-Received: by 2002:a05:6000:1a86:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-39973c1ac04mr1897805f8f.15.1742380041493;
        Wed, 19 Mar 2025 03:27:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:df00:67e8:5c3d:de72:4929? (p200300cbc705df0067e85c3dde724929.dip0.t-ipconnect.de. [2003:cb:c705:df00:67e8:5c3d:de72:4929])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3978ef9a23bsm16338663f8f.15.2025.03.19.03.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 03:27:21 -0700 (PDT)
Message-ID: <faa04276-a4d7-48af-8957-9123cc09f66b@redhat.com>
Date: Wed, 19 Mar 2025 11:27:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/mm] x86/mm/pat: Fix VM_PAT handling when fork() fails
 in copy_page_range()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 xingwei lee <xrivendell7@gmail.com>, yuxin wang <wang1315768607@163.com>,
 Marius Fleischer <fleischermarius@gmail.com>, Ingo Molnar
 <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Xu <peterx@redhat.com>, x86@kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20241029210331.1339581-1-david@redhat.com>
 <174100624258.10177.4534865061014070904.tip-bot2@tip-bot2>
 <fe0a67dc-d7cb-42ff-9b20-9527af7f6a94@redhat.com>
 <20250319095357.GAZ9qUNaWSORZMXdRK@fat_crate.local>
 <50f03347-0586-4284-b02d-b16abf89e656@redhat.com>
 <20250319102441.GBZ9qbaZfRWdYFIknU@fat_crate.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250319102441.GBZ9qbaZfRWdYFIknU@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.03.25 11:24, Borislav Petkov wrote:
> On Wed, Mar 19, 2025 at 11:16:36AM +0100, David Hildenbrand wrote:
>> Ahh, the commit id is already supposed to be stable, got it.
> 
> Yap, we try to avoid rebasing when it becomes really hairy and the commits
> have been stable and out there for a while...
> 
>> I'm currently testing the following as fix, that avoids the second lookup
>> completely.
> 
> Cool, please holler asap what happens so that we can act accordingly.

Yes, expect it later today -- have to refresh my brain how I managed to 
reproduce the original issue.

-- 
Cheers,

David / dhildenb


