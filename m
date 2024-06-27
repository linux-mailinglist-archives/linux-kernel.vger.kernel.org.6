Return-Path: <linux-kernel+bounces-231858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEEE919F83
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CDA285A41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955B739AD5;
	Thu, 27 Jun 2024 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xPDWkjwt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sxaZLSry"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A21CA96
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470806; cv=none; b=cDRa2ugbLgtxoGaYtHKKf5psJ9epbUUgVNLzLnIGv+o63vCZlgfCjqVkmbm4JuD4BR6E9u0Gg5FZctgCmX1UllNUefq6KGxDx6Z5/W2z4eVQ545P9ZewHrFoaGOHmgXBMtAMJKb/TKTGyBaaAGtP3NR9AQcdZYwL83DI9aoXhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470806; c=relaxed/simple;
	bh=59yHLOAL0r7lbk5fzQyapZJtsEqdJTadNmnTZvypfXk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=syqyuVvotRyc3c1oUaYFVgFb8WNH8UT2H9hKlCFclIBPaZIWPVNyv6pa2vhJxA7uLjomJUbnbdcqm0wThsgzXJh7xgeRfYLH6vZvIIJQJFSXwSF87HJ+rwwPyQ6pnapy3XPIrXgvEkg8rvvhW5wQ/QijjmRitkDVTR6IMshQUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xPDWkjwt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sxaZLSry; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 45CB011402E3;
	Thu, 27 Jun 2024 02:46:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 27 Jun 2024 02:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719470803; x=1719557203; bh=21wogX4lZL
	dYQzweo1UR0890OgNIFA+e+je+r+/6fNo=; b=xPDWkjwtCkBAdcU9N6if4TzWrN
	vUs8YLMoBJAVLOj1Z/FJsYOqnp6vwWWIVQYZ68IUodxGb78SaKLP1xrQjhyYCGuX
	vgnOy6sau+lE9q128THuLtp/vOJQLVzUxXxoTec3ndCloeISEGofE3CMlPptEw3k
	VuVPj01e7/zEFeKngp/zsIcDNup1QOHv6QPSd+Row4oBRensqIERKQpI+ahCEAU9
	S+UWw3TTjO8pbJHdyZEDWpjI8eQqnmkbI6hBD+qngT/jdI3zD0hX/pHWVlFSq0Qu
	CrnW6zH89vQUgiIWGQQybh3MTDdmFc5d+keb4WNXxqKBrctPB+sGX1zHwXfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719470803; x=1719557203; bh=21wogX4lZLdYQzweo1UR0890OgNI
	FA+e+je+r+/6fNo=; b=sxaZLSryANyxwV5Q7pSihncMz03TjU1gZUQintd8piDq
	lSAOqaaW2VUzN/4xSK9TAA0/76S6coZL1E4JpBOHFvE4go8gP0bcy8fvEL1XCt0w
	InpS28YpmcURU6KR4DyIHV8meRJdun5xQxNhg9H7iEXT0tlokrZuK42xgMgWoOWw
	JwZrnFnl4BCWUm5mJHW7V9XLg1CO0ICZtp03fS8U/MU4MPSXtJmKHVmIVD575LTL
	Ea+P+f5zVwRwOSiaoqq+Ft6qQQtqOVFYiQrDPKcdQ8OfRbep05dtfydssiRlexbZ
	DO2J6DFeJGtRGgiwa7IWbSuPuXKZrmY/FFMs1QoZ5Q==
X-ME-Sender: <xms:0gp9ZnB1HFhEm6lLQam-gpQftE47xuz_bsKyVopcD_D3cl9aHW39Sg>
    <xme:0gp9Zti81sA0SgXyDzPAEbcswii1UVLxbSTJ5mZuF-tfu9VorrmIK-aeCjn3dhIJv
    I1djJeG5fsOg7YtpDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdefgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:0gp9ZinQmGc6DwiOjgU4l6_dOj34AiyDDcyVHzvSnXT5h1iwg9TxJw>
    <xmx:0gp9ZpzjxB8cPQNNDA_tB7UWZS9e5dUj3MGzUAfccES9pWSPQ85XtQ>
    <xmx:0gp9ZsTVZsN1HL7DUIkCuHpd568qBdR5m1fXjO-SWZu1HeMbZ168Pw>
    <xmx:0gp9Zsa4bSCwZ9Isge5pZytj76slgwi-iStXRUrW_kqc8NZ_gXtRgw>
    <xmx:0wp9ZrEWUnqs22onNT-vE2_nimPpvGDICsa_WGE1kaP03jto2qCGo4SS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 347EAB6008D; Thu, 27 Jun 2024 02:46:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b5145139-21e5-46a9-a6c6-7330795fda55@app.fastmail.com>
In-Reply-To: <Znw7engdDiMldJp2@xhacker>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <20240625040500.1788-3-jszhang@kernel.org> <mvmikxvonjh.fsf@suse.de>
 <ZnwTwnSsnZ8Td9GZ@xhacker>
 <dcf9574a-0f1b-4131-befd-39f47d4f9002@app.fastmail.com>
 <Znw7engdDiMldJp2@xhacker>
Date: Thu, 27 Jun 2024 08:46:19 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: "Andreas Schwab" <schwab@suse.de>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] riscv: uaccess: use input constraints for ptr of __put_user
Content-Type: text/plain

On Wed, Jun 26, 2024, at 18:02, Jisheng Zhang wrote:
>
> "m" version is better than "r", usually can save one
> instruction.
> I will try to combine other constraints with "r" to
> see whether we can still generate the sd with offset
> instruction. If can't, seems sticking with "m" and keeping
> output constraints is better

Ah, I see.

> You only mention "user space access", so just curious, does
> arm64 version still correctly work with below __put_kernel_nofault()
> example?

No, I think the example I gave would break for both x86 and arm64
without adding an output constraint.

My main concern about using an input constraint was that it
doesn't match what the code does. Maybe there is a way to
make it use the correct "=m" output when CONFIG_CC_HAS_ASM_GOTO_OUTPUT
is set but use either "r" or "m" inputs on older gcc releases.

After gcc-11 becomes the minimum in a few years, the hack can
be removed.

     Arnd

