Return-Path: <linux-kernel+bounces-206309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 384039007A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7574B28B44
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17631993AB;
	Fri,  7 Jun 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2nYRtGx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696CF199398
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771794; cv=none; b=AFmw0Jyt6pocJV/KyJ9Ul0kI6k/8CH7nmw8JWzLywolL78A7Fa+VXLan1b8cx1rh6W7SkzhzWKFk0JZfdSbxUDREOuInhEMAqP/YAl2NNfJn4XR1jpEk/dOMU+SnAMVNx4LBnPXye+yihQDhgSM9XXLs/oDS331FQXbiXvMlWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771794; c=relaxed/simple;
	bh=dNcfbEn/4dwttuD6duwT+dnalxogOxKSbIawfyls7tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtDc+NOw3+FeFmRJs+O/0nbLOyUxclrOeDUjYlj0W1E475xC9keT0I8ibTzl4JOc2JymABhrE6CHt0xxBRwYHVdTMYxfkMqRlP5+nh9ptQqV79M+Q4bM0cK0AzyUq3VrXTpPJeylg1VfSIUmmQMrJEbWpRlIiw/pjVnRoU6Ph9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t2nYRtGx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b88335dd7so2772799e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717771790; x=1718376590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeBDr4hz46MDwNO029hqLbhPu5de9UVwtLyZV8A2Etw=;
        b=t2nYRtGxE9aAFb/ukNSKwCKzUC9o74+snoq3IgLStY6L+dpw2e6DxbOuetpDq1stD3
         H2VZP8+2eaxKl6myIdO+jua+jHwasvIdn1m3hfNFtLmgxPB/9IRXwHofPaoZ0PuX4yvM
         YjOA3olXMgrDuCUB6F2+qahqUUAmJvprv6Xbh+HotNmBwmfq2XZLqtdTwmocijGngcB6
         flQYsgOiV18Nv1QglqwWoK+aBkcfL9RN1FfFzZ+4gLok3C02eOI+iUjq9N5Ft6USqIfs
         MYInO9drL35HSuYRPCzZd6Usj2K075Joa+WPC/dMG/okJeAL+PQt4WTH0E21TECcj08D
         Odjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717771790; x=1718376590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeBDr4hz46MDwNO029hqLbhPu5de9UVwtLyZV8A2Etw=;
        b=sUO3e/aE0/f1gaiY7cy4xpDS19IEV6hsYy2tXoIl3LjxsffZ13eI2h2pCiHIjjx7rz
         3AV/EKaTZEB5anvyYEUoaisK83GlgGdQdgKn1/qYFsBPyxIfzgX4goP5tQgxoMPaFpKl
         r+fKs5jrWv7bRTTqtpnpS0bpkvMIR06zNUErsx86AfopyfUJ5VO9NnCefEuHTqsNf1lp
         HlJ2nudbnBDTsdzuWXrg7uDmP5AhAt3FzQN5Po2S/BRsZX2BUq4WK9Wo6BXRH+YDRSLm
         4DLiXyRMSfG50ArkpqqHjGtXC3pOJeh1gCjKAJ8R7OJNMvOJOjXWSYs4vWnix17U5VPl
         Vwdg==
X-Forwarded-Encrypted: i=1; AJvYcCWCYszBFZANJItpFkU+3JNDFNVrp3grgng3PWSEvjYJ7McDhiPz/Uz6dG18jQdBvuZ67ubzYX/0HdzCKxQ/S7h1gHOFWHf4crGYMhNX
X-Gm-Message-State: AOJu0YyPmJmYGX2TyoJac3LpXhKypzK/sQUWGWUs4P4u6aGrliuCoZRP
	KIL2ReOvF+3PhAloJbKYpNmeN4KPJ3ltEe5L/2zzCoRGR0vPI/bghwP0xY3qDGA=
X-Google-Smtp-Source: AGHT+IG0AZxjWYuE+muWD8kWSB/kMaubH3h5PiaJkS3Te9HOfhANYploBcOkSprTh7bH9wAMG+Cozg==
X-Received: by 2002:a05:6512:3b99:b0:52b:c1cc:5d51 with SMTP id 2adb3069b0e04-52bc1cc5daamr1208817e87.63.1717771790525;
        Fri, 07 Jun 2024 07:49:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41ee0c1sm557650e87.66.2024.06.07.07.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:49:50 -0700 (PDT)
Date: Fri, 7 Jun 2024 17:49:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Andersson <andersson@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] usb: typec-mux: nb7vpq904m: unregister typec
 switch on probe error and remove
Message-ID: <dltdptcgqtg6ffyajiompniag6otgrib73p4jbiskxaieagjqs@jtqse45u3gh5>
References: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-0-c6f6eae479c3@linaro.org>
 <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-2-c6f6eae479c3@linaro.org>
 <cnqpgfjcqqedk3xqkfbjacjikc5jwktev6c3kwmbq7cwut3eyk@xqyhgi5xgzgf>
 <ac155efa-de85-4bc0-9af3-2190d4d1a60d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac155efa-de85-4bc0-9af3-2190d4d1a60d@linaro.org>

On Fri, Jun 07, 2024 at 04:00:22PM +0200, Neil Armstrong wrote:
> On 07/06/2024 07:50, Dmitry Baryshkov wrote:
> > On Thu, Jun 06, 2024 at 03:11:14PM +0200, Neil Armstrong wrote:
> > > Add the missing call to typec_switch_put() when probe fails and
> > > the nb7vpq904m_remove() call is called.
> > > 
> > > Fixes: 348359e7c232 ("usb: typec: nb7vpq904m: Add an error handling path in nb7vpq904m_probe()")
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   drivers/usb/typec/mux/nb7vpq904m.c | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > I'd say:
> > 
> > Fixes: 88d8f3ac9c67 ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
> 
> I should add both yes, it won't apply with only 88d8f3ac9c67

That's fine. The issue is still present in the original commit. In the
worst case you'll get a 'please backport' request.

> 
> > 
> > Nevertheless:
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > 
> > 
> 

-- 
With best wishes
Dmitry

