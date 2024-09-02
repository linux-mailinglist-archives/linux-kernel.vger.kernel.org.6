Return-Path: <linux-kernel+bounces-311578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040E5968AA8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D7B1F2314C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1E1CB51F;
	Mon,  2 Sep 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFIiZT0O"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D831CB50C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289628; cv=none; b=LSenCYPrMbWaq75Gr9yN1GewU94qCTZ0u19MRTysk5DPgpLNPLiGhxAkGxtLn1cRBSSjLHu4grZks3SGRizI3bSX1dhkNmIor25pB1NHrmi1VQelVnQV6pL0ovSz49eUVqQIydY4DBgxKLUk+ztjULWUPo+QMd1T4HomDBNmJQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289628; c=relaxed/simple;
	bh=Jg3r8F/hNV9RONd57/gAPY5wNGdOgfbGhdwobHsIR2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnKvrCU/k/wrmXALz/k5m1askc57Nk0RbiuNt9YiIPKBS7zJbxonO+IagSlvGWjc1o3XplErra2w+I8W/Yb78I6Zn74JHu1cQuGpR4euLnxYXwyJAtGhqpkF9TjWHfSF108iiTfqEPVzTCyrI77SSAyrKxo10KOwpd+qtPUL9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFIiZT0O; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71423704ef3so3239627b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725289626; x=1725894426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQqKVn4GMFpeH5zOPhKoE6Vafb6VlpfHZJVbVTatMlU=;
        b=EFIiZT0OzpBg8ikYuxIRk30kSfh/KRtwhDHoFxQ+iJRIsheLdMZXBCIfoBCnQwyJ74
         9wMfAKgV7LYDYBKtD8KGE8kvOID4V5pVXnicUyFR6TKxBEiokuVDxXNacQ41zMlHVJSU
         VGGFfju+1CIeYUNb6Dsrhs9uJGyW10GK3+tWUlUT7ptHho3LCmR8HP+xxOJBibGw+6MN
         pXWovqnewlL26yvYgxdypz/T0yx8a3jn5YNWKxq7NacdhguFzqOpMMafAAo2E0hrUKK9
         9/VtXQLj+ujsvrJ0wITVmK+pkjVAhTLCr+eOpR8i9AP9tlygkWjUVq9r0+fvu2TQ5iFc
         3BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725289626; x=1725894426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQqKVn4GMFpeH5zOPhKoE6Vafb6VlpfHZJVbVTatMlU=;
        b=u1/DVON7dno7Va8x+zcmBCg0cI5cNoGGd/Osp6spRt8jaK0cPO9+zZQ6w6vBmYo4XE
         B+rjYXCpLPnJxK2c1kvyTUZ9xiKiN+T337SSU8j7P3/PspSisDKFE1MFlGzMUzonQtdK
         aqV9FVnY1K5HGsJmG989f67cRBk6UTTQ1ZzH77xMg0TQ9YzP47D6ax1/Jz7FL+dRL+9L
         1MiFjVOM+o9aB9p6vtZJx+tzMNxcd8itsUV8y8DkIt+l+YxxTARjog3N9GimvgBQ8MVH
         1CpM8YVa0kMuHiOjEuDSeBXARETNDblA8vEbS0d8czfZndoryCz026O/3VoWOpmnGC8o
         I8BQ==
X-Gm-Message-State: AOJu0YzQL7WOVJcgQtUJ4h56uRhfDejNqHsTpEW6geqW3CYyjnwnBAL9
	t59bOIRL/NDP74A6alTVvLZ0rx2EyD9t3TF1MFTIwMGXozeJnxx5wakBFQ==
X-Google-Smtp-Source: AGHT+IFQrvk+qOl/VQOVU3zygR7PkE+ZRU7Pv1RwSnup1e8YJ43Z2m3eAAMGrDbX10LywO/N3p3xJg==
X-Received: by 2002:a05:6a21:10f:b0:1c0:e329:5c51 with SMTP id adf61e73a8af0-1cecdf0e441mr10286033637.13.1725289625522;
        Mon, 02 Sep 2024 08:07:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9daac4sm6514001a12.92.2024.09.02.08.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:07:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Sep 2024 08:07:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.11-rc6
Message-ID: <b9d58888-d94d-41c6-b0c3-19e4598c1bc8@roeck-us.net>
References: <CAHk-=wgumCUwjVkGREh1WwZ2ia5EqSjAQ_4wjUDw3-m0aT7KFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgumCUwjVkGREh1WwZ2ia5EqSjAQ_4wjUDw3-m0aT7KFA@mail.gmail.com>

On Sun, Sep 01, 2024 at 08:02:32PM +1200, Linus Torvalds wrote:
> I'm still in an unusual timezone, but next week everything should be
> back to normal.
> 
> Anyway, it's definitely well past Sunday afternoon here, and thus time
> for the weekly rc release.
> 
> Things look pretty normal, although we have perhaps unusually many
> filesystem fixes here, spread out over smb, xfs, bcachefs and netfs.
> That said, driver fixes obviously still dominate the diffstat - "more
> than perhaps usual" still doesn't make the filesystem changes _that_
> big. I suspect they stand out more mainly because the rest is fairly
> small.
> 
> Outside of drivers (all the usual suspects) and filesystems, we have
> various architecture fixes (although honestly, that's mostly arm64 dts
> files), some core networking, and some selftest updates related to
> that.
> 
> Nothing particularly odd stands out, please do keep testing,
> 

Looks good here.

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 543 pass: 543 fail: 0
Unit test results:
	pass: 383873 fail: 0

Thanks for merging my fixes branch; that was a bit unexpected.
Had I known, I would have made sure to collect all signatures.
I'll do that next time, just in case.

Guenter

