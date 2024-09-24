Return-Path: <linux-kernel+bounces-336672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B04983F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0583282324
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C2814601F;
	Tue, 24 Sep 2024 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yb/DFUhu"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946DB6E614
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162789; cv=none; b=i1n5iAYSMKsFF6Uro9P7z6Wt6rAxCSj29yO715FXABrkD2zcTeoMQlmnriQvmD0HjwrCpjtI+/bt3ew0feUBxfUJ7EpvOSNeWBCaoK6QTigkkVz/kvl6JG3I2fjQDlZ1+v10kAfBA9F0e9W0vzmb1TyUvdgOHzMQpRyv7Fuxuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162789; c=relaxed/simple;
	bh=DyTKiRIuOe5S7r5x1ITrlHVyDwuMn93F3mkinUyk8Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyCW3UsTsr6q1/Nc86J4t5mNtyVrQWCc1U0NyIFNjtpp6zjqRW4lDK32jHhFe1RCWcV6LtCA1+SIB6jD9TZGicXvDj1fXUiHIGJun4BMQdLIdNb4Q0pSgDoiLbPDwSka4rzAXbQmafv6TNhWJr5Z2gWTqeWcEdxTeoYvPFBVOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yb/DFUhu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb806623eso44181395e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727162786; x=1727767586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAwczMCanQ0yFyxbvc+noYCID3f4HS/SOLyLulvvpdc=;
        b=yb/DFUhuCK34KSG7VDYRwIR1mTkqyPVR60G/kjl75h0B6IVunjK5PyUtm5crvzV7iy
         xsvNcfBE4U69dGMV6I0HQZ63HJzyvmyUbDILmG8lLPOLFwU5WJBvhyzC9djJMF0uBJfJ
         q8zDwu+W5ECIMGEmIMM5+QoOv161Ev3qL0yIcUSYL8FPgJa6XJZDc25N0f/yQW9FsN3c
         PaK7M9AbN/cvfsZg0SUtD9t4Bj29tSVMQPhGSrdo0mLO24+wwGkWkP0EDt4OHrCjr6DR
         l/AihacRVptm9iyvWbr4vQ+ndO2yhauLm8VK+chYfIoNwRGyG5Y9G+oiYXQc25qnAP4j
         +JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727162786; x=1727767586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAwczMCanQ0yFyxbvc+noYCID3f4HS/SOLyLulvvpdc=;
        b=GgZ1DcFAG5rmE7T0kWcqE9DtZuLV26wah/O9YOvAqX0TcnAJagXl/MlHXDLdXmUTzC
         gSNqHqqVRCKcbsOo2AKbCdTiUJ9B7+Pn1YK3S+QMxGjxVzXmlZXrCbhXzsgjSXOWaefH
         vM4NTR7djJmXD7ACidxAFS6AUIB1a6t2mIlF5hLRvy801fIZIExrRK2nXAQbSFqUVPEV
         GPGS/O9++KpKMwUPsDm5bO2RqNNJsW5WJRC+W5i1o8bDsNNDUYFwcay3vnO7UOyzY0II
         ETJHzupQiiZVBmkW4gD8NlGrvLY+7b5WENJ47MtFh0P7AfC8kdsVNvssOzfR/1+8mXe8
         WoVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwd5nSRqgKNzWyC6itaen6WNN7qgmIhSHbBy/E/XwEeC5cKFKkD3vhT2KVXd5VLuLRf/1N3ZqF2wWJh+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGjGsKXk8+Yy6K1DPPwCSsILv8+BnLZnEGk65JbWCQuEi11P92
	D9HnhJUGq0wvRK70IxoCW+eR8D3ZseU2L8H/CMGCteSlhu9cNHMXp79iYR0VvgQ=
X-Google-Smtp-Source: AGHT+IHlnvC9pPK8OU5nIyUxrMM24qVz/hHE1cqLn3YBhe/2YttHyA4BIVkMJbKi7vbadpavoyb3Zw==
X-Received: by 2002:a05:600c:3c87:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-42e7ad9dc04mr89513035e9.30.1727162785961;
        Tue, 24 Sep 2024 00:26:25 -0700 (PDT)
Received: from linaro.org ([82.77.84.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754a69a7sm147970255e9.34.2024.09.24.00.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 00:26:24 -0700 (PDT)
Date: Tue, 24 Sep 2024 10:26:22 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Johan Hovold <johan@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] usb: typec: Add support for Parade PS8830 Type-C
 Retimer
Message-ID: <ZvJpngJaav9Rb32k@linaro.org>
References: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
 <20240829-x1e80100-ps8830-v1-2-bcc4790b1d45@linaro.org>
 <Zta6cBq881Ju7r7H@hovoldconsulting.com>
 <Zthet0QqChgGWJAe@hovoldconsulting.com>
 <ZvGMCTPqBR0VuHd3@linaro.org>
 <CAA8EJpqq9ROYyTnwPwj+mX2T_422vcmcyzPta+QPL53EgtJ6vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqq9ROYyTnwPwj+mX2T_422vcmcyzPta+QPL53EgtJ6vg@mail.gmail.com>

On 24-09-23 18:03:09, Dmitry Baryshkov wrote:
> On Mon, 23 Sept 2024 at 17:41, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > On 24-09-04 15:20:55, Johan Hovold wrote:
> > > On Tue, Sep 03, 2024 at 09:27:45AM +0200, Johan Hovold wrote:
> > > > On Thu, Aug 29, 2024 at 09:44:26PM +0300, Abel Vesa wrote:
> > > > > The Parade PS8830 is a Type-C muti-protocol retimer controlled over I2C.
> > > > > It provides both altmode and orientation handling.
> > > > >
> > > > > Add a driver with support for the following modes:
> > > > >  - DP 4lanes
> > > > >  - USB3
> > > > >  - DP 2lanes + USB3
> > > > >
> > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > >
> > > > > + retimer->supplies[0].supply = "vdd33";
> > > > > + retimer->supplies[1].supply = "vdd18";
> > > > > + retimer->supplies[2].supply = "vdd15";
> > > >
> > > > vdd115?
> > > >
> > > > > + retimer->supplies[3].supply = "vcc";
> > >
> > > I took a look at the schematics and it seems like all but one of the
> > > above supply names are wrong and that some are missing. "vcc" also does
> > > not exist in either the binding or dt patches you sent separately.
> > >
> > > From what I can tell the supplies are:
> > >
> > >       vdd             1.15 V
> > >       vdd33           3.3 V
> > >       vdd33_cap       3.3 V
> > >       vddat           1.15 V
> > >       vddar           1.15 V
> > >       vddio           1.8 V
> >
> > The schematics seem to suggest that vdd, vddat and vddar are all
> > supplied by the 1.15V supply. As for the vdd33 and vdd33_cap, their
> > seem to be supplied by the 3.3V supply.
> 
> Please follow the datasheet when naming the supplies. Some of them
> might be supplied by a single rail, but that might be a property of
> your platform.

Fair enough, then will use the ones Johan listed here as those are the
ones the datasheet lists as well.

> 
> >
> > >
> > > Also, have you checked that there are no ordering constraints between
> > > the supplies?
> >
> > The documentation seems to suggest that there are some timing as well as
> > ordering contrains, yes. I can't tell for sure if that is really needed
> > or not.
> 
> Again, please follow the datasheet.

OK, will drop the bulk, will use simple get instead and add proper
timings according to datasheet.

> 
> >
> > Thanks for reviewing.
> >
> > >
> > > Johan
> > >
> >
> > Abel
> 
> 
> 
> -- 
> With best wishes
> Dmitry
> 

Thanks for feedback.

Abel


