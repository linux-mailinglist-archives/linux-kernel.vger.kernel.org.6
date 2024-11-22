Return-Path: <linux-kernel+bounces-417635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3535B9D56F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE2EB22250
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4E3111A8;
	Fri, 22 Nov 2024 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="FIL2dtlr"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FE317C;
	Fri, 22 Nov 2024 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732237034; cv=none; b=S9FpQxZ1LqZD5FfZT8LTj4LmYncJuV+TZn/cltnndiBZCS5XcBolsdDHHbb54nE2KsgfrBTXX1CroWK5KEQRpdze3doSGQ09EjKvE28K0uS0xV7mYKjiabxi3jopY6N2jc46sJ5AKAM6KluvlKoJZNWZbjdgPYSb6n67RsL4TSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732237034; c=relaxed/simple;
	bh=NoFHxlk/MxXl8zn0QsJEzFEW9uJPQ9u0jXpK1xuLvzU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FL2OXJ1TJr3Tab6xZ5xx47HlocG2xQR34SMaashKf31aUEdA876owOAmlhS8O91nDGNC1V1yClSC1JoJxaw8ehTkkt4BwpDAbTIQhLciktNrqI/4j1ymo65zOAvQ7EKcIxojm6AX1KnsjlBtPBpn7N7O0d08Uj0jsLPH8umn8zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=FIL2dtlr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1732237030;
	bh=NoFHxlk/MxXl8zn0QsJEzFEW9uJPQ9u0jXpK1xuLvzU=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=FIL2dtlr7AuN89P3H/wj7W1MsXCkQvugxo0jOhi4kklYgD9YIbu552Ex6Wfk8ZIKD
	 j5tJJVKYcWGfxsKqHUJgJ3imk/K0OGO89bgnwrC2ORok8EbuTr+/vTe62yRfrv5PLv
	 nXtCr6yPUsf4BiMbLY0E04ZUXNpwVqgRnrjEye8MkCkQS3rz7mU+SAUj4V7JQETGXF
	 FNoCvU3y8Ial9m8D1vR1i9Uto7k8V6B96uvWvMc/mUGPDdIevtH7U/3VZ8E67Kbe5B
	 B9HIIrIT1PJTnG+9GjZMbGAA8blAVN28WlJAeEgg6VMN2UUd5EumuMzpgE3RayKKK+
	 s6NMQqjS+VKvA==
Received: from [192.168.68.112] (ppp118-210-73-187.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.187])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8C22268F88;
	Fri, 22 Nov 2024 08:57:09 +0800 (AWST)
Message-ID: <920e053a17d5f9a7d5805bcd674f036a9c7fb402.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/6] Revise Meta(Facebook) Harma BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: PeterYin <peteryin.openbmc@gmail.com>, Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 22 Nov 2024 11:27:08 +1030
In-Reply-To: <b13e5063-3b07-43ec-a7cc-b19e73b7c9e0@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
	 <b13e5063-3b07-43ec-a7cc-b19e73b7c9e0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Peter,

On Thu, 2024-11-21 at 12:33 +0800, PeterYin wrote:
> Hi Andrew,
> =C2=A0=C2=A0 I believe this series' path will conflict with upstream due =
to=20
> version differences between OpenBMC and upstream. I will update to
> the=20
> latest version of the DTS from upstream and submit a new version=20
> accordingly.

Going forward, please make sure that patches you send upstream have
been tested on upstream (in terms of whether they apply to the
appropriate branch, and whether they have the right effect on the
system at runtime).

Andrew

