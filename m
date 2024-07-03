Return-Path: <linux-kernel+bounces-240315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4F2926BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D641F2295A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1668A191F6D;
	Wed,  3 Jul 2024 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Hh8ILOF2"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5B13C8EE;
	Wed,  3 Jul 2024 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720046735; cv=none; b=RX42gvkdmeYKH0hM9wzl9HHO6GQ4/mCp8NXMH7MRsV4brwLWtc1653iLohUvCqmXGfbLn1x4Z6iQmpYvTAntgu0RlJL5EvA2XW9uuep4muWHOX6muT5ZkhGJPDEWoea0B2E4dOYqQVcBDJmMBArigUnZsmOu9eOtHi1s+lTByRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720046735; c=relaxed/simple;
	bh=fNMayVtc/Uc85z5+2aY88Dp4v3+e6dcT6NuOkFfetOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gln6XAUyV7T83yah44oGau8v6M9pdKrnEGbu1yEwlbIOYq35qefbH6zPjb62/bCwitKxrtR/8OnMJFMeyygDaqgVMkZNMHpF3sVrWAiEGoPqP4gRRSUj3hw09NJy4AWvYVdt1NdRWsOfPF0sQ8Oswxg5g7fHoZ26weRgmZyu01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Hh8ILOF2; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1BD584189E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720046731; bh=uFWhK3aDyzozkwTo58fIzcrGNoSCUI7ocMsW/Sf0duk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Hh8ILOF29WdbXTVT0gqn5ghjTXibp8yUHv7SRPUaN5wIOaXiNGINNu0sbvXgvuiOy
	 dCVvO89UJm26X81OKE/Z2h45g0lp44Y8wSzEKvHNBiFgx0vU9CjCL5afa/fTpCvmlh
	 Ac73SgKXCJHXJpPVYiS4tBHv06WrZHVzmwAXiolg1FTWHSdmHpf6+4TK/jMnOml6Gz
	 IlcNFhZ/6DMWJqjflelFqctNoPWNH6bFtKP6auakuoXjSl/b0tE58WdIlqHvdSDyor
	 3aZDNVApgaH5lx9Jym/lRYIkAQS6/ohCU2AYFSKx5XR1HyW+CShhGSCp5AmbXyLnoH
	 846u086m/eZNw==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1BD584189E;
	Wed,  3 Jul 2024 22:45:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Dongliang Mu <dzm91@hust.edu.cn>, Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs/zh_CN: add process/researcher-guidelines
 Chinese translation
In-Reply-To: <20240614032211.241899-1-dzm91@hust.edu.cn>
References: <20240614032211.241899-1-dzm91@hust.edu.cn>
Date: Wed, 03 Jul 2024 16:45:30 -0600
Message-ID: <875xtmt7qt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Finish the translation of researcher-guidelines and add it to the
> index file.
>
> Update to commit 27103dddc2da ("Documentation: update mailing list
> addresses")
>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v2->v3: modify _cn_submittingpatches to _cn_researcherguidelines
>         according to jon
> v1->v2: Revise description suggested by Alex Shi
>         Add a commit id to keep track of the translation status
>         Add a new line at the end of researcher-guidelines.rst
>  .../translations/zh_CN/process/index.rst      |   2 +-
>  .../zh_CN/process/researcher-guidelines.rst   | 129 ++++++++++++++++++
>  2 files changed, 130 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/process/researcher-guidelines.rst

Applied, thanks.

jon

