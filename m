Return-Path: <linux-kernel+bounces-266571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622BB9401C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D751C22246
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8B718FC94;
	Mon, 29 Jul 2024 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dJhWFbY5"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E618FC64
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722296360; cv=none; b=OJ9YJAQoMYMOc+SyX88ZgukCfeCcm0mLyKBU9GrMcYvyUBZM4PArjVX3D9r8j9feLYvtP4fs+lZ8jnrGhak3+CmEazX9jCa2UZrqSmxeTwFv7pEZUrn8UgihFNKF6FCMcHKSOup2ckee050Vgisp+35IRcj8izxA2euBeaDj6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722296360; c=relaxed/simple;
	bh=GrYTdr/Lfiqp/j7QTBHta1asRCW10VHT87ZR2/J9QpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKLkXf3E7cqL2lUcSxnComRfdhwNX8aV0oCIYXrvJCgeEAppVBLSffJjR4zNZthCKrxE6fyUyY6WyxQkQNhJjGq6Rf2PqmBA0x0ChJgf7MXl9mL00Im8izqWNo3t2b3FkO66P9+2VBvh8yt554XMuPjTiQUhKfvWDwheTmd/lBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dJhWFbY5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3683178b226so1590152f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722296356; x=1722901156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QI6LketRcSHxADi+8iYULTPVBmFAZZrmM/uumYTfQCg=;
        b=dJhWFbY5iNMRTwDGv4td93A6EQHvrWt9Y1rrT94YARifaRz/w6/sXUGnUNnpgaez7m
         PXIQOlhxrLp2fET1aitnpwmlFbE4ka7sonA6iLlHMpKTbDi3qErHsdRg+F+y9Ai20zEd
         D5xozPFVmhn+Rc4TcvfmYdD9zil9GkEZ7fM1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722296356; x=1722901156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QI6LketRcSHxADi+8iYULTPVBmFAZZrmM/uumYTfQCg=;
        b=UNDhVlcin8IcsYn6/Ei9IcvH+5TdYT2hGTJyudvYDZ2/SCAY6ddoXubDq3LKNKxUmE
         oBJmsNDb00Y9/AFWT24RHbmqbxk+c9SuKgeJdWYLejMLG+gYLFHu6hF+mAtorAxiNCJV
         UxAOu/owfBOYK0mhkGL+n6jRiruQZN3uzTT6D+NVA4F43GcIS5LWvdVOdtRgdzUrRbR8
         SPFMlrvj3JI8qQjiIlofWCflJh5LjFosQU/McbQpTZ03DCh0eYxGdcrviNGzjob3//Fp
         1X1XkPQ4WpcNA3b9nuqI0OHdj/+9ESp9lOmnJZEmmjGlYbRm1NzXm41PtMe+v3DWFbtE
         05dA==
X-Gm-Message-State: AOJu0YypIdtX7ut/1lJOQMVVoUVnYF+BdysM22RmZgXt2lJJhmbJYVTU
	pBa96WKeOS/PFjz54Riwm/W18T7dYWgRjkmB2hyD3EfSvmFSkNr0lNClgqeQHVusnpVs6r3e7Qk
	J3NHP8w==
X-Google-Smtp-Source: AGHT+IEbaLAPphZQUAZ+hxzE2uFPdPZO4g2LIb7O/Oj18UPMeRzINj5zefHYQc4zF7tBob6UKuk2Fw==
X-Received: by 2002:adf:ee4f:0:b0:368:3f04:d5b with SMTP id ffacd0b85a97d-36b5cefdc26mr6008732f8f.25.1722296356299;
        Mon, 29 Jul 2024 16:39:16 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2365fsm565630966b.21.2024.07.29.16.39.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 16:39:15 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso3745107a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:39:15 -0700 (PDT)
X-Received: by 2002:a50:d696:0:b0:5a2:2ecc:2f0 with SMTP id
 4fb4d7f45d1cf-5b02000bde0mr6124611a12.1.1722296355229; Mon, 29 Jul 2024
 16:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730082204.57c64765@canb.auug.org.au>
In-Reply-To: <20240730082204.57c64765@canb.auug.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jul 2024 16:38:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEipN1BoDCG02m1XqvACCFLxj2SoEG8O4BZMAFXKifqg@mail.gmail.com>
Message-ID: <CAHk-=wgEipN1BoDCG02m1XqvACCFLxj2SoEG8O4BZMAFXKifqg@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the origin tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 15:22, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> After merging the origin tree, today's linux-next build (powerpc
> ppc64_defconfig) produced these warnings:

My bad.

I wonder how I don't see them. I very much tested a config with both
SMP and PROC_FS, and those obviously correct warnings do not show up
for me on either arm64 or x86-64.

Does anybody have a clue-bat: what makes only the powerpc build show
this valid warning?

            Linus

