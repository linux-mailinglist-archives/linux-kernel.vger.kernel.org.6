Return-Path: <linux-kernel+bounces-271918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CAE9454F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70552B224D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1FC14D2B2;
	Thu,  1 Aug 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KlfAolTe"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E1DF49
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722555502; cv=none; b=GfQdDIU6WVw45fQUz7Z39+O10TlqksUeHzi1ccgMFPqw1pFCyszH+ErEBtkY8kmIGuZsQnUNpcm0dWnDd0q2nC374KxjU8ieCDb1ZjOgF4FL6aZp41O9WPEmOpbI2OrYlIHSeJgXtfSS+/nhsbYz4MezyjiNmy010r6QAupg5+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722555502; c=relaxed/simple;
	bh=T1jwRBHm7faM+J2Ak2RzJK2qwtcMu3acgNrj9JW9Hmw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JnMPIjTtv1DpFpwqbgq3dHzhJFn0ZOlF32xf+rqTBozCIUyXBK/Z+dnIrLSKbMZQSysDXfNYIOs/Dp0L3JmyZS6mYeBl2hJFZMxGJ6dUjeZmb4nf2w/lJAYp8W2TeYOd3NNQuQabxLlCZtWtB+KFeUVOfhilV7YMMQNFLewY/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KlfAolTe; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3dab336717fso5047208b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 16:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722555499; x=1723160299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rCy9HJ4srmJ3m1vjr1m6yAWWjKvtqIa6hEHwcJ8Tvgk=;
        b=KlfAolTeoK14fzu70mDkyVW03ozkKC3tPPfyzzsEymETfsrCFiNg/mUu83GxQ4QuWa
         7U1zAw5yCL3mj+QzWmliZVJy/FcXQvLIQ34edGZ8C8HUIjDWnn47kPIHo1hXGNOKw7FR
         81d/AWWSJLuKY04UoyFV0l1MP8jSE9qMXrn9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722555499; x=1723160299;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCy9HJ4srmJ3m1vjr1m6yAWWjKvtqIa6hEHwcJ8Tvgk=;
        b=eNbdvehm3pbSaQmjYwpK7JXmKbtnFkmsGbJUy+phKGkcMfrF3iP/HE9IgVIGj+r4sH
         aXfrVxASc7zBBOQGn82ACSBxT1KNyW6wIzLVqp4OIkmBKOmJkiDUQJ3/EpIvq0+IN8Xg
         dWgAjLRsJAxEKhYMWPR997bs49X1+wmsUJ8btOMHv24Ui0IqBv8x+tQHaVg1hjaBOqMB
         RFY028lKyiX4aFwlGGw8KNM+M03McM5IZUY4cMmrGEMqsJp81y+K2654o/XqIBWvtI9W
         SzlrNtG+Xg4sdNAuGhTHaZUnpk9sdNIXtLzC22CNWrH2v35iVw7Oxs32M5oIk9HIULQO
         gi8w==
X-Gm-Message-State: AOJu0Yx1CPZk1d9tNSDUfRjXB01/q0xN+vD+SGsUFrNrcGGc2Gm7gu+F
	ea/5UGiytqL46U/b27RyrtYxTX/i4xlaYzUddM8+8CQvQg1PwVov7TmuNKpcdIUmSz40OnViQJL
	OvA1FZt93CQQqRFrt+3eVFWpwgvj8rygMarGO
X-Google-Smtp-Source: AGHT+IHCC/ltUotYX6mLVunWSlKXpfCoNSXiFbzHh0RAb47QRijYbCEypBsPXdFhe1PxzDbg/LWlbx7mXp9sRWsmdbk=
X-Received: by 2002:a05:6870:c1c9:b0:261:360:8e26 with SMTP id
 586e51a60fabf-2689179adf0mr2182219fac.0.1722555499402; Thu, 01 Aug 2024
 16:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 1 Aug 2024 16:38:07 -0700
Message-ID: <CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com>
Subject: question on [uprobes] special vma
To: Kees Cook <keescook@chromium.org>, srikar@linux.vnet.ibm.com, 
	Ryan Roberts <ryan.roberts@arm.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"glider@google.com" <glider@google.com>, Matthew Wilcox <willy@infradead.org>, zokeefe@google.com, 
	hughd@google.com, luto@amacapital.net, oleg@redhat.com, 
	"jmarchan@redhat.com" <jmarchan@redhat.com>, "rientjes@google.com" <rientjes@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi

__create_xol_area() calls  _install_special_mapping() to create a vma
named [uprobes].

I'm trying to find out the lifetime of this uprobes vma, e.g. when it
is created, will it ever be unmapped/remapped/changed during the
lifetime of the process.

If  the uprobes vma remains the same during the lifetime of the
process, I can call mseal on it so user space can't change it, i.e.
blocking munmap/mremap/mprotect/mmap, etc.

Thanks
Best regards
-Jeff

