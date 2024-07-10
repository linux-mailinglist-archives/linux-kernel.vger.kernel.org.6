Return-Path: <linux-kernel+bounces-247319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2D792CDF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A2A1F23198
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFF518F2F7;
	Wed, 10 Jul 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3Q4sren"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C716F27A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602673; cv=none; b=ihWggZB62OG8Q+Ix5WjxbMLmn3odWwSxVBICSMIB2wveOUf5VtvEkTJW9qNMFjDKfrgmGmr3STx1aUnvrbjXXaP5jHdS0ZhheDgQra3sA7xSfz/lH4ubNTi8GUQu7IJuYjZ1M9dMlzuVUjTkyl6tuTyN0jY+bB+l+vD02ptUE/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602673; c=relaxed/simple;
	bh=sVcVGZKl2xwIdvcTfd9mefZDBHmsqt4J1Ded4unQblk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz+6X3gaeULzk7T634UFp8FZ0fWL52cfzqFXUCNFlnCwzI7Izl2dta1l1KewHNWKnzZxfKGjneVmhvyX08IcKuFe8vM6OQrl4LM+Y3O2JCeEz3g15zcXcpD0gUFUj8+mPGq849MnwgNcQvwvhFAi9rfQn8PdPs/dSoEHc8BJdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3Q4sren; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720602671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1cQDDUjmr5ak9+joDdULTaEfg0ceo+yAVZe0qbv7s9U=;
	b=d3Q4srenZ8pyavahp9KCEyPNfugmBkHaBXatSgukzfHpOhFcElY5kVV2gktHKd1gZikQyo
	G1nLM8IvrQbLUlyX8qwFKD3hrwnFTpET+Jkqvs/2BO29Hu3b7RE0PzJ1rnlKp/iL/siQQZ
	6q4vZ/Bd1sTxoF+tvv0Cp1s018RgRkk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-3TQvQujxNrSZVEy4zukMAQ-1; Wed, 10 Jul 2024 05:11:09 -0400
X-MC-Unique: 3TQvQujxNrSZVEy4zukMAQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58c4f94b57cso4673321a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720602668; x=1721207468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cQDDUjmr5ak9+joDdULTaEfg0ceo+yAVZe0qbv7s9U=;
        b=eSBIeyxsT3xIfUX0L2J68FSciwBU95i0F8hBE/9HvsHYdOzcT5s3+SBIrRw0bKJowK
         HFPwHiWyHqS/JsfrqZIEW9v88vybkrPAjR078I+A/V+1D4IwHZXyC6K4aDE+kHNX4Olg
         /LH8W+PanDlSPSPYIsFmK/rNrv2qFG6TVFJF+Vovkb4eA57IQ3KRBJ4ypq0Q4xc3VgQI
         nMYBjTlWk/eyWvpIbpdmd1fDaOQ4AhQfydFMkm/EiUXpSORdN1cjQkSZa5r99JeOP2Lk
         NedIHczumERGnInff1+DmKTN4dnFQ3Lih3UzFOjC+B2gSYT7FpvFzMTwQ8O/OxbQu7rD
         1rHg==
X-Forwarded-Encrypted: i=1; AJvYcCUk8EAWbJc2KrI+zFeu5eDHnRDrWbogASp/pS23DGC/RGXZIFMcIP2mjX5I3RCu80WDGqZh3JCx2eYa8AkbhztRJPKYqInFrdhYAC2k
X-Gm-Message-State: AOJu0YzcvAXTGOMhPGDAP0RN3dTOb4aF4c3xpb75Ln5BH+qmdmLJ4rK9
	wjjwD6M3kafKPQmJ7xArTM4VG8XFuQeuU6LnomhlAQIQQN7NOJHNJ8T3Auui6DdZgLgrvta8Rem
	q1sChz9mgtvJGwZww5h90UHuGmK0qOz7vz5pGiCo3szE69E30B9zPI+Sfr1qFgA==
X-Received: by 2002:a05:6402:2552:b0:58b:1df9:d3c1 with SMTP id 4fb4d7f45d1cf-594baf871aamr3923845a12.12.1720602668488;
        Wed, 10 Jul 2024 02:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMHjnifV3M27H8S9u+6/lvaJAWQKKtA/LzTGGDKIijdNacTcJVUCSPqn79d2thZJLRbSd3sQ==
