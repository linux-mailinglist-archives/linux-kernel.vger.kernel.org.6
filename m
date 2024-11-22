Return-Path: <linux-kernel+bounces-418635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D16A9D63A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8807C160FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D31C1D2F50;
	Fri, 22 Nov 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+5Kb+tG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38770809
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298604; cv=none; b=GHeCWgcEWQDvLK/YkQWv97nr7T7Zz+2Q2XMhk1Wr9HE6MNCEiY030oMr3oILe45hpqzWawDQ3kdXOnUdtczZxYuQXZf8N0ui9U9+OlN+WV8Z9RMFHWQxSINVOv3CZyRGNNgucau12xMHl6UZHG9cwO14jiAxhObbtM8xZhG8uU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298604; c=relaxed/simple;
	bh=kGnK4cMUDdm6YYKXg3I2JvAfdZaQrGXC3Xsuc27xdos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8uYOsCJcNMioiW5hnu7uVN39CmQNRryUhFCAb9mP68Pa9LaSnfEfvJBzqtGQwiRUL5bmK+PWQge55qtitp5gviit7aaGeAb9717uDd3o4vorYOwCJB4sYbCEnh64h+nDvMCcIQryIWVKSLZdaufeKrK491O3Rnvq1B+IbYgO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+5Kb+tG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732298602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=779BNLH2N6tx2iOCEXW0cNJ7EGBdC88+huie7WxmWzY=;
	b=A+5Kb+tGNK4ndm3XARsXF+5OKBOXS+kRjsaHMouG9H8qCUT6uy5Z4McMkj7H86s927GuKB
	O//JcGnkUAarCBh9TOnJcZxFbLEMgTOJ8FATh/SJRFQMNX6ueRE/NdX/ixG/DMOFIYCEAS
	I54JT0I79cAu2NaYXKkpVdCMio+gFf4=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-7ixU2gVUOnWi6B76ykqaUA-1; Fri, 22 Nov 2024 13:03:20 -0500
X-MC-Unique: 7ixU2gVUOnWi6B76ykqaUA-1
X-Mimecast-MFC-AGG-ID: 7ixU2gVUOnWi6B76ykqaUA
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a79afe7a0bso14925555ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732298600; x=1732903400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=779BNLH2N6tx2iOCEXW0cNJ7EGBdC88+huie7WxmWzY=;
        b=xPIeIc25vSm4zA4tOpoO0JMIU18hoLilqozRP4jgChqxuCtLTlIN5isCvJR4bAwlzP
         21lRj8j3E8jLO+imoANIcNaj873Ez8opAv+NogzPYlHCU99hAhQFwj8mg6CtUKkK31+X
         82Xfhs0/5feZSoNU/BJ4O5yuHeZdAQsHtf4g8SBbhuomFDfoRpMnX2CSTkiNNhVqrQXw
         LnKuwZ7zTsNhxb5GXVGSBv+aClr4QGOKYwSERslfYxYLh/UYDaEfCdm0GlNHFXaADHA0
         Tiz2/adsQ35iUw3hDgPbVC3CbcZ/P48nZRPeo+r/kCojnR2lgk6vESm5jgqQ6x9lpP1O
         2Q/A==
X-Forwarded-Encrypted: i=1; AJvYcCUeFlsFqcyoX3Ti/CSEm5TnS80S3TpuoiL4dDakNTEOvqnUTiSZBjgs+Ebt6Kzimj1VYFaeUy4jVl6B9MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+KrmtcmEYdpXdVIee8/OCsn1OjimabTz4xicTpQbu3GNr/PU
	vXyuDDvIDRCldupmayRdCeRZc/yNoFf2xs+yPGA+clE6K5rLzRiAkPnuJtLMn+VXM72iyg6N9zV
	mWAzH5HbV3QKMLYZIVqUmUwNK1P/td+qYualQuOMxD6phjpCDviX6SgSkaDY5mw==
X-Gm-Gg: ASbGncsoHTT3FpSQ4fBAZnnH1VZxZgwmm1WxAZP/1KaowX0+Ye3m40hpcYKlMk9XGrZ
	rafK8ySWvE3KRoKWcPtdHvpSnNiIO5oUwAIVbIH+IzrDdZE8zb8RAyJhc9N4He4MdVGs+bTPB4Y
	rxHwBBfflOH4uOJgA2AK5RVpkaXP6N/AR0hqCtzSDrhEA09Fhi9c1Sszgu59+MdoItrRePImEGW
	AMDNOa5KUZOV7Lbx6mT/3VsyyZjQqKEwoW/fz62z8QfcRz+WQeApA9Fg8Txd4X1zgxzwj3bUg+R
	luQnOQ==
X-Received: by 2002:a05:6e02:1789:b0:3a7:1c51:f83d with SMTP id e9e14a558f8ab-3a79af1fe69mr43580565ab.18.1732298600054;
        Fri, 22 Nov 2024 10:03:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErqQFPFZV9N9lMqdDfIln6Z9aT0JfSm6HTQGuRe4rEyAA79sNqU7IwmTnAMzFQ6nOexwbdpw==
X-Received: by 2002:a05:6e02:1789:b0:3a7:1c51:f83d with SMTP id e9e14a558f8ab-3a79af1fe69mr43580205ab.18.1732298599649;
        Fri, 22 Nov 2024 10:03:19 -0800 (PST)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4301:5e20:98fe:4ecb:4f14:576b])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cff35be5sm726492173.155.2024.11.22.10.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 10:03:19 -0800 (PST)
Date: Fri, 22 Nov 2024 10:03:16 -0800
From: Jared Kangas <jkangas@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kasan: make report_lock a raw spinlock
Message-ID: <Z0DHZIEI5hobBUwn@jkangas-thinkpadp1gen3.rmtuswa.csb>
References: <20241119210234.1602529-1-jkangas@redhat.com>
 <20241121222809.4b53e070a943e100bb6f7ba0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121222809.4b53e070a943e100bb6f7ba0@linux-foundation.org>

On Thu, Nov 21, 2024 at 10:28:09PM -0800, Andrew Morton wrote:
> On Tue, 19 Nov 2024 13:02:34 -0800 Jared Kangas <jkangas@redhat.com> wrote:
> 
> > If PREEMPT_RT is enabled, report_lock is a sleeping spinlock and must
> > not be locked when IRQs are disabled. However, KASAN reports may be
> > triggered in such contexts. For example:
> > 
> >         char *s = kzalloc(1, GFP_KERNEL);
> >         kfree(s);
> >         local_irq_disable();
> >         char c = *s;  /* KASAN report here leads to spin_lock() */
> >         local_irq_enable();
> > 
> > Make report_spinlock a raw spinlock to prevent rescheduling when
> > PREEMPT_RT is enabled.
> 
> So I assume we want this backported into 6.12.x?

Sorry for missing that; I think a backport of the patch would be
appropriate.

> If so, please help us identify a suitable Fixes: commit.

Fixes: 342a93247e08 ("locking/spinlock: Provide RT variant header: <linux/spinlock_rt.h>")


