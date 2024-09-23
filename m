Return-Path: <linux-kernel+bounces-331676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D6697AFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95007285DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EC515854D;
	Tue, 17 Sep 2024 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Umo9UTov"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2161803E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574512; cv=none; b=t9hlUaAnYy0/1LTmNzsldXtCY3ISiRqmdgQS162QNxREOE/9ardEUEU+ByCVGlF9ckm5UXnQWQurQTONBcyS/FebdEIAP13ZfHTel8GZyAxXwZAebHE87+ZAM7RBMkwGjHpGDK+3PkQI6R5I7+yFCcrYrBNeKH02+wgm/Hx6/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574512; c=relaxed/simple;
	bh=zolbVNnpMIk0SSKpAI04LmsJEtj8eHEWx+2AJucWdfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3phuLaYj67xmo8p4ZChkQUHf7H4bKQzypfwiq7fH+AgBJeABNEcBfBJVHP1ylV+Qn3xU7qVvQE3aMCBYONXNAed6Jgg67/PlKF4CxE2Ovvi8XZrfL12cO8AWECw4CJMdxgbJTI1+lW4mygkJWJ2X4R1NXk1clo0DI98RiMFYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Umo9UTov; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726574510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HzhMxnLNe3jV8pAQOQDyx0mfb5RIW+kELp9fCFj67Q=;
	b=Umo9UTovRP3a690qwWHBK3QsO1pWzFqYh8hxFm38LBV39jLwD7J24pl089OXwqNa2bnZyS
	QzrBAoUD89poGga9QpCf4nPizti2MFmos110sxFLFZv7F0OHbU51CDKteU8GK73IP3A/YJ
	WfNW3Y2tw60KVmf/yeOkp0FMS3Rrh0U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Lpe6MlqnNDG4A1UhGD3e6A-1; Tue, 17 Sep 2024 08:01:49 -0400
X-MC-Unique: Lpe6MlqnNDG4A1UhGD3e6A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374cd315c68so1959824f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726574508; x=1727179308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HzhMxnLNe3jV8pAQOQDyx0mfb5RIW+kELp9fCFj67Q=;
        b=lBb737VSYp4aUpnpfkKRDhxmBjvNMjuDaxbBZIw6fnBKIhxd0WajEG8h2viY2cpbtp
         0GO6NkeuJbV+APzvzlFkpzADjru09Q10KXMF2JC9uWscIXyQaUY3zzVv/gJFgCNzJxhi
         T0UIF/ery7Lo7MSJoSeT9siXc3thJqkoNRHS9v8QUOpcUZy5TcCFaDc5DW+Z2AKBthPi
         hIVVgUaDSMnpK/UxUwLujnfwUoho0CSU0lc00LgA0k/0idWF0PWkPbUXZ5LlhF24XIZT
         J9Czyesz4YgV4In2D6KD30eSoYWR/kSwCZATp7aSwJtgpxmknJQ/2s6UucL8TXOhDoYw
         Lj8g==
X-Forwarded-Encrypted: i=1; AJvYcCW76t/LJ7uVEMLjthn+d2J42EZrkGrewlkan1CqUsxJJYDcPp7annJpeEkhl5GU5sr7TK4gV5SaC96gb7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJau9MTtd2bTuKuTrYb1B7gJnxYHDdrlk7lcnJHh0j8U2JdFW4
	trG+cyscZakY/LOBbAu6L4LAWaq6LOTdnju5644HXJinUVnGU0UKTje+OnFnDEpP2JnTtxWHQ5D
	hCVyFNXts8t1tMn6IKY6rG+oYMjZ7DnWB0/QmJDqlMvx7xfo3JQStFz7GLMXHCA==
X-Received: by 2002:adf:facb:0:b0:374:babf:ac4d with SMTP id ffacd0b85a97d-378d625360bmr7023028f8f.58.1726574507871;
        Tue, 17 Sep 2024 05:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi0v4jdOWNkzYoSWoRO+8xe9tG/92/3wCyKj+zNE83KRvnVAbqziGM7mF21MWO04u1FDwVYA==
X-Received: by 2002:adf:facb:0:b0:374:babf:ac4d with SMTP id ffacd0b85a97d-378d625360bmr7023012f8f.58.1726574507371;
        Tue, 17 Sep 2024 05:01:47 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800237sm9377230f8f.83.2024.09.17.05.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 05:01:46 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:01:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 02/21] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <20240917140146.56c9d581@imammedo.users.ipa.redhat.com>
In-Reply-To: <bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
	<bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 08:13:23 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES migration logic at GED should now support HEST table
> location too.
> 
> Increase migration version and change needed to check for both
> ghes_addr_le and hest_addr_le.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/generic_event_device.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf24..4e5e387ee2df 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -343,10 +343,11 @@ static const VMStateDescription vmstate_ged_state = {
>  
>  static const VMStateDescription vmstate_ghes = {
>      .name = "acpi-ghes",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -354,13 +355,13 @@ static const VMStateDescription vmstate_ghes = {
>  static bool ghes_needed(void *opaque)
>  {
>      AcpiGedState *s = opaque;
> -    return s->ghes_state.ghes_addr_le;
                            ^^^^^^^^^^^^
another thing, perhaps we should rename it to 'hardware_errors_addr'
to make it less confusing 

> +    return s->ghes_state.ghes_addr_le && s->ghes_state.hest_addr_le;
>  }
>  
>  static const VMStateDescription vmstate_ghes_state = {
>      .name = "acpi-ged/ghes",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .needed = ghes_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,


