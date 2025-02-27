Return-Path: <linux-kernel+bounces-536631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F9FA48246
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4BF188F6E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1DC25C6F1;
	Thu, 27 Feb 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="judPU/uM"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37C25BAD0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667784; cv=none; b=ApV8q+LlGOJxjGPhOkQb4zOEDvhk/iEPQwDIMOCzKJd1EAYsrCmscXN1lU461FWfMAW5KmlJKVYn1STEOjrJS3xggeF423k7ANdcyNQAXg8fM4CDfpzh9S4pQ1+uX1fWQH6bncCPkg9xI4URNETOU2wikKX8cF/tSTUgUQaSD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667784; c=relaxed/simple;
	bh=6faw81wFFaRXZ3ymmYdJwV0mSvCtlP2Ar7QjlZFTgoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMbmUqdKckFfJJ/QcPsw37e20R8KfgyQqfUmh9qCgx+vtr80exgRxLa2VLyPUIGkQ7ZR7HyhxUIZL7+y0VAtl8HmUydjmT/3Bybrgf0MxcWR+xiYCXHA+NQcqxLp4LAP9YlIys8X0XXe+X9Syfm5yCpMPrATbJkBh+9S4Ww7VZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=judPU/uM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22359001f1aso15614985ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740667782; x=1741272582; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=smnGGK6K/Wef+b2awCjLQ7c9xAU1Vqd0Z5QG8gAABNQ=;
        b=judPU/uMsYozBnMd+rF7yQgjRKyWcfspUpOL7O4D6Qu0vGtEQXaW80EAINGBF3aSGO
         noWvuuIibRn7Zf64JOzA405Y+lwU08n/udEMRvSiWCw9cj9YEPb0WR+zUWUhxQMXqjPm
         lGVjMs8dWyyvSOfuqIGCunUofES+wOr51+mci83gfpqgaYYSG1n1jqZcW16M5wCGxQNi
         WVNH28NbJEH931xJd29QZoC0PAk5zghXGwS+sznl4QI05OOadq4XkGOshBP+lGlh93Nb
         d6IN/9auyIcVySUq9YVs+H+Lyc/6ozzn5cMqO5T3t4NsIUb1GZP5IaM+GUbmIccHDuXI
         3DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667782; x=1741272582;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smnGGK6K/Wef+b2awCjLQ7c9xAU1Vqd0Z5QG8gAABNQ=;
        b=fyxx6Z0vVUD/7B8+zLtbzZdLXoiJCBoUG0DUmMKqr9FBNWb8kPM8g2GqSzksC8IMXy
         cKswmHRNeq8Ne9dtlEtE36Pdr50mxB8dSVsLcNBAZUQBu+5VoXyWGHYJZDjJWypIabV2
         8lnFMXgElEkX7UPtTFbecEYjgBG3syAHosyUsNfvezhHAVBzQCY9nSJqmuYKLUq+c18t
         SNtp32Y+1dz31iYiu+s40roVv26jrQvBiZPYTbutRtad9j7TsEiRHIUpKgxZLWKO6Rms
         li8VD5jfjO5SgwNheV/lcArQtRL1dl2EW92a4h7K2wWpkD74GtHH+25SzlnTwuqKYwvw
         NU+g==
X-Forwarded-Encrypted: i=1; AJvYcCUFKFXNcyEGvxrU/5WO5RTvmyyLTNH9nesU2LTkSZjMBcwwhsjVCMaYyffN96dNqGHqlMfGDI/2lK9WnHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlQ3UxucV5Y7s+CtaqbWuqbZB2BKorRdfoErgxDoxuXjzsEga
	cnpcNm5b9Kqfvn7xKWTMkTSd261dAEEA3faO0OZzzJSOF3Shx1+qfQriNRyjjg==
