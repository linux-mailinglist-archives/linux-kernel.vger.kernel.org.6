Return-Path: <linux-kernel+bounces-570415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F62A6B016
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A5F18969DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DA22206BE;
	Thu, 20 Mar 2025 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3o8RDs+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196A635
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507142; cv=none; b=uJ9nqAWPLU2MRxTTRtueN/GZsECnFFJhKzD24yiDTDEzKkwddGLSLa+Z4SeMntP1glpA4hwU2wXOJkSapY5KJS7DMDDFjD71CqKNJbIdxW6grQ6FYfsMSj5VfV4s785Lb0ekQeI3us9J4FoW2MvcEmxaRTgZXZb3bq4YP7NfyvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507142; c=relaxed/simple;
	bh=SBb3iiDVgGzDDUDb41lF8D/GTxXasUXOzcZsbIghZwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez32xHxX0zsicgeAmjxSiA+iF8u8cgBS9SdDWvkV6kHLUDNdPADik6Ml6CY/Lk+mREqfgBseCUWpxc46IT2ax7jjHhtcGjjVBS30rSTH8CmumKqwlkooqg5WKNm/tqHNmGvWSb3v/+bwa7nufxJTkg4RC0cTQratQA77Asqegi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3o8RDs+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742507139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xp4ba/+3wLTR3mmUwPGvNNnkKeFCX9EMvxtwrFwnWpM=;
	b=X3o8RDs+8ctnmOOv9e8FP40ocfYXEkADjU/xb5WvYVKmmInaj0dY730DeiH4u7YUk1aMxK
	xSbnn5j08cnDDOxQ71VJXH7aDfM+rav5N2QvII5h1d+g6eKfD4wMYSC3zGsLfp3zoOKhlB
	k8cVItTN1nhGN7G5TewrEXdQCIcd2Ao=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-QPcxL1qLM0u4SqD8YIOuCw-1; Thu, 20 Mar 2025 17:45:37 -0400
X-MC-Unique: QPcxL1qLM0u4SqD8YIOuCw-1
X-Mimecast-MFC-AGG-ID: QPcxL1qLM0u4SqD8YIOuCw_1742507137
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85db4460f5dso217634339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742507137; x=1743111937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp4ba/+3wLTR3mmUwPGvNNnkKeFCX9EMvxtwrFwnWpM=;
        b=uHg1/PsgGGy4CEIiuQIZfR/sAnp88p6gWirOn+wiQfFpZH9cr3CmHBJSJN274XLB/L
         M6Z+FZ1P72FhXJK10Tnm/MeP/rze+jqbMtF3WGXZADJeir915NaL7+uqC257W/jSOoTi
         42eiEeJOopb30mgibRIYoZCoxv6QxEVMRqKKX0W4ZaPlp32LoS1DG6Tj423OuGlO6iPR
         QkyH8XtFtRlqMC83ZAuDmXmEqYUIOhmxW7BhFUCeCAhehOErsK8Z9z/SiU8+4GH5lE/G
         R47Ud1lVTUHNL9bdlaM3qmTuVIeQ8PLhXB8p9aHIE5mnQYG9/bDie/etDFaUd4AVof9X
         ZIkA==
X-Forwarded-Encrypted: i=1; AJvYcCV9UTqKGlhE1X8DRtsLZRLzpo9Mr2hEMw5cIIkTrMT4y9ZC3/nyzpUxlfcDelU5N+J8Xd28IkQHBWRp9DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbREOTeC3t5UMX4x+APDlvbo/BB873f8wjsUe0h3zny57FQDyP
	30vEWQ4swDTDTxpwJIbL3ymLRjn+s1OqypFm5kgm7/GVS1ajlP2GPRFFmLXeUGAmZDMtYX1Ebsz
	Mib00M9lGsr7qKbXzwGpSkKgOFj0q5DVjiWgHAHcaRwmd16MlwXgq+T7PjVjf2w==
X-Gm-Gg: ASbGncukMtFYwnIrN2YkddmmaW60GFnyIGKay+Nlh3xQIcSn8lIMkvphHn9upY2ipro
	CcsBTGEHu1rAz0kYjj1chLR5ecD5WNfkjDSQouH+O8vv1VB/RpGXds6Cni32/PFSU8KmmiFV8vm
	SAcZhD/9znL/p0DW/DkcHr3EvgjoygJqVd2l5d4RNECSqcKn1TidFRiZystzg2U0U2/zQWihpc5
	H0cOpHiMX+E5pdMm2VmIxPL0zYG4wqtUd1jpG2ldAqbk6z9y6FRIoGFVOzzD97Qk/bFYD7VW6od
	FGjLCLI=
X-Received: by 2002:a05:6e02:4506:20b0:3d4:4114:1003 with SMTP id e9e14a558f8ab-3d5961a8f95mr7812455ab.17.1742507137112;
        Thu, 20 Mar 2025 14:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1IdDajXugiCbEt7uBnRwAX+2fxkUsWfEG2lGH6v+tiv8pOxpafZZWUGhZ/RSEb+iV/xpQNg==
X-Received: by 2002:a05:6e02:4506:20b0:3d4:4114:1003 with SMTP id e9e14a558f8ab-3d5961a8f95mr7812395ab.17.1742507136887;
        Thu, 20 Mar 2025 14:45:36 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdb3b32sm118558173.18.2025.03.20.14.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:45:36 -0700 (PDT)
Date: Thu, 20 Mar 2025 17:45:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Donald Dutile <ddutile@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] mm/arm64: Drop dead code for pud special bit handling
Message-ID: <Z9yMfPVxPYAQ0XD5@x1.local>
References: <20250320183405.12659-1-peterx@redhat.com>
 <73969634-a6f6-4dbb-bc30-801a5c4500cf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73969634-a6f6-4dbb-bc30-801a5c4500cf@redhat.com>

On Thu, Mar 20, 2025 at 05:03:05PM -0400, Donald Dutile wrote:
> Peter,

Hello, Don,

> 
> Thanks for the cc, as I have the original commit in a recent, proposed backport that now needs an edit...
> or, since harmless, maybe this patch to additionally backport, once committed. :-)

I would suggest not having the backport blocked by this. :)

Thanks for the quick review!

-- 
Peter Xu


