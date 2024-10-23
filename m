Return-Path: <linux-kernel+bounces-377546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D860B9AC04C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E724CB23E28
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3A9156883;
	Wed, 23 Oct 2024 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnzPosid"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19F156644
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668736; cv=none; b=i4KbmVBab/8CW+OElArK06K8ljjK1grYeWCdcmN0XbSFuuuzhXHfHFyBnb7zDo7UY1qNWFDmS1YU11o+o7wOSk8+Vh87ka63A8k3RRSsHg7Mi9YdU+Hu4pXmqyZM3t22r9SiHA494led3Dq9MQ5XKnHjIKj7FnpAAi17UK0wmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668736; c=relaxed/simple;
	bh=UG6ihVAcJ5pYreWh3xW3jBvz7qOrrWyU52nZm6ikEK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmq1R4CKmWNCirshG3EfgW/hp5ma70ruhL5rxwaHel4EbRjlxNRfUFljLvSCN9FrvUNR59qWXeYbmdLOIM8YMpzi+69aglPYSUm2euQKL3d7IR35RplbZU9fjvWa6+HdZuIDYzyvYMsrJDxhuT3t0FW39qpRA53yb5qev36S7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rnzPosid; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso5121337f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729668732; x=1730273532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ByOuflTVuw6FqNFCU6UPV6W286vup+uWGJ9ZYP4mkM=;
        b=rnzPosidsZfkKP9K0Lvs+r9sC6NLuAmZf0Bz99r3WvVrlT3tJt1Um0S/JhhOL2DBmi
         UfpsTzFMXricAvlVtD95Ra5TetnGrGG9nuQqO70H4idTM3rTtqe8LN8gvYex/qa5b36M
         6zuOEWgrzeYOWvLDJmeBp4O9mfK8dl9JebGzIj+cbg4jQ7zwjoRVF7hd6bEL0dlex+mp
         +CAGNr5eDHPuJBRwnV1Y9lFuFImrgXK07ZJiEGw/AOyKUp4mAN1k6FAehreau6PQG24K
         jbpe12thcixDm9hTbxLc4DgQqJdZ7iEUciDfabUXTPZURSGhZWS7JELA8pOZyagWMRNC
         eQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729668732; x=1730273532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ByOuflTVuw6FqNFCU6UPV6W286vup+uWGJ9ZYP4mkM=;
        b=aSoh3ws1L5YN1f7H6GT1uRRxkLIf5FFVbrEQ73dEpRukuXTYJdI0ODrKUqNpXrBX1a
         5Gs9JnVsPStVYLmYhequX46BhnlxkgJ24NA1FRvuMkrg/1jQhjJO6LbHqbgGQV3gD+jp
         Odg/Esn2/i3T4wZCjcAa4kfAGGo+owEr1K1cY4r8wR7aQJFxP94vnFcaqL8WHZjuj5ao
         0T/07UFWQSZl56PK6Z4cUMmFly9EAQuBboZJd+WvxYZVolefLJUqmge95BEsrO3rKg3w
         illNfs+iEFSanKLj7xg9sI5921wA5k5DIoRvB81fFEosOF2Jy+Urakv9b0ouQ1vk3ydq
         W1ag==
X-Forwarded-Encrypted: i=1; AJvYcCW8QbEZz08NPmrUt1MLafUwQglJ9GPAVG2FTBEal23VpB/40w3WIwihu5SMHRaWGD5PsddJKfhtGv0Vf8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvslNnj814F38lztIvzAHBMAJKwHVa7wiao9I5zfIyPSJiWk7z
	lrRqAZ3Nh8M6jyoHB9BV5r8rkuZet3xTpKN52Kv4JvfXNwQrOGhDbGyA7F8MC/1O1h9mzbWelp0
	D
