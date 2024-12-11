Return-Path: <linux-kernel+bounces-441487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766809ECF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1F168152
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F38119F42F;
	Wed, 11 Dec 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8Xwhc6X"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB218A6D3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928808; cv=none; b=LsUAbOCTSTcIONJqkfMk150n0EeZWPJ3ekn07pscTGtgGgTK0Lc5NqP3xHoy8N+Z/LlJC9tNqYuflrcjfOoLIZ1NqQdpuiGq5DFkA3JleWNk0hZnkQkxrBJSCQ3dDLZcHn0AdRgBwfRy+9OlsT7XjvT1DsUSemPtjvVChEX5++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928808; c=relaxed/simple;
	bh=71rnSn7wFVoD21U48pjt1zEn20evixs1VxJ1eb4i9XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjdNdjmuVyYqFgadTF4cHln3y5a1N78Z3Advt8x7rzpPXZ5fU6IMd8eYozPYNJrVI5ITHkOcwbIZWmyjt4wxWTazwrMpJkCdtfFlbxKW5ZbNJUvhLdkXU/ZBD7FefbMJkMUk0HmYhqwUOSL8iC/ipsbeAUnsSWeQsZBP2kt+2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z8Xwhc6X; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728f337a921so623025b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733928806; x=1734533606; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ymW0qBk2uaFHFENJ06sbcJsCW5UbRGhhuFjHIPKzUxM=;
        b=Z8Xwhc6X+ORWsd1PyKMplb0d92snfxj6PPptVVhfmea0zGvD2n6gxMDxkWowoIXeJ6
         qlPLSLimbO3AT34yyqNAyyTyuOrai2tLhGHZIn9sbh6/9LOFCdTstLqQgkxm9A62t842
         XJDqlKq+Z/A6J1IKmK7KbmulBVVj7lmo/sadGJcOH5hRNkeowsjkn56Nj5aSgYgLwIUh
         y/gCNj+TRnZpPIb0HT1+QIy2r937bdQLR/s91YdC8oTo/xdPfVwtrUjIJ9IW2ZJx8uw2
         4Ej8B6T0h0uap5OeMSpvibuWCT7aZImfscHRJujE9RDdJg5FDGGfLdljzuYS2FHzR5f0
         qT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733928806; x=1734533606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymW0qBk2uaFHFENJ06sbcJsCW5UbRGhhuFjHIPKzUxM=;
        b=RdMLCt/cZ1N9rHmlJ0tPg7gWEKy0U9MPGSLid9nYJqbNPi6ynwxayDK6veQW4zyM6H
         FlJ1QNj2xwGBfcdHsPYnyeknV6YTve2M2eihRKxm0RVptfVYbCIFhAxL/qPoEl6J7C/a
         fW36oBN4GV9tOxvCaI62OgtX1iHQhOsRgtvq11m4Q5agYsR6Yulw31QyRadrSarNaG8h
         Ypu6sCr0yIYKvKZUKFKXxxo6V6bXoGe5aRayRt+cXRqMQDIGF0R3HqGtIKJxtkgfEaxf
         huQaLTlzqApUljghH84z54bCqdfJXcWWoZhVULNt97WahwdQAqkSw2PM0Gs81MDN5Oi0
         9HBg==
X-Forwarded-Encrypted: i=1; AJvYcCWtgBU9JC7wUWrcAFD1haQDgOpBnaejNWy4DzWB+WgXU7NYh+QKA2JuESYUZVkeQlNBPIKpP+d4DFrUi6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzURU9VpZjD4xMnecB/0ndIKwTOBTLPHUrE//cI1xuANxuSbALp
	2J72rSl+1XMFIguQ4oFbXsAgnTaJ+qT+2SocBiK6PBBzNiNycqBahg3+bQqlzA==
X-Gm-Gg: ASbGnctew1Nz9fTUsnpMvW3GNwkdE2HfLfXwwLltCnmIj8S82tnO64VPujgySwp09Te
	i4STiFIP5vZIwu+pYO92K6L9j5XLz99I6G/CAggHiO7Dc5L95O6hmOWBypzUvwlj6tVBC/E2bSi
	FbejIE7PA1bd0mvq2wSkVuY+ZxGfylIOikrnMzV3CN6EIjtsNCospG2IxRny5rpD7RNeRgzgpkX
	teYdxCgYOyXui2cNoJzMZHafnyjntcEoGwCn0Ir3NWcRcgE+wbGhRPyZmstlwY=
X-Google-Smtp-Source: AGHT+IFq2maYgX0r5WCfZcfI+e7jk/jBe+sBMf30hjHmbIonDMVLKoFqFD2DGiVukLa2oSKZQbvJiw==
X-Received: by 2002:a05:6a00:c8a:b0:727:3b77:4174 with SMTP id d2e1a72fcca58-728ed4b9fa7mr5561458b3a.23.1733928806217;
        Wed, 11 Dec 2024 06:53:26 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f03a0ca4sm5205402b3a.113.2024.12.11.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 06:53:25 -0800 (PST)
Date: Wed, 11 Dec 2024 20:23:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: mhi resume failure on reboot with 6.13-rc2
Message-ID: <20241211145315.vaf7gbapieywcvau@thinkpad>
References: <Z1me8iaK7cwgjL92@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1me8iaK7cwgjL92@hovoldconsulting.com>

Hi,

On Wed, Dec 11, 2024 at 03:17:22PM +0100, Johan Hovold wrote:
> Hi Mani,
> 
> I just hit the following modem related error on reboot of the x1e80100
> CRD for the second time with 6.13-rc2:
> 
> 	[  138.348724] shutdown[1]: Rebooting.
>         [  138.545683] arm-smmu 3da0000.iommu: disabling translation
>         [  138.582505] mhi mhi0: Resuming from non M3 state (SYS ERROR)
>         [  138.588516] mhi-pci-generic 0005:01:00.0: failed to resume device: -22
>         [  138.595375] mhi-pci-generic 0005:01:00.0: device recovery started
>         [  138.603841] wwan wwan0: port wwan0qcdm0 disconnected
>         [  138.609508] wwan wwan0: port wwan0mbim0 disconnected
>         [  138.615137] wwan wwan0: port wwan0qmi0 disconnected
>         [  138.702604] mhi mhi0: Requested to power ON
>         [  139.027494] mhi mhi0: Power on setup success
>         [  139.027640] mhi mhi0: Wait for device to enter SBL or Mission mode
> 
> and then the machine hangs.
> 
> Do you know if there are any changes since 6.12 that could cause this?
> 

Only 3 changes went in for 6.13-rc1 and they shouldn't cause any issues. One
caused the regression with pcim_iomap_region(), but you submitted a fix for
that and other two were trivial.

From the log, 'mhi mhi0: Resuming from non M3 state (SYS ERROR)' indicates that
the firmware got crashed while resuming. So maybe you should check with ath12k
folks.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

