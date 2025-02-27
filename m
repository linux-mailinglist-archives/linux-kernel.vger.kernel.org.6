Return-Path: <linux-kernel+bounces-536209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91085A47CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD627A4255
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F884B5AE;
	Thu, 27 Feb 2025 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRcioiBa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8B270020
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657824; cv=none; b=PHEpwaPz3UfTQ7AOkC0eiI20khlxUe9dQJou+PpnYEDB9jZlutc/OAqQOYAUPuUuaUdijME4M4k/tkUw8vm7OfQ3r+zUxTn2wv5cBtlC8SDSh+49HatomyGnSPw+xBsT2SG7X/FHKaLQzMZ+qkYHHxdBXUCB0/nBZTEbDqvmzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657824; c=relaxed/simple;
	bh=0JcGUGWv/7VPrsNOKRs5pmneC4ffhJsXc+GlzSN6K8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjjHEuw8pJVnyXHL7oksb1/Ql8CZdn2jeW/w3N7t9nVUlugC9DC5mNNyR6x0JuBHjKR3m2zNLvfogMH76wbE2n0X6+r18Vkivt1OI2sGSXhhFhs7tWJFKXexFI9e67bCH6uuovyluBw+IJyw+QFGhVedcZSXBox44mrPdYI3ozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRcioiBa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740657821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3IIRWTfz/eEhKgTnFWptplWM8F1KHYcG7w57dEy7Ao=;
	b=ZRcioiBaQb/3Mbs3rZwi36BozewxVjqS50MmvC5myrZLP3rcW26Ufou5p1D+2vwGdScDYf
	dcBT2bF9jODEenga6poZVI1qcl77tgV17xr7wq9OGHslpO7EbfEQHhNksjXbiyCCbnzEQM
	LlimMZ0IynggVB5XF5EC4Cl2fkjXIxU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-xCn70UYKPl-R4UTTBE-O2A-1; Thu, 27 Feb 2025 07:03:40 -0500
X-MC-Unique: xCn70UYKPl-R4UTTBE-O2A-1
X-Mimecast-MFC-AGG-ID: xCn70UYKPl-R4UTTBE-O2A_1740657819
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390e27150dbso651741f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740657819; x=1741262619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3IIRWTfz/eEhKgTnFWptplWM8F1KHYcG7w57dEy7Ao=;
        b=OZxYRNMHLLpnrIUF/xUnaxi+MXj4ubni46l5K/ooPViKsWT3oBAE9iBzWh1KSGFr2s
         v+18MYuKsfA3X5vXMLhAYxjrtd727AiEevLWEAjEMGP97Lv493IDULI+ADvGUMHTJuhg
         b5hwwXH6h72q5lb24WZfLARz2DlSkvuwcJahMCBEtB2BWwNZrhRIuHH7DH1x2S2sXRL7
         m9kLBvc+TuFx1HXPp7+zqKMe/kchUB/ht19gVIgkjsT4idsOTXkKy0YCYQoulhs9qjJO
         xHZ8SHd54Hnm7QtWrH581GQZUpA5MesKYhbQQtYNX5WNDQSrePqUKVpQ9FjArO47Dset
         yeIg==
X-Forwarded-Encrypted: i=1; AJvYcCV1C2n0y1RMlm6rq5bp+PZJf8BleNrC+Y0+i4hNWfup/YhaCNN8bY/ZiDtUtyNxYcPbyDspL5tSm/4NXpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbpJja3vaLSDzfyNua+54ZHrDjI9/7qov0XAWrzyQTa/wmCTO/
	STwUvOaHi8IDAlVMXMvME6lj8BQmkPBKt+YjKAM+ndvri/La4ueprJBS7V3fh3SXtEsaCaSM8FN
	CgP6DX42x7+Nldw+OYt4Rghms8rs2RK4UZbXV8cVnRr5RvQ2Lo+mQcHQaC97EHA==
X-Gm-Gg: ASbGnctQpN1KfHMRLVZ97aadcITjvLTicqQax94rTSKMlOtXrxKXWnDJQvuacSoNqj7
	DekWmIgw+S3HfcaHOiWzKfcnEU9tD0j1oGeou1/GejtqCmRZhCWV32XtXoi4DvOsJdHhNV2nk0V
	cIVIvhBdYK4zIXz1RBfko3SL7+TTox5ECMY/TTznhkwQtX6+e3eGw31Tvpy8rOpCCPyuTwtpJIY
	xth1hMuAz93M8xKRl4wXp8xo558wwPu9xp8zMYC1kJpgwwahQnMGqWc5ftxkpqN8lfrD0eH66Tn
	B0zd1+nWljfw3Xgl7niDIW+ZCGQZ+PkWb0KT8ZrwQ51tzlrQeN0PjvqE6OQ+Efg=
X-Received: by 2002:a05:6000:18a5:b0:390:de58:d7fe with SMTP id ffacd0b85a97d-390de58dbc6mr4083582f8f.51.1740657818812;
        Thu, 27 Feb 2025 04:03:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIvLiWh2tdVmP6HZrr7TBnk071x+cG1W0d6K0NLkz3NzaVfzLf567WwsMpcijntSKKBlKQ5A==
X-Received: by 2002:a05:6000:18a5:b0:390:de58:d7fe with SMTP id ffacd0b85a97d-390de58dbc6mr4083544f8f.51.1740657818495;
        Thu, 27 Feb 2025 04:03:38 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d906sm1828794f8f.90.2025.02.27.04.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:03:38 -0800 (PST)
Date: Thu, 27 Feb 2025 13:03:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/21] tests/acpi: virt: update HEST file with its
 current data
Message-ID: <20250227130337.31f2a285@imammedo.users.ipa.redhat.com>
In-Reply-To: <5bb163b260d6a29b082d12cbae31035fa68342df.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<5bb163b260d6a29b082d12cbae31035fa68342df.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 12:03:33 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that HEST table is checked for aarch64, add the current
> firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/data/acpi/aarch64/virt/HEST           | Bin 0 -> 132 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4c5d8c5b5da5b3241f93cd0839e94272bf6b1486 100644
> GIT binary patch
> literal 132
> zcmeZp4Gw8xU|?W;<mB({5v<@85#X$#prF9Wz`y`vgJ=-uVqjqS|DS;o#%Ew*U|?_n
> dk++-~7#J8hWI!Yi09DHYRr~Kh1c1x}0RY>66afGL
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 39901c58d647..dfb8523c8bf4 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/HEST",


