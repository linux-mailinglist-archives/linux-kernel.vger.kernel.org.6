Return-Path: <linux-kernel+bounces-289006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B295412B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B37B225A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049D377115;
	Fri, 16 Aug 2024 05:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rpk9rTkH"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1282899
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786120; cv=none; b=b/6dv8sB3XS3Ye9oSLenA0x9c4P8SUhKuCaF06LM6qV3JxqvWpfSp8cm3m/LsGrmiHLTq3X3AD15vQjFwE3XEG3ftxHvIiO2F3BtDtuyxQ4oRImvEajZnUiBKNxHgLIu6j/ZTmZRFm0zWs+Jlpa+zsnO4uBbx5mxBiRRonTE/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786120; c=relaxed/simple;
	bh=CVgyyW45hqKlKWSJtD9mWkFJqSEYWC96cjYmVWtoD4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzeRxq0WCcBZT+XBcdQYEB8YfJP384nWWX9nPM7rPsVYmhYSoGO20SG30gs8Lu4iatbH0wMEgQmdnxmX4u2i++Q/JeX5kJTeEf5s8+ixfKBlPmuMyFuBcsam61aScAkFO0hE0E5e9JxqHR+n4Bsy7985o6BhI/hNVIBuDdgxyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rpk9rTkH; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1233952a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723786118; x=1724390918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HjZ4i2QLY2MCZUTKrXk0L2WJ9ATcFb1xvQJ16nAWgPU=;
        b=Rpk9rTkHkfDWBw9ANRoJmFBPA1SiQO/sIwfIM5KjzGhfd/F3SyO8OY9AYC74q5r8GC
         Zxi0l/jNcB0pIyPkxhFlAVaki/xQWM+Ws6mYZ8uh5evqI+Ez/URAbapQMg2jhkkR2IEf
         QpMamo0fcz3yJI6p7iSXHCX9s09ot/6vM/OzSVNnZaFpzfiW3wr6TfeBsIBpaKgk0UWh
         bcx0A6wrL1bhkpJ/uFHlKOZ/9dDsJ70mfaV+qOlQZm4OVA0RNuD1BkZh640/qMHGQrAP
         as0zFafFBr+iV9xU7oWjoFmTJHC5OBsKjrSWZUFla2CzCX2Fc1tiRXOpiBpWuMQ/LkYg
         +ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723786118; x=1724390918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjZ4i2QLY2MCZUTKrXk0L2WJ9ATcFb1xvQJ16nAWgPU=;
        b=dF9NHaFz39u5d9GeYXzqkOylJSrqwdkgRkQym6D/4+m1obZdicW7+qepXTsh1jhKig
         A6kdD467E3BjZiIM+G8N6IdeR7ma7lKEW6SSxbnG1fmnOsaMV0ZfmuRgv5efHbX8l5G9
         Mw32yMyQcgDWFuuKGDz3j5pHvEtC5v434qGVT3zPsWdHZUuDJqpJLbb+faBTR5KOCssj
         OiPiNGT8HUPb4jOw+1qsNp7ODH1sDHyIVwQW+ADR6gP1CtLlwtU1kvrwyhJSWU9Xp3iK
         4gffYaCTvanD2CidW3Z1czosEQ6j7HR1nk935vsKREMRx6O7z5QgT4u4Kyd78gtWNkxx
         aTzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDTiFLKNKoO4kg7Qx8hNqJaJFPIA5JmTqntW/iYZQy+c5R+9YiZEc6WlfA1NmbljAbRDTeT/xnsDBf0CHvF4CpgSbR4kRJomXdXSrB
X-Gm-Message-State: AOJu0Yz6oJQBhf76RBElhXVWtZbcDq+m1XbUVN79JziDrmYsELna96dA
	Hyzx8RBCDiqiFu7DCZ5ND4kj6IFZp67Eg7sSQbRu8YCf8e8Y/C5KLcXCJq26Xw==
X-Google-Smtp-Source: AGHT+IGG47xUshJiY1c6p/0b3IHMBPociHpJXS5YR2Dk8ppi8J/QwruzB8NXPo12pRISFhAwDv1BBw==
X-Received: by 2002:a05:6a21:3998:b0:1c2:a0b2:e69 with SMTP id adf61e73a8af0-1c90501bd2fmr2157398637.33.1723786118061;
        Thu, 15 Aug 2024 22:28:38 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f039e084sm18407175ad.243.2024.08.15.22.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 22:28:37 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:58:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Kyoungrul Kim <k831.kim@samsung.com>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 3/3] ufs: qcom: Add UFSHCD_QUIRK_BROKEN_LSDBS_CAP for
 SM8550 SoC
Message-ID: <20240816052832.GD2331@thinkpad>
References: <20240815-ufs-bug-fix-v2-0-b373afae888f@linaro.org>
 <20240815-ufs-bug-fix-v2-3-b373afae888f@linaro.org>
 <4b24453a-3f4e-4707-8c3a-2dbb0040281d@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b24453a-3f4e-4707-8c3a-2dbb0040281d@acm.org>

On Thu, Aug 15, 2024 at 11:01:47AM -0700, Bart Van Assche wrote:
> On 8/14/24 10:16 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > SM8550 SoC supports the UFSHCI 3.0 spec, but it reports a bogus value of
> > 1 in the reserved 'Legacy Queue & Single Doorbell Support (LSDBS)' field of
> > the Controller Capabilities register. This field is supposed to read 0 as
> > per the spec.
> > 
> > But starting with commit 0c60eb0cc320 ("scsi: ufs: core: Check LSDBS cap
> > when !mcq"), ufshcd driver is now relying on the LSDBS field to decide when
> > to use the legacy doorbell mode if MCQ is not supported. And this ends up
> > breaking UFS on SM8550:
> > 
> > ufshcd-qcom 1d84000.ufs: ufshcd_init: failed to initialize (legacy doorbell mode not supported)
> > ufshcd-qcom 1d84000.ufs: error -EINVAL: Initialization failed with error -22
> > 
> > So use the UFSHCD_QUIRK_BROKEN_LSDBS_CAP quirk for SM8550 SoC so that the
> > ufshcd driver could use legacy doorbell mode correctly.
> > 
> > Fixes: 0c60eb0cc320 ("scsi: ufs: core: Check LSDBS cap when !mcq")
> 
> Since this patch depends on the previous two patches, the previous two
> patches probably need a "Cc: stable" tag. Otherwise the stable
> maintainers will have a hard time figuring out which patches this patch
> depends on.
> 

Well, I have not CCed stable list for this patch intentionally as the offending
commit got merged in v6.11-rc2. So there is no need of backport. Once this
series gets merged into one of the v6.11-rcS, all will be good.

> Since this patch by itself looks good to me:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 

Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

