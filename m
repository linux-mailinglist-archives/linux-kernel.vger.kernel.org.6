Return-Path: <linux-kernel+bounces-565709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2EFA66DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94C7175192
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D8146D6A;
	Tue, 18 Mar 2025 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="at9NJmn2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBA205513
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285708; cv=none; b=cfB0lp9go7Uxr0hLmA3BTVsrZdOC9X/6NUGqep37DPBInR0Wdb3h6wxHVj2n1r2SOrvN5HSdTNftWJ7VN2oBobdT2kzvcm1zjh1uecJw1iAnwicAg6+HLyjDZahzL/rEbMjordbPk+Dk7of2Gzh+fUyeLuSI8Fd5GdcUEtmg0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285708; c=relaxed/simple;
	bh=OZvckXs1wdPAxti84kRLJiFsAU0LBEGmtOzq+PD43x8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jxNm6sXaAYyi6fSwDE72J/6G4720nx22hc6CkC4R05t9VYfCH7oZPSrZ7LAUpO20nLGYLNSkSG5TflpwOBEdqpFa79/VQXoNdEvNQ3fPxv/qwPprsHmR9C+UEWptI03PfC+uZv125yBD38KBPXGTU0FlisWIeWSFf6sSlfanKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=at9NJmn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC706C4CEDD;
	Tue, 18 Mar 2025 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742285707;
	bh=OZvckXs1wdPAxti84kRLJiFsAU0LBEGmtOzq+PD43x8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=at9NJmn26B/uhsCV3iKXF7FpFwdefvjS/6bOqcxgrPHRU51NANCf735YLbdwY0f9Y
	 HwMrzQRZ0b4mSQDHqXgxUdja4dyJnu81wr+K8tPtoYg1mdTbzxm1BLGbl//hOSlQ40
	 c5PBBchI8jgwLD6NUfprbqM54S9VlW0567KAqmig=
Date: Tue, 18 Mar 2025 01:15:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jing Su <jingsusu@didiglobal.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dql: Fix dql->limit value when reset.
Message-Id: <20250318011507.5b86cac6bc808f49c5447e78@linux-foundation.org>
In-Reply-To: <Z9khNixRKEVRG4Yj@pilot-ThinkCentre-M930t-N000>
References: <Z9khNixRKEVRG4Yj@pilot-ThinkCentre-M930t-N000>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 15:31:02 +0800 Jing Su <jingsusu@didiglobal.com> wrote:

>  lib/dynamic_queue_limits.c | 2 +-
>  

This belongs to the networking people.

get_maintainer is silent for some reason.  So using `git log
lib/dynamic_queue_limits.c | grep Author' suggests

Author: Eric Dumazet <edumazet@google.com>
Author: Breno Leitao <leitao@debian.org>
Author: Jakub Kicinski <kuba@kernel.org>
...
Author: David S. Miller <davem@davemloft.net>
...

Please resend to those developers and cc netdev@vger.kernel.org, thanks.

