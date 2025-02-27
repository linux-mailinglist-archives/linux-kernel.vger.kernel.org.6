Return-Path: <linux-kernel+bounces-537244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68F8A48995
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C071886167
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A9F26FA76;
	Thu, 27 Feb 2025 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMNSlluZ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23B26F46E;
	Thu, 27 Feb 2025 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687089; cv=none; b=fq4O3e5VQ+73VJ4ULXWqO5DLf3ifgQLj9cW1roCWVvJi90NoUKKYij/h0Vy6z2XlCPPA3UCRxJ9vkv2S3F16838GMhz5MBhMjYJL7BTzkHza+S80Q9PcPD9QZhMs3iz9ixdEW9piTMGDcGC5eWKpNcilSR/HikeXof4HgK9gzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687089; c=relaxed/simple;
	bh=DnWd/E0xczaoDEIgI+I55eU7RCGoOyvxz0buRmpQb9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a71IE9VjH5YufBMon1RsSYx1aEes9cBRdjS2cTEeApMFP/NLTdOn6tpIjligq9atn6uXj8Wy2xt5XKKDGf0h1pv+MVfDasvccxflvl9v8EL+y17FhTpaKPEdkII3y1E31XMXEolM0nDyMjcuvLPs9TsxSGUpFCqKvG3FgLWOEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMNSlluZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso2353853a91.1;
        Thu, 27 Feb 2025 12:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740687087; x=1741291887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtRBTV9UKR+OGw3dJKUiMPVCp52egxrnRethKoRX62Q=;
        b=YMNSlluZh6p0FYvrcqOHoPd28capt7PhPP5iyJF+Wwm/E0WqVmOV/gURpOtGcRG6R8
         grH2mY0qsWTgCnNUE0gM9q5H2dbV7LxiX+7OtuTvmCldp0F/XwnyF8+j2z6aDRkCiKZ6
         L97X39D8Yn7+TkmWVg9F6iAiCSFPeYok0HAxl++OkXHvMocKkLntBtY3BkhGub6wOPOn
         EY6Q0xA7WNMIaJgKjd6SukXayb9r9IYfoOkMgG9oe/JJDvtc/Gi4uepJPHhI3m0BEiZZ
         R4dUfWGVNpfgs8mHkxOckBqYG2ogey+4oABkQVylmxGNtdAcXNGG/7o1ESd7ZKfHo65H
         zdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740687087; x=1741291887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtRBTV9UKR+OGw3dJKUiMPVCp52egxrnRethKoRX62Q=;
        b=Li/p0wHlDiCopPMXRTFKEomleisJZ+wCv1Q6TLFgmci0RU4HWZdQeAu6bnAqy1Gep5
         bnlWuILR/MtHPq7WcGU9M1iY/4NiDNugQ22YU/4BRhbdZA0lTqVwwDhnobXANlK9wFhN
         VmgdAKIgaMOLBZaicQcFW0zxfBfQ+3/rmRnjA8AuguL6BRsULz9rKygGye1H2pi+GP7g
         DMcxAY3EnZGljk1TSOFzvlKU/FxIpy0xL+tZ2QXQhij8nu2IIoeLIxScVGiSLSNr6dSs
         2lDLlfqeCOfQnKsOGuJga97naFjX/RD2///hbtFaOk4inQdYBeG79n4kBiDY3hnRX1Ax
         bOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfIdG+fwTLyI0kcMleBxc6iW0M63+SYKf70ZYhRXfyaZcVY0Q5xGzwP/f+b+oBsk2U8D3s26wgsj53@vger.kernel.org, AJvYcCXDeP0g2YV6PQEU01TUi8gKgasArikzW5UR+Tp74guYAHLqR0qdB2hv5YmamRzuOJE182Y3N0RQ34foI4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaUQwSVFEZMdGWjrYNFlw4xLRSY3nlyZXSYtcP3i7Aq5rzhLKs
	74C22dkEGgUMHRqjamC2id5zA8dcAcm1gpF8xCpz6UcKJSsNKKH5
X-Gm-Gg: ASbGncuYAGwBe8nlVCtObg0MEe8icP06N2MWpLsoI3HduflLjSB7m3eg1K6pInN2ywm
	5HR0mWG7944QmlP5bEITsukRpM9WDZh6cIN6fUsJNhCiEs0sIXwzSwRzE7b5J2uH9ahtRgY2Bup
	4Lly0+5AbNcojP1J8V2CMuiPJyZiK+KsQDa/kai1F/HEgAIHvDbgH/GSjvpW7RVGRv1Ob6Pi8xu
	MxlM/SdFkrYAZyYaC1+bhGuFp8VM1rFiibSuw11Wa5Ph194YjyhWOUuqYyzVk30pB43ACuejxcF
	oz6EqZBngiSG7rUnkAPJen36KI0e3v/dpQ==
X-Google-Smtp-Source: AGHT+IF3ctquER88QUePhseS75+E0p/QHwJwJmAEL1HQNd2e5ZIyU0Ayi2LIjBjv8ihie8XLSXm58Q==
X-Received: by 2002:a17:90a:d605:b0:2ee:bbe0:98c6 with SMTP id 98e67ed59e1d1-2febab56ffemr964338a91.8.1740687086863;
        Thu, 27 Feb 2025 12:11:26 -0800 (PST)
Received: from embed-PC ([2401:4900:1cb5:84b:96dd:21a7:7ff3:7964])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe4cd89sm2195510b3a.66.2025.02.27.12.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 12:11:26 -0800 (PST)
Date: Fri, 28 Feb 2025 01:41:20 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Subject: Re: [PATCH] xhci: Fix bcdUSB initialization
Message-ID: <Z8DG6A76HFWs3hlD@embed-PC>
References: <20250227193400.109593-1-abhishektamboli9@gmail.com>
 <2025022757-extrude-carpenter-5bec@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022757-extrude-carpenter-5bec@gregkh>

Hi Greg,
Thanks for the review.
> On Fri, Feb 28, 2025 at 01:04:00AM +0530, Abhishek Tamboli wrote:
> > Initialize bcdUSB to 0 to prevent undefined behaviour
> > if accessed without being explicitly set.
> 
> Is it actually accessed without being set?  If so, please explain it and
> also how the compiler is somehow missing this already?
I added bcdUSB = 0 based on a Smatch warning about potential uninitialized access. 
However, given that bcdUSB is always set in the first loop iteration, 
this might be a false positive.

Regards,
Abhishek

