Return-Path: <linux-kernel+bounces-570176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5E1A6AD23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36DC3AFFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF422687A;
	Thu, 20 Mar 2025 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="WfbHmWmW"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4761E8359
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495496; cv=none; b=Iqyin+EqFi0C0lTv/CKyoOhgT09BQgDmcD9ajh+WRFqQH7UhULUXagX9qA83AeGnj5VE4K1Zh92N6VVk2ahyJ4siEjeASZtaa2Raxl7AL1yFqfXcgPblDrsReLUzVWAxJhw477Ne8ICj9At91Ilbs1vp6Mo9s5ah1+JtdnobFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495496; c=relaxed/simple;
	bh=KW7c5R9LPeRvdEkyrrPNb19Z7ay+Q1gA6RBTzjIj+9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxXkTIdiXTHxVbWRsDEji7yRjycTBbWSW+WDG6u5mwTxjpNBlVkhrDMifnF8AF45etmZ8IPKUEy9dDkXj6mwF5T5nJO02IwLtHxwQ/btIBf07e7QswkIbSECw3ppbU1AGLYVy+fF3kZUObWJ06K2qO/3bAQDJUnVXaZfaoueJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=WfbHmWmW; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d439dc0548so3624915ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1742495493; x=1743100293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xs9sWGtkq4Oqg7PObi/N0JVnImd5J4EMGp3yDmOQZM4=;
        b=WfbHmWmW/z1LpK8pe87aezjgqxjIMA1eMWPRTq/11QndkF0ZT7kWhoYqAUiW26/WCx
         EfcH9r95qfaTL0GrFMhL1Cn+87efV/rPlG1+axrm1EZ47USYrF5I64Qs8RwpHjRgoA2F
         e/b0xlJuZf+NzyvG4pWXtiBpV1rMZfLurxIFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742495493; x=1743100293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xs9sWGtkq4Oqg7PObi/N0JVnImd5J4EMGp3yDmOQZM4=;
        b=bUw8hqwbk3fHMCT+04RdbLeZW3EGGTJL6lrVhKw7DLTJBdbnftrUFCmU16/66/vqRc
         25gWIYFyNOVJ/r/2MrvCfpyRf6oJG/QtYh0gow0F9s0/3nHZdEnJaiwoM99Xpeyu/CHz
         uqKQs1Xm30HJ5USYNF8JcaN6DZFvspieLE4/mfCKaPo6Xbx2f0Bnc63Qur8zVxoHmjek
         zp65aG8g97yHXLMs8yb2hCZZ4j1s3e/PFIFY9xZW9jCqmJp8f71RsMH+a72u9WkSJdiQ
         +pYaVA/MU4Go+3IKBpQwBqWQ4X3N26wnRuCR/5YipgozOxU6XDdgzkfbMqj31zTilIx0
         u9xg==
X-Forwarded-Encrypted: i=1; AJvYcCX81tU59aNb2c/6oX0iQWtHKA/xR3jK+LS5Z+dnNaatagXa3n5WPCKrAXb6TcfVqABfI0D14f9VfqBm0+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YygPdj31vCMas5gOk+pnloeIXyOGhtenIPapyTF/B/urCydvfST
	zF0URJgI4QXmASJmW3ygiSHkwFvzLRYW/AkF7i70eiG/HfEGT1z4EMPsn+VvRQ==
X-Gm-Gg: ASbGncvCU8ZVs6IrBU5jbPjeZNAheAP26yMSzymo/Ja0pk51WWkh4IHHH8ng77hf/P2
	Nc8xGJeIj0oZQNVTQJCd9bkESnjkOoZDsca1GWdHwzyZyyTQh1iFaE7bxMnbQ0yzTsw4+kaYOcL
	tBEOdho4fn19mDvEB+/2+6WQG+h5so6DslYtz+4diNIyA4wlw11GasyW8fTj7HDM4mG29czxPDF
	YdQK6jofXr8AuHPT3Dvvf1ZoU/YXSV+rW//jet2rL5XRFAtmvTdg5vUrLZY3o+A6MVzPCNvaO6E
	VsVy6UPLSH6yAoc4676WWTT/n+n3TGzqRbldzgHxtP1/6y2qa8vuQbWJ0rw/pw==
X-Google-Smtp-Source: AGHT+IH1B/ENspb1EAT9798Q5mHyvjf0wtm7TPVZ0us1pA6jy9nfdcYp5nR3VG+erfS7FWqlo6BnRQ==
X-Received: by 2002:a05:6e02:188b:b0:3d2:b0f1:f5bd with SMTP id e9e14a558f8ab-3d5960bf875mr5574885ab.3.1742495493404;
        Thu, 20 Mar 2025 11:31:33 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdd17f0sm45233173.45.2025.03.20.11.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:31:33 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 20 Mar 2025 12:31:31 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
Message-ID: <Z9xfA8UujBjRf5l0@fedora64.linuxtx.org>
References: <20250319143027.685727358@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>

On Wed, Mar 19, 2025 at 07:27:50AM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.8 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