X-Google-Smtp-Source: AGHT+IHjIA8gmyjHXms77rT5Sn14lEAq7Alni4DB4J5+vDcwterfp4ljbKgcAnTOfUwgEtKEJq9FJA==
X-Received: by 2002:adf:ea46:0:b0:37d:529f:ac1e with SMTP id ffacd0b85a97d-37efcf9c1a9mr938910f8f.53.1729668732225;
        Wed, 23 Oct 2024 00:32:12 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4ac2esm8276357f8f.44.2024.10.23.00.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:32:11 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:32:09 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: Add support for Parade PS8830 Type-C
 Retimer
Message-ID: <ZximeTNi7huc95te@linaro.org>
References: <20241004-x1e80100-ps8830-v2-0-5cd8008c8c40@linaro.org>
 <20241004-x1e80100-ps8830-v2-2-5cd8008c8c40@linaro.org>
 <Zw5oEyMj6cPGFDEI@hovoldconsulting.com>
 <Zxdp2vHzREJAFkwj@linaro.org>
 <Zxif6vmh8BE_C-_n@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxif6vmh8BE_C-_n@hovoldconsulting.com>

On 24-10-23 09:04:10, Johan Hovold wrote:
> On Tue, Oct 22, 2024 at 12:01:14PM +0300, Abel Vesa wrote:
> > On 24-10-15 15:03:15, Johan Hovold wrote:
> > > On Fri, Oct 04, 2024 at 04:57:38PM +0300, Abel Vesa wrote:
> 
> > > > +	ret = ps8830_get_vregs(retimer);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	retimer->xo_clk = devm_clk_get(dev, "xo");
> > > > +	if (IS_ERR(retimer->xo_clk))
> > > > +		return dev_err_probe(dev, PTR_ERR(retimer->xo_clk),
> > > > +				     "failed to get xo clock\n");
> > > > +
> > > > +	retimer->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > > 
> > > The reset line is active low and should be described as such in DT. So
> > > here you want to request it as logically low if you want to deassert
> > > reset.
> > 
> > This is being reworked in v3 as we need to support cases where the
> > retimer has been left enabled and initialized by bootloader and we want
> > to keep that state until unplug event for the cold-plug orientation
> > to work properly.
> > 
> > On top of that, we don't want to deassert the reset here. We do that
> > via gpiod_set_value() call below, after the clocks and regulators have
> > been enabled.
> 
> Ok, but you should generally not drive an input high before powering on
> the device as that can damage the IC (more below).

This is just not true, generally. Think of top level XTALs which feed in
clocks (and can't be disabled) before ICs are enabled.

> 
> That is, in this case, you should not deassert reset before making sure
> the supplies are enabled.

Wrong. Even the data sheet of this retimer shows in the timigs plot the
reset as being asserted before the supplies are enabled.

And generally speaking, the reset needs to be asserted before the
supplies are up, so that the IC doesn't start doing any work until
the SW decides it needs to.

> 
> > > > +	ret = clk_prepare_enable(retimer->xo_clk);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "failed to enable XO: %d\n", ret);
> > > > +		goto err_retimer_unregister;
> > > > +	}
> > > 
> > > Should you really enable the clock before the regulators?
> > 
> > So maybe in this case it might not really matter. But in principle,
> > the HW might be affected by clock glitches and such when IP block
> > is powered up but unclocked. Even more so if the clock enabling
> > (prepare, to be more exact) involves switching to a new PLL.
> > 
> > So clock first, then power up. At least that's my understanding of HW
> > in general.
> 
> I think you got that backwards as inputs are typically rated for some
> maximum voltage based on the supply voltage. 

Yes, but that's done at board design stage.

> That applies also to the
> reset line as I also mentioned above.
> 
> What does the datasheet say?

As mentioned above, datasheet shows reset asserted before the supplies
are being enabled.

> 
> > > > +
> > > > +	ret = ps8830_enable_vregs(retimer);
> > > > +	if (ret)
> > > > +		goto err_clk_disable;
> 
> Johan

