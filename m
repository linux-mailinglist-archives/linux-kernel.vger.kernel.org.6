Return-Path: <linux-kernel+bounces-536368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F16A47EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FC9176CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8422C321;
	Thu, 27 Feb 2025 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoBDCn5C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F088634
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662171; cv=none; b=Nztsxd7lRdsR2S14f9506SYp/ybO9q920b8EJK/vegtg3/VYbbgl7UpR8jm5360nET3fDG1mO52gfDj5GJeHg1BMpEFK7wbZm/UmWzRtWs04ilCv4Tr3lhKgKD4CRSQotEuB7dXwg66i1Plo9Y2mwwE5b0zGCJQy+FxbWX/FoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662171; c=relaxed/simple;
	bh=tvTKxcKgZCi/zq6R8nnzNqyfWj6Zv+XFO8+SjSH/2qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBud///I5roAI3yAVkR0bFkPybPP5Hd+1/l75zzpiHx6l/gwaRvSrIdQZPyJRr18yJbSAC7/UJB9F2EeBNcApSK1+VXiQYaEVJxFfgdqvo4UrHR7C2iBLJkbIipt97HM4MpCBXuVByK3i/RWlgbu+o9fBO1zt7m9GqqXLHR4P+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BoBDCn5C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740662168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xri/I+IO4rfkr0OA9xWmMHdYrgWkiifWK4QW+1livv0=;
	b=BoBDCn5CapMX4DW4lKYSms5WR8jSsxAZv8L411qeee/2O0L2ouIVxw9EeOHyC1jYvlLDP5
	EQk2LmTxpd+BXWNg0GxP2bAbzr/mG3Z18+k+0irZqLbAsdhnschgJwq2zLj8gmnuZN3Ay/
	itOb6XWJ4IhlbBWVn2p163EYoBTjSwQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-mt7sA8D9Ori1UPICy1lVHQ-1; Thu, 27 Feb 2025 08:16:06 -0500
X-MC-Unique: mt7sA8D9Ori1UPICy1lVHQ-1
X-Mimecast-MFC-AGG-ID: mt7sA8D9Ori1UPICy1lVHQ_1740662165
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390d5f1e05cso349258f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662165; x=1741266965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xri/I+IO4rfkr0OA9xWmMHdYrgWkiifWK4QW+1livv0=;
        b=vgo5rgaoF6ankPOpyyh9Zhq6LrC2R3We7KjnXFqqE/xi3wIu4oTVLcUhniTpCCyotk
         AbClpQonYWrJ/GBBCrHCaBofyuD/X400xamQ3nIesugoZE7kpX4UNe2rzJOWZXHBh3/l
         FS0WDluDEAqG/vVwmZL5ca0aDIPQ9Ga8kj8gHdcmtGEd85KKelbtfmSWgyg7E4U9DwOR
         cX2RRElFQGidbmKxK8HrzdLyaVBDzfG2F2PjxKtOAmKdy8ju072b7IyhBBHBOeMFnK4K
         AOcuzqtNVG6GfzmGnAo0XAVJ8sde4Dot4fuBF4+z/aMlsnyLcIcG62ITaYMRA5t0Xw/7
         RcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoB9U7x/sqbd24n9tXzkcX5KcUQp/prNpJGmUALEiCtA5syUMFiOkpdPUjJFujJepI6LW/XkcFrDBrKsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4EWNNKdc8RfcIelAIxu5Bfu80+46+NUbtZZ53yKmYM0ZSmcY7
	Wi+Pnn2SzUP0vh0wtjBESPE1MST20QCcpdP8ljDYkLEcpjicKnTSdQiOAK3nLTZpjsCURajiojC
	yJUIf9D6mDyGCDfMJU2pqTqZyuR+JVLhYcRx6cYTpDjnyPUhPuMmy8CGzhQNytA==
X-Gm-Gg: ASbGncsCa5KBvC5aNJqpNZP/5UiP1AhX9j5g9RNwIa3UZv/b45ybE4L9UEJJdMWaJg6
	hmJLWyah/kM82aN0/WrqbpYafe/ajaZRnrvSgHa0N8NcTuLa9m9/VigwAUk97U3i7bMFJY8j+wD
	A3nR5oXGkgfPfFJsF7OLen4KKbqu3qP6krLy7zNWR/R97G66BzwTfgFhsJYBBd1fiwbtDfdHrhn
	9v694k4D4UVSpEVihsQfA03dN2+U9CyTOmGIOG25yhJ1RMl2NRmAoFmhkDsd2/IaBTC7WiUx0VM
	gyMEKU+TkfJcL4VFOH0HQhGi1AaSrzrXwU/ecXrQtV5ZmDGP5yFEQ1Y7RVc7jwY=
