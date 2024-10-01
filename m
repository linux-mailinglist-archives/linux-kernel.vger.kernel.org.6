Return-Path: <linux-kernel+bounces-345629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2595B98B857
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD651C22C84
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A452B19DFB3;
	Tue,  1 Oct 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyM34THt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942819D8BB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775010; cv=none; b=TxuwxHQetKJvJXOtJIMtLOWKAHPuL98r7hE4gnOBR+C9IL6MaL2iSI0fFpPGSAWaPkThQyklJIZsjk2++kcDHj8do3q0JgbUDkKHhGPPmBgLFn6cjGnXzucebc/XhqZ+AItrInkgRKQhc7ALshcRxUvKnAbm1xLTABUAtGqZxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775010; c=relaxed/simple;
	bh=zUdt3Y3iP7rYP0vvrA+vU/N/qU+YuF1X1kDjHOS4VYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqUfh0xKj/cQb95L+redBGmPdOCJIQMr+/qj+uUsGaycBXMSfl92ZOeF22j4u84QNcxMiH4VNmgqh8jScRkHP1Qg4Rnj7T0hyxHtOpTtxn6f40QjXfg4QIXeOnIxCZdmVrdIzr6iI6sSjpZrBTLu1CCteSyO0bRLyTBWKMuILjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyM34THt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727775007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+x1a+GyDQ15EY7q1rmBJO7Brfiu2xmcThN9CzntVvKw=;
	b=fyM34THt/wYrCB8S6qCxF4WawDAcnS7tZLmyuJ2l7sHqVnyHIIqf2/m+szRFHdA1sneKI1
	yHgNHU0ONkEEzKFUE3kgs6kcjUy5X47VDtPi0eWhSHl5tYFyeei3mmivXnYgrtjS5WY9Jz
	Q1UDxoiv2qve/GpNrPcVYdfiLRt4PsI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-rYq53KhzNQqVLYTB5SirIA-1; Tue, 01 Oct 2024 05:30:06 -0400
X-MC-Unique: rYq53KhzNQqVLYTB5SirIA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb33e6299so40533245e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727775005; x=1728379805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+x1a+GyDQ15EY7q1rmBJO7Brfiu2xmcThN9CzntVvKw=;
        b=HwgbpBO3KS2RflDEp+lZ3msPCg3wyvpOC9PIk6BBRxoEUS4MS60n55tpW7seFVbaVy
         fwpb3SINsOjqDVLHx7N/TW5bq/VjvPqc2yDebyP/JHScRBsmg1oIbGYcnZwSepwi9Ekz
         MHFzkpQyM9ZQuc5oNtCMuUZDkusgrwfCP5Mc3rKu8595dJL9bYOe0mSIVuqgsOLwP800
         RUF/k/f/nUPDq1q6zSWuKfnIOXsFb01alQo5KOAJ9q3NMOZJIVjnLeI+DRPUfzbscB4O
         IYQHIqc6anlqdgHj8bJEwKIzCkXokv8uwmGXejGsF/7FD6pzPsZDrdWX/3O9pnChR2te
         NvJA==
X-Forwarded-Encrypted: i=1; AJvYcCVRJnMkbZN32Slzk/7Ncs1WcTCSbbxqPOs4lJp8TsKpnJG+gQ7aB/o4uSgG9CW/BWH/v8QRRN3wMKPLRWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPMqD/MbQDSYKiTEtyBUpIDw4NRcQnk/20cF27N36A2cZedSXS
	Zd9NgPoVqGxrHENpIhroJuv5Ej+B6mkr6+JrVNxJ2ESgLWzrLBVkTWiGcJ8lDgGVzYePVtgk15Q
	hxvgiErxUQvVQhJZulIAC0cXCmKru6B+T+4HYlc32QUYUHryCC44o/SB4tvDxag==
X-Received: by 2002:a5d:414e:0:b0:37c:d20e:37c with SMTP id ffacd0b85a97d-37cd5aec5dbmr8713047f8f.36.1727775005380;
        Tue, 01 Oct 2024 02:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwbiZsH84hyENEzuORxWsK74YrRF3pjgnznljoAbtEaBi2LBM3rD+RHdsw3d41YOD2xBg1Cg==
X-Received: by 2002:a5d:414e:0:b0:37c:d20e:37c with SMTP id ffacd0b85a97d-37cd5aec5dbmr8713027f8f.36.1727775004950;
        Tue, 01 Oct 2024 02:30:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e767sm11367738f8f.38.2024.10.01.02.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 02:30:04 -0700 (PDT)
Message-ID: <cbed8e5a-2dd4-400f-80e4-307d0cef8f70@redhat.com>
Date: Tue, 1 Oct 2024 11:30:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/35] bnxt_en: Reorganize kerneldoc parameter names
To: Julia Lawall <Julia.Lawall@inria.fr>,
 Michael Chan <michael.chan@broadcom.com>
Cc: kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-4-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240930112121.95324-4-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/30/24 13:20, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

As mentioned elsewhere, please split-up the series by sub-system and 
driver, it will make maintainers life easier,

Thanks!

Paolo


