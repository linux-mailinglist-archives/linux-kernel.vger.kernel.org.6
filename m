Return-Path: <linux-kernel+bounces-534359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A0A46651
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F402A425EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D6921D58C;
	Wed, 26 Feb 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj7UdVGI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94221CA1A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585353; cv=none; b=epfvHIWumiOBIKEMCFm4rlZT/YLiBx9YRvgf5Ff5KnBM2Jfjx9Wg7FVNod4LRRhrK0vdeuJJ9jFqZKLokfOhd3U9qILD19gaxHmB6HKMw1bCTEQcQtzAgUFX0OsRUYanv08oi1GwJpSFyzWnLCGXN5QSzRZjH8V4z19CBq+ohA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585353; c=relaxed/simple;
	bh=2V2GATVQJcPkGjF/duSvrvUcmkbPPn2Zf8HokeRm1VE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qz5xmOYhJ7nZ81qidWriSdxKJbcOYdS6eqitGtkgljDagW3dfMaC6FYTiX6ulH//ROVwHYL/omwqdA4V2eGhVulOKFe+Sl6F6HEYxtORRzAYZcpvfpEY5vCuFGpORVyl5odoN7pzGt/xOMBQXMTfGN4LqNsNePDVfgJjNWlZFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj7UdVGI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740585350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8CqY4o0DPQo+Y928L9zA4t9/2HrPF7Rgytn7kgXlYc=;
	b=Bj7UdVGIgY18SvqR/Il12ecs9gqQwrDoWzwyB0QZHcCb2DT0prD+gbCvfZd2zw+egp823J
	JxrOvNrXuoNIQggsyV7QJTBbwITO5A3zkSmDKtKAVgYJCBjNCfEG6tOA/PiC2Cv1bKJkf6
	+bEE6qKpDbv0eSsvCFRGE5MAwlIUT5o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-bYfCjx7XPCeU8lfQruPBjA-1; Wed, 26 Feb 2025 10:55:49 -0500
X-MC-Unique: bYfCjx7XPCeU8lfQruPBjA-1
X-Mimecast-MFC-AGG-ID: bYfCjx7XPCeU8lfQruPBjA_1740585348
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43998ec3733so35546435e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585348; x=1741190148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8CqY4o0DPQo+Y928L9zA4t9/2HrPF7Rgytn7kgXlYc=;
        b=CdpJeswFLehy3Z59hVZakQ/MI0vuGaHT+Vj64Zk3fH94MvB1SmNTUT4AqUWjqAboWW
         pcJN4G+PXuGiKuWZDvnaawd2gqFrxQQ/b5PpcyEwhXw7BflSS62FaHVGvzMG8VEnI9w1
         ROUH2ZTywUdle3XBhbkiOMzi2wvIazvwoF/VnNQwaowJAVcUGEP4r/t1OFDZ/44VQ6Zg
         sD//ee0tLZNT/y41k6wxQKuR/Kb/GERmaXKuZP1i+2DLF+NrlB/RHk1b4gG2Ll93OXDB
         YOxszBNuwowiSKmOYoCjEZbFuFVDRXdTGINXJhB1IPSb4wmGILZUFVU/em6HhajTQoUg
         WBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6+wiMSqT61Poa8lrjGXgnPnqyp7Fxa694XXU6zxb4MJ9uUIFC5Jqg31Diz/GD+D+AFLtNel8+eQSg4zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE/19QlSQPsTllSAF87GeVujTvgSbhJGIPSN0+Kuv+46bqYrHb
	NFMpQpFLuch78QYj7uCAKjgF5Ni1HO5WiMImcmKHV5cC5F1nucCMnaOOwj3rI+G7mJohQO8ATvi
	uvdEEF2gkcEzqj8uMBCJWvi7PCIIfIKpDZS+Qfyozvz47UMk4t3YyrcIsrE5RBQ==
X-Gm-Gg: ASbGncth4FbBNnjV2y3WTPY+7vobc9hxkc2koxjVlppI+iZGYXCsMRwEhuyVmRSgVXM
	en0is7WLp+1KvYyvz8176clFRDBD42c9oeY+7l8DSU9DCorOpvi6JajfAZ4QEZ5SwRKH9xGhQkI
	7p/DtgSa24R2+nk8KKFyJcvJUlfg3ROcbK0D5Ge3deiZJ8XslDYVT4ahtnOgELjzUj4Batmf0dK
	LuFbq37Lzb0Og3HfzAAzxyDAc0xo51U2jYbb2hX2YEARxogNgdOrJX14cVeByu2wFSuNoOtkAp9
	dDNKu+4092O4+DUCTatWbDvBAnTXK/szJ/vX9MvxlbysbtDw2m1mzHSxb4kiO60=
X-Received: by 2002:a05:6000:18ad:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-390cc6475ddmr6949959f8f.54.1740585348082;
        Wed, 26 Feb 2025 07:55:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyuJQRaFb4583I4taVqxsuF1Qw2F0ZkJcIPI2a6MwWctYzyb+OQVaF4zA3fJ8tVybL/MtDRQ==
X-Received: by 2002:a05:6000:18ad:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-390cc6475ddmr6949942f8f.54.1740585347741;
        Wed, 26 Feb 2025 07:55:47 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e1040844sm110155f8f.85.2025.02.26.07.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:55:47 -0800 (PST)
Date: Wed, 26 Feb 2025 16:55:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/14] tests/acpi: virt: allow acpi table changes for
 a new table: HEST
Message-ID: <20250226165546.3b1ded0b@imammedo.users.ipa.redhat.com>
In-Reply-To: <94ff7f7ccde4c8d74c7838c0021cbb453e91f12a.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<94ff7f7ccde4c8d74c7838c0021cbb453e91f12a.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:35:19 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The DSDT table will also be affected by such change.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8bf4..1a4c2277bd5a 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/DSDT",
this and flowing update would also include HEST table, once you enable 'ras' in tests



