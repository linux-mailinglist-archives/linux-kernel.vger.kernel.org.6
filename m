Return-Path: <linux-kernel+bounces-404301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D23E39C4224
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588C3B26D05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6019E7F3;
	Mon, 11 Nov 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="K8Hrj4gY"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3547142AA1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339925; cv=none; b=s1O45buHl/iSr3uU3L1bl46Eln17fThEISrXLiZzT3TVYFqoH5yqE/5lrHZqzWzt/0bf0ICNDx755NxWAmCAcJWEKcF2EZvwzCMH98iKonadm6jm/ACWK87GFmygRHLrdSrpUSx7wN1kUrSnGJ8nRzSSca5db/j9cNCYe9wJ6cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339925; c=relaxed/simple;
	bh=exa2y6eKjt46ZR+xY0nZgxZZaTA8O9D4XD+FG9JWtlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1Q/rgkEo5bva8RoREHj1+Dt8ZfEdrbLi6QJiFsP2AXmk2zEb2jqvJxEqG4BtFRUkea5RgsoTb37AmpPrd8CSg6yfvPZFj9F5j+b4sQWr76DmYvGrYHn/vbrkXOaQxkwHz+9oocYRrrqn1FBBU2f8lKxJSssIws28Qit28zFgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=K8Hrj4gY; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4609b968452so33713521cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1731339922; x=1731944722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iCXsU+nIi3O7Py500c5fEHZL4/6y1J44sJ8PdhEWdk4=;
        b=K8Hrj4gY0JU0XM+wiZHO60gS031T5f+Y/cDHMmm3MKI2SVaBvIAnT9VMQy3lQRE4xV
         IZwg8AksyprVvUgf7HC/zeuoreWTmgh9el1NTp6tRx+Dix/JPkcoitYGc7rf4LeZ7OSG
         AzkQcJoXZZxYKACz3RtIyVkBF+26KYOOhj0Omj05ztjzrjNWFK+5Uo9gDDuvobgTeqVO
         spDAW7aUeKq5H4jsvrYKpISfcGgbHwDY7vsHNd+iaRhm3ERiN42Px+X+YRocx434vZuz
         39W/ysCdHcho9kvbm7X8JQ91CJikpzQbYkHSu6zd0UHFxSCJmZ/6i2hHXtM/fzIRGXl3
         kxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731339922; x=1731944722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCXsU+nIi3O7Py500c5fEHZL4/6y1J44sJ8PdhEWdk4=;
        b=STriSiqlPeJDF2dL4PlnXB94fpHrR8zCu+50Himx/SzeS3NGAYu428IrAJMPeTFBid
         LeBJQ+qDR7D9t+LZ1eRhczsSJdpnnKE8XsXrZo0Lmii9SAv6s1QS1ipMhZF41Tisp1XS
         ROE5xh0gFhxcVnxkenp8Ay1xyrXxum7Miym71yl/8zKC5d6L7HYgTPtlyob27lJ/oJct
         2640gxzboVkjMS1Tm1ArTCnXBnL7Oo16gWAkakw3P/syN5FQp5a1a1bRnrTWaeoDi1Jv
         sfkP8QxJ1KxkpwvRZBCct1XJeoycMNPznSZFUCudxI0MsCbyC3XKOpHw3E1bOiHsf1sB
         RFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2YQ+Q81jZsQnYYwkgVZRzDE5EV7AR/AyS2Hac043RzN5O0xwuvSom483uJW3m1TEyt4ICsvnIJphzbGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIaOeEFIBEaN9btIYNvyUgksHQf8kkEMFWXG+/DeAEUcORE1+F
	2X9SPhpolGE2Fhq0ywcquVA2sCvPMmXQ+g50iM1DNcWTVNDTE+LfskiRb+iXSw==
X-Google-Smtp-Source: AGHT+IEj3sl4CA3R9xS24YOsLMugaKGVPIrva5w5VBDVhL0F6m4Bo20B2UlSKP2+WdzSbxHG/fODlQ==
X-Received: by 2002:a05:622a:294:b0:460:bb96:dd08 with SMTP id d75a77b69052e-4630930ecfemr184669691cf.5.1731339922180;
        Mon, 11 Nov 2024 07:45:22 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::9dc2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df36asm64043171cf.18.2024.11.11.07.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:45:21 -0800 (PST)
Date: Mon, 11 Nov 2024 10:45:18 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+e8e879922808870c3437@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in ld_usb_release
Message-ID: <1af819ae-cd88-4db0-af6e-02064489ebb2@rowland.harvard.edu>
References: <6731d32b.050a0220.1fb99c.014d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6731d32b.050a0220.1fb99c.014d.GAE@google.com>

On Mon, Nov 11, 2024 at 01:49:31AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1650d6a7980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b77c8a55ccf1d9e2
> dashboard link: https://syzkaller.appspot.com/bug?extid=e8e879922808870c3437
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Question for the syzbot people:

If I have a patch which I think will cause the issue to become 
reproducible, is there any way to ask syzbot to apply the same test that 
failed here to a kernel including my patch?

Alan Stern

