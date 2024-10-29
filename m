Return-Path: <linux-kernel+bounces-387378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B059B5020
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFB81C22B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6421DBB36;
	Tue, 29 Oct 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="DAVKcMtS"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90A1DB54B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221635; cv=none; b=mVUBW2h4xuqfp8GT17k49jQmIWX2SZ2HzIxXTDw2qtdlP+Fq8LOBdz3buM4XE1U+wPtbGZ+kMCuB1k4OOznbpsv8hQep+if1XZjkDTav9gkT7X8t3yVPKf0G6fgtwnZsfZ5fe7wX57POThO128eruQgcnzL6hH3d68cn0OU+ojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221635; c=relaxed/simple;
	bh=HIAt7Xdq33eEcSF47rRGWWp8L+H3VMAAWWAYqZoatgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHYgOiC5SN1SD7Z6xdSpQnZ5NLvhP5Sric1pydSrmSa7KfT9VpQUNA23hPqebSD6KpL1k7fzSEGUiVTFUzRZH8qoa/laH/Dv0XIy2caQEzInliDwnDdatOOgsHECKm+ZWub1NA5pP62yFsmxbh/lLcdCEDz/ENKdqqPDWUfAv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=DAVKcMtS; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b463e9b0so20734435ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1730221632; x=1730826432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prNOXuzq2k9yHwgN9GjPKL//CDayG10KbbsLQkFhgd0=;
        b=DAVKcMtSJt2Brj4Rc72qMB/vQh0i9ntbDU4KNo/TaMxI+ZqoNQV21BBGN8o0fLqkmc
         3aOMVxAZvwMzHktylxXkv4mne1EAYRCv2827JQLFOW5ExlyE8H9+Z3u/7jcuj7sPEMj5
         GJRbIvkRje3Nl1tbs+/kJ+OQstl+Nuq546Al0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730221632; x=1730826432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prNOXuzq2k9yHwgN9GjPKL//CDayG10KbbsLQkFhgd0=;
        b=xHU9tmwkTRcJJCQPikeTYAU/Bdvvi4Bf3peBaFqjwBZ9l5AuUr2ZZ2IeucntpWyjy+
         8yWsEqN+tuMvpKnRqju79+iVBYdbdyXs51zRKJSka3K0YuL+5tAAa3OsVkuUrbNN1C5W
         Dp/NO7+miZrX5X5e+lEtUjU5bF7Ird8vjFppkOXs/nr5dCJp+vUuJdl5+QYVKghrukst
         xwyZkJRyD6qrykbDcE54CK0ZRFUorVI6Rp9r+qXO33pdUgMQ6dFWawgjTmNdfZn5C4Ni
         nZaOEK09C0UVcMFBKUMi+KyAtqdsUhZmCZgNPAVaEPLVY2tOdmaA/ZF2RquUh5uLshDt
         JmgA==
X-Forwarded-Encrypted: i=1; AJvYcCU22YffigvlpSKL9YT0IeSVomfeTjDn21H1a7ai8VKMZNzYabAEZx1YiuvZ4Xfd+2od+93SXtyMR70+A4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8CCODYGsSbr/iU4bPjGXM9Vxk8Gh+u2MJKsuED02unwDBnMyn
	DYyq+xFgOACHsZyhkzL5YmNN0gww7X2x5N1zjZGXdxnSaJT5Uo6ePKMGEdjW2A==
X-Google-Smtp-Source: AGHT+IGN9Ci4Y8VOHnsfF3L5QUISAu+V1eVqvAiXjJUJFmaZ1nzDtFq+vrmYfNB8DmH4n9y6WW09Ow==
X-Received: by 2002:a92:cd82:0:b0:3a4:d9d0:55a6 with SMTP id e9e14a558f8ab-3a4ed2f4ad5mr120407025ab.19.1730221631706;
        Tue, 29 Oct 2024 10:07:11 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc727b245fsm2480505173.179.2024.10.29.10.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:07:11 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 29 Oct 2024 11:07:09 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/261] 6.11.6-rc1 review
Message-ID: <ZyEWPUUCBMQArAP_@fedora64.linuxtx.org>
References: <20241028062312.001273460@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>

On Mon, Oct 28, 2024 at 07:22:22AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.6 release.
> There are 261 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

