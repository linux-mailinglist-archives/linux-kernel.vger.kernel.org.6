Return-Path: <linux-kernel+bounces-525071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AA5A3EA78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152D017EAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC081CCEE0;
	Fri, 21 Feb 2025 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="qeXA+tnk"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCA1C3C08;
	Fri, 21 Feb 2025 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103134; cv=none; b=kr/1ykBoEwfg5BEDue80wQ5lJ0EmF8PSza+4cx58lp3cu5RX6qyD7Bv+60XSPebmZ7nhRClAHkmIMHhc4WhRxN4Zx8ycbq+DAcVBtL/KDAVqoWdv2NLMjLPW77JB5O4Sqg0dPqHdkrtT1UBBhpvXQgbO6E7XU/aQxEE/iWR1uAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103134; c=relaxed/simple;
	bh=YKzB9LlS+hz9zHtYRIJ5VBIMcp4B9hLVUYeSJF2x+4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUPS1vWqlt03IZNF7g20dbj1QRxtnuLATjsNkCb3e6+enDTg5yIXQeNt29hobJPf5RgfH4asjTo06C9Ln89S4t/5fsEaJBhEhrgjTkGmm9jT6LibMDHgSVUTLdR3bOuWIQyS1VH/Y0cxA7JzNRJjruurzRXd8Di7HqfxTU3VECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=qeXA+tnk; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=8PnzCTyZw6paCch4lbu5zV0UA8a6YCbFLxHKnS85TRs=; b=qeXA+tnkY/r5Sifr
	hXlECacakS7zd8TnqWIm13DoahDn0sjQkLKbmizrY56EwFyzlqi5aXxwUe5yiL0l77Fil4pRdyEtH
	srJkfROQQSlIlk/16vUxCiXtYnAVb4LG/qwRcrBf5rmBwgdpj76mB7q+8H/L4xLHtqANlt7tle2uo
	DDZRCFEgxQGvMpCdHVVoiQBPIf4cSEVHDx5klC0BjLbzSH9FH7gLw4D3z91nLF1pT/b9jbQueX3Pp
	VM33CYvEu4wum+ycRhLupjUs3FMJTXh0o84zfBf/YMnBzZtKPBw0k9pRyPQOEmIi16cwwUARCQESM
	csdLdQm4w3stVcbIOQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tlIJN-00HM47-2y;
	Fri, 21 Feb 2025 01:58:41 +0000
From: linux@treblig.org
To: srinivas.kandagatla@linaro.org
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] Remove nvmem deadcode
Date: Fri, 21 Feb 2025 01:58:38 +0000
Message-ID: <20250221015841.209458-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This series removes some uncalled deadcode in nvmem.
The third patch probably deserves a bit closer inspection.

The first one removes nvmem_device_cell_read/write functions
that haven't been used in ~10 years.

The second removes nvmem_add/del_cell_table - again this is
removing uncalled functions; nvmem_add_cell_table is unused
after the removal of the Davinci machines.

The third one removes the remaining nvmem_cell_table code - including
a function that's called ( nvmem_add_cells_from_table ) - but
my reading is that from the previous patch there's no way for this
function to do anything active any more since the list it walks is
empty.

Build tested only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (3):
  nvmem: core: Remove unused nvmem_device_cell_(read|write)
  nvmem: core: Remove nvmem_(add|del)_cell_table
  nvmem: core: Remove remains of nvmem_cell_table

 Documentation/driver-api/nvmem.rst |  23 ------
 drivers/nvmem/core.c               | 126 -----------------------------
 include/linux/nvmem-consumer.h     |   4 -
 include/linux/nvmem-provider.h     |  24 ------
 4 files changed, 177 deletions(-)

-- 
2.48.1


