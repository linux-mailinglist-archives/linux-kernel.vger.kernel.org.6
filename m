Return-Path: <linux-kernel+bounces-570802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23765A6B4A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A923B5CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90F1EB189;
	Fri, 21 Mar 2025 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gf1ZXQz1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E2F1E0E15
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742540118; cv=none; b=H6y2VZsPkSE3HvhQeIPuQGYnqnSuIIeqpZjQEZNxvDmtq46K2PQLSBsk6eQPlH+tp4v30R2ZN+qtTYPLZFHReVgIb6xiwIubvPFxsIIeNh5egr+Tq/STnOIlftMDnL0iwPrVd86b61a+SvBMvJmHefd2U5/UEDAJot1P0TK7mGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742540118; c=relaxed/simple;
	bh=rHJ58OXOHFqvJ0svHAgsQKtQLLKbzZwbHXMAMaHOj/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1OpmZiaYSdTZr5xD55IipZ4tKG8s8xTaDzJ6q4pY7MZYkxFgi+VVDuk303CY1J1/zScUw+TPllcv0V9s9AKK17TpIWe2RXbl9ojYcH5ItBEk3KIDxH9gztfAqIjfPJLtu6FKt9qwphJ5nXD1hKVj+Vsqfxd6t++H7hjUU7Aat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gf1ZXQz1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742540115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMWt8YvXyabuaMyB83WYD5/GSI63ZBxdSuLqDERj8Os=;
	b=gf1ZXQz1+GINkgk3vrlCQt+8rsT1Dyp7qI6oj0+Lhfy01lbiMmxbzqXLBHZmbFceDs4j2j
	4CTTHu+lM9CHHQiU2Kh6W5HdC/gSrqwG0wAYzrI8lVKcc/nIAQRf9PnLHNNUxcxTmyInbO
	EpqzrKTsQi5UGKGEMaR6D2Qrip4Sang=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-DV8WJU0FMbO018X-fxCZ8A-1; Fri, 21 Mar 2025 02:55:13 -0400
X-MC-Unique: DV8WJU0FMbO018X-fxCZ8A-1
X-Mimecast-MFC-AGG-ID: DV8WJU0FMbO018X-fxCZ8A_1742540113
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2240a96112fso37683375ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742540113; x=1743144913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMWt8YvXyabuaMyB83WYD5/GSI63ZBxdSuLqDERj8Os=;
        b=FBYTvz4RtZSx96/6lrJVGY73TOTAsZXKg8QxqbAwxXWOqMSqQ9ZvOROBeOCFblyDA6
         jyxetbjLCK1qC0yKZ4IFjBgD7VYVtOpjaBroGMN4xicfK3KR1EwXomzWErQuaek8RjHl
         N3D9lNMpi60qCAWLO7q1WHE3Yh9vYltO0qk+cfvknifYKA073S1ZMpwBL3DpYaIbvQPZ
         Bp8UYSrKR7g/QYzymT9+9/G2tQ9Lu57O7FnV7Ttq1jC7KOwPhRhIvi9QAwAPFqbg0gfV
         8xM4B58MWDFF+CbKHtgiQkOyk/VBnoPJ32Lud+QR8sSno8myvw0JZowiQ/tTPIRe5rPq
         WLnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkky6fQCSgO0OGiemBJff3ZMvxOYHpDAASuuF8l4CGgJoZro+O9HiCxNJFpOByw6sxZKHz3JeDXIe7F5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVLyWswozG4r2UDIif6kiz1u5590jUMSICCkQuclzZACm7zKXy
	Dubo0WvmsjI4Em3OTyoKYaOnAJOFIqwCilwmipykcjR+a9yUoTr3V/BcuRaXLSWL+9gp6+N4omJ
	nBvWgEmOy1D+hO2S75JzBnu23QFXrTcqQuPyYRnjp20xBe4fPg0CFURc170yQKA==
X-Gm-Gg: ASbGncvpjluuN/LNKntJd1/0GUVtz9X5/bhKAxR+hOOX2GVzW1p1ChCLp86Ij2uyBgw
	zyR+SYdPTphPn/Kk/g/9GanpifSn84/qi6BOACQPK6Jt4QDmvzPLtX1tLcA+CwMDy3VnXaDNLlP
	9yGNjBrw/umrgbwcChhLd116jow9UjeULFNxwSmcTThTOs6BgjAKca8IyovzdPAjyNif0teN+fd
	4xgWK/13CXgi/eLBbSqAckreKrySYqb+bfJuSdcnlQ0bZFdPBz6AORM3SqV0sx5x/p25PMjdtQu
	rRTcZ3U=
X-Received: by 2002:a05:6a00:1954:b0:736:546c:eb69 with SMTP id d2e1a72fcca58-73905966986mr3013067b3a.9.1742540112609;
        Thu, 20 Mar 2025 23:55:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUJjdikKFu9bVdd5Uc+aAJpIZjuZhFtSPz+rAzYpY6fPM3oklYwQdBYym81w0q7yVcYtU4Kw==
X-Received: by 2002:a05:6a00:1954:b0:736:546c:eb69 with SMTP id d2e1a72fcca58-73905966986mr3013024b3a.9.1742540112161;
        Thu, 20 Mar 2025 23:55:12 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600bad4sm1053637b3a.77.2025.03.20.23.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 23:55:11 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:54:35 +0800
From: Coiby Xu <coxu@redhat.com>
To: akpm@linux-foundation.org, Dave Hansen <dave.hansen@intel.com>, 
	Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v8 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <jx5dxurvzupwsdp2gma3vi7baijmqd4co4i2ilhsbkucdzxofj@ucvpictjctb6>
References: <20250207080818.129165-1-coxu@redhat.com>
 <Z6sljm1lurDKPCvj@MiWiFi-R3L-srv>
 <Z7vNMJPQPr4N6Dih@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z7vNMJPQPr4N6Dih@MiWiFi-R3L-srv>

On Mon, Feb 24, 2025 at 09:36:48AM +0800, Baoquan He wrote:
>Hi Andrew,
>
>On 02/11/25 at 06:25pm, Baoquan He wrote:
>> On 02/07/25 at 04:08pm, Coiby Xu wrote:
>> > LUKS is the standard for Linux disk encryption, widely adopted by users,
>> > and in some cases, such as Confidential VMs, it is a requirement. With
>> > kdump enabled, when the first kernel crashes, the system can boot into
>> > the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore)
>> > to a specified target. However, there are two challenges when dumping
>> > vmcore to a LUKS-encrypted device:
>> > [...]
>> >
>> > This patch set only supports x86. There will be patches to support other
>> > architectures once this patch set gets merged.
>
>Could you pick this patchset into your tree since no conern from other
>reviewers?

Thanks to Baoquan for endorsing the patch set!

Hi Andrew and Dave,

If there is anything further I need to do, any suggestion or feedback
will be appreciated!

Or if it's more appropriate for Dave to take the patch set to the x86 tree,
it couldn't be better.

>
>Thanks
>Baoquan
>
>>
>> This v8 looks good to me, thanks for the great effort, Coiby.
>>
>> Acked-by: Baoquan He <bhe@redhat.com>
>>
>

-- 
Best regards,
Coiby


