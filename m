Return-Path: <linux-kernel+bounces-306972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD928964646
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A021F215C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123A1A7047;
	Thu, 29 Aug 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcF8wSsy"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B118CC16
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937490; cv=none; b=gKwlbsUKw704jP8wborggwGO0o6idpp1dUT00GASj8dYpxWu9NpuN+OFj4b+WTwBFeCdus7t7G+FmdKqa+q6quS1bmNgcSmnS9L31/eo4uuLB5T/huJUc3ZATm3HjXNamGPIPl9ZozlJt5fkL/6+9ef7jxQ7y9btwRDUPKV6NXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937490; c=relaxed/simple;
	bh=2MmB29rKAnws/xNhn07vrihc2y1nGw1w7I0eW9HsGug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA+YfQ6qut+3EwuTIZq8EVVaDt1xQnIG3gziV0FRhCXFDUgC51VjJhVWz05DhAXyc+DX89IWSAZGfCOVX9NSgbukejl0nXJA3Cx33h70au4zto7aFDGAY3r8PXpj+cmlUMzp7FPaA18jNa/LRxFeTL1u+vBbVaFwgVSisqaWpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcF8wSsy; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e13c23dbabdso617852276.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724937488; x=1725542288; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2aU20A/u0/XqGV84fVcWPLj9pv6NSG1S9p41dOwNq+0=;
        b=PcF8wSsy6MyQMDPJmaqjZe/Pa39niYNCS9QJITC3Fd7n30oC8LTvXdeYH/fYd5AROc
         0xL7mKnIdCIAGLuqIxwnKMbSY8eoncGFlm6QgSy50yasMF7kQgNHSahR7kfRlX0xD7Ww
         ZdX4wUSRUfDcuTGDoPvO53dWC2xsEScaYc/4tbkUFjPofSAj4XE3Mf3PY8hdkWMGF/U6
         e7fxqihfUv8JiOw+fw2MBnskELUjQqoFaXOHENODcO9DtSbUmMKEA282Xq2BrY6th0A2
         Oi//lLc37IqroMCPiWmF0s6b73DDrzF4TXWVd4YyO5DcPxBwcb4y0CkjsZPJSTdsAgXn
         3GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937488; x=1725542288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aU20A/u0/XqGV84fVcWPLj9pv6NSG1S9p41dOwNq+0=;
        b=v7c6B3JSPkhiBcOlG7Bjbkja2VQkouR5gHeSap77x5ryzA331TYR5IrxDkdCMQdRZW
         onT7c42wMUTZm7XsiBnYhuL1gttnbttXE1B7fFBfc5WIpawZLnD2Qd3lHtpWE+Qt/yMJ
         PbPL0VlmZ7zG0jnOTsmqDQBg0oubYyrLNzD4VJssDdyZNCm1my2CoUoaURzdz5SOhwn/
         lPu5GigPR6ctgkxLr8oZ7QXsZtLeu4bnV63Cbn8GDyY9NZuuwD8zRGmUZKEPL7A9cfmg
         DH0N9p2xksWCviJCm87ntXBEm3YUD24RJul5iIxXw2usFhicbcMqHMX7NNFOBtwixHhK
         6T4A==
X-Gm-Message-State: AOJu0YyEf4dWjmhG7hoHETEDPxKCpiqkntJEYUfXj4vckmQXHGuLNZPB
	FZhDX2mIrjsdGPgtU7a+9UK6IpsX/y2JhOx4GkGV5nNSjucA0jOO
X-Google-Smtp-Source: AGHT+IG++QYfkH8TebRveL61VPS95T5xn3u95IDwNWUjukvfa5j03w/Yi+1m9KwL1YwY0GoCQ8d+5Q==
X-Received: by 2002:a05:6902:2504:b0:e0b:e1da:e711 with SMTP id 3f1490d57ef6-e1a5af0b737mr2669350276.40.1724937487874;
        Thu, 29 Aug 2024 06:18:07 -0700 (PDT)
Received: from localhost (c-71-203-131-184.hsd1.fl.comcast.net. [71.203.131.184])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1a626e58e5sm231749276.40.2024.08.29.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:18:07 -0700 (PDT)
Date: Thu, 29 Aug 2024 06:18:06 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
	Leonardo Bras <leobras@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2 0/2] sched/topology: optimize topology_span_sane()
Message-ID: <ZtB1Di1ysJjSZgTc@yury-ThinkPad>
References: <20240807190522.432388-1-yury.norov@gmail.com>
 <ZrzcozFadC5xQdUq@yury-ThinkPad>
 <Zs8vmpwY2Dt9s0Ei@yury-ThinkPad>
 <97643a07-bc9d-41d5-8e3c-e251f510129b@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97643a07-bc9d-41d5-8e3c-e251f510129b@wanadoo.fr>

On Thu, Aug 29, 2024 at 08:11:41AM +0200, Christophe JAILLET wrote:
> Le 28/08/2024 à 16:09, Yury Norov a écrit :
> > Ping again?
> > 
> 
> Hi,
> 
> The covert letter is v2, but the patch below it are without v2.
> 
> In patch 1/2, the Suggested-by: tags in v1 have been removed in this new
> version :(.

My bad. I'll send v3.

