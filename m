Return-Path: <linux-kernel+bounces-523475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C52A3D74E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48179177F23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926311F0E20;
	Thu, 20 Feb 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3hEmC6m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E201BD01F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048568; cv=none; b=N7jvmLue0DTaWvpn8kyHxZe/9CnVjJ0iLcWHrNzXzHRmriJAmNLlgI6RaP0kBZqf9ei+ixi1p3ey9pfRIDlgbCRhrnj5NAz6YzaUCt3YwkCdVg5oEPQ+QkQcYj5pNcmLTH1Z7EUSq6fKm20taorHVqnIDKEjehf3pmQNMnB8DBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048568; c=relaxed/simple;
	bh=DX/WKGk8HmQeZKX6s69j5TMN+4bBbCRmUVBFZ2XhrTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xsbr8hV0wR+3zDKC0XTtwbp2STnoV/8kpyLIMEaynuAxMIHKVPdgeZ5WueDOLds+Wuz4nULkWlBEn57mncfNZ2PtM/G+PEs3fnIDHTg0TCgYpL9AlAXMrff8S4kEg7PQDR8BL9cTGTmEwNW3SnOoXXhNChhP+015ku8tAlXdZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3hEmC6m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740048565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1d62Lm9FrwOp7FYknRqM421oQFVPlwapQR2aEhbtG0I=;
	b=T3hEmC6mrAic7cB6CVK2uLueYPgijVoschvH6Ut/Qf1Hay4B7P3Nx1mteFxwZR4xkT45B/
	XShF/21Qmf36Za9yYuErSDu5FaZjaaUC9JpkLo5kb3tPf8fidy23WHJhjPxkicoW2hf6FF
	len+US2mjMEDaDUYqWChLH1RXXde3ck=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-QFP5ys7QPPaG9Ff3_MZJWA-1; Thu, 20 Feb 2025 05:49:24 -0500
X-MC-Unique: QFP5ys7QPPaG9Ff3_MZJWA-1
X-Mimecast-MFC-AGG-ID: QFP5ys7QPPaG9Ff3_MZJWA_1740048563
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f455a8fcaso524549f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048563; x=1740653363;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1d62Lm9FrwOp7FYknRqM421oQFVPlwapQR2aEhbtG0I=;
        b=WvgFe+I3rjwdESeSERwpE9NJKIDAEYN+HBUyUl12cmL1kk3JdVTf1rRvqaQ5BUkdou
         4O0QLIrGwObx5ZRPdeywOL3XtCLbJ7XCkQdFJruYMUw3lMXz4VKK4tdMBK5MFJ4vFvhu
         8SN1rmvHx1yuJaVUsfFrjzroc96JC23J5YiCPhR2ZTGT0mSMaZzisrE1yC3UZQyB1nJ4
         IMOm4dDLO8xkmUqhkZqGTKjMgfIMXSUpyJrYJIjHEsRWWGvBkODcQ9FY9nyhBTeWFFze
         og7RIBAZ3kDeUAoyDHN4hqtNuJ3zSBfdRrksNOpJmjw0H09Gdwm7NcxYrjrVJ7XrBNWl
         JVig==
X-Gm-Message-State: AOJu0YxGxsVzM1Lz0nXKPk4tLHTnCOVBquLiTzbAj+QrxBryYOjUx1tk
	Jf3FRHDeJO6wVwTltziqlsPcZfg5EoSRtEVlnod9N2pIIVp3wHx9fqrkHYQQuk87neg9s7ovIwb
	MFEVvjbXHWJRDq8vPXfC5FRHQkH1zFZ1pM/Xu3HeWRNkGswgJy+7bcmvXm+Q/MdemVTxeBw==
X-Gm-Gg: ASbGncvac/A2iljZtddJpQ7vDYyFNUSTRDawgojgjyReDIFHRaPvA+EfbH60/lmsHHk
	rT6ex1qFiCEVdUxz4ZhGmsVR7icMuWeCdHU2Vo2jOKDFlpvAe6jsPwXt97jOz9QxU+H+NEfN786
	T1uL55u8oQdlYQM8OkwFfJ6B04NWX1ahbTcDqbgZc1WTb8r2jdhbH0h2STsTw0+HHAWZVerz+ow
	gd8wr2xaUOkdwXnvECFww6k/eZNZI4sR7ahzqRFkP6hhJcHPK20oAeKkg4phIHnMjEGEwoETy40
	rSaKWbJmM9PLhT6PNYCVDHlBIRK8jkSBUtlgv5Ik8fidMZbr3EaOnL3w+MBNgLdjN6l6HlAyhNA
	mMR17puKQRj29wNf0HVNv1auO3BxsnQ==
X-Received: by 2002:adf:e28a:0:b0:38f:27e9:7918 with SMTP id ffacd0b85a97d-38f58795a50mr4758516f8f.26.1740048563175;
        Thu, 20 Feb 2025 02:49:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMEXvHrgQ58ZUvDndBYVDPj/iF5E79puoGSJGaEm3vVmo2LMBzxQWT306ZrDUC4APIdSOkjw==
X-Received: by 2002:adf:e28a:0:b0:38f:27e9:7918 with SMTP id ffacd0b85a97d-38f58795a50mr4758504f8f.26.1740048562791;
        Thu, 20 Feb 2025 02:49:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399c41022csm42748355e9.40.2025.02.20.02.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:49:22 -0800 (PST)
Message-ID: <b80a15a7-f9ce-49eb-b721-b59f20bd6fac@redhat.com>
Date: Thu, 20 Feb 2025 11:49:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: page_ext: Introduce new iteration API
To: Andrew Morton <akpm@linux-foundation.org>,
 Luiz Capitulino <luizcap@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, yuzhao@google.com,
 pasha.tatashin@soleen.com, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1739931468.git.luizcap@redhat.com>
 <20250219155212.9474b8c44bd58780a54c8a6e@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250219155212.9474b8c44bd58780a54c8a6e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.02.25 00:52, Andrew Morton wrote:
> On Tue, 18 Feb 2025 21:17:46 -0500 Luiz Capitulino <luizcap@redhat.com> wrote:
> 
>> To fix this, this series introduces a new iteration API for page extension
>> objects. The API checks if the next page extension object can be retrieved
>> from the current section or if it needs to look up for it in another
>> section.
>>
>> ...
> 
> A regression since 6.12, so we should backport the fix.
> 
>> ...
>>
>>   include/linux/page_ext.h | 67 +++++++++++++++++++++++++++++++++++++---
>>   mm/page_ext.c            | 48 ++++++++++++++++++++++++++++
>>   mm/page_owner.c          | 61 +++++++++++++++++-------------------
>>   mm/page_table_check.c    | 39 +++++++----------------
>>   4 files changed, 152 insertions(+), 63 deletions(-)
> 
> That's a lot to backport!
> 
> Is there some quick-n-dirty fixup we can apply for the sake of -stable
> kernels, then work on this long-term approach for future kernels?

I assume we could loop in 
reset_page_owner()/page_table_check_free()/set_page_owner()/page_table_check_alloc(). 
Not-so-nice for upstream, maybe good-enough for stable. Still nasty :)

OTOH, we don't really expect a lot of conflicts.

-- 
Cheers,

David / dhildenb


