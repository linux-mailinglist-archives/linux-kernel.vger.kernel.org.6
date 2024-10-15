Return-Path: <linux-kernel+bounces-366029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ABD99EFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CE01F22218
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D611DD0C6;
	Tue, 15 Oct 2024 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQaWoYzR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056A1C4A00
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003258; cv=none; b=HfaqODuKJ4JdZdi4Ybe7pe8/84lARzPoE10G24TuQXlXk/5KstdOpKNLEvWXXCFL17LCW2dNpI9tWvzKAjGNxT8pKY/fSiLVOe3YSXMyusgnniaCNRnc5xz/qhM5lto8N1+rc6aEG4luusPH2kAH5Y/tiXR3FigTZFZFZELPqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003258; c=relaxed/simple;
	bh=S7fN5J8Lg5YnzBWTYYlglS+mC2vo+3bgPIZri22xKOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SR0nyioXuVPXC4A0ZVcFDMNH6UEfAPdtKz9a21YzzECZFPWyVgXHpUt+/CDPLYTswIwFgoskk0TKCYicIbXZNHe/7TnbvBt/TQfBqYKwzRx2WdkqsCQjBFWLTq7TTg0Ht0GjLR4BT2UZxFbqfO6U4ESBm6sQX2qYimyj6vge1cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQaWoYzR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729003255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4PLQa3VvP4Ln4Udj1blaUt/K6lWUViRUXc94QV9z4T0=;
	b=cQaWoYzR6LVltADUEEPcP9rY6yjXoB4HjBRLpKNyrjAT2WMoyx+udGyuw5rkHWgKqwxzBA
	xusd2eDjvs7P+WGXO1+fvod2iYQkgGOZJxAIBOeV+YlIELL26Zqkeige4BbdPi67FO/Db9
	WxFcIkdm4KobrUmuchz13vQmSWDjd7c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-ZDt1lNzcNoqAYPlDJBEGhQ-1; Tue, 15 Oct 2024 10:40:50 -0400
X-MC-Unique: ZDt1lNzcNoqAYPlDJBEGhQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5606250aso1571473f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003250; x=1729608050;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4PLQa3VvP4Ln4Udj1blaUt/K6lWUViRUXc94QV9z4T0=;
        b=Mc0W6ijdF2Ji236ga3HrLB7kQFZWCnSJ8rrNx1rMboOI3CRDtud9Nov7IsGwfASn9L
         W60jiSobvrDU5K40wi76w1denMrPeEUnNggkgLyStuZUBql/3VbYHF13QMVcG/3XwfO7
         cGLsBE8tv9rympWluuRWH3xhYsxfz5M26KkxUVfruDs7pFJy/QwyPbuR62VHsFYAmkOm
         SPvfxXS4HgQy7GAoyc3zsd7dQFXFW9VEfMr+aFl2+rHtkCreAau7YtFLMROtGzZ2SiXb
         Ow0wRHafW3AxlbRSld5h/JHqnMFePX/B0TY7EtTh5XjBvaiQtSmNJZXcsyI4OIJSxr+8
         YAOA==
X-Gm-Message-State: AOJu0YzRm38t/J6Bj+PZX2YCtZad9S0Vem9zHUtsBZXCdcSWW5PEym2S
	yQINR8Z/d5Tm6ENDwyFLsNwDBi7pfM+TZz+noJTTcdYaphdv2w5UfX5uE0goFot+fCmem0G+OWf
	StXcGsGXmua287v4fLDgMFAXtTBpWPklnU31s1FX2rfatomz6qEv68DZy58syUw==
X-Received: by 2002:adf:a3ca:0:b0:378:e8cd:71fa with SMTP id ffacd0b85a97d-37d86d3c5e6mr460069f8f.39.1729003249588;
        Tue, 15 Oct 2024 07:40:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUV0yv1UDYAKYQENDUUq/Q1tCsFsthpDbodjV6SeiGL8Jum3Qtlr8d4VbGKmz07TahxMStfA==
X-Received: by 2002:adf:a3ca:0:b0:378:e8cd:71fa with SMTP id ffacd0b85a97d-37d86d3c5e6mr460047f8f.39.1729003249186;
        Tue, 15 Oct 2024 07:40:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c730:9700:d653:fb19:75e5:ab5c? (p200300cbc7309700d653fb1975e5ab5c.dip0.t-ipconnect.de. [2003:cb:c730:9700:d653:fb19:75e5:ab5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56a6a3sm19822505e9.20.2024.10.15.07.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:40:48 -0700 (PDT)
Message-ID: <ef49981b-b4ae-4a39-bfb2-7c2065d7bc98@redhat.com>
Date: Tue, 15 Oct 2024 16:40:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/pagewalk: fix usage of pmd_leaf()/pud_leaf()
 without present check
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>
References: <20241015111236.1290921-1-david@redhat.com>
 <bu3aq2gxcfkjxocu3uzowvevlv6rgeihepc36cwuhh44xqydkc@3ghgml6xnlgx>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bu3aq2gxcfkjxocu3uzowvevlv6rgeihepc36cwuhh44xqydkc@3ghgml6xnlgx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.24 16:32, Kirill A. Shutemov wrote:
> On Tue, Oct 15, 2024 at 01:12:36PM +0200, David Hildenbrand wrote:
>> pmd_leaf()/pud_leaf() only implies a pmd_present()/pud_present() check on
>> some architectures.
> 
> Should we clarify what behaviour we actually want from arch code?

We probably should document somewhere that things like pmd_special(), 
pmd_leaf() ... should only be used when we know that the PMD is present.

I wonder if we should even add ways to detect mis-use

Jann also raised that recently in a private message, that it is rather 
unclear (well, and repeatedly leads to issues) when pmd_leaf() is valid 
to be called.

Thanks!

-- 
Cheers,

David / dhildenb


