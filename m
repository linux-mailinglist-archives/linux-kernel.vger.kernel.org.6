Return-Path: <linux-kernel+bounces-196678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A88D5FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0301C2269E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C7156245;
	Fri, 31 May 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="I7ohPjh1"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB9155C8E;
	Fri, 31 May 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151886; cv=none; b=lXNxXnonethysvIO/V3qYAjJu2laPlzb9Xqqt4QPUyFz4AX2bG40iE8PnQwH8ZP3XuuvnYfqAtZEGcAsaKOFwQQdz5ychDunPi6mQEfHl4t0we5Y7XDHrCGMpKwqrYvgynk3yFU1qc+2kHo8P+Kgh2ud3DxMEr6+GbAtRFc83UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151886; c=relaxed/simple;
	bh=vGS6g45uGnxHvSSNpUZ+06i5ODxlJer7tFN7ZSsuT3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3Pgcc5lTEnJytAjbd87DHSVg5/wS+AX67Qlm+cIJuP5AXuavmKqS4WsSRQZwov6HxlcA2r2m4uxWr/9teIN80mBOc3GdVKCQdsjFqoQBvCCzBgCEoZWEHTw8NKcpNZ3UDPW4IUfLUApvdXKjcxyRzsBWHvaakJFm9MUjxGN5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=I7ohPjh1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1717151875; bh=vGS6g45uGnxHvSSNpUZ+06i5ODxlJer7tFN7ZSsuT3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7ohPjh1avznzAaPb8T6T7o4LUKfcwAdQet/t5H/NpzpKtL4FfFYE/P4ucUbW6j3T
	 SVCdjqM8Wjgnc2pwGNtt1GO02xrFZlLwFVHFyxJZ+e9XpapKCWzfDo1XUUKQbyUt48
	 AxPK4mJsasUNb4FlIbz/JCnDeDv20T49z8G9QMSQ=
Date: Fri, 31 May 2024 12:37:54 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: =?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Radu Sabau <radu.sabau@analog.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
Message-ID: <2b3ca226-339e-40f3-908f-bf8adcb94504@t-8ch.de>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <34a4292e-c4db-4b40-822e-b892e1444045@t-8ch.de>
 <16e448f1-cfc9-4e88-b3f1-55e1856d1405@roeck-us.net>
 <0a2ed64d-06d9-45e8-a054-4ded4429f952@t-8ch.de>
 <ffd72953-ecd2-405a-ad6d-236143b26946@roeck-us.net>
 <20240531093154.rna2vwbfx7csu2sj@ninjato>
 <BA0B79E0-6582-45EA-8EA9-35E278B8CC42@exactcode.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BA0B79E0-6582-45EA-8EA9-35E278B8CC42@exactcode.de>

On 2024-05-31 12:01:35+0000, René Rebe wrote:
> On May 31, 2024, at 11:31, Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> >>> Wolfgang seems to think it's important:
> > 
> > Wolfram, please.

Sorry, Wolfram.

> > 
> >>> https://lore.kernel.org/lkml/tdia472d4pow2osabef24y2ujkkquplfajxmmtk5pnxllsdxsz@wxzynz7llasr/
> >>> 
> >> 
> >> Ok, but that doesn't explain the reason. Wolfram, Paul, why do you
> >> think this is needed ? Note that I am not opposed to adding spd
> >> eeprom support, but I'd like to know why I am doing it before
> >> I spend time on it.
> > 
> > A working eeprom driver is needed to get 'decode-dimms' from the
> > i2c-tools package working. Jean reported that EEPROM access for DDR5 is
> > different from DDR4, so it needs a separate driver. And
> > i2c_register_spd() then needs to be updated to use the new driver for
> > DDR5.
> 
> Well my original downstream driver already had eeprom access:
> 
> 	https://svn.exactcode.de/t2/trunk/package/kernel/linux/spd-5118.patch
> 
> Note there are some surrounding -2, and parity patches around this patch.

That would need to be rewritten to use the nvmem APIs though, I guess.
If nobody wants to do it, I'm volunteering.

Thomas

