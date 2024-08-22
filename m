Return-Path: <linux-kernel+bounces-297491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E991795B935
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FEE91F21768
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DFA1CC896;
	Thu, 22 Aug 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZS2ZkpAf"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C21CC89F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338848; cv=none; b=ALe2p75SEkJHtDGXDTUEiSN3/n4TUxIWUfYJqOfn5DRqJSYEGopxIjb0h5l407HePY861wgdYdx3YTs4fri9WXshQc56V22wiZCpVNKNZZ5Hu5An7F3/5tK28Ir8qCanMDwmpgFFSVn5I0SSsP7Unox12VrXNCjYKkzkbcv7DGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338848; c=relaxed/simple;
	bh=70PL5f2MblAyg/FBGlan2qHuC5lm7vOFjRzQYtiH1ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmVf076Y37k8vNZh2B3M0/QiaMm5A/VyQBOd9SSNxyPruILQTxxqbTdrxP60JIW/4rJ7wAsXQBcahNDbMGaKiv2FijSEd1cd9onYG6dvrhww6HZ8nzIxd1qI3JqNCkf37aI4aecDeww3bsTW2WpZcsDizIzzAG7m4m6iSBRjz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZS2ZkpAf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-67.bstnma.fios.verizon.net [173.48.112.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47MF0MKa022377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724338824; bh=sKAFdZgSvPvrdIUpPT56RTQQlQknRd04letoFd7nzZo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ZS2ZkpAfw50GU3CLQGY7XF6QwhlPO64vfflX76Sy3rlKkzkVQCCJnkXWU+MggveWa
	 a0LFogos/ap8qtVY/XhY4iZX0Af3deHuSrKOB2GyzxeGe+q4YNsuPA3YPe47MUE8ig
	 k27T1Neo46XWVVN5tvP2xZfXCuOiujdoS5JceLNbQ3AU3D+AcsiyouJOHCb3x9uxjW
	 /Lie2wOMNivD/HAVoCaU7sGPbfSXEkPQIz0hyPpW8S00zNF+ZKMqR0QExQd1oUiHB8
	 U7CQp2BUMUeZk4deCNCyBBwU8n1d9aatBPpLZcD2FShw1GQTx/JRw9XJfryEAjwhvy
	 76IhY3CIbkzEg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E2AC415C02C3; Thu, 22 Aug 2024 11:00:21 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Some extended attributes related comments correction
Date: Thu, 22 Aug 2024 11:00:12 -0400
Message-ID: <172433877724.370733.10230780173544926638.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606125508.1459893-1-shikemeng@huaweicloud.com>
References: <20240606125508.1459893-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 06 Jun 2024 20:55:05 +0800, Kemeng Shi wrote:
> Some extended attributes related comments correction. Please see
> repective patches for detail. Thanks.
> 
> Kemeng Shi (3):
>   ext4: correct comment of ext4_xattr_cmp
>   ext4: correct comment of ext4_xattr_block_cache_insert
>   ext4: correct comment of h_checksum
> 
> [...]

Applied, thanks!

[1/3] ext4: correct comment of ext4_xattr_cmp
      commit: 6ceeb2d8fdb19a1b6bb9cc48302e682fb380043b
[2/3] ext4: correct comment of ext4_xattr_block_cache_insert
      commit: 4b14737ce90424179d615cd35f04453f398f8324
[3/3] ext4: correct comment of h_checksum
      commit: 5071010ac3aa32a1b0f0b4c14d3ea6b217ba21ba

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

