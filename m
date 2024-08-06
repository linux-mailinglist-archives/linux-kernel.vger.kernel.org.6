Return-Path: <linux-kernel+bounces-277048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF8A949B92
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5254B1F23558
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97353175D38;
	Tue,  6 Aug 2024 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OW1XKP1Z"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA4517557E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984672; cv=none; b=oYlJUL6whbpr6e4LGkRzXQySU6Biy561XxwhI7kiht3lHtgv/uKCrwd6fzffh5RhDh4y9TkoC3yWcUBdYw6oZxuiGvFAJ3sl4AY35+HN6fRX3OE9ComPAWLeJxPGVsw0gAy1B5JDhm9h4D8sADrInd6NDN2BRXKZwdrbCFJe+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984672; c=relaxed/simple;
	bh=v2B7nVx7bGwylS1Coul36Jp/i9HWOlxXDCVw6QkBijA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzjTg0MAqsHGWvVIbU6VWuuIqP+a4IwK5e/hHgc/HYt+2FmBBQX/PSZtdj9c8C2pCKxjekRcIo9eyOpD3tXQBEuwpXIGTgoyV3NVoiFtXOZKw0NqASGhlpfY1u1Rk1zcn6RzYaCrDjWrc9d9ohzi47hbYZ9EfYD9rM/asT1oMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OW1XKP1Z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fdd6d81812so10194595ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722984670; x=1723589470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QB3pdYOMTN4zfS35rYEzvo3b4e8uJgrA8HIiP1Z9cOg=;
        b=OW1XKP1Z7fPLs+FQK6koKjaoAh56LIQe4tlM4d5HcfK+4AH2IAKLK/qY05wIiUFBGB
         ICzkiqyEllzcKo+PUdePI39SC7XlF2YFaK587zZF7t1Tiu29FSYDQHIFyTT13Qt00Vhu
         n1LduAl0UIbsQzBSEVO0zuJsoj2TT2P0EJT8BhfKf5Ln6MvEmGNe9P/j/taf4awYQC32
         cPxdRwnGhhwSt3ljROGFcnUMjqbm2U835iAN1tI36Y7pAR7acDXJEdmm3UhevcSsaLCd
         Uo0NX8Hb7J3vpuO0jIqYv55IMJdN4Ns/wnPI/yLJNKQTwIcxL76JoXOw8U5XOyUWe1w6
         ksnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722984670; x=1723589470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QB3pdYOMTN4zfS35rYEzvo3b4e8uJgrA8HIiP1Z9cOg=;
        b=JGpc78FlQxbR338dJrJn5QMoXMZGMbKYFn86luulY0FcHsvpdwlQd8YR4GiB7MXY+m
         6oU8GtxQLTd4B2UavNGCSNEAijudP+6LOafZuIoMmuikn6cSHrzVqTC5x9s9HM6nlcIK
         XYwm2yyGaLAQxMwln/VCZzorpZ7dU0Y+ZbLTub2vabDEHNqrVXLrL4pPxCS6/Ob5y2IA
         YWPa7dvIyZ3fChL2ZIqpmyToS6T+WlUrjslQrWb+ljqsxa5Kv5+hv6gXjBe7WHy7t9/i
         D9E3GzIs9uoMsc0Q1sX44/Rsf1CWNXBWGEtBwTS70r8JGPEdLN5IoeyLm2O7t1pyqtpb
         bsJg==
X-Forwarded-Encrypted: i=1; AJvYcCX/6kH3al7sXUayzl5ZvsxHDNWRQDEJNnBEWE03euvzt/YdYiwMYAmtwfb0bdmT4hMJMJyl8PnzkfUjz1vZIBtRWawYrqf6+e09808D
X-Gm-Message-State: AOJu0YzixQg1OMSMthe9jUstuyzT5PR5BKbOs498tpyjvOQJIbavMPIB
	CrvZ5xsFLtc5w9vJ8hbbatxD68m1OkdFNVMnfzsU5LIN8bnbk90D54Kly6S5RQU=
X-Google-Smtp-Source: AGHT+IFE46gLoqQz8l8cruTk5/OYiCyXCPpy+CMOkGB+am/kp+K4IXuhCfx++xe6zztsBZajWiT0Fg==
X-Received: by 2002:a17:902:d2cf:b0:1f9:d0da:5b2f with SMTP id d9443c01a7336-1ff572d48e5mr238212395ad.39.1722984670579;
        Tue, 06 Aug 2024 15:51:10 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff591764ebsm92926865ad.197.2024.08.06.15.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:51:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sbT1H-007sHp-3C;
	Wed, 07 Aug 2024 08:51:08 +1000
Date: Wed, 7 Aug 2024 08:51:07 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <ZrKo23cfS2jtN9wF@dread.disaster.area>
References: <20240806144628.874350-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806144628.874350-1-mjguzik@gmail.com>

On Tue, Aug 06, 2024 at 04:46:28PM +0200, Mateusz Guzik wrote:
>  	error = may_open(idmap, &nd->path, acc_mode, open_flag);
> -	if (!error && !(file->f_mode & FMODE_OPENED))
> -		error = vfs_open(&nd->path, file);
> +	if (!error && !(file->f_mode & FMODE_OPENED)) {
> +		BUG_ON(nd->state & ND_PATH_CONSUMED);

Please don't litter new code with random BUG_ON() checks. If this
every happens, it will panic a production kernel and the fix will
generate a CVE.

Given that these checks should never fire in a production kernel
unless something is corrupting memory (i.e. the end is already
near), these should be considered debug assertions and we should
treat them that way from the start.

i.e. we really should have a VFS_ASSERT() or VFS_BUG_ON() (following
the VM_BUG_ON() pattern) masked by a CONFIG_VFS_DEBUG option so they
are only included into debug builds where there is a developer
watching to debug the system when one of these things fires.

This is a common pattern for subsystem specific assertions.  We do
this in all the major filesystems, the MM subsystem does this
(VM_BUG_ON), etc.  Perhaps it is time to do this in the VFS code as
well....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

