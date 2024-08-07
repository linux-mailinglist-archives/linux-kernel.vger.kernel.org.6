Return-Path: <linux-kernel+bounces-278191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AEB94AD20
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C351C21765
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486DA83CD9;
	Wed,  7 Aug 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="G8nKNM/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PmuKlMPW"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8284A31
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045334; cv=none; b=kYC9w7WXeZZ6LbyUL6Ky4Ly3mjgOVQGGmzfO5zZ1nJwsv5nmTHPRZ22MqxnjWIONt5LpuHWfSIDLsrC6Qbtfefw8+qe5krvL1kt8r9XpNXqq2nKxtH5daUnNz1gwKxHvVwx2H0Sln8mOuPgpiWmas9hVdJoZ431r4gF6hhpRkc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045334; c=relaxed/simple;
	bh=PpDLyds5h5kxsSem1CFdBZfnjjULgatLnUyWUZvxY5o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CfZnA0eHpCjrGwz8565UAN6teLEkHcKCPSFX20Yuso1PzhucTYVjns+cpOfGVmkWHJFwd5y75Yopia7Fo/7VBE+HCzIZKrXpl9ULCYNk6OuAgUbqOu9LnhPKlFESyfo/CBSds0R8+GPfEISeCY0+IV5HzN7PY+MjX2G/sKrVG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=G8nKNM/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PmuKlMPW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8E1D813833E3;
	Wed,  7 Aug 2024 11:42:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 11:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723045331;
	 x=1723131731; bh=326l5a7wkn9AVsfKxBpX7rFmljZvlN8Y6oFhj4e2ahU=; b=
	G8nKNM/hwNjGnGUL4V3keQJhh8CmYN5tkFjBxysqxdTxjgfA7xSXUkfzgEkYiEqB
	GpibdPgypmKig+ldZxe407OS4aIYfpq4Wg/TZh3qxpRFPWu5dAO4y3dbWAVLXnYY
	S6m8aKM8rC9mnzOCQRJnNktGycP8Lpmeo0Jf+xVgVaFKdCQ8Tcy/UeBRI++sYERf
	7SGZFkjr/8+DAZxgKEa7Q/FL1jFIiTrKC3oFa1Gkq2uabXs5IlGl5kx+Wm9lNJd8
	X/6WJO3zxAIxhboy0IV6nmKYtKUPUk2Ahox9UBiIq1DJzSK0D2s8qf6e/9ML3BzE
	xA4J1BA2bHy0RsshDdZchQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723045331; x=
	1723131731; bh=326l5a7wkn9AVsfKxBpX7rFmljZvlN8Y6oFhj4e2ahU=; b=P
	muKlMPWAgIBpZhXMCbq0xE1sqNfbWJTsguxk2POFaip1dEF4qWqtz1/BhYdwkJan
	Y/qCPWNpSLJ3L3UWOt3KOUsBGHK89suJdbZZ8F4JcWtyn4mNXXb5UM7vMytl4aUV
	T+6NnK76ymzELwlOZ3RZAgeVzq9Df6t6pqgHfLI+J4jjveLzZlGpdbOuC94B0mM1
	lIma4J2AKfQdfTB6QGBPBTrMzPz8vZWOaX/flu+jBCYsUEk+zt4RKuhTJBQkul3A
	1BO5QnHNwjM17Edq5/lN3i6roeZVenIr1UxCKrEoe/XJKlh8j2PiOS8jBlzKqAfd
	6/4y/da3GVimAnUrjf6dg==
X-ME-Sender: <xms:05WzZlPrDGFTiqSR4PNlvQ002s5TRs15q5wuRrfr2NdFfMPFoEFasw>
    <xme:05WzZn_gZiAbUqAWuVGwR7XlMrwnvRtDDeGqxyOadlZDkT7iWEGYkVnJk1lmtjj2a
    hh70QVeLL3mxYri0b4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeel
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:05WzZkQI9EcLmtLzvmEvCEDXDz6POgBZM06G2CTC7muqKatTV01hqQ>
    <xmx:05WzZhsJ6L0Sig7IBwU4fGRjxir4uWCZ43rnwABq58xcfIMNf-u4Mg>
    <xmx:05WzZtfmIV9zWY98y8zlIxm4rOJMm78zyS5kfOyRFDFS-cdz-9Xl5A>
    <xmx:05WzZt0P77fyfYwZhboULZEdKhOsKDEdlyZRvIDs5kRQPtC5fX1sTw>
    <xmx:05WzZnuI1VPZ_hmFtfPNa7H3YEuir3R4889PMTjA6dfWej09tB3jwDTa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2F954B6008D; Wed,  7 Aug 2024 11:42:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Aug 2024 17:41:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Harith George" <mail2hgg@gmail.com>,
 "Yuntao Liu" <liuyuntao12@huawei.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Ard Biesheuvel" <ardb@kernel.org>, harith.g@alifsemi.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-Id: <2083af75-e2d8-42b9-8fa6-f5b7496671bd@app.fastmail.com>
In-Reply-To: <a65d0b09-466d-415f-9bd0-cbc5ff3539e7@gmail.com>
References: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
 <c11ba413-89f6-46b4-8d59-96306c9f1f14@huawei.com>
 <52518ac5-53bb-4c70-ba99-4314593129dc@gmail.com>
 <2812367a-49ad-4c88-8844-8f8493b15bbd@huawei.com>
 <a65d0b09-466d-415f-9bd0-cbc5ff3539e7@gmail.com>
Subject: Re: [build fail] v6.11-rc2 from "ARM: 9404/1: arm32: enable
 HAVE_LD_DEAD_CODE_DATA_ELIMINATION"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024, at 17:36, Harith George wrote:
> On 07-08-2024 20:52, liuyuntao (F) wrote:
>> Thanks, I reproduce the link error with toolchain
>> gcc version 9.3.0
>> GNU ld (GNU Binutils) 2.33.1
>>=20
>> with same gcc version, just upgrading ld version to 2.36.1, it does n=
ot=20
>> segfault and build completes. there should be bugs in low version of =
ld,
>> and the ".reloc=C2=A0 .text, R_ARM_NONE, ." triggers that.
>>=20
> Thanks for confirming.
>
> I guess we need to add something like
> #if !CONFIG_CC_IS_GCC || CONFIG_LD_VERSION >=3D 23600
> around the entry-armv.S changes and maybe select=20
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION in arch/arm/Kconfig only if the sam=
e=20
> conditions are met ??

I think it makes most sense to have a minimum LD
version as a dependency for HAVE_LD_DEAD_CODE_DATA_ELIMINATION.
Are you sure that 2.36 is the first one that works, and it's
not just 2.33 specifically that is broken?

If so, we could use

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -117,7 +117,7 @@ config ARM
        select HAVE_KERNEL_XZ
        select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V=
7M && !CPU_32v3
        select HAVE_KRETPROBES if HAVE_KPROBES
-       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
+       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >=3D 23=
600 || LD_IS_LLD)
        select HAVE_MOD_ARCH_SPECIFIC
        select HAVE_NMI
        select HAVE_OPTPROBES if !THUMB2_KERNEL


binutils only takes a few seconds to build from source, so
you could just try all version from 2.25 (the oldest supported)
to 2.36) to see which ones work.

       Arnd

