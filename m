Return-Path: <linux-kernel+bounces-405730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25BB9C5651
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526221F21FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FA12123DE;
	Tue, 12 Nov 2024 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XMOjobmU"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E920E30A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409455; cv=none; b=Qm2/Fx9RHA8o6FsM8KJH9Oe0+8zbEbUyZr/h161LgyykcFypnljbu1Nh4iVdLHMwrdafTZ7V6DlIRUjMnWCsxrMpQKcA4ICxxq86S1ggj2WohUg+SaQEK3yPkrE7xagYdAdfyza46Nhq18WLjbfe47aR2XopfLeBg9xW9gXRfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409455; c=relaxed/simple;
	bh=okpfAQ7CDULMdOaIg+qLk0vgXSNjNmDu/6uc8VKrUyk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CzoBqxvoQ00tZRPjmlRUjIwqXHlx6qwv5CbRD2RZsxCnhmuhsaq63dcJU1TLC1PPwjBpx2spl1oqnPLw9rrRtXRMHQ0D63p8o5MveWGQkvsHisUHpwNLz+8CsY1wWb30SWw102bEhIeMioqwGj2knbb/UNkhTdAd4P8hsTPaQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XMOjobmU; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731409447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okpfAQ7CDULMdOaIg+qLk0vgXSNjNmDu/6uc8VKrUyk=;
	b=XMOjobmUgeQNDdIuxMV6rWiaei8gqY/qp3V1TX0CmBCxPKGYv7a482GvzdCo0QJisz1zoQ
	59X9btHAJOgBEajvYIM0GddcKB0FmJ6s+hDjAMNOFHnoSZQkQ5rSaGK8oGTsWzNGCNFx4f
	oh0f6dod3vn6DzjZ0424nsocBT1MhcM=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] sparc: Replace one-element array with flexible array
 member
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20241111204724.165263-2-thorsten.blum@linux.dev>
Date: Tue, 12 Nov 2024 12:03:51 +0100
Cc: linux-hardening@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8EAE9B99-EB4F-4361-9C7C-4DBC4998F439@linux.dev>
References: <20241111204724.165263-2-thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>,
 Sam Ravnborg <sam@ravnborg.org>,
 Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On 11. Nov 2024, at 21:47, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct hvtramp_descr.
>=20
> Additionally, 15 unnecessary bytes were allocated for hdesc, but =
instead
> of fixing the parentheses in the open-coded version, use struct_size()
> to calculate the correct number of bytes.
>=20
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

If this justifies a Fixes: tag, it should probably be:

Fixes: 64658743fdd4 ("[SPARC64]: Remove most limitations to kernel image =
size.")

Thanks,
Thorsten


