Return-Path: <linux-kernel+bounces-200622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AB88FB280
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416E328330E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A46146596;
	Tue,  4 Jun 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tAOJBFRc"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C9146585
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505112; cv=none; b=AXc88JkEXSkDJriAbiX2rnxyNqzRO8FtSAmMoECOvvPb7SKzWaKinsNSQ9w2UILo+mBTpdeIVH+3RnzG6EtjyKHNBAmuFnBx2bGCPlN93abWRzP33r+mT/J9Qr+FuB9pcZnXdH5FsTp27G+WHqGUB6KKSeU3w4N0DUf8GEahv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505112; c=relaxed/simple;
	bh=FS2meUHyqAFzj3ZwOILxZCEhyOYL5YlmGh67XCjBmN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGOj4xgAgUby+FR3Ft5p00Qa0S36BpcW7u5tYFbS8BmJd4igzMj61FPTlOzRjOX2sgxXsJO/5NntpNHnx3TvxleePatQrNyiaqRT2gHmjsidyGtTlWQpxCSX4+BpzyZd01GIfYnqWzttGldI4WHMzIYwcjiW3cMIb0sVf4jyTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tAOJBFRc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b82d57963so5761321e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717505109; x=1718109909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTSWP21QZ+eqjBfIIWcv/YErfD1pgnAWKFQYJnk3e7Y=;
        b=tAOJBFRcY4EiEdYTyDUAVO94+G93of9ZvNso6zHXIUd5Pl9WfuWYHaw9XYhGgckoti
         /lBwwNiUTZuOZyqu914bqRJ7Yvj77BfVvVIfb1FZSeYB/jh7SH4isRR7/51prRNt9mGu
         1QfBZGzFIeRh3MBICIhd6/9XCxMvh4VeQILTLDRGjEifSnlYhLAxrwpdW/PTZsOGPWBb
         PV83iz54qnbqdPNwBEdLIvoC9E3/M5/MB/Wq4+2Do7Av+pW9HITL3SWp200mhm8MihLH
         Iw9RBrA2ZAAEKeQMVkaVk3MiB3vMqWQyV6dcaJ8u8iK/Gmf1vxh63G4IloKlHI2F2YNY
         mq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505109; x=1718109909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTSWP21QZ+eqjBfIIWcv/YErfD1pgnAWKFQYJnk3e7Y=;
        b=ncrv63ca0SKOBNQVLSbPxWlEoh8O+AnfA64hoN1Q07gKB71Hi2H3oizz4tp9jfDHIs
         IRbDMpzw9FhFhKR6q0x9IT8x4J1uK3j5apQDC8VhrvN23KXn7COcfGnYy1AQF0t/VoSq
         RBCDOJnwTGg6vCPKwJOG141lyDKxphb97DJdcA+GDCGTgasXkLa8yUcg0K6gu4TMSI0C
         AtZgtLUqOhNYOsk6/aB04UUuUOIDiAMj8xBf1LEAkQkNWXgSo1zoQZutHVFu1YyF39ku
         zgR28Zrbh4cKKndjsFttNP/o3Ssis01WWyJyyzqp4iuq6sNhYsZQ3kg+EBnacpZ7QzV0
         yNkw==
X-Forwarded-Encrypted: i=1; AJvYcCUByt7FRUgco/fL9JUUuUTYqLbthdTn7RzxlEfIyGRMX3XReu0wLWp3rGJKYs1v3XztWJ1EKUVKxLQXKVz38f/7Uy2zf3wEeZ5GFdDw
X-Gm-Message-State: AOJu0YyJHBFtj0b6lDXQz/Cv427UVsoiX9EN7mcbla1Nx5a9xHmQneFv
	GnJaKQEscmGXIPFqlX03cnsc4kIDgXgCmY0Nty3MC9DChdr9PL3IURdXHi0LCFE=
X-Google-Smtp-Source: AGHT+IFm2FI2pRnzHQ9nL48l/MAYYryy+SOdMrgt6P5LxDtGzf5oycvSKJISwo5n1Y/8T5hXK2lPng==
X-Received: by 2002:ac2:43cc:0:b0:524:339:4375 with SMTP id 2adb3069b0e04-52b896b69eemr7446350e87.40.1717505108618;
        Tue, 04 Jun 2024 05:45:08 -0700 (PDT)
Received: from linaro.org ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68519892c8sm587367066b.65.2024.06.04.05.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:45:08 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:45:06 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100: Make the PCIe 6a PHY
 support 4 lanes mode
Message-ID: <Zl8MUpfy/2Khw+wD@linaro.org>
References: <20240531-x1e80100-dts-fixes-pcie6a-v1-0-1573ebcae1e8@linaro.org>
 <20240531-x1e80100-dts-fixes-pcie6a-v1-2-1573ebcae1e8@linaro.org>
 <Zl28nvnpGFRsYpGh@hovoldconsulting.com>
 <d93fe55e-7c65-48cb-bdaf-5e15bc22be30@linaro.org>
 <Zl8GoRoY9lXRtg2R@hovoldconsulting.com>
 <402aa998-8b3c-4c3c-8dcb-f128b6ddac46@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402aa998-8b3c-4c3c-8dcb-f128b6ddac46@linaro.org>

On 24-06-04 14:38:40, Konrad Dybcio wrote:
> 
> 
> On 6/4/24 14:20, Johan Hovold wrote:
> > On Tue, Jun 04, 2024 at 02:00:10PM +0200, Konrad Dybcio wrote:
> > > On 6/3/24 14:52, Johan Hovold wrote:
> > 
> > > > As I just mentioned in my reply on the PHY patch, this does not seem to
> > > > work on the CRD were the link still come up as 2-lane (also with the
> > > > clocks fixed):
> > > > 
> > > > 	qcom-pcie 1bf8000.pci: PCIe Gen.4 x2 link up
> > > > 
> > > > So something appears to be wrong here or in the PHY changes.
> > > 
> > > Is the device on the other end x4-capable? Or does it not matter in
> > > this log line?
> > 
> > Yes, of course. It's the CRD as I wrote above, and you can tell from
> > other log entries:
> > 
> > 	pci 0007:01:00.0: 31.506 Gb/s available PCIe bandwidth, limited by 16.0 GT/s PCIe x2 link at 0007:00:00.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
> > 
> > lspci and what Windows reports.
> Ok, good. I was scared of double-sourcing of parts that are not identical
> in spec..
> 

On my CRD, there is a KBG50ZNS256G.

> [1] suggests this wasn't ever achieved.. which makes the cover letter of
> this series a bit misleading..

True ...

> 
> What does the TCSR check return? If 0, can you hardcode it to 1 and see if
> the link comes up at x4?

TCSR check returns 1. But that is not enough. The PCIe controller needs to
handles some stuff about margining. See the following patchset.

https://lore.kernel.org/linux-pci/20240501163610.8900-3-quic_schintav@quicinc.com/

But even with this, I'm not able to get 4-lanes mode to work (yet).
So it must be something else in the controller driver that is needed.

IIRC, this is the first Qualcomm platform that would support Gen4 with
4-lanes upstream. Maybe I'm wrong.

> 
> Konrad
> 
> [1] https://lore.kernel.org/all/Zl8H0KOrfuF91kpZ@linaro.org/

