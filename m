Return-Path: <linux-kernel+bounces-210603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8D390461A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5386E281F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D25152E12;
	Tue, 11 Jun 2024 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="It54hzqs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5F21364
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140308; cv=none; b=hsj65YSeohBHkRVLeB6Cgqi+N827y593x3mN0bj/CI6xPGkIBVfPAQl4GtKvYvrHLWPw3KpaS5vifcC1TcMBrmJcf0h9qk6lpoMrHto/H4mLp7nRVHOnUbT1qVX1YsNmVSSRE9p2XOhKz7Du44p1rkEfy7Zs0wrzxPcAMM0nvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140308; c=relaxed/simple;
	bh=maB6CaHEx9s9SPvBuEwLIkR00dt0tjGNbYhSUkIz2VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLSOw0jWvmEZT1W82uZFGAIbmF2QArlyO0MFNS/0lWwSUM2B4qkxqCrCP0sWyttdvHWDGFzkmDDf5yC59RCXTYwfHOK5r1K7iXwXU//zJbwoNhNE3Sf4KKdK9g+8Y/mgD0T7VADMK+hx++ZPiGlllwU9YLct0bqZTv1lExkJuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=It54hzqs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718140305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNr+ss4QaS2MDribXW6MuNOxVlwStfChUH+ZQND479E=;
	b=It54hzqsxG/7rg4pdenroWFiYBtlgIyHB1EsSzXQXPUNvndC4SrKEjZZbB9kcA19UXC3nL
	WcD1pR/uEcST8PK1p2EnaoXZXCqH989hW9MHvgCNxpC6ERQBMUs4SI9gexCfBn0pzrkOD/
	KdFBLXuFg/Cl/MLAhU4QxY2FUCx4m7Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-W6VdvvwnN02kzPWpvwowzQ-1; Tue,
 11 Jun 2024 17:11:41 -0400
X-MC-Unique: W6VdvvwnN02kzPWpvwowzQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DC0D19560AF;
	Tue, 11 Jun 2024 21:11:39 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.22.17.224])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC5E719560AB;
	Tue, 11 Jun 2024 21:11:36 +0000 (UTC)
From: Rafael Aquini <aquini@redhat.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	aquini@redhat.com
Subject: [PATCH 0/2] kbuild: rpm-pkg: fix rpmbuild warnings for kernel.spec
Date: Tue, 11 Jun 2024 17:11:20 -0400
Message-ID: <20240611211123.959459-1-aquini@redhat.com>
In-Reply-To: <CAK7LNATxSePzOrHaQvS1MQo4mpAwdfwrDu3iuUsYZ+RL=LiirA@mail.gmail.com>
References: <CAK7LNATxSePzOrHaQvS1MQo4mpAwdfwrDu3iuUsYZ+RL=LiirA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Newer revisions of rpmbuild are throwing warnings about the current
kernel.spec template having an unversioned kernel-headers in the
'Obsoletes:' field and not being able to source the epoch's date from
the spec's missing '%changelog' section:

  $ make srcrpm-pkg
    UPD     include/config/kernel.release
    GEN     rpmbuild/SPECS/kernel.spec
    UPD     .tmp_HEAD
    ARCHIVE linux.tar.gz
  rpmbuild -bs rpmbuild/SPECS/kernel.spec --define='_topdir /mnt/nfs/work/kernel/linux/rpmbuild'
  warning: line 34: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
  warning: source_date_epoch_from_changelog set but %changelog is missing
  Wrote: /mnt/nfs/work/kernel/linux/rpmbuild/SRPMS/kernel-6.10.0_rc3-1.src.rpm

  RPM build warnings:
      line 34: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
      source_date_epoch_from_changelog set but %changelog is missing

This patchset addresses both RPM build warnings.

Rafael Aquini (2):
  kbuild: rpm-pkg: make sure to have versioned 'Obsoletes' for kernel.spec
  kbuild: rpm-pkg: introduce a simple changelog section for kernel.spec

 scripts/package/kernel.spec | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.45.1


