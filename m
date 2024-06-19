Return-Path: <linux-kernel+bounces-220410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC590E161
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17A8283E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA5DDDC0;
	Wed, 19 Jun 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xsCcz3WG"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3ABCA40;
	Wed, 19 Jun 2024 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718761398; cv=none; b=GBEHN85cXxOhOypam4iu5kGAZJWnW+rEkNdxSpajRCtU1EDQJ6fX+Di+NELiJU4YeWlt8alVcKUzYGIJVSS9IGI2CY0H90ppqiH9PKyfgqcLcMXimdo6F0lzFF1G7wfUP83FDWQ9unw+K3VPdQZTEsGNZajrC2iTsCPEZVCIycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718761398; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:From:Content-Type:Mime-Version:Subject:Date:Cc:To; b=fjmb1Sj/9cFud3FhIPf6EfCO8rO1OZozxxe/xrvsxkvgwnW2U+qG0NFiVy+tN+GRfLq4aW7nuIxg1loXKq0VXHOqKmdUGxzVl3uzbxiSm7oGqA89sKXjaasa9k9lF19viVCbyrtgswwqF2ZaVv8BTHLS8rxBoVVMpVcHgKFmYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xsCcz3WG; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1718761086;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:Subject:Date:Cc:To;
	b=xsCcz3WGEC0jUtG/OFZH/2SrmfktfMqk5UZGZ8Ju2HUKQfZXszAf6CWELwu0VuYHI
	 KABoQxrguE+mjo5HG3nRL819gv+Gt7z/W2NzWwuqYOzNJGtbErdpHd7n73ilx4RHQn
	 aZlu/4eizveWZABH3TZL7Mh1GXnFU0dC2ja+tXMo=
Received: from smtpclient.apple ([2401:b180:9000:0:1051:934d:1051:934d])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 983B581C; Wed, 19 Jun 2024 09:38:03 +0800
X-QQ-mid: xmsmtpt1718761083tq8lqe0wo
Message-ID: <tencent_33256C08A57BF8870600614ECB9602004405@qq.com>
X-QQ-XMAILINFO: MVKy59SpMLfUV+b8Y0xW1uUo8WDMtRWsdFPbHcJ4FQkUYMHE4Pz+nsCp2U6G4o
	 EtSbApYCfO7AKa6H+hQrPINoIaL6DaD4l3oedMvCXzRN7WgGqDU5af8d7s/tjrvmjDlHXFw35O6T
	 Zv6eRN0RalLM6CS++3IGCEE/weCjXGGiX3xUEKvEnWRgzTEkSH2C1UzlT43A7HJZfwhwLVgdbJOS
	 9gmNS5+i4Pqbd9k5EHhFDREbaOxXGJddvVNy/+jBfzvsMv+fLDhtMgEXR6bucoRgWYtSrsB0wTjw
	 ia8EzpqqybDeF1z7BWiFBc2QTG74v4g0o1VoIeney7l4tT7xLc7zyB85kK+ZgTL6oPLXChp+FNXG
	 LBzIEdvI220fTtA8bUYFijxrMnKaGL1N2j2c5/VDxgoZRlPp+MdZmNWNgeMK2Zl16VM7I8pzZjU0
	 tsBXTfRlLtt4UJjPGIAiIwh6aR0Qg1K97pKJ6hgPt4FPIjlulTuc1Vw+FfJK43ecJQpWprHpGZCE
	 13UnGg6ESum2oJyH5J9GW0XWdiCPS+/vaz8MWRLuvEVjBKNpYGDwb4QcgAjsjVuVdC7/NbnOGKME
	 YE+ScgHNiHbpZVARcCp30ZjkfGUzp5+OjNDdIoaajW911B7jjyiEPsglPEsWsUPf7wUqC84NaPYV
	 yDAPzCmdgGOdVGiZpNwBYhc02YAYQtQLXebk3ZIpafUOZn4u44YOhtRH5ft9WuS0upg0hePfVsIt
	 fHQYzwtI9v99oFIzDxe9LGlHvLhEDKC5Fgzu/ykoBMzW2p/VHb5sJ9gIN20p1nUMk0XRsqPxD/1P
	 4TiRj16pGxXIUkVK3ET30Dq4DwLdmbSRbN1//wxzLmA7HyTCX4vr7bgzda8QNtLBz8ErKwCbkNvn
	 Q9N0znxTqE5tZjZNx6yHYP2oM+KzVhuLrS/R+Tyw4t
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: =?utf-8?B?6YK55rab?= <wodemia@foxmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH V1 RESEND 1/1] zh_CN/admin-guide: Add
 zh_CN/admin-guide/numastat.rst translation document
X-OQ-MSGID: <F7159148-EA2E-4BDB-B689-C6DD75C1D3CC@foxmail.com>
Date: Wed, 19 Jun 2024 09:37:53 +0800
Cc: alexs@kernel.org,
 corbet@lwn.net,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 wodemia@foxmail.com,
 wodemia@linux.alibaba.com
To: Yanteng Si <siyanteng@loongson.cn>
X-Mailer: Apple Mail (2.3774.600.62)


