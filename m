Return-Path: <linux-kernel+bounces-247157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC4F92CBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A76283579
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ABB83CD2;
	Wed, 10 Jul 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beDieEaB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC083CD4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596890; cv=none; b=An3amUUVSswgnr2XlwaXWKXZWrcUfWIDQF4Cxzz3OiSB0P3EVP/qOQDS2N11ObB64cPy/ec4rogDoivwFxsCB08cRHchgTWpkMup4FzLPO6yrgwm0Hvyt8P8GX2/yfFeFer6sbMUcTAWhOLVpWGcdgDAhPdZy07Hskl3wj6GnuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596890; c=relaxed/simple;
	bh=NfrfV5Vy+VM7vSghradxFkPpeufS31T/y1I2gyDTmrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sApEma2OBht1otqJfav2Av9zUMkBkL34Nd11080GkzYMR4QqIXFWvvT9LvmfNlak5rbzc4/nOso1PfQuXF5kpqwubHXoANZTtH4+p5mAq8suzfOBMmsSJfHyyHck7wci5xduIsa+VAdiGIFt5BSo/AJmg5vQ89gss0LQ8jIMRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=beDieEaB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720596888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D2M3DvwDrSJcyOfWVtdeker8I2MWaBFXWRzk+di5ddk=;
	b=beDieEaBv/YdrIB89j810lKKmwYRogEg1lI89E6pALUR9pSZol/hZgtnbR5kAE2Y5pKXpI
	lNsMU7WaUuKMiHYeKr2J1aiOruGrHe6TIsPPSlPXPz7s64yNVKY47d/nAPWWp3LGB1Nn5K
	9Ck5ns00cZnExT1X2LfpN0pEunDRSew=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-uspX4un9OHm5X3r5s-eZdA-1; Wed, 10 Jul 2024 03:34:46 -0400
X-MC-Unique: uspX4un9OHm5X3r5s-eZdA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6f571c3eefso359314166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720596885; x=1721201685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2M3DvwDrSJcyOfWVtdeker8I2MWaBFXWRzk+di5ddk=;
        b=Gft00fMjiz19dnhonoDjCvkv25zIhfvAvl20E83bNchB+OxBZ+gQJHzqZJ8WKRQclb
         QfNIvsKxNR9YtrJFgWANupuz5bwLvjuNYmLbPT+iXoVLAvR5pIr0YHzX3FSSIl9Q79dk
         LPqq6xPkYBJVaAgEao9yUzFw8gnD78bEuc12XM4V/NU70kZOcURxqNCNLmaEv9GHvD4Y
         27U1dNFG4Jk7Uyw+Pqr9dDg3Ix9OTz3VpuSlxzzROlVJtqfZXdUnGGa13GVGPoo6Pl87
         zGF61Utf+SPTd6E9bYcqxfJH+cp+UGTzYsRZ4AmlFhRe258rybwAGgjmyccldqqL8aea
         mGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYSIzzRi5Rg8i1/WT5iHn7rplxVMPKIK569jbPEGih9vetHoN+RZfYxOzswft3J/xfhO0KNqrC6DcEZpl7X1N5ZyMU7r5uGnxx2RnW
X-Gm-Message-State: AOJu0YzahVDZ2R84ItPcc1B/Bgr9AM4AB464XEGaVPbuajyDGGexBspd
	PtOG3/0hG6EPWU0dEIaXdB9OjitJp9tvdSwNQz28f0e11lAyVr0ywla8aqMytMKh5/Bqptz4cyk
	8Q5/hfGcV3YQr2vE8vSxkRrmpYfKUUAHrTS70qDwtHomYXkg/rMTBXqQPcVC1Qw==
X-Received: by 2002:a17:906:d925:b0:a77:c364:c4f2 with SMTP id a640c23a62f3a-a780b883457mr263385766b.52.1720596884835;
        Wed, 10 Jul 2024 00:34:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdCK3sPHoX5ymCLdtTzOFCG6cqJ6FCKNdOKjpgNsX4y+qO5d6Ij6ITF6psUTIa6WmxdNi7Pw==
X-Received: by 2002:a17:906:d925:b0:a77:c364:c4f2 with SMTP id a640c23a62f3a-a780b883457mr263384166b.52.1720596884237;
        Wed, 10 Jul 2024 00:34:44 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc520sm136516266b.51.2024.07.10.00.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:34:43 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:34:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240709135051.3152502-1-peng.fan@oss.nxp.com>

On Tue, Jul 09, 2024 at 09:50:51PM GMT, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>Add install target for vsock to make Yocto easy to install the images.
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
> tools/testing/vsock/Makefile | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index a7f56a09ca9f..5c8442fa9460 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -8,8 +8,20 @@ vsock_perf: vsock_perf.o msg_zerocopy_common.o
> vsock_uring_test: LDLIBS = -luring
> vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
>
>+VSOCK_INSTALL_PATH ?= $(abspath .)
>+# Avoid changing the rest of the logic here and lib.mk.
>+INSTALL_PATH := $(VSOCK_INSTALL_PATH)
>+
> CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
> .PHONY: all test clean
> clean:
> 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf vsock_uring_test
> -include *.d
>+
>+install: all
>+	@# Ask all targets to install their files
>+	mkdir -p $(INSTALL_PATH)/vsock

why using the "vsock" subdir?

IIUC you were inspired by selftests/Makefile, but it installs under 
$(INSTALL_PATH)/kselftest/ the scripts used by the main one 
`run_kselftest.sh`, which is installed in $(INSTALL_PATH instead.
So in this case I would install everything in $(INSTALL_PATH).

WDYT?

>+	install -m 744 vsock_test $(INSTALL_PATH)/vsock/
>+	install -m 744 vsock_perf $(INSTALL_PATH)/vsock/
>+	install -m 744 vsock_diag_test $(INSTALL_PATH)/vsock/
>+	install -m 744 vsock_uring_test $(INSTALL_PATH)/vsock/

Also from selftests/Makefile, what about using the ifdef instead of 
using $(abspath .) as default place?

I mean this:

install: all
ifdef INSTALL_PATH
   ...
else
	$(error Error: set INSTALL_PATH to use install)
endif

Thanks,
Stefano


