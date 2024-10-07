Return-Path: <linux-kernel+bounces-353907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C2993449
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEEB284645
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB6C1DC18B;
	Mon,  7 Oct 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5XWn5h4"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885331DB35C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320410; cv=none; b=l1sbz6fLOAnpWGGpQtRAnZSP3f8+u0NWhWmjDA3a95jSMXY6aOtFmcbmpIMVvkeoLQMmBt4cLqtCAbF8iNDovYzftejquKjkaFnhTrSzmtZppqPhr0ri998SNexVHcU29sqUcF68WINdj1c9vj7fH5L+VVVp06PuZh9wV3DWoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320410; c=relaxed/simple;
	bh=NQELeFUUN3T6RVoHPHqRj2Vh9zR8dkL12jBg95Vj4Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFDtUXxiftLySbpVtkJV0OuPjwqb4uOB5SrP476xU8hDlApUj/bGLQY4HwlkyCmJHoBOiKnbaHEmGvwOKEjzmMew8HH8qAoTpxD76CYUafsOmkJMCB8c8DEbXgPTFgCIjs2Nyapc1vl35A1QR7qaog6ATQqLY9akn1bhUKBEqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5XWn5h4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ba8d92af9so35029345ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728320408; x=1728925208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2i+POyxYuxG5qmXqlZX6h15DS2BKxCH3uihrzEqaNV0=;
        b=A5XWn5h4oBwPughkbJJiwD72GkfCF+XdzdM8fJ3McjhO8QLH3ea5QgGr2pa9I+mga8
         oln/2SkSART11CKZy9dDc8g3xqwAFgfigulX+gTILuAn1F6PDs9sM21ie8QK5M1wWvgl
         xEYnx4WphQTgLBy9KmgnkThiT/1WgWFDOLp3OsH3coC/RB0AyP2MNY6hZQMJizsf9BEZ
         jD6KYyExKy8/oEzbkKinAfgIGN8L5D0rkyHE3yJvy0DQkdYZbxOM2CDFd3HS5/83Y60I
         NIIhpzqd72udhXIjhzwK3d3g4lkyxUnh9UFpUgwSMqHS72ez1QZS7SX+OBh4lfXL3+67
         DbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728320408; x=1728925208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i+POyxYuxG5qmXqlZX6h15DS2BKxCH3uihrzEqaNV0=;
        b=Jc4CeikzWBGfvm8Ic28fCnmlONBKHoSiFyTfDHlj2RLp3qQ/AUuCSDdfLS/XcnSA8S
         f3GpiaLYT7CPer01vF3pZbHU4o/SJFYbQe4C1xVWCoECthBlNeOa5Iwwj6KqnCjtgHk9
         xvll6mMJh/Ac5NrB1udvUadnwqGQW2Lqk3lDQZB5qcl15cU+vLrL2a6hLzueqjjNt/fa
         DV9FZUG5kVmpFGQ9cUpPMxVpDV+bzkifzGR8rTQ0Mh1GQNu9DbXaSqAzxUIW3bSFr6RZ
         Y82BHtEHlic+R6aS1IuDiGShMjISjNtXApjQ77/+IIFfPP9Py+kp67Vz/7mIXcQVB12b
         XtXQ==
X-Gm-Message-State: AOJu0Ywkr/GTboGdFbmzY30HI3XaCnRZRScQzKDkIiWxuu1iRbqUPMWy
	5CMd+/xXac97XHPPG8yC2bONNvFR0AYQOw1/r42Ufa8ea/0PWEb0
X-Google-Smtp-Source: AGHT+IHr+SiwN7A2matuGNEmQxxnuCCLslYc4dzftPWtm5MzgfRRWzGHA9exVsWQiR6GLXnNEDPAxA==
X-Received: by 2002:a17:903:11c7:b0:20b:aebb:e17c with SMTP id d9443c01a7336-20bfe04af0cmr184127425ad.36.1728320407063;
        Mon, 07 Oct 2024 10:00:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b12adbcsm5694584a91.53.2024.10.07.10.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:00:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 7 Oct 2024 10:00:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	Wei Fang <wei.fang@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Linux 6.12-rc2
Message-ID: <3016e3d6-f916-4a6e-82a5-2bfcd1f2dc2d@roeck-us.net>
References: <CAHk-=wgMS-TBfirwuxf+oFA3cTMWVLik=w+mA5KdT9dAvcvhTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMS-TBfirwuxf+oFA3cTMWVLik=w+mA5KdT9dAvcvhTA@mail.gmail.com>

On Sun, Oct 06, 2024 at 04:28:36PM -0700, Linus Torvalds wrote:
> Hmm. I have had this mental picture that usually rc2 tends to be one
> of the smaller rc's because people take a breather after the merge
> window, and/or because it takes a while before people start finding
> issues.
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 555 pass: 550 fail: 5
Failed tests:
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:mem128:net=default:imx25-pdk:initrd
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:sd:mem128:net=default:imx25-pdk:ext2
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb0:mem128:net=default:imx25-pdk:ext2
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb1:mem128:net=default:imx25-pdk:ext2
	m68k:mcf5208evb:m5208:m5208evb_defconfig:initrd
Unit test results:
	pass: 459052 fail: 1
Failed unit tests:
	arm:npcm750-evb:vcap_api_iterator_init_test
	arm:npcm750-evb:VCAP_API_Encoding_Testsuite

The failed qemu tests are crashes, bisected to commit d9335d0232d2 ("net: fec: Reload PTP
registers after link-state change"). I copied the author and reviewers for feedback.

I did not have time to analyze the failed unit tests.

Warning backtraces seen earlier are still present. I did not have time to analyze thoss
further.

Anyone interested, please feel free to check details at kerneltests.org/builders,
in the "master" column of qemu tests.

Thanks,
Guenter

