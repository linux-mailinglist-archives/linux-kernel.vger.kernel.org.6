Return-Path: <linux-kernel+bounces-272516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEEA945D64
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B92282239
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF451E2887;
	Fri,  2 Aug 2024 11:47:15 +0000 (UTC)
Received: from hkg.router.rivoreo (45.78.32.129.16clouds.com [45.78.32.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1DB1E2873;
	Fri,  2 Aug 2024 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.78.32.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599234; cv=none; b=szJtoQVtcwP/GCLgPg1IrXlgb1cVGk/rD9UzwKWwawvOBA9goZT68ghD/bpqMpx/Y7mWYKW2HzCK5UCUBw+bafMHtvi2uIMe8NN8W2sgGpOXmWLfg03aT86oTk69XJxMSju+ZAIOFB54V8MutpIPdQ1WjtwVc1ttwJPajmj0+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599234; c=relaxed/simple;
	bh=Ywmrtq1bhsgjkopmVHEBTo8ehChPseqHw6GpKd+PL4U=;
	h=Message-ID:In-Reply-To:References:Date:Subject:From:To:Cc:
	 MIME-Version:Content-Type; b=Jc9atIJbf3gNZH5bKmPj19xaDl0Xt7NKRL5muu6ORBSzJNJudNnAD1MjP1y8VNq/f748GO5xdXUr7h3DXyGda5TIvO8eo8PTNoTftDfuH4v7WQu5GmFcehrX9jp/ZeF02qPyvt/KgKh9a/wv/DGinPZrk7Q9nd3kiQtdaqvYJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rivoreo.one; spf=pass smtp.mailfrom=rivoreo.one; arc=none smtp.client-ip=45.78.32.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rivoreo.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivoreo.one
Received: from tianjin2.rivoreo.one (unknown [10.100.1.128])
	by hkg.router.rivoreo (Postfix) with ESMTPS id E920711CEEF;
	Fri,  2 Aug 2024 11:47:11 +0000 (UTC)
Received: from [10.1.105.1] (localhost [127.0.0.1])
	by tianjin2.rivoreo.one (Postfix) with ESMTP id 796326BEA1;
	Fri,  2 Aug 2024 19:45:42 +0800 (CST)
Received: from 10.12.4.102
        (SquirrelMail authenticated user whr)
        by _ with HTTP;
        Fri, 2 Aug 2024 11:45:42 -0000
Message-ID: <bc8e26604c189e737c92cb7d43ec1681.squirrel@_>
In-Reply-To: <CAL_Jsq+Wcag2Lzu_kLRb5ia=3hNUOs1Ny93Y541eOY-NZOA5qw@mail.gmail.com>
References: <2046da39e53a8bbca5166e04dfe56bd5.squirrel@_>
    <CAL_JsqKpTKv-fthwD9bFHiVESJyNP6uMg7Px7Rh+-k583oz76g@mail.gmail.com>
    <1c7955e8b5f0cdb3c60381a9a7dbbf42.squirrel@_>
    <CAL_Jsq+Wcag2Lzu_kLRb5ia=3hNUOs1Ny93Y541eOY-NZOA5qw@mail.gmail.com>
Date: Fri, 2 Aug 2024 11:45:42 -0000
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

> On Wed, Jul 31, 2024 at 10:22 PM WHR <whr@rivoreo.one> wrote:
>>
>> > On Mon, Jul 29, 2024 at 11:54 PM WHR <whr@rivoreo.one> wrote:
>> >>
>> >> Commit 935df1bd40d43c4ee91838c42a20e9af751885cc has removed an
>> >> assignment statement for 'out_irq->np' right after label 'skiplevel',
>> >> causing the new parent acquired from function of_irq_find_parent didn't
>> >> being stored to 'out_irq->np' as it supposed to. Under some conditions
>> >> this can resuit in multiple corruptions and leakages to device nodes.
>> >
>> > Under what conditions? Please provide a specific platform and DT.
>>
>> I have a previous email sent to you before I came up with the fix. The
>> kernel
>> log for debugging and the device tree blob are attached again.
> 
> Thanks. The patch needs to stand on its own with this detail, not
> require that I've read (and remember) some other email among the
> 1000s.

For referencing the mentioned email in mailing list archive:
https://lore.kernel.org/linux-devicetree/a373cf98c2d35f2bd828261f078471a5.squirrel@_/


