Return-Path: <linux-kernel+bounces-515326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C33A3633F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35FF169C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B62673AA;
	Fri, 14 Feb 2025 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="etCggWTs"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF41519AE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550992; cv=none; b=D6w6pVI0LfWK616VnWj6i1kEIuX02VwMCzsrvwPkj/t0sLhScp8gHZQyXB8ICfpaPdU2fOqp3xnGj+X8tRvGZ4JBgtsfaxLEy+BVOn6rfpNqq5TwmQs03e364kbEmMP356CapAABUBJ6I1ZsSD+oXxhrQi7uEd04OVmnKIbEWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550992; c=relaxed/simple;
	bh=1OchyBLQNbTi+NZeOFydF9x1FuN/RuVN5Jl20UpsW1A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XBGubOi2c2dnob2Cf7BT/HBvXq8gi7m11S3u9fKj63YQTstbFDEsLhlk68sLhhCJISGuqoL1x0U5pFX8sS3TVt9MIN4YmwcOUKsxDLpGQrqsCH+kE9dG2AYI913mBqwn11CaDwKuD9Ynvmosq2+OM3wqcmeqEpicJIA1AUnoJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=etCggWTs; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739550979;
	bh=1OchyBLQNbTi+NZeOFydF9x1FuN/RuVN5Jl20UpsW1A=;
	h=Date:From:To:Cc:Subject:From;
	b=etCggWTsDwk+DhZmkL2gMhLbc39g6ymcjzWni4rU0FEwBVBjZaa4VLg3zhi6b0AOE
	 b/UP52F80cwl2gPjXJ8temvbYlGoXCjbxIqE45y8dh2cCqimYJ8VH9zR32If2ND9N7
	 FWFFeZesLNfzHPNtvcIp6Ux60cM6Aa2aLWBdGzBA=
Date: Fri, 14 Feb 2025 17:36:19 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Current state of the 'const bin_attribute' constification
Message-ID: <fae9a4c4-a497-4990-89e0-aceb05e58502@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

most of the patches for the 'const bin_attribute' work have gone in
through the maintainer trees. A few series have not been picked up:

https://lore.kernel.org/r/20250114-sysfs-const-bin_attr-cxl-v1-1-5afa23fe2a52@weissschuh.net
https://lore.kernel.org/r/20250125-sysfs-const-bin_attr-dmi-v2-0-ece1895936f4@weissschuh.net
https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net
https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-fsi-v1-1-b717f76a0146@weissschuh.net
https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-habanalabs-v1-1-b35463197efb@weissschuh.net
https://lore.kernel.org/r/20241222-sysfs-const-bin_attr-input-v1-1-1229dbe5ae71@weissschuh.net
https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-mokvar-v1-1-d5a3d1fff8d1@weissschuh.net
https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-pcmcia-v1-1-ebb82e47d834@weissschuh.net
https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net
https://lore.kernel.org/r/20250114-sysfs-const-bin_attr-qemu_fw_cfg-v1-1-76f525a3ee72@weissschuh.net
https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-rapidio-v1-1-0f47f4719683@weissschuh.net
https://lore.kernel.org/r/20241122-sysfs-const-bin_attr-rci2-v1-1-3db1ec9aa203@weissschuh.net

Do you want to take these directly?

Then I can send the removal of the transition machinery.
There is also a potential conflict in linux-next with Kexec Handover [0],
but that will be trivial to resolve and hopefully they fix it in their v2.

[0] https://lore.kernel.org/lkml/ae80c1b9-bafb-401c-9789-37a774c702c0@t-8ch.de/

