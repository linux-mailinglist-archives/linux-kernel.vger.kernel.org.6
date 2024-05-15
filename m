Return-Path: <linux-kernel+bounces-179377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1AD8C5F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0091E2835B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB6A21;
	Wed, 15 May 2024 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aJhDP7DK"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20F381D4
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715744240; cv=none; b=YDLUQJnMaNsCtS3FY4LoAUErIwvoet+FreCDAmfAFU1FKRJFA6cSaECmor+h3pILJBNIIWS/MKeEPUIGRqkSusp2WCke4RSoZAFL2GC8C0+4bN9fV3PZQ737jg1ygaDnUxi4OSAPPPAdRS3plCGpRmP3cy2Mto8AN87ve2fONYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715744240; c=relaxed/simple;
	bh=EfdUCHrSrcD/J7rjef0Mhq6ZfzJmqLp0Wf8LNr0IwnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSpjfamLXl+gLR/G9BBDKPBG68/ljwtmgkqnPCpPjjVQeaMx0/NSRLL3o3Id1mLPIzv+Vu8OOVkdYV2Py1xkeUsQJHzNSnGAu4i+nOGmOTOFuTE+I/zmOeRDAxpFryhY3BmoX5fiyWJcrwlFMZi6jO5yprqJ33A8idv3E6qP2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aJhDP7DK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572b37afd73so1202502a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715744237; x=1716349037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s05R5WbZKAqPwH8O5MN7TtiDlbeN3dQ+l+K+4TPNREM=;
        b=aJhDP7DKj7Nw9apCPgYuNa9wUwGRfA0kbb3VLTabFtUwQqZaeMWO1oglAov8TXQ86K
         UbdSu7nAsDwY2KV5IBPu8Iij5+OKdAnrf0FR6ISfNsS8fjYowWXgb5tqciWo0y7pzFTX
         qw4Imwephnd6cZnljRZyTMRz3SAfMxgMj1WAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715744237; x=1716349037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s05R5WbZKAqPwH8O5MN7TtiDlbeN3dQ+l+K+4TPNREM=;
        b=Xt4b+NxuPkz5rVx4972H06Jp6Z40JTlI1gHZ8CfFhVtO5a27tlO7C/I/oPDWo+PoNG
         wbOMoh97xHoh3L7ZPZjOka/QmYr8PlIzYaQly2Rg+5U9mY3z9GohpPAWdVCQiIJ2Dgz1
         SXgP783dqRXgCK3rdnYpr7EymEGo86f0WRaxFgDykwZI5yR7vnuFAqce9UvjMcIIB74n
         G2VXgGTmo790uHn7hlv5qKAX3lP6AZDqHsCXSCDemtnUTgEs57RzoB2puq5CtDaYhG0Y
         Cw+BI2JJy3tyNfxgDuR7+7i41gokMQxwVKQGWETLldiE24hQmo6zqopPQceJp+UNvkf0
         ZRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOKGsGCSetUzndW1eYgZyQk+ZQAe/KFftGlisNlBxOWGLhRU/yQVjOb+2WZM9nCd1qNBs1oK5kDlWsf8nNfcvxX+ibSDa+SImmHkRE
X-Gm-Message-State: AOJu0YxGLwGFUlOMxwwf3qaCjXhI9FeC4HffHBMRY6DOq7DU1MwDE9Lk
	JqsQHOWyb7SX3f8fpGW5WKfcXnxdAo2psFYI8SAFuI/xh7xeAD/55Jw6haUoh1XNeGknDhs9s6k
	lQXVnfQ==
X-Google-Smtp-Source: AGHT+IGeMsinDp2VPqI6myGrIaKd8APpfJIXX/3+ZnNWlLEuMVL9MEHwKY5LuvEMaa3nWUROfw1Txw==
X-Received: by 2002:a50:870d:0:b0:56c:5a49:730 with SMTP id 4fb4d7f45d1cf-5734d5cc261mr9889186a12.19.1715744237054;
        Tue, 14 May 2024 20:37:17 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574ebdf46cesm1065579a12.37.2024.05.14.20.37.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 20:37:16 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so89573666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:37:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoQeSAQf4TA3Zgws37h5jdIKNPCgNeo/F1kmnk9Amf7zZOhX6xIhevAijXs6NUYgi0uUGWEGvjHncH1Zrpd/M743/O2GxeGqebPmmy
X-Received: by 2002:a17:906:3d6:b0:a5a:7ce8:f52c with SMTP id
 a640c23a62f3a-a5a7ce8f6e1mr298659166b.16.1715744236120; Tue, 14 May 2024
 20:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <20240514160150.3ed0fda8af5cbd2f17c625e6@linux-foundation.org>
 <92453.1715730450@cvs.openbsd.org> <20240515025811.GA1232@1wt.eu>
In-Reply-To: <20240515025811.GA1232@1wt.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 20:36:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
Message-ID: <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Willy Tarreau <w@1wt.eu>
Cc: Theo de Raadt <deraadt@openbsd.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, jeffxu@chromium.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, 
	Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 20:13, Willy Tarreau <w@1wt.eu> wrote:
>
> Wouldn't it be more effective to have a non-resettable prctl() allowing
> the application to prefer to be killed upon such an munmap() failure in
> order to stay consistent and more robust against such class of attacks?

This whole argument is based on a castle of sand, and some notion that
this is a problem in the first place.

Guys, if you let untrusted code execute random system calls, the whole
"look, now unmap() acts oddly" IS THE LEAST OF YOUR ISSUES.

This whole "problem" is made-up. It's not real. Theo is literally
upset about something that Linux has done forever, and that has never
been an issue.

Stop inventing make-believe problems - there are enough *real* bugs
people can look at that you really don't need to.

                 Linus