X-Received: by 2002:a5d:588b:0:b0:38c:5dcb:312e with SMTP id ffacd0b85a97d-390cc3aff06mr9907658f8f.0.1740662165419;
        Thu, 27 Feb 2025 05:16:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkykoQF+oum41Q36ikGuOScAYAfjAbiM9vItgaXjqABwL6KRcMEP1IdsaWiIto2nIlpgYtfQ==
X-Received: by 2002:a5d:588b:0:b0:38c:5dcb:312e with SMTP id ffacd0b85a97d-390cc3aff06mr9907637f8f.0.1740662165071;
        Thu, 27 Feb 2025 05:16:05 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7b88sm2026731f8f.40.2025.02.27.05.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:16:04 -0800 (PST)
Date: Thu, 27 Feb 2025 14:16:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/21] tests/acpi: virt: update HEST table to accept
 two sources
Message-ID: <20250227141603.3957e78b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250227141038.28501d73@imammedo.users.ipa.redhat.com>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<9d57e2a6ec3f523eb7691347403f05ad40782b94.1740653898.git.mchehab+huawei@kernel.org>
	<20250227141038.28501d73@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 14:10:38 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 27 Feb 2025 12:03:47 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> squash this patch into the next one
> 
> Also at this point there is no visible HEST changes yet, so a soon as you remove
> white-list without enabling new HEST, the tests should start failing.
> 
> I suggest to move 20/21 before this patch,
> as result one would see dsdt and hest diffs when running tests
> and then you can use rebuild-expected-aml.sh to generate updated
> tables and update them in one patch (that's what we typically do,
> we don't split updates in increments).

on top of that,
it seems the patch doesn't apply for some reason.

> 
> 
> > --- /tmp/asl-38PE22.dsl	2025-02-26 16:25:32.362148388 +0100
> > +++ /tmp/asl-HSPE22.dsl	2025-02-26 16:25:32.361148402 +0100
> > @@ -1,39 +1,39 @@
> >  /*
> >   * Intel ACPI Component Architecture
> >   * AML/ASL+ Disassembler version 20240322 (64-bit version)
> >   * Copyright (c) 2000 - 2023 Intel Corporation
> >   *
> > - * Disassembly of tests/data/acpi/aarch64/virt/HEST
> > + * Disassembly of /tmp/aml-DMPE22
> >   *
> >   * ACPI Data Table [HEST]
> >   *
> >   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
> >   */
> > 
> >  [000h 0000 004h]                   Signature : "HEST"    [Hardware Error Source Table]
> > -[004h 0004 004h]                Table Length : 00000084
> > +[004h 0004 004h]                Table Length : 000000E0
> >  [008h 0008 001h]                    Revision : 01
> > -[009h 0009 001h]                    Checksum : E2
> > +[009h 0009 001h]                    Checksum : 6C
> >  [00Ah 0010 006h]                      Oem ID : "BOCHS "
> >  [010h 0016 008h]                Oem Table ID : "BXPC    "
> >  [018h 0024 004h]                Oem Revision : 00000001
> >  [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
> >  [020h 0032 004h]       Asl Compiler Revision : 00000001
> > 
> > -[024h 0036 004h]          Error Source Count : 00000001
> > +[024h 0036 004h]          Error Source Count : 00000002
> > 
> >  [028h 0040 002h]               Subtable Type : 000A [Generic Hardware Error Source V2]
> >  [02Ah 0042 002h]                   Source Id : 0000
> >  [02Ch 0044 002h]           Related Source Id : FFFF
> >  [02Eh 0046 001h]                    Reserved : 00
> >  [02Fh 0047 001h]                     Enabled : 01
> >  [030h 0048 004h]      Records To Preallocate : 00000001
> >  [034h 0052 004h]     Max Sections Per Record : 00000001
> >  [038h 0056 004h]         Max Raw Data Length : 00000400
> > 
> >  [03Ch 0060 00Ch]        Error Status Address : [Generic Address Structure]
> >  [03Ch 0060 001h]                    Space ID : 00 [SystemMemory]
> >  [03Dh 0061 001h]                   Bit Width : 40
> >  [03Eh 0062 001h]                  Bit Offset : 00
> >  [03Fh 0063 001h]        Encoded Access Width : 04 [QWord Access:64]
> >  [040h 0064 008h]                     Address : 0000000043DA0000
> > @@ -42,32 +42,75 @@
> >  [048h 0072 001h]                 Notify Type : 08 [SEA]
> >  [049h 0073 001h]               Notify Length : 1C
> >  [04Ah 0074 002h]  Configuration Write Enable : 0000
> >  [04Ch 0076 004h]                PollInterval : 00000000
> >  [050h 0080 004h]                      Vector : 00000000
> >  [054h 0084 004h]     Polling Threshold Value : 00000000
> >  [058h 0088 004h]    Polling Threshold Window : 00000000
> >  [05Ch 0092 004h]       Error Threshold Value : 00000000
> >  [060h 0096 004h]      Error Threshold Window : 00000000
> > 
> >  [064h 0100 004h]   Error Status Block Length : 00000400
> >  [068h 0104 00Ch]           Read Ack Register : [Generic Address Structure]
> >  [068h 0104 001h]                    Space ID : 00 [SystemMemory]
> >  [069h 0105 001h]                   Bit Width : 40
> >  [06Ah 0106 001h]                  Bit Offset : 00
> >  [06Bh 0107 001h]        Encoded Access Width : 04 [QWord Access:64]
> > -[06Ch 0108 008h]                     Address : 0000000043DA0008
> > +[06Ch 0108 008h]                     Address : 0000000043DA0010
> > 
> >  [074h 0116 008h]           Read Ack Preserve : FFFFFFFFFFFFFFFE
> >  [07Ch 0124 008h]              Read Ack Write : 0000000000000001
> > 
> > -Raw Table Data: Length 132 (0x84)
> > +[084h 0132 002h]               Subtable Type : 000A [Generic Hardware Error Source V2]
> > +[086h 0134 002h]                   Source Id : 0001
> > +[088h 0136 002h]           Related Source Id : FFFF
> > +[08Ah 0138 001h]                    Reserved : 00
> > +[08Bh 0139 001h]                     Enabled : 01
> > +[08Ch 0140 004h]      Records To Preallocate : 00000001
> > +[090h 0144 004h]     Max Sections Per Record : 00000001
> > +[094h 0148 004h]         Max Raw Data Length : 00000400
> > +
> > +[098h 0152 00Ch]        Error Status Address : [Generic Address Structure]
> > +[098h 0152 001h]                    Space ID : 00 [SystemMemory]
> > +[099h 0153 001h]                   Bit Width : 40
> > +[09Ah 0154 001h]                  Bit Offset : 00
> > +[09Bh 0155 001h]        Encoded Access Width : 04 [QWord Access:64]
> > +[09Ch 0156 008h]                     Address : 0000000043DA0008
> > +
> > +[0A4h 0164 01Ch]                      Notify : [Hardware Error Notification Structure]
> > +[0A4h 0164 001h]                 Notify Type : 07 [GPIO]
> > +[0A5h 0165 001h]               Notify Length : 1C
> > +[0A6h 0166 002h]  Configuration Write Enable : 0000
> > +[0A8h 0168 004h]                PollInterval : 00000000
> > +[0ACh 0172 004h]                      Vector : 00000000
> > +[0B0h 0176 004h]     Polling Threshold Value : 00000000
> > +[0B4h 0180 004h]    Polling Threshold Window : 00000000
> > +[0B8h 0184 004h]       Error Threshold Value : 00000000
> > +[0BCh 0188 004h]      Error Threshold Window : 00000000
> > +
> > +[0C0h 0192 004h]   Error Status Block Length : 00000400
> > +[0C4h 0196 00Ch]           Read Ack Register : [Generic Address Structure]
> > +[0C4h 0196 001h]                    Space ID : 00 [SystemMemory]
> > +[0C5h 0197 001h]                   Bit Width : 40
> > +[0C6h 0198 001h]                  Bit Offset : 00
> > +[0C7h 0199 001h]        Encoded Access Width : 04 [QWord Access:64]
> > +[0C8h 0200 008h]                     Address : 0000000043DA0018
> > 
> > -    0000: 48 45 53 54 84 00 00 00 01 E2 42 4F 43 48 53 20  // HEST......BOCHS
> > +[0D0h 0208 008h]           Read Ack Preserve : FFFFFFFFFFFFFFFE
> > +[0D8h 0216 008h]              Read Ack Write : 0000000000000001
> > +
> > +Raw Table Data: Length 224 (0xE0)
> > +
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  tests/data/acpi/aarch64/virt/HEST | Bin 132 -> 224 bytes
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> > 
> > diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
> > index 4c5d8c5b5da5b3241f93cd0839e94272bf6b1486..674272922db7d48f7821aa7c83ec76bb3b556d2a 100644
> > GIT binary patch
> > delta 68
> > zcmZo+e89-%;TjzBfPsO5F=rx|6eH6_Rd+^#iMisuTnvm1|Nk>EGJ@nLCJHmL%S;Ru
> > WnV7)J#lXPAz`)?Zz#=g*R~!HcF%5eF
> > 
> > delta 29
> > lcmaFB*uu!=;Tjy$!oa}5_-G=R6eHtARriT=I3|_|004Ge2nqlI
> >   
> 


