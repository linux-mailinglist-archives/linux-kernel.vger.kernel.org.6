Return-Path: <linux-kernel+bounces-393639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 825749BA37E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 02:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398411F22613
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 01:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B13C7080E;
	Sun,  3 Nov 2024 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LXlc3P0g"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B54879B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730598647; cv=none; b=MM/+sS1HE/JCo+SpTp2uzcebJUfJkSeWpYOVdSmZuvP2yUIBIT8Mje5al/TlpNNVj/Fn/LrNzYKoJ7ZHojHMxuOp18HNkj7Fb2lirJNOHd+yFKKAD6OAcIk1IQt84CIfoEQMuMtFmBM9Dxm6EItZHiKLq6lv6HtihWbemE0dckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730598647; c=relaxed/simple;
	bh=EBs5gl7N93upcJIXXwrDgIci/YMFdfn4ptMpREAlBNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu2o1T9Mdka/Vp3OYZ05lz5zD63rpfq+Jp3bUUTNSKUypFalE/8a/rT7w694MdeCzCMGQvvnLmWUcL1kX9FON+UQrm4o1NxV1WQ+DMM5+CDaP8IHWF3374u4gM83lQOvfAP2FL3JvLMdAj0pVSDqaUvQu+Z8nM1FuxycoOvQxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LXlc3P0g; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c7edf2872so32065295ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730598644; x=1731203444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3Pxis2muyr2ltVxVCPzj+ieXZtWSMkxjvBW6HHZ6bw=;
        b=LXlc3P0g5MEdc8K1kdFuwNyOPNkFAOgp8kIPDHv8+1CIl85QEJOcfQv7Rfxty91uXE
         an6DEgYGZjk4H5+fRP2wRojD/P6bMbkBP2cUxH9LrY3m4zXZWsHCp0Tvr9SbxniF5Bpc
         E2K/xt3INbVVDmy0Cf7Ui33pRwmpwDQAFhKdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730598644; x=1731203444;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3Pxis2muyr2ltVxVCPzj+ieXZtWSMkxjvBW6HHZ6bw=;
        b=lyWe6rsHlYfQhzlGsFthvbYrpHVD5O2uXasrqlWD244S7puStTnAdnC5alfKfg3cbI
         Ym+k1qahRR0ADNJ9CYygCViAT5So9MlJsOB6ARiIun7IMMiT+QM3xPoZzP52/RByDYDn
         BWHrRzfwzeXaW+cX3xAUkH4h3S7fR681nyk4Mld18abJ7E2ZE33Q1oxzV5BADWs3LBZO
         XVwBZ9Ak6XE40YA0wEn/GN2dtBxUECQyc4kvquGZzE7x2lpG+HoA/Q/HbAaathFIEKQ0
         DDZlZK1B1iBEB+6dsSIFoUsgR3fTPj5lS5U6ibWHKXiFTF2ItPHVRZZBtlKSeO5uWL6Y
         KGWw==
X-Forwarded-Encrypted: i=1; AJvYcCVH3pn+K/ffckqpqV/S0YnR9lxWfZnB9Dv24SkHEqpL4Cvc7YsUqA4VWgZeEGRcoSUl5q2xlm91cTyiGuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0YwztDd3Sn9omzO1XwekbxJQuKYMqPDSn2s73QfaHL8RLssr
	QAL9Y7e+aiCLyUVbEGXUipzr7wHlb7FUlBePZzDn7iXsZ7Ctc/nNWbhKBfE52xM=
X-Google-Smtp-Source: AGHT+IFsHnbXf1U3NgvkcpiLAfPsPJzjVhKBCWplOF+ORDTLneObrD4bFY9HYjBaYdBSMDye9dYOCw==
X-Received: by 2002:a17:90b:1844:b0:2da:6e46:ad48 with SMTP id 98e67ed59e1d1-2e93e058c03mr16960867a91.1.1730598644112;
        Sat, 02 Nov 2024 18:50:44 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db1890fsm5002054a91.45.2024.11.02.18.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 18:50:43 -0700 (PDT)
Date: Sat, 2 Nov 2024 18:50:34 -0700
From: Joe Damato <jdamato@fastly.com>
To: Hillf Danton <hdanton@sina.com>
Cc: netdev@vger.kernel.org, edumazet@google.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/7] Suspend IRQs during application busy
 periods
Message-ID: <ZybW6uMXrted0UGF@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
	edumazet@google.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20241102005214.32443-1-jdamato@fastly.com>
 <20241102235121.3002-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102235121.3002-1-hdanton@sina.com>

On Sun, Nov 03, 2024 at 07:51:21AM +0800, Hillf Danton wrote:
> On Sat,  2 Nov 2024 00:51:56 +0000 Joe Damato <jdamato@fastly.com>
> > 
> > ~ Design rationale
> > 
> > The implementation of the IRQ suspension mechanism very nicely dovetails
> > with the existing mechanism for IRQ deferral when preferred busy poll is
> > enabled (introduced in commit 7fd3253a7de6 ("net: Introduce preferred
> > busy-polling"), see that commit message for more details).
> 
> Pull Kselftest fixes from Shuah Khan: [1]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=7fd3253a7de6

Your URL is missing a query parameter, id, and should be:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7fd3253a7de6

which is "net: Introduce preferred busy-polling", and so the cover
letter is correct.

