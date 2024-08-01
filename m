Return-Path: <linux-kernel+bounces-271173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44261944A5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1637B24C52
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE830189B9B;
	Thu,  1 Aug 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxEXGGlk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD5183CC8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511699; cv=none; b=ESipCYc0r7/XhVGjmdaiZ8ldyaJzkkEQoFp72lXx0UR++C4O26LzNlBxDtRAYcEHKQ7Xb7Cj1CF6joKB5iLHRHDqUywbKmBlEczhMG07AuvYFMBcqeM0DH/6ZlD1HMAILrQ2u/DHRD2lHxGcSQ/e67dQB9fHaVswCFpnju83UHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511699; c=relaxed/simple;
	bh=mZM8ShDKFN03JigDL5TNPjn3F1g+jShmFXjhR3yjiGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ni7/jVv8a8H4UAI3OUJw7bSDOY17dpj6u+Qrwj5N1LqO4llrz+tmKUh2n7Jvm5YHHJT8u0z2d+6YWv07yOCSiXzEjpVSqWyP59bWsgEnkc5BImhmlsYFNxuMKASXMepU3DGOAlAhA7eYyg8Rep6IrkPcGFn8qxg2DgnjYC0Wq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxEXGGlk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722511695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=gvGF3Ef4dkikJ/Hli43T5ir+KPPgKqAfpvG3aCiZZik=;
	b=XxEXGGlkY9tMwRmsSCiEBoLsF+fRUn02ADVOOa73kao+WSbsB35C000X5wwaL61iYRAXIn
	iYK1JHu29PTQJtz7tki6IbQ9xkT8LaGxbDWbxQxKJiks6lv8TfQGCv4fTIQEW6RSoEGRWS
	Rl48Fd8ovTcMZke1QuOKCccJ1TmpV30=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-eCFFAnTQNLSudFPLefCy_w-1; Thu,
 01 Aug 2024 07:28:12 -0400
X-MC-Unique: eCFFAnTQNLSudFPLefCy_w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1908D19560B6;
	Thu,  1 Aug 2024 11:28:11 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F79F1955E80;
	Thu,  1 Aug 2024 11:28:07 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Subject: syscall.tbl refactoring seems to have dropped definition of
 __NR_newfstatat on arm64 and riscv (64-bit) at least
Date: Thu, 01 Aug 2024 13:28:04 +0200
Message-ID: <87sevoqy7v.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

It's been repported that __NR_newfstatat has gone missing from the UAPI
headers.

  [sanitizer] __NR_newfstatat not defined in linux kernel headers in
  aarch64
  <https://github.com/llvm/llvm-project/issues/100098>

  __NR_newfstatat no longer defined on aarch64
  <https://bugzilla.redhat.com/show_bug.cgi?id=2301919>

I suspect that's related to the syscall.tbl refactoring around these
commits:

commit e632bca07c8eef1de9dc50f4e4066c56e9d68b07
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Jul 4 14:33:34 2024 +0200

    arm64: generate 64-bit syscall.tbl

commit 3db80c999debbadd5d627fb30f8b06fee331ffb6
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Apr 24 09:14:39 2024 +0200

    riscv: convert to generic syscall table

Thanks,
Florian


