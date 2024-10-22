Return-Path: <linux-kernel+bounces-375670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADA89A9912
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B0D1F21CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492AA13D613;
	Tue, 22 Oct 2024 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B49lRi/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191C13BC35;
	Tue, 22 Oct 2024 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576771; cv=none; b=NycJo3Th9jwPftvbdERafN5zDZ0vSvgxmx88dFGOXmFsRb64qEdWd1frLJ1LzYIx0+VGoI8iOQD7bEha1da1l2nEx30gxIrfa4Zd+q93yx8XTt+GStOFIH55s9xiZW9tJpx1SSWo32QMjnI/CpZLEsYRk44yR+lF+bL/4w93i5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576771; c=relaxed/simple;
	bh=GpRMng1ccoi3f2cJb14oOODmsXi9QulBvFA355RktFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euskc4Qj3XSQdD+b58GE7HnexsC5+1BQGC0emMTPrkBnkAjL70uNAlca3Z2yQEy10+pqZt9nI8et/RryGPJLe1+JzXbDeiy8yTJ08mI/e1oLTuF2kWjtRPRy9Bgu9xWw+ElqxdWwXqccKMwJsMs+VhplXpzaS5ZG6pAGo/pSDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B49lRi/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E21CC4CEE3;
	Tue, 22 Oct 2024 05:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729576771;
	bh=GpRMng1ccoi3f2cJb14oOODmsXi9QulBvFA355RktFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B49lRi/80kmhAo6BzIWQ9OOr3520QdvtqCIno27fkSn6UCcpWueav/ooDGYK7RGV6
	 83GiSYPsq3FVonvFwkPMfF/mPz+NGL0ZcYJRTHFx3KEn0pEq3nClZoIl1focCCSwnG
	 KrYOt0B5u4Wg5bd3d1VIIotDVA7uGluqL3Qd+j/TzjzNTKSa9a07KFG+202ujMt/7N
	 pM7v/KaKu4297e31VrRcGzJdzUoklDK14voW6O3gCkUe8ZOimaX+OFDiORgQY8wfep
	 UjIN+1ocEjg16FLk7WeRRfMIH0YPiBCr1kNV0STFeW8LBrzyh7Jt2EkJ3NVOAuROKC
	 NHBhxc8Yp0AKg==
Date: Tue, 22 Oct 2024 07:59:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Corey Minyard <minyard@acm.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Quan Nguyen <quan@os.amperecomputing.com>, Patrick Williams <patrick@stwcx.xyz>, 
	openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH v2 1/2] bindings: ipmi: Add alert GPIO enhancement for
 SSIF BMC driver
Message-ID: <yc5wngdgxh5ijixezdv6wyg4cqi7upcq5xtnrmwqt6e43nwaup@2asrssuj6bkm>
References: <20241022-ssif-alert-gpios-v2-0-c7dd6dd17a7e@gmail.com>
 <20241022-ssif-alert-gpios-v2-1-c7dd6dd17a7e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022-ssif-alert-gpios-v2-1-c7dd6dd17a7e@gmail.com>

On Tue, Oct 22, 2024 at 09:20:46AM +0800, Potin Lai wrote:
> Introduce the `alert-gpios` property to define an alert pin, enabling
> the BMC to notify the host when a response is available.
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


