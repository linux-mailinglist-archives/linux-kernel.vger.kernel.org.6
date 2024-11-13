Return-Path: <linux-kernel+bounces-407739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651329C7265
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8DE1F20F76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45D8200135;
	Wed, 13 Nov 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXobA+d5"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B8138DE9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506791; cv=none; b=qO0luhnTpEMkNKPriQFCbMemu7qpBBm4fJLIGXbkS3WueuFNzhvpAOfkADvCmLSmTfmlaKkvCzYbW+Cng2P24dqwt9kPwUr+/jJP51bYUdwK7lWNrfwNEFMabkJBMkdxyAQUhqVBklJX8zyXyXXGh42xEsc51rVc649Jyd3lCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506791; c=relaxed/simple;
	bh=eRDM6glYNPJ3JRSGjE8zGy2sCOXwrE90ctHKVf3hhxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYOOeCeHKHBo4SFPNoxUlHS3av2Wd5LAbyRGHxXF6LC7ZDlnwxvoK8GhbYuqrhs/v13im7UEta0t8t9MiQeuF5BYKqH/1oWdkoo6j+AJoGGhHGHRjv0G+74v7txJonP7bl84y0TxhAQDmyUUAgLyNQw4AtZ+SavOwKfuKY8RaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uXobA+d5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f84907caso7863988e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731506788; x=1732111588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UHoqGF0l3GD0aOweZBHSDKHmHKw99KAviUGfHjwDo4=;
        b=uXobA+d50nHfU/aP8f3uJsK/KSMuHtTD3mKeYy6ZJH8qYLOMLF1sRNS2AyH/tz/d8l
         tHNZh5O36Oo8dFE3zAopi1VokSL4CzoGNtTwKH1gHKQ88CAt3go70ifjuD5Nob1M5Sj9
         186tv6demHi5yJHxfsrPJ+hoyVy/DX2/jh74lNYX0dG8ljzaMh1hP9X0g/5TGa8wcCNb
         Pj91MYt+ecz/Y6bslsrQXF2JVZQiHz4kBdp/RGZjwHAL9R45nMmKlfGeceutva4+9KRu
         85uuX3r2XLvPVdMAMDssVSQsdCIgQEVo9O/Y3HdPwHmjBrdh8s6j9pFU5EoqOo2z9Mw0
         re8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731506788; x=1732111588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UHoqGF0l3GD0aOweZBHSDKHmHKw99KAviUGfHjwDo4=;
        b=S7zRtxC8Vb/qUPK41EfMFbZzutkeFXlWPM/FH9FEi69+R0tL6VQhkYqxaZxeSX3V68
         lVZ6/w36/O/5hK9vZkxxaBQPq/dJVGkKUwZOuUw49Ll+BRLpZL/tPxvimnb3l70OBQdI
         nuGWU8PTHi6rGG21tDeY3QqZRN89xrr/JaU0P31DBQYwTlrkBvGXErr/2LDWJ66aUhx6
         1VXRtjlLcVXY8MLNX4W+L0amNzMEDVFESglSFd1+27diix+mEh1G9HEGkYwuwsW+WMVh
         3sdD6WZM708HKDTa5AGGkUxecdKYpZo45WQwEcHb0ClRAbLIVvC8JUdaM1dRvsm6gg04
         ZR9g==
X-Forwarded-Encrypted: i=1; AJvYcCWkJGKgNT2HahqhL9XKv0OwiLu2ZcAJIzesa9O5xsZPt7yRr4QLX/YfeH5K/SzEIk3n67yu969PgcjK9lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy03WN2Jlyt+ylzo2Wr1+uV5A0kR2Cjbp36Fdd0RE12DH9hGf+
	hA+g1pgBEQJEn29EbBLig26y559sAYfwrwZn6xuESwddh9peWWCy4GSq0E1zPdk=
X-Google-Smtp-Source: AGHT+IGc5jEArT2BsF6zReSswVNVhl7F1+SW1eg++sx7YhaW7IQQvQ1DgvHdR9iSCclM1XFzIp7s/Q==
X-Received: by 2002:a05:6512:3c96:b0:53b:1f90:576f with SMTP id 2adb3069b0e04-53d862c5c4cmr9786278e87.22.1731506787427;
        Wed, 13 Nov 2024 06:06:27 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5541824sm25621365e9.31.2024.11.13.06.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:06:27 -0800 (PST)
Date: Wed, 13 Nov 2024 17:06:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] xfrm: Add error handling when nla_put_u32()
 returns an error
Message-ID: <ae4f3c01-2cd5-4ac1-acdf-ba70a47c3bfb@stanley.mountain>
References: <20241112233613.6444-1-everestkc@everestkc.com.np>
 <20241113105939.GY4507@kernel.org>
 <81088611-41d9-4472-94e6-3170418156c9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81088611-41d9-4472-94e6-3170418156c9@stanley.mountain>

Here are the relevant lines from my email generator script.  The script
greps to see if netdev is in the CC list but wireless isn't.  Then it
looks up the FIXES_HASH.  You have to have to have done a recent fetch
obviously.  My process doesn't work very well for patchsets.

regards,
dan carpenter

if grep -q netdev $MAIL_FILE && ! grep -q wireless $MAIL_FILE ; then
    if [ "$FIXES_COMMIT" != "" ] ; then
        if git merge-base --is-ancestor $FIXES_COMMIT net/main ; then
            TREE=" net"
        elif git merge-base --is-ancestor $FIXES_COMMIT net-next/main ; then
            TREE=" net-next"
        fi
    else
        TREE=" net-next"
    fi
fi

if [ "$TREE" == "" ] ; then
    if [ "$FIXES_COMMIT" != "" ] ; then
        if ! git merge-base --is-ancestor $FIXES_COMMIT origin/master ; then
            TREE=" next"
        fi
    fi
fi

git format-patch HEAD^ --stdout | sed -e "s/Subject: \[PATCH\]/Subject: [PATCH${TREE}]/" >> $MAIL_FILE



