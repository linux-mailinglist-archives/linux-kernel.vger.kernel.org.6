Return-Path: <linux-kernel+bounces-329731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08056979511
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 09:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307D41C20F33
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 07:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C00C21A1C;
	Sun, 15 Sep 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3RvT6gb"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2D364A9
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726386614; cv=none; b=rg4Ad06CxcAQUmBQ8WyxoFg7HVNtMMVAb0aszofZeK+ZdcIXQu+DGKjmAc++52PLzRlpI/PhGiYutKqt/+ebTMzzZfFIKHEkMQ2fuRMI/UxY7tV/AKEiBAsI7ec55qLzhvaMlRWiUXs8+gm7UAiZWqkQugynT4jHJyXIerx1K94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726386614; c=relaxed/simple;
	bh=QsY4XZPWNrDF93W1mg/lR3N3nA9sy/l3K0ESNcVu0Bg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AveyolKCbKJrMZBuTEIocWiQB6BeGpe26N42xOwYS3m058tBOLnqXyzdG5MqluyYzVTMGBrYCpbsQsPllhT88sWDz943qCwJe2yGqxRw8Zcp32glPbx+a6saj45Kw1NuekCXSYaPjR/XhKD0ZbtujlV/yHUMjK0qPJdocNX7TQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3RvT6gb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2056aa5cefcso162445ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726386612; x=1726991412; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0sP0C/SZXbtE7kXb1uPu6iN1tgyGfXaUc3oWuyV4hHE=;
        b=z3RvT6gbzqgmp4qev/AQ+z5Tw/dB1RofkSSQikNvjIkcNk1Ap8UvwrQPFk2zuvGkBU
         jkOKYjFmHpjO92ulPDuL9ZpsRbJhAYJRYCj+AFsNp3UviQqwqH9huIZdYg/oCbiuKPm/
         ZBrRuxOYABgYvJjrGz8uafeZ1oKZGliIqSJNONZJ83m0LiG/fUEh90d7uwJsRzUhVxba
         kdleBlPNnxUM527JZh91DTGD9N3H9TQTbrMiso8VJ/t8ggzyUQoasCeExXx0/oPSWiAi
         bO7NwnzXwyyBOj24UC9M0ThtzBvguzUDGDrJXVOAKRt3HLFjpj0JRLbJh7gsc8rxGkh3
         sD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726386612; x=1726991412;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sP0C/SZXbtE7kXb1uPu6iN1tgyGfXaUc3oWuyV4hHE=;
        b=oQwnw6dTIQtQBYtsmsE18bOgkO46Zq6F5fRhk3Whmr0FbNziCqOjuXD9fxuOrdKK5E
         lEd/UhOLoUpcR/+6CBm8ex3FoKfOESBaj1Zg22bGwTNUDXr0Zuqp3dmU4WUq+NN68cjW
         3oB4qIsvMKLPXVmR5AB9WdkkAtzLI2tUS7MlQs3YObqlggy/6FbfomGZX5X3UA/AIZgL
         /0Lu9n06LHKXEbFlYOPieBw2kVIAjMRd14QuRJB5AQdL3MLsRL5wGsppgwp8vVMZwEqj
         IiaoP71MaQSB3vt22p95QXk+utgPpYliT8QzowRQQq5k91cHVgwyGO7ZjqYzzeXY9L2I
         SLXg==
X-Forwarded-Encrypted: i=1; AJvYcCUEeGD1ptLCjyQ66idg1ZKPBFkhvGQkt0q3SFo+/vxdts/cKDK5+FZNNlwC/KjfK6me+95tkc39EU3KRz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFABFvUfcMdMIz3hRqR3MpCwx4FwApZEF+sh9SjJkE5Xjl1pTW
	sp4EoY06VUH5o62zEREL0OQcJe8z11zRT7eBIPewWmdc4EyfwzFLjaPY/8wDIw==
X-Google-Smtp-Source: AGHT+IEPML2/cMATOIRhcrZ7qpCU8XOPOY9iRaNq1New23c86px/YVkX7cWtzIXR1QGfzY08RFGckg==
X-Received: by 2002:a17:902:cec9:b0:207:14ab:722e with SMTP id d9443c01a7336-2077278b5f7mr7877975ad.7.1726386611571;
        Sun, 15 Sep 2024 00:50:11 -0700 (PDT)
Received: from [2620:0:1008:15:8b83:20f7:eba:dd56] ([2620:0:1008:15:8b83:20f7:eba:dd56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946fab1fsm17926595ad.195.2024.09.15.00.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 00:50:11 -0700 (PDT)
Date: Sun, 15 Sep 2024 00:50:10 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
    Liam Howlett <liam.howlett@oracle.com>, Shakeel Butt <shakeelb@google.com>, 
    Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/madvise: process_madvise() drop capability check if
 same mm
In-Reply-To: <20240913140628.77047-1-lorenzo.stoakes@oracle.com>
Message-ID: <5db5f367-9efd-7a9b-07dc-efb06669b260@google.com>
References: <20240913140628.77047-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 13 Sep 2024, Lorenzo Stoakes wrote:

> In commit 96cfe2c0fd23 ("mm/madvise: replace ptrace attach requirement for
> process_madvise") process_madvise() was updated to require the caller to
> possess the CAP_SYS_NICE capability to perform the operation, in addition
> to a check against PTRACE_MODE_READ performed by mm_access().
> 
> The mm_access() function explicitly checks to see if the address space of
> the process being referenced is the current one, in which case no check is
> performed.
> 
> We, however, do not do this when checking the CAP_SYS_NICE capability. This
> means that we insist on the caller possessing this capability in order to
> perform madvise() operations on its own address space, which seems
> nonsensical.
> 
> Simply add a check to allow for an invocation of this function with pidfd
> set to the current process without elevation.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: David Rientjes <rientjes@google.com>

