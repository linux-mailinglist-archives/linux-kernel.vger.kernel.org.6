Return-Path: <linux-kernel+bounces-566141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D5EA673BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5E219A42E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C8420C47C;
	Tue, 18 Mar 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRFgTD5b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B720B819
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300485; cv=none; b=szxdnaKpfeQSU+geovhwEWtIjALddFQ8vIADk2pPqib2AAypfzC+7rko2qgClKmOVmpd55itTvJ83MKnA4OI4lUieuD9oVirVYsAw76Cr58krNluz03RKqnc4iefrh/ZjOGVS98v6zSS8ZzljgokNRXIKG43knlrbfg4hb/tEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300485; c=relaxed/simple;
	bh=PEOho3mxJkzAPXe0fWAi/WRTM0HsCB29b4iFjxeQFas=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fQwa/DUjbTI/tFIvmXeSttM+3R4R4DBQsuxtYOuMZ4Cza54w1wJNs4qIp40jGiV6nM3dpKCzeEhBC9Pi4bupi5BGhgGbSn2ql+Dn5DzAKSYbmAIyo9xyp6smqWCQf8epSbsNKJkCU/AUuQpEFlxmInirW4hdcfFjnfTWYICDmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRFgTD5b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742300478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhhFr4l2vI9LJA1A6kjAKN0mfUZ99Bab74KjDm91CcE=;
	b=dRFgTD5b9V3V8TaNsnFdhEfm14xwyqTsoKVZ3ocJyPi19muSkP4TzNhN+h3fUUwntRnEV8
	JUXzJidSxmWVk//nreO4woU8Ry6dZT/eHmgzFl+XfX8Zp3LVMdjuj3OKlKdzXN9xE/jsdK
	XzESibGiPHWfeTPB1MSN3gAlXs2q4Qg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-HEABu_VROieY0cNFHiu00w-1; Tue, 18 Mar 2025 08:21:17 -0400
X-MC-Unique: HEABu_VROieY0cNFHiu00w-1
X-Mimecast-MFC-AGG-ID: HEABu_VROieY0cNFHiu00w_1742300476
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac27d8ac365so409477766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742300476; x=1742905276;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhhFr4l2vI9LJA1A6kjAKN0mfUZ99Bab74KjDm91CcE=;
        b=ZKs1vNyac3Q7zHxwQ2uEEZDV6QrKEK7tvNgRcVpMqHOnxJ6HgnTYB0KSDx2qQv6kOS
         DwU/GQ3y66jMG77FeDPvhKiduU4txq0EuSv+ChurX/zFbLcsQ+IkGjKZyhi2MhsnQ2IA
         xPf5cF4RQOkQeK33/2C4InCEQ7GW1LV6SpNg+BujJIswtAytHEuWOgWS1UKnhQM2ns5A
         hGClAx/fcAXjQ7RQWD3Z5Ws/iGhe+I4LtVNBzhMl0y8bDobTh1oECi4PXyVvZXSuji0m
         qDsWXGFdtVTdg+dFUn5TkZKLnUxEt8uaOubDu3OtZ5aHnlRJqPKiVdHbg7ahURdGTyTv
         jlHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt9d3jk+QH07pEF8C/44cEWDK1V3Kit7uSmrKvojpXT7HxcCVtwF3JE3Uug7c3EF5RxSFF79Er2dD16Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0JmjQjsq2ruD2R/KlH0W+84F6WAlnMRSs0Vum1aaLN8nGWM3
	xP2ujaXJsTMXaPRujWoFVCvHNp8zVtqYIZ1Cx7MxZUj8lFSn7QH0vzV8SuFec7CUAgDbqaiky1v
	h09ETdPRbNbMnerXR3dUhr7DV7C7iz/8zOEY3ce5/VAoEtqkQN58oCht6NrcZQg==
