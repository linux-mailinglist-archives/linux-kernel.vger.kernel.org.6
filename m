Return-Path: <linux-kernel+bounces-250484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C518F92F857
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0286C1C21F85
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182A5143C51;
	Fri, 12 Jul 2024 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="YWXaT/gn"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0095A17BB6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777798; cv=none; b=OsLzbopQ451CenNnuPAriY2vFQX0MaWGGx+g7y5Zu1fTQWyBpwSl12MmxaljvxrNEix1pP0PT1hWlHHaqa4RyXyOTBi7u4ZJtamHvhRj9E6TME/DZkCyMvMve+9BJCU+k9XM2vYBE32y3bzBOalqO2TrLwxr4OuAfp5u/7rGIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777798; c=relaxed/simple;
	bh=Xt4865nA6FKxAlh+m0+aqm9hP4TKUQZNYBGl2HLyLjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YMpfxG4zvX9A7c9okr8mn+qg5TSy46ZYYABvqidJMmNkierkKTaeEf2yI0PhhOC7EZWujb+8quXLa+RFQOmxaX3OmTPWxTatcpL91qPEJmjEAEq9dVXkwWjJa3aECEQLQTAi2OAGjsTCOVgWJPKO1fx64A/tPy6AD6CmnKoh8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=YWXaT/gn; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1720777788;
	bh=Xt4865nA6FKxAlh+m0+aqm9hP4TKUQZNYBGl2HLyLjM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YWXaT/gn1YuRNLaAOGUH97Bh24wfvMQ8g7VhSAO/3Yq7lE6k6ERNLHJxRwwuBM7GY
	 N0vE15qICHogSjDGFxK2Yh3Ynw4eYwEpya39O7znJjYN/OQ+eBug3GfHQOi8a1I3iU
	 VNB5958Q3YIlbQSZ9qL0//tHyd4cTeeBrlr7bm1A=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id CF024661FC;
	Fri, 12 Jul 2024 05:49:46 -0400 (EDT)
Message-ID: <0adc4126e7fbb8fcf84bae67ebe39ff6da4721cd.camel@xry111.site>
Subject: Re: [RFC PATCH 4/4] LoongArch: Remove -fno-jump-tables for objtool
From: Xi Ruoyao <xry111@xry111.site>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf
 <jpoimboe@kernel.org>,  Peter Zijlstra <peterz@infradead.org>, Huacai Chen
 <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Fri, 12 Jul 2024 17:49:44 +0800
In-Reply-To: <20240712091506.28140-5-yangtiezhu@loongson.cn>
References: <20240712091506.28140-1-yangtiezhu@loongson.cn>
	 <20240712091506.28140-5-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-12 at 17:15 +0800, Tiezhu Yang wrote:
> -ifdef CONFIG_OBJTOOL
> -KBUILD_CFLAGS			+=3D -fno-jump-tables
> -endif
> +KBUILD_AFLAGS			+=3D $(call cc-option,-mannotate-tablejump) $(call cc-op=
tion,-Wa$(comma)-mannotate-tablejump)
> +KBUILD_CFLAGS			+=3D $(call cc-option,-mannotate-tablejump) $(call cc-op=
tion,-Wa$(comma)-mannotate-tablejump)

KBUILD_AFLAGS isn't needed, and $(call cc-option,-Wa$(comma)-mannotate-
tablejump) will always expand to nothing because the assembler does not
have -mannotate-tablejump.

The assembler never creates a jump table itself.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

