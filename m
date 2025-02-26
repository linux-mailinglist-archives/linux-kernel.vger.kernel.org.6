Return-Path: <linux-kernel+bounces-533021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B983A454E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A083216CDCA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560EA4430;
	Wed, 26 Feb 2025 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoKf9oVM"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A32940B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547826; cv=none; b=BWID2Wz4Ol7/WQbCcsgBEpxGehUFrgyE1/rfcyZl7Ow96dShJkF3oid4rbf2QYE+bd9im30a1fAAlNJDHIH6pOhfCsfdJlXhnOEZbfM0UO8x5r+BYCRcKtB1cqMS2UaPXkVozDthaxTCFMJ1P+5mnzkfURfcJvBZUPilxY18lPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547826; c=relaxed/simple;
	bh=PDCwV3qdEOjxXIjtKkWf5Vz2HcCqhICawWEfa4yI5K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+9TQLCt8a2M5kCzKMrq/wXb72NXLqXE3jn3Emn7eBHP2xbGbLVIhlwdoHojWuCbOQxh85I9EV90JL6cgpGtsmjaruh32sLp2z3vwFdcUN2+UyyIgiM10KJ/dROL7ZT/2EUrHlcfFj9ydU4pTs/OsmFhvO8WwkZsLsvYd8lU1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hoKf9oVM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220e6028214so139634505ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740547824; x=1741152624; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ysxu4HBM1PvBAX3G7aQAJNrxG8wBMOF98K3kSzCpKb4=;
        b=hoKf9oVMGq/+2ovy8FOqD2fmzLHSTD8lGrmrZtUKQC7itxUJJAsI+fR+xw1l+RYBmD
         Ljf6IgoB6vTyHnWa4Wsp4cEff0bvxOr5Zl5bIPXewCJuMn4jkgnHrBe5bJYJxNn95T0g
         9Aj1ddGjbZ2QZdMcAqEiy3jOeXNlop7sABATIrmL43bVSHBvuqEwN4P95MtxaB6XdNHu
         ZHn8xbComngq+Pocw2X1PxoBLcb1ViyAzCwjN2zlHoO4a1Gc8KjZc9WDw0rIlRsOLCl9
         gcGSNCvvs4W20XyQjioyWvCflTIgoYEjvRfju2I9En4zpMKAt3Bq+O+lc/CNHdPLLYia
         i57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740547824; x=1741152624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ysxu4HBM1PvBAX3G7aQAJNrxG8wBMOF98K3kSzCpKb4=;
        b=CSzBhWYpdk3PVEn88Hg/rr5/nl2vlGAlIhJR8OPBdFrRGLcpKIzuoU4VwxFLhf7NIp
         6zwR9Xkdyx3Xoz5Q2DnTiS4KXCsa57keG+HEwt3SK1hnNQNUz8VPkouNvySDT+pVwfXj
         VMe2L3KtDmRCDvlatixW/Rs/8gb0IvLN9mj3fLjuWb4kywaxwGIYWxD9w8Xkd0qbQ1Pl
         2yY4CLKK+qMenkbkWAHXU0Loh4TmdP0lTuWbUKMlUJccXXarWEzOzmlD6aVgD5BtYx7t
         8WKO4UgLJOpM4A524tAz03e8GSY+CXtEnFNH8D1Jo3UvHU7vN+N2/qYA5JssIV+yxP3X
         B9cA==
X-Forwarded-Encrypted: i=1; AJvYcCW9Em18xY2hWmZcf08LwzGjqJOtm4Kiekq43elKHuoYatKPjSDErTi2LYW6Eq7UnA7DFrmsUWZv1n2tQmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10v5UnagmAZRcV/RA2BXX0nv4WGT43YIWdu+vdYUL3pQ5Ag65
	UfrxtrjjV4UCdUx6yTB4TOa4nFBCB/sz/leZxVWsDkzRbwqCyGvhkwc+dTCSOg==
