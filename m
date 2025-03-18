Return-Path: <linux-kernel+bounces-565933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A90A6713A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198EB3B7A12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDCD2080C9;
	Tue, 18 Mar 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T1EftWyo"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C8206F18;
	Tue, 18 Mar 2025 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293623; cv=none; b=PICAw9DeksmELfwMHnFSRXEnwmgU+7ON9ix3nC+NRSfxWfsXOwqzzUL/lbZV2DMgHJLDff3sNUcS9rj49mUYSTex02HORMzgXb77p/C0DQTIzm0hRzwlp0ZZdC+AfYAPJ0OCuKS+x5RKSmxNuEHQgGHkb666TXzSV5kx/8pelzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293623; c=relaxed/simple;
	bh=vhf2yFdvIdkY0ES4ZMw6oAyokhaSIllpoSKNDnt86Ig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gwU7onm8J87ePfxqhouZVkp8+8tsT+vQBiXLEUt6JGTQf6WPJFoTlzB3lTlbcWbm8MZYM+chwN8uzax2ySEkH4e6Ax+eCcE9hOILsNvPJVAr/dt4Vf7zc/2Wm73+gQq4PUekUOONU6EE9XQtTmIz7SBNpkaHcQWwTliiuV1MucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T1EftWyo; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C7C7432BB;
	Tue, 18 Mar 2025 10:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742293613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhf2yFdvIdkY0ES4ZMw6oAyokhaSIllpoSKNDnt86Ig=;
	b=T1EftWyoVjXgeLianlFmLfDtluRNEmcDGeGL3vyDI0F43X+fsDh2QFvgrqMHqFkUfyoOIG
	KC7yRHopGDGNJysHPfKOImMqYdWoQO7b3d4L8/LzxOv8r+Jpo3suCYM64AO8Bz94VopMim
	BlRwcr1RBMXwoSDry2U/nTRDVBwxbFoWZUrps5//lXMDp+ZnbwQiQW1pK0h7GcI0DckOwC
	+6sr4srtwAGGlp0pJyqAxHDi8U8l+4LFsUJCX9vPcCeGdgJFCc5yMMudvrvK6tVbRUZMRF
	idDa3yIvviCCJikq0xWc9pkA4Vj4ivNC6h5rtkd6B2hTxaQosZmzJ6OraaWynw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org,  linux-mtd@lists.infradead.org,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  cocci@inria.fr,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] mtd: cfi_cmdset_0001: Fix exception handling in
 cfi_intelext_setup()
In-Reply-To: <d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de> (Markus Elfring's
	message of "Tue, 4 Mar 2025 20:21:53 +0100")
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
	<3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
	<d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 11:26:52 +0100
Message-ID: <87o6xyab2r.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepofgrrhhkuhhsrdfglhhfrhhinhhgseifvggsrdguvgdprhgtphhtthhopehkvghrnhgvlhdqjhgrnhhithhorhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmp
 dhrtghpthhtoheptghotggtihesihhnrhhirgdrfhhrpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

On 04/03/2025 at 20:21:53 +01, Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 21 Mar 2023 20:13:51 +0100
>
> The label =E2=80=9Csetup_err=E2=80=9D was used to jump to another pointer=
 check despite of
> the detail in the implementation of the function =E2=80=9Ccfi_intelext_se=
tup=E2=80=9D
> that it was determined already that a corresponding variable contained
> a null pointer because of a failed memory allocation.

Can you please rephrase the commit log? It is super hard to understand.

Thanks,
Miqu=C3=A8l

