Return-Path: <linux-kernel+bounces-267718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991D99414B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E571C22A45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8394E19F499;
	Tue, 30 Jul 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pIj0NQ4y"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912F1974FE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350822; cv=none; b=VAlQZrUXqma/Cg9TcylA4H9WxZRPdpgfgkEchLAtfTxoCQ2WFOTHj1ahwgO3ytCstDy3qx6zck1QEUN8dCC1koc9Kzbqz36Jpltno+mTqwnPdftHgJF6Q+Ctsb3XTJgTHaoZERFExg00TGv6BMT1L8BNvhsamGB5BbPu0AZEqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350822; c=relaxed/simple;
	bh=kYTYimlYBjiquYDmbW3OVap8P13dPnSkQlQ5r4BDh/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbSS89xUbzrea8OX1iWEyTATCFLxPLq1oloe2N+dDOh+x+RTxuC6/hx89xeezWACR+Q5UKVSdmQYnblO1lE4KFV1SJxa/RCDOk98Qa37B8S2i24skjiyZXekxmajtI+vWZ6AV3XCnNRFuT0slNJnL5BecUbYNLgd9lfge8iLdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pIj0NQ4y; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70936061d0dso2776779a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722350819; x=1722955619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=19bzD3dFV7tz7aCe19kweAd1yB7wIjeVyw1SeEg2Kvc=;
        b=pIj0NQ4y64pWz4ZYm6uy6j6zeRk0wlOa/FmU1h6DnQfg3glxp9YKQQ9IJ8kRp1NFS7
         PewXM5NkRW2WeDDTNC0t2x6QPSG4TTDkFQlTlsAh9jyPpsnzQXtJcVpqX5oyl8C/oMhb
         lLeeRmA4JkK5Lau2E+hqlD1TgemI8nHTY5I3jtuZHgD+WzWHWwiDobpuUZfxjeLAKNB4
         ngYNjSjXRb0jz+CJuT9NXFCxe6r4PURXlkh7/uQZmiVNcMsg+cQsUkbI/5rUuojQIeCp
         8A40TyHgGpbNTIChHng6cpCcvM4hQ8UqMo3zf4LLRkrT1fct/QJH0qd5rbpCYbxep0vA
         ov/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722350819; x=1722955619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19bzD3dFV7tz7aCe19kweAd1yB7wIjeVyw1SeEg2Kvc=;
        b=h/EICIrfkyADPqVMEDucuUFb9Ln08K9AFaUTeiVue810iQeBBG45LF6SOdpeAUcs9f
         cLiTaIAR54ap698dccRo6yWCVBQEw/3VUQyOP0HVvrnXmZ7xTddMqwpNIFpPzDiXsJuX
         b8LPB8wu4Ylx7OtzQ/gER7yxDuGlJlG9XMuJyHI/nkPkBDTFIb2ROkZy9U5i0kKx7mSy
         rtAVB/wGKlkTAG5hALBfxVei5ql5p8wFhfTT4YDR8QXktAfRkYZtxdQ5W7r/KcJIfvW7
         I9L8ZvywxTZuq4wi5yqteW0QjywZ0+Ex/FxP00kNYaiNSyzJ3bXKiI5Tm8zH7+PXu2CC
         nQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4AlQZYacbJ2PeRYueD+BIrES5BEwnr+w0LB0N2P6biD7ie+6VuE83MuLzqmm5F/ea6nfnP6b7RJETInM4tyEedi2xaDa4hzg5E/P
X-Gm-Message-State: AOJu0Yxixw7zGnI8BAObq+CKTWhHGkhaQho4m/u5hdCeTTaEZQG3RJ9v
	owOL4d11bcRtMqizQJp6gz97Ht8/4VzyuAfyW/nnmXmvboobbhiYEFnc7ef0dSU=
X-Google-Smtp-Source: AGHT+IFzmIHN0DOkgtHQwpPa+Hy+IykmpFZBDq+APGpQyBzcGQJhlffeH0XZLGJ3D0C3lyQkcihSlA==
X-Received: by 2002:a05:6830:6819:b0:703:6543:ecf3 with SMTP id 46e09a7af769-70940c0bb40mr11828257a34.9.1722350819159;
        Tue, 30 Jul 2024 07:46:59 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d5b35c810asm1236669eaf.22.2024.07.30.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 07:46:58 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:46:56 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
Subject: Re: [PATCH v2] staging: rtl8723bs: style fix open brace on new line
Message-ID: <ad55619f-f663-4bc2-ae73-aae7dcaa4272@suswa.mountain>
References: <20240730065901.35254-1-sskartheekadivi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730065901.35254-1-sskartheekadivi@gmail.com>

On Tue, Jul 30, 2024 at 06:59:01AM +0000, Sai Sree Kartheek Adivi wrote:
> It fixes the following checkpatch.pl error
> "ERROR: that open brace { should be on the previous line" and avoids the
> warning "WARNING: braces {} are not necessary for single statement blocks".
> 
> Signed-off-by: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
> ---
> Updated the commit message.
> This is my first contribution. Hope I did everything right!
> 

The only thing you didn't do was explain what changed between v1 and v2.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Please send a v3 patch.

regards,
dan carpenter


