Return-Path: <linux-kernel+bounces-342080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCF9988A62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78B61F24535
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2CA1C1AD1;
	Fri, 27 Sep 2024 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="htT5hZAv"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C376171E76
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463119; cv=none; b=oPwJuhDOWeFeVrDEMaH3+4WDEF2q137pmC2bVbYRSdsP9KS7orh5MyU5fflv9wNQmT7kYSRMI6AjlbmYB0reujrVvJKzpDuBLqR3VqBjiMYp4/RhJkQ0ogAj18CnKtVVluExjHRnFbtcKUyBxaF3eClLAhxEbJt0OczOI+fbkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463119; c=relaxed/simple;
	bh=eITh1z6ROeAVjf34DngYzl3Vc0FLZBZpfykTmNZoXY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDJW3PscRGKUtg+4u/X1qToVfNinO40BdwcPHybI4rHdPeb2ZO19wylYIsnlPC1Zf5scSJ77unThOE8UATZZcmQcfAOPKjwzMU+YHhj6ETUOEMGr2cTDNBmTvC0VyH3c1j8OHg5Jt+yt2a2Ndd5aGRTPwo/4Bsc6g8lroNwLQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=htT5hZAv; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a344f92143so6357045ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1727463116; x=1728067916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxyQQgkA3wMtE3Hi9DOhcULcCDQzTPtIVdh2jdevVzY=;
        b=htT5hZAvsc4OzGUhVRT0aOz+u1Tj4OQsqKOwZKMxumVI9srorEk0Nkt12LoxPPkxrb
         G0ENv9lBv11YkPUPnrnrQ88UNsBJ9rhNuIF1jqb7VFlQedkvWhZ8RBzmXHrSNo6kHAEB
         O1ECxrFJ6/QW8fe0ceXVzejqRAZZQqcOOLcUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463116; x=1728067916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxyQQgkA3wMtE3Hi9DOhcULcCDQzTPtIVdh2jdevVzY=;
        b=XwAE+yMZ9EhdoKQVwpkMzzgsfYKBu1v5GuTw51Yp78VkAIV5WzZuRhM5101/MLBlE1
         AIzRD/455eRyyPk8EGTfIo+Goe/wUN7/Wp4VcEr5eYISCh1FlSU/94ed2ys8kEzGshXi
         VZenQ1O7AziJNAn7fCYOU7frVxpDGGxWcChLp9i1+AUS2FUOCUJg02W0BqXHq6FQQP3I
         j67ieg28EkMpxOaqmDA/VhUEr7rAckdhpvrSMIIqlN/eEcAGIHDw6I0dK9dJQG62Ixmg
         1ewEqt/zr+KrV0V2lHnFDR1xKWTxlKDjNwi2FI5KzJOV/W3OltTUxTEm2VV6B56mLnE6
         iBjw==
X-Forwarded-Encrypted: i=1; AJvYcCX3hVkdj0oPtad0DnmGJLVwlV6BVx/AGuWTCDRKe9SLI9RoXe9YXJaOqJ9sVGa0uoI00QgpxYDnHB2Qyiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOCm81OYcE3wLXdTzjYuNkarbPa/RLSDleJWbs5UvSY2SSrqI
	ckcjwb2IWNREBiOYJUQSSimkDFnkpHzcnY4wNkxfpV2w9CO3fK7pXlObKedvZlvFJy2EzNFQdKs
	/Mw==
X-Google-Smtp-Source: AGHT+IGBJMHjU3F3oNzrEVYyvsCJoiibFm59q1GvVFt61CRaclCtx2Dq6FUyz7K8DJ0ILIP0e9KCaQ==
X-Received: by 2002:a05:6e02:19cd:b0:3a0:c7f9:29e2 with SMTP id e9e14a558f8ab-3a3451b691amr37024015ab.19.1727463116011;
        Fri, 27 Sep 2024 11:51:56 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d82ae5sm7443195ab.28.2024.09.27.11.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:51:55 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 27 Sep 2024 12:51:53 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 00/12] 6.11.1-rc1 review
Message-ID: <Zvb-yRASvJclm4hT@fedora64.linuxtx.org>
References: <20240927121715.213013166@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>

On Fri, Sep 27, 2024 at 02:24:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.1 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.1-rc1.gz
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