X-Gm-Gg: ASbGncvzP0+HJOU2xxi5GDhDB1yRh3r+ANqwdS+uWLNaMvh4jJ2W9ggZBWwL/dqDcDy
	A5vOHu7MxZZlDCvYoDw8k/dkjFMsma/p1ZYpeL1Qo4YDyk+0AH1WrkXtx/sS4sFBhsk64a9f1lb
	biLtzotZzDwWNgWCc1IzibnjX7p5sWop7lI1Wg1rkbPVXvhMhPB/thcdAwDUfPKd77vFM7C22aG
	kwaWop936+qVwnlZtWjQ5QaXrzftewnvJUAiDJX2EQ0XL2DhGzvBzoh3HLLrCj+fVX68rSgwvcu
	6I690zlzPX0rM34G3GLUVsPbptUS2U9amHfs
X-Google-Smtp-Source: AGHT+IGPbMh9YLaLdnjg+qD36H+rS672w6Z7sxM9qS1ipKhQCSGEXPnAHeWSHqT6Fb4RF7dlqr8/wQ==
X-Received: by 2002:a05:6a00:c94:b0:730:99cb:7c2f with SMTP id d2e1a72fcca58-73426cb3cdamr39658350b3a.6.1740667781668;
        Thu, 27 Feb 2025 06:49:41 -0800 (PST)
Received: from thinkpad ([120.60.51.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0060069sm1661260b3a.159.2025.02.27.06.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:49:41 -0800 (PST)
Date: Thu, 27 Feb 2025 20:19:36 +0530
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
Message-ID: <20250227144936.4wrvydm4i4oenszf@thinkpad>
References: <20241025055054.23170-1-quic_mapa@quicinc.com>
 <20241112075000.vausf7ulr2t5svmg@thinkpad>
 <cb3b0c9c-4589-4b58-90a1-998743803c5a@acm.org>
 <20241209040355.kc4ab6nfp6syw37q@thinkpad>
 <3a850d86-5974-4b2d-95be-e79dad33636f@acm.org>
 <20250226053019.y6tdukcqpijkug4m@thinkpad>
 <6eb9ec05-96f1-41d2-b055-56e34d5722ae@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6eb9ec05-96f1-41d2-b055-56e34d5722ae@acm.org>

On Wed, Feb 26, 2025 at 10:40:51AM -0800, Bart Van Assche wrote:
> On 2/25/25 9:30 PM, Manivannan Sadhasivam wrote:
> > On Mon, Dec 09, 2024 at 10:35:39AM -0800, Bart Van Assche wrote:
> > > On 12/8/24 12:03 PM, Manivannan Sadhasivam wrote:
> > > > On Tue, Nov 12, 2024 at 10:10:02AM -0800, Bart Van Assche wrote:
> > > > > On 11/11/24 11:50 PM, Manivannan Sadhasivam wrote:
> > > > > > On Fri, Oct 25, 2024 at 11:20:51AM +0530, Manish Pandey wrote:
> > > > > > > Submitting a series of patches aimed at enhancing the debugging and monitoring capabilities
> > > > > > > of the UFS-QCOM driver. These patches introduce new functionalities that will significantly
> > > > > > > aid in diagnosing and resolving issues related to hardware and software operations.
> > > > > > > 
> > > > > > 
> > > > > > TBH, the current state of dumping UFSHC registers itself is just annoying as it
> > > > > > pollutes the kernel ring buffer. I don't think any peripheral driver in the
> > > > > > kernel does this. Please dump only relevant registers, not everything that you
> > > > > > feel like dumping.
> > > > > 
> > > > > I wouldn't mind if the code for dumping  UFSHC registers would be removed.
> > > > 
> > > > Instead of removing, I'm planning to move the dump to dev_coredump framework.
> > > > But should we move all the error prints also? Like all ufshcd_print_*()
> > > > functions?
> > > 
> > > Hmm ... we may be better off to check which of these functions can be
> > > removed rather than moving all of them to another framework.
> > 
> > devcoredump turned out to be not a good fit for storage drivers. And I can't
> > figure out another way. And Qcom is telling me that these debug prints are
> > necessary for them to debug the issues going forward.
> > 
> > Your thoughts?
> 
> Does this mean that printk() is the best alternative we have available?
> 

For storage, yes unfortunately.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

