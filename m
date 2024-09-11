Return-Path: <linux-kernel+bounces-324776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E649750B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A67A1C21093
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08518CC1A;
	Wed, 11 Sep 2024 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iR6mZGTB";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="NkS3Dxi5"
Received: from a7-44.smtp-out.eu-west-1.amazonses.com (a7-44.smtp-out.eu-west-1.amazonses.com [54.240.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E957187338;
	Wed, 11 Sep 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053867; cv=none; b=r9gfmI2JmGoYbtbvbUKwst7S9f8Jrv6iz22qpIXYCQ9/7dopmtFCemnIFzwhXeJgc2qRFLrMrjt4AlwuZbqUa9hmOOLdBG5mkd+HgmHN81NeyvQTTWqZl+4EKubddkFSJfHXgA4qhA4ieHqI7uJpaS6nvZg2+HYTMoprROlyy40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053867; c=relaxed/simple;
	bh=KyJobcNk7xhzcp2Jb5bLfWvTg1sjvFWcmiu4ZNFOuNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bc4gWemvywc6aefw0dJ9opLthMSVD9D/LPSW1g4VU6ASf4kM/MwYGKKYA66/bFumiXUzAlpoV9J5G0kZfrFhQE/hOr6gyJYHXgeUz5lpmM2ZD7UUFK2QZ0aVpuFZfxGGero8I9Z9Tca+CrXODcitbYA/VqBbJTtIXgWU4ACjJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iR6mZGTB; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=NkS3Dxi5; arc=none smtp.client-ip=54.240.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726053862;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KyJobcNk7xhzcp2Jb5bLfWvTg1sjvFWcmiu4ZNFOuNc=;
	b=iR6mZGTBY0ig9bkXxXUCoPXSzgzCP3ZA2MUdRS8/JLU4u/2qDAnPcDBwY76gR6oG
	5yyruaLCSifjRHqYdXX/HaSRLDblysbgYWdjm80D/A3e3r/aeH8lQ6jqjnrRjwEmVX/
	YBNcWY22m6BH8NmkgVw2wIraIC54EMN4B95lNbWjSRlLFo404CO+AGfX8V5EbKWQfUA
	JQcoXq1b3XcV8Y4AYRUPDpswpqBNzaE9eY6jh8OpNdZ5m602dTuS0bRTZ5ofsGSMoSE
	1NM8Z79fR/+ubP4nDneXAZoowsDaInmJwZzWYt0BQkLLtZKWp7iyEPd39cY3YhzNcjP
	fypbLg7aAg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726053862;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=KyJobcNk7xhzcp2Jb5bLfWvTg1sjvFWcmiu4ZNFOuNc=;
	b=NkS3Dxi5k6FOFcn1BGHTwIJyReKBKMV477myCbaDHAUjyxxBUCSjbcfyBwgqHh3Z
	gCtl9RItPdgFET2haQ2+HYHSCGKCQeRcIVMBaICZnJgkiwOeOx32HuaZdALehtrCaD8
	5M3I112HSpIPSSM+R6DqAdsgHNF/RQ/Oq8RQCyQQ=
Message-ID: <01020191e0d3cd23-55b96d22-80a9-4eca-bc01-f02e5c642544-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 11:24:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: spmi: spmi-mtk-pmif: Add compatible
 for MT8188
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
References: <20240911105131.4094027-1-fshao@chromium.org>
 <20240911105131.4094027-2-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911105131.4094027-2-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.44

Il 11/09/24 12:51, Fei Shao ha scritto:
> Add compatible string for the SPMI block on MT8188 SoC, which is
> compatible with the one used on MT8195.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.dleregno@collabora.com>



