Return-Path: <linux-kernel+bounces-270878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6E694468F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0A31F2622B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD3416DC3A;
	Thu,  1 Aug 2024 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyFUfd4m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAD16C85D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500813; cv=none; b=BYl0yyVsyz32z2AvTHFnJ1Wa+i1tu7bs2R8wZZi0IpeTM7WVI6gMe1kpx/z+7Nfa97wZ0S3O3Aeo/zjYaPIQHwqUIQ72FJpxOniBIlLu86saeIt81Y2RFKib81+ic41WqeEu+uilC3kucCDSLYDIRY4PimQh0APMWGWYKl9ombI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500813; c=relaxed/simple;
	bh=sK9uPwXODAOK1618LJVzHYiKRa8fhsRB/2eNYrf/lMs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lHn7zuKzCMNEz09bI7ebT1mbls+xp425CpuSRYoihDy6FzSOFqukZtdqvndC1BNpnwQ4YUYfSa2/AheutZorLdDfL339WyZm8Nc7FoWehMvVVc1MqU/4rU8kCrMfC4rkGg2N5JtfRMRWac8eJRcCESIRlop5eyJ8vPEFWWEXA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyFUfd4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31ABC32786;
	Thu,  1 Aug 2024 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722500812;
	bh=sK9uPwXODAOK1618LJVzHYiKRa8fhsRB/2eNYrf/lMs=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=qyFUfd4mG1yQQMnzIn5qETY+aUMEnj6QpgOX0JCarOO4BfWpw56Eo/5Wjc9LeXfU5
	 FGszwS/rZgITWrZjhdmM6mvCSM8oyXJnDN0Ybtu5y5iGKIbw+dnWHMJR1L16Q9g31d
	 qrsXucg68M7ti+HcnHLqQskvX6FRBjepdFMzhJVxDlgY85r6T8HPUS2WEf4lXdg7xG
	 isr7JiwAczyKcVBZVZf16ZvX7CYnkDd2DK0Az7tjxhH2TmYCUxg8tOk6E82MkG5bQO
	 eOVEc+LKrjUHIhX+vdXms0e+E7Qyyz37QSZvSk5Sfggkq2r8oL5aGqqsNRqTLeC1mh
	 S2Zt33+/RBSdg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 838771473D52; Thu, 01 Aug 2024 10:26:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Rosen Penev <rosenp@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ath9k: use devm for gpio_request_one
In-Reply-To: <20240731210052.6974-1-rosenp@gmail.com>
References: <20240731210052.6974-1-rosenp@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 01 Aug 2024 10:26:50 +0200
Message-ID: <87le1godh1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rosen Penev <rosenp@gmail.com> writes:

> No need to manually free the gpio now.
>
> Remove if statement as it's redundant now. The gpio bit now gets cleared
> whether set or not.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

So presumably these will conflict with this patch?

https://patchwork.kernel.org/project/linux-wireless/patch/3b46f6c7-4372-4cc9-9a7c-2c1c06d29324@gmail.com/

-Toke

