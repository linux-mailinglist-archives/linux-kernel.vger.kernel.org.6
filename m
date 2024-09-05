Return-Path: <linux-kernel+bounces-316168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E9396CC22
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DDC281915
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BB2C133;
	Thu,  5 Sep 2024 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5SKK1ae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AEC9454
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498904; cv=none; b=tehxeesm4hCU8t21M9ZK1up2o2SixFhxND7GX3+poZAoJ029Qrcu29wdcQqtVQxBXjSgPLeFson2t+Ag34Chy0KldcW+oOEGv/cq/6u/SJ2+Av3U0in02/Wl8sX6m/Xw39zOtj1Rx1fmJze0vM0PYBEcli7OhbBA41yumL2iw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498904; c=relaxed/simple;
	bh=3fWJeDzfvSnisSK5HoEs4qKH4+GRMvygpcT7XlA/xvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUj1bjaxQzQdHVmHYH8lQ7why2TkGspJNQXTKTUIs4gYi5f+1HnXyfQ8Cj9w09PQJfG+LkG7zpEYV+9Fsln/ynJ54mi+crQvCwSWWDGoKSVzp6lXJfPFiiJc0UBSlujns6xpBImCw5TwzGlmrRIr3jOjCpvENyiUXdrpQ26I/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5SKK1ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86156C4CEC8;
	Thu,  5 Sep 2024 01:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725498903;
	bh=3fWJeDzfvSnisSK5HoEs4qKH4+GRMvygpcT7XlA/xvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h5SKK1ae0STWk1Orez3ypAbXneFv0yqmIvUux0O2WwHcbKoo4FK5+/TMORIxxmg+u
	 +iwdlIkECnL4dDlmijBSor/XWbxmG6VgMVpZLZRniUiH9FnZx6dxAKut3wWIrdrt1n
	 7Kl63t5viX5JO45I3XsbFrk0GofOoWOEqLBDYyW43V0XBKgScrNAPJ3keUAGGffMI3
	 yjQSoMlp5AdEVKUqK8PiIj7zAmTHNizJMkgIS/MsAS0poju7jv0ytT0nRBdgVbH3U1
	 FWRTOZMWuupizkurgJVUYnE6wWqNUSOB7o4LZpu53eIdC6titZJgjZxHIYDc+x6yFa
	 wxOqaGxW9rPog==
Message-ID: <f31dec2f-01c4-40e5-bc0d-06eb921392b8@kernel.org>
Date: Thu, 5 Sep 2024 09:14:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: use correct endian conversion for
 writing lpf inode
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240903173157.602995-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240903173157.602995-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/4 1:31, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The conversion between cpu and little endian is incorrect.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

