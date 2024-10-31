Return-Path: <linux-kernel+bounces-390267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB339B77B8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062F6B23C89
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BBA198E6F;
	Thu, 31 Oct 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBGZSJi6"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E13198853
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367557; cv=none; b=qqd9/F4F7wdfPGWIUr3GZJ878WYt53rnxxSL6a0ArU4UpasVcDSOD47NBL96j0xSXyiRsl7DnD5bAkCWFSNtClWW5PqnZTzk9p0rULdj5zguz49J7g7M61vkC+LXMRoaQWPx8Tlj2IC+Jk8wOMVs6d3BNPgYgcOhTSDqXVGZbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367557; c=relaxed/simple;
	bh=/o4MggE+AzcXkavFkmQNZ85Um2Lx9dIx/mjXbk/xSWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a65Sy+52rPRCB9kZZ0g7lrCVn97zNYsCe/u+wmxtXx0b8EcpB/yRMSIq4T05ydfhF4HvwIkK1jafE473scme5+Ce1/VEcJGZ/GUn1JfI5dFNw2R6VYy+w5UV4pHUkP7/bj46gJZHd5NTuA7wuDRnAnwxgYelP8lkBHvVincj+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rBGZSJi6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d5689eea8so465076f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730367554; x=1730972354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i42WZwPkLvBRfNlQLAxPTVFJmRSkrVUk9wWE2BSDhqk=;
        b=rBGZSJi6YwyQmBItYrXzf+ClrldPGHHPdOlQjwfPmzBsg347PhHi33xepCNJgTxRze
         fxJAW1O865AZNUsbqu++RWjvRYVwLnkZpi/ijLai3HFKJCd10NBpoGvGLHHEao+QkHyw
         9Naxwi9r/Z1gGhQCcrpPY3+W6b0nju6D1XBvPr+IT4sH7EWXj+bQHCCJztMymZM/4HaK
         xTsIoDtVA+1W48VEcHJ6P3VOnAKQCTD7GcIPJXjqY/Ib7+l6nvcAHXUvQNENXHUB5+Fh
         k1/jZGycbX0PnlKnjqAVxq3QjOOtAAjcwHRQPnQYmOmtcRwwhyACPtMt1PC6WLpCYa++
         0djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367554; x=1730972354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i42WZwPkLvBRfNlQLAxPTVFJmRSkrVUk9wWE2BSDhqk=;
        b=V/aqmOtipN+tm0+JQ11GqRDbuXWW9gKkoiL815KRvTl6475iejm4nfK40EXG650TK4
         lcmPRU1MHIN0CJK9Kz5xk4qDurNgju66CLWAeyVBFDYS7mHDPM5VIMljo60gQFbI0zQN
         /XojoCMDJbXjhddz9ee5euo/5rU2HaKSUkgaw5h3OebMff85O8ih82J3X3t/xBoSVXSf
         61q7iEO9yVO3KBJ3xuQZcxhK1j+oMjbSz37UafYPrV4f2k57XFENRaMOBCJJcobj/d+4
         rj34eGuTfkjfJ+1ZeTGlbsAhwc6oaVyliT1xwLxo37PIHy1cEgd0I9ybPjftxc9D7uCa
         FI0A==
X-Forwarded-Encrypted: i=1; AJvYcCWTFabV/X9ddE3Ol3aWK0k0RWcH0Vap6w9FK9NN5nFG8HAfclhWodxixiyCim/TNBKtdDByM1nnGFiKgxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyK0IbjY7ekq5Y0xR29krV4oMXWjmHTjisacp8eyJrlf6BfcWY
	1SEep+4TIN0jtiS1P8g7ThHek83Lvq7LYtq//F5zMsfZmpkgOFmb4rbP3yG8NxM=
X-Google-Smtp-Source: AGHT+IHVBYXZHIeFVSzJKMyjPPRTI538bYROcADmMmloUIXdIkyVOxBgB4ul/54dATOWsHi6/eAB+g==
X-Received: by 2002:adf:fd4f:0:b0:37d:5130:b384 with SMTP id ffacd0b85a97d-3806119cdd9mr12579318f8f.35.1730367553824;
        Thu, 31 Oct 2024 02:39:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c08sm1561130f8f.17.2024.10.31.02.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:39:13 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:39:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] USB: serial: Fix use after free in debug printk
Message-ID: <490dc872-fc62-49da-89ff-4eba067df8c0@stanley.mountain>
References: <7d0481da-5852-4566-9adb-3a8bb74cb159@stanley.mountain>
 <ZyNI3rQw6q4pkqpD@hovoldconsulting.com>
 <8bad985d-4655-45d2-b448-2b3377a8438c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bad985d-4655-45d2-b448-2b3377a8438c@stanley.mountain>

On Thu, Oct 31, 2024 at 12:35:31PM +0300, Dan Carpenter wrote:
> On Thu, Oct 31, 2024 at 10:07:42AM +0100, Johan Hovold wrote:
> > On Thu, Oct 31, 2024 at 09:59:10AM +0300, Dan Carpenter wrote:
> > > The dev_dbg() call dereferences "urb" but it was already freed on the
> > > previous line.  Move the debug output earlier in the function.
> > 
> > Thanks for catching this, but please use a temporary variable for the
> > struct device pointer instead of changing the flow.
> > 
> 
> Why?  The output is the same either way and this way is cleaner code.
> 

Nah, you're right.  A temporary variable is nicer.  It avoids having two if
statements.

regards,
dan carpenter


