Return-Path: <linux-kernel+bounces-274747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A4E947C2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EA31C21C99
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244763C08A;
	Mon,  5 Aug 2024 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEV6Eidl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65A2D057;
	Mon,  5 Aug 2024 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865781; cv=none; b=EXd6Hhc8bJQSv4u2+i3ataRDUGs+ZZNx6veDKEPdrsqJZanzUoB+1NH5axlvecynNulYg6szzypjb/ggWRoNclwthKh94ymW743xZ2AocqedGy81iZTlSTDOa802m2ouDxeXAGmM5NNHFHo5gIdcqo3T7GdeyI0AVG8BfIi3TDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865781; c=relaxed/simple;
	bh=GXKEwYWx84eMo8y58a1IILiIiCxlB+z7rkUzUmIgCp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkRQ09c0P7p83rpehSYFIeMwEmuW4rVcDmiGUke9gHJ81er8UWqIQ8VUFfZYpEYfaRsPOk59nlMFeElnsgMfwtqrbVPLIE1n25ZNqyQcLEFCLObK8/b1o+cXkXYjqntQ3hLmTqF3R/DiGMtlKRpB3CdUHDQ4VpicdA4YYYEx4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEV6Eidl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48960C32782;
	Mon,  5 Aug 2024 13:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722865781;
	bh=GXKEwYWx84eMo8y58a1IILiIiCxlB+z7rkUzUmIgCp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AEV6Eidlzou40/NKX/flL/igGX8O8VCwym6oEldlYVeha/igiR80uOuanUbXzDCLl
	 MPFYp1wZRDtENC6OSjY78MGiCZbgRFVjTyIOVcZaRd8iYZt5CqZhTa0Yik79KQRpXO
	 /2XGLwNcIy4EbpWP+hQSH5jC6kYrCsNhZqtB6W7PONfEmSqorRy19hEv+/1s1oThLQ
	 wahPLo0llwDu9YC997D/J+mOQe1OOOWzE84zGIep7GQ/ha/DZj9O0ktGT1mKQF/LSw
	 joyyr+yZjjyl3DhSxFOXmsfcdvjopWwHzSGbr0otfmbs9aJi1kw9zYCUQmGA54+eW8
	 n4W5jiPbSRRvQ==
Message-ID: <8b93b8e6-b9fd-4564-b17b-514fbab55a40@kernel.org>
Date: Mon, 5 Aug 2024 16:49:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] usb: cdns3: add quirk to platform data for
 reset-on-resume
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Kevin Hilman <khilman@kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-5-8664bfb032ac@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240726-s2r-cdns-v5-5-8664bfb032ac@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/07/2024 21:17, Théo Lebrun wrote:
> The cdns3 host role does not care about reset-on-resume. xHCI however
> reconfigures itself in silence rather than printing a warning about a
> resume error. Related warning example:
> 
>   [   16.017462] xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x401, Reinit
> 
> Allow passing a CDNS3_RESET_ON_RESUME quirk flag from cdns3 pdata down
> to xHCI pdata. The goal is to allow signaling about reset-on-resume
> behavior from platform wrapper drivers.
> 
> When used, remote wakeup is not expected to work.
> 
> Acked-by: Peter Chen <peter.chen@kernel.org>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

