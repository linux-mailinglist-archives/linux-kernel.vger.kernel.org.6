Return-Path: <linux-kernel+bounces-278515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B93D94B133
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FB42822DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A47145A07;
	Wed,  7 Aug 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="U8ALGxp4"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A936F315
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723062239; cv=none; b=WgRQJf+Vd17st/FV3T5uQl1qEx/hFr+ISkUtz8rLM7viUaE0eZowzJ6Huf8fdWhnkHQ36/CzyiGUF9mTnzSJV5rCesLE/mOmzsYZ8FXVRziNas4JCRg1yDNO99+xSTU+rnSyAnYi6XmC5twAlZCzdbjRs+uJQM+/4lJgX++f1bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723062239; c=relaxed/simple;
	bh=+3jwXodw4pt9DovGiW81mYh8/wDwEtCWOX6/qoXKUQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X68LmwsW0uSJLDFSL78l6JFHmb0wo5ExKvHTDOLKE3AVaI/uLDJR3bLyqCe4iuhKNJb1T7TzB9vY+rQjGKg3xLQiA1q6zxS+4tpdgrY4QN0zP9kmmCfcX9ZMg8CQF7czKaxGLxjuWCrL1N8bx+NzD7Jb8zjjA2ddUnH7WXsRZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=U8ALGxp4; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-816ca307407so7767439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1723062235; x=1723667035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6tLkUPbQyEjGAfmYn4iHvooN09UUMM9a2k9Hqq5QZY=;
        b=U8ALGxp4r4axSgSXfFU6QGAnb3ZK9FuLJaTI3GtAPnLZQxUDVYNQ9N37Jw7QZYyt7A
         Uetduqx/L70eJgPlbKe9ufrrXapQa5joa/YyzXFt4vrZTy6kBLSfInizs1Xqy/XeSB8o
         YoQpT7lqCzwSKDPwU56YPJjvbe+RIwuhK0Xi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723062235; x=1723667035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6tLkUPbQyEjGAfmYn4iHvooN09UUMM9a2k9Hqq5QZY=;
        b=a3Vw//cag9/2kfLBXgpStvPwcf50dmFyU1kyACVBKKjqO/Wes+5povqt4JogscUTvk
         ZvoaSzIwIUVTaW9y4aZwvXjFFq508MVzex6CslClp9KbFQeOyGvU6FovGa0GnzE++N3N
         CJdxWEs6ZvWNQyPlZ0PdNmn5IFFX1fDHLlIjm/KuIHwnHdSfGMjVhxFzrIcN10MkW3bV
         RekupcWVPIPmcA/J2OJy/Yf1YCrNR5NrAgt5g2B3KhYdZtJ6Zt+MfLs6AxWCi7iii72q
         w/WXJl6bl1nUcM5d3VazOhv6sRAxzPOB8koHtRehSnDHds78Mp8y2E/Ak4EQC+InkqK3
         QjTA==
X-Forwarded-Encrypted: i=1; AJvYcCX//1OXDKWpNWXjoGlMQZwbJgRotD9T3uoj31zM6+inZhooLyc84lW3Yl6S31jOCyCx/ksrgp0oF0Vk/B0MOeDUmH1nihs8oQX+OkCD
X-Gm-Message-State: AOJu0Yw4YL9f71QXuP7x28gXJuUYUoD2TOn8hDz3FZveRf3Khr9dTCZk
	YWTICKYa+ieYUqQrKrm4WjKmDT7J/eQoHv840RXO98p3b3zGmQh7Mv1ZXlCHAw==
X-Google-Smtp-Source: AGHT+IFM2XyOCn+eCI6JYyc7AasqD31v6ZmwIhteJB0obCYGFILhHY8WH67Vfy84rpEbTTm5+nxxHQ==
X-Received: by 2002:a05:6602:29c8:b0:81f:9b2d:e824 with SMTP id ca18e2360f4ac-81fd4361c61mr2727276539f.5.1723062235394;
        Wed, 07 Aug 2024 13:23:55 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.171])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d70115sm336133839f.34.2024.08.07.13.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 13:23:55 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 7 Aug 2024 14:23:49 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 000/123] 6.10.4-rc1 review
Message-ID: <ZrPX1QQO4X3Bjkes@fedora64.linuxtx.org>
References: <20240807150020.790615758@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>

On Wed, Aug 07, 2024 at 04:58:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.4 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 14:59:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

