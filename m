Return-Path: <linux-kernel+bounces-287489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0374A952855
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A4CB23F15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9738FA1;
	Thu, 15 Aug 2024 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CP+i6tKx"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22921D52B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692995; cv=none; b=FTH2f+hsSbSKHTgwQcxbJ78Nf8+RdQEpc/YEAIOQZ0d+x76yktIMbS5N4xaGPa9VuTzdx46mL9vZyZJa0zi/19W70shYiN+WMOEXm/PTMulish6Pb3ofqxA6ma9V+T1YvsFBxIbcr38lfGMarhGSuzCdJ7H3EEP1/5M1HYISPXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692995; c=relaxed/simple;
	bh=VmeDJe5IiChyVSiwtUDllH7JOe3LYaNcF1sph/vs5MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzIdCzUyZntcolmPCBewfXIjnqri/nOJZRT4TDDrNcO6ono8AnUIFMRu7fn0qrVJQgleL12x/XMMWmSR2RfgbWUeGJg0KbyCcVeSP3uzepZdhPjeaNCYZ5+NL1S0kJ5sBEgS6Cdq5VXJr/uBwyQxVyH63xolMKd3eMeOPE6FTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CP+i6tKx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc65329979so5206585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723692993; x=1724297793; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uz/2NgVRt2KKEiEq3hw8wd1EQ71jZ2iS/El9DiUWZbk=;
        b=CP+i6tKxwkcdQl6OlqNVcLTL9uvFqY5Kaiy6OUVANBInsm+0pnSFouGoXTMkadYLuI
         qdaLTFLyw9gwnpHxqWTN4jT7ixNFHlPOx3ihdG1yL0o5Kc8VoaFm8uJ3x+Sy/x7TYM85
         ke/vaj4rhdZ7kmeR7zmo3B13u8CfsC3pnB6Ag/Ts21Na9klLVZmxNTbWPaf5QzTnWGPY
         xMSYpf/DtDqYx/2JzkerSfAALTjhkfbsQYyzRIwWk8vJaJGrPNNHAyQlmBfLoAoCS0to
         eiJ3a+LgowGT5Ug+05zswJq9OygsbSRODWCYnrFH5IZ6ZhNamMOIj2aJ9aqrd48PUzmd
         7kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723692993; x=1724297793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uz/2NgVRt2KKEiEq3hw8wd1EQ71jZ2iS/El9DiUWZbk=;
        b=B3PvaIo67ykFf6e7h07jPpye3BDVWNt6mK7X3kTy60W8XN+X5z12ls+m9LHJ4gEIzF
         en4Ukd+NJqrPeds8tf7Xr7de9BoNMgg20RsXS4zvERzH2UsX/5eWldYHZgpdWxJc4DZQ
         5WfxzmQtalSqw3Nga9484szQnfc/HFaKe+3uIcpWxdngZXi1+pBeles5KjewXASIWff9
         Yx9lDKKBBg3si1Wszw9n41qv+vCk7s6WQsQp6LRJ+ClHqiVzlBrvJxtZ5nVWVGhlK6AE
         6uYo7CUFBdJcss4TVFXV9Wi8haZxDtx1mRnJFbUqF5i84lg+LRq5PWmGGaKXvW66YDuz
         nJTg==
X-Forwarded-Encrypted: i=1; AJvYcCX0uFZw7MUJvQAnqTs4mJXnbgQDUmVQTu+ItXi+4eq/fDFdh//WhLaR2BiRYSt0luftU6uJOQw0f6Qqv065QLflwDbt+iMcsOPUZPl4
X-Gm-Message-State: AOJu0YxFlsk1+YIYCvP/OjV7Hr47rO7rGLGYEujEsfMOJNabmu3Yxwm7
	ZPpsSUetk+ZzxPKMLSXUwZ4dG3ao1HHzr0ulPsvE2irIBjkJFs7mspNolnwHDw==
X-Google-Smtp-Source: AGHT+IEMvWY/Z1OVulH8TSILC9neilL+JWYFVF+pUMJtaZh3B6tR9sxb+rJu6EZq+pGEBrQM/vvA5g==
X-Received: by 2002:a17:902:d2c9:b0:1fb:94e2:5643 with SMTP id d9443c01a7336-201d63b3fe6mr50032115ad.12.1723692993188;
        Wed, 14 Aug 2024 20:36:33 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0319755sm3371305ad.65.2024.08.14.20.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 20:36:32 -0700 (PDT)
Date: Thu, 15 Aug 2024 09:06:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Kyoungrul Kim <k831.kim@samsung.com>
Subject: Re: [PATCH 1/3] ufs: core: Rename LSDB to SDBS to reflect the UFSHCI
 4.0 spec
Message-ID: <20240815033627.GA2562@thinkpad>
References: <20240814-ufs-bug-fix-v1-0-5eb49d5f7571@linaro.org>
 <20240814-ufs-bug-fix-v1-1-5eb49d5f7571@linaro.org>
 <3e7cf9f9-abab-4249-9e7b-71f237850bdf@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e7cf9f9-abab-4249-9e7b-71f237850bdf@acm.org>

On Wed, Aug 14, 2024 at 10:27:48AM -0700, Bart Van Assche wrote:
> On 8/14/24 10:15 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > UFSHCI 4.0 spec names the 'Legacy Queue & Single Doorbell Support' field in
> > Controller Capabilities register as 'SDBS'. So let's use the same
> > terminology in the driver to align with the spec.
> 
> If a rename happens, we should use the name from the spec. I found the
> following in the UFSHCI 4.0 specification: "Legacy Single DoorBell Support
> (LSDBS)". So please either rename SDBS into LSDBS or drop this
> patch.
> 

Hmm. I looked into the editorial version of the 4.0 spec that I got access to
and that used SDBS. Maybe that got changed in the final version. Will change it
to LSDBS.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

