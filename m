Return-Path: <linux-kernel+bounces-347031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA4D98CC9C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732B31F21F97
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0AD8121F;
	Wed,  2 Oct 2024 05:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O5XcbVAw"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49165328B6
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727848427; cv=none; b=urK0PLw0FIekAX6Lw+6pUZbje5fVi/ibnsKUUH7+gPUPkz0xyWRcToQBP9ZpedyFnoyqB5ofFv2v8OROz80H43bbTjsToOedJbktbkwnNaOeeoN9XWvBrg1/or8UIGuh/p0h6uHGN4it2QDl1SqOWoHIhTSqwKVWlZpzCDqpcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727848427; c=relaxed/simple;
	bh=SIgX91uTHifWEtgReNCzhIe7IG2O8Z1SQtz8/H0apK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJPw/V9GB4JWLCKZEM9+H/spf+IuYmynIHiuvCpzL6oDCjIijcVxVfGrPBY/uOtu1yec9Ad7Mmwr2s5rSkXOYfGlmvWQDv/oGxuxtH42us4aL50RzH1qLxFc3QGF3V3nUPSf62DRpTVFEmGK3QRIgilCTVTkscBHoXqq7n/8yyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O5XcbVAw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37cc810ce73so3615149f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 22:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727848423; x=1728453223; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z3bBDoAXmx+gs8b1KuDNQSPhrXil7aJHswuVh/xJcY=;
        b=O5XcbVAwb59+wKirArFvJcotvGIpkAhCWVYyhrDF+yCq43Zl2p7edf4Xyzghy6P26d
         0Ci/c1Z4nPPpSxYMKDvKQBGC7FLwzr+715Zagy6SW0tbGGgUF8tpQRpJGkdxnwZvXrMQ
         aFBCsJFxv1Hl8gp904oMbOmMFfARy04pVdvE9fb6C5MjD5QeqyxBCnBWrUFARoPcEplX
         mvndmweDv5bDU50PvW2zl9a8H4ozZXk2faSwUiR6/vFC2o/6Ay5p9Ih1h/Q0xH7fsZAW
         tbPPkW+yqjZP3eXS7Q3rtxFzMXNkQ/meFSPivHRAFuBllwHimDekINUtcgVS9IBMXi0D
         CAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727848423; x=1728453223;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z3bBDoAXmx+gs8b1KuDNQSPhrXil7aJHswuVh/xJcY=;
        b=D1SHOx3Il3Bo8XcOc7VrpPOxPRd6aggq52i9n7CvL9yS1dfG6G7whX2pfBrIYqLSC4
         EfqL+/hCyQZE8xYWhm1eKQufx/P6UYndOoQbTL7n3gOdsfmHWwZYSi2dWgEyMoiEqRg0
         +UgIpnlED4Gb/arhocFIidG9T33lryVpQuWakxDHyGJprvfrM9MdFANJy7IEouAFND2B
         rDWd0fI7wX3C3jbQqwBGbHjnYkvXVcXLBaxVfTzdh5GPapIXrDG0afPkr6m2TJKAZxcf
         fNPp0mQKnlPobGwIWcGToVqsIpX+UvLwM5cCuPuDJo3QXUH1m+XQsEXw7EsXWmkEz7/e
         y74w==
X-Forwarded-Encrypted: i=1; AJvYcCV7FcxjJ74/lsuiKbsv1L7CvJ87ZCgycgtb41hB6HZ4OGLVjKzN3nzBBT378kWLGk0MnIiK6zDDAi/u+A0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7U4oFotRDYo9wqdNAQRY/zhfbG0tCtez65LKejk9Pd2Qe8VnT
	wENe7yOs8mLd0WobzkLDiZXX5xzLDJZdfZkFUPq3MyM/USYoLOzHo5CuSSxKJ/U=
X-Google-Smtp-Source: AGHT+IEYmAs+Nb8DOVp6b/C54wZi0j4LpH8rZzXj+DcrAl6qDLY7Tfv4lzNuqeMfdg2bjma+P+w37w==
X-Received: by 2002:a5d:694a:0:b0:374:bde6:bff5 with SMTP id ffacd0b85a97d-37cfb9fb82bmr892437f8f.46.1727848423184;
        Tue, 01 Oct 2024 22:53:43 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4e24fsm78588645ad.244.2024.10.01.22.53.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2024 22:53:42 -0700 (PDT)
Date: Wed, 2 Oct 2024 13:53:38 +0800
From: joeyli <jlee@suse.com>
To: Valentin Kleibel <valentin@vrvis.at>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20241002055338.GI3296@linux-l9pv.suse>
References: <20240912102935.31442-1-jlee@suse.com>
 <9371a3ab-3637-4106-bee5-9280abb5f5ae@vrvis.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9371a3ab-3637-4106-bee5-9280abb5f5ae@vrvis.at>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Valentin,

On Thu, Sep 12, 2024 at 12:58:46PM +0200, Valentin Kleibel wrote:
> > Then Nicolai Stange found more places in aoe have potential use-after-free
> > problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
> > and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
> > packet to tx queue. So they should also use dev_hold() to increase the
> > refcnt of skb->dev.
> 
> We've tested your patch on our servers and ran into an issue.
> With heavy I/O load the aoe device had stale I/Os (e.g. rsync waiting
> indefinetly on one core) that can be "fixed" by running aoe-revalidate on
> that device.
> 
> Additionally when trying to shut down the system we see the message:
> unregister_netdevice: waiting for XXX to become free. Usage Count = XXXXX
> on aoe devices with a usage count somewhere in the millions.
> This has been the same as without the patch, i assume the fix is still
> incomplete.
>

For the reference count debugging, I have sent a patch series here:

[RFC PATCH 0/2] tracking the references of net_device in aoe
https://lore.kernel.org/lkml/20241002040616.25193-1-jlee@suse.com/T/#t

Base on my testing, the number of dev_hold(nd) and dev_put(nd) are balance
in aoe after the this 'aoe: fix the potential use-after-free problem in more places'
patch be applied on v6.11 kernel. I have tested add/modify/delete files in remote
target by aoe. My testing is not a heavy I/O testing. But the result is
balance.

Could you please help to try the above debug patch series for looking at the
refcnt value in aoe in your side?

Thanks a lot!
Joey Lee

