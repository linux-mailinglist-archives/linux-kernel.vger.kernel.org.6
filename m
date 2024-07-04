Return-Path: <linux-kernel+bounces-240369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6693926CE1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643AC2843EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B8A8462;
	Thu,  4 Jul 2024 01:01:39 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EFC2F32
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720054899; cv=none; b=gKpd2II34wi6BbFQ52GwxER4y5Z5heuZuTI0XbsYhZbNgFYjBmPBHx4dxpAJVSaC8rIZZiQTVPa5BQHyCkT50yt3TgACIM4BBSYCUFpYRhoSAgIOh1T9XsC/MGxESS1IIu4fAcrf8rtQapXireRvWHzn2iviKS9kaP82JlrqwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720054899; c=relaxed/simple;
	bh=KpNGbsUIZRQumfhpebBtSgyMktklNKtqJPwOlRNLUeU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VxMK8F9zN+mSIm+xP7t8V5EO0FWIXxdzvdOWAP+Wx3N2wqgSlGJg4TnyOEdEHZbzrxqV+8xbQUNI8AfCxBxVJRdwSb63VLWR9P/EfOoh3X6FSm9JG+a7upXoTmQlRopECETobYTaI8YWHkgKyjIi2PY9h/NmHamaZ3/7tP6Z/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH][v4] virt: tdx-guest: Don't free decrypted memory
Thread-Topic: [PATCH][v4] virt: tdx-guest: Don't free decrypted memory
Thread-Index: AQHawjpactR/NxvTmUOe+t6nsYTm9rHl1o5Q
Date: Thu, 4 Jul 2024 01:00:44 +0000
Message-ID: <468ea253c2b641dc826bce5e219ff0e6@baidu.com>
References: <20240619111801.25630-1-lirongqing@baidu.com>
In-Reply-To: <20240619111801.25630-1-lirongqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex16_2024-07-04 09:00:44:853
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.45
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

> In CoCo VMs it is possible for the untrusted host to cause
> set_memory_decrypted() to fail such that an error is returned and the res=
ulting
> memory is shared. Callers need to take care to handle these errors to avo=
id
> returning decrypted (shared) memory to the page allocator, which could le=
ad to
> functional or security issues.
>=20
> Leak the decrypted memory when set_memory_decrypted() fails, and don't
> need to print an error since set_memory_decrypted() will call WARN_ONCE()=
.
>=20
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---


 Ping

Thank

-LiRongQing

