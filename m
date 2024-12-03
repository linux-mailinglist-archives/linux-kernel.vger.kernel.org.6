Return-Path: <linux-kernel+bounces-429556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A29E1DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C002810E2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1DB1EF0BD;
	Tue,  3 Dec 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqc9GqaJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE81E32CB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233112; cv=none; b=lRTjHgym/LpVK5YRKpZECJdU3PL073R1HBuQZlCihkgOsKwLFw61ditiVHF6kGEiIiLSqggYPR+LXMoX+GeL3TH6V+fom2a25OWtFKAoyxD0BCl+lGn79yT4ivBYw2EQJBh7xXxdatj4K7qurgKxNUXc/CwRjZ6f3XiuUpH+AvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233112; c=relaxed/simple;
	bh=7rxcTbvnhbMVz8ygNphkbF86kDtn0YCOEk/Z5XEkOIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocZ3c+VxPBmlG1QLlQXjGUMo/JtwJ6nC1KYNNtmC0PIoYkTFQLvp76GL8IVcyQIfcHSq9hKiNHDljPHuyRSKALvVhJSMAOMUGk/YyAvTs2548F/cu9RKtwnzq9cczgteR89w13afxcMUtymPYa6gkA84rnLcIbIwbqIl06q9U6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqc9GqaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C710C4CECF;
	Tue,  3 Dec 2024 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733233111;
	bh=7rxcTbvnhbMVz8ygNphkbF86kDtn0YCOEk/Z5XEkOIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uqc9GqaJAwLMEfMTl1Uxxddq28fOYmkab+8EZHajCB9nJkl6YKkV66Rn8EIv7hZVT
	 /8RMKl+agEt1aQ6br0aQDLMDzW3UB6JE7QL30/BEmsTJVySuu9EkHoRsQHoYWyYwhk
	 7uJ4i5yV/ydkkycCttziqNqxlF1PdQ3hPAPZrAE/ZMw4qcizb7lHR+cCWHun4toi1l
	 zDmxacGiTGVe6QIvi+WYeAgY/EPFyFQ3NNT8ae3iMl4KPY69BpOsXOs2iywSthl657
	 jJ/vjf1/nsH+cac7j92JCCdpQU+jgO8SCeoXuA787bz8Xf0jbjt/V/csJ+W+hRLpyH
	 p/aGkoLSnWEkg==
Date: Tue, 3 Dec 2024 14:38:26 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241203143826.4fd23e48@foz.lan>
In-Reply-To: <20241203124232.7948b2fb@imammedo.users.ipa.redhat.com>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
	<20241203124232.7948b2fb@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 3 Dec 2024 12:42:32 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +    /*
> > +     * Clear the Read Ack Register, OSPM will write it to 1 when  
>                                                  ^^^^^^^^^^^^^ typo?
> > +     * it acknowledges this error.
> > +     */

Yes. I'll add this hunk there:

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 68fb30c2d5c1..4b5332f8c667 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -403,8 +403,8 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
     read_ack_register = cpu_to_le64(0);
     /*
-     * Clear the Read Ack Register, OSPM will write it to 1 when
-     * it acknowledges this error.
+     * Clear the Read Ack Register, OSPM will write 1 to this register when
+     * it acknowledges the error.
      */
     cpu_physical_memory_write(read_ack_register_addr,
         &read_ack_register, sizeof(uint64_t));


Thanks,
Mauro

