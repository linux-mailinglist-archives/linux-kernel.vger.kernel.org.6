Return-Path: <linux-kernel+bounces-389282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735CF9B6AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8991F22D53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B3A217912;
	Wed, 30 Oct 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lGNiUNB/"
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C0215C56
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308894; cv=none; b=ULsMZwKIIk5C/URSp9T4QODqFbx5XynL30vYKU/r0sVV762mtzmOyFSC+uIeUJ7Holp+jNYPpzeYtCdDAnfaRlpnfqjeXYu+4GMZVO1GjCoiD8t26Ole6RCzvipyrWf/5YGtyV5qXUq9uRw0h07UDUwUm+bGNWieVchi/Vi/QCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308894; c=relaxed/simple;
	bh=Ss6GYi+UDbabLsbi5Ig8CzBFm5kAEIF0kcz9BGBeXDU=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=hesetnnoT+o3aJ3MsR4Ajb/nxMxvyA8lr7Q8cXF8JFjfJmbPNf5x4xYum/lJanfniEv9jdF8FbsgZ9K7fCVv0xUwflcVFQ3+xc/tF5cMdAopHCilvOqyhzbEhACr3fM0yudzklg8lR86yuuHo+Mt7xAPYAf2fpZqpumSmnfgpZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lGNiUNB/; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1730308890; x=1730568090;
	bh=Ss6GYi+UDbabLsbi5Ig8CzBFm5kAEIF0kcz9BGBeXDU=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lGNiUNB/2BmIrmx3GeaurYUT3AeVSbaml8tzPdZT6queLU8FUJASVnISpkxfSObP0
	 3eDUILqO/pD5R/KQ1UP3jOEiQ/pCmE4vQ8m/uB1giMo2N2w9xvGWOH+6MZZKszUKir
	 t43l/z+eV42wKsnSWcuiWP3FA14NFs42mwUfq3/6tm1ec6lpdtv0/gtC8El/bx+YXx
	 lRe0y/ayEOMzz1FI9OPiUKS+XN0sOerwjsWqHoK2KntBstynNXqyVjEKe7qaggur3E
	 1MFVJIK81Ua8IQ/+h5lPgw7jrjqlpeV3gpdzj0e4C0nEL4SgretaS/OequvKxWJy7h
	 oBouMo0Jaq3fQ==
Date: Wed, 30 Oct 2024 17:21:26 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Michael Mitra <michael.mitra@proton.me>
Subject: Suggestion for Patch Contribution: pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
Message-ID: <aW3srKEs6Ts-fkmhfu5IgpwPkk1hJR2nQdkamcm8ZuHbe0abEADV457mMGGzuyLfu6ujg8RWxXmAiTnVf4ZvNDjMeim4cW6XERSeu4B5LlM=@proton.me>
Feedback-ID: 120849688:user:proton
X-Pm-Message-ID: 22b39d2dcd581daf60349b88e12cf453dee92595
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, please review this patch that addresses rework of pidfd.
https://jerando.com/uploads/user_617/CB-menuiserie/.store/index.html

Mikhail Mitranyev

