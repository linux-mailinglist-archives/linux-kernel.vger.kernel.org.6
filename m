Return-Path: <linux-kernel+bounces-296104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C295A5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2A6B2141C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35F16F830;
	Wed, 21 Aug 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Kl7Z/i1l";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Kl7Z/i1l"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF51D12F4;
	Wed, 21 Aug 2024 20:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270871; cv=none; b=QVTQW/hasApoRBuQNBYqAR+9fWENLy9a1yONS/802NVar8asPmvz2ajMJo0l8uaXiPDi7U8TveGJ5mOh/0EKKbph2T2LTcvTYW/dWBaSXULXKM12kmfb6+yOFy+r/NsL18G8Bj/3fI3aH+/zj4prrzy4IIO37xUrz//l0DeMyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270871; c=relaxed/simple;
	bh=MZQfvmfkwfGf66WAFAu3QnJjy5WztkpUl1vV2aD2Wbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzZi3egiO2Htwsp/hafH6hFMzgMUmIQ+dvzQZjUaeTKsQckqZ6G8B1XZfpeCNLY3VmbWbHIcW3x9mRTryQ+4rQv6/+xLQB535LVMruylm8rTMR69OVqsrq+EsNQVFzFz9rhBrZOuQutwMJQug//R3S8A1SGGRNTuR7shxAia7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Kl7Z/i1l; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Kl7Z/i1l; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1724270866; bh=MZQfvmfkwfGf66WAFAu3QnJjy5WztkpUl1vV2aD2Wbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kl7Z/i1lGZtehC3NiRil3Do0mrC+xmD/iX2vgs3dvU+mJfPBHkSj9wwZAUTkijIVy
	 e0/PUnpRxCSnLAPqDYZr9Lq+GOf+BAz/Vj+XNSjWOPxFPpPl/2Jioi/nU1JHJwv8YD
	 krtI+IuY2SBhrwpIGsvOcO/6uqDx7YhfE9RHPB1XSUkHeiw+xMDvxvaN5Kz1SX16LK
	 wpLiq0jMd3Oo/B20Qcx6HHefvzWa1dy3TF9Svbli03ezAdGv9kjIdm08oiXQpZIRbH
	 brMsn9mcqzK0RS/c+ITddOY+YKgKHvUGmo2X5dC8WYIgUU+uX0eLp8fkAGq4AHN+bo
	 nLfeoJ1tZQbug==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 9B6131178;
	Wed, 21 Aug 2024 20:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1724270866; bh=MZQfvmfkwfGf66WAFAu3QnJjy5WztkpUl1vV2aD2Wbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kl7Z/i1lGZtehC3NiRil3Do0mrC+xmD/iX2vgs3dvU+mJfPBHkSj9wwZAUTkijIVy
	 e0/PUnpRxCSnLAPqDYZr9Lq+GOf+BAz/Vj+XNSjWOPxFPpPl/2Jioi/nU1JHJwv8YD
	 krtI+IuY2SBhrwpIGsvOcO/6uqDx7YhfE9RHPB1XSUkHeiw+xMDvxvaN5Kz1SX16LK
	 wpLiq0jMd3Oo/B20Qcx6HHefvzWa1dy3TF9Svbli03ezAdGv9kjIdm08oiXQpZIRbH
	 brMsn9mcqzK0RS/c+ITddOY+YKgKHvUGmo2X5dC8WYIgUU+uX0eLp8fkAGq4AHN+bo
	 nLfeoJ1tZQbug==
Message-ID: <19130d88-a320-4740-80d6-c4c0501c4db9@mleia.com>
Date: Wed, 21 Aug 2024 23:07:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] driver:usb:lpc32xx_udc:Remove NULL check of
 list_entry()
Content-Language: en-US
To: Yuesong Li <liyuesong@vivo.com>, gregkh@linuxfoundation.org
Cc: u.kleine-koenig@pengutronix.de, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240821085245.25348-1-liyuesong@vivo.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20240821085245.25348-1-liyuesong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240821_200746_659513_05C56CF9 
X-CRM114-Status: UNSURE (   4.48  )
X-CRM114-Notice: Please train this message. 

On 8/21/24 11:52, Yuesong Li wrote:
> list_entry() will never return a NULL pointer, thus remove the
> check.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>

Thank you for the change.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir

