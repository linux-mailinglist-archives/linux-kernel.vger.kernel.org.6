Return-Path: <linux-kernel+bounces-220324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EA390DFC3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E74B21E33
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3746B17B41B;
	Tue, 18 Jun 2024 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jbt0qkPe"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91813A418
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752792; cv=none; b=dXF5s84V8lg+OevOyqHY59eeEycPwP7+Y7fH4rMXH1LrP7EdEqExyWK992iRKDQzlBlDegq2XCR1pOKN03Jet0XEVzqaRG/A5xoY5z0AF7UIRJHCiga7f1ABmZ+W6sPp6mTFIGJJS0ldWs1TnmufX1lvMc0OyQZUcj6dKRA0Fb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752792; c=relaxed/simple;
	bh=jRbM95jfpOwuaJSZ6zapVf12ZwahESC/BSNU+/AJPPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D9CdyQzSq22h/dK+p5ioI9YS+F3uxds8E/fwj7VYBPw7ei4akaX8meuFkuKzder2kNVRZ67Ghgv/wvNLkrg/ol6IdPYM2k8ekvoKlkBunhoVz9ICTQjf2IKX+WT45eaDYo3PdajjtXGLtsv8csESOayio3O1+FE+OK635Kz46sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jbt0qkPe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f6ea6afba0so2078965ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718752790; x=1719357590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/817AErV5RHGHALrV4PiucygGj2MnKUpiGCv3RHz83w=;
        b=Jbt0qkPeak3o+LDGTAe+blCkwpGdnz0M2WN4WotASGDs5aFG4wBIqLB/2QzA/Zv5Ng
         wnGwzPDiBx8Z/o19gpdmoTunaZQGjvdKHm+0MYkkmPttP4A9jRsgDrHphrGtn/fBQWMh
         Ez7Q7WoQ97kt+phKQsPkVb75BIcPigvi9WB/W0mUBL8YeyJh+CWi6fijRwkiQX1H3vAb
         6YVNx+3v7BRgt4qhnvWTGeUfVVPBG8wK6/XKIAvVLKB0lPI2oriPwl2+7cwoKeFOheAP
         KBJy+P3ilm3cDyOXjYS2ih/oK6kTRnxCv7IChs+avRt2NSU8tGGa0t+BU4jNIfpELucn
         TlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718752790; x=1719357590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/817AErV5RHGHALrV4PiucygGj2MnKUpiGCv3RHz83w=;
        b=CQSEsE3KVr+gsIZwmJYjUwfiVa3+IrODT4Icisg1VVNnGgpI5b5z+8EvlRE3W2Fgun
         jQgmcrRQhFZs0QxV8BkWlGYoeiSSHjTiDQlbsFh3DSHxLGGAPhJ48PavuW4VZyZbBGeh
         0rcAJBg7TqpS+TpfDnIMzZz4adXoRB4YlHQHxMhxZHwjNCjDYkr1ZW1yNVtUUYCJ1b9o
         nU7hflbJaFg6xJHS/ac/OSzCJQ3YOS20B5w2r5Jq2jGzadiAE58TpyqUO2udsPwbOuPc
         15QoH5Hrs6i251G6t74uywpPpeEJqk96MVZdMDu2qGFmPdJLSqN7QRa6lribjNh91CW9
         Jq4g==
X-Forwarded-Encrypted: i=1; AJvYcCW7BIIjAeUB+THp8nnSZt875ckWxvqYXMRGQs871l6KAFc+Qj5XmO7BCJ4P0p0wHWaxz28ymHcNrC7iGRP32PoPxqrtqkq1hIVZeVqT
X-Gm-Message-State: AOJu0YzTgP7zaDR2SaGD1t14fdDb+fYdLNkbtW5B2b9eeOHX2T1D49jC
	s9dww0QjwlCmvPXeWRtDUElyGRVTb62TO+JrtCQSULTVt2VpSoVKEAZxEeLRsGo5TURlPdnFRVN
	sZw==
X-Google-Smtp-Source: AGHT+IGzClFmSTJcFUIBNsjpYLZdAvEQWkl7PL3o8ZDCHfzvI0LMduG3qLVX4qiXtcMULKDUIkK2TvTPAlo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d50e:b0:1f8:66fb:1683 with SMTP id
 d9443c01a7336-1f9a993310fmr858855ad.3.1718752790360; Tue, 18 Jun 2024
 16:19:50 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:19:48 -0700
In-Reply-To: <20240618200539.GHZnHok3nr60R4BXSK@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202406141648.jO9qNGLa-lkp@intel.com> <20240614152228.GAZmxgNPmozj7UzRdV@fat_crate.local>
 <20240618104234.GF31592@noisy.programming.kicks-ass.net> <20240618104700.GT12673@noisy.programming.kicks-ass.net>
 <20240618200539.GHZnHok3nr60R4BXSK@fat_crate.local>
Message-ID: <ZnIWFHYipU2DsLK6@google.com>
Subject: Re: [PATCH] x86/alternatives, kvm: Fix a couple of CALLs without a
 frame pointer
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, kernel test robot <lkp@intel.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 18, 2024, Borislav Petkov wrote:
> Ok, I was able to scratch up this from the whole shebang:
> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 18 Jun 2024 21:57:27 +0200
> 
> objtool complains:
> 
>   arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
>   vmlinux.o: warning: objtool: .altinstr_replacement+0x2eb: call without frame pointer save/setup
> 
> Make sure rSP is an output operand to the respective asm() statements.
> 
> The test_cc() hunk courtesy of peterz. Also from him add some helpful
> debugging info to the documentation.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406141648.jO9qNGLa-lkp@intel.com/
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---

Feel free to take this through tip, I'll be flabbergasted if someone sends a patch
that modifies test_cc().

Acked-by: Sean Christopherson <seanjc@google.com>

