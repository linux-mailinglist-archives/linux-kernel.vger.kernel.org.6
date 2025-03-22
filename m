Return-Path: <linux-kernel+bounces-572157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7781A6C775
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 04:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED9A189C016
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 03:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E46C143C5D;
	Sat, 22 Mar 2025 03:36:54 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8245714A4CC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614614; cv=none; b=IbfzoAINcHfM+dqANB4XkrP0rVowPrYXnDsfZP+J5wmErWnNmyp/AdLsOwKlo5kzbaC1v/uKAbEcnyLV1R/zPbInQ/SAW0oAFnhPu/iH9Q5zZ3lPM7r7ABIE0xMkLD8xRQplvNWJU+9lO6XercHgg0gE6E3j0yDFnGlPHIJ6djQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614614; c=relaxed/simple;
	bh=JqsvHkEtR1js2oxw1GhdUI0c2XgtruxlopFr7w7MbvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvp4xfZ9EaJbHvzzEYLYHWtNCCI7sfjdwpdA0jcjJYlU83EAi7COOLcpDn01OEaxcEC/jPWToBmHlcxH0moesv8/bWH9XGuHDXq++MRoZoUzLB7yJMuDGUqlPdezEiBNKsYWFWf1Qi4tDVH3grgV8JH1EycSi79t0PArAJZLIxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52M3aMDI007707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 23:36:23 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BC54E2E010D; Fri, 21 Mar 2025 23:36:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>, Andreas Dilger <adilger@dilger.ca>,
        Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: hash: simplify kzalloc(n * 1, ...) to kzalloc(n, ...)
Date: Fri, 21 Mar 2025 23:36:16 -0400
Message-ID: <174261457016.1344301.3520847990943957158.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250316-ext4-hash-kcalloc-v2-1-2a99e93ec6e0@ethancedwards.com>
References: <20250316-ext4-hash-kcalloc-v2-1-2a99e93ec6e0@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 16 Mar 2025 01:33:59 -0400, Ethan Carter Edwards wrote:
> sizeof(char) evaluates to 1. Remove the churn.
> 
> 

Applied, thanks!

[1/1] ext4: hash: simplify kzalloc(n * 1, ...) to kzalloc(n, ...)
      commit: 1e93d6f221e7cfe5e069583a2b664e79eb361ba6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

