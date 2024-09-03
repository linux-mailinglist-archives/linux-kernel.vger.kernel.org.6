Return-Path: <linux-kernel+bounces-312321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08509694F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35CA1C231E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0086D1D6C46;
	Tue,  3 Sep 2024 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs1AGCOE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2C31D6786;
	Tue,  3 Sep 2024 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347607; cv=none; b=L+yYqmkaclZM7Kvc8cOXyaJq67VDzUyWbhnrSqot0dYDr9PnlHkOJlRozwJMaxPmweEgSO1Fp2EWDTCqWP2SYPXvqicVKCA3IE45lNjLGCPX/BDVW5ECv8tlzw8d3IAlQdDHJYFSezNx1RHHbTfEAyeUwxHIfTk2a63mcuKRdCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347607; c=relaxed/simple;
	bh=gdQzZXQlNJ2WddxY58vtzSE+Tx9smuEhfiUdnMoqg7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWLxgZlfmNr8O/W2e0lCuzBQJfJFd/ZIIkZ3ToK3FcCXsgsuTU5JhYXTQKQOVv+jNBEHRlgBmV7+cpbCcMmtPY64cuqgdPsjobC1FL4z/xsFLA03hBq71PIFBCBKJEKexG1k5DU5Ojdq0C5GSW1G3NakeqLk6lB5L6QjfXn0xtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs1AGCOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC72BC4CEC5;
	Tue,  3 Sep 2024 07:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725347606;
	bh=gdQzZXQlNJ2WddxY58vtzSE+Tx9smuEhfiUdnMoqg7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gs1AGCOE0G9fqfFMaSn6iVu8Mq8LATc6F2Zfv81WpvPE9dRr3nnBEfcFkPCe+F4oi
	 RxyaYqcDIUmPlyIbiiIAHo0f8PaJepNHUlB+EXBtkRAPZXakwUGiyutUpmAG1urLl6
	 90esgVCbA8qZJCGUeirSeGWISfaU4n7bFJUd3LFJazKHKn01VeWFKO4+m7kwqUyHMp
	 mCpt73XfigcFJUqP9YPo50jpw4r77A1f+Xuhoi7EfSFTmHo/ICV0paScvwr21F7sCg
	 YZ4ioGQh0SdO4b4zMI7us8SmiY1G0zC5S0nk/n2QGjfIAYD4CI/u1zG/N/IpX24GkK
	 fiZmzoPriFhng==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1slNjS-000000000zP-0Wm6;
	Tue, 03 Sep 2024 09:13:42 +0200
Date: Tue, 3 Sep 2024 09:13:42 +0200
From: Johan Hovold <johan@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: usb: Add Parade PS8830 Type-C
 retimer bindings
Message-ID: <Zta3Jr7rCDzxe_mE@hovoldconsulting.com>
References: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
 <20240829-x1e80100-ps8830-v1-1-bcc4790b1d45@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-x1e80100-ps8830-v1-1-bcc4790b1d45@linaro.org>

On Thu, Aug 29, 2024 at 09:44:25PM +0300, Abel Vesa wrote:
> Document bindings for the Parade PS8830 Type-C retimer. This retimer is
> currently found on all boards featuring Qualcomm Snapdragon X Elite SoCs
> and it is needed to provide altmode muxing between DP and USB.

> +  vdd15-supply:
> +    description: power supply (1.5V)

As Konrad already pointed out, this appears to be a 1.15 V supply, in
which case the name and description needs an update.

> +
> +  vdd18-supply:
> +    description: power supply (1.8V)
> +
> +  vdd33-supply:
> +    description: power supply (3.3V)

Johan

