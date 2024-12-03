Return-Path: <linux-kernel+bounces-429365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30339E1D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F90B2775B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5D31E410E;
	Tue,  3 Dec 2024 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1JzJicu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D41AA792
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226160; cv=none; b=G+hKcHI7SYq5QzOmkhArQYruTxI79M31QE3hERjHXSHPTgwRBTWcD/RdWYLC0K2Pwpuibz0EzSG4IXHngVVguL56TKOq1NmobZG1rUS6wH3p/ACiJ0sKVY5tkc9nofccFVNTyDnVu5VjCZSIRXQEpWek9q0Y3qA5wSIU9v20/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226160; c=relaxed/simple;
	bh=rJwIat1pXyYVHXx641rAzasCNWtG1HUaPJBKNiKEbrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFsPBla3NAdWK+e91jclGIDSUQPLSrafZQ7DLDMq72uKmXEqsb/iuT6c+UYgMB9BlyROKY6WbIwxrpKa133CuwMfFth2r9+0suYACv/kQBaM+8EsowVrwRo3aBElaan27loqAkP8L13vOJn/R2EA+h7XGrt/CMHaJIqp5zj/5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1JzJicu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733226157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdV+kCaE9Lyhdv1F9WhU4L/Nk8QckqLF6OR7JQI+70U=;
	b=Z1JzJicuq+iL0Gxekf/ye6Wg2CjGqPWs2L0GnC76E5wD1Dkw3vwyYsNMh8UXqYKvT2AAJf
	9hklnV99FLDA6pJJ+KF0tKrzvAkQ8jTJ7GPwQE6uz4sbitUhpemh+HFlDK5ngeMV2SUafC
	7THweWoQnHOzfIXjkJZiTg70wKa7+80=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-tZWZwjJqOSuen9RxcIKNqA-1; Tue, 03 Dec 2024 06:42:35 -0500
X-MC-Unique: tZWZwjJqOSuen9RxcIKNqA-1
X-Mimecast-MFC-AGG-ID: tZWZwjJqOSuen9RxcIKNqA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a0bf9914so39748265e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226154; x=1733830954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdV+kCaE9Lyhdv1F9WhU4L/Nk8QckqLF6OR7JQI+70U=;
        b=q082xEcF9CuSikQqjEzBsWPi/UHRZK4YmqY4aaUcINa+xEzWi79xmqS2berfpf4RmK
         UdQeun3h0Dfbh0WOdDBiXIJ6ZxCXIjdDCfbG15QOFWpyNRAb9QUEjNmCWaklpdm8UcMb
         ALxvqfYLnkmpXLSGAUg9ue3wFxHi/nrNHdvPEGUOtXuCs3AM3jovtZCZghK+LS4ydRUM
         feGKjrNHlf/M7/nffrhMAfbTig1aek2oSDgHjnzBZPFLM10UqwarQPECGAUXu58weBER
         PRQlLxEKGwfG78ZPjV6abQtdhiVS5aOf7ecX01Fj8/AkUODHeuCDHIhcbqGY0YMkbwcl
         31jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUDF5r+mNnq25H6IYEMj0oK8FqhkPiTQ+T3UxNMQTnVnNMQ8C6hTSBYKgE/OU1HnEl6+GizewcnFjz/5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqXJX6LcfmVDMpIomX7VFMINe1kVct+YdnFPwnXO57Y9a5m4C
	PutY++SFEsVv9sezFds0XXMcCzWL2abh3VCA4GeOuAtTh2p+TiE2jEynl4ZWaAq/a7/9GSAzla8
	6xSNOE69Y/Cf+NBqjTnUPAtiYUaR3oNJpjURGTlmFkT2ph8LM5GmsKgznhnaKpA==
X-Gm-Gg: ASbGncu38b5n7zPXgpkJZA26F8W2HYFKzut29IvINxMwUEMbGkwnqqT9KeK486iHQCz
	mih94UFXytjoyjdnJPmCxfAX4qOv0C82cFqza70dx8fHufhsrMglfXxqbaDIEXPm54HLSbg6tV5
	k+ecS1jMl0PSj3HmINp+TdiLWvLTnD9HH1dFuqbbpuB4/k3Zp3yJnnz+JMLXyIhdvmQuLFNGp/0
	NMBf4ug5RW6frKYrdSYVeayV0ikOazuB9C2EhFu9m4u3Ih7Ln0U7/wOdMa+EqJt1/JZ4CkbSsda
	hmWmCJ+xC0DBlPwk5fu/8Q==
X-Received: by 2002:a05:600c:4708:b0:434:a75b:5f6c with SMTP id 5b1f17b1804b1-434d09bf679mr21243035e9.10.1733226153855;
        Tue, 03 Dec 2024 03:42:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxNIMxmum8ZNVHTxSVk7U02XMS5k10BcA7udiCBF1F18eXmzrvQxBopFgxD6upbMlqusfpMA==
X-Received: by 2002:a05:600c:4708:b0:434:a75b:5f6c with SMTP id 5b1f17b1804b1-434d09bf679mr21242765e9.10.1733226153544;
        Tue, 03 Dec 2024 03:42:33 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dc9827sm185133725e9.26.2024.12.03.03.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:42:33 -0800 (PST)
Date: Tue, 3 Dec 2024 12:42:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241203124232.7948b2fb@imammedo.users.ipa.redhat.com>
In-Reply-To: <b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 10:11:25 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Split the code into separate functions to allow using the
> common CPER filling code by different error sources.
> 
> The generic code was moved to ghes_record_cper_errors(),
> and ghes_gen_err_data_uncorrectable_recoverable() now contains
> only a logic to fill the Generic Error Data part of the record,
> as described at:
> 
> 	ACPI 6.2: 18.3.2.7.1 Generic Error Data
> 
> The remaining code to generate a memory error now belongs to
> acpi_ghes_record_errors() function.
> 
> A further patch will give it a better name.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
[...]

> -    return ret;
> +    read_ack_register = cpu_to_le64(0);
> +    /*
> +     * Clear the Read Ack Register, OSPM will write it to 1 when
                                                 ^^^^^^^^^^^^^ typo?
> +     * it acknowledges this error.
> +     */
> +    cpu_physical_memory_write(read_ack_register_addr,
> +        &read_ack_register, sizeof(uint64_t));
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_addr, cper, len);
> +
> +    return;
> +}
[...]


