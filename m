Return-Path: <linux-kernel+bounces-250393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38A392F74B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CAB1C22502
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484B14E2CC;
	Fri, 12 Jul 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IENHo2gb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639BE14A4C8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774430; cv=none; b=hcIXzzpqbgTW0Z7qtlGY1/pWQ+tukgCs12KHhKbRdxSiw/lbxLPoBpD2U/kPC+18z0sMJy/YEXNFk0UGWL9XqqHXkWxUIO/l1EEr6OAaS6EZFp38YPUU3dUR6QhV+6zb5xNgVu5myTGPCsITgtxZaX7myHDJIOpCfco5u/eZxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774430; c=relaxed/simple;
	bh=7ii2cMWIXSW9Zvft7iHYSxGbuGdBlukrB4DhkMPVLDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrN+uASZjvNBDV+CW0QhvhVZS4uz5K+IrDQ0KqHr4VgWAiR5tdU0gxhThcizmcKLzALwsV744kHv/Eoup8VY1hrORan2Gu6gYdJuKgnrpuq4lV3BtIeOOcp9AkEdvEx5hI5mZKydmTFXBy2JQV3rvyIVU+dnfdvIdBoYp8DM5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IENHo2gb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720774427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6eZohFqmRNYBDXGIYv2tB15qLRHJ4lN578ZEp/GlC8=;
	b=IENHo2gb7PRqfogW90yrZaZYLRvNzBYFVZVMzO06/s6R3A0JP5mRWtMIq/yBGRfwQMmFmc
	OD7S2RabvPhDGk8cOzJXVxXInZRU+8baAtmBb1quL3cUnhRX6zlRBsbfPk0LmJMXBBiAJI
	XXEm4SQ6cUHDRggc3M/kwYiEXSmtvsg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-PP8-ioZuMq6RC2QYvheG2g-1; Fri, 12 Jul 2024 04:53:45 -0400
X-MC-Unique: PP8-ioZuMq6RC2QYvheG2g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77f0eca75bso173029666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 01:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720774424; x=1721379224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6eZohFqmRNYBDXGIYv2tB15qLRHJ4lN578ZEp/GlC8=;
        b=pTwJKrUUST9pXm5x6WOy0iFaDmX+VchIrSCN0RXv/sNhxIYOVOR2U9rnSe2q44KXH1
         caqEuUUn6vXTyA547D6zqCIUtjzX/FvcJoqoPt/4R9mA0jhDvwDb7jzgQB8XHJucuGHK
         6dr4zZGocQlus/eEOpRPrFaGMyOWgZSeY6XrsU+ipNwFpaE+TCOdVNV2d+ZPzpYHfhR2
         USf8SjF+ElMQbGP6URnVkErQAMas/iSgj4s0wlcZF/bJaI2ANkbQpdsdqA2oy2bEAbmH
         kgLNJ3hLa8EjEQor77mRObD1uvRQBZS+B9vJXQCU8iCgN63x3z7w9tBBscE7FxZ9ySCa
         p9Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVGgoA+PIWZFb73lS/fQ939MvRPusOLqS6W4DDQoVBnZg/ZogDTTg8JeubjCe0vi6gSAPEyR9ck6xzeCjJkW0TJm4qWucTza/bCwgP3
X-Gm-Message-State: AOJu0YwQsW4InrN+QyBaJ7soq2r+/vFMLC34tg5ST1gU3DvHEtJTHagR
	qnl3xEj0N7LhwWIR08XaQCEXFzrwbFYzbbZcmbhfLZCM1KLcJf3yZyjv44hCA1wXIxeswy/LUxh
	YwkwtUrRMGWuqUr1CgpkHJyczQXcjYzpG73yDNko05r7SJCHOkNL0gF2g7QIHqw==
X-Received: by 2002:a17:907:3f1c:b0:a79:8149:967a with SMTP id a640c23a62f3a-a7981499859mr589657266b.16.1720774424711;
        Fri, 12 Jul 2024 01:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpV63wxZL+4AWmv5IQrzSy5U9zbXvyslQuXagjzNSHgkYzRL5RG5InQqljmrd5V56lJG4Yxg==
X-Received: by 2002:a17:907:3f1c:b0:a79:8149:967a with SMTP id a640c23a62f3a-a7981499859mr589655066b.16.1720774424085;
        Fri, 12 Jul 2024 01:53:44 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc721sm322652666b.53.2024.07.12.01.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:53:43 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:53:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peng Fan <peng.fan@nxp.com>, 
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <3cx46c62lttslofdaneqqmsrcffeeblgy3d7eumuwx6x72xqtm@uux54tnn5fe7>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
 <PAXPR04MB845955C754284163737BECE788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <whgbeixcinqi2dmcfxxy4h7xfzjjx3kpsqsmjiffkkaijlxh6i@ozhumbrjse3c>
 <20240710190059.06f01a4c@kernel.org>
 <hxsdbdaywybncq5tdusx2zosfnhzxmu3zvlus7s722whwf4wei@amci3g47la7x>
 <20240711133801.GA18681@fedora.redhat.com>
 <20240711071455.5abfaae9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240711071455.5abfaae9@kernel.org>

On Thu, Jul 11, 2024 at 07:14:55AM GMT, Jakub Kicinski wrote:
>On Thu, 11 Jul 2024 15:38:01 +0200 Stefan Hajnoczi wrote:
>> > Usually vsock tests test both the driver (virtio-vsock) in the guest and the
>> > device in the host kernel (vhost-vsock). So I usually run the tests in 2
>> > nested VMs to test the latest changes for both the guest and the host.
>> >
>> > I don't know enough selftests, but do you think it is possible to integrate
>> > them?
>> >
>> > CCing Stefan who is the original author and may remember more reasons about
>> > this choice.
>>
>> It's probably because of the manual steps in tools/testing/vsock/README:
>>
>>   The following prerequisite steps are not automated and must be performed prior
>>   to running tests:
>>
>>   1. Build the kernel, make headers_install, and build these tests.
>>   2. Install the kernel and tests on the host.
>>   3. Install the kernel and tests inside the guest.
>>   4. Boot the guest and ensure that the AF_VSOCK transport is enabled.
>>
>> If you want to automate this for QEMU, VMware, and Hyper-V that would be
>> great. It relies on having a guest running under these hypervisors and
>> that's not trivial to automate (plus it involves proprietary software
>> for VMware and Hyper-V that may not be available without additional
>> license agreements and/or payment).
>
>Not sure if there's a requirement that full process is automated.
>Or at least if there is we are already breaking it in networking
>because for some tests we need user to export some env variables
>to point the test to the right interfaces and even a remote machine
>to generate traffic. If the env isn't set up tests return 4 (SKIP).
>I don't feel strongly that ksft + env approach is better but at
>least it gives us easy access to the basic build and packaging
>features from ksft. Up to you but thought I'd ask.
>

Yeah, I'll try to allocate some cycles to look into that. Tracking it 
here: https://gitlab.com/vsock/vsock/-/issues/13

What about this patch, can we queue it for now?

Thanks,
Stefano


