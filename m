Return-Path: <linux-kernel+bounces-363746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866DA99C67B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2ACB2323F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F503158A13;
	Mon, 14 Oct 2024 09:53:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02011158DDC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899638; cv=none; b=CCUAwtg6jTK7wIo9uTuFUzRDnzCfmEbCKB1u+Y5pULwF81O/4VKaAcyPtfwu/TX38KdHtvnjrN9HcXCKE8TrUTCom0X/LkM9W6HRKAFECYY0XQk9XLY4GOAYsdvLUjePM5V8lOEEU/qZo8IhTOSR3NEEj2lsxfL4oIGKYDqNoKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899638; c=relaxed/simple;
	bh=NrilqX9I0/mXNvp4xDJtkTprlVVw46zascPCdyF0ul0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzeDB8yEuzIGEASj8qd4M4i/teQ9lmZCDV3dbtbY8WPNyY/zJcc5Z0d48v3NNFN7TxXCX1zbenDOEmEvZjXJv9NVyrYRDDUAkC329oy6rBzO8QxbKAxfVKuVyODO6whx4LRrB+7ME1MxQ5IjoJ/dmOF//f4l8jifneCKhqS+F50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 090851424;
	Mon, 14 Oct 2024 02:54:26 -0700 (PDT)
Received: from [10.57.78.229] (unknown [10.57.78.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A29B3F51B;
	Mon, 14 Oct 2024 02:53:54 -0700 (PDT)
Message-ID: <87ba9595-6229-4a79-aa65-d76567ef708e@arm.com>
Date: Mon, 14 Oct 2024 10:54:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: NOMMU: Fix exc_ret for stack frame type
To: Jisheng Zhang <jszhang@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241013132520.2848-1-jszhang@kernel.org>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20241013132520.2848-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/24 14:25, Jisheng Zhang wrote:
> commit 72cd4064fcca ("ARM: 8830/1: NOMMU: Toggle only bits in
> EXC_RETURN we are really care of") only sets BIT[3] for Thread mode
> and BIT[2] for PSP, it leaves BIT[4] untouched. But there's such a
> case: the pre-linux env makes use of FPU then the BIT[4] in 'lr' is
> cleared, this brings an umatch issue since the NOMMU kernel doesn't

Can pre-linux env disable FPU before passing control to kernel (which
is, as correctly pointed, doesn't know how to use FPU)?

Cheers
Vladimir

