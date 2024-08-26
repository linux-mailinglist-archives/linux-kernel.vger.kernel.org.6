Return-Path: <linux-kernel+bounces-300912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFF695EA68
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD71288537
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CB412DD88;
	Mon, 26 Aug 2024 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udx50K2W"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983212C54D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657311; cv=none; b=BlwUGk9ZTik5wy0tefmzFHD0xIXS2UC4srWeWCtfTTt0vfxkiXMCBjAQfRdeSLooVsi7CYbrVJJKwi75+tZ+s0VUXv1ZNI3MebApwArxoKbHjDFfdEKjY+whoTnUQKrKmvOvRg9L4C8hD4VnozEFXmymphx5irNjrUNo5ian1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657311; c=relaxed/simple;
	bh=NEUvsrWIGuopintg+ZF53sc4sJ3/HAHUMMoDA4oKY08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idnowKkInusKxGRXcgkZtZtsxR/gfivviOQHH8uwPE1p3d4safJuPuSpAeMYym7jKSoQa60DJ/MWRvVr6rpqnBEm/FmzXHCijuCybgk1x6quHshWtQl/Oxr3b7lj6BYsngGKSSBYTt1EW2AmkUKhPOr8vXngYlxWfse5dtpEy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=udx50K2W; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso4281186a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724657308; x=1725262108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RbGqkUI0s/gjlQAZIm/lK8sn6ESFX+2I3G+WPltBFcQ=;
        b=udx50K2WWAmhuLirSR1LcMJL6j/HZ6GYGQOE9bp1u9NAq69/u6O/MgFxjtc/8N4LyS
         1TiUyxS4kK2tyoSVCvmw/F0h2AtVWGpJ27VwtaZjvCto0rhMRV+fUpcrarImSF3C9PVM
         I2tWeNEgk2nzL3HsXiTXyVk8T8R6xL8T46mvuwwVSD//tjXjVe0xWncHy6YBxLSMR1D2
         /i6qByPcEmtYpwZgsVD9/xWhX/4ZInuznbY3uuq/8D26/ljsIpfAy9IbaW+2kQMZ0M72
         Fl4Xg2XmdKlg8NUg3CtDQzjgsJqGpXLEn+N9U4WdL23xN3x0km/qffwcE4n58DrJWdb2
         +aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724657308; x=1725262108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbGqkUI0s/gjlQAZIm/lK8sn6ESFX+2I3G+WPltBFcQ=;
        b=vte4HMybSuzf/ch9YpMpri/qCU0Z3pKSs56lat5Xs5O/jy6zOPhjclrEaBr7AEtczS
         tRk9tMOwOFEy9HlMtgFCtvZSDCRXfY8qhhjMMD2Y0RINxivS2JJrM75m3fMryTOBWhj7
         RgznT9qCrA34hGub0KK5Va1sWBIsDuO2jwIYqDCyeIMyxIWP55bjQ8fRbLxr87fugNO3
         UeO6nrvVsfLuzg79YEa670X3cpIFPbtLOhCW3F0fIY3lj5eAhdiH6OiHk5YNwSufHBPB
         0ugy8Yzl9vVVl3rCTulFAPuYzROibOKnrej2xUrqvTcaDSnIPCQJ4UusD9qE5UMGqWbk
         NUOA==
X-Forwarded-Encrypted: i=1; AJvYcCUnRegPSrGOeDpUHnSDqVpAvBJBiq5/Qq7yX2thpXU8U/V6f5Bcz3z6+jErnj9Z/PM3N7JpwpJxtHhsNGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42AKBMS0dQyw0fLBzYxpSa73SHxjMno8wBZt/Px8KeU/Qqcl4
	3NAp+Z2nsWTcg5VRmkGHpqme3W2Xfzp3FjeSJVTLuCVYoIIT99c4TcNzKeWDgG4=
X-Google-Smtp-Source: AGHT+IHuCNKZOpTwAIQbI3QRJpJxs21gzKfq52+yERHzKxo0FB3Q/CNhhr8mVEpnGGjQd4Ose+mb4g==
X-Received: by 2002:a05:6402:26d4:b0:5be:eb90:183c with SMTP id 4fb4d7f45d1cf-5c08915f4edmr8424931a12.6.1724657307678;
        Mon, 26 Aug 2024 00:28:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddbee6sm5565008a12.9.2024.08.26.00.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 00:28:27 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:28:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Change slot number type from int to
 u32
Message-ID: <0289149f-3880-4e20-a22b-8540f212f1b0@stanley.mountain>
References: <20240825072955.120884-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825072955.120884-1-riyandhiman14@gmail.com>

On Sun, Aug 25, 2024 at 12:59:55PM +0530, Riyan Dhiman wrote:
> Change the type used for VME slot numbers from int to u32 throughout vme
> driver. This modification more accurately represents the nature of slot
> numbers which are always non-negative.
> 
> The changes include
> - Updating variable declarations
> - Modifying function signatures and return types
> 
> This change imporves type safety, prevents potential issues with sign conversion.

How type promotion works is that if we have if (a < b) { we first cast
everything to int.  Then we look at the types of a and b and if one of them has
more than 31 positive bits,  which ever has the most positive bits then we cast
both sides to that.  The danger is that a negative value will be cast to a high
unsigned value.

In a way you could look at it like the unsigned types are what is making the
code more dangerous.  If we didn't have unsigned types, nothing would change the
negatives into unsigned values.  Sure we'd have to always check for negatives,
but you'd just get used to that and do it.  This is how high level languages
like python work.  They don't have any kind of nonsense about if you're
comparing a define and a number -5 and the define is defined as another define
and you have to dig through five different header files and then the define
eventually becomes a sizeof() and so that means -5 is now 18446744073709551611.
In python -5 is just -5.

Of course, there is a place for unsigned types in C but it's so subtle and
complicated to explain.  I think people wish that there was a way to make C
safer when there really isn't.  There is no easy answer like just declare
everything as u32.  It's a false hope.

Here is a blog with more ranting.
https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/

regards,
dan carpenter

