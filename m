Return-Path: <linux-kernel+bounces-329513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E8979236
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B321C21480
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD12B1CFECD;
	Sat, 14 Sep 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVjSPdP6"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2D4414
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726332692; cv=none; b=KMxkbp7uCXnp9vwnHPeGjeoyn9fYdi4ThSXoHpG0ATXk0QHltfI1u5h9NBqVbg2H8BFK/DSm3fwT0TityNROu6lpwOgkVzZrGLttXVrTgfGvuKBfaSKC7VkrPgo4f/xWwVwwb7TpLd5q7tyUC17riBc0NLdJogJT7mB9au7Lpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726332692; c=relaxed/simple;
	bh=4YIUED8NTvL+pJU9x1zOi1xxGpnRcuZT+fTCARpcsEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fardyu6jNSII0jwGC5KqETyti5ay50aP7TriExCujDpnkLJ2IzZaQvbgV11mDNnUtx9psHQfU1C/wvtkjPeMSk/53Nna3MsEen+D2a4/N93SoJDQej0Y8CRMpyD/sVkJ2AlhcarOwfzUA+t4RJH4Mmq1b0ckYKK6SDQJTuuXfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FVjSPdP6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso485914166b.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726332689; x=1726937489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=260L8wObmIZ37leKXxRsSt6Vzwvxj0E4EQRxHhUduKk=;
        b=FVjSPdP6xwzAB9Rk9eIiHm1OZNeoj2Sfx93YXeHYVpKXj67QIXh+8/tjdaBGEmO9xN
         K14Pl4nvRdEryDMItlBLftU/J/KG/xy7mFO1tTwiXl+M7/mw2iAmzOnFp6WPVFC3vtdY
         54xR7zP+lcGz+zmhyI4eaFgvtrYE5Jc1Vu3ilz3Uw/ROIXhaRjnw7YDHtMgw9nReuRWh
         1P2fMM94qkVKHd0FX3JY3Xbv4AsJwetRBIWDtPQ5t+wrdqQrcmgWIDks3TOnRWo2MI1u
         MMH911BvdYZGML+TDacZtFpGA8IOe1ZHAKvObClDO+eSINS1tOyS0Acj7AhAw4h5nDtl
         QIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726332689; x=1726937489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=260L8wObmIZ37leKXxRsSt6Vzwvxj0E4EQRxHhUduKk=;
        b=UGe7QRr1VH1uzRSXJv3K5NUb+zD4d48kD+KKlumwyXMytGOXnUYbpkGpFT01hKu14p
         NURvPiXV2JdqA9gz6YzAa5ob/2dqSUDWhNr5Yj1IhZe+eLz6xTcpoRzbn2WWlpmDfEiX
         GDBwAmAoRzeQXeA4rE4fJgcE+q/ttmGPSXzx2guDepAGXmB8jDm3JYgTVM3p1bcjszhf
         j1twtY0XWu9L/MC9X5Eoo5iCCFP9Ibj93GJXsEU2N8jT/KXdGZ3fNR7YTvpAqP+fJ0nZ
         7NnQ/7IldRZ2Hmf3WSASdsR7v7YOFOjSnm/KjVfRPRQ20Jj+PJqX0UTNH8JrNU6g8EBn
         npIw==
X-Forwarded-Encrypted: i=1; AJvYcCWQzMskNrarE3ScjZU96KliYBJgbYtsr6++tuOExWJfp0qtl9GN0pWxI/zW6PptitzAC5LtEl4FkeU/iLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxetiH9OoSFnirupc/ePUZCHRb04EOnp6VeE+hiLwVOx+4HXQBH
	JTC+sC5zIVVZF4wcf29NuzhxorZjnY3oyNMpYf/fBAO9aH26dC18JH5C+ffx/Bg=
X-Google-Smtp-Source: AGHT+IEg9Ep2YCZ/L0TFudDfeLg21XrwMV52bqJ4ziTDK6kTpQLQzJiKRJFmO88/YXaT2/T/CXXbOw==
X-Received: by 2002:a17:907:6d28:b0:a8d:1655:a423 with SMTP id a640c23a62f3a-a9029678c66mr1159702366b.56.1726332688539;
        Sat, 14 Sep 2024 09:51:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3997sm98312866b.104.2024.09.14.09.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 09:51:28 -0700 (PDT)
Date: Sat, 14 Sep 2024 19:51:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: octeon: Use new initialization api for
 tasklet
Message-ID: <3d9ff743-01bb-4b40-9551-fb220bf3c7f3@stanley.mountain>
References: <20240913191734.805815-1-abhishektamboli9@gmail.com>
 <2024091424-glisten-unmanned-bb8f@gregkh>
 <ZuW9iInzizGypLRt@embed-PC.myguest.virtualbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuW9iInzizGypLRt@embed-PC.myguest.virtualbox.org>

On Sat, Sep 14, 2024 at 10:14:56PM +0530, Abhishek Tamboli wrote:
> Hi Greg,
> 
> On Sat, Sep 14, 2024 at 10:20:02AM +0200, Greg KH wrote:
> > On Sat, Sep 14, 2024 at 12:47:34AM +0530, Abhishek Tamboli wrote:
> > > Use the new api DECLARE_TASKLET instead of DECLARE_TASKLET_OLD
> > > introduced in commit 12cc923f1ccc ("tasklet: Introduce new
> > > initialization API").
> > 
> > This says what you are doing, but not why you are doing this.
> > 
> > Why is this needed?  What bug does this fix?  The code is the exact same
> > afterward so why should this be accepted?
> > 
>  While this patch doesn't fix any functional bug, it ensures that the 
>  code is kept up to date with the new Initialization API for tasklets.

You need to resend the patch with this information included in the commit
message.

regards,
dan carpenter


