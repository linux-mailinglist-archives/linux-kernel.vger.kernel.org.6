Return-Path: <linux-kernel+bounces-551373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF88A56B9E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BF31891DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50E0221554;
	Fri,  7 Mar 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="dCSrvI9+"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CB21C173
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360524; cv=none; b=gDVYxMcXqBJqWkHa0pW2ChPXG5hMTfUVfkf1kWSd1dShZl7f/m45UsgDHvw66UA916HWwMkHwbzLR2UXi9jMxPBx+R4eAcKbYHVLnK3LX0b2G1lwZj7hXHp//u3PFtmvydw5y2lyeKrxWXkRORSHd6NByln+ce/WCaU8bizbep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360524; c=relaxed/simple;
	bh=Jyg0BlNEVONMN3/qpK5whDdVuZ36nVAtfOMd2YynnAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipIzyGA2BUEnpOIWStkOCph+2vXKLJO7e9RQuuU06gMJlDPPfQa7ugz+3N/81zSh1OpeOPD8GtOCGtAzA10JJjMxKwk3DJ9k67QnGIC6TEBnYHZAE+cduNT3KWLJZJIgE7VBP6pRSQwWHjpf5hQrHwDJA+hRO1dAfAmn3nXKPGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=dCSrvI9+; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d2b6ed8128so9960115ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1741360520; x=1741965320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNhnQrGFa2eZSGaA05d8tH8yb8bigPtWKz7iWwlz8ks=;
        b=dCSrvI9+JxYTPle6B1IbN6y1LQdb5a5c7gdl+F0xu0+1sY4oQNPl64+q3aMY+uiAAm
         JrKEzfevb68ZM+G7Ai1McBP3r7JzgEqGzoNa8PlkUk1hDuW8ebLwjwquRCjr4881V04+
         aRmzR6k7/91M2cKz+rOMxuBn9yCdI5AmzwmoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360520; x=1741965320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNhnQrGFa2eZSGaA05d8tH8yb8bigPtWKz7iWwlz8ks=;
        b=bJUwb3day7gsIVirsT7ZXQsxNuG/g12c+4bS4I7W7CQCoZyRPINN9KmkemxYwn0gHg
         /w0PgFKacGYCWQg6v4G0nb88uXqLn5dG/X6JDV/sjzH+mBtfXtXI8Q6jqK2mvfh6ZFVv
         7RNNBUZ0v/kqMIUjnut1AXxLeC8t/F3ZJ98MUjcshs5EHYh9rD26Rt+u2ELGqR/uasa/
         xD5GF37oCAmiMX2Lsx6cB/mk6YpPP3609QixSE7iq9wpdJqu9A8bc8O4NKeZcHMRQvFz
         72cvmRq9jwwpZlx4Wc/GxgNxvNrlcCCVeooSNUuPgtWg2eHoB3Rhu7oPEn9fJzUDpfrM
         avqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKI/LI3+w9I88lQQ19hF4WmHBO4qgjga9yeOPc6xCGHVjQ7vYWSsB5fQd1W8x9aeXnHU14auqZmN55UT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt0QjsFZxCChXv12aXB5rmiFuvIgavgU+ogQvLFZaYhXYaj3hB
	8CVLxAA7liurNfHhgw+k43++JBTNHUD1Z45Q49XABlaRX2Rg3+xthIS4cTKcOA==
X-Gm-Gg: ASbGncvvZ3vl4a1oNdrJcn3TYCNMciLW75ZnT9htV5q2RD7D54/SzG4JVTUylRJxKDN
	bK0HVGaib3FyL6koEgXGh65k3b2KRmc45g4t2EG7PeqQp800KAOalPpkLgHZp6gZroz56wbkThf
	x+AfMnFg1YnJ+EzQsxAd8JD/KZYP4XOxc+pFNoqUEM4j/b+xILED4yFcMzfY+7c+UWul6BR27/Z
	J+zP+Sp1MuhhUnwbkt6uq8rm1hiJHpweg9gAeGG/I4vTKffLZWwP9oUjqrkLgFXFlZHZP8sdCQ/
	0SH7ba0zUEh0dYq008H7eAxGqc9ewNoZbcbbKyqH2YUsjupbfPR5r2Z6ozVeOQ==
X-Google-Smtp-Source: AGHT+IGJMJxSyE4UNVIY3LX2S7nhf3Y5lt2eLGH38VXXHHpoq/52h36JCsBDp/RY5WFAtMDkWXBzow==
X-Received: by 2002:a05:6e02:1a84:b0:3d3:f72c:8fd8 with SMTP id e9e14a558f8ab-3d4419b2bb9mr42285385ab.6.1741360519989;
        Fri, 07 Mar 2025 07:15:19 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b599080sm8399705ab.60.2025.03.07.07.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:15:19 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 7 Mar 2025 08:15:17 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/154] 6.13.6-rc2 review
Message-ID: <Z8sNhU27IirlaPn3@fedora64.linuxtx.org>
References: <20250306151416.469067667@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306151416.469067667@linuxfoundation.org>

On Thu, Mar 06, 2025 at 04:21:02PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.6-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

