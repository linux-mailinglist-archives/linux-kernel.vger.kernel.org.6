Return-Path: <linux-kernel+bounces-561553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD708A6136B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD8C173708
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ECC20011A;
	Fri, 14 Mar 2025 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FtOUxFb1"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFE1FFC7A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961597; cv=none; b=U4CZOd6M4u+j4SRdpn3jvOLvsWfQwMNdMP/WboQnxchwvZKy9l3BS+Xq3sSJLc2x8GPY9oTllJK2gX5lKwCUP/AioDliFNbRzHL6CODDioik4IVRxqHRxPJ3TVYpLOpO5x77gLW6foEBeUE8rRq6AlBNstq2AbN3PckZKwjXr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961597; c=relaxed/simple;
	bh=9iUNtBBTrhjDotYpsJ4A1kjabcl4g1/BapYEuI/nJtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeHcV8P7H2o73L6E7xD2Au6Y+xmVnMGR7mIzK+/lzXRO0d4gdI+D9nC1M1w/y9oRde+slbNrinrUdjAIObON3GTbl/VaOtbyRabU54sB/ccMTw4c7JueIuJkhrfONHoml+Q9qUXbX0fOHnxCEyhWMYkzKL6NcocEOObnriyVKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FtOUxFb1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394a823036so20663305e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741961594; x=1742566394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ev7Ui75IuuSIPWk86Wm5e6FobvO+1G5BN5BqKHdtAI=;
        b=FtOUxFb1SGuki814z5Qg5vHv7vUbxkyp0uZmnX3DfSWRa8KMf5CVVR35LDHs3PsfA3
         YmS+csNjzHnXuyqLdqO8DbeoFJYdJMhL8S0Iqm9cB6oxLH9i/xGhHTPwISGwrRoOmC4L
         KibCY8pDqMdkiOXY9ouzsmj5KMcKIziV18VCnfBsf/Ok/fex8jhiORpUFG7qtPZaSDQk
         cLoJ4jcRAWzX8Q/9KJVJtKc0YKq/8rQRN+8k3PS+Bjk1RQCtN0HeyXmzTLtDyRHrTRMP
         9NhY2YIYqUtLvFitMMXDGoRMc9GfVXIgC87PRtGm1w9dSV3W98kT7FQESn1n3v5yrwNT
         YNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961594; x=1742566394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ev7Ui75IuuSIPWk86Wm5e6FobvO+1G5BN5BqKHdtAI=;
        b=uf/V2YhBPkxx5eYpyjcW2sPeB65KwkpiLrlpWfcqsEArZa30jSBVUy0/acKNpmqylL
         +mibVrFNJ2er5Gu5NidHf/+8JoNQ5BChqw+suZqHAgOPDuQu5WupkwRW8fO+k2nL2dva
         uOkOv1DSobIM4mNNRvItdP1IL8Wbqe13A/EZ9wBCi4M0ytCRte/fWtYYNP+sucpojIYi
         XbFdvkS6WiUxpp+C3FdiwhQF371t1IrgPS0kfJ3nQrNoljvRgAgHiJdTNXzoJUkSTE4H
         8BSWNWuYVjUbFD0fDA7eoKR5H9wwxuvEGv/SW/hOuqCNKHevXiRly7sSvSYcLSpnKOBM
         ntkA==
X-Gm-Message-State: AOJu0YzgAcHY2XXDf+ig4vzdMVgylcf8S4IqfjDmxPEMVB4gl7q52sdm
	dmWYqof3iNIzK4IME1m8UvEqdJNdCVCBJ0g5+kETN9GwEgEIGHI9nPheQRPCZhc=
X-Gm-Gg: ASbGncuCoV+Mkxg8dFHLDvknwq+fBLqvCrY4o6hFveLmSNUffB3Cq78s2IYrp2FqQwE
	aIaaGEnNGp4zuus8jQurQsIGRJnve4DTPi8ZpQL+W8Z5FqIgJsZMYPUr2qb5QAaxN4tyhPJKbIY
	yblmRH6h3vdPjutjQDcBEkgQJfuDMRT27lrV4DmAMwd/XJ3VuAKld4u8eg368Y+E35JiWgQBtiq
	xc65alAt5DP7qnVkyqHhGuzLnSMaF8rkccOQBlrj18C+Ajyu8JLPOGHJQZuN4zem/vg5r25Gm5S
	5n8tvAz+cPClgPRF+YeIv+SE5jPOAJeKfLfkuU0lxM/hHi1kDzw2qhttBQ==
X-Google-Smtp-Source: AGHT+IHwozIbGl0OHOmEZQ3S3NFp6KYWrzBJ9oVTGXL5DC16G6oKXkM7tqtYNlSXL2GE2j1zPhB1Og==
X-Received: by 2002:a05:600c:1c86:b0:43c:f4b3:b0ad with SMTP id 5b1f17b1804b1-43d1ecd0f21mr32888105e9.19.1741961593813;
        Fri, 14 Mar 2025 07:13:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df34eesm5761373f8f.18.2025.03.14.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:13:13 -0700 (PDT)
Date: Fri, 14 Mar 2025 15:13:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	linux-mm@kvack.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] tracing: gfp: vsprintf: Do not print "none" when using %pGg
 printf format
Message-ID: <Z9Q5d11ZbA3CNMZm@pathway.suse.cz>
References: <20250225135611.1942b65c@gandalf.local.home>
 <Z9L5HsVzQ0bVZtjp@pathway.suse.cz>
 <20250313125313.4f3d98f4@batman.local.home>
 <20250314082534.57ef07c4@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314082534.57ef07c4@batman.local.home>

The commit ca29a0bf122145 ("tracing: gfp: Remove duplication of recording
GFP flags") caused the following regression in printf_test selftest:

[   46.208199] test_printf: kvasprintf(..., "%pGg", ...) returned 'none|0xfc000000', expected '0xfc000000'
[   46.208209] test_printf: kvasprintf(..., "%pGg", ...) returned '__GFP_HIGH|none|0xfc000000', expected '__GFP_HIGH|0xfc000000'

The problem is the new '{ 0, "none" }' entry in __def_gfpflag_names macro
and the following code:

char *format_flags(char *buf, char *end, unsigned long flags,
					const struct trace_print_flags *names)
{
[...]
		if ((flags & mask) != mask)
			continue;
[...]
}

The purpose of the code is to print the name of a mask instead of bits,
for example, printk "GFP_ZONEMASK", instead of
"__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE".

Unfortunately, the mask "0" pass this check and "none" is always
printed.

A solution would be to move TRACE_GFP_FLAGS up so that it is not
the last entry. But it breaks the rule that named masks must
be defined before names of single bytes. Otherwise, it would
print the names of the bytes instead of the mask.

Instead, replace '{ 0, "none" }' with '{ 0, NULL }'. It works because
__def_gfpflag_names defines a standalone array and this is the standard
trailing entry. The code processing these arrays always ends the cycle
when flag->name == NULL.

Fixes: ca29a0bf122145 ("tracing: gfp: Remove duplication of recording GFP flags")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/trace/events/mmflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 82371177ef79..15aae955a10b 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -101,7 +101,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 	gfpflag_string(GFP_DMA32),		\
 	gfpflag_string(__GFP_RECLAIM),		\
 	TRACE_GFP_FLAGS				\
-	{ 0, "none" }
+	{ 0, NULL }
 
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|", __def_gfpflag_names		\
-- 
2.48.1