X-Received: by 2002:a05:6402:2552:b0:58b:1df9:d3c1 with SMTP id 4fb4d7f45d1cf-594baf871aamr3923807a12.12.1720602667795;
        Wed, 10 Jul 2024 02:11:07 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bba548e8sm2009554a12.1.2024.07.10.02.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 02:11:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:11:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Wed, Jul 10, 2024 at 08:11:32AM GMT, Peng Fan wrote:
>> Subject: Re: [PATCH] test/vsock: add install target
>>
>> On Tue, Jul 09, 2024 at 09:50:51PM GMT, Peng Fan (OSS) wrote:
>> >From: Peng Fan <peng.fan@nxp.com>
>> >
>> >Add install target for vsock to make Yocto easy to install the images.
>> >
>> >Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> >---
>> > tools/testing/vsock/Makefile | 12 ++++++++++++
>> > 1 file changed, 12 insertions(+)
>> >
>> >diff --git a/tools/testing/vsock/Makefile
>> >b/tools/testing/vsock/Makefile index a7f56a09ca9f..5c8442fa9460
>> 100644
>> >--- a/tools/testing/vsock/Makefile
>> >+++ b/tools/testing/vsock/Makefile
>> >@@ -8,8 +8,20 @@ vsock_perf: vsock_perf.o
>> msg_zerocopy_common.o
>> > vsock_uring_test: LDLIBS = -luring
>> > vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o
>> >msg_zerocopy_common.o
>> >
>> >+VSOCK_INSTALL_PATH ?= $(abspath .)
>> >+# Avoid changing the rest of the logic here and lib.mk.
>> >+INSTALL_PATH := $(VSOCK_INSTALL_PATH)
>> >+
>> > CFLAGS += -g -O2 -Werror -Wall -I. -I../../include
>> > -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow
>> > -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -
>> D_GNU_SOURCE
>> > .PHONY: all test clean
>> > clean:
>> > 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf
>> vsock_uring_test
>> > -include *.d
>> >+
>> >+install: all
>> >+	@# Ask all targets to install their files
>> >+	mkdir -p $(INSTALL_PATH)/vsock
>>
>> why using the "vsock" subdir?
>>
>> IIUC you were inspired by selftests/Makefile, but it installs under
>> $(INSTALL_PATH)/kselftest/ the scripts used by the main one
>> `run_kselftest.sh`, which is installed in $(INSTALL_PATH instead.
>> So in this case I would install everything in $(INSTALL_PATH).
>>
>> WDYT?
>
>I agree.
>
>>
>> >+	install -m 744 vsock_test $(INSTALL_PATH)/vsock/
>> >+	install -m 744 vsock_perf $(INSTALL_PATH)/vsock/
>> >+	install -m 744 vsock_diag_test $(INSTALL_PATH)/vsock/
>> >+	install -m 744 vsock_uring_test $(INSTALL_PATH)/vsock/
>>
>> Also from selftests/Makefile, what about using the ifdef instead of
>> using $(abspath .) as default place?
>>
>> I mean this:
>>
>> install: all
>> ifdef INSTALL_PATH
>>    ...
>> else
>> 	$(error Error: set INSTALL_PATH to use install) endif
>
>Is the following looks good to you?
>
># Avoid conflict with INSTALL_PATH set by the main Makefile
>VSOCK_INSTALL_PATH ?=
>INSTALL_PATH := $(VSOCK_INSTALL_PATH)

I'm not a super Makefile expert, but why do we need both 
VSOCK_INSTALL_PATH and INSTALL_PATH?

Stefano

>
>install: all
>ifdef INSTALL_PATH
>        mkdir -p $(INSTALL_PATH)
>        install -m 744 vsock_test $(INSTALL_PATH)
>        install -m 744 vsock_perf $(INSTALL_PATH)
>        install -m 744 vsock_diag_test $(INSTALL_PATH)
>        install -m 744 vsock_uring_test $(INSTALL_PATH)
>else
>        $(error Error: set INSTALL_PATH to use install)
>Endif
>
>Thanks,
>Peng.
>>
>> Thanks,
>> Stefano
>


