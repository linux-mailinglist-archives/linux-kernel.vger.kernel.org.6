Return-Path: <linux-kernel+bounces-240335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43966926C50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED71D1F21015
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F056E194AC7;
	Wed,  3 Jul 2024 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="U7Fz61pW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF5194A75;
	Wed,  3 Jul 2024 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048065; cv=none; b=Y5hWTrmjnyqlOCIgf4GU7kYFlPB+OmTQ0A6iMG5w+AN7MFoxCuHpHhL46r5cg269UzMnbPv3aNbuMn3uL8xnthWvNwqEbobXmvsSr/0xQMPxMwLOZW5rCwpCW2Coi0uLMOqIoHNYQDgIU5JlpOLnkO52INeZPFi/u2Yiqy+khSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048065; c=relaxed/simple;
	bh=o3PpDOsEbzGibzhF30rXzP7FichK/a1O2xk7xk5hZG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ezlISfaQOYeWrvH486TTLfIeR1ghhMS2AEDwwtQkkgRZ/gp/mvZlG7MoyziHkmwPGmeG8s9KEmIz/D+BwLhMY8RAaAdDeDHVLx1Ram529/T0JyUmQZjw7DJEAu8BdnALc5qQ7kM+1nFgkfik8SCuYH+sGst5Ldet+3vbRpKkO4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=U7Fz61pW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E16304189E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720048061; bh=q/1IKlg8o5G9b5vyFjZhcZ1c3e6Ub6TvBAIZ4vVsB7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U7Fz61pWWGfSbsTXy2+7VmnASFUymlsleQTlPqoOwfvPXuxwOWkisr+z6tYbHfk8R
	 QHvk5oty2UzbeMcllyPM4WOyjiFncmH7CiXuLiNyLBy5HOYyi55DZKtBR2yXdYhpNS
	 aDrM4lHTHAd5bw4/7T2ZOyqpiIBKdbXywqbyfMTEBsfiDAnecCnk4v2uqmsAWCi/Ki
	 4w/98cgRmpnhB5Vzh16UDJNvKnaLe+AH0RaNjdTFOlWdP+XBCVb/WCse6/ZJimf2R/
	 Ia4AgaLOZZBpyKM5+2ag9uJK0XS7a65LHo2ESlOuO3QDuFkzXGIcU8ZvK1jTeJUWgH
	 hSN6ln8sTURww==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E16304189E;
	Wed,  3 Jul 2024 23:07:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tao Zou <wodemia@linux.alibaba.com>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>
Cc: Tao Zou <wodemia@linux.alibaba.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] zh_CN/admin-guide: Add
 zh_CN/admin-guide/numastat.rst translation document
In-Reply-To: <20240701064153.62303-1-wodemia@linux.alibaba.com>
References: <20240701064153.62303-1-wodemia@linux.alibaba.com>
Date: Wed, 03 Jul 2024 17:07:40 -0600
Message-ID: <87v81mrs5f.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tao Zou <wodemia@linux.alibaba.com> writes:

> Add translation zh_CN/admin-guide/numastat.rst and link it to
> zh_CN/admin-guide/index.rst while clean its todo entry.
>
> commit 77691ee92d4a ("Documentation: update numastat explanation")
>
> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> ---
> v4->v5: fix one typo error
> v3->v4: replace "=E5=9C=A8=E6=9C=89=E6=97=A0=E5=86=85=E5=AD=98=E8=8A=82=
=E7=82=B9" with "=E5=9C=A8=E5=8C=85=E5=90=AB=E6=97=A0=E5=86=85=E5=AD=98=E8=
=8A=82=E7=82=B9"
> v2->v3: add space in origin commit tag
> v1->v2: drop the useless label "+.. _cn_numastat:" and unnecessary "=3D",
> 	add a commit tag of origin document in commit description
>
>  .../translations/zh_CN/admin-guide/index.rst  |  2 +-
>  .../zh_CN/admin-guide/numastat.rst            | 48 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/admin-guide/numastat=
.rst

So I had applied v4 - it seems I neglected to send an email saying so,
apologies for that.  So if there is an additional change to make, can
you send me a separate patch?

Thanks,

jon

