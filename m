Return-Path: <linux-kernel+bounces-538926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1DEA49EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756241776A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84CA280A3C;
	Fri, 28 Feb 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfSu3/TJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EEB280A3A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760345; cv=none; b=j05f3qmiGS1k5TOuyIy33Lmzhha9g9ln71fL1R73tFbAPMzEPu2ST7z2whrUaKp2zthvLiotwb0vP+pfjfQk9oERxzRjWo4RDqwphfDJFVNi6ttY/QPifdt0cspeIVxhwVkjyn7Oat5St+lQf0nYQc8M0MRbWw2au3fSkEL/A0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760345; c=relaxed/simple;
	bh=xHfETFRXXqxzlXTdtZnDhJeu4Hb5RXkwxN6WWVEL74c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTJdmppIoM4NUTCqYjnwiufV/9S1CSM0/BS0t+CKvCEApTpsdJEF5qh2LC7LzdPbhYuyz0Hi+jhATtRtzcLJUJmHo4QdJwucFeIKv5WTWhsu6HUwwaVxhOJUTczEizgqLMtfsFFTBsAAw3Sk+YnGL7N7b8YyXPbNWrmBpoZ3IN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfSu3/TJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740760342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrqrOSYWZtD40E+osmzSBLGghD04Qb3lStl4xZJ4Yw4=;
	b=NfSu3/TJ7KWSoJINB0NRfqjle0xRnSjT5X+W22wnDBJqy9CUrNmvfN0cdzrQ0Hz4c420+X
	v0OXsUDJyHjhhyK0QAj0QM/m2FprZA3fFiIJM/AbM+jGA1VcDmn3pPevjCjDeX2+Kry42n
	Hlc0Mp/9y/JUpCSIG+x+aRBzyrqCy0s=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-9DS2Yqd2Nau0WMxjqZ1kMQ-1; Fri, 28 Feb 2025 11:32:20 -0500
X-MC-Unique: 9DS2Yqd2Nau0WMxjqZ1kMQ-1
X-Mimecast-MFC-AGG-ID: 9DS2Yqd2Nau0WMxjqZ1kMQ_1740760340
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-858755ba77cso33473839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760340; x=1741365140;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrqrOSYWZtD40E+osmzSBLGghD04Qb3lStl4xZJ4Yw4=;
        b=QLI3xkzaON82+CUdR/pUUDc1Pe76/wsi7Bs9RkXBtGCHjAPjauJ6ZqSK5qiNcGarTw
         u/6HRvJuoGsnSamkZUegao3S2dZ5adii9YjfkonaApQl/a8oCzrgV4XOxBAAXiDeccxU
         0iNtsYiUoIXC7DayNDFlcn/RphGGkp+cj+viF1pbba/0XiF8YFPxTdM6cj3NNfH6+rZl
         qeq5F0Nq2glRZweaXcd+yuGqjTfohahhtSCDDP8oYe1kvJ9V/5O4WAUK4qgbvcyXmazM
         D9HQN+7WT16p4vH370QDgR3oRGIm7ynQgCxgfu8BD7j3YnljPsWuhNjwdyEV6crz9iZw
         bm0A==
X-Forwarded-Encrypted: i=1; AJvYcCWO3ZMxHgPThzuul19MCrfQGQn9fzCJPL8xa3o1TziM7B+RomiXqliRlqUmCOnmn4DxtQkzELvjx7OOhkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGIeUAPkNzSVtp41lq0te5+E31qnPzVTL21o1JZ1y/07GvyUA
	XSMYsMmm6x0oUFEHn2RCORRxc2R6kPbSS9o1FmdiO8LrMXOc0n8tINERJnoOBQWY14xjycPGHkV
	km+NZmwQAtwDkJGCCpttvH5SubC5OYO7x2H+AfmNT+rnMdJrRf1i9RaC8cjwEJA==
X-Gm-Gg: ASbGncuUKXUAZqAT9/QBt3quziz8ux7Ekjq2xnfHw3klUQcHu1PbJfYnEGpF0X7P+EB
	sePLSGBIlgN1nW1nYNqwm0wGCVcTPezefYVbx0llanwRfu13y1YsVZ46JVUlDo0cQPjKelgzBhM
	n7Gmt6QXkh8KGAr+W+dmDWpGziG8WJ84FXoT1A8o6PISgE50UYpJQTWXl2A2XENPWNR2TyKZRYj
	ZXgfpyamIQvq412XbDgvye31vAoRpbFogwW87ngMtZtLKd4luHm8rFAPcaB5arAbWsMuzwHpJCu
	ecetV5XKrON5IgA5bic=
X-Received: by 2002:a05:6e02:8e:b0:3d3:dcd5:cde5 with SMTP id e9e14a558f8ab-3d3e6f65b5dmr11898975ab.4.1740760339809;
        Fri, 28 Feb 2025 08:32:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEQVWdAAouesIuSGFJu/QRRb8A3ncG+n0kWFoE0EBXjfN1U0L9ZvyqALnG5kZJ/4ZmPBGsmw==
X-Received: by 2002:a05:6e02:8e:b0:3d3:dcd5:cde5 with SMTP id e9e14a558f8ab-3d3e6f65b5dmr11898885ab.4.1740760339544;
        Fri, 28 Feb 2025 08:32:19 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c701dfsm964449173.60.2025.02.28.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:32:18 -0800 (PST)
Date: Fri, 28 Feb 2025 09:32:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vfio/pci: match IGD devices in display controller
 class
Message-ID: <20250228093215.2901dd7f.alex.williamson@redhat.com>
In-Reply-To: <20250123163416.7653-1-tomitamoeko@gmail.com>
References: <20250123163416.7653-1-tomitamoeko@gmail.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 00:34:15 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> IGD device can either expose as a VGA controller or display controller
> depending on whether it is configured as the primary display device in
> BIOS. In both cases, the OpRegion may be present. A new helper function
> vfio_pci_is_intel_display() is introduced to check if the device might
> be an IGD device.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---

Applied to vfio next branch for v6.15.  Thanks,

Alex


