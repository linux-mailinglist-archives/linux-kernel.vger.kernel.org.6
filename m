Return-Path: <linux-kernel+bounces-296001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6345195A426
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8D11C20F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9DA1B2EEE;
	Wed, 21 Aug 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1Zes1du"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635631B2ED3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262508; cv=none; b=s2oLn4DpFDTvTulTAUzfXL9gsqTT7pPiEJueOe0QaR2IiAd/EiGSbzgIhtmKe6y7zgqG7tvSTBteMOUEMcsc2z1XOU+5KiRVrzfSWVuQ11wPUMcIF6VEHBKs3o3mGFlloqJwiaH0it32+9rT3yl/H46QanV8oZX9yAtElhbWBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262508; c=relaxed/simple;
	bh=vwmaLh4zcZU9ysYQatGWVZMCBVdhOOp8fnW9VPNyhBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKtwitfJsjoDa6Db/rZABUMjo82A6RwGGIeiu0F5pDm1WAOwrIfrRa0B3Y+Ed15iidxGRgwddVz62CNBr3/V0tCMsuqbFmsd9fIi9bF4+7q5m5gxKyGxkuPzxO0ej5bOFmP+nfwSQmpelBCOtNF1yHUqvYq3MQmhpQSA2QyD974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1Zes1du; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso4621342a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724262506; x=1724867306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2QitwiEuNNARUtd2MSbapEJMilFbV4RH639T4iAGcQ=;
        b=l1Zes1duCr7R4YC2DmpgczbtSW1qYJrSpesdrF0DeW+Yk+lsvyNBhjtf/kDDDVv00g
         //tm9prYrdgxAj6U2XZIQWVv+AncXq0ZUT5n/hIGsGUsUVn3rRyuIBmR8S76l/enA9bc
         IKZVNn9NdY1xEI5f/UMonIeMslVt3aITG7QLF+Ak413GSUb9z2ZxM4B2ZFOKPnWEfGiZ
         lbAJIpUjTemlJUi6iBeOBONag9KfaJeg/l5nz3SJzC9KPw9aYAdCdpKveZhvFvSKMsnQ
         c8Kefx9Q8sZ0j5m3gvaNVpgQo8MEbImER5tK1hIdnoDMWL2IBW5voO81XDQnQmzXsmuy
         D5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724262506; x=1724867306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2QitwiEuNNARUtd2MSbapEJMilFbV4RH639T4iAGcQ=;
        b=eyo64U8YOMZZoU3Vt/RSVeMwth6L1/auvP7UQSxNyvcppPu4ii3TCyS258eKuGGGfs
         lSXPsbh4EWp5zLHccAk1ymQcDx6Vm2I+ju6sQ00YjMesqTZ9MpbC49sLvikFCbP5fZ+9
         7Ijpfr0CUUWiV3oqXxxQIZTzDxOIq1tmlgdFaIx9IRAK+aU2qzGkfaAUfWfUoZY12Lkq
         NPC+86qVN5eyt/Q+OcAv37xA0MEpL2oI0gtQs54CallO2ataKP9Mmt2DUjucXBa0ggd4
         faP1ahGXVnkzUiVSSxqjUUYpneCz4a5JBATJ/hLE+Efe/SmH3PTl5HMm2++P0Sh6uony
         uT+g==
X-Forwarded-Encrypted: i=1; AJvYcCXKADViwGxNCkRXAnIW0+C1hkDgvO6VidLDCro7YXVAqit4Cyk95xCHm5mLJQ7kBf15V8rLQWiBT7WZkvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzDO0Js5PR1nkAFqTTtBVwUnosJkyr5RcGrvg1wfsNDR7/mR0
	cLacy/+rhTav9vgoPVqzXR6qecOEYD+/qj6F2YZe+Imb1ysfU2LG
X-Google-Smtp-Source: AGHT+IHA3fTEXfdi31zERq05Tq9B7V+Rlr4+hXgnN3j/g16WdRD+7L3ipGO6qiUlAiZ/IvKdrYyzxg==
X-Received: by 2002:a05:6a21:178a:b0:1be:c262:9c0d with SMTP id adf61e73a8af0-1cad81a4224mr3879325637.44.1724262506432;
        Wed, 21 Aug 2024 10:48:26 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.234.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71422afda7csm1734551b3a.27.2024.08.21.10.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:48:26 -0700 (PDT)
Date: Wed, 21 Aug 2024 23:18:17 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com, garyrookard@fastmail.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Replace strcpy with strscpy in
 rtl819x_translate_scan
Message-ID: <ZsYoYe+8k0YEyS2U@embed-PC.myguest.virtualbox.org>
References: <20240820184216.45390-1-abhishektamboli9@gmail.com>
 <b2efc687-07bd-462a-b0a5-58e09bde32a7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2efc687-07bd-462a-b0a5-58e09bde32a7@stanley.mountain>

On Tue, Aug 20, 2024 at 10:29:47PM +0300, Dan Carpenter wrote:
> On Wed, Aug 21, 2024 at 12:12:16AM +0530, Abhishek Tamboli wrote:
> > Replace strcpy() with strscpy() in rtl819x_translate_scan() 
> > function to ensure buffer safety.
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> >  drivers/staging/rtl8192e/rtllib_wx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> > index fbd4ec824084..970b7fcb3f7e 100644
> > --- a/drivers/staging/rtl8192e/rtllib_wx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> > @@ -61,7 +61,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
> >  	iwe.cmd = SIOCGIWNAME;
> >  	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
> >  		if (network->mode & BIT(i)) {
> > -			strcpy(pname, rtllib_modes[i]);
> > +			strscpy(pname, rtllib_modes[i], sizeof(pname));
>                                                                ^^^^^
> pname is a pointer, not an array, so this doesn't work.
Thanks for pointing out the issue with strscpy.
> >  			pname += strlen(rtllib_modes[i]);
>                         ^^^^^^^^
> pname is incremented here.
> 
> What this loop is doing is that it's going through all the network modes and
> adding to the string.  You should look at the rtllib_modes[] array and ensure
> that if we printed every string it would fit into pname.  (Currently that is not
> the case.  Probably not all network modes are possible.  But I have looked at
> this code and I'm saying that we should just ensure that we could handle it if
> they were all possible).
I understand that the size of proto_name is insufficient if all network modes 
from rtllib_modes[] are copied, so I need to increase its size.

Given this, would it be better to use strcat?
This would eliminate the need for the pname pointer and align with 
the current code's method of concatenating the rtllib_modes.

Regards,
Abhishek

