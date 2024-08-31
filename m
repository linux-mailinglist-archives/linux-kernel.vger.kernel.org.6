Return-Path: <linux-kernel+bounces-309874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C016967166
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADED1F22626
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779B617E016;
	Sat, 31 Aug 2024 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSJNLCZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E24C99;
	Sat, 31 Aug 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725104937; cv=none; b=AerZ2g0X5Re/ysGf9wAp7Q53OCgqe1ln2hG+WYLEyBpm6kGFo/dlE9J8eXNAJP7Ri45+MQwmgNjYaoJlHtCl3JEetCamhID9Y9h3EncmAY74KqHYZwcF7Wk/MkfFuFDvYj3fU444+JA2I+TyTjYMjQGgn5hPyKbFzXwl+xJmFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725104937; c=relaxed/simple;
	bh=WO9DTaJ6BhMqSYHc9IQ0RIHmqxjJrk5UH99GMcAiwdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPk/dVuC9rVqqs0qHM4zN9cGoYx+VRkOyJVKqzpTOaMbIZJUb+ankkt3eNyB8EE4w8ebs0bhmBht2tm5Zh5eR2VhZWGoklGujz3xP4LWdt5XhireIcuaQY1joKlSk+t8SFQsnf6RSbm7LAlhfNUlt83H6etfMT6vw5KVD8t8diQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSJNLCZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85DAC4CEC0;
	Sat, 31 Aug 2024 11:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725104937;
	bh=WO9DTaJ6BhMqSYHc9IQ0RIHmqxjJrk5UH99GMcAiwdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZSJNLCZgwalLUDRo9V7I/TlqfCZsWvEYK9xMySojEfb1EuTDCU3df8sMYHvDzhBKR
	 JfKfBAWDg2tYszNMSzBIRxuPuGVr6O9nCySRLMA7V/wVMUJg04svb4faJZYJfrRNzo
	 vKzmvD16C1ijjXiWFkxevODkCvTIqMU6sM6o+Ebr5DOWoW+zDGOAmklKyt3GdsBwrz
	 TMJhiWORYFjX+JqHL6JcrI6GfZzBWZUhMjSbrllHpEwHJFZrgeD4tcbh/AZ57xt15t
	 ksKBcImdknnxIEAu/vO/p1TpKcJ3xyfwxSMl4K6xE3r135NR8KawIHaCglvwssKw5V
	 pKP15KDfvSDEg==
Date: Sat, 31 Aug 2024 12:48:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Subject: Re: [PATCH RFC 5/8] iio: dac: ad3552r: changes to use FIELD_PREP
Message-ID: <20240831124847.5c679e55@jic23-huawei>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-5-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240829-wip-bl-ad3552r-axi-v0-v1-5-b6da6015327a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 14:32:03 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Changes to use FIELD_PREP, so that driver-specific ad3552r_field_prep
> is removed. Variables (arrays) that was used to call ad3552r_field_prep
> are removerd too.
removed

LGTM


