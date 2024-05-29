Return-Path: <linux-kernel+bounces-194332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8798D3A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9909B21958
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D35017DE0D;
	Wed, 29 May 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGERC7O0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E8015A861
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995398; cv=none; b=lSMs+/+y5Wkoim4JkwMDW38f+jOQaa4NWBuC3/8rFzSSE2y2Ci2NuPC3IgvZpZzc6JalEOaqTpwMuimYON/MdoOxPi+x2mXpFr8BcPH8HI6iUicyLSnQ1BEDseaHBFLpPgi0INwRz5QHuc3U6zOXNA6LpL6T6/K4I2GmuY6Trb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995398; c=relaxed/simple;
	bh=mlvdMnXQm5x1qWpfm4xuhnDcqdkOQN7ibjz/WVpV/KU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E7KCYVAheYs/2vdT2CtjJTjS9xBLsLAw76WA1aO9LC7YX1Oz7GPNxsom+7WaXLlaq53opWslQ9879xrDYLAa2PhYxS0l/DTbMwfwpq0oEEyDXN9N5TSE1xsr/zXyLABXIfR8sGDYZijlzZIpveZhxVLinm4EJ/lz7VL1gxOnI5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGERC7O0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716995395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/xbZFT1XaokgTezQUZXctPQ0AEMSGFvQXtxdfPhl30=;
	b=KGERC7O0fuP2Ds5C782FhtI5sNeHHDOmn91LkEkA7INivhOaAn4trj3xwyBkDE/tFe/OOA
	0GPaLoWnblG/YUxX6z2F2vEfN9krqqUJu62Ouv+h22qPwjSIBPN1OZNHXB3o2J0QYCjKcJ
	6slu1kgvCZkx5EbsWcxCnq1PXY3Id78=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-HpjW1JK4PiulVQ2P3X5giA-1; Wed, 29 May 2024 11:09:53 -0400
X-MC-Unique: HpjW1JK4PiulVQ2P3X5giA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1f4afa9aac0so24235585ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716995393; x=1717600193;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/xbZFT1XaokgTezQUZXctPQ0AEMSGFvQXtxdfPhl30=;
        b=e27OshSTF8ZDGjXnybzFARbJxNdnKjZx9g1d4zPyfMBDHMZ+3SQNRX1Q7XghekO41w
         WlKmrj/+b2DeeRqJjPFr2lI4kF82NMsWYqFb+i09+Bpk2zkhGrriIHiBj17rutzKDYqD
         bGRafC+AqxjTf6L7U5VHqdntP0oT76A6eDTdT5dEXGJ6R6Ad8dtvM6Bv7HckJa4bbJKS
         UmBrFu+gaThjhicXStyKlG33tXKmK+jwfarPRg1jCJDSBMLiqZmegy4A6MvViFIyVd4z
         P0Wg9WEp3sfOp6T9263jT/qQD1Co4NENn7dI1ZlBjrY+o/+F+GjlX76ZGKCHZVZX1aYR
         9IKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWJOpynJVsbjFrLOS4CzEtj8hj5Y2PDlQyxN+QG/sTq+7lYKTDagOfEfjamppUaeJlWL0QlAa0a31+fH192nPtgnY0erXO2RZGrapQ
X-Gm-Message-State: AOJu0Yys2EIC+hdMkwN9wFw/jqA+jo1Wb71fI7b75LO08gHebhyl9m3A
	NsiTbWMJM+fD7ZuX2leCznOjJrAi6DiBQrhd95oCB7NmKWotzKg6pTQAfy6Ot2tI28pJ5xmpiaX
	Ucr1kntqALe/i4Ivjzlov26bp4kLup6buutG69jEuU/7B5JlbIjJT/UQK4E9e
X-Received: by 2002:a17:902:f68e:b0:1f4:b316:57f2 with SMTP id d9443c01a7336-1f4b3165bb5mr84420355ad.40.1716995392781;
        Wed, 29 May 2024 08:09:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESJIuVqyrSreBzNsGwEIgmcHckygCCtU9UJsKuVwk6bMzlNtWIgx30hhAYQu4JLnVO41POnA==
X-Received: by 2002:a17:902:f68e:b0:1f4:b316:57f2 with SMTP id d9443c01a7336-1f4b3165bb5mr84419975ad.40.1716995392226;
        Wed, 29 May 2024 08:09:52 -0700 (PDT)
Received: from ?IPV6:2001:569:7cd6:cc00:99d0:471c:5800:8739? ([2001:569:7cd6:cc00:99d0:471c:5800:8739])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9683a8sm99923335ad.132.2024.05.29.08.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 08:09:51 -0700 (PDT)
Message-ID: <8c460997-f8ff-4985-9e8a-09697a647a28@redhat.com>
Date: Wed, 29 May 2024 08:09:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Adam Williamson <awilliam@redhat.com>
Subject: Re: Intermittent inability to type in graphical Plymouth on UEFI VMs
 since kernel 6.9
Content-Language: en-CA
To: Genes Lists <lists@sapience.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-kernel@vger.kernel.org
Cc: jforbes@redhat.com, rstrode@redhat.com
References: <75c17881-68e9-40e7-821c-5655d49d7c0f@redhat.com>
 <8fee69cc8fdd67fd265790c0fa287cb9566c2349.camel@sapience.com>
 <165f7cfd-41bc-4c37-b859-a418a3ccece7@leemhuis.info>
 <c5b3d3ec7701b51dd7b163261c84fb54c778b9bb.camel@sapience.com>
Organization: Red Hat
In-Reply-To: <c5b3d3ec7701b51dd7b163261c84fb54c778b9bb.camel@sapience.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-05-29 06:35, Genes Lists wrote:
> On Wed, 2024-05-29 at 15:01 +0200, Linux regression tracking (Thorsten
> Leemhuis) wrote:
>>>
>>>      cpu i9-12900K  / Raptor Lake-P [Iris Xe Graphics]
> 
>    Sorry, this should be:  13th Gen Intel(R) Core(TM) i7-1360P
> 
> 
>>>
>>
>> Does this happen every boot or only sometimes? Could you maybe upload
>> the full dmesg from a boot where things worked and one where only the
> 
> For me it is every boot - the first few key strokes are accepted but no
> asterisks are displayed - and it works fine even though fewer asterisks
> are displayed than characters typed.

That sounds different from my case. In openQA (and the one time I saw it 
live), the keystrokes do not appear to have any effect - no dots are 
echoed at all, and hitting enter does not submit the passphrase.

I have no idea where to send emails reporting kernel bugs. It's a very 
difficult world to penetrate if you're not already in it. A proper bug 
tracker would make things much easier.
-- 
Adam Williamson (he/him/his)
Fedora QA
Fedora Chat: @adamwill:fedora.im | Mastodon: @adamw@fosstodon.org
https://www.happyassassin.net


