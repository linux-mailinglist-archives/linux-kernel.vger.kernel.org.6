Return-Path: <linux-kernel+bounces-413753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0629D1E39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CD7B21B15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97313EFF3;
	Tue, 19 Nov 2024 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdWI7GlN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D773113A24D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983120; cv=none; b=sQF/AJHtXrVufmwp1bjGcfSOUTHub2qFz/eZLeu5q5rfjM76YsQz000mAqu1fKhrVHOC8J/LNAVCVc0cCi7pUAqDFpEOOwiacwzm5uBczLd6uRdpgWSi68KEMFZZYAJFjbL+LehFYqYkoha+TA+9S5F3DxBh3Bb9l4HdWGIclRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983120; c=relaxed/simple;
	bh=47dpyttEFDhx+veDJNsZewL8yCGD1eo7OSN4BfBOvoU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j4d/JfMj77K1QnVlr8tURYmYWGVFfBZ1RehtEEay8V3JVQesscWaLbTTjqInK526Uz5ljplpSoL5t+U6izGCx+cA0tD/ZFZNozEcZEVrDJA/w5TMIpSu9MzQpMo6jjVKl9ZuEClqe/NmRbIiQFtx0VI7kp/wj+Edg5RPsmLeW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdWI7GlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61061C4CECC;
	Tue, 19 Nov 2024 02:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731983120;
	bh=47dpyttEFDhx+veDJNsZewL8yCGD1eo7OSN4BfBOvoU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BdWI7GlNPZBMyb++DxqvUhl3vOlymrTcATZfgYXlV1muOoWixVq5bbWw6445paa3E
	 /Xj21pd/bqlFGhvn9ADcWc+sRUU9vtHPIPdmkd+S53j4jfFR7bFvqdg4N1T8113YRa
	 NMqFcxO5FXsLoYIGuUwkKxO/G0dVPKjE0PRLD0EVr9bKcC6dpiLHaIils4MDCHOjqu
	 XDZIDlMW8NJA4ld+0teDchuZWeo7zDEEOdeaTL9T+vBCrYu62hmvTlipTMQbD/0Gjf
	 ru/6jAxmUsvdGRuxqbgV1ia5IoXy+LC80qKTnJXa9F67Jfk5Z11wLjtF+PwDa2X7wP
	 kiFYnel7XaZ9Q==
Message-ID: <405f3117-efe3-4d5d-889b-8fdfa87d30ad@kernel.org>
Date: Tue, 19 Nov 2024 10:25:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: adjust unusable cap before
 checkpoint=disable mode
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20241118184535.1047327-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241118184535.1047327-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/19 2:45, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The unusable cap value must be adjusted before checking whether
> checkpoint=disable is feasible.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