X-Gm-Gg: ASbGncuDUUKfOVN0NlP/Heqh+SWlOXH1z+mQZjo316zmficFkZaVPITQWp6aKaEs3iL
	MBwhLwIXt03etFFjiinkMxqo+I46G52NWKPVwnjf7N0U7v8nwMfO7Opx3fEYaK8p3U17igr0Ov6
	ZIpj83tUv0KBmCnDCU5m67EXVGhczk7wp+FRxR3EI6wpljaC7qljPr6KFzHuIpDMr7VT41cx0Xx
	AAYp32QsbzGGTEBZ23lssiJRjLCMKeNvhfEXa2nnu/ZdsITNxFCtMgzGu6KFliGdcw90bCRKw9s
	+yMNEHW69zLa4UipqLTtv0YHKCrwGIxXM3dx
X-Google-Smtp-Source: AGHT+IG1ATYcBA3Lx5kX9fxW7lirbjTeUCqtNQ1K3OphxIX9hK11KaA9lvhbUyRdKaGgUECgCpTu2A==
X-Received: by 2002:a17:903:1c4:b0:215:5ea2:6544 with SMTP id d9443c01a7336-2219ff827b7mr300683495ad.7.1740547824537;
        Tue, 25 Feb 2025 21:30:24 -0800 (PST)
Received: from thinkpad ([120.60.72.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a6252sm23604675ad.186.2025.02.25.21.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 21:30:23 -0800 (PST)
Date: Wed, 26 Feb 2025 11:00:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Manivannan Sadhasivam <manisadhasivam.linux@gmail.com>,
	Manish Pandey <quic_mapa@quicinc.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com
Subject: Re: [PATCH 0/3] scsi: ufs-qcom: Enable Dumping of Hibern8, MCQ, and
 Testbus Registers
Message-ID: <20250226053019.y6tdukcqpijkug4m@thinkpad>
References: <20241025055054.23170-1-quic_mapa@quicinc.com>
 <20241112075000.vausf7ulr2t5svmg@thinkpad>
 <cb3b0c9c-4589-4b58-90a1-998743803c5a@acm.org>
 <20241209040355.kc4ab6nfp6syw37q@thinkpad>
 <3a850d86-5974-4b2d-95be-e79dad33636f@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a850d86-5974-4b2d-95be-e79dad33636f@acm.org>

On Mon, Dec 09, 2024 at 10:35:39AM -0800, Bart Van Assche wrote:
> On 12/8/24 12:03 PM, Manivannan Sadhasivam wrote:
> > On Tue, Nov 12, 2024 at 10:10:02AM -0800, Bart Van Assche wrote:
> > > On 11/11/24 11:50 PM, Manivannan Sadhasivam wrote:
> > > > On Fri, Oct 25, 2024 at 11:20:51AM +0530, Manish Pandey wrote:
> > > > > Submitting a series of patches aimed at enhancing the debugging and monitoring capabilities
> > > > > of the UFS-QCOM driver. These patches introduce new functionalities that will significantly
> > > > > aid in diagnosing and resolving issues related to hardware and software operations.
> > > > > 
> > > > 
> > > > TBH, the current state of dumping UFSHC registers itself is just annoying as it
> > > > pollutes the kernel ring buffer. I don't think any peripheral driver in the
> > > > kernel does this. Please dump only relevant registers, not everything that you
> > > > feel like dumping.
> > > 
> > > I wouldn't mind if the code for dumping  UFSHC registers would be removed.
> > 
> > Instead of removing, I'm planning to move the dump to dev_coredump framework.
> > But should we move all the error prints also? Like all ufshcd_print_*()
> > functions?
> 
> Hmm ... we may be better off to check which of these functions can be
> removed rather than moving all of them to another framework.
> 

devcoredump turned out to be not a good fit for storage drivers. And I can't
figure out another way. And Qcom is telling me that these debug prints are
necessary for them to debug the issues going forward.

Your thoughts?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

