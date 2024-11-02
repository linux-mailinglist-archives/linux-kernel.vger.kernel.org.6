Return-Path: <linux-kernel+bounces-393081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7A9B9BA5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6C41C211EB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C491171C;
	Sat,  2 Nov 2024 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqpU1Mq1"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CFC191;
	Sat,  2 Nov 2024 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508664; cv=none; b=UtfwJscEEK3gjoUggGFBuGyDo9terAz1Arx0d5GSXfTpmske+I/+CbMjY8Xs+3lWFdSIbmGomvuPn18LSwAPdpubgtwOjMJEUyUc+xFJYulrDIYgI7K8pyw9A6D6Wt2p0zt/cIrqkAJEOH5lhEJYpcHfcdw35iqunoUeQb+Zryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508664; c=relaxed/simple;
	bh=XpFydpuIBmwZE635p7YZzmUWJPO3ARERCA/AayY+nzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmeZRbFRHqYHr+u2E4MT9AIjBEnW/X/KyoeJeMVMlnlFf88EZMU585O6GhbZkAU8+EPo9N13+y3+G1Y03KypiBndApGuKpwIiRaOvQTrrLsg6k4oMmiy1l1SGXusvL94OcGm0YF8FOFMw/dEMGLhSlx0DlBvYEJCpzQgLFyyWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqpU1Mq1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cbca51687so23812505ad.1;
        Fri, 01 Nov 2024 17:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730508662; x=1731113462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=02siiafPBB+WwrD70k7f5oYXgfNSeX3MzSwQ/u7qGxI=;
        b=jqpU1Mq1hdaAyXC0MCYHC+SCh+IxARRWto5fP0/B0vCd8rbXfwx10zUqZZTfcOwvln
         MqaF9KHC5ae9f6DcQJVfbMWSLu0JkJIBrVu78Jj1Sgwxn3Rwv452LJ/VHnc2ooIFMCp5
         +rbxvpGCLZlOD0vHQMUHjn6jyenBf09gt70Nyg5COeyuU6YimU9+GdCWMDnT712Pwari
         qLWBlgtKeRAjHgrsYnD2vFIWR0wuGX/jOkITR2ZyrMgAAJWz4UZVStUyPKI5bO7d7G30
         w0DwmEZLiJGYf45Xj46WvIRLpTeQ67aQ8IfI9L49/BZc7ZSrzVROEdCNv1YS9jMZcteX
         OvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730508662; x=1731113462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02siiafPBB+WwrD70k7f5oYXgfNSeX3MzSwQ/u7qGxI=;
        b=GPjZuSJ/pdzFZLTtpe7XexSPfg0PiowQqPpcJvnJLhGyEd48f2s8MXTPmKV14DcgxF
         hQIKj57fop6rd/LHIPAPLC04tya2Dimj1ar8XUOG2554pKD6lw5xTpSRbwML8cdViGvN
         wz2ysL7VfkvyWqrQMrpGKfrVPt0GNV39725mVfBXd0MJRaeZyp3MnRjAj+SVIA61sTXw
         vsPQRXLtH9tKQ4dX25kwT23Z1xRxZC2Rum8Bfhcsi2yktrGFgSiz0NgnWiZGLZNv7/2z
         BAOymzH4puEHLMWMoQOMnsq+Y51G5JwIyd2ahABKIVzOV03keIk9fOb4tm0UFqzMAcbk
         79AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkYcS7LJ6T5bZqKm8ZyIHot9ODC8qZXIYbFSULLPN1zHyGFRNo5tLsOq9m7EAruFsmEFayksEncaqmZrEA@vger.kernel.org, AJvYcCXbr/qF4M83UA6XAk1+2f2s3qqaE8BRh/6MFO3XKD5YisMQMTKtTIm1UACLdgvN53b9LHM7S65u84aN@vger.kernel.org
X-Gm-Message-State: AOJu0YxPojZSTGZFOO684du9gb1sdu1pJTW8wlL4LAH8G/qN9IUL/QVw
	hLC7d8ytPd2GW2r8LG5rDc3jqVGRjLys6EczALC0wYtpfrAJMl/7
X-Google-Smtp-Source: AGHT+IFHGKcbBzTBN6w+LmMFrDb+s/iIBlF+oSnT13qe0i7i+AMUtykuFT0A6r8jbSq24XPs62aIow==
X-Received: by 2002:a17:902:da8f:b0:20b:58f2:e1a0 with SMTP id d9443c01a7336-2111aee4402mr74234475ad.18.1730508662020;
        Fri, 01 Nov 2024 17:51:02 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d44b8sm26490065ad.263.2024.11.01.17.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:51:01 -0700 (PDT)
Date: Sat, 2 Nov 2024 08:50:33 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Inochi Amaoto <inochiama@outlook.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: fix pinctrl base-address
Message-ID: <zfnisncpvhjtnsfdciwnqdzlh6bhcdslxx5tp76smmyskgtdpi@wcwdrllaeifo>
References: <20241028-fix-address-v1-1-dcbe21e59ccf@bootlin.com>
 <ihmors43w3ttfun7c4fj75ahh2hnhafdxhlmocbxfwttigj3fq@wxud2d2srisn>
 <MA0P287MB28221D96A094D7C3373C1865FE562@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB28221D96A094D7C3373C1865FE562@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>

On Sat, Nov 02, 2024 at 06:28:50AM +0800, Chen Wang wrote:
> Hi, Inochi,
> 
> Will you pick this on sophgo/for-next?
> 
> Regards,
> 
> Chen
> 
> On 2024/10/30 11:50, Inochi Amaoto wrote:
> > On Mon, Oct 28, 2024 at 11:43:24AM +0100, Thomas Bonnefille wrote:
> > > Fix the base-address of the pinctrl controller to match its register
> > > address.
> > > 
> > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > Fixes: 93b61555f509 ("riscv: dts: sophgo: Add initial SG2002 SoC device tree")
> > 

Yeah, I have quened this patch and will merge it once I have
space time, so please wait.

Regards,
Inochi

