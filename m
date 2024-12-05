Return-Path: <linux-kernel+bounces-432946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537419E5237
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E001882323
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CC01D9A4E;
	Thu,  5 Dec 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M2I1dusu"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809942A8F;
	Thu,  5 Dec 2024 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394403; cv=none; b=LObt0m2zd3kWk+Rg0ar4YnjKgC0Rp12iSS94D0RqlvOkJEGUUZlvbYDp2XtNV6q7ecmoyHdhXRl3k0ImJGEIO0x7QIQrjmKjMvhlIk1PyhQF4qNqqnuwNjjnzMLLFITXkvLrx1H7MzGkBQGb+Hz9tDlMEvXLdF3jYui7bTVLFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394403; c=relaxed/simple;
	bh=PxMPtw+FA47VX7lM8lzOYD5D4a/f9KaEItY3WZ2SxiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GQs2Tc6dLZmzx5tL8zIMeE+kWlG29rqoHTvmERENdcqBTw5GaMrXqa6ri+kegJ0MO2hNTYVu3T0TqfPk6BwUE/SDjozg0Qou4DO3yW0VjBqSYrKMAOiXj0LKqxAHSkc7nRICIGIAcmJ3HvNC70UqaUQdgzjftnJCTBroGfwtDhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M2I1dusu; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED33E1C000C;
	Thu,  5 Dec 2024 10:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733394393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aqjkju8oywA4XQ9GAWJQ38Rocfc/Zbwx/1Z53fTbedU=;
	b=M2I1dusuYQ98J+fp7HT1Dh/OuY0f5pd2K8Ztma2vrV6iDGsO2cetLW41VHrwoxxDhd6lMS
	XOmdPXWB61W1PG5FG+y15sC00q+yWJOxgyWRq2VT+0sgJY2Use9001fuXYQQfPk1wZHDlI
	9cE8FQRUHiTJalsqwzj/q/1qyD0FD7KdVvv/GYTZKeTN+WoZfdvWUV9KQefWrQAI5XGIGJ
	it4Ns0/F4tsDVEQz/nKMPNeyJqhfaonCsk1+nUg0wHD8RhWr4EjtUd2+iMCyj3YrBPx6sf
	ZNvseaTcmf1oydvh+k6VBqpieK6FdxCE3Gm2Yrj9ND1y66M/Jaa17FgJyCJ5AQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: richard@nod.at,  vigneshr@ti.com,  robh@kernel.org,  krzk+dt@kernel.org,
  conor+dt@kernel.org,  nikita.shubin@maquefel.me,  arnd@arndb.de,
  vkoul@kernel.org,  esben@geanix.com,
  linux-arm-kernel@lists.infradead.org,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] Add support for nuvoton ma35 nand controller
In-Reply-To: <20241204025129.150525-1-hpchen0nvt@gmail.com> (Hui-Ping Chen's
	message of "Wed, 4 Dec 2024 02:51:27 +0000")
References: <20241204025129.150525-1-hpchen0nvt@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 05 Dec 2024 11:26:30 +0100
Message-ID: <878qsuwhm1.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

On 04/12/2024 at 02:51:27 GMT, Hui-Ping Chen <hpchen0nvt@gmail.com> wrote:

> This patch series adds the mtd nand driver for the nuvoton ma35 ARMv8 SoC.
> It includes DT binding documentation and the ma35 mtd nand driver.
>
> v10:
>   - Update ma35d1 mtd nand driver
>     - Add unsupported write page handling.

I was about to apply it but...

    [31m=E2=97=8F[0m checkpatch.pl: 117: WARNING: please write a help parag=
raph that fully describes the config symbol
    [31m=E2=97=8F[0m checkpatch.pl: 141: WARNING: added, moved or deleted f=
ile(s), does MAINTAINERS need updating?
    [31m=E2=97=8F[0m checkpatch.pl: 348: CHECK: spaces preferred around tha=
t '+' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 352: CHECK: spaces preferred around tha=
t '+' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 352: CHECK: spaces preferred around tha=
t '+' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 429: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 465: CHECK: spaces preferred around tha=
t '*' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 465: CHECK: spaces preferred around tha=
t '+' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 466: CHECK: spaces preferred around tha=
t '*' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 466: CHECK: spaces preferred around tha=
t '+' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 467: CHECK: spaces preferred around tha=
t '*' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 467: CHECK: spaces preferred around tha=
t '+' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 468: CHECK: spaces preferred around tha=
t '*' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 468: CHECK: spaces preferred around tha=
t '+' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 479: CHECK: spaces preferred around tha=
t '*' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 479: CHECK: spaces preferred around tha=
t '+' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 481: CHECK: spaces preferred around tha=
t '*' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 481: CHECK: spaces preferred around tha=
t '+' (ctx:VxV)
    [31m=E2=97=8F[0m checkpatch.pl: 514: CHECK: Unbalanced braces around el=
se statement
    [31m=E2=97=8F[0m checkpatch.pl: 611: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 650: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 665: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 675: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 689: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 699: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 715: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 756: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 805: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 935: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 950: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 953: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 975: CHECK: Alignment should match open=
 parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 1001: CHECK: Alignment should match ope=
n parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 1018: CHECK: Alignment should match ope=
n parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 1131: CHECK: Alignment should match ope=
n parenthesis
    [31m=E2=97=8F[0m checkpatch.pl: 1159: WARNING: DT compatible string "nu=
voton,ma35d1-nand" appears un-documented -- check ./Documentation/devicetre=
e/bindings/

Please fix these warnings and checks.

You might want to use --strict by default.

Thanks,
Miqu=C3=A8l

