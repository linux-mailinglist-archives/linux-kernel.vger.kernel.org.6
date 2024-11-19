Return-Path: <linux-kernel+bounces-414970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808979D2FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0190EB23EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A81D2F76;
	Tue, 19 Nov 2024 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NJC2LlRQ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D67149C7A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049815; cv=none; b=gvSesI74+7MyQU2hdCVxs3QnjFTfvz7vXW0DE9Gh5qBqHwdB6quHliNMl/GlZ/GyRU8F+RO46Dw1EoXry16fveXWmpqiJvJ+1XSvyIQyatag0AQi5FjFlD8DvfyHoTYq4S70wDgqG9rtFytA/808j4tg0kgzi/BpV3V1lamJIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049815; c=relaxed/simple;
	bh=KBsMzAAMMuSv92BNqXNCbBy1mDiClOsll4y9+9H2i7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQCFaAow9+Q4IlRKeSEVtJFz3GxHTJjEYBMf1Q38j88/aN6O+vDRtyOhU5tmBWJFgSSeN0uB7MfJj6sHkXwPB7S2BtagDI0HDPUsPc0q00wJmCNBholyyx6hnUKPcKyKF51xK6U/xcu/6GV4CwUX183sRz1h5MOqllCpo5sV8fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NJC2LlRQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9ec86a67feso258596466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732049811; x=1732654611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j8Frib9EBxDTYycw+Xkri5/LSw6YM6TVLb/mIprSD6Y=;
        b=NJC2LlRQ/fMe0g2Oqz9fgBG2xRLfZPR8dkl8Crm7oG1TXSDQfSpW6icADAFeygOOuo
         d3pzFggelfjpgXwS2atovAtZG6wkie6HEB09wnW/yJ2J+fNQZXyyUj3fkusbKWa0UMey
         Du9w5deabcEXc2NHMLYCR5qqLBeguhUMPoQLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732049811; x=1732654611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8Frib9EBxDTYycw+Xkri5/LSw6YM6TVLb/mIprSD6Y=;
        b=hYPwULeX7yKpfxctUyYho1xDierOFRhZiicGrcdpd5zdeXw2qFBi02aaUTb4loUHQA
         uvSsm1rRtDsMYDm2Y/FqcAxjh6vhXzoHsME0lV+OagfzcOzQ2KLeAlz7Bvfyt4qEeb8R
         shP5MWSMkxTpMwM64CuyYLgKsKOVYiDz3HZrkWPEIZ+fe1KkmPSZ5g19vnkvYsJZBSh6
         b8w64GgJ21UtxzRsf7AKC2WRgg0Rlg2EByN6b3rDxQ926SjpMRshtllACXr567HP0nyu
         puXq7j9hywhLwB9BBlYuqYgpjc8Any28VG44ePDvFNL2WHlXIIUQOFrc3TH9fq2JaBy5
         +jNQ==
X-Gm-Message-State: AOJu0YyoPYiblBn2kmdtVYzVuQ9rsQzBB0s6PVjlEo2uPVD89ROoYQ/v
	WCPK9q/mpSQ3zzRPG+aqF++To52EZED9um19SdH1zq+DvaDr1rjHAp4ltsNNSE3NaL9IK8vGcxY
	Fzew=
X-Google-Smtp-Source: AGHT+IFeYMjtDuy6IhnWPuMDa4QsqVsSfKxF+az8GadgOqvjfQLNnNHkxo9vyHrIN/EKXrQ8KiJ3TQ==
X-Received: by 2002:a17:907:9726:b0:a9a:2afc:e4cc with SMTP id a640c23a62f3a-aa4dd749ef7mr26303066b.58.1732049811257;
        Tue, 19 Nov 2024 12:56:51 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd78dsm687585566b.115.2024.11.19.12.56.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 12:56:50 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9ec86a67feso258590166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:56:49 -0800 (PST)
X-Received: by 2002:a17:906:c107:b0:a99:fc9a:5363 with SMTP id
 a640c23a62f3a-aa4dd52ad02mr30138866b.9.1732049808805; Tue, 19 Nov 2024
 12:56:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZzsC7HOiJ8Mwk8D6@gmail.com>
In-Reply-To: <ZzsC7HOiJ8Mwk8D6@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Nov 2024 12:56:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com>
Message-ID: <CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com>
Subject: Re: [GIT PULL] locking changes for v6.13
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 01:03, Ingo Molnar <mingo@kernel.org> wrote:
>
>  - <linux/cleanup.h>:
>     - Add if_not_cond_guard() conditional guard helper (David Lechner)

I've pulled this, but I'm unhappy.

This macro generates actively wrong code if it happens to be inside an
if-statement or a loop without a block.

IOW, code like this:

    for (iterate-over-something)
        if_not_guard(a)
            return -BUSY;

looks like will build fine, but will generate completely incorrect code.

Honestly, just switching the order of the BUILD_BUG_ON() and the
CLASS() declaration looks like it would have fixed this (because then
the '_id' won't be in scope of the subsequent if-statement any more),
but I'm unhappy with how apparently nobody even bothered to think
about such a fundamental issue with macros.

Macros that expand to statements absolutely *ALWAYS* need to deal with
"what if we're in a single-statement situation?"

              Linus

