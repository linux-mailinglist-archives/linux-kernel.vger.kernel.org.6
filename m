Return-Path: <linux-kernel+bounces-268418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6FD942478
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F031F24C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C251210A0C;
	Wed, 31 Jul 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VLZueX09"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE17C2FD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722392187; cv=none; b=BjMJb9KZMe1sIhF4rPklkX8cVNAugRzQHKXUHTVHCRe3swi/htMWhKV9xIk0XnztTbKGAm6R1tIFYXjzKnDEAikvlGXmE4l7FNAe3uXbXUaZvfSsTDJNuGldlTPs9XXGZ9j7bn6bzhcLzRr/+dSoJpHFPB3IN/yZxkIGGBzEyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722392187; c=relaxed/simple;
	bh=DMG3rbkS3kfAD+T5PEJSjY/gTvAmj5VUgDnq4/nSGsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYwr3r48ZKPAdA6IRCwCEVIZ3b8djRrqXVN67kCV3qwVgiiZzA1S9KajxyO6MX1hzWpMy0B0QY5wSWaR8LVFFyuZNpFsLsl33KFfeL3Fdejr4OaSRgQXlkR4bnVBDA+ZrTF6rRWiDOtEa0/gMAUKHlEEun8JbRsOWS531diKrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VLZueX09; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70ef732ff95so1841004b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722392185; x=1722996985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pm24eBOf5RouWLkBrgSLmesZOwTzNnb44rrW9Pz95Ps=;
        b=VLZueX09U2lUbS2XCQQOYSWnRME7jD1A+6M/SVvR8INeQAs3rP6AEYkkoAUn1mDYs7
         iwE9ijHHGCsQvOsr4kqf9IAEyDD01HC8NHHpy8mJ5S8FpMzvyLjt4WokECuuP5Kqkl5J
         BWyhQRScLauRiyP1xzJA7fS8IPQO+RDRy1+hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722392185; x=1722996985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pm24eBOf5RouWLkBrgSLmesZOwTzNnb44rrW9Pz95Ps=;
        b=DNNhyrQXw4sv5Yvfz1O/gFYnIAIHXtbnuuNAObrpgGTs5bi1H9Y4zjH7sp/XJpb18Q
         rxse6MNjTCVxGNisJLwImkADBjDMHIEYW+Y+S+YFujQenYtlCzq2edzRCSjbR+LcCNNb
         khYQUbkbkKNGLuZ2bJdBYiQ97648ywugiPOoAB8e+3TK0ygOBvImOJ2fn9jyDxcw64hO
         4kwwuhDUOhKHn8gHIpsjHdHl+7nO1gNo/TKAAkA1PJeBBfalUSk0HQQ152hDKyzSyHl9
         MEDt0S4G0F8H9fdiovtnDeTnLdfQ/P1CfTGn8bFOx/J4CTtqfhcjPggsPwdbVpHpU5co
         meKA==
X-Forwarded-Encrypted: i=1; AJvYcCVCH6pasiqWW4uxUZ99FOvi8BjEumXfLIE1c4KXlM/1krag3JQeqlbXrCNW5IcYiipxrAjOIwRGNXkT2c/s/thZ+dE0eGGvrzuvlJrq
X-Gm-Message-State: AOJu0Yw+390NE+zioS4Hl/fKVWSEo4hHllHJC0ncAG0pcvNXI/Ucpupc
	YG+89KV4CICQFUiupqMMETyGJDXq+5P1LMMVzI/gbCzKFL45qYmi2sXaHaXHXg==
X-Google-Smtp-Source: AGHT+IHvRHiupRzDSjcjS5k2okMhnlosHol4XJ/6pHV7OZKZTQwMTSSIaRFUYw18t2u9L3IpHM3MjQ==
X-Received: by 2002:a05:6a00:4fd2:b0:70b:3175:1f4f with SMTP id d2e1a72fcca58-70ecea40e8amr11579240b3a.16.1722392184908;
        Tue, 30 Jul 2024 19:16:24 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a51d:b844:f0ff:3c91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead874619sm9051234b3a.164.2024.07.30.19.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 19:16:24 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:16:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alex Shi <seakeel@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, david@redhat.com,
	42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Subject: Re: [PATCH v4 22/22] mm/zsmalloc: update comments for page->zpdesc
 changes
Message-ID: <20240731021619.GD16599@google.com>
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-23-alexs@kernel.org>
 <20240730093726.GB16599@google.com>
 <8fc7939b-416a-4328-9df2-488f17783543@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc7939b-416a-4328-9df2-488f17783543@gmail.com>

On (24/07/30 19:45), Alex Shi wrote:
> On 7/30/24 5:37 PM, Sergey Senozhatsky wrote:
> > On (24/07/29 19:25), alexs@kernel.org wrote:
> >>
> >> From: Alex Shi <alexs@kernel.org>
> >>
> > 
> > Usually some simple commit message is still expected.
> 
> Uh, my fault. Just forgive this part, is the following log fine?
> 
>     After the page to zpdesc conversion, there still left few comments or
>     function named with page not zpdesc, let's update the comments and
>     rename function create_page_chain() as create_zpdesc_chain().

A bit of a different thing, still documentation related tho: do
we want to do something about comments that mention page_lock in
zsmalloc.c?

