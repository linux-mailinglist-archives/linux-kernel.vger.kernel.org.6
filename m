Return-Path: <linux-kernel+bounces-228473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C057916068
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC0282394
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF1F1474A3;
	Tue, 25 Jun 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="ooDiAHZX"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A73146D76;
	Tue, 25 Jun 2024 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301886; cv=none; b=OvwhCITBZsqyhZrs812KUAjnYGmtzusLJdqRxzABZeg+l+pS2u6XzF+gOIMMZ7mzjthYzptnWLijGZSEQwVuVikJgf6b/a7BedE7PMySPo5L4XPSo3BdmPIERBcVKqT6ZafQTvDbS+6iv+o7juhIFTLkLjRaNBWU1c6CXmxKEHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301886; c=relaxed/simple;
	bh=KLqf935lSAJuGQQElpBuZqXf46nRUx378xaLq4T4IaU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bAbzVtOiZXwbz6JrRwu9QyFUu+GGScCl0RnDHoBgah92OprDwK8t7wGLwOPLgTUs7tNRt2AMeT+cB9bsB8NpKQlyDRQi3kVeQYB4uHxTRT0lMJudste7oY7nBXrrN0uJh31XER0Hni8AHXB4cLqpZ57cj9dSOdQZyumnykLxmgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=ooDiAHZX; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 6E9CD3004C5C;
	Tue, 25 Jun 2024 09:51:21 +0200 (CEST)
Authentication-Results: ext-mx-out013.mykolab.com (amavis);
 dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:content-type:content-type:message-id
	:references:in-reply-to:subject:subject:from:from:date:date
	:mime-version:received:received:received; s=dkim20240523; t=
	1719301880; x=1721116281; bh=H5af9yjgTthkIh74doQYQLtPF8gG8f4WGKd
	py7fAyBs=; b=ooDiAHZXrD03pbszTQot/79JiSgW6ToSsGGEpDWSQJDyKXv2gU0
	PcO25ueN9JV5jNRF9RCPlBVDa/zbft3jUiFXBUojNdHk6PS2t6qxHZ2QbxD108P3
	DuKPVIoE8LZfKk3n1LDHU1FQbOjdtrRw7ekwtCUvLmyB6TMwTFXGwHXJSVMFjmws
	4ERPs0e1YAOA5Xb32MNVaiEM8AioVdvr8zhgbfslqRgp+vsQoQ2017ZQDiFWYk99
	s3fFNUX9jFRKOmzQ2Jf/7iYqF7CAtaiAtWpB84dMzyJbjTh8sN4ADRTj+N32w9+P
	gCEzn8oap/IBREGTPQ+fQFlVizySqIL/dMw==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 5K128MH4078t; Tue, 25 Jun 2024 09:51:20 +0200 (CEST)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
	by mx.kolabnow.com (Postfix) with ESMTPS id F15203004C4C;
	Tue, 25 Jun 2024 09:51:19 +0200 (CEST)
Received: from int-subm015.mykolab.com (unknown [10.9.37.15])
	by int-mx011.mykolab.com (Postfix) with ESMTPS id 5AF8F32F1269;
	Tue, 25 Jun 2024 09:51:19 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 09:51:19 +0200
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, Avadhut Naik
 <avadhut.naik@amd.com>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <siyanteng@loongson.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 workflows@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 4/7] Docs: Move clang-format from process/ to dev-tools/
In-Reply-To: <20240624185312.94537-5-sj@kernel.org>
References: <20240624185312.94537-1-sj@kernel.org>
 <20240624185312.94537-5-sj@kernel.org>
Message-ID: <ae3edebe685d15a4398e587ebd082a18@vaga.pv.it>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-24 20:53, SeongJae Park wrote:
> 'clang-format' is on 'Other material' section of 'process/index', but 
> it
> may fit more under 'dev-tools/' directory.  Move it.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  .clang-format                                             | 2 +-
>  Documentation/{process => dev-tools}/clang-format.rst     | 0
>  Documentation/dev-tools/index.rst                         | 1 +
>  Documentation/process/4.Coding.rst                        | 2 +-
>  Documentation/process/coding-style.rst                    | 2 +-
>  Documentation/process/index.rst                           | 1 -
>  Documentation/translations/it_IT/process/clang-format.rst | 2 +-
>  Documentation/translations/sp_SP/process/coding-style.rst | 2 +-
>  Documentation/translations/zh_CN/process/4.Coding.rst     | 2 +-
>  Documentation/translations/zh_CN/process/coding-style.rst | 2 +-
>  Documentation/translations/zh_TW/process/4.Coding.rst     | 2 +-
>  Documentation/translations/zh_TW/process/coding-style.rst | 2 +-
>  12 files changed, 10 insertions(+), 10 deletions(-)
>  rename Documentation/{process => dev-tools}/clang-format.rst (100%)

Good for me

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

-- 
Federico Vaga

