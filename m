Return-Path: <linux-kernel+bounces-218502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6F390C0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165FE2824D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D497483;
	Tue, 18 Jun 2024 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn4xzXW9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3F4C8F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672522; cv=none; b=h8Z6RurVZtV3Q8Kig2AeSDpolUeWOWa4ZsbtFJQ8Sml6a1AoW5L80+0kowfEvDrXkXTV0KlXNfQJQmaQJJ8tGbcSgYhJoUZ7QLe0pTSeiAabKx3K23AqHoZUnOz5oMphwcWkk2a9jSqdpbkIwMqc+mfW7A5uFideZGPIC42u0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672522; c=relaxed/simple;
	bh=lydhvMk1/cTBLc9nkGWn8WKi5PQNxBQkD4/oF9bwnq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KI5uDWDok9avNwrvTJM9QD+cH3cYITvewypw+HvWeJl/o0FFbcSjRyFcCz996B7JI9A2uSLcqUBkx11o7nS/mpS6pIiD5AvqlXec0lR9vqzl3bOimRaBRY89OYpQjjipcsTTSx4SThG0SsItXm8o1Jm8N1fswDo+4sF4bhmB3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn4xzXW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE69C2BD10;
	Tue, 18 Jun 2024 01:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718672522;
	bh=lydhvMk1/cTBLc9nkGWn8WKi5PQNxBQkD4/oF9bwnq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vn4xzXW9qBc+/0mEK8hTzSpHbMEh9OAfBqx3fgCr3bmVyJByt+qYOLEfwYhH/OoHs
	 nLABGnKfoLL8ZtvhpuAaGNAsleK30zSOKcI5ALS2QK9in2774n+5BMB1vPqNdZS1M1
	 e2FJNcpMVoqdaaa8BNM2D8cCmINFO3mWdDRd/NZAWSO+td/dVj8FFEPYeRTc0jtsa/
	 7FW8cRW8S//slPgoHtQ+cAHV+jDl8LcGmN6gxHMoFp9lGnBYZbF/KTqHKt3G2av+Ek
	 2y4DowGZK4CXqCWAlepQJIS3zdPqjA6G3tH2ewaDv+Xh7llr2MqI4FZKpfAS70GUaM
	 6qznEPD0tT/5Q==
Message-ID: <5eb12aeb-a898-4fcc-9f60-037458905929@kernel.org>
Date: Tue, 18 Jun 2024 09:01:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to use mnt_{want,drop}_write_file replace
 file_{start,end}_wrtie
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
References: <1718271333-32179-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1718271333-32179-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/13 17:35, Zhiguo Niu wrote:
> mnt_{want,drop}_write_file is more suitable than
> file_{start,end}_wrtie and also is consistent with
> other ioctl operations.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

