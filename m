Return-Path: <linux-kernel+bounces-192773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40DF8D21DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0CC286986
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6FD173320;
	Tue, 28 May 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZI98vM1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810991DA4C;
	Tue, 28 May 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914778; cv=none; b=IKwpU2O5+dAclPxcxIzcQX3n8NbBdnf0Xm9UKB4U47pMuRPZ2Shtqbub8PlLLcM3wYsepoo9BItHnNuOccjVCHksyZU3Gb4a/oCk4RyZXalAuF5aPkzCPpjBIDZblnuFsUAynhY5TDf69xpzbJBrqp5X7ccHhCnz7sgXvMSf+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914778; c=relaxed/simple;
	bh=TBDbSkYjUyl2imYhMy6xaeLQMRP0gJiFNyUlwCfZ240=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVyEpLiO540INqUdU1sbcu/HQPAD+TwJ2mbokR2DC05+pq0DVKKKT7Vu39bFU/afIDWuOlirIBbSkXh4ZIht7qgPrCxF7QGn7GYoFYHKwFyZa44NCP8p2QGyQDRNlIxRCw3Gjhw1HWKvO8cg10rRl69NLocLtqbVuR78xlhz06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZI98vM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81368C3277B;
	Tue, 28 May 2024 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716914778;
	bh=TBDbSkYjUyl2imYhMy6xaeLQMRP0gJiFNyUlwCfZ240=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZI98vM1bOWvEdMkNd8NbsCBpuWkqoxDAMKRXwMT/1FT5Eda5GPIiYwce+6WigkVo
	 fyfIeq9NsgGRSfV95t9QvKmfK0XQnSr2xDgg0+jGQH+d/683cc9orhAtHO7Iw47DEq
	 pSB5KK8kXrrA2yLm5Lk5lAS8NCRlaqkzMZWd1lnV6j5gWEYRANkP85N2SrmicwPnzD
	 ouRQwPmLfqzpj61QQxVG0+zpbF0GnNRri/5C8k99dUlofbdW87mn9EE6j3SGRNyRWQ
	 bCG8YO+q85qDaPvXm001cpSDnEI6S+zTPd6l5mriFmiBmqo3r77PKfDrfu/ljMUxd+
	 iN0amIJWSt7Eg==
Date: Tue, 28 May 2024 22:16:14 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Bard Liao <bard.liao@intel.com>
Subject: Re: soundwire: fix usages of device_get_named_child_node()
Message-ID: <ZlYKVtymA3zNe7VQ@matsya>
References: <20240528063533.26723-1-yung-chuan.liao@linux.intel.com>
 <0080bd18-58e1-4e82-96e0-e64d2fa978c9@web.de>
 <9d5f2625-f3e7-4212-8c9a-c22f137f39d9@linux.intel.com>
 <a2036c46-0527-4ac3-a40b-c9c2cd3e185e@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2036c46-0527-4ac3-a40b-c9c2cd3e185e@web.de>

On 28-05-24, 18:22, Markus Elfring wrote:
> >>> Add fwnode_handle_put() to avoid leaked references.
> >>
> >> Are you going to respond also to my previous patch review
> >> in more constructive ways?
> >> https://lore.kernel.org/lkml/eb15ab0a-e416-4ae9-98bb-610fdc04492c@web.de/
> >> https://lkml.org/lkml/2024/4/29/493
> >
> > Sorry about that, both Bard and I missed your comments.
> 
> How could this happen?

Becuase your emails go to dev/null for most of people!

-- 
~Vinod

