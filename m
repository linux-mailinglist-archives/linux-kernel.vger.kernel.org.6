Return-Path: <linux-kernel+bounces-304164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BBA961B45
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6732852D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5701B5AA;
	Wed, 28 Aug 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQs28eMk"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9911CA0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724807431; cv=none; b=jHjzd8bI+w+FRvQseRn3z6hJtpZignroM6cCOf3J5rwGKKNbLSKT8Y11OfDNFtyPweGmlmY3ytRHW2c1r42E/FE0qIowu+Y96TBKANJgIr0QETpgyz2XR3UZum74MngS8/XiSFxk3k4MnV8IjmfI3hupveH+5Lih3B7jZrMgRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724807431; c=relaxed/simple;
	bh=AuLaYQ6hGlE2Qz8ZX/thqSLpjLbNa+eI2JoC70MnK38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYUA+3fD3XebvfClNs0aTc6ARYV/9bZhfIsokSGvTFAXt8UAr6znoiKHtLoNjaKAUFG06tQZ1Il23ax2EZCQshRFW9DABmj+xZKsPNj6OSchmRNEQvQ5iLDQUaHZsY4G95lCMi8n2oTY5YwC1gNACyqID/MjD5fhnYzAyi0uPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQs28eMk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7141b04e7b5so3818394b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724807429; x=1725412229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PjyeUnjfze9Oq2Y7CK0+FGKkLjQKXuGNbg4jbEvLWgA=;
        b=QQs28eMkxc4EFbdu/C/9m/UL1JC27LFJllqVZFqqW9+QTnIlPr535zvr29uZpHab+l
         XutfmUPuWb6QI9lxlbWLADoat7GPBSXZW93V4bu+x+kBthMlp/Sx6T+SZ9VrcFxKM+av
         BVx/XLGjLC45K0qXw7Q0VC5W9TnOqTjDPyRPZNt/AmNK9C03cmfWo/4goLtPzY5LBIFb
         tih1D9kPT7wGB62GHX9T/8xDJGi+jLAemJ6mwS4k6VkBqYC7m/xzJ4EHa+3yqdoChKla
         C4uJuCvlAcJvBIBZ+piL2Bk5cxGLqI/uJYQhim3G/bAiwI/RS2nIw/PZApAgiuqgqftD
         L5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724807429; x=1725412229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjyeUnjfze9Oq2Y7CK0+FGKkLjQKXuGNbg4jbEvLWgA=;
        b=EHDA7+rsn4xPsRqHmIKfW9BchCZ1ylTW+bViz24aQMUplLUJ/44L0CPeLBgxHwQD/6
         yl9qrtG+yMQB6u+PLXrV37iC32q94UZrUsjDSIVYj91LYk6eoyPGt30ZYoscbNBH5YNQ
         YQD6Y6xTBA438uPazy7aXX4JEAbrY/oQqSiw9GXfrnP4BjBe+GhfbZzHwS1LOQHPizKd
         g+DbX5nzlB7nCiTXNDm8rsh56izqMcyYBBPknicM6SDidJ2nCul2xZlKIk+euY31e79F
         BWrqraNhJ4wuDMF00oZB+w4AVUm0MSOuz2q7Vvzgjh8otcxKOHZFNlES39SpbtyDo5S7
         VsUA==
X-Gm-Message-State: AOJu0YzccwMQYBwBwdiJz3RszEP2RRXcsQkKPneU/Xo50EC+dNEJmwpn
	QIa+0t02XIt24JuXM585LQ/h2x5bcE3mHhJDa8ClMtEizNcjSlJ6hDYSKA==
X-Google-Smtp-Source: AGHT+IHVsGntcgoA5ewInxBnsCtrgkmSCCTZqEMFvWsuzSyefsys9DoMoTHAk3YNU+x0nIJRcsEtDQ==
X-Received: by 2002:a05:6a20:2d0e:b0:1c2:97cd:94d8 with SMTP id adf61e73a8af0-1cc89d6bba5mr18020222637.20.1724807428554;
        Tue, 27 Aug 2024 18:10:28 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:95c4:e75d:161d:a90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143679cd7asm8960108b3a.112.2024.08.27.18.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 18:10:28 -0700 (PDT)
Date: Tue, 27 Aug 2024 18:10:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Woody Suwalski <terraluna977@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mouse_cypress_ps2: Fix 6.11 regression on xps15z
Message-ID: <Zs55AWhUEts-uJ5B@google.com>
References: <a8252e0f-dab4-ef5e-2aa1-407a6f4c7204@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8252e0f-dab4-ef5e-2aa1-407a6f4c7204@gmail.com>

Hi Woody,

On Tue, Aug 27, 2024 at 07:44:12PM -0400, Woody Suwalski wrote:
> Kernel 6.11 rcN on Dell XPS 15Z:  touch pad has stopped working after the
> patch
> 
> commit 8bccf667f62a2351fd0b2a2fe5ba90806702c048
> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Date:   Fri Jun 28 15:47:25 2024 -0700
> 
>     Input: cypress_ps2 - report timeouts when reading command status
> 
> It seems that the first communication is with an invalid packet of 3 NULLs,
> and that
> status failure used to be ignored. With the above patch it is now returning
> an error and
> that results in a dead touch pad.
> 
> The fix is to stop flagging an error for 3-byte null packets, just keep
> ignoring them as before.
> [    2.338016] [    T591] err: Command 0x00 response data (0x): 00 00 00
> [    2.338032] [    T591] ok: Command 0x00 response data (0x): 33 cc a2
> ...
> [    2.770029] [    T591] ok: Command 0x00 response data (0x): 33 cc a2
> [    2.998030] [    T591] ok: Command 0x11 response data (0x): 01 00 64

Could you please send me logs with i8042.debug=1 kernel command line
option please?  I wonder if we need to wake up the controller...

Thanks.

-- 
Dmitry

