Return-Path: <linux-kernel+bounces-435914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5FC9E7E87
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 07:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D503166C13
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B225483CC7;
	Sat,  7 Dec 2024 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daZEMNjS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D574A1C
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733552280; cv=none; b=eL+CumWHK88kGtF+KKo3HFir8oH+9SG0NTx0Dtnz5z30YMQnIjvHA51yLZjb/k70V4IH47BKyae4JYJ9WIb1OOTx0NNmgh4HDUqKmOwAQ66fC9qnccgGOdtC8KshH80Iu/AYLUnInty5/HeqRS7aGcotO/ru/Hwesh024jXiA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733552280; c=relaxed/simple;
	bh=N30TJvXrzvaC1vfQH9ZEUNJj81IPJB/Abu4v/1Xw1YQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YzSJHl7qKjIH/LkcCKAqhmOeEExJz53Yen/yivrEmV6mATVZfCtXSpYk8441LF4C2S//reBHsbtHpB3aLckfGHGAB/7tyb7aIwYLcSuCi1V/nUV4bD8Jnyhc9332qDl2mlrbeJhhl0OjC/FSoU1nR9vX5DY2fXZT46HHk/GjzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=daZEMNjS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733552277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXd6sRb6hzxCMVHU9f1VtGB+1Mk/DPskD3I2aLsr55s=;
	b=daZEMNjSZPitniNtY2OFnDGbHGGu7I1j2qiuHgHhLLB8BYSX525oGIS+9yKGdev0j4JYfN
	bMwItURbaBDZQD4tTxNgPLxCKRgac5DlkeT5TOk38rnCyrVOf6EG5+kgIvKpo/nuamMN7Z
	6jnPtrNlOY4mvn3IRqhxbAFxVu8KH5k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-0iHDL88oP52LvbRkV2HSgQ-1; Sat,
 07 Dec 2024 01:17:47 -0500
X-MC-Unique: 0iHDL88oP52LvbRkV2HSgQ-1
X-Mimecast-MFC-AGG-ID: 0iHDL88oP52LvbRkV2HSgQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F136419560A5;
	Sat,  7 Dec 2024 06:17:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82FDE1956095;
	Sat,  7 Dec 2024 06:17:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 39E4D21E66D2; Sat,  7 Dec 2024 07:17:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Shiju Jose <shiju.jose@huawei.com>,  Ani
 Sinha <anisinha@redhat.com>,  Dongjiu Geng <gengdongjiu1@gmail.com>,  Igor
 Mammedov <imammedo@redhat.com>,  linux-kernel@vger.kernel.org,
  qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 31/31] FIXME: acpi/ghes: properly set data record size
In-Reply-To: <104add143d349685cea1b47298b8f5d367a3a15e.1733504943.git.mchehab+huawei@kernel.org>
	(Mauro Carvalho Chehab's message of "Fri, 6 Dec 2024 18:12:53 +0100")
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
	<104add143d349685cea1b47298b8f5d367a3a15e.1733504943.git.mchehab+huawei@kernel.org>
Date: Sat, 07 Dec 2024 07:17:42 +0100
Message-ID: <87o71o2f09.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Another subject line that suggests this isn't fully baked.  Respin to
reduce confusion?


