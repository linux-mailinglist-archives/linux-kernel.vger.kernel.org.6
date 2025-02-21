Return-Path: <linux-kernel+bounces-525204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C7AA3EC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F0E421682
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8FC1FBEB0;
	Fri, 21 Feb 2025 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI/NJwlR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A71F3FD7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117059; cv=none; b=s6D6Y6XGALTDpsBFxpQti3g2UhbnS7EdJB8ww75ArvsIargwOVXaB2FVygLR88fp0OxTCzAoWWjgoCeTH59teTtwfWY1x7rrUGJxOmP6qmySp0P6ZjcbH9v74sVDgDIjGxXvbWnR/OgJ19UCpDhkF9t4J94nzU8d/W8A478jcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117059; c=relaxed/simple;
	bh=K1T2o/vCyEITexv4WCBzEEJJ3U6qnc3E/6iz3JNtoXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QhJCIR/pO/PoxrtQ7qfYWsH5Vn5IhrUkiSzLLFRZpih/L2/sTIQ+POfExNtrDY4PR845j1EsXXlP4mjmetdhm/qbj4nrDgr0hv3ttyLvzj2vlz7D4Q+HJX6RG5A4Kn/OGHz7HQZiKCGrKLeKmg3VwMaIOnBSl6j5Hc2A5uJnh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EI/NJwlR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740117056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8n/y5M5Rgs8X2823jv5/GcyScpEIxbJkh3xrgFvCPg4=;
	b=EI/NJwlRLVv9HZGQ58hskOL7fmTroMlC5c89ye9LSt5/GhZBV944K3EpUqBJwMx6RapOXX
	J14DgzBqwTWnsBIaPYRLORlcIchaNeGhMO8xAppYj3ZFOxDwvKGVuGoalmAEorqE7Y9nCc
	RggOEso3L1WZk4sV5kXvotUhAsbHk5w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-EWo52nA4M82yhiOuVwMK6w-1; Fri,
 21 Feb 2025 00:50:50 -0500
X-MC-Unique: EWo52nA4M82yhiOuVwMK6w-1
X-Mimecast-MFC-AGG-ID: EWo52nA4M82yhiOuVwMK6w_1740117049
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E61D19373D8;
	Fri, 21 Feb 2025 05:50:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBFD5300019F;
	Fri, 21 Feb 2025 05:50:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 29BEA21E6A28; Fri, 21 Feb 2025 06:50:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Shiju
 Jose <shiju.jose@huawei.com>,  qemu-arm@nongnu.org,
  qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  John Snow
 <jsnow@redhat.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/14] scripts/ghes_inject: add a script to generate
 GHES error inject
In-Reply-To: <20250221055728.03289b6c@foz.lan> (Mauro Carvalho Chehab's
	message of "Fri, 21 Feb 2025 05:57:28 +0100")
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
	<80858743b6fd67db3f48ac8cb466bbcde5b11132.1738345063.git.mchehab+huawei@kernel.org>
	<87bjvg6c22.fsf@pond.sub.org> <20250221055728.03289b6c@foz.lan>
Date: Fri, 21 Feb 2025 06:50:44 +0100
Message-ID: <87o6yvongr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Wed, 05 Feb 2025 09:16:53 +0100
> Markus Armbruster <armbru@redhat.com> escreveu:

[...]

>> Sorry if this has been answered already...  why not GPL-2.0-or-later?
>> 
>> More of the same below.
>
> No particular reason. It is just that GPL-2.0 is my preferred license.
>
> I'll change the license of the three scripts to be GPL-2.0-or-later.

Thank you!


