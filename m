Return-Path: <linux-kernel+bounces-407174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835E99C69AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356BC1F25816
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EB417D341;
	Wed, 13 Nov 2024 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dQY03K/a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25E230996
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731481606; cv=none; b=cq0n90xumlZ0FI9CcXzzIOtiYT7GTcjfffVYAfZsc0D8AB+kmukRAr3VTQcuwiuw5wHsjwUJ8g+LcY/LOC6lANtmcSYAjG4192pccZCuUKqlGOAPV2GjAg5cR7rQh5rev1ySsMJcoFeLkNULO3/JKvJq7WDBNwXfDEUJPpCVO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731481606; c=relaxed/simple;
	bh=M5qxvfjeX8zm3X4cnPusqZs4KtLcO+3neliyehKO66o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LtzUzKSGLgr0E4fRymIhtLaYCyD4uQJ0XJu0/lAIXZsq8s+DYA0eR8Yjf7hRVthSbM729OOu3Motol5eeL3DTo42uGwGX1Z439G88kInqm5BQy/im72GpowpmYRm+GeTMgZF5xEKrKca68hjk0yuVKkQlQZIpJAsv3++k3ZN07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dQY03K/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699BFC4CECD;
	Wed, 13 Nov 2024 07:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731481605;
	bh=M5qxvfjeX8zm3X4cnPusqZs4KtLcO+3neliyehKO66o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dQY03K/a5ff4CVtAJY4jZ2nFifaVnecEcbnac7qZpUq/arw0+yhJKRk33TnhALB2q
	 xww3Gpgy4fWJ0UlorAx1gjLm/QNetaiySqGjN7JBAIPZNdury1Bjd++S74Jo1OUksp
	 Z8QQCpKaB889fkknSLWZ/+PbJZfTR9VicESk9wwE=
Date: Tue, 12 Nov 2024 23:06:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Kent Overstreet <kent.overstreet@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <catalin.marinas@arm.com>, Casper Li
 <casper.li@mediatek.com>, Chinwen Chang <chinwen.chang@mediatek.com>,
 Andrew Yang <andrew.yang@mediatek.com>, Elena Yu <elena.yu@mediatek.com>,
 <wsd_upstream@mediatek.com>
Subject: Re: [PATCH] sched/task_stack: Fix object_is_on_stack() for KASAN
 tagged pointers
Message-Id: <20241112230644.cfe24aa5e863112de04b16c0@linux-foundation.org>
In-Reply-To: <20241113042544.19095-1-qun-wei.lin@mediatek.com>
References: <20241113042544.19095-1-qun-wei.lin@mediatek.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 12:25:43 +0800 Qun-Wei Lin <qun-wei.lin@mediatek.com> wrote:

> When CONFIG_KASAN_SW_TAGS and CONFIG_KASAN_STACK are enabled, the
> object_is_on_stack() function may produce incorrect results due to the
> presence of tags in the obj pointer, while the stack pointer does not
> have tags. This discrepancy can lead to incorrect stack object detection
> and subsequently trigger warnings if CONFIG_DEBUG_OBJECTS is also
> enabled.
> 
> Example of the warning:

Thanks.

Are we able to identify when this started happening?  ie, a suitable
Fixes: taret?


