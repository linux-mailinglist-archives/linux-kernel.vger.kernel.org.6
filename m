Return-Path: <linux-kernel+bounces-245053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CFE92ADBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3711F2211B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984782837D;
	Tue,  9 Jul 2024 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN0P/x4D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D407A110A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487843; cv=none; b=NDrE7p7SEtA16PK5dFUren1zuOXfLZXkIx+oVLcR9TUc7ec9M7YwDGsFDRh+lBbTFFCG+rjuykCkyU+mO2V8k+lrMJLtKSCT/Et8Xvh6yhnx3ZM+t7iUvyEX9dsDKtrKxK299uxaQDTi90fK4Jn26x3uLcghPOhiGGZ5UqTS4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487843; c=relaxed/simple;
	bh=obnbwPM8Tpsz4jf1AHrjx4tSMl96mYa3Fvrpjx+z21I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIFJ7Nq14cwiRbCKCAu+gY2zU36wgJXkXxYWQiH63jQ2X7PqP5SoXm8U+KGamaWiG7H9hTsoa0xlx1yqqBswIBwa+kcLsJpYyOWHCl4dRWuGJQOoGo9yA62t+9oCzQHVB9uQ+O0rGKdgxE1WYiSmUsauVjIklOc4augm7vkmLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN0P/x4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532BDC116B1;
	Tue,  9 Jul 2024 01:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720487843;
	bh=obnbwPM8Tpsz4jf1AHrjx4tSMl96mYa3Fvrpjx+z21I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sN0P/x4D+9+rWA8LmSrSb+ki4i4/8WyLjMaBr4Brqk+fek8mLeHFGzLVUB0HyD5QX
	 r9Ogl3gfqGbI5ubQko4odU4EQ+Rqbyktb/y312R+hxdwU0XLab3lHj2/HYGyorp2qN
	 jyStudvaUxObIYjXLE6H1j8OmBt9I9qsuOYDdunXxpdFqn+m9Blbt1oiXZtV6Cxvg1
	 fRRTvPtdzmFGtUHM8isOFVScq7aymwkXjrjf8XTIEsbJYScAWyQ5dSBW4sSCYjiUkH
	 dMxgp6gSJlXptrorUeyuOwdVKJD64p9EGu+4x2trP9QqOYEd47A7AOYgIhemQnAu2I
	 ZYsxIy7TbEtSQ==
Message-ID: <2627d1bc-17bb-467b-8ba0-fefbbe9c7c44@kernel.org>
Date: Tue, 9 Jul 2024 09:17:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: fix start segno of large section
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240708120407.2807639-1-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240708120407.2807639-1-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/8 20:04, Sheng Yong wrote:
> get_ckpt_valid_blocks() checks valid ckpt blocks in current section.
> It counts all vblocks from the first to the last segment in the
> large section. However, START_SEGNO() is used to get the first segno
> in an SIT block. This patch fixes that to get the correct start segno.
> 
> Fixes: 61461fc921b7 ("f2fs: fix to avoid touching checkpointed data in get_victim()")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

