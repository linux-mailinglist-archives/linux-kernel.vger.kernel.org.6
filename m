Return-Path: <linux-kernel+bounces-369901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F09A243B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB7282490
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746EA1DE3A6;
	Thu, 17 Oct 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1HBmuov"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25191DD548
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172971; cv=none; b=vBO0+XnoFmxeEal/oPu/CCvdi1b+6TO/NneLGVNjYtEqpATmp5Cy8rUfrxIwX3YZpby3jViraSFkwQf31bBiQjV+/aoces4Z80mcqaEZITYkF9+xzMkz4pv2m4xVBZwoPwhgxds+c6/efT8u68xPG+P4PeezqqB8Bn/TyGqJdJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172971; c=relaxed/simple;
	bh=UJqO2BFWnJpl6c4qm9egZxuBzIzCsmzQFDLnn4xO+aQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xt27namUxJJgFJlxiLCIPJ7mlicxAVc9P8UiDxZeqDvCmPL8sxn0Q/nQYwmxVylpAwfIYQusJRm0+jqZnBOUhVhBjV1pCRUXw77D1D4KohN1betgjuvg14ULJxpowKAxHuufQc/YuvdMd+7W/od46+Xj1JuMmCG+ezSm8Oi9mhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1HBmuov; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729172965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNf8lHsoPwrlsxVpfhmkSU98SQdpX5wGBJqf796QQlg=;
	b=i1HBmuov0DmeOem9OBE+66ZwIvnTu7NomcA26Az/55nq3rSGILhW6nxbQg6nGEACs6u7hm
	hwafQfyJlic8ME8u073vmJQK8H+IloHdWCijbcz/RdxsiquoHIjcmzB3/yQ7kWPtPEFyTh
	rTsL1NVGuYnQgatzhJw8OiAIG/7YsoU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-SK6UFHjvPIKtLLXaFeIbtA-1; Thu, 17 Oct 2024 09:49:24 -0400
X-MC-Unique: SK6UFHjvPIKtLLXaFeIbtA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315d98a873so3582125e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729172963; x=1729777763;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNf8lHsoPwrlsxVpfhmkSU98SQdpX5wGBJqf796QQlg=;
        b=w0MISqtjNaSzCd9xzi8uo1tZ8XZ7iZiZW2VwoVtcVk06bJRRQagiZAHpPYsBtZFZ8W
         oAkVBeAUBqIIWjpoEEnRa4ayXkCqjZ+nowjWBf+qv0P3L0S1c0nW5GJ4mOT3MgXUX9+0
         0ta5RBFr2gXLou/9b2JyapmZZtWZDRQkxn48mtyfi9WYE6vt3AUana/bbSYR3b2C0nI6
         G726wIneEvmamYKok+6fOWVKlMBdkdZGVVg50rJkaUCluRiq9iEunKnddO0guUwRPEvM
         5DniacSPzgaZoPyByABsO1Njiz0iApMXQndZH65rM/qR2jDBFKjPjagcSPvv6nsqrJ/3
         NkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWldOddUGjEmitqYLAy3d4kD4bQD7S4e98K65sRYrfnvxKo7GVelJPstWTHrQkEelImYjd4SDJZcKAG4+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZANkDUuh3p4HWlV/y1RRyx1OnePxGeueWh3lcfntbjncBf/en
	idrUgkNxAIkb9gfzNYkcBuuKyuNQ/kcjXE/H39w6VFsk7OTwTzsrB+b1iaej15qI/VSyeMf0dc0
	3AjgSqOAwryTpCNCbmvFrWAJ3G1XLF8r7KNpV3iwpn08rO54JZg2E5Eu5XT6kzTP3YVFd/sTr
X-Received: by 2002:a05:600c:3b94:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-43155afae76mr36850305e9.33.1729172963004;
        Thu, 17 Oct 2024 06:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE59ghlSm/r1F2zW+K6I0ImyWECFDbS8bjiEE3OExKnAO6buqdIFsvuMEjWIWmzxTwikE8TQ==
X-Received: by 2002:a05:600c:3b94:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-43155afae76mr36850125e9.33.1729172962615;
        Thu, 17 Oct 2024 06:49:22 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87ec5sm7322128f8f.37.2024.10.17.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:49:22 -0700 (PDT)
Message-ID: <23927f7a574bd4d683c07069e5cbccdff8ac14d9.camel@redhat.com>
Subject: Re: [PATCH v2 1/1] PCI: Improve printout in pdev_sort_resources()
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 17 Oct 2024 15:49:20 +0200
In-Reply-To: <20241017095545.1424-1-ilpo.jarvinen@linux.intel.com>
References: <20241017095545.1424-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 12:55 +0300, Ilpo J=C3=A4rvinen wrote:
> Use pci_resource_name() helper in pdev_sort_resources() to print
> resources in user-friendly format. Also replace the vague "bogus
> alignment" with a more precise explanation of the problem.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Philipp Stanner <pstanner@redhat.com>

> ---
>=20
> v2:
> - Place colon after %s %pR to be consistent with other printouts
> - Replace vague "bogus alignment" with the exact cause
>=20
> =C2=A0drivers/pci/setup-bus.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 23082bc0ca37..0fd286f79674 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct pci_dev
> *dev, struct list_head *head)
> =C2=A0	int i;
> =C2=A0
> =C2=A0	pci_dev_for_each_resource(dev, r, i) {
> +		const char *r_name =3D pci_resource_name(dev, i);
> =C2=A0		struct pci_dev_resource *dev_res, *tmp;
> =C2=A0		resource_size_t r_align;
> =C2=A0		struct list_head *n;
> @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct pci_dev
> *dev, struct list_head *head)
> =C2=A0
> =C2=A0		r_align =3D pci_resource_alignment(dev, r);
> =C2=A0		if (!r_align) {
> -			pci_warn(dev, "BAR %d: %pR has bogus
> alignment\n",
> -				 i, r);
> +			pci_warn(dev, "%s %pR: alignment must not be
> zero\n",
> +				 r_name, r);
> =C2=A0			continue;
> =C2=A0		}
> =C2=A0


