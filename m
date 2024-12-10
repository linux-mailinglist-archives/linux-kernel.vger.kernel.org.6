Return-Path: <linux-kernel+bounces-438947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6779EA896
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B65A1691B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFD122ACF7;
	Tue, 10 Dec 2024 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y462j8qQ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC891D0E28
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733811282; cv=none; b=p9WBJU0y1XHrxYhcaXHrgNEzk4vnJ5tqmx7Kje9ZMkxdYkUN46IuX4EllBjTeJ10xLpIrL4wKHn8S2Z9Y/VL9+8JCZjRKOGxtV/oU1gpZyyx41JaV4sDmth+oiv7xPs6/kWrpKCm0c62EVA3ZO3bwfJTh6QbAuyIJIKsW3ZicEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733811282; c=relaxed/simple;
	bh=H5jhkkBmcSeHnp14FMPbK7KoVdIILqWdySHjtUR3xmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXbkjTCVJtXdnE3gnPlY1hBlDcEzaAS0r8vyotkXznZnRg+xi423FDBOa52hCOTSkIYSditeKQgP7OObOMl01uK/kr90qDCYb+A2vqH9JshV+t0qrPQ7tjvjzPoegHUxqUXUWPB9oTSOIUOWl2MwuJ8Xy3gC7X3LTTntdJ2j2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y462j8qQ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso2875376a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 22:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733811280; x=1734416080; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LpAEUHjy0DmUd/FI9eBMVOYYjjorp2l0DbXffRcgJ5E=;
        b=Y462j8qQlBXq7N6LQIOYblicdfUwWVdQ1LXl3CWvwFP75T80aSAt65FihsUg6oKv2v
         nBBK8GsG30oBGcfXxZTtrQ/u/qnLwIkyxkcje2EMT8zHnfrEvaMD9sm9eGEk9fSkzQ4x
         Lw2dBOqRK3Gr2uYRG6BNfkkVRUmYtI2Z4OlMh064295qJg6TaJpY+3Hkfs2TDnW5Qy9f
         JWlaRTUfXWIc0DKlYKRJRQ7kO4u9ohlQPEYT3MVgd6knd1DGD/Cc9aPk3dwAefbclhIs
         J/7n36BODFrkyjXI0YR3fqY3R4wRhJiha1DNbM0JOtQjJoCXnNj8TOZBvVSBzzlJvkmH
         KfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733811280; x=1734416080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpAEUHjy0DmUd/FI9eBMVOYYjjorp2l0DbXffRcgJ5E=;
        b=TDRglDFU2UNNIuwpeguW4/a5zbkTAFCUvC7tsthU01T5bg+i2CWODrjbEvLF2ZC9FE
         AfOFx98Yl6TduuK/VIPv46NlaaZLmx4X4T3qAU8Rq+xIDrw1UVeYMz2n2rQpr7jdYa2j
         KdAzhHXMGzE7o0KRjH+XQ0fp6uVKry5IIlh8J3g0N/AdLL6JYkzsrnZwrY5XsdSMBNP/
         Tk3iDZGKSOHUeDHHa6kAJ3HbZWhPCmzJaOaXtJC61ZJumjRuCKJKmjvSFNGMkYc+Atlz
         MBuaKAepdR9vLbx+COyaVGwEI7wQy4diLIu1fhqgeI+RsqAydcQyHzIOOmVItGn1cHoj
         VuMA==
X-Forwarded-Encrypted: i=1; AJvYcCW5I7kSdnx2FuXwyi1qStA2ZzLkSJpBSrTLaP7kVC5FpLxZ+Ju5RqjnAmzcqNRF06K/LPV7gYSqD3v2FPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqs8nmtS9Wihcolff9uFd80T9zNs8XH88apTOxXyJh/7+GtFl3
	l8HPW78blw+sONtx0T1NDYd+xGc14dtp7esFGr1hFnQISvHKRYTB4NG5EnTCqBiSk8m0PBtlV6g
	=
X-Gm-Gg: ASbGncsvQl6+nFFif7mK8yW8C1uUuD2KlGquvBXANMI5sx28TRjM69TZvrradPExKbV
	TuEKXOBgcMxa9tKTbPIQaAP7Ln4IkCAuLD+MORdHuwsOki6pCNSe3Yd1xCg1gGugYaVLUCNXDno
	7KveRifc3ZsmcBeBXfG8zOvmZVJX9qW2gaSrpNPEjb4Hxo/vqR3pPNKKT+JQTrCGj2zZVxuBs+1
	vn4qClVoXk3jAMsT2cujT1HGOpdpau3ce7/Dg/cWh9sSoUsRk5z5elp+nHQlgfO
X-Google-Smtp-Source: AGHT+IEiT5QWdrtrlNLz0y/XTxkbz1jJLbvpAPbUeDX4xD2zua00YW8f3fwqZuwMML6Qot71OABORQ==
X-Received: by 2002:a17:902:ec8c:b0:216:2bd7:1c27 with SMTP id d9443c01a7336-2162bd71f80mr170672615ad.33.1733811280440;
        Mon, 09 Dec 2024 22:14:40 -0800 (PST)
Received: from thinkpad ([120.60.59.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163b1f8697sm37552555ad.261.2024.12.09.22.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 22:14:40 -0800 (PST)
Date: Tue, 10 Dec 2024 11:44:30 +0530
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
Message-ID: <20241210061430.fmj5d6xyqgtqm3jc@thinkpad>
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

They are mostly for debugging the errors. I don't see why we should completely
get rid of them. Moving to devcoredump allows debugging the errors in a
standardized way and also prevents spamming the kernel ring buffer.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

