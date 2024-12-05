Return-Path: <linux-kernel+bounces-432919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7C89E51D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC32167A77
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD582163B5;
	Thu,  5 Dec 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/+PPlLq"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5D2163A8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393178; cv=none; b=rgXBN3cTPBu0Mb52/LNCnAwiISr8E8fkwfqSdPZKcKuTroBd14GBZ8q6ia9aHfDZTGuxWfaNXuY7T/TJFt0YbQJ5HuCp8w8bgtUYBuWZ1undP+IT7yNbNDpgaDx0j4Bnyun45oUKz+uyWt3hqv8PE67lp3Ns4/g7xnblZqEz83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393178; c=relaxed/simple;
	bh=duPje3LygJnHrXaaI0cTK/M8CS+WA9ne+Dj6Zrq6UK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSLHSZ0uvTcpgVGxuyG37RGwXlZLHdEzBhq36O2SwZkdr9IwWxpA4Oj/JmZIsEYix0RD0pyZvEWVrwztFsZDbI00mKlmyJkRwRmp2beRyqJRUUW+bMk9dl5WJmgvwqM9KIIld9W+doyBJx+ynWxl+H6hO2n58IfHkWmw9YUAtpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q/+PPlLq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e1721716so306228f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733393174; x=1733997974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/kQOpXWTUOPQmOqqeamFyujejmTR09eYwRs0b1/cOw=;
        b=Q/+PPlLqlxGr+HXBwYXaIWAtXTsicWVMb8Mx3FAzxmj/OBi/TetPrn4b6jWAr56ZJU
         k7xADxEn+j37UDGu1Bl8a+nIfTT21Bs7pdK1Zr4i5YBfsJbBuIsrSlLl/GTRGHlYQ2Sk
         cNYMGDzdDlLaC4WplB/wn3Kj5psjmBJuqyfYf8vFiOFsS9FDq8KW8gx5UzxFOzJr69ly
         PRPaeGa6q2NMmi8KmaPTyqMxDOKnywJbbVxLFeaCS+wBL3Juvq4Cn3jlp5oY/wj/Sv0D
         rsHZNNa4SZ06yPuwOS5YjHYb2hyCu4IogiNFt1L/64kmTvl1HEr+84XBT3hgaB+9cgz4
         10Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733393174; x=1733997974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/kQOpXWTUOPQmOqqeamFyujejmTR09eYwRs0b1/cOw=;
        b=oerq4XXNJGZbLXmKnLrGa5zPT4/dYBj1YeXeorRCTZ7Xt6vHWBOcMQUORvtPavVQ7e
         B6BAp0AuaV89Th5Hakr8A0j49c+yMWxO8Qvsi6Gxx6imp7LUWx/WqFSFIaBuFz+0jPCT
         fFnO8M410WvGz5Ce3T00hkPkZtHynQYEAslQdEibtidfnDp5pv28USEQRFw5P/HTYF9F
         70yM1IpnwHVQgkbMxauC3ZUiqgQS////PuicCEaqedNJT6RSlINpvxKMonGpFArdYSt4
         NPMZWSRVPfMdC8l19HvUeu3yHnzbK/0uKtq1uSo0BQ7VzC5LOc622XzWUGUFRpSZRy1x
         zbgA==
X-Forwarded-Encrypted: i=1; AJvYcCVeWcso/WxXlrkvpc5/vCNAvMouGVdTXAZbJ5R8c0xVs/ct9JwtmN6xbeN1sS6fivDv/sd4C2YYmagnt60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5YBzVoaKdIm6qq1OYrxAqlqaP2ZAuKyi8GUmsd5tPlwfcDBy
	Y3u7UJ0i6PEC16fofSo8sCyFb67miloaC1AftdPAXKSJaEJBKvMas0vrPBSZ55g=
X-Gm-Gg: ASbGncvbZQdNsR/T+vy/exSHfB6MJ+dB/SHkI0x726OXIwbNuNQC1MSj9JAixEBGw+v
	Zh2+9q6Ooct0GiNIRy3M1WRtwHOSCy33Z9xSI2VjvnXTovT5sAxautd64mRkq61MXNhkFFWbTBr
	1gFEoaiawmoM0pVMmwlZ2vxE3Xopr8rjZS5SoUa3TOw8lU7JPGhyPzxl+pJnMBIfxvYzFwCJOHd
	r7UBUwbav5Qv8rUH7pqCtrGi7QqVleQgRh4wGO3cLUqST2rot8X5fs=
X-Google-Smtp-Source: AGHT+IFKUP4XEhaH9l0KWirCvsRf2IyP3F1dJ5FSJTnmx+VqsQDiutPTjsI+5MMwOtaQ5pVTxO5vKQ==
X-Received: by 2002:a05:6000:1f8b:b0:385:f249:c336 with SMTP id ffacd0b85a97d-385fd419e08mr7365729f8f.45.1733393174622;
        Thu, 05 Dec 2024 02:06:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386221a607csm1487807f8f.103.2024.12.05.02.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:06:14 -0800 (PST)
Date: Thu, 5 Dec 2024 13:06:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Marcello Carla' <marcello.carla@gmx.com>
Subject: Re: [PATCH 3/4 v3] staging: gpib: Fix erroneous removal of blank
 before newline
Message-ID: <36f9a87e-ad02-45e6-a8a0-8da65461b346@stanley.mountain>
References: <20241205093442.5796-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205093442.5796-1-dpenkler@gmail.com>

On Thu, Dec 05, 2024 at 10:34:42AM +0100, Dave Penkler wrote:
> The USB_GPIB_SET_LINES command string used to be: "\nIBDC \n" but when
> we were merging this code into the upstream kernel we deleted the space
> character before the newline to make checkpatch happy.  That turned
> out to be a mistake.
> 
> The "\nIBDC" part of the string is a command that we pass to the
> firmware and the next character is a variable u8 value.
> It gets set in set_control_line().
> 
>  msg[leng - 2] = value ? (retval & ~line) : retval | line;
> 
> where leng is the length of the command string.
> 
> Imagine the parameter was supposed to be "8".
> With the pre-merge code the command string would be "\nIBDC8\n"
> With the post-merge code the command string became "\nIBD8\n"
> 
> The firmware doesn't recognize "IBD8" as a valid command and rejects it.
> 
> Putting a "." where the parameter is supposed to go fixes the driver
> and makes checkpatch happy.  Same thing with the other define and
> the in-line assignment.
> 
> Reported-by: Marcello Carla' <marcello.carla@gmx.com>
> Fixes: fce79512a96a ("staging: gpib: Add LPVO DIY USB GPIB driver")
> Co-developed-by: Marcello Carla' <marcello.carla@gmx.com>
> Signed-off-by: Marcello Carla' <marcello.carla@gmx.com>
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> ---

Thank you!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


