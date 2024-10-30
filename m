Return-Path: <linux-kernel+bounces-388098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B09B5A83
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E2A1C22E69
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5731991AE;
	Wed, 30 Oct 2024 03:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJoTboqH"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA919341F;
	Wed, 30 Oct 2024 03:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730260350; cv=none; b=acBWACzSljqsU0FP3jQyZ7uggVbEjVSPTpuEfrj85y4gSUlSORW0grv8TKXnz8aFaA+JJx+82WM5eCNAI35yCSQoWEbEO2Um9LPPMJZ5eiG9YcZPZitY8LDNQ5YYND+29kAAkLZ9k2a3tGsi+Va3gOLr7CL2gjBSMkNHCCYEXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730260350; c=relaxed/simple;
	bh=I7kpKQmp+LA7SA7EyORv8B9GG6XIXMl8zBoQd8WMleQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNsaJBUAuR4OJHOrmQStUJksL9G6nTcCyqY9egMiGd3CKb8gYEcmP00uqo+dQlD/7hoc+XcQ+sDTaw6KxFvt93xSozBMiRGBGjJQT6Amu6mnbCCunjgvkYOJXSEHB/PoY3I5e9lnK6RG6wy7vO2oPaiqbcSzrLWFUcMYt2OtWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJoTboqH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so4768156a91.2;
        Tue, 29 Oct 2024 20:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730260346; x=1730865146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbwvVTwOy+SO0yRgFOz9kS/o1vQ7kE8X5/o9C5j2WJ4=;
        b=CJoTboqHlLpQS+nugV/bTL+OftwTNOQyDKzUhdXfi14GNo5gOtZObhy5mmlduGJB8K
         diHF8IVc2eZhpV6ImG8OkpjVUAdyOkE2EIgQVxbOFFiU0hf1MD0P/BTgTAWfBhDusIpc
         /UtOJePp19FRaRWAYUvZHyFXnccs54+aROaTMNjGjm8GLyo4DdQwybYkV3S9wzIT7pTj
         OIU7Pb8IbakELK6bZ/V5nWZzT6nwYtPRcaipkbq7dUaxPiJNRRr3fJCJTHqv8jeAXBjX
         uVKldKBmqN4kK1BKIBbxFlVZOj5WY/clrOUXj6e+mqc41j8Bkj4LnIcxxiEN0Vwinjys
         Bl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730260346; x=1730865146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbwvVTwOy+SO0yRgFOz9kS/o1vQ7kE8X5/o9C5j2WJ4=;
        b=LqwrrRhFF4jIyV4TpPswdI95jnG4KXqpj80znwHDP88upkElAhOlSC5G5I7Xu9g0gj
         N7ElFRRjY0uvuO8qvkWfRr7K2dDyLQSdair9x0MeW0Xobh7FzoeSPdWJoxZsOt0vPA7x
         6QETb3kinI1LJzYRyXD5e70xBcqb+8z9gDmGy1kyoqgQsjJniuwrGHMFKDK4NSRzjCPL
         b5ejewJ2y0FbfztUSSr7G046TllTP3p3JStafQl2qw0VBZYKBXv2ed5wEZwG/Ig0nE5Y
         WV+wMyRFVM7UMa71Qa6hzBbtoPPlGnoSWZTZJ+0XLlmLnPyWI80RjzTl6Jxhz+mZUiDm
         F4vw==
X-Forwarded-Encrypted: i=1; AJvYcCVbscA5IeWKzJHlwVVoNld9EPT+/G0dW2TP9849z2HRJPfpJjO1xv1hHy9Yov0UsTn4Qn5coqb+KwdC@vger.kernel.org, AJvYcCX4FzU7l8P6RYq/Exu0AVIRUgT89RXcoS/PPkkR8iuAzTQ8VxYttLCk/dWFXFAnylwcGbX3Lp71+xajWdxX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4iKIDxC9AmtHeHVAN1tZd2aAvkJGtUGFgi/TRkwLuVG596NL
	XbT58gWCAs5UCem1y4rzS+MIx98twcCKLaXISRtONjQjqcBv9BXX6XVgiw==
X-Google-Smtp-Source: AGHT+IHyC/i13QPcOKD2CFv23b+jdVC2FHNMqnX9p8U1AHLFjS2zjB6luXhurheF98UBB3QUMm+kZQ==
X-Received: by 2002:a17:90a:b111:b0:2e2:d16e:8769 with SMTP id 98e67ed59e1d1-2e8f106926emr15758945a91.15.1730260346047;
        Tue, 29 Oct 2024 20:52:26 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbe07cesm525438a91.43.2024.10.29.20.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 20:52:25 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:50:54 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH] riscv: dts: sophgo: fix pinctrl base-address
Message-ID: <ihmors43w3ttfun7c4fj75ahh2hnhafdxhlmocbxfwttigj3fq@wxud2d2srisn>
References: <20241028-fix-address-v1-1-dcbe21e59ccf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-fix-address-v1-1-dcbe21e59ccf@bootlin.com>

On Mon, Oct 28, 2024 at 11:43:24AM +0100, Thomas Bonnefille wrote:
> Fix the base-address of the pinctrl controller to match its register
> address.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

Fixes: 93b61555f509 ("riscv: dts: sophgo: Add initial SG2002 SoC device tree")


