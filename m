Return-Path: <linux-kernel+bounces-574809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D209BA6EA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7023AA3E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075CF253B5D;
	Tue, 25 Mar 2025 07:20:11 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750F253322
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887210; cv=none; b=cblZAPm0I5vf5sFQhCZhZIRvGBgF53B94aapciCwIk1nH1TsdUEiM9x2ubdJPQIqK8RUH8AzTnlVGLRk8zPr74o1FocVC81aybnZYpl57NmgxEpFPaHqJ8EzVn4fhDmOxBftRAC8F/R0gV6XUB2VNd8xEACWUqP3rUcDKuWP8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887210; c=relaxed/simple;
	bh=7++8MRvel0ZG165ECZzrMH/By98tMTFy8BYo3OxxrDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoeRCctxxlbxcgjW1Gt8R1aB4Hf5BHqVJm1hGyXkPsE55PT1NxU2c4ezn8aCJYWz1uJQ2xD1XQMdR5TV+DUgggJwiJ3O5q0R6GczF+yBGTBPdxFaSZk5d4FDrNW3ouLb0yJIm0fSQyfYRaMZEMFCs0SSuDyRaxiLtxCxhBspFTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZMLW63xsFz9sSN;
	Tue, 25 Mar 2025 08:04:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v6JKQQL_eFrh; Tue, 25 Mar 2025 08:04:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZMLW635Zrz9sRy;
	Tue, 25 Mar 2025 08:04:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 519418B765;
	Tue, 25 Mar 2025 08:04:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id RHurKaChOlYD; Tue, 25 Mar 2025 08:04:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B9F58B763;
	Tue, 25 Mar 2025 08:04:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.17.1) with ESMTPS id 52P73rZi009331
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 08:03:53 +0100
Received: (from chleroy@localhost)
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.18.1/Submit) id 52P73odJ009328;
	Tue, 25 Mar 2025 08:03:50 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Stuart Yoder <stuyoder@gmail.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/3] MAINTAINERS: updates for the fsl-mc bus entry
Date: Tue, 25 Mar 2025 08:03:27 +0100
Message-ID: <174288553817.2234438.3505434675141018123.b4-ty@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250320120319.3520315-1-ioana.ciornei@nxp.com>
References: <20250320120319.3520315-1-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742886214; l=861; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=5ct58WUMCAhireJk5huWUvhQ9El2yA0OK7tPTYy9x7A=; b=F2JnbXHN3cz8KA26VpWyklKsskrhu/PjUTjpnQuGBhLOOzsPIA29F8wTqO9SMTufc2xs4Rk+V lBtj8F+abOTD2p1xRKgGg9i/g2W7MVVQaUYXg5qnJFtHn0aZl+bupc3
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit


On Thu, 20 Mar 2025 14:03:16 +0200, Ioana Ciornei wrote:
> This patch set updates the fsl-mc bus driver MAINTAINERS entry. Since
> there are small separate changes, I put each of them into a separate
> patch.
> 
> Changes in v2:
> - 1/3: also removed Stuart from the MAINTAINERS file
> https://lore.kernel.org/linuxppc-dev/CAEac7tYQE76z4pYminhvMJR6GZ66RPRv4PxM-U9VpGJjvn6APg@mail.gmail.com/
> 
> [...]

Applied, thanks!

[1/3] MAINTAINERS: add myself as maintainer for the fsl-mc bus
      commit: 29904d6c1be66882c7148a1439e0f671fc02e56c
[2/3] MAINTAINERS: fix nonexistent dtbinding file name
      commit: baa9934908ad1cb6f7093c8ba15d518a43419f9a
[3/3] MAINTAINERS: add the linuppc-dev list to the fsl-mc bus entry
      commit: 586739b1e8b14a38145a80e7684874d1a3268498

Best regards,
-- 
Christophe Leroy <christophe.leroy@csgroup.eu>

