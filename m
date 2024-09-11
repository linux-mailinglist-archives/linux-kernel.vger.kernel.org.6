Return-Path: <linux-kernel+bounces-324109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7419747FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766C61F275C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0142C859;
	Wed, 11 Sep 2024 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJOcBqdp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B5E2C190
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726019740; cv=none; b=ChebcqCsWgzQD9Vw67CdOIrsohgLzso89CmQTf3oqVxmBRODBNGhsvHPMNCMDKZFlb5jnQ8xfvztvGvMeY5YA6xYT3xHZIaoygzqJWRx6OFb7H+KGl1SoAg2FM4tMgHbVKl+bpP4JTkw51uctrVynrivsRGOROUY4Cw1CxQuibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726019740; c=relaxed/simple;
	bh=u22K8r9foXtr+7paujcJ/ApAdSro5EUyd4uHs8UiTWQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VBGjauWO3O9Nrv4e9CDWD5oTZiC9HyC6iRppKTrs6OETF1qA6hAjhFzqCdOBXHlqDhukCc5Qhgtk0wA4uyEKtAbSwVvMAdtk1TQ6R/6q3bHMIB7nn0bWwcippz/JzV+YXf9Ug58pNJLHgtk4lKOvZz6bezPnJu4Y2o7reug9fVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJOcBqdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1339C4CEC3;
	Wed, 11 Sep 2024 01:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726019739;
	bh=u22K8r9foXtr+7paujcJ/ApAdSro5EUyd4uHs8UiTWQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UJOcBqdpkhjNEjtwPeckjcZkC5vhfqQnSNXYggtTurPkk4ulDm6K/ywpk2BP8qG9v
	 TsjjVAi+sIN7mGof9s76EgdHXonMAriDBjllSzcvwkUBaGiTM6qRK/r/B3bS34aLft
	 Uz8w2/NpnTkysQV85tc9fUItZJCZ07T9KE+7Ix5qR0NjsGOQBtWG3KccglccbWHEmi
	 phgR7AN0QyeBqN3cj8H4kYfmQ4zP3ycrxuGCNdpQf9V0Zm8wXmx7GyXoXLFXX1iGn9
	 fisjVjxDoMnIMffVbD0mlM99dU07mQKY2F60zTw1orXPcCEh/LfOQPaTdU4wjzaLkr
	 tikzNZNDMBGzA==
Message-ID: <380e8cb7-b3b8-4634-9e61-1b622d2bcf45@kernel.org>
Date: Wed, 11 Sep 2024 09:55:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: remove redundant i_ext.len set to
 zero
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240909164535.1926830-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240909164535.1926830-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/10 0:45, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Removed a redundant code to set i_ext.len to zero.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

