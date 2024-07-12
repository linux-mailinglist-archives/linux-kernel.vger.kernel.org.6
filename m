Return-Path: <linux-kernel+bounces-250275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BF292F5F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034FF28165A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41B913D8A1;
	Fri, 12 Jul 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2Sk5wBk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5A200A9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720768309; cv=none; b=vBBhuEm6cNFORt/+iEbrSM19CvCPK5t5KA1eKQDpp+YVaUrDPmrF++b3bO8sTDfg65+pl2Hgay7XSUsCDdceWicML1W9vSQ7/XNPgv50bOxtil1Anluct5KYGEO1mBIunWN/cWZgmAxVh+iqVGYJZbnKtnHK0ODl+J2hS2CeoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720768309; c=relaxed/simple;
	bh=d3bGbQxdmtGnFYCN456kMPjz+j3MldMdmEnprdzEfVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=Sb4RLd84pymsPJoAerveQ7f0Jk2Ji0uC/EoWQAI3E+FKz/MVCwDKZxpxqQbfDeyrO4xiDcUwSzQy73uPZMmrWDMC5LQ+WdaCAuF0LQjVZYDPjKl38bUu77TI+shisG7Esxg9jbrYQnPrn4n2LyQ1Js3eHzeQ3zz2BDx/k5gvI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2Sk5wBk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720768305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CuAjWFlcc5b0uJ1rZAYPcAUm08klty2b2sLm1pv2iG4=;
	b=T2Sk5wBkY8pGPxYepEWj1T26IAKQ1kSyGPcRKst8pWA2zzQHvxWMTc2By7ZGAyjpyvC9Qr
	zxFVfLc95Tq9eFrUgLDVxMmK0JowzrehPfCuEixToa6tmBQpGnZQa4Jo4/MHeAWU7qvCkK
	i/ynMoFjatckC5NGnTtzMR3NjyroDYg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-9CAb64JxMky0py6PYuu_bg-1; Fri,
 12 Jul 2024 03:11:44 -0400
X-MC-Unique: 9CAb64JxMky0py6PYuu_bg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 780791956080;
	Fri, 12 Jul 2024 07:11:43 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 028A01955E85;
	Fri, 12 Jul 2024 07:11:40 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: dhowells@redhat.com,
	dwmw2@infradead.org,
	zxu@redhat.com,
	keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH 0/3] sign-file,extract-cert: switch to PROVIDER API for OpenSSL >= 3.0
Date: Fri, 12 Jul 2024 09:11:13 +0200
Message-Id: <cover.1720728319.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The ENGINE interface has its limitations and it has been superseded
by the PROVIDER API, it is deprecated in OpenSSL version 3.0.
Some distros have started removing it from header files.

Update sign-file and extract-cert to use PROVIDER API for OpenSSL Major >= 3.

Tested on F39 with openssl-3.1.1, pkcs11-provider-0.5-2, openssl-pkcs11-0.4.12-4
and softhsm-2.6.1-5 by using same key/cert as PEM and PKCS11 and comparing that
the result is identical.

Jan Stancek (3):
  sign-file,extract-cert: move common SSL helper functions to a header
  sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
  sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3

 MAINTAINERS          |   1 +
 certs/Makefile       |   2 +-
 certs/extract-cert.c | 138 +++++++++++++++++++++++--------------------
 scripts/sign-file.c  | 134 +++++++++++++++++++++--------------------
 scripts/ssl-common.h |  32 ++++++++++
 5 files changed, 178 insertions(+), 129 deletions(-)
 create mode 100644 scripts/ssl-common.h

-- 
2.39.3


