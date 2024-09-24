Return-Path: <linux-kernel+bounces-337732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4C3984E16
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687471C2376A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9063176FDB;
	Tue, 24 Sep 2024 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Qat7BRIc"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDB414659D;
	Tue, 24 Sep 2024 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218089; cv=none; b=uW/KtB/S+vTQDwfUCd2aVrBUYSHCa35d5eu9tHy2LIZVdaJwcpmx1lheMy/T39yfcqgwxPBwvx6by1CD/ARHAtcCydBJ5li7CTFJreqHA2G1zyE9crarIi/oTXFBaHlIZPOg12L8he7SfU1yHK/iTfQndI3IxOzu97IMnoBTCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218089; c=relaxed/simple;
	bh=snQfrpIqF5lUmTbpr5USfLuGXPChKFptXRBOF9rrTxU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=b+M0/3B8OyeSRzuTELXhvczGlMuxcPf9tBTxB3qi5MQvd4ZopVsDAgSNS/WUB7Hs3w87uoEZiSg3PRBCAp3WYFsGU7mN/1S5B6sWYIsjtSaXxbAO3M5NlSg/2sQs2oCE3I7DIwppWVJ9vRg1AueYvvuhSIebGt8LaX1BhFJMkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=Qat7BRIc; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 009E5346CBC0;
	Wed, 25 Sep 2024 00:48:05 +0200 (CEST)
Authentication-Results: ext-mx-out011.mykolab.com (amavis);
 dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:content-type:content-type:message-id
	:references:in-reply-to:subject:subject:from:from:date:date
	:mime-version:received:received:received; s=dkim20240523; t=
	1727218084; x=1729032485; bh=YuTUd1UN7aa81yhmE+VrikY6dAazHh4wGL0
	ncS9hgsA=; b=Qat7BRIc/k/bviJZP0Fdvdgln+0xyKQ4x2s7a9FDLkFprpObd7s
	6E/l6j5/ye6xrxv4N3pdTlvsiq6mDBclwe4wRFRXIytPNjd7QsaQ74B/x/UBtA5u
	5EBlMHwRkXX8CMfHeZRgwJEdS3jfPM3X57HlP3Cdkwr2KDD3TaIUZ86ZMBRdvGjQ
	3AVa622D3Vk3TSaynFoDNRpgWu9xYFHgYnap1TcXaCVe9WEiXGVsi1M/PFbCZO2K
	SCqi/9Figl7nwrz/G7iLYw1kJfJZMVB5RndS3nO5+8ZcF0qO3aC/GlQLvGDTVCUr
	g+XhRIEthtS82VWCL7dAesdYXwvd9GqUnww==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id OR9IiRTkVdBC; Wed, 25 Sep 2024 00:48:04 +0200 (CEST)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
	by mx.kolabnow.com (Postfix) with ESMTPS id 1F1EE3470026;
	Wed, 25 Sep 2024 00:48:03 +0200 (CEST)
Received: from int-subm015.mykolab.com (unknown [10.9.37.15])
	by int-mx011.mykolab.com (Postfix) with ESMTPS id D9B0E30851DA;
	Wed, 25 Sep 2024 00:48:03 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Sep 2024 00:48:03 +0200
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: update documents in process/
In-Reply-To: <20240924221816.19009-1-federico.vaga@vaga.pv.it>
References: <20240924221816.19009-1-federico.vaga@vaga.pv.it>
Message-ID: <28549ef9d5ecf8799767482166470242@vaga.pv.it>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-25 00:18, Federico Vaga wrote:
> Update Italian translation following these changes under 
> Documentation/process
> 
> commit eb5ed2fae197 ("docs: submitting-patches: Advertise b4")
> commit 413e775efaec ("Documentation: fix links to mailing list 
> services")
> commit 47c67ec1e8ef ("docs: submit-checklist: use subheadings")
> commit 5969fbf30274 ("docs: submit-checklist: structure by category")
> commit 5f99665ee8f4 ("kbuild: raise the minimum GNU Make requirement to 
> 4.0")
> commit 627395716cc3 ("docs: document python version used for 
> compilation")
> commit 7a23b027ec17 ("arm64: boot: Support Flat Image Tree")
> commit 56f64b370612 ("rust: upgrade to Rust 1.78.0")
> commit 82b8000c28b5 ("net: drop special comment style")
> commit 6813216bbdba ("Documentation: coding-style: ask function-like
> macros to evaluate parameters")
> commit 91031ca349ee ("docs: improve comment consistency in .muttrc
> example configuration")
> commit 7fe7de7be828 ("Docs/process/email-clients: Document HacKerMaiL")
> commit 9c03bc90c065 ("Documentation: process: Revert "Document
> suitability of Proton Mail for kernel development"")
> commit f9a4f4a0e1f5 ("Docs: Move magic-number from process to staging")
> commit 7400d25a0a5c ("Docs/process/index: Remove
> riscv/patch-acceptance from 'Other materi
> al' section")
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

My mistake. Ignore this version. Keep V2
-- 
Federico Vaga

