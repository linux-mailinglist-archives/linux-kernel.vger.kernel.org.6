Return-Path: <linux-kernel+bounces-574602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4233FA6E761
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515631697AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAF21F180F;
	Mon, 24 Mar 2025 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="gS0Iydm/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877D14658D;
	Mon, 24 Mar 2025 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742860752; cv=none; b=GfZEHn8J2MtiQfXd/0idlZU6RrnH7sk/QBtt1eJsko0WY/gN3PpU8g3H+xYeefSVli0duewgQEPEwjPlTlwUUx12KUrC6NeSlfmBO73W5qFcIJAncK3hogtin62O/EDxjz+tEyAIGISDdmWRZOHmftViDNed1q92z1fAExUnhUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742860752; c=relaxed/simple;
	bh=jrZ7ZaNs4d9Lc7kh5J6sq7xG8RVnppeRCIfrfAPId1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hAaK/IDfHsPC9w8yiXWCZNpMnC/SsHQQIqEz9K6dB7yocAt1W/k4V9FkoquUupLrFMWRIn8ziUPhTGx/nm1vsM6OrruMAg3qjwWYZITwC0N5i+Ja+7NxN5SBb+AA2olgOc+CB9nKdYFIHMeIVVFUNnKX4ru8QV/Vp+LAw0H7eYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=gS0Iydm/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742860748;
	bh=FWdFElbolN32IcSIukRd2p8E/VsngBvOblp9fg+S+xY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gS0Iydm/MeDjtnLSJdBetps1Xv0ZUqMP2L6gevOdlk9P4BuYUJa3X0+mAzh1KELYu
	 RpqKP0F7rqM7clhL4pPXc5sbOKWMm35GLhEwqB3ENEiQcSCiWPOJv4shasRNZrbEc7
	 N2bJK6ywGbu70kOZ9nQRl9AOtaLLwky/V6fCLtKmsoYGKtqm9ONzJEU5wYDUc9oKOk
	 u9KnOXA7OcCT/GnzMbnsg6wbc+/kZe35QawZCbDj+kovJCXAhJDPVf++U5iRpxjRT+
	 eGuYM063/xkB2Qmj2s+cGbijNsGY2zjC8ppTiwhL2whiZ/0+ymmAH/3/qdzgiGMWn1
	 F73EryAwms/Rw==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A8CEC7B506;
	Tue, 25 Mar 2025 07:59:06 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
Subject: Re: [PATCH v6 00/10] ARM: dts: aspeed: catalina: Update DTS to
 support Catalina PVT hardware
Message-Id: <174286074647.923686.7149650911621706997.b4-ty@codeconstruct.com.au>
Date: Tue, 25 Mar 2025 10:29:06 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 21 Mar 2025 15:26:01 +0800, Potin Lai wrote:
> Update the DTS file for the Catalina platform based on the PVT hardware
> changes.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


