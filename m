Return-Path: <linux-kernel+bounces-186432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A958CC41C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F861F230C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733C2824B1;
	Wed, 22 May 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZybNjzWp"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95514768EC
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391877; cv=none; b=OW76O2GeHNYIbcPplFtgTWFUArgqEHJO/sAcG4rhLGAAjoHw2CVd0AgZEOR0ljM9o1tFQQYFnFsKwLg+3t2CsUCxJi/LJzi6KDGmo8UkYp++JlDkWwSnYHv1ds+FtDgqEOt56SGmTSweKMbaKBDNyacp1iFA/BsEoecSX3rp2fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391877; c=relaxed/simple;
	bh=DblYs+ScPiYd2IWFS83ByHnJTeIt6Z6vSH1U1R5ojrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTow7tzGdVYLauHUZX3NipmTji1zRdal3DR0GHGv/vBGEOK5W80TJ/0udgH5xJbaVL3BiPgwCIgvnu7RWcmTbxPVNqZxB44iG4LXGFbVd163zLEL0C3Iy8sbbVhRazz7nD3UCg6xfwoIoRQV+swgkep79Zdi/yudEl5MDS7yRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZybNjzWp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a609dd3fso201566766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716391874; x=1716996674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOnW/DfLA3xJXZ5u+WZq3O9RUUMYHYU/muej88lDrWk=;
        b=ZybNjzWp/+wwasCT5weeIL7CIV9zPVbn/53q2/YeEdPzrRjUVaUi6s0hooWjaQLh57
         ACf3NUu8vvJM+BtTMi3VwOKEaH8/xzva6JDJhFguY2xOMmQkWY8mVSBuTJb8+kL3Ei1W
         QExy+8Tuw35gz8NEzePbjK1dM3BrB2q/Z+UR/BQ+r/jm5kYPftj0YT9d/Ur07hyGyh54
         hI41sihIJIAG7qRRB0mU6h5b3pAP6phowMoKSrV/UTCd152tc2nq4KqRYI6/TqAoTCm/
         0KdqR8UQVKLk5iHuh57Z9UHegna2I+Y+MfgeiDBIb/jwskkZSqtLHNXTUXP/p3II5wyJ
         FsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716391874; x=1716996674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOnW/DfLA3xJXZ5u+WZq3O9RUUMYHYU/muej88lDrWk=;
        b=ZzqJyej9b8FGwHYNaq6crCY4sYQLchsyQ/6R+fWW5Ne1WXGZbvaoqeAQZhrFyM4Uk8
         JUThxaUHlsGB2SyW8tchGx2FqhAwq6pnYaCcnZjyNiSSG05V5JmcXvJiP6/H7ynUvYxP
         aSw7OEp0/wlU7Ah1RHdM7NKHxZQqPPsWWvG1Z8OBD+c/bjP6pzcy0n8aj0m/bg5dHi9n
         KEKngM3fKZBTRakf7RrI3BbM6696RyI+A3zWhAwk6fQoS5toXzsjlU7D07mmI061Vl7h
         k53/fiL9rUXgsmpDgcTBQsY4rCZsEnMyZFbUod89gjGYr8J4WtUj8LGCELDwxEWvk/tC
         CrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYFi/HOx+6hnl0hWLv273+Xf8V2Pr0S74W0GjrzxJj0nkZx574t/lvn6EbOjTILCWerNieLqxq2nwC+9Wo0cYdDeGhneRyrC70wx9Y
X-Gm-Message-State: AOJu0Yz0VBj1XwQpzRmCBxrnE+VMj7AOYs9XlnD+fbWsH65RKVsLbkVq
	WEfIJt4Hc+DvqiFmIfJnf/M7yHubrCtzAdT282NVTQCCxVkm6imFV1hbM5VLB+c=
X-Google-Smtp-Source: AGHT+IGqVvLYq+kT50O7GsSXXYDLUBYlTXLfwZdhz5s8zKLbBgML4M/AO44hf5zj4i1wkF2z2CAoEg==
X-Received: by 2002:a17:906:3cea:b0:a59:9f88:f1f1 with SMTP id a640c23a62f3a-a622314c52dmr217055966b.19.1716391874015;
        Wed, 22 May 2024 08:31:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d40sm1781965366b.75.2024.05.22.08.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:31:13 -0700 (PDT)
Date: Wed, 22 May 2024 17:31:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
	anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v6 2/2] tty/sysrq: Replay kernel log messages on consoles
 via sysrq
Message-ID: <Zk4PwD2ZLldFAqEE@pathway.suse.cz>
References: <cover.1710220326.git.sreenath.vijayan@sony.com>
 <cc3b9b1aae60a236c6aed1dc7b0ffa2c7cd1f183.1710220326.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc3b9b1aae60a236c6aed1dc7b0ffa2c7cd1f183.1710220326.git.sreenath.vijayan@sony.com>

On Wed 2024-03-13 15:52:52, Sreenath Vijayan wrote:
> When terminal is unresponsive, one cannot use dmesg to view
> the printk ring buffer messages. Also, syslog services may be
> disabled, especially on embedded systems, to check the messages
> after a reboot. In this scenario, replay the messages in printk
> ring buffer on consoles via sysrq by pressing sysrq+R.
> 
> The console loglevel will determine which all kernel log messages
> are displayed. The messages will be displayed only when
> console_trylock() succeeds. Users could repeat the sysrq key when
> it fails. If the owner of console subsystem lock is stuck,
> repeating the key won't work.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

