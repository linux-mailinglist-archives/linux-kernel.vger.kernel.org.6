Return-Path: <linux-kernel+bounces-270619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E2994422C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992C1282C51
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE0513D8A6;
	Thu,  1 Aug 2024 04:16:06 +0000 (UTC)
Received: from hkg.router.rivoreo (45.78.32.129.16clouds.com [45.78.32.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0D91EB485;
	Thu,  1 Aug 2024 04:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.78.32.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722485766; cv=none; b=ETocADd4UfPCQPvax+GvqgkmqIz3Vf0JhYXqzPePQGZHGQsyLFt0APRLaDGRxvIa5LegyBxYCQKZAwuRQYItusPWtQEn+YsJuaskhb6j0m6hSrn9Bg5u0sOuUv8wTx/91GxSysKvB4/99VijIgCw4yEMCwaDcmyUisIxeJTFb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722485766; c=relaxed/simple;
	bh=YD3HyOBoKOyPQMt777seW1EDazfNA+9gsCp7WKOR49w=;
	h=Message-ID:In-Reply-To:References:Date:Subject:From:To:Cc:
	 MIME-Version:Content-Type; b=ZGo4Qmzi8q9pz+PczWxaotGvGKf2E+2zaNLCOwDYbwQGGOfDueaFnwbM/nvLB9JViJoUKEK2JnMPRTU6xlK9MsG9eb/x/rgDzSe5I8qu9ej1Zqa0RI79+w5UJL4bGxhk3Wrc6WFoTGc9HUTEDh60EPwJ8JaOV9PbP9ccglPG78A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rivoreo.one; spf=pass smtp.mailfrom=rivoreo.one; arc=none smtp.client-ip=45.78.32.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rivoreo.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivoreo.one
Received: from tianjin2.rivoreo.one (unknown [10.100.1.128])
	by hkg.router.rivoreo (Postfix) with ESMTPS id 6772111CEEF;
	Thu,  1 Aug 2024 04:15:57 +0000 (UTC)
Received: from [10.1.105.1] (localhost [127.0.0.1])
	by tianjin2.rivoreo.one (Postfix) with ESMTP id 527906A909;
	Thu,  1 Aug 2024 12:14:29 +0800 (CST)
Received: from 10.1.107.31
        (SquirrelMail authenticated user whr)
        by _ with HTTP;
        Thu, 1 Aug 2024 04:14:29 -0000
Message-ID: <0425beae71b2214e8e160b3c0c91ad99.squirrel@_>
In-Reply-To: <CAL_JsqKpTKv-fthwD9bFHiVESJyNP6uMg7Px7Rh+-k583oz76g@mail.gmail.com>
References: <2046da39e53a8bbca5166e04dfe56bd5.squirrel@_>
    <CAL_JsqKpTKv-fthwD9bFHiVESJyNP6uMg7Px7Rh+-k583oz76g@mail.gmail.com>
Date: Thu, 1 Aug 2024 04:14:29 -0000
Subject: Re: [PATCH v2] of/irq: Make sure to update out_irq->np to the new
 parent in of_irq_parse_raw
From: "WHR" <whr@rivoreo.one>
To: "Rob Herring" <robh@kernel.org>
Cc: "Saravana Kannan" <saravanak@google.com>,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.23 [Rivoreo]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal

> On Mon, Jul 29, 2024 at 11:54 PM WHR <whr@rivoreo.one> wrote:
>>
>> Commit 935df1bd40d43c4ee91838c42a20e9af751885cc has removed an
>> assignment statement for 'out_irq->np' right after label 'skiplevel',
>> causing the new parent acquired from function of_irq_find_parent didn't
>> being stored to 'out_irq->np' as it supposed to. Under some conditions
>> this can resuit in multiple corruptions and leakages to device nodes.
> 
> Under what conditions? Please provide a specific platform and DT.

I have a previous email sent to you before I came up with the fix. The kernel
log for debugging and the device tree blob are attached again.

> Honestly, I think the DT is wrong if you get to this point. We'd have
> to have the initial interrupt parent with #interrupt-cells, but not an
> interrupt-controller nor interrupt-map property to get here. Maybe
> that happens in some ancient platform, but if so, I want to know which
> one and what exactly we need to handle.

So you suggest the #interrupt-cells is erroneous in that node, and should be
removed?

This is a device vendor-provided DT, so any issue in it will have to be fixed
locally.



