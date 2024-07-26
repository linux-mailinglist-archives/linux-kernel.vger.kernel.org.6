Return-Path: <linux-kernel+bounces-263103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B426C93D11D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6892D281FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9543D178CDF;
	Fri, 26 Jul 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwSMSxLY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF62B9C4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989652; cv=none; b=a9B/hyvham2a5kdwdFCkj++dqOVu7HeFSU1GBJvrkX1Fx5JKm5jo7OaviLtOWdQuf0txXxS06TClevUkxhNYYt0B55ElSdlCeePngJ37+rLxissJ6dN+RuLYiT13Hs06qpwO7gJOehHkTcVDq29mwr8q8RUQvVTH/s/ERnEeUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989652; c=relaxed/simple;
	bh=gqS+bnHGN3PI1lQgIphwTZ959H8S8VAnVlC3KPa2a3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOGdVWLfrHygmWc3RVjnNyv5xBUxE8OiXoPt2qoFowI7HpRoV1gJg6XEKe3P6OythYEmtu9DIidLvB3EzEaYdwGgMatTZtLeSn3g1m5oacPDJX1b7V/lA0Ki+UEcjWz6XR/V/GdPVCOLkt2QpJRxCR9gjvysgQLyFKigZM1usC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwSMSxLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAAFC4AF07;
	Fri, 26 Jul 2024 10:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721989652;
	bh=gqS+bnHGN3PI1lQgIphwTZ959H8S8VAnVlC3KPa2a3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MwSMSxLYfCL4rlH6vxbnbqPKhxQFS9MesvJF+JIuRjE46O3m43gXAzzIvA8Ded27F
	 L0+VdGj807p1jI5By7jehYJbNFlkxv61q7DuveVya5YD18Utrf70CWLyNFVlKPiVdA
	 paq3CBxatc4aQBqLSXJUHFeTw3ua7CzXBZ8VDVG+ch//ZmvDXJdjwt6x5/Iu8+33qG
	 QATc+Bpr2Jr7tkmohgVkO1Sy3bpHTuKFYuVjzyMTok+ZvGuN5l5WqN+DJUn8DF+prz
	 110VQ0q3H7fy3ZX7emEV79WWSct73PNCaMZq1EKZBMHj3c19QBs2PnMRqXwWQFyCP9
	 9jbBKUUh9dVJg==
Message-ID: <68d18ae4-88ca-49fd-b105-85eb3f48715b@kernel.org>
Date: Fri, 26 Jul 2024 18:27:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: support multi-page folios for erofs_bread()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <20240723073024.875290-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240723073024.875290-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/23 15:30, Gao Xiang wrote:
> If the requested page is part of the previous multi-page folio, there
> is no need to call read_mapping_folio() again.
> 
> Also, get rid of the remaining one of page->index [1] in our codebase.
> 
> [1] https://lore.kernel.org/r/Zp8fgUSIBGQ1TN0D@casper.infradead.org
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

