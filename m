Return-Path: <linux-kernel+bounces-335372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC4997E4C0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 04:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C0EB20D97
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 02:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C519D23C9;
	Mon, 23 Sep 2024 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OAaoj/+s"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696B10E9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727057765; cv=none; b=l0Ghh0FFfM4OjPph3hbok1SdK03UFiRBfroQCbaiPzmVZqW2lMrBszTtuFwvvdQj1JYAf1hD8mUnahyTMpLgNJO/OrStXaNS9jJaAFhnL+dkFHwbiB55PnZfkl86iVToWJIFkfv2Psm8CZT5viRmDaz0hIPoPmJGadQG9g4VSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727057765; c=relaxed/simple;
	bh=d/jMoc0fE2qUw6SNYHaGC41Nyi+tsSLAFREYoBUiS54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJfLbdRLWwoOfIBiJ5739BP6dCLhOUyUhlQvjpCAOe5WD3kVKCCY1J0qGM6VxVkVgheLeGlMZ9c57S7OPauyIcb8GnAQG7pi2vHP8YYGu8DNu6/68wHdBosWu/+5o1uI0vQzthjF4Yo3q1B7zlLr4RJ4NSRuLYRLSwayvssxiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OAaoj/+s; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so3159752a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 19:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727057762; x=1727662562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iasbysCenz7uyGomAHZxudZeL78s012Zo7N6U1Pe6Yk=;
        b=OAaoj/+s46rxB58ZsI6Oop0CDfn8zj1jUZUvIxJG5CPUZvPiAggQiOo7alLtlKyxxI
         7Toxb/HMRI+bzPolmX59Vvklrp5c0lkdeflL3hhIDFLA2npcLKtckZaVr00RTDxu12z3
         KZSc/ckVslcSQUs6W2Nj2/c1Dhp3actUj+bCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727057762; x=1727662562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iasbysCenz7uyGomAHZxudZeL78s012Zo7N6U1Pe6Yk=;
        b=oYYOiD+nK3q+LRjZrGM3Sq4K4nVETr5rXhREarlltZd+46no0/Hb6PhkjYdErPldS2
         R7b7Yq/kZ8eivMGOBmKZaFHJW6xBNrnqpMQpJU66mlMOw7ocCjZBlLsEIx24/doBxLNc
         Rs2j6+4JUHlM9X0SXaw4bAoCTBYnsvASdnsF9ncAA4ysKt+9L2a2ezUVG54oJLCVULrh
         Sh5M37DJmg+vT55/RvspNf9oAe4H7WH4UtWghMt+lxAY0AaAdD/O8yuJFPA8oHj1HdFn
         FaLQG40HvZRGGlu2Cq7cP9xzYk6pKBRo139fPxTfdZLEld0X+gXLfMrrJOR2w3Sf388X
         is1w==
X-Gm-Message-State: AOJu0YzdQaUUrHMObLiPnEx8OaXinny6PdLiwUhCofaPgRBplkp9emZv
	dnIZFqbHgxIdMFw2jylt83kFiIB9orNdgDRLcuT6sX6kk4EN23TwQLGOj15GASFZz0cycpGeoj0
	=
X-Google-Smtp-Source: AGHT+IEVFNeMkz/rQnZtNMOkdI7qq6A51lL3WpTLQ0ItCoFcML/fGuk1r4Dc3g5VZuRpkYNgUCKSEw==
X-Received: by 2002:a05:6a20:c89c:b0:1cf:55e:f893 with SMTP id adf61e73a8af0-1d30a9be5ddmr13234422637.36.1727057762370;
        Sun, 22 Sep 2024 19:16:02 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3e10:9e7e:65b4:e016])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4999cddasm14510674a12.76.2024.09.22.19.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 19:16:01 -0700 (PDT)
Date: Mon, 23 Sep 2024 11:15:57 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	senozhatsky@chromium.org, akpm@linux-foundation.org,
	minchan@kernel.org, terrelln@fb.com, sfr@canb.auug.org.au
Subject: Re: [Bug][Git-Bisect][6.11.0-next-20240917]BUG: Unable to handle
 kernel data access on read at 0xc00c020000013d88
Message-ID: <20240923021557.GA38742@google.com>
References: <57130e48-dbb6-4047-a8c7-ebf5aaea93f4@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57130e48-dbb6-4047-a8c7-ebf5aaea93f4@linux.vnet.ibm.com>

Hi,

On (24/09/22 22:23), Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> I am observing Kernel OOPs on PowerPC system, while running LTP Test case.
> 
> [11472.962838] BUG: Unable to handle kernel data access on read at
> 0xc00c020000013d88
> [11472.962846] Faulting instruction address: 0xc00000000055e2c0
[..]
> [11472.963005] NIP [c00000000055e2c0] kfree+0x60/0x468
> [11472.963013] LR [c008000004e02838] zram_destroy_comps+0x5c/0xa4 [zram]
> [11472.963020] Call Trace:
> [11472.963023] [c0000005da817b30] [c00000051f580440] 0xc00000051f580440
> (unreliable)
> [11472.963028] [c0000005da817ba0] [c008000004e02838]
> zram_destroy_comps+0x5c/0xa4 [zram]
> [11472.963034] [c0000005da817bd0] [c008000004e02d24]
> zram_reset_device+0x178/0x250 [zram]
> [11472.963040] [c0000005da817c20] [c008000004e031e0] reset_store+0xd0/0x174
> [zram]
> [11472.963046] [c0000005da817c80] [c000000000a85874]
> dev_attr_store+0x34/0x50
> [11472.963052] [c0000005da817ca0] [c00000000070e7a4]
> sysfs_kf_write+0x64/0x78
> [11472.963060] [c0000005da817cc0] [c00000000070d2a8]
> kernfs_fop_write_iter+0x1b0/0x290
> [11472.963066] [c0000005da817d10] [c000000000604868] vfs_write+0x38c/0x488
> [11472.963071] [c0000005da817dc0] [c000000000604c98] ksys_write+0x84/0x140

Can you post the script that you run?

