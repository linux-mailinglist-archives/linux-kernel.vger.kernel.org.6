Return-Path: <linux-kernel+bounces-317339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4871996DCB1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A9228D0E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C767219F49E;
	Thu,  5 Sep 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="juisWDZn"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C419F499
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548064; cv=none; b=MQav8Tc4AXVT53k7aBded7BkVXWbmw7ZGpx/7wj/K/W1uw4KA0SgfHZVDb0D/T87hFB0kZfvIxqM+iltAc7R5/KjbAyTI3oQzOc4JdBmRznz6krusQarZ/G1fSEcner+f79qZi9iPzCqzNVjNoh8B7r3cYDVoGM4GXaOTQWSST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548064; c=relaxed/simple;
	bh=i3IkJZ8CVvslUAGx/dB+0f+mJECIBoFQBahEYT71yEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNQhTD/gFxJmKUXNjQDvvUqHlgaMc467zSFKxm0elXEgEGocdkoldYtd5aFiUhenSISNsyDAX01vY5mqh0t6mTN2Ct5nNZKDyIc0XLQ06YPkrrfdW4u0P3XJzfJofCOhCP3yuK1jPJsFuFrvHdJ+nv1AM8CXFcc7fgz1UO4zEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=juisWDZn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485ErsHX004659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 10:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725548040; bh=bPePAcmEsqxs7gy1FbVzMnCjjwWUf7FZa+kBRyOnqgk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=juisWDZn/Cu0EYVSmTg1OoHtGUVGBgmnJuyjyWHd1cJDWJtnvHJALCIODORWo9+Bd
	 HTx8HAWRQXe+LkIgMRPwpotlx3xWr6bk3ym8iiDJvdeZN19YO79Yg2vUnPmrKmXAPi
	 ydyBG72pLzwajtZzFOM0LHYgtWJ7ovqiPavKdemnx4yyvyIINPphKttVcnhlF4j9XZ
	 B5gfGi8mSBmvJeQ/pJ0Us5113NbCl6vjZRFCxCwbMXU0Ijy1FfHBxW24/qqPG6K0Yy
	 yNI4N3t7fPtENFqQsR8Ey4Pm9CZIMaHIpilRzVHLTC2Bsu57yow9rtf2R+ZMrj9yOq
	 G/94L7EBRK74w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DC0D715C1909; Thu, 05 Sep 2024 10:53:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Tao Ma <boyu.mt@taobao.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
        kernel-dev@igalia.com
Subject: Re: [PATCH 0/4] ext4: avoid OOB when system.data xattr changes underneath the filesystem
Date: Thu,  5 Sep 2024 10:53:41 -0400
Message-ID: <172554793832.1268668.642779330743885621.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821152324.3621860-1-cascardo@igalia.com>
References: <20240821152324.3621860-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 21 Aug 2024 12:23:20 -0300, Thadeu Lima de Souza Cascardo wrote:
> This patchset changes some of the error paths involving dir entries lookups
> and recheck that xattrs are valid after an inode is potentially reread from
> disk.
> 
> Thadeu Lima de Souza Cascardo (4):
>   ext4: ext4_search_dir should return a proper error
>   ext4: return error on ext4_find_inline_entry
>   ext4: explicitly exit when ext4_find_inline_entry returns an error
>   ext4: avoid OOB when system.data xattr changes underneath the
>     filesystem
> 
> [...]

Applied, thanks!

[1/4] ext4: ext4_search_dir should return a proper error
      commit: cd69f8f9de280e331c9e6ff689ced0a688a9ce8f
[2/4] ext4: return error on ext4_find_inline_entry
      commit: 4d231b91a944f3cab355fce65af5871fb5d7735b
[3/4] ext4: explicitly exit when ext4_find_inline_entry returns an error
      commit: 51e14e78b5fb3e6f839393cd2d34386ee7b69af3
[4/4] ext4: avoid OOB when system.data xattr changes underneath the filesystem
      commit: c6b72f5d82b1017bad80f9ebf502832fc321d796

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

