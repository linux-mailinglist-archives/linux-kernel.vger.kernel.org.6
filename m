Return-Path: <linux-kernel+bounces-368140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F539A0BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E278B2853BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49329209687;
	Wed, 16 Oct 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oVpTpZ/h"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11595125B9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086088; cv=none; b=QqR4x7FHHMbEpBMQVHg17oNbSPjVCcRxR5rG1cDxiIILqnf6O+PCsJDJWFQ6kg8hZ457FgKZMcxlOHaqfmFZmC1fv+mq+pmF64VK9f3kcb4vaac5BwtTGv8d/8u39HzA15kNeynl3VMFwZGVFYD2ZGIHo/mDjjpDI93Clf40iyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086088; c=relaxed/simple;
	bh=Vw3WdylphoiNDJyo8Y9KPyEbQ3q3sHVG413pORDG2XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltrZ6s/aV9fF8Fga5nafGf4xYewL8desaT4Mg7oKraKx0cd8QFt+ErlTEG8LXzafHUbnlLE/Am1biK9GuGP37JyNnAKh7fx0yw37xboqe0TlEWxWrpDVrl6FuWZ9kpNDX/DPTFB9N0/UcOpVD7+MuVMWI8YBpUeeXiSHP/8oREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oVpTpZ/h; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B14EE40002;
	Wed, 16 Oct 2024 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729086084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vw3WdylphoiNDJyo8Y9KPyEbQ3q3sHVG413pORDG2XU=;
	b=oVpTpZ/h/azP3l+Ti9Hps/n/5+Q6G3DGyJwI72R8fFjGqKh9er3l4z6Gkj/kIRTT/kixCI
	Exr7EU1axNIOndz4sx6Y++8fV+vlSavD2lOYw3dGAStr1NoKXVO35TER3fXfMO6w/Omwbo
	skWzkgLXxiPboPlBxrkD9WnzMH+I8Q7OO0UnelVEcd3bitgz8+DALws8zaX2FcvWafgjVi
	pomIGTj9CQ7RAh9Ng767aRhHVMjXlgslXI3s9bCm1oADRwWJVZFp9hWxlFpGD0JIN5dRlM
	tMe+QJArkqQcINgzJKdqpNlLLprSi3l0sGJL0eopEabIYwulyzuhWxi/WCrhTw==
Message-ID: <edf663fc-43f3-4bb6-af50-19ab606e1cef@bootlin.com>
Date: Wed, 16 Oct 2024 15:41:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mux: mmio: Add suspend and resume support
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com
References: <20240613-mux-mmio-resume-support-v2-1-e8496099b034@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20240613-mux-mmio-resume-support-v2-1-e8496099b034@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 9/11/24 10:53, Thomas Richard wrote:
> The status of each mux is read during suspend and stored in the private
> memory of the mux_chip.
> Then the state is restored during the resume.

Hello Peter,

Did you have time to look at this patch ?

Regards,

Thomas

