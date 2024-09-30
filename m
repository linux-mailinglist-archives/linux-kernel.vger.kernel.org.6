Return-Path: <linux-kernel+bounces-343562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C729C989CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D8E1C2192E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2B1174EF0;
	Mon, 30 Sep 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALvq3RJU"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652F1714A4
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684491; cv=none; b=HrdBId4LaUf4RI9TCt6eYUuj/UyL99NJyJkq/ljR3f5iVB4VblNTVdoC5R8oQOd0CfhqYCvhcBKoeHxk5E3n7FnaM5ZH6mY6hcVH/Uq4PPIci6PURX1HHN2U7cL84az2EeMZDcQdEPorQmV56n4wHOjQqoHE0G5ClxCT1A+jm7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684491; c=relaxed/simple;
	bh=p5isOWxMgjO6Sc3TWMN/idYkcjeV+whb/4/Df26N0c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC8XT/1mOvYt3Glsws/tXr3ketZpE1qbzbPFJzdYsnUKiRmQUEf9vK2ULOSe3UzIHyypTINbrA7uDDfRvCZvMxYO3+jaSXnpTwrEZXYhmTh2VMKQn9neFkd+3YFY7wcUrcgc3Hm9+qagpCXkUU0HKHEBTTgcYayP0p2HderJ3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ALvq3RJU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so402089466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727684488; x=1728289288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xkt+WMnfLpn5WSjSIWKAP+K2wOoddac+r97jKObN8dg=;
        b=ALvq3RJUL/eyszxGkobBF4ROLHwRIX//mHf4S2Rpfj4D8xeIp2j/aKNzB9bspQR2OU
         D+OXr5BUzoSWvsfXFMMbqB9QA6z/cz8qzgIPc1n5X+ybABcOgRJwvALmBdcbSWJXoOW1
         Z9ZHC2PEWXjW9jGg2++YsoK/DMTfzapc+Eu0L2eSsIiBSDvpcE1QwUFZ7/S+rlY8Y6sr
         s0hXd12xsPdvvN9fzRS0D737FoCYOP3dYksc+MxN6tvuo7h1zE8VfifmeptJ65ZibtS4
         aNL10ny9LcA0Y1ADu2ZjZs02JG+fUHF//zG9bljEFJI4HeiDThBt5zy2V2Nm8QVM1wvu
         PqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727684488; x=1728289288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xkt+WMnfLpn5WSjSIWKAP+K2wOoddac+r97jKObN8dg=;
        b=RTpdj/f+sxGTC8C74MOvgUtyl89ClqyeZjTImk2QklTh2s6IjfPphxGceT4J498tMr
         2t/IPBY1imiKg2RundAv2+/na4qeJYHG7QJAIMa7gajigA1bRCNT7LSoXdEdhcKKu7NV
         42zUOoBZZU8Ne/T8/G57mhSEMxPKUkrtS8ZgEJYwiLm5Jmnz6FurLVZj4KiOGThYQz3z
         Osu9PmeWn/nMGIYscyWFWR+5fEe/m7VOy+q9prhXGep3069h1kAE+NosE8ohwpTwmJHJ
         xjCxYv7edckAmf2HLlmF0b1AW9Pg1OrrxqtsFv04T1ot41zQEsU9IDW7USjJ8M0J1IgQ
         LSyg==
X-Forwarded-Encrypted: i=1; AJvYcCWNtxbQlnckJsonK/Ll9/g5u5IpbWYpCkTV750Y6rQ6sV54cw9C9xsSHGyn9HB/+uWai1yy/ZuandOx8NY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/D/SGxCLnhXUu5/JQzwBdZBePyLJzuF6dja/XzZ+HpB0C1qR
	qFkB7uBAJmDSn2uqepNnToIkzhBS31A2y4OkG9fegWLeeXKbzai0lebeB83sQpM=
X-Google-Smtp-Source: AGHT+IGj9kDzTZrGEc7mBzO2pItthsAhNW+Y0CeRuOhEKM2DSvfxOJpzWiSpzc7S8W0OF1VlWfdofw==
X-Received: by 2002:a17:906:6a07:b0:a90:3517:6b1d with SMTP id a640c23a62f3a-a93c4acab49mr1261892766b.48.1727684487541;
        Mon, 30 Sep 2024 01:21:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2945f2esm490403566b.117.2024.09.30.01.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:21:27 -0700 (PDT)
Date: Mon, 30 Sep 2024 11:21:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	konrad.dybcio@linaro.org, andi.shyti@kernel.org,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	conor+dt@kernel.org, agross@kernel.org, devicetree@vger.kernel.org,
	vkoul@kernel.org, linux@treblig.org, Frank.Li@nxp.com,
	konradybcio@kernel.org, bryan.odonoghue@linaro.org,
	krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 4/4] i2c: i2c-qcom-geni: Enable i2c controller sharing
 between two subsystems
Message-ID: <42e0622d-0bb6-4850-bf5a-629996c702db@stanley.mountain>
References: <20240927063108.2773304-1-quic_msavaliy@quicinc.com>
 <20240927063108.2773304-5-quic_msavaliy@quicinc.com>
 <lmo4jylfwt3wingdqb6zc6ew2537kqksuckfyd7vwuu4ufg5cr@ic2j7bv2r6e4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lmo4jylfwt3wingdqb6zc6ew2537kqksuckfyd7vwuu4ufg5cr@ic2j7bv2r6e4>

On Sun, Sep 29, 2024 at 10:46:37PM -0500, Bjorn Andersson wrote:
> > @@ -602,6 +603,7 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
> >  	peripheral.clk_div = itr->clk_div;
> >  	peripheral.set_config = 1;
> >  	peripheral.multi_msg = false;
> > +	peripheral.shared_se = gi2c->se.shared_geni_se;
> >  
> >  	for (i = 0; i < num; i++) {
> >  		gi2c->cur = &msgs[i];
> > @@ -612,6 +614,8 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
> >  		if (i < num - 1)
> >  			peripheral.stretch = 1;
> >  
> > +		peripheral.first_msg = (i == 0);
> > +		peripheral.last_msg = (i == num - 1);
> 
> There are multiple error paths in this loop, which would result in us
> never issuing the unlock TRE - effectively blocking other subsystems
> from accessing the serial engine until we perform our next access
> (assuming that APSS issuing a lock TRE when APSS already has the channel
> locked isn't a problem?)
> 

Hi Bjorn,

I saw the words "error paths" and "unlock" and I thought there was maybe
something we could do here with static analysis.  But I don't know what TRE
or APSS mean.

The one thing I do see is that this uses "one err" style error handling where
there is one err label and it calls dmaengine_terminate_sync(gi2c->rx_c)
regardless of whether or not geni_i2c_gpi() was called or failed/succeeded.

regards,
dan carpenter


