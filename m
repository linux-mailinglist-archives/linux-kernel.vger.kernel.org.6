Return-Path: <linux-kernel+bounces-306838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DE2964470
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB35B284F98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96546197A99;
	Thu, 29 Aug 2024 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="U0VrUGvi"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE66195FD5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934589; cv=none; b=KGD/aI2eJl24POezqtdjL7focGT2oSJqWqfQCilLqPf4Kwbp+q/+IOX1qoSJIX9EbxjYNtKzXEhTwKVaUAI0HlQK2kLFftQOsAdFsvrFU8MuUn2ZLF4Wi2qbEb+HxH7UGphlfsMnv0BWyEwJ1FaC8JdrCfLUibytyo5qy+9bAyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934589; c=relaxed/simple;
	bh=FGHM4XNfa/cVlTtzzUXPSLt9FVuJ0sM45yJhXV9JDCI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=igP8k3WavbmpKWOOdWVPuLOnvO7FGMfUbKQA8OIK2ClmR7LG2nGFG5UqykD5Dm853FatbN/UrCut9XDZhTkVQwTQuzNM3kHN2bVoNPdnbkgFpEslE/5xMkhjoATTmvK/Iff1RK8sXqMgoTxDBKa5I4EV2e5nKSdXtBKj99Cf9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=U0VrUGvi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86a2fb30aaso3903666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724934586; x=1725539386; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yi9q0gAo3pbGHakMMQ1qlw9QBFV5RKXeNwADykw9ibU=;
        b=U0VrUGviA78NIc/Ny3WC9WDWYTagQ4y7ygBmpezMpJ++bPGjwm532NF5Nh15Ui3hgn
         sFLeUqDVMqdgRqQGY1XKfPCsckeYQJvP4ud+nl9GVNrTUo8xgfT+/jM8Y3R9pjfWM+Jw
         K4f6r0E2/KbE/Ut8EDsDw5xF0zPs0tsx7Rh1yVlAYwiuYWDtv5MJmWvp8mdbEzV1RiAl
         bqhHHFRH/9kZDUzjFktg7GlrrAItQG5UVuYI4okwbXSvNSBKZZjRE/maGUY8P9mF/MY6
         wxdZfYRu0diPFHbEfjmfDEnYIafGEuI1o0s2nKZxxBJgLJy5UC5cZ4EE69jHyP1nLYXE
         F5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934586; x=1725539386;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yi9q0gAo3pbGHakMMQ1qlw9QBFV5RKXeNwADykw9ibU=;
        b=m8TmiQk/2C4j5kCjpILQD76lRyrVx6bDjYCxW0AWyRkgVQJ2KQ3PTZg90JsxHz3vtP
         PGPDlCQf773RPM7uJ7q5fBbTg6fM4yIM5EBgby6brk7SxaDGfnTUBMJBIuxLNJLyLbtN
         eUycw1av6WVfvhtgqt/8eBXone2LqbF8nBOn+fl6nmXpMabyK8WI0O4ZR2/Zx7UKlkzB
         iQu3l9KPoKWlsF45mVy/mCviG0HatistT3RCRjFiCUcn7WMisv73rM66gZzF5bioQGSd
         +U/1quGa2x9gCoEF4kmD7aYly0s+7FqvFLJfKz56A7D6mx8abcOA1wcvuSoysAKDoMhK
         ox+g==
X-Forwarded-Encrypted: i=1; AJvYcCVAozfZ4WzMZATJmjgdCDOb/cS+z7KdbnSegIcj/OtoBOeWU2XMGc1VczUBEgexnfE92jWYQJbYQj3FdII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZVfp15DKk+JSo6YfbCLw9PniksMvtiRPhUrp91sh9Z0M2uljV
	OoFQh0XxmWJu6KJGFjM8IyIct+icqQP2nn727IbkfBsQqadV8IdYkWl35m0OUwA=
X-Google-Smtp-Source: AGHT+IGC9nmjU8Jg5RFOgij0MQ/hzj3G8U3KttB3SuxCDoCApdLe6XuQc8iokX8LRBfJC/kKOpynpQ==
X-Received: by 2002:a17:907:3d88:b0:a80:79ff:6aa9 with SMTP id a640c23a62f3a-a897fb15d30mr118842766b.8.1724934586358;
        Thu, 29 Aug 2024 05:29:46 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:2965:1b4:50ce:19ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb0f0sm73372866b.20.2024.08.29.05.29.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 05:29:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RESEND PATCH] fscache: Remove duplicate included header
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240628-dingfest-gemessen-756a29e9af0b@brauner>
Date: Thu, 29 Aug 2024 14:29:34 +0200
Cc: netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>,
 dhowells@redhat.com,
 jlayton@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4A2EAFA2-842F-46EF-995E-7843937E8CD5@toblux.com>
References: <20240628062329.321162-2-thorsten.blum@toblux.com>
 <20240628-dingfest-gemessen-756a29e9af0b@brauner>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On 28. Jun 2024, at 10:44, Christian Brauner <brauner@kernel.org> wrote:
> On Fri, 28 Jun 2024 08:23:30 +0200, Thorsten Blum wrote:
>> Remove duplicate included header file linux/uio.h
>> 
>> 
> 
> Applied to the vfs.netfs branch of the vfs/vfs.git tree.
> Patches in the vfs.netfs branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.netfs
> 
> [1/1] fscache: Remove duplicate included header
>      https://git.kernel.org/vfs/vfs/c/5094b901bedc

Hi Christian,

I just noticed that this patch never made it into linux-next and I 
can't find it in the vfs.netfs branch either. Any ideas?

Thanks,
Thorsten

