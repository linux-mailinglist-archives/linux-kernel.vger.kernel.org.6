Return-Path: <linux-kernel+bounces-239052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB29925575
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB28A285193
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6813A402;
	Wed,  3 Jul 2024 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH+Uo8gY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB94D584;
	Wed,  3 Jul 2024 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995675; cv=none; b=nia1edO6XRKt/Rs/SrZo+03in0CtsQSwNkesfn5xIvy1XK9fewoQdUJ4RnOpzHS5thXnDBDCxzKRbD9qQyfXOGLJmbPzWDs73EUJDgaMAULG8P2UGd9/oy30af94rxXJlkFDAq/l/vr6/cXVShhiSafLM5796nsowDh06o/EM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995675; c=relaxed/simple;
	bh=w6xg1fyr7yWh81UufQwP4pvlK6VB04D0mXQfOGaYspQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6BPkLQeWb2jNJWsnZFnfb3wkJ1RCyJeua8JCmmgaczVxzWzCgvVTnvptd/qvThpGv76IB4kdQkcsvdQZUUkvvcrI79SFaRMTWsQowaZLkR6fT9ePsk1BJiyUWV8Hm3eAh8ptCbK2ZXfD9xkQcUJFFUviW9U+WBn6Gk+cgPqqyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH+Uo8gY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9B1C2BD10;
	Wed,  3 Jul 2024 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719995675;
	bh=w6xg1fyr7yWh81UufQwP4pvlK6VB04D0mXQfOGaYspQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aH+Uo8gYQNBm85rnqkHTED/XB6kbeYQhUIlf8opLkg4ZhygWI4moPJXezmu3tgs+6
	 tnkC/eBuqcisvQlSpKdS+v+1vSYU1nnx6k5mlnp8nOt5wxdVRHhKOI0qK7xasMLiZ7
	 J4exc6yCxVat7oQWxkSkxvb7O9PCj+6T3j/S0nA2uieF94rEe+HFRs5EO04yDX88cx
	 SGy8dHBBdzh3axPh8cgbuN2iSiA2o7Oy91Tn9Asta+bBRGnbEKVjHkXBRu2tKvERxQ
	 yjJvJAj4Qj7GR9qukWqpEmSlSzI+otqOKpBtI05/x+PI6Zsb9cDJbbySwn3a1dmkfl
	 2OE9Fw3FQHgZg==
Date: Wed, 3 Jul 2024 10:34:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [lockref]  d042dae6ad:  unixbench.throughput
 -33.7% regression
Message-ID: <20240703-stornieren-achtmal-ea2fa1422bea@brauner>
References: <202406270912.633e6c61-oliver.sang@intel.com>
 <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>

> 1. this patch should be dropped, I don't think there is a good
> replacement either

dropped

