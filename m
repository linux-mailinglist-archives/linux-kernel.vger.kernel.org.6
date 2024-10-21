Return-Path: <linux-kernel+bounces-375268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFF39A93ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DBAB23450
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31EA1FB3F4;
	Mon, 21 Oct 2024 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="dkR86t8C"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270631FF611;
	Mon, 21 Oct 2024 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729552114; cv=none; b=ihJf2S2TbeRB3ANG3o+KxeQquIUBqkSHwrkgaM/NxkqcK8aq5IlJOTRrzisJrJa5R8JrLfg5B6JUrVwuJekekI3WcIVgfmPl+2m4p8ik+jA1TIk44vV/FTs+z7JbxaTqiDBhluW00w4zEX+qJnYuISzZq4Px/ZiklCv0V/87Eig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729552114; c=relaxed/simple;
	bh=1H2hzWra8FvYjFCFxNnEV3ZEFgunoJiDHcGTbmxD56k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UejXzle6fPbDiG2MeM+0iacGAFCLwq/MF3pN69RWztmQsp8nzOr5n+ZdRC+8vkg1fEYi0L8a4+jBTcg9+PwiogT1ALCiszfCOkHUZrq6TEl6IHku6YW63D0s710Rug4M/zJj52ut33wlca1rqNjJm4aExiL+J62EtBoXRPOHZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=dkR86t8C; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729552109;
	bh=HujQp2mhg09W7KS1yS8qHdzqq2w6ddNhAO0OXRrftPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dkR86t8CL5wPWttnIx/R3K27EXqKSO9uxKGzUpNOQKCo5VwlrzbdM7hjH51AxDFW8
	 43XUNUuZqmOo8opCDec3kBg6CrI0RY3OKEK5AIOEBlzKZBe9jkCuTCA9xx2j++6RSv
	 2x1HzoR+dWNWmWZTJY8R7XuFzyyVVM6xNSswBmm/EKiaiLq+6tUVWKSbWLcO6t0xnJ
	 /+D0YKKcL3Eylu1dy9TLOfrUp67iW0amUdx/sbJf6V6aoDNewQBYk3Ao6Kr2BzX58V
	 dg+kZcGFbuQ1ML3hDN9bhagsM51sC5se2r2Vg3VkHqkaPnOXkq54pW1raATxRdIcUP
	 UU0+gLVbz+8dQ==
Received: from [127.0.1.1] (ppp118-210-184-223.adl-adc-lon-bras34.tpg.internode.on.net [118.210.184.223])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3AE3A6881A;
	Tue, 22 Oct 2024 07:08:26 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 OpenBMC Maillist <openbmc@lists.ozlabs.org>, 
 Open Source Submission <patches@amperecomputing.com>, 
 Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>, 
 Thang Nguyen <thang@os.amperecomputing.com>, 
 Quan Nguyen <quan@os.amperecomputing.com>, 
 Khanh Pham <khpham@amperecomputing.com>
In-Reply-To: <20241021083702.9734-1-chanh@os.amperecomputing.com>
References: <20241021083702.9734-1-chanh@os.amperecomputing.com>
Subject: Re: [PATCH v2 0/2] Add device tree for Ampere's Mt. Jefferson BMC
Message-Id: <172955210690.47095.10418122883150753763.b4-ty@codeconstruct.com.au>
Date: Tue, 22 Oct 2024 09:38:26 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Mon, 21 Oct 2024 08:37:00 +0000, Chanh Nguyen wrote:
> The Mt. Jefferson BMC is an ASPEED AST2600-based BMC for the Mt. Jefferson
> hardware reference platform with AmpereOne(TM)M processor.
> 
> These patches add a device-tree and binding for the Ampere's Mt. Jefferson
> BMC board.
> 
> Changes in v2:
>  - Document Mt. Jefferson board compatible                      [Krzysztof]
>  - Remove the PSU node with pmbus compatible                       [Andrew]
>  - Remove clock-names property in mac3 node                        [Andrew]
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


