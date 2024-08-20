Return-Path: <linux-kernel+bounces-293375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE66957E86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130E8B21ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D7E18E344;
	Tue, 20 Aug 2024 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5CP4O46"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4016D33C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136036; cv=none; b=r5PP91bqkY856+A8T8qmV1bKEYCIL6QnQGT82l/N194OxPk7ysYkQnP59/03fTTaOdEjEfElOqjOu7ruhlk8FMFKModqAZq5/vRXnJT+86h4nwjj0wo8tM4TIm3aKykK5FV84hONXIVWdtdqC1bYbAFkcWR7WPnUzvfNKFFJuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136036; c=relaxed/simple;
	bh=15UH5N8RvByknQFgvTBOI7zYBxbzOSOr6Znak6JM2sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPY1f1fRx1wBtaGfFdlO15nZkMG+ixuEwL90+Vu8KfOXwWEv6x5O0PNfsh9vrzatG2s4KLNv65LBjMGf21XupDoRLcPh/iWBYK+OwXmAQ99BUfogRIFL/i+YVhxd6cZ7Ai3aixXE8DjYB0VZByDLWgAIhIn/bdiu7/jP5FBCPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5CP4O46; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724136033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTEWIGxuQjibL588vtu8KylgICyjhCyrybpbVqP9eqM=;
	b=N5CP4O46mV4eO/pWYrlvS6Eem406oTogwN+vAeHzHYuA2FHOkihIWZGLChI8xviDXPFhKJ
	Z4n4x1anXz92f8WU3/TLOjN09IgvQEObj0K0e5WGKF7kXqRQWMHwG83fR87PQOeI/tSLnk
	T9LNSWK7NiLyAlOyJExzcsCkI9znA3Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Ncq_ah5EN4CVNVnohHSYeQ-1; Tue, 20 Aug 2024 02:40:32 -0400
X-MC-Unique: Ncq_ah5EN4CVNVnohHSYeQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6bf6a05cb2eso58021246d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724136031; x=1724740831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTEWIGxuQjibL588vtu8KylgICyjhCyrybpbVqP9eqM=;
        b=bnGuzifHztpIJcywHQ0zXsjuDfrYZCoWbn2ZBPSdrcDOcTcQkdE9PUsMBeLhTHCXC0
         YaDXIbL8h4ebD3VjHEwCo4odYbQm+jInk5LxnAjqqj0xaVybuCvda4lz+M/0bE6Le2AZ
         +gJudRXOXdUC5sj8trHk5dXig0gX6gi8xqFj7ezSdgOpiSO9aJMDO5hHoJc8fhsuXg/S
         0t1Eywhoau59vEL1YxpA8XXNnkfvcqNNlXbe6BzBSgJvxeLIidq8VzmH3j9NoyaDm0ol
         1+sI15PO3edui5yoBpx3VzxHL1xWJqbpsXT7Z687OjzaiPeUwDSfMQZpViFqUQGnEvZ3
         CBUw==
X-Forwarded-Encrypted: i=1; AJvYcCVx81yYyRpbsdsd12F8GWUhR7cojQkr7bIZEtCNUaqk2s8Yn1O4d+F/DkciP4iZb+UxRNS1aqQBSXeoRek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jjxpUXUOGSqEAX6TqivqXU3Ho6WRepRAPk6mBBL5kzQXtRH5
	/6kE4E31AJ4bafr/hAhA+BKHikck4ilQLUiVDgeDLL5o5gAu2YiI9qZdBuqUYbpvtT7H6dm3AiA
	xPmeTIZ5rxHWjk3iftj4xVZ/d+ssJh0qRRzJ1IikxUOXjlFATB6IgyvkGVMOeimsAaWqaD77DFb
	c=
X-Received: by 2002:a05:6214:3d07:b0:6b5:e895:82f0 with SMTP id 6a1803df08f44-6bf7ce5f9c0mr177450816d6.43.1724136031400;
        Mon, 19 Aug 2024 23:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7IXov9rapEYo20mlC1Ac8XNsv4V0P307FJH1DBt4tDq1PP9/jepF/Dveyd/aAdyFYkAPCIg==
X-Received: by 2002:a05:6214:3d07:b0:6b5:e895:82f0 with SMTP id 6a1803df08f44-6bf7ce5f9c0mr177450726d6.43.1724136031061;
        Mon, 19 Aug 2024 23:40:31 -0700 (PDT)
Received: from rhfedora ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec603fsm49544726d6.93.2024.08.19.23.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 23:40:30 -0700 (PDT)
Date: Tue, 20 Aug 2024 02:40:28 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
Message-ID: <ZsQ6XKQ4pRFYkGoS@rhfedora>
References: <20240724221122.54601-1-jwyatt@redhat.com>
 <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>
 <Zqv9BOjxLAgyNP5B@hatbackup>
 <2024080405-roundish-casket-2474@gregkh>
 <ZrKOCLYvYklsPg1K@fedora.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrKOCLYvYklsPg1K@fedora.redhat.com>

I wanted to follow up on this since I am close to sending out the v2 of
this patchset.

3 points I wanted to raise:

1) Does everyone understand, is okay with the SWIG license, and wants to
proceed with me sending in a more complete version of this as a candidate for
upstreaming?

2) About maintainership: if I am to be the maintainer of this, how would
myself and John Kacur be listed? As a CPU POWER MONITORING SUBSYSTEM
maintainer, a separate category below it called CPU POWER MONITORING SUBSYSTEM
PYTHON BINDINGS maintainer, or is not needed to be listed at this time?

A quick search for bindings shows what I believe to be all of them for device
tree. This may establish a new precedent.

If I was to be added, I assume it would be a separate commit in the v2
submission?

3) I had to comment out powercap_set_enabled

SWIG reported this symbol not being found despite being in powercap.h. I did a
quick search and was not able to find it's implementation in powercap.c. The
get equivalent powercap_get_enabled is in powercap.c. Wanted to check on this
just in case it is a bug or part of future functionality. I am assuming the
latter; I would send it v2 with that declaration commented out with a note
explaining it for users if there is no objection.
-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


