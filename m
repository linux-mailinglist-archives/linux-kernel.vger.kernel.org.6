Return-Path: <linux-kernel+bounces-377642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D7D9AC1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16F51C240C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D815B0EC;
	Wed, 23 Oct 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxABMWm2"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881E153838
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672517; cv=none; b=EN+zmRePW1s+zojqt07yywMdg2UOkrcscRfSl8rj93l+ikAzMCdUamRjkflXNZ/XdEZPElxACYrrDrBA2TxOE/QfelIMn2rpB0/eeZ6siPP+KyvFtBqeN2Z3wT8BoT+670U80HBeKSCLw5cVjhZKOdGfDedNNoYAd3BNUAYHtjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672517; c=relaxed/simple;
	bh=asnLS+EmH7yhaFNpb7qccfRX1olrMIisDu1X+wRh2Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3PPgJKgyzp/O6TFA8ijsqMBR5Bfmj4VfO+sOzX0gEiRPzI/53p463Dlv6qZq+rM31TuCYeD5EfQX1DRrT11HNxgyEMW1o5GeKbK+2+Rd047l2qgKEY/swGBVQU5QYDzyDkPfJ4swvAWL0VZTnaW5ZDDHqSfIueHxpUsiIKar0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IxABMWm2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so45853895e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729672514; x=1730277314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pwg9xrcCt0istZyNHx+xNVxgZiXZ5ztml68Y6uwKbU=;
        b=IxABMWm26/wnTHe+MFcSt7teFBMEjUwo/xF/G47+XFILVUq8X34V4Dn5imwUD0SITt
         6MW2/nlhH8Y/x8l1oTPR56ZSjelh32Q0CYah+rxqPi00GCNAxgnc5RZD7PWoDXu/QTNG
         ic+T2Xm01sLvouO3HOtQszRGRSnzxQ+TFZxDTq6Jq95ctIWTin+HsgLW4N0FGyRRblyZ
         7OI5qfagie0pnqLG9gdI1md3trSxpj/GahD8eqa01U2fduy4Y1BAniaZNvZZ8Woae82J
         yWG8i9AYLGo5X7YpYVeWu5dw0UkyMzf0t8TaNmZnIaBYMw7M35DRQPmfndqNl9f3YcaM
         Qspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672514; x=1730277314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pwg9xrcCt0istZyNHx+xNVxgZiXZ5ztml68Y6uwKbU=;
        b=t1AWknuDfxTjjtGbpO05fUH52NqQYztFGMcu067pIFdQWVCigzDF2t9bcP16wdNnin
         xAqVdnn++H0jjVKBHOdBeZsBx/iC7InlyhSElNOXnrKkVuNom9dmONAVf86s1pWdrP8Z
         4L94JBIaBwIyIYXMhzEy4Mar2tTKlorglCzJ32Mq8+gUacasRTYl/9HCWktdmzVkU70C
         Wx+j2fnSndIfugXjNOOlOq7KoclCUedi3PpATMVb3Xh01CEkNM/owM5qvnf1ZrrKA8We
         0BfHJjGwcuUgHq/l106GHJcJQjbEzWjIM2erx/ZJ6itMliBtpkM7DlX2mduJPpGbVxDk
         RjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoV9SMz/b34ikhVEJu7sDHl3Fl49AyFROKaupNX5sXKQp+ciOe/8X8lsKhcroLeV9kdhk6M33Gg+20cGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPzeouFOnlgYZF1UrcahjNga5w2LlYmoCbvz9j6rG87voFtu9r
	UauHiH+upLduz3rmAYu3UDtYkyeSq4yg70FUA9RVrs9QvPKj0M+Su2u4BV2/blg/VVUBMOd3ewQ
	oUTs=
X-Google-Smtp-Source: AGHT+IG6BfYRaxuQt+TZH1fYAiwXxf8JZ6zQWto1UJUldW2JmsaSAInHWPIkYLQ8xIlIQ44Z5SXl/Q==
X-Received: by 2002:a05:600c:3b16:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-43184198a99mr13532065e9.23.1729672513733;
        Wed, 23 Oct 2024 01:35:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c50947sm9710115e9.45.2024.10.23.01.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:35:13 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:35:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] wifi: rtw89: unlock on error path in
 rtw89_ops_unassign_vif_chanctx()
Message-ID: <2e85c84b-31bf-484b-b3e2-9285999bb2e4@stanley.mountain>
References: <8683a712-ffc2-466b-8382-0b264719f8ef@stanley.mountain>
 <6a80d4adc51f4ea884b5e02f16d8aaed@realtek.com>
 <931c79c15bc04be99bb87a9826cf2b04@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931c79c15bc04be99bb87a9826cf2b04@realtek.com>

On Tue, Oct 22, 2024 at 03:32:23AM +0000, Ping-Ke Shih wrote:
> Zong-Zhe Yang <kevin_yang@realtek.com> wrote:
> > Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >
> > > [...]
> > >
> > > @@ -1373,6 +1373,7 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw
> > > *hw,
> > >
> > >         rtwvif_link = rtwvif->links[link_conf->link_id];
> > >         if (unlikely(!rtwvif_link)) {
> > > +               mutex_unlock(&rtwdev->mutex);
> > >                 rtw89_err(rtwdev,
> > >                           "%s: rtwvif link (link_id %u) is not active\n",
> > >                           __func__, link_conf->link_id);
> > >
> > 
> > Acked-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > 
> 
> Thanks for the ack. 
> 
> Acked-by is often used by the maintainer, so I will change it to Reviewed-by
> during committing. 

To me Acked by just means you're okay with the patch.  When I use it, it means I
don't feel qualified or interested enough to do a full review.  For example, if
I complain about a v1 patch and they fix my issue in v2 then I like to say that
I'm okay with it.  In that case I'll use Reviewed-by for a full review or Acked
by if the bits that I care about are okay.  I don't like to complain and then
just go silent.

In the end, it doesn't make any difference.  You'll get CC'd on bug reports to
do with the patch and you'll potentially feel bad for not spotting the bug, I
guess.

regards,
dan carpenter


