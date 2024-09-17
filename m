Return-Path: <linux-kernel+bounces-331680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6760297AFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A73B285D32
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8E15854D;
	Tue, 17 Sep 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOtnZhO9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1B136357
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574651; cv=none; b=ejQvql3OxC8OUzPrg1VK4TAK/kByj4/kicTC3gm3wgU7D7DkKV2XEmQf/TLB2ZmR4mOHQj+zKsAsY9YJHvtgT1JnEv0CTLI/8FOtZB69mcSrA0XonH6Lsfl/9I6ER4L0iJSDiEON+reokIz3lHmQkR2To//dq2zu33S7ohUbPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574651; c=relaxed/simple;
	bh=V6gMa2HXhlhBWoNLdCf7/dpiJaYRDfLtYpb04TFTHOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlkBwujYUHKWmJqCgLbYQsHox5vy7yzjc4X4OJbqrE6/NPFt9FKtEKTKxViH77K3Xqrehv0yF44pSMwzUlnKD9AhGts73SR4ufDFW958drL1oPB87pACHN7o4ginFjvDG4xX94UYaHF/e+Zq6ogfCHRw51YfBtgf0ZVq4duuy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOtnZhO9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726574648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3mPRoAn/jcSQbMphwkl3dfQdA1X6c4zq+Qf8pQUnQ4=;
	b=hOtnZhO9xzTw1uMbLpr3QGMV3SdF+cTjlDyRDP0yCJFs+v9ij9+trlsjrtkFiY5QEJB0e7
	giOlBC2FtmFnIjFjPNdW6JvPl5JvuHUUiXUfmrrzg6ePyOS+CykNe1+C3e+h3RuNL+wMtU
	t0+9HiK+YqNREZans7XU6WcZwICX7XU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-tWGn0yeaNKiOqHRzrHoyBw-1; Tue, 17 Sep 2024 08:04:07 -0400
X-MC-Unique: tWGn0yeaNKiOqHRzrHoyBw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-378ab5b74e1so1624988f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726574646; x=1727179446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3mPRoAn/jcSQbMphwkl3dfQdA1X6c4zq+Qf8pQUnQ4=;
        b=nmYZJ1XkkqyZnc7mlS2qUF66DWog9GMHuSEim64e0EdhMBUK2euRCci24bGR9u0xXT
         d7x+S/s+Qo4JD/6gWihIVYhXUAOR3/lG2xbOrZAJucXEA/4HqxOKIVG5muGj20I2xhNo
         QoCbmbCLOp3SY5XvciQ331Yjri1GPW/PZOm6+rRgbUm92haeCqWs+rh/Q8JTMEuO6kDg
         AGsIE/o2xgPr1CJkJsSg01LHX+UHaj+62movAXVVDahrC8IsMIwBq/hATY8eGoNPC9Ha
         5JCPIVcz2frOAthu84VN9bsXMuuyYrL2TRnhTsaSccoagQd1T2u2DUL9tvkfYYRlmXXW
         GhPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc9xDuthZcsQ3AFaWK0SAYZshHvA2UViWq+3pURZ0oneso6MFKr2RhvAfs8tjzZRFRWRVf9CUtbYU1r0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzor+UfNCiQN53aNmKogN92tMIbe8ugAneEWzHlvGeunfzR6t6O
	oDUIAUICQT77SRmJqgQKGShmOYt+VIPr/s2fYnGt4SC93RczhGriOS/VofR8+uoqmxkRtNNzxsa
	avTwmBIX0naqK3nrvToNAl3h0gSvu+M7iPecSeeBNUC/Gr/ex5om4Kc0fICBaxQ==
X-Received: by 2002:a05:6000:1faf:b0:367:991d:8b76 with SMTP id ffacd0b85a97d-378d61e28b7mr10430321f8f.15.1726574646019;
        Tue, 17 Sep 2024 05:04:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQjzt44DVLX1iIp0pGOcq8zBmTwnTihJV9Tfiak19XPUOl6reWHzGMTPFZdrHRqw2ufjXv2Q==
X-Received: by 2002:a05:6000:1faf:b0:367:991d:8b76 with SMTP id ffacd0b85a97d-378d61e28b7mr10430292f8f.15.1726574645510;
        Tue, 17 Sep 2024 05:04:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22d7e2esm100741425e9.13.2024.09.17.05.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 05:04:04 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:04:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 08/21] acpi/ghes: Change the type for source_id
Message-ID: <20240917140404.306fb514@imammedo.users.ipa.redhat.com>
In-Reply-To: <64de87ae9e03e9be6cb98dc75e2eb02503354904.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
	<64de87ae9e03e9be6cb98dc75e2eb02503354904.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 08:13:29 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> HEST source ID is actually a 16-bit value. Yet, make it a little
> bit more generic using just an integer type.

wouldn't uint16_t be better to use, to explicitly show expectations?


> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes-stub.c    | 2 +-
>  hw/acpi/ghes.c         | 2 +-
>  include/hw/acpi/ghes.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index c315de1802d6..58a04e935142 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
>  {
>      return -1;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 6e5f0e8cf0c9..4e34b16a6ca9 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -416,7 +416,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
>  {
>      uint64_t hest_read_ack_start_addr, read_ack_start_addr;
>      uint64_t hest_addr, cper_addr, err_source_struct;
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 7485f54c28f2..6471934d7775 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -75,7 +75,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(uint8_t source_id,
> +int acpi_ghes_record_errors(int source_id,
>                              uint64_t error_physical_addr);
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);


