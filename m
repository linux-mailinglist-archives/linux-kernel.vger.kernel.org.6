Return-Path: <linux-kernel+bounces-360880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C3B99A0E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246C6285E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7838210C09;
	Fri, 11 Oct 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmzj5TBv"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641EB21018F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641509; cv=none; b=t4LqMXhhsJmDeMvJYa3BOmJiJXpD+pL1WK0s1OlZHH/jvpJULutfD9v7z8OBtJ4AVi1oxULTGlfSrIv0jrNY3XGuIf13OerAuLAYQJ0InRRQ2rzmRxZdpYfzKkydKk64jUmwU9BqjBwrcF/M5KQQxS31BDvVEZNvgGntb+dibhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641509; c=relaxed/simple;
	bh=yaRy18JzaCR4lPwXWEq4MPREYdKVBhXc3Ez/aUa0Drw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvfM+RlirwBLAQ3TEYaU1vy5uAidlT4vR65cJq6JZC1e4Lx+l2I5IXr6B3pzus5gxK71TT/B9LmGkTcL3XzYunBEchC3e1OZdnVvjqt0aRk4GVt2nQIYVrYob0gSB9RsBk+D9iXT4cK9Jjn6QU39k4RgAFayVuaaAEcujvqHAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zmzj5TBv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43056d99a5aso18798145e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728641506; x=1729246306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nthva+KikeYDY2jXsfCkd2Wj5lsxwGGbWSJrT4OoTAY=;
        b=zmzj5TBvyVr8sIU1690XLn8MGw3MX7VHCcZ6xMSYnffjUWX/ZhlAWGYqGWdGgqa5oN
         tMjobtD0hm+FcP40Z6AHjvIk//OZtU/9zscfaV9WquBepHWUVyBWRE27Ym9cg2WdYVI3
         h1A5gq9YAIUUTeksdy1ROn28um320bdWRbGO+qkVBcWzq/7ksjBAWoagBo8/8FyMq3Az
         mhucC/fwRXX3ShGyhY93ImaWeOhOIS7cST9byDU4ELU3TlyjEZd4R4L0Rm1sK4grFsVd
         V0bdIqJ7kZb24Gs0PrUy765I2L36lHyQwcarFfdD4VI9T8lOLt3VYqV+YVEGSShtSzKD
         JAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641506; x=1729246306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nthva+KikeYDY2jXsfCkd2Wj5lsxwGGbWSJrT4OoTAY=;
        b=a3031Q6mGeRnY/ZJ8r5WFWXtPHLnN8Q/Tw4AZM5tGGX2j1uUvcrgrX4xvzlD/hYjc4
         3XaoW4i+OD87OMo81pWU4n6VOi+mzD3s3ZcI/qta4wCIageZ3gw52IsZNLo12Z2doee6
         muKpUdCCAn1rhXbIQF9LPCUlYTiHlE99W1lMwUxm3olzjRuZhGF8CfexCaPmXVQ4tYta
         39wOCCH1pPL1yhaGR6imh9Hi7LLZ3iDf6k341xG9tmj7Y7C3tlOTwn73ZOAvHZiAoMxI
         P4UzbwM59U4kpJvu+iCIVg5eAv3+y8thyaRrrv0jxtf5g+wJSHj8OHHYZsH9DSZfEv/+
         QMkg==
X-Forwarded-Encrypted: i=1; AJvYcCWdbyIln3JWnVyRHTQJUoWixXcGNvx1uhguWRuqkh2kGEYNJQgXvHjnzkBFVosEXeA2zhkdDWZ0a9OnaxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnySnFFJxGfUgDjhpuiHJRXgK1t+iBkiXOPZxVS+DvOJK/K/uu
	VqGPN26gwJOxPfjW3CJfpDSfZpRsz4N/UXHnhUXg8PTCL/JvqHEAMsvLWp+gsGkzYmVUe9SGyHe
	pFbQoYw==
X-Google-Smtp-Source: AGHT+IHsKhIjDvBqoaWJfEqeedwwgJUaycEBOS/lAbm4uc8aM7TqsOOGKINMfjLpgjtxnD7257CBkQ==
X-Received: by 2002:adf:e8d0:0:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-37d481c22d1mr4923898f8f.22.1728641505704;
        Fri, 11 Oct 2024 03:11:45 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef80:63d1:4749:f717:d9e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd03fsm3555944f8f.34.2024.10.11.03.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:11:45 -0700 (PDT)
Date: Fri, 11 Oct 2024 12:11:43 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: x1e80100-qcp: Add WiFi/BT pwrseq
Message-ID: <Zwj539cN2DJ7nd3A@linaro.org>
References: <20241007-x1e80100-pwrseq-qcp-v1-0-f7166510ab17@linaro.org>
 <20241007-x1e80100-pwrseq-qcp-v1-3-f7166510ab17@linaro.org>
 <ZweftESPrJNEsqGE@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZweftESPrJNEsqGE@hovoldconsulting.com>

On Thu, Oct 10, 2024 at 11:34:44AM +0200, Johan Hovold wrote:
> On Mon, Oct 07, 2024 at 08:22:27PM +0200, Stephan Gerhold wrote:
> > Add the WiFi/BT nodes for QCP and describe the regulators for the WCN7850
> > combo chip using the new power sequencing bindings. All voltages are
> > derived from chained fixed regulators controlled using a single GPIO.
> > 
> > The same setup also works for CRD (and likely most of the other X1E80100
> > laptops). However, unlike the QCP they use soldered or removable M.2 cards
> > supplied by a single 3.3V fixed regulator. The other necessary voltages are
> > then derived inside the M.2 card. Describing this properly requires
> > new bindings, so this commit only adds QCP for now.
> 
> Based on our discussions it seems we do not really need to describe the
> internal PMU at all for WCN7850 (as the bluetooth and wlan blocks can be
> enabled indepdendently) so perhaps we can just restore the old binding
> and drop most of this boilerplate for all boards.
> 

I think there is no clear conclusion on that yet. The old bindings
didn't describe any power supplies for WiFi at all. The pwrseq bindings
are currently the only way to do that.

We could potentially move all the "PMU supplies" to the WiFi/BT nodes
and rely on reference counting to handle them. But I think it's better
to wait how the M.2/generic PCI power control discussion turns out
before investing any time to refactor the current solution.

There are existing users of qcom,wcn7850-pmu already in 6.11, so I think
it does not hurt to take this patch as-is for now. We can clean them up
together later if needed.

Thanks,
Stephan

