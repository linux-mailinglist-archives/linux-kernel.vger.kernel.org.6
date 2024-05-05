Return-Path: <linux-kernel+bounces-169057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732F8BC274
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6631F21102
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A15739FED;
	Sun,  5 May 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmLzFLp0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983C3D76
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714926160; cv=none; b=gkEnuHfzT8usoEP2/LVRzwwTcd/IO9CyxVC3HNH7n4BjyfJNO0y1rxmFAcGu+Slu4g0NoeyCLOrV8j9+Vzunb5O6hx9UXubSkuTwXpjlfj4jhoBcWGnp8+zlWgMVEgZZ0XhbM6cFjoTUkW4mH7UikevcZtPsuIkz5jsw6AH0i7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714926160; c=relaxed/simple;
	bh=3zDIzyJilplhY+uk6X7VllbKghNRgmUlIiFKwxWqLv8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFjzrspGkC+/0F5X1cxe/mSTXIdk0v52uDu4IzckF9QwQ2ZaEL7fXVhLbIZUw01EbXmE35ILfFFEh8hDMh2v1ERBYnViIRU8VJdNqcXpzpAmzEw62nc80Iw6KA6VBrmVV+yy0qZXVANUOZvu3osqYZPacvFVDPi4mGKMwUe8Ig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmLzFLp0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34d7d04808bso819825f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714926157; x=1715530957; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qJl5gQtEbQx7pryPEtSedHcDuNcmdNUVMpaUOyid+hk=;
        b=BmLzFLp00tfr7BPrcyQXK4qTB7TmflMHgU0GqJW5SLfsrlFUM0iajWiTfgl3N7BnQX
         1UHTmp9u06lLbAZ5CAVwonNIG2I8uIrAm68JgXDBWI0LPoLYOwB8xjhNzTgUKy/l1iyV
         lJcQDRQiHTfFxFjrx3JSYsvXaapp4x1/3ziVP3CiPxdP0BRjl6lzWR3ifcKIeo2tlhGg
         TGLiT+vOypUqXMJ7s9Q6pk9LdTWF4AGyo701W07yB3IVQ50/1p4iyQkDK7s9tMpkTT58
         GC0clHBiahhhNtpHAGFGdjuLgofbePXes3d9TMaMDzKZnkY2LbUBMIvATACToftE0G5r
         hrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714926157; x=1715530957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJl5gQtEbQx7pryPEtSedHcDuNcmdNUVMpaUOyid+hk=;
        b=R/f4q19FXAtha9h/depJQb1x19K8JUaX12IKumh3PwCqTSnyj69fuXVvkgS6MwEt5h
         ef1ZuPLPWWOfSkVzBvPpPmy5CmgQWSMYliDwZW1Yjy1GCgPtJqx+qffp2elLRlRVFI1N
         oY7Gd476OyCgveiCB80mMlNLKIMdnYvWlB8cQI1xh2BZ36MRjSQstQdOLjR4g/++7fqs
         jy2euc0v+MFUXD3YaUfgx3qTfzfDMcRWUv10SDe+gt1fEKlG8sZyR8XFomxeH0iKcHnc
         bjZZPkT1WYaroPCIBplazAVMRZWJiupR1dJPgFMABznfjvK0KhiqXUKZUvk68YXdnJOi
         rlbA==
X-Forwarded-Encrypted: i=1; AJvYcCWeusohfCMS3TACCZywIs/wM7LrbPTdBSlKspsqG1o68jxBcsuOPSyBc8/wSIsFaMecUoxqXjQfxrC/+LYukV2z3OJIZpvtnLBSymwy
X-Gm-Message-State: AOJu0YzyuAqvWUBUujm6tdL3DRb0N/RmJ8Zlew6eLK7nOU2SHEHJpuo9
	J/o/sDhA2GmTpZ66saW9F3cchC1oU1sS/sQhV0pZCJA3srmWq/K7
X-Google-Smtp-Source: AGHT+IFPBPxTI9zi6MsxoqVF7FOCU96PdOYUTyAfd/Cv5WLwJbeo0LZO9FEa4Pxo8Lu0ndS1TlX1PQ==
X-Received: by 2002:adf:e691:0:b0:34b:b50:3689 with SMTP id r17-20020adfe691000000b0034b0b503689mr6822148wrm.10.1714926157268;
        Sun, 05 May 2024 09:22:37 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id z18-20020adff752000000b0034e19861891sm8531966wrp.33.2024.05.05.09.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 09:22:36 -0700 (PDT)
Message-ID: <6637b24c.df0a0220.e96f3.a400@mx.google.com>
X-Google-Original-Message-ID: <ZjeyS4w8mVWBt_Fb@Ansuel-XPS.>
Date: Sun, 5 May 2024 18:22:35 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2 0/2] ARM: decompressor: support AUTO_ZRELADDR and
 appended DTB
References: <20240121203009.9257-1-ansuelsmth@gmail.com>
 <65d62b60.050a0220.c7b96.614e@mx.google.com>
 <CACRpkdYZSr0Kif+q-DBZi7v7qZ=_tedONEP-OPhOHg4yHmwkhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYZSr0Kif+q-DBZi7v7qZ=_tedONEP-OPhOHg4yHmwkhg@mail.gmail.com>

On Thu, Feb 22, 2024 at 01:07:56PM +0100, Linus Walleij wrote:
> On Wed, Feb 21, 2024 at 5:57 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Any news for this?
> 
> Can you please put the patches into Russell's patch tracker so he can
> apply them?
> https://www.arm.linux.org.uk/developer/patches/
> 
> If you run into any problems, ping me on IRC and I'll help out.
>

God I totally missed this email where I had to put the 2 patch in the
tracking system. Just did now... my bad!

-- 
	Ansuel

