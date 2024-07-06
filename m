Return-Path: <linux-kernel+bounces-243341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE19294E7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 19:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AA21C2146C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8F13BAC5;
	Sat,  6 Jul 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MHDDcpNJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF138FB9;
	Sat,  6 Jul 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720287176; cv=none; b=Kfaiqiw3zky8cTofnRuDHqUevjgAIEwERLu22vVwe/gqKmuwFsiE3HXZaMPIPI+SDa7vFi/XifOrNaX4PUGCcnWr2Q/MRbfMHEQyWh/5VYTU4II5jm3PGPPtHiIuJ3WhHG7hV4kH57P9wsvbNKCDoso6bCkGgFeCmiByTXJK8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720287176; c=relaxed/simple;
	bh=9dnnbKPbftHghV0zYZgPx3alIVM+Chv0BnenmnFrCo4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Xm65EKs/FE/5JldomdOkN8eQmCm+amH7eSfiq8OqFVr3D/Z1Gb7h+vD1P6pLKO2yNGF04YBrQxGKDinqjzJ62o0q3g66aBc37SmQh7YE5VYJsxpVBr/7e3dx0Ktn5XUo/3yo5Sxb5FZXk92IMruYsL78M80q3tdOUZkqy6G5P1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MHDDcpNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9480EC2BD10;
	Sat,  6 Jul 2024 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720287175;
	bh=9dnnbKPbftHghV0zYZgPx3alIVM+Chv0BnenmnFrCo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MHDDcpNJet3iZAa0Os5C6cuHQ+F2oDgNqhASpRlL51Dlx8ibnEtbyS5WBb9qeuHwT
	 teYBNrFlLOv3HDIJkRKNgWGQdE+AldlAxDO5w5NLAs9aUk7JDjK6pCYYv7RJLSn3y2
	 d9XMgGFGziTmaj9/eMLqKxzzeX4uZCiB7DVope6M=
Date: Sat, 6 Jul 2024 10:32:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed
 <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Domenico
 Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive
 shrink
Message-Id: <20240706103254.ffd02d7036fa3fe43dbed806@linux-foundation.org>
In-Reply-To: <20240706022523.1104080-1-flintglass@gmail.com>
References: <20240706022523.1104080-1-flintglass@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jul 2024 02:25:16 +0000 Takero Funaki <flintglass@gmail.com> wrote:

> This series addresses some issues and introduces a minor improvement in
> the zswap global shrinker.

Seems that patches 1 & 2 might be worthy of backporting into earlier
kernels?  Could you please provide a description of the
userspace-visible effects of the bugs so the desirability of such an
action can be better understood?


