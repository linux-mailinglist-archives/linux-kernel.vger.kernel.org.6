Return-Path: <linux-kernel+bounces-237032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A549391EA13
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA8AB21427
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767C83CC8;
	Mon,  1 Jul 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8Xgi+ej"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638532BB05
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868523; cv=none; b=olynnAT9bYyplSiv5Xjquvm167JYHu7XhRR25N8XrYqrRPfClm5xoTq1+FNNxREWflJQ1lJAb7IQ0BP0J1EuJcL49JL7Aew0nPB4qeBVKqUiuSlKcA/Vv1LuYoIYpJUZUKfszgjf1UGeIYp9lKrDTJwljkI8whZNeBFKRBBpqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868523; c=relaxed/simple;
	bh=b4iFMOwsvk1yyy4eIIH6phVK+v4nAT3kLac1lMQPGZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAg3CSiet2asX8EHo25A2jQG84SHkKylLOpHI9IK0uXmUhTe5hJVeO7C1/NIhowe4yhJQKRCFBERHZgNXpqRYWSyH+WjEQCWO2Vbko6EZmkjjSY/KMbH0eJGEcCQUrI/jH4iUrseKEEAWtc7eBVVPAZF6TIV0ccftTnSproQGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8Xgi+ej; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d55f198f1eso1758762b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719868521; x=1720473321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWlZpA9w0jHOBVI29bT6ToqLRafNc0gupNX61H+Tj74=;
        b=G8Xgi+ejlTey1nT2Coub+ipXzOxYPtbN1EaEqToJYuVsMfatZ5oFe+E3/lfRV7of0M
         tvOY+VAnLakS0fanPi4bY0rpUme4L3zOHmTtdLRIEcKqP0vLpLl5GyW094EQF0jmirWY
         Rcc771x/8ZNED65g8Zetid6u34AfgVT9FgDotQQGpw+D7UtdDshqZYqkVJCdgBHFJG52
         kOKft88vKibu3Rv7y+bjB0hfwFmNPFosXGMPIUdWFQSZtpzIX8AVhkbcBIlUstWb8WXL
         ZiieP/i7BMYHth44EwM3O4eFFtb3koLE5jRH+VkCL1H83QM59sCRjQ7n/7bvlNVOHdIi
         NYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719868521; x=1720473321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWlZpA9w0jHOBVI29bT6ToqLRafNc0gupNX61H+Tj74=;
        b=WHgJ4Ta1RjMR0JQPB31U9i6QK2VQxO+TuE+lgZHE7Dx6xrFvHpkeUnAiQ1lfrOPhgD
         ujYJ9I2W9GXGDS1KhhE+3CRn5zfslCL+wNudowRoF72GzfmqRL4SpliylqQo0eNRSDOv
         k+EFiKHvQdM5rwxYeEagdtlvPo3VbOTNPcIm4UORKROpv5kiU4xpNjzPeo3TDF+Pr/9/
         xvVfyZCLGg/+Q9ntSR4eDxqYIgp9nGpGQkCppwCZ/aKBIJvPd+ng2XFoXPbcyTlZn3E3
         Rz1lxY+/zDj0HrSQebnFRpG1FDJK1igy4YSHcVzuG1vzUUlZLLBjr6ZgXkA66rqCLpfU
         +ZXQ==
X-Gm-Message-State: AOJu0YxrQ3feRxDaqb7Ct4wYQ1JsknWyxSPDsksgQhtL0GZ8WheMdcqS
	He3Jfr1r0rjVIgVZEkTFwRMKh1l0bn7qTy7L48I6tREsNzcAUYRs7e6csQ==
X-Google-Smtp-Source: AGHT+IFwsW3hWWkrZhat9jTx1KbBCXiKdjnnJHyxOrO7nVUQPwqBVuJ0EcOgH4GNBq8+SxQHgTyi9A==
X-Received: by 2002:a05:6808:2004:b0:3d5:4213:82a0 with SMTP id 5614622812f47-3d6b4de241fmr10476108b6e.45.1719868521304;
        Mon, 01 Jul 2024 14:15:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b54d31sm5446722a12.19.2024.07.01.14.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:15:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 1 Jul 2024 14:15:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.10-rc6
Message-ID: <096d3129-0160-42b0-aa56-a27c6d19e44b@roeck-us.net>
References: <CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com>

On Sun, Jun 30, 2024 at 02:55:16PM -0700, Linus Torvalds wrote:
> This release continues to be fairly calm, and rc6 looks pretty small.
> It's also entirely just random small fixes spread all over, with no
> bigger pattern.
> 
> Mostly drivers, but we've got some random arch fixlets from Arnd
> (mostly compat syscall stuff), we've got some filesystem fixes (yes,
> bcachefs again), some bpf stuff with selftests etc.
> 
> Nothing really stands out, with the possible exception of a series of
> tty/serial reverts ("not ready yet, revert and we'll try again
> later").
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 532 pass: 532 fail: 0
Unit test results:
	pass: 272796 fail: 0

Ok, I admit, I am cheating: This is for v6.10-rc6-41-g9903efbddba0,
where the parisc build failure seen in v6.10-rc6 has been fixed.

Guenter

