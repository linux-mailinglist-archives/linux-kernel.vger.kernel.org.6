Return-Path: <linux-kernel+bounces-540580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0DDA4B26E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C95A16D87F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200C41E7C25;
	Sun,  2 Mar 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="N5rXtFnP"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8BF1D61BB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740927581; cv=none; b=H0emH3rZsVchqdeV09sdwR1QWOkdEYWXDqkUlcmWvIDKD31xw2OocOgO9mtvKwHFhy13j6AzYg03Wc7EWfWEZqQqwGJTpSmRVHXsFv5zHDW1fin2t5nbdTGqLa82B+dG9yLlOpFE3tOetvH/5haMgrTWAjgiwRlVXlr7l7mxMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740927581; c=relaxed/simple;
	bh=vG5djXaFhKK3CzDRSFtUV0aHIyTlukv5vBOR74eFVik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGoIP9Gkkg0d2IyLzNTZ9DDhPNLOj7nK64IZFGAnSZKgbg+QxMQl1aAFwc7y5+3HqARMjdwYVVFgSsV1ZQDjxD2devrQzcROv+e2xuKrtXKR9VAIOz6oFTIwk4nwwLJ6w0JrLdKhIrGz5Pb7pjeHaWeP8sYUW9SbTCjO1DVhJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=N5rXtFnP; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id okmqtJVk70yWRokmut9O82; Sun, 02 Mar 2025 15:59:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740927569;
	bh=CHITz2+YWVCqZNH8zM0mCk4OaRmTsJ9xq+F0/7AL1r0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=N5rXtFnPdciX4yYY/+OAbDtQWCPVFXb0Q7ZwJp8RQBxYKLhiMBfbZELmQBspi2cz1
	 UQfhmOdjvcCKk8TTVQw3QfKhcIjwpXFb15L44d4zDcZYuBJTEK7MFXW2pCFKjXAzEe
	 cKfqVLg6T7j+bKTKCacfO0894mvXRItoyqSZ1g1o9VfvgmqHCef9O9EUCkv+Orl6Tu
	 kPikree9OBxPQRsJkIMX31J6B4IZUIQWWkmEb0fDkWhYRi8rUCNLBZ2LG4lbPcRT1S
	 7XITGjy/ij66aTeP0D4yYEFD8PvqSHCBm+EEM8FpQBDp/8wCUKI6iMIACeYJh0ei05
	 BGeJgUR0rJwkQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Mar 2025 15:59:29 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2] powerpc: gpio_mdio: Simplify gpio_mdio_probe()
Date: Sun,  2 Mar 2025 15:59:14 +0100
Message-ID: <cover.1740926808.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While wondering if it was correct to call mdiobus_free() in the remove
function and only kfree() in the error handling of the probe, I
arrived at the conclusion that the code could be simpler here.

Patch 1 uses mdiobus_alloc_size() instead of a hand written
mdiobus_alloc() + kzalloc(). it also uses the devm_ version in order to
save some LoC (and answer my initial question)

Patch 2 uses devm_of_mdiobus_register() to completly remove the .remove()
function and save some more LoC.

Both patches are compile tested only.

Christophe JAILLET (2):
  powerpc: gpio_mdio: Use devm_mdiobus_alloc_size()
  powerpc: gpio_mdio: Use devm_of_mdiobus_register()

 arch/powerpc/platforms/pasemi/gpio_mdio.c | 41 ++++-------------------
 1 file changed, 6 insertions(+), 35 deletions(-)

-- 
2.48.1