X-Gm-Gg: ASbGncvhBoyZUTonLshWZ8QJM0WQjSIuoo5re5In0Iqz0q44MNTffq81UaOph/+avbH
	Qm+G+z20sPS1bOQ2g6YDM9hNeIBlQ5m6qX4KrzSlJ6ENq/Hsz5Prxm9/EKEWIMl1qkw2slWFTiN
	0HRlpDe+h7I4B+7YTX9X5Vn63crlfLnnG1kOpVQMnwZQthELWcIQq9or/yanqi4WJXSaMPwE+SS
	EHKuZfqvSUBAWrVtdcWr+vu+fO8pE5IYYKhC8/vkHP5ZGm5DlYyacPdNZjDTATgJ4Wgaxczk+89
	WZwwJXNZtlZxbdgFkSzo9uvTiHKoM271ZQlJ1E1khmV2T94BA2KzI78caDhCoTww4Le0wh+cCjn
	gAQSCZy29QZxMHwy83H4qG8O5qCYdN9AXRV4DkrkkSq3PNE63SFA=
X-Received: by 2002:a17:907:1ca5:b0:ac3:47b1:d210 with SMTP id a640c23a62f3a-ac38d552aa7mr415062666b.39.1742300475757;
        Tue, 18 Mar 2025 05:21:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8b7vYW7kKObT+hlOwRJc2vA3dRrUIWytcgZqXUp/m1iOSxyN5NhZITY3nlGVypU4loUGSjQ==
X-Received: by 2002:a17:907:1ca5:b0:ac3:47b1:d210 with SMTP id a640c23a62f3a-ac38d552aa7mr415058366b.39.1742300475281;
        Tue, 18 Mar 2025 05:21:15 -0700 (PDT)
Received: from ?IPv6:2001:16b8:2d5b:6600:11f7:ef82:cebd:8734? (200116b82d5b660011f7ef82cebd8734.dip.versatel-1u1.de. [2001:16b8:2d5b:6600:11f7:ef82:cebd:8734])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a49825sm833427066b.160.2025.03.18.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:21:14 -0700 (PDT)
Message-ID: <0292a3331a61a77fb05d44ba6d298baaf8a7265a.camel@redhat.com>
Subject: Re: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Bjorn
 Helgaas <bhelgaas@google.com>, Alex Williamson
 <alex.williamson@redhat.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Date: Tue, 18 Mar 2025 13:21:13 +0100
In-Reply-To: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
References: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-07 at 16:03 +0200, Ilpo J=C3=A4rvinen wrote:
> __resource_resize_store() attempts to release all resources of the
> device before attempting the resize. The loop, however, only covers
> standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
> assigned, pci_reassign_bridge_resources() finds the bridge window
> still
> has some assigned child resources and returns -NOENT which makes
> pci_resize_resource() to detect an error and abort the resize.
>=20
> Change the release loop to cover all resources up to VF BARs which
> allows the resize operation to release the bridge windows and attempt
> to assigned them again with the different size.
>=20
> As __resource_resize_store() checks first that no driver is bound to
> the PCI device before resizing is allowed, SR-IOV cannot be enabled
> during resize so it is safe to release also the IOV resources.
>=20
> Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via
> sysfs")
> Reported-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>=20
> v2:
> - Removed language about expansion ROMs
>=20
> =C2=A0drivers/pci/pci-sysfs.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b46ce1a2c554..0c16751bab40 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1578,7 +1578,7 @@ static ssize_t __resource_resize_store(struct
> device *dev, int n,
> =C2=A0
> =C2=A0	pci_remove_resource_files(pdev);
> =C2=A0
> -	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> +	for (i =3D 0; i < PCI_BRIDGE_RESOURCES; i++) {

I, just recently, fixed a similar bug (assuming it is one in this
particular case here) [1].

I think it would be great if someone who has the knowledge could
improve the documentation in linux/pci.h where those constants are
defined.

PCI_STD_NUM_BARS is even defined in a different header, hinting at a
different background.


P.

[1] https://lore.kernel.org/all/20250312080634.13731-2-phasta@kernel.org/


> =C2=A0		if (pci_resource_len(pdev, i) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 pci_resource_flags(pdev, i) =3D=3D flags)
> =C2=A0			pci_release_resource(pdev, i);
>=20
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b


