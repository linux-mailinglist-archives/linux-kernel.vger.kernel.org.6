Return-Path: <linux-kernel+bounces-231272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A4B918A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B824B25219
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995818FDC8;
	Wed, 26 Jun 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="R8E9OSZL"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A081618EFC7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422780; cv=none; b=WUZtG91KpJ9SjI1fk5ong7LBXxxgWaI1wAkA4MLqk/+uesnpNFD6ftCp81asojAYfVbknQGv+vEOp4EOBvIvXNmSElFvYGDg1HgK5e6/jvMAqjptzMf3tQr0H1DeoAeE0qFULLVE2SumuQFkPhJy8GJBINFe/3A07iIpZSeAfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422780; c=relaxed/simple;
	bh=hdziQqMIHtmWYYC3U6YBP0fNbpLTLhpowDVrFRHdLqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MS8TzxceWAa9Eek4rBk6L63qADjFzWIdRhGfZbYUjNElOWSps7ljsSF4tCLcBZu+H6voGV+BGCzol1TVxfcNSCHXCHg9jsC45scVE2ouSVknuQghYy13kSuqxs1G6W/eMH7SApdBID0uRESrl5nVd1dkrzlc21ILAB8G5pbx1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=R8E9OSZL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f090093d8so4567169f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1719422777; x=1720027577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hdziQqMIHtmWYYC3U6YBP0fNbpLTLhpowDVrFRHdLqM=;
        b=R8E9OSZLLjUbI1zH3h2O/eD9WtOrhjUg6/BvIu+VGv1Csjv1WrHzAMrFy+hCRYx7V+
         LzajrXuly7+gIBq8rQ5/tiGJxHw5fVhbv2Oyc9k785VGaCDenL1AzSRmPDJzT6BdIQhI
         2aYNNTaVYSiN+XIOe1ehUtLBe3kiVMJ6Xg0wQHBxxL5Fttx1X+ymXe5I1lqJG8ffoIKC
         erApeAyHX7bUoqKjmZMURVlri+9+RBLeFhJBcF0Qc0JBODyiYWfJ8wo3PQXiG5RlqeZ3
         32eeFW95q/2n0m/ZPX8XaMPm6U8hGD51eLkVBJoALC4YuVC9P+SGzCeOhsYkPTpeHGXA
         5j0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422777; x=1720027577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdziQqMIHtmWYYC3U6YBP0fNbpLTLhpowDVrFRHdLqM=;
        b=UiN7xwMTL/hNpGVll3C8s8twFbf7E2n57a1x/V8rXYDi4dPQ2+LQhBeE+hH3LCTWp3
         qdaIay3YeZpn7HchQDyBK0K8kT4MkYTRkDke8GMrun7aMCYHovNkxtmiiAurG+p3EEpw
         ptMXczEvib5hQv8xOT6DkP/uHqC1VCHsrbgBrvh47WT32pOGZaF4pPzRBxpOlFTGi/yY
         nZVxVS6jq1PyW/RxJ15fbPpnXLgIx9Vk0shFx6XyeQXhyP7sPYrFsWV+fRlS8ZJ9vH/H
         vCQZZ+Mst8OkymJVPfwOLM0Cv3xUhT70PTh2Qn2eXrEnCWGNBsWkg6heXCslTKeloB2A
         fqmw==
X-Forwarded-Encrypted: i=1; AJvYcCXyy/IAMWhCQqy9jg5/pbJtK2oOLIVlGB90e9AvxrhVI55bQbPoez5077PPGzf2Oqg5taTGvBqfaxuUPvjb2gebAKy8dGWx5RGzTpMb
X-Gm-Message-State: AOJu0YzsXGKc8+s/MovByOGF+I5NKdNV2UQF4cfT6zJVyIVEB8vvgRal
	aYDHsfUiKmk8v7cApPVWD1/lnkuBjrd2XPt6ypsON4DB48dCZef4ptDXeXDnZql3RZH+x/kU4xn
	bCtenA9tZVwpLuLQpQVZlqXIxxalcxs7mWfAFWg==
X-Google-Smtp-Source: AGHT+IFahjV2p+0jb7TmBNawhEs+kITz8DpgAILl/YOsslr05y3/eAw+boWA26XBNXr//vtV4EDunrUcL09OOlQ4xTM=
X-Received: by 2002:a5d:6c63:0:b0:366:ead8:6019 with SMTP id
 ffacd0b85a97d-366ead86044mr11222202f8f.49.1719422776897; Wed, 26 Jun 2024
 10:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625122605.857462-1-jmeneghi@redhat.com> <ZnryTZqwlz61s0D4@kbusch-mbp.dhcp.thefacebook.com>
 <ZnxHwNflN3l9EN8p@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZnxHwNflN3l9EN8p@kbusch-mbp.dhcp.thefacebook.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Wed, 26 Jun 2024 10:26:08 -0700
Message-ID: <CAPpK+O0SneKwOKqPZ+aw7=_1=xqKHOs0p6+reeA+r0=u2rLiyg@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] nvme: queue-depth multipath iopolicy
To: Keith Busch <kbusch@kernel.org>
Cc: John Meneghini <jmeneghi@redhat.com>, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	emilne@redhat.com, jrani@purestorage.com, chaitanyak@nvidia.com, 
	hare@kernel.org
Content-Type: text/plain; charset="UTF-8"

> I fixed up the suggestions from Christoph while applying. Thanks,
> patches are now in nvme-6.11.
Thank you very much!

Sincerely,
Randy Jennings

