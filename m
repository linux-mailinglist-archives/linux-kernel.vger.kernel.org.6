Return-Path: <linux-kernel+bounces-349148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB7298F1C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06133B2271A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315AF19C57F;
	Thu,  3 Oct 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQHf3Smh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFCD19993F
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966810; cv=none; b=uAkD/ntrG+kQI9ZAFrwL0Tr7N4MRXoiSkOU9hPqYtaAUhPao4+pkD1bqNyRArptvlFIetASd+NfbdDtyTZ0EdvbdLdtXZuJtBu78+t1EUypHRQAZ+Iw0nk5f5vuAAzC3/2aYd4b8GvmaTrl2bW6UeQsmKrGPKHrEzAAhRluK6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966810; c=relaxed/simple;
	bh=MsMu/Eu0sgD39bsCHZ0Z1TZ1GNoqeeCs1Ucl7X27XXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Os44mlzjjjNCEQpwuG/ijZBOsTp5BFyIKV21FHEiDGgl4EZWoBTl0tcHUZ4aOD9Lx1bQTuP2QKQpV4Ld8icGip1K4EeznL/FCSkdQqYx8SGOtfTF/QKroEawaKqdq8JB6mv3JD6WpowUfErpe/MhTTyGniClQ1zTRh8SaTDPLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQHf3Smh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727966807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ecke0VAUjbY2qs/OU5TI2Vftyi8DYGdyyeDK1FIBoPU=;
	b=bQHf3Smh7QU8nhY0grBAmevr6CK4h3V+m9bYqaJFffOJgdg/TcqlNUA1zbq6OWF1U/DDDQ
	QwtMV3KBB+UUS8LNNhuXMb1dRkAspG0UId8hpCDcs1ZreWgjWlOHmYt7AFMmtk9w1D/b9e
	dN1ujksK5MyrV3sn/slLQYfAiEtljvI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-YWHg1BdbNhWp4AvUbnW_Zw-1; Thu, 03 Oct 2024 10:46:44 -0400
X-MC-Unique: YWHg1BdbNhWp4AvUbnW_Zw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37ce14d621aso559260f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 07:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727966803; x=1728571603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecke0VAUjbY2qs/OU5TI2Vftyi8DYGdyyeDK1FIBoPU=;
        b=wNlK19lWlmL+9xl2E/TWMFI0BU1dNSaWWAISs6YXPvjYVlz8cX+1Oi8BCTDg55GMmt
         yjU5cVJJPKoRqNTPsv28I8dQovfqFENol+P4ePAl3KrsEvXUwJ2kgey16PHdQaPKgJ5O
         iwVUG7HB+Vr3yCevRQQkmr+nI08PIyn0oPjtb3DE0P77heSdSgAt4lIKzgzFv/aO74Sk
         zp9OE5fpI50nsttGzHGr1MpNbn1u6KxekmTGNXKq/KNzatAiuTv9KA7/3yyqQ76LGRI5
         m6QDILURPuP6BEdINrsewdLM0xkWdzxbrEzyjGXnzq/e8DaYomCEvm5mcvEQKUMM5xSQ
         yPyA==
X-Forwarded-Encrypted: i=1; AJvYcCW1zdEjgvj4p0yE+jln4tBYJK3ej+bsjwhLdF1kUl5Q4o5Zeyusg1c/IBIqxOV4RehXE05Gztb6GZsvBVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7D1AlarSe8U4sp7q+WDBTHgN9QNb/YNODVAY2fHPmMKzuV3h
	ZD6IfkM+ycIvo5UKExdg5Ie+xA+cp8w6ypCgJjtJp8hS38XcCw+jcdj+GUYaxIdwfr2Oi+CoYhs
	1nHRprtSlf2PBm4vbcB1O5hxqMVepqh8AdkFVB2+ya16MmQ1R9qS5PsiaUOEeeQ==
X-Received: by 2002:adf:f34f:0:b0:37c:d200:4fea with SMTP id ffacd0b85a97d-37cfb9d1efdmr4040750f8f.34.1727966803418;
        Thu, 03 Oct 2024 07:46:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb8ArqDAhHc3fjm09LTdhgfEQWhxfi2zK/99j6Ugl5pfcjb3RFuJs9QcFnDuRgQPhv30R5Aw==
X-Received: by 2002:adf:f34f:0:b0:37c:d200:4fea with SMTP id ffacd0b85a97d-37cfb9d1efdmr4040738f8f.34.1727966802988;
        Thu, 03 Oct 2024 07:46:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0823ed00sm1414702f8f.49.2024.10.03.07.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 07:46:42 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:46:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 5/5] arm/virt-acpi-build: Properly handle virt-9.1
Message-ID: <20241003164641.76e5bffe@imammedo.users.ipa.redhat.com>
In-Reply-To: <2b5b4e57eb5332c83789d4bd0f01214861cc7f0a.1727782588.git.mchehab+huawei@kernel.org>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
	<2b5b4e57eb5332c83789d4bd0f01214861cc7f0a.1727782588.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 13:42:50 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> A virt-9.1 machine can have only one source ID.

and here it is.
I'd just merge this into previous patch

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/arm/virt-acpi-build.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 476c365851c4..8036eb5953d0 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -894,6 +894,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
>      {ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA},
>  };
>  
> +static const AcpiNotificationSourceId hest_ghes_notify_9_1[] = {
> +    {ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO},
> +};
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -947,10 +951,28 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> -                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
> -                        vms->oem_id, vms->oem_table_id);
> +        AcpiGhesState *ags;
> +        AcpiGedState *acpi_ged_state;
> +
> +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +        if (acpi_ged_state) {
> +            ags = &acpi_ged_state->ghes_state;
> +
> +            acpi_add_table(table_offsets, tables_blob);
> +
> +            if (!ags->hest_lookup) {
> +                acpi_build_hest(tables_blob, tables->hardware_errors,
> +                                tables->linker, hest_ghes_notify_9_1,
> +                                ARRAY_SIZE(hest_ghes_notify_9_1),
> +                                vms->oem_id, vms->oem_table_id);
> +            } else {
> +                acpi_build_hest(tables_blob, tables->hardware_errors,
> +                                tables->linker, hest_ghes_notify,
> +                                ARRAY_SIZE(hest_ghes_notify),
> +                                vms->oem_id, vms->oem_table_id);
> +            }
> +        }
>      }
>  
>      if (ms->numa_state->num_nodes > 0) {


