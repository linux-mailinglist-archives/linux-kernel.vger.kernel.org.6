Return-Path: <linux-kernel+bounces-412561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C379D0AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46125281A57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7738C1552EE;
	Mon, 18 Nov 2024 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3bsT4t2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9A18E25
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917652; cv=none; b=KBWnmqzxPjmQGiXVhusrNkYy2g5to9EF5REidb9n3llIhsBFeNZXv7yjhCXKuRpmmnRII7BadmlxCYwwJvWc5avyJqzpD9VdE0OrvDkPJLvYfKslOuUkEyoaoTAPMIRfgY26k33N8HOmxMoodx2aR1zK9ByNpQvEmMwu+xR7M6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917652; c=relaxed/simple;
	bh=xTqkpiNtWzScx2UhoZf8aeDQxu5Y8IDbmaRI/71QrJE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PGEY9IMd43roj73rmXM6AGhY/K/UPlOU3qAJVHXzotnGrTrFPuaXYQy5HPFves8nMfNmbmAoOEPL2vi93Iq9JH3ruvUHl0FJgogLBM+mgSfAOhw1x7sbj42Aki8wI1fbnbZZPluzr+uUIPxL5PJt9k28tpbkuB9+gSTU2IssbdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3bsT4t2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B82C4CECC;
	Mon, 18 Nov 2024 08:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731917652;
	bh=xTqkpiNtWzScx2UhoZf8aeDQxu5Y8IDbmaRI/71QrJE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=R3bsT4t2gu0RNDSnckibOpoTVglBTM4WTqVgFbatK3TlKehExrq1TQJVYNeuPUVnP
	 xR0lVIEHxl6MFOQwolm0ZpOyyYuhx34G9DMsZL/vKveqfZnDayaKdqHP9JKUA+ugbL
	 4l/38UP/RKFiVyJz7lHWC2z2Cw5NjLE+omUbeGDLKZicO0it76Lbq0UrFKVWwLV/XR
	 87AQPIXV6RVl1FQ99vzl5Qb8k3VCuu7FBK90Z+MLydUfs9oUrzt3OJjbjoHByCzJvh
	 payuFIz1g0yiuDlXAZFWJ9vjOSl/8DOrWuc9o8s3Yg6dscOni92jQj0liFA+tkN9XP
	 bbk5jFOzbnyHg==
Message-ID: <4ab5c6d1-9ce0-40aa-8fdb-340a50db3bec@kernel.org>
Date: Mon, 18 Nov 2024 16:14:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v3] f2fs: replace deprecated strcpy with strscpy
To: Daniel Yang <danielyangkang@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20241118070141.3474-1-danielyangkang@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241118070141.3474-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/18 15:01, Daniel Yang wrote:
> strcpy is deprecated. Kernel docs recommend replacing strcpy with
> strscpy. The function strcpy() return value isn't used so there
> shouldn't be an issue replacing with the safer alternative strscpy.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

