Return-Path: <linux-kernel+bounces-538549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F09A49A19
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759553B3CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD5126B2DD;
	Fri, 28 Feb 2025 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+T58mQr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE926B2C8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747594; cv=none; b=nN4ye91xajd31iHaHAOr0z9g2W4PHVqkfFA3D3zUiPQolQS5LXAqdlvNKsC9ecdlbCFHijM+P52XDqM4p+g6KYagvRD7JGQB3TZwtx/1SI405Cd8ihLHl5pbjyRyWVScnZyCul5qyqwF2ZHR7pLQygdKx7IJFAkB9DfmDMB1KD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747594; c=relaxed/simple;
	bh=3DKT7J+swXfr3LZY9NRwOLeY8J+OdBEFnuOEu3W8oWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiuDGVxwgcfbxKnAn+LkHVGN/G80YOCx45RHSW9XcpJSlr1suYVSAQ8LHZJRV7n8iEVnIp0rCHLLe15+NJ2szQh33/iOmZUvb3UA5kHhyroKikbm344Pbq49jd3LTveKnMh944mYckroE+5Zg7VDguGwvsWM1pQ0LYjXyBrgsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+T58mQr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740747591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c83XVy6ozclMfOWx6ksvJRIp+J3X+fmuC/ka4FyOnOE=;
	b=J+T58mQrISVMClWI3vv6AVTayFUYLEBJw0lNDups01s0gKdNI+sEu0rs57FAziioPU2KCA
	mcTf7TEYSVj3vcwcE6JuUobmhQ/BOEj4EcwZN7NWzBXNvBMhCyuI/WiLQ6/bA2fVvdW8HC
	jsqF2mjg+2qP/dzNT3tKk5R1u41sCX4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-z26nYuikNSCUuFbJSxSxpA-1; Fri, 28 Feb 2025 07:59:50 -0500
X-MC-Unique: z26nYuikNSCUuFbJSxSxpA-1
X-Mimecast-MFC-AGG-ID: z26nYuikNSCUuFbJSxSxpA_1740747589
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390f000e962so308990f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747589; x=1741352389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c83XVy6ozclMfOWx6ksvJRIp+J3X+fmuC/ka4FyOnOE=;
        b=kd14o3z4ZyrnKZDkGGvF5zPY/OwxbiH7pOXw+26X8Pbpy1+9tnjXazSDjYKo8I1VVj
         W5CZxkmkTlHQZ6xYIa9+EfIuYdUA328BNxGxvSHC0mv65an9/WKBjh9mbLDq3X0E4GJZ
         LFibfT/U9kr2v/1Fd1ExaNsNperccietPvf9hK7MKqoPT1NBKiA1c9GVpxVO0/zfhv9C
         mg0tcAtKZrGAeJA7fOJF3yPCUoTu4WuOklaeckoDCBDR+MkO/zU+ll7oM82JvYVGNufX
         IyKEWrcapHrw+7eNg6U8IFPFcE5mN11oV3JvZCRSyzVnxy6+Jz2w8bVYAsVMnDbVFDXs
         RLIg==
X-Forwarded-Encrypted: i=1; AJvYcCWUKpnSP8u1o+rgS8iT1LJ7Y6+X3tghQhwsCHFgRqaE5H2ZCuzaucppJOmcqVDGzad2XbDdIvyWIx6UTTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/X296WpIlqi652jS8NWT0XRAzaxbEnS0ta8Ix2amlG8bQfVn
	/pEuVwZAVfsmTBSOEzD5qnlN7WGg5ucPutIrIZUqs+S//C5cy22BjiTs2PMqSOpGA3xibNqB3np
	WrPBmWmO2IX6dHPWUrqhUbX1fMh3DfK62Z8hIxfbA3wiUVCrrrS6xi2yq5wAHGg==
X-Gm-Gg: ASbGncsrHWprtJgQN5Ou9P2LR+miDMIxu4T/PqQTNjMu0jkQVcrJJmUQKLd41V/b8g1
	aXp9BAvTUgtwwGcVAwJM+Ab5PWSgPNcsStCPS1aoIoAczI7gLEtQG9YRSHIIf2I1j9/DOWSHhEP
	kxk1AkYfixkUFKPPmZ3mJA6MWXvNEVongOa17EPpJvwHi3HlbtPPYfvAVcMam6nhqJeBtQxKVDq
	0vF3sw3icN5SzSXvyXK/viB4SMZyWoEgRVRvh7L+kW0kmjQe0GpEkxltMWhG52FnXgnaI2PL5Kw
	SGVCHGl8GMqhoXXIkkzBOJLcd17kgKcDA1T9K5MRmMmESDyRLRBJoaZWItqupKY=
X-Received: by 2002:a05:6000:1f8b:b0:38d:e092:3ced with SMTP id ffacd0b85a97d-390ec7c6c4amr2643359f8f.7.1740747588684;
        Fri, 28 Feb 2025 04:59:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF39024ECeki2qeJ7m1bCe/xYOH62Iyh1CEl4EZF/iAAejb6b6Z9XQvhcS5PKHFcbRdN7SHDw==
X-Received: by 2002:a05:6000:1f8b:b0:38d:e092:3ced with SMTP id ffacd0b85a97d-390ec7c6c4amr2643343f8f.7.1740747588359;
        Fri, 28 Feb 2025 04:59:48 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6739sm5110782f8f.22.2025.02.28.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:59:47 -0800 (PST)
Date: Fri, 28 Feb 2025 13:59:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 16/19] acpi/generic_event_device.c: enable
 use_hest_addr for QEMU 10.x
Message-ID: <20250228135947.15504734@imammedo.users.ipa.redhat.com>
In-Reply-To: <797c0199ef713241db145baf3860d32e0eb1d03a.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
	<797c0199ef713241db145baf3860d32e0eb1d03a.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 17:00:54 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that we have everything in place, enable using HEST GPA
> instead of etc/hardware_errors GPA.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/generic_event_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index f029753ab709..9fe70b74bd42 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -332,7 +332,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  static const Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
>      DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
> -                     ghes_state.use_hest_addr, false),
> +                     ghes_state.use_hest_addr, true),
>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {


