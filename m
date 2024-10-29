Return-Path: <linux-kernel+bounces-387874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF509B5712
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652031F23734
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCE320B201;
	Tue, 29 Oct 2024 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ2X9+34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1C190665
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245309; cv=none; b=CeVPSnDOW/+dmhsleK5G/qneRk/3ftPn9nhSibx5EKCvqCykysFIdtbkz3jgYnQzYe0CedvEbviot2G7OiZmJPuyihwLowrZMmV38gNxfjQiLCVWVQ7U8ABhbYANV7rVSrTReRvmgDcjxEFvkLmOGvNTAMOEoAIS/ycSsWAZOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245309; c=relaxed/simple;
	bh=1klZnACYUFdic8E420CIKgnM1WPngKyl9bJQHZUV0bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aD+/a+jaPP2En4zeZTLhN41w5YFfdTNxOhmUVNalEnULmQ36oyfAwWCvy1BVkgmaCieuii8YLwl5yZEJmd4eDoCgehJVYvu8GlAeWHkhRptoGd3kAWY5XJF5Z326NFMWFwrdQirs3mYSRPnYxI5NiKJZb9VWbw1PLj1y1bD77I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJ2X9+34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B98FC4CECD;
	Tue, 29 Oct 2024 23:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730245308;
	bh=1klZnACYUFdic8E420CIKgnM1WPngKyl9bJQHZUV0bo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tJ2X9+34BM6iIkxHe7BsIPq4/B5dQBX3WpUrAkmwO7FIgMqF65ihy938tvcHLcO1w
	 CeCaTZ36UpyWD7l6OCivN+J96KFGluV3xRH1NbsJcgwiUQ7MokGqr33Yo8SiFd2USr
	 eowk5qlvT7L4WYhkVga7WM9b7upm3OIR6Uf+wW3YQNzuBh+yY1GvZ9+kQkbkK1p7Wf
	 iJE53ZJJxQ35R3+t9EjhcwDb2xJJOa1EBAMe2XQPpHP+9ko68ePzeMC0U2HYYmmGKP
	 9bJb0Rhx+S4/3niOGXaGEXlpdUJyalnUa8ZS4SOdFKCSM3GtDqMpJfJ/gVMqK5/vF1
	 Bapwqbl4LPQMQ==
Message-ID: <528f1b95-59d1-4040-bfda-c710010c1aa1@kernel.org>
Date: Wed, 30 Oct 2024 08:41:46 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/31] ata: pata_octeon_cf: Switch to use hrtimer_setup()
To: Nam Cao <namcao@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1729864823.git.namcao@linutronix.de>
 <ed3d9c1f672708ba5b77f1d903e472bdd310a037.1729864823.git.namcao@linutronix.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ed3d9c1f672708ba5b77f1d903e472bdd310a037.1729864823.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/24 16:31, Nam Cao wrote:
> There is a newly introduced hrtimer_setup() which will replace
> hrtimer_init(). This new function is similar to the old one, except that it
> also sanity-checks and initializes the timer's callback function.
> 
> Switch to use this new function.
> 
> Patch was created by using Coccinelle.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

